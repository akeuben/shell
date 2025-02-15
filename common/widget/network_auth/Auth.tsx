import { App, Astal, Gdk, Gtk } from "astal/gtk3"
import Variable from "astal/variable";

let req = new Variable("");
let res = (response: string) => {};

export const updateNetworkAuthRequest = (reqt: string) => {
    req.set(reqt);
}

export const updateNetworkAuthResponse = (resp: (response: string) => void) => {
    res = resp;
}

export const NetworkAuthenticationWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    const password = new Variable("");

    const ret = () => {
        res(password.get());
        password.set("");
        App.get_window(`network-auth-${App.get_monitors().indexOf(monitor)}`)?.set_visible(false);
    }

    return <box vexpand={false} hexpand={true} valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} orientation={Gtk.Orientation.VERTICAL}>
        <label label={req(ssid => `The network ${ssid} requires authentication`)} />
        <entry can_focus={true} focus_on_click={true} editable={true} placeholder_text="Password" text={password()} onChanged={entry => password.set(entry.text)} onKeyReleaseEvent={(s,e) => {
            const [keyEvent, keyCode] = e.get_keycode();
            if(keyEvent && [104, 36].includes(keyCode)) {
                ret();
            }
        }}/>
        <button onClickRelease={ret}>
            <label label="submit" />
        </button>
    </box>
}
