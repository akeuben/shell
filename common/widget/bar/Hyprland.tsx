import Hyprland from "gi://AstalHyprland";
import Apps from "gi://AstalApps";
import { bind } from "astal/binding";
import { App, Gdk, Gtk } from "astal/gtk3";
import { exec } from "astal/process";
import { mergeBindings } from "astal/gtk3/astalify";
import Variable from "astal/variable";

const ICON_CACHE: Record<number, string> = {};

export const WorkspacesWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    const hyprland = Hyprland.get_default();
    const workspaces = bind(hyprland, "workspaces");
    
    return <box hexpand={false} className="bar-section widget-workspace">
        {workspaces.as(workspaces => workspaces.sort((a, b) => a.id - b.id).map(w => WorkspaceIndicator(w, monitor)))}
    </box>
}

const WorkspaceIndicator = (workspace: Hyprland.Workspace, monitor: Gdk.Monitor) => {
    const hyprland = Hyprland.get_default();
    const hyprMonitor = hyprland.get_monitor(App.get_monitors().indexOf(monitor));
    const focused = bind(hyprMonitor, "active_workspace");

    const getIndicatorClass = (focused: Hyprland.Workspace) => {
        if(focused.id === workspace.id) {
            return "focused";
        }
        return "";
    }
    return <button className={focused.as(c => `widget-workspace-indicator ${getIndicatorClass(c)}`)}
        margin={3} 
        vexpand={false} 
        cursor={focused.as(c => c.id === workspace.id ? "default" : "pointer")}
        onClickRelease={() => {
            workspace.move_to(hyprMonitor);
            workspace.focus();
        }}
        valign={Gtk.Align.CENTER}
    />
}

const get_executable = (c: Hyprland.Client) => {
    const pid = c.pid;
    let executable_name = exec(`cat /proc/${pid}/cmdline`);

    if(executable_name.includes("/nix/store")) {
        executable_name = executable_name.substring(executable_name.lastIndexOf("/nix/store/"));
        const parts = executable_name.split("-");
        return parts[1];
    }

    const parts = executable_name.split("/");
    return parts[parts.length - 1];
}

const get_icon = (c: Hyprland.Client) => {
    if(!c) return "unknown";
    if(ICON_CACHE[c.pid]) {
        return ICON_CACHE[c.pid];
    }

    const apps = new Apps.Apps({
        executableMultiplier: 1000,
    });
    const executable_name = get_executable(c);
    const applications = apps.fuzzy_query(executable_name);

    if(applications.length === 0) return "unknown";

    ICON_CACHE[c.pid] = applications[0].icon_name;

    return applications[0].icon_name;
}

const format_title = (title: string) => {
    if(title.length > 35) {
        return title.substring(0, 35) + "...";
    }

    return title;
}

export const ActiveClientWidget = () => {
    const hyprland = Hyprland.get_default();
    const focused_client = bind(hyprland, "focused_client");
    const clients = bind(hyprland, "clients");

    return <>
        {focused_client.as(client => client ? <box spacing={10}
            className={clients.as(cls => `bar-section-part first ${cls.length === 1 ? "last" : ""}`)}>
            <icon icon={get_icon(client)} />
            <label label={bind(client, "title").as(format_title)} />
            <button cursor="pointer" onClickRelease={() => focused_client.get().kill()}></button>
        </box> : <></>)}
    </>;
}

export const NonActiveClientsWidget = () => {
    const hyprland = Hyprland.get_default();
    const focused_client = bind(hyprland, "focused_client");
    const clients = bind(hyprland, "clients");

    const non_focused_clients = Variable.derive([focused_client, clients], (focused: Hyprland.Client, all: Hyprland.Client[]) => {
        if(!focused) return all;
        return all.filter(c => c !== focused).splice(0, 7);
    })

    return <>
        {non_focused_clients(list => list.map((c, i) => <button className={focused_client.as(fc => `bar-section-part ${!fc && i === 0 ? "first" : ""} ${i === list.length - 1 ? "last" : ""}`)} cursor="pointer" onClick={() => c.focus()}>
            <icon icon={get_icon(c)} hexpand={true} /> 
        </button>))}
    </>;
}

export const ClientsWidget = () => {
    return <box spacing={3}>
        <ActiveClientWidget />
        <NonActiveClientsWidget />
    </box>
}
