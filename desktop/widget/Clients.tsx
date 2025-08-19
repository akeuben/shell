import { Astal, Gdk, Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { Accessor, createBinding, createComputed, For, With } from "gnim";

const hyprland = AstalHyprland.get_default();

const fixup_icons = (initial_class: string): string => {
    if(initial_class === "zen") return "zen-browser";
    if(initial_class.toLowerCase().includes("minecraft")) return "minecraft";

    return initial_class;
}

export const ClientWidget = ({client, workspace}: {client: AstalHyprland.Client, workspace: Accessor<AstalHyprland.Workspace>}) => {
    const clientWorkspace = createBinding(client, "workspace");
    const focusedClient = createBinding(hyprland, "focused_client");
    
    const isOnCorrectWorkspace = createComputed([clientWorkspace, workspace, focusedClient], (clientWorkspace, workspace, focusedClient) => clientWorkspace.name === workspace.name && focusedClient.pid !== client.pid);
    
    return <Astal.Bin> 
        <With value={isOnCorrectWorkspace}>
            {isOnCorrectWorkspace => <Astal.Bin>
                {isOnCorrectWorkspace ? <button class="client" cursor={Gdk.Cursor.new_from_name("pointer", null)}>
                    <Gtk.GestureClick
                        button={Gdk.BUTTON_PRIMARY}
                        onPressed={() => client.focus()}
                      />
                    <image icon_name={fixup_icons(client.initial_class)} pixel_size={24} />
                </button> : <></>}
            </Astal.Bin>}
        </With>
    </Astal.Bin>
}

export const ClientList = ({gdkmonitor}: {gdkmonitor: Gdk.Monitor}) => {
    const monitor = hyprland.monitors.find(m => m.name === gdkmonitor.connector) as AstalHyprland.Monitor;
    const workspace = createBinding(monitor, "active_workspace");
    const clients = createBinding(hyprland, "clients");

    return <box halign={Gtk.Align.CENTER} orientation={Gtk.Orientation.VERTICAL}> 
        <For each={clients}>
            {(client: AstalHyprland.Client) =>  <ClientWidget client={client} workspace={workspace} />
            }
        </For>
    </box>
}

export const ActiveClient = ({gdkmonitor}: {gdkmonitor: Gdk.Monitor}) => {
    const monitor = hyprland.monitors.find(m => m.name === gdkmonitor.connector) as AstalHyprland.Monitor;
    const monitor_focused = createBinding(monitor, "focused");
    const activeClient = createBinding(hyprland, "focused_client");
    const activeWorkspace = createBinding(monitor, "active_workspace");
    const visible = createComputed([activeClient, activeWorkspace, monitor_focused], (c, w, m) => c.workspace.name === w.name && m);
    return <box halign={Gtk.Align.CENTER} hexpand={false}>
        <With value={visible}>
            {visible => visible && <box orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                <image icon_name={activeClient.as(client => fixup_icons(client.initial_class))} pixel_size={24} />
                <label label={activeClient.as(c => c.title)} css="transform: rotate(90deg)" $={self => {
                    self.vfunc_measure = (a, b) => {
                        const [x, y, w, h] = self.vfunc_measure(a, b);
                        return [0, 0, 0, 0];
                    }
                }}/>
                <button icon_name="close-symbolic" onClicked={() => {
                    activeClient.get().kill();
                }}/>
            </box>}
        </With>
    </box>
}
