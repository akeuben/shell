import { App, Gtk } from "astal/gtk3";
import { exec } from "astal/process";
import {readFile} from "astal/file";
import AstalGreet from "gi://AstalGreet?version=0.1";
import { Variable } from "astal";
import { Button } from "astal/gtk3/widget";
import AstalHyprland from "gi://AstalHyprland?version=0.1";

const get_greeting = () => {
    const hourOfDay = new Date().getHours();
    let time = "";
    if(hourOfDay < 3) {
        time = "Night";
    } else if(hourOfDay < 12) {
        time = "Morning";
    } else if(hourOfDay < 18) {
        time = "Afternoon"
    } else if(hourOfDay < 21) {
        time = "Evening";
    } else {
        time = "Night";
    }

    return `Good ${time}!`;
}

const get_user_list = () => {
    const passwd = exec("cat /etc/passwd");
    return passwd.split("\n")
        .filter(entry => !entry.includes("nologin"))
        .map(entry => entry.split(":")[0])
        .filter(entry => entry !== "root");
}

type DesktopEntry = {
    name: string,
    exec: string,
} | undefined;

const parseSession = (desktopFile: string) => {
    const contents = readFile(desktopFile);
    const lines = contents.split("\n");

    let name: string | null = null;
    let exec: string | null = null;

    for(const line of lines) {
        if(line.startsWith("Name")) {
            name = line.split("=")[1]
        } else if(line.startsWith("Exec")) {
            exec = line.split("=")[1];
        }
    }

    if(!name || !exec) return undefined;

    return {
        name: name,
        exec: exec,
    };
}

export const LoginWidget = () => {
    const password = new Variable("");
    let sessions: DesktopEntry[] = [];

    if(ARGV.includes("--sessions")) {
        sessions = ARGV[ARGV.indexOf("--sessions") + 1]
            .split(":")
            .map(directory => exec(`ls ${directory}`)
                 .split("\n")
                 .filter(file => !file.includes("systemd"))
                 .map(file => `${directory}/${file}`))
            .flat()
            .map(parseSession)
            .filter(a => a !== undefined);
    }
    sessions.push({
        name: "Shell",
        exec: "fish",
    });

    const user_combo_box = Gtk.ComboBoxText.new_with_entry();
    const users = get_user_list();
    users.forEach(user => {
        user_combo_box.append(user, user);
    })
    user_combo_box.set_active_id(users[0]);
    user_combo_box.show_all();

    const session_combo_box = Gtk.ComboBoxText.new();
    sessions.forEach((session, i) => {
        session_combo_box.append(`${i}`, session?.name as string);
    })
    session_combo_box.show_all();
    session_combo_box.set_active_id(`0`);

    const error_message = Gtk.Label.new(null);
    error_message.wrap = true;
    error_message.wrap_mode = Gtk.WrapMode.WORD;

    console.log(sessions);


    const login = () => {
        AstalGreet.login(user_combo_box.get_active_text(), 
            password.get(), 
            sessions[parseInt(session_combo_box.get_active_id() as string)]?.exec as string,
            (a, res, data) => {
                console.log(data)
                console.log(res instanceof AstalGreet.Response);
                console.log(Object.keys(res));
                try {
                    AstalGreet.login_finish(res);
                    setTimeout(() => {
                        App.quit();
                        AstalHyprland.get_default().dispatch("dispatch", "exit");
                    }, 500);
                    console.log("login success!");
                } catch(error) {
                    error_message.set_text(JSON.stringify(error));
                    error_message.show_all();
                    console.log("Error while logging in: " + JSON.stringify(error) + "\n" + a);
                }
            }
        )
    }

    const login_btn = new Button({label: "Login", onClick: login});

    return <box className="login-dialog" orientation={Gtk.Orientation.VERTICAL} spacing={20}>
        <label label="Login" className="title" />
        {user_combo_box}
        <entry can_focus={true} focus_on_click={true} editable={true} placeholder_text="Password" visibility={false} text={password()} onChanged={entry => password.set(entry.text)} onKeyReleaseEvent={(s,e) => {
            const [keyEvent, keyCode] = e.get_keycode();
            if(keyEvent && [104, 36].includes(keyCode)) {
                login();
            }
        }} onRealize={(self) => {
            self.grab_focus();
        }}/>
        {login_btn}
        {error_message}
        {session_combo_box}
    </box>
}
