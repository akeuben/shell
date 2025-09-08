import { Gdk, Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1"
import { createBinding, For } from "gnim";

const hyprland = AstalHyprland.get_default();

const determineWorkspaceClass = (active_workspace: AstalHyprland.Workspace, current_workspace: AstalHyprland.Workspace) => {
    let clazz = "workspace-indicator ";
    
    if(active_workspace && active_workspace.name === current_workspace.name) {
        clazz += "active ";
    }
    if(isNaN(parseInt(current_workspace.name))) {
        clazz += "special "
    }

    return clazz;
}

export const WorkspaceIndicator = ({gdkmonitor}: {gdkmonitor: Gdk.Monitor}) => {
    const workspaces = createBinding(hyprland, "workspaces");
    const monitor = hyprland.monitors.find(m => m.name === gdkmonitor.connector) as AstalHyprland.Monitor;

    return <box orientation={Gtk.Orientation.VERTICAL} spacing={10} class="workspaces">
        <For each={workspaces.as(w => w.toSorted((a, b) => parseInt(a.name) - parseInt(b.name)))}>
            {(workspace: AstalHyprland.Workspace) => <box 
                hexpand={false} 
                cursor={Gdk.Cursor.new_from_name("pointer", null)}
                halign={Gtk.Align.CENTER} 
                class={createBinding(monitor, "active_workspace").as(w => determineWorkspaceClass(w, workspace))}
            >
                <Gtk.GestureClick 
                    button={Gdk.BUTTON_PRIMARY}
                    onPressed={() => {
                        workspace.move_to(monitor);
                        workspace.focus();
                    }}
                />
            </box>}
        </For>
    </box>
}
