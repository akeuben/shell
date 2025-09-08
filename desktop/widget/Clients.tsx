import { Astal, Gdk, Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import Graphene from "gi://Graphene?version=1.0";
import Gsk from "gi://Gsk?version=4.0";
import { Accessor, createBinding, createComputed, For, With } from "gnim";
import { property, register } from "gnim/gobject";
import { pointer } from "../util/cursor";

const hyprland = AstalHyprland.get_default();

const fixup_icons = (initial_class: string): string => {
    if(!initial_class) return "window-symbolic";
    if(initial_class === "zen") return "zen-browser";
    if(initial_class.toLowerCase().includes("minecraft")) return "minecraft";

    return initial_class;
}

export const ClientWidget = ({client, workspace}: {client: AstalHyprland.Client, workspace: Accessor<AstalHyprland.Workspace>}) => {
    const clientWorkspace = createBinding(client, "workspace");
    const focusedClient = createBinding(hyprland, "focused_client");
    
    const isOnCorrectWorkspace = createComputed([clientWorkspace, workspace, focusedClient], (clientWorkspace, workspace, focusedClient) => workspace && clientWorkspace.name === workspace.name && (!focusedClient || focusedClient.pid !== client.pid));
    
    return <Astal.Bin> 
        <With value={isOnCorrectWorkspace}>
            {isOnCorrectWorkspace => <Astal.Bin>
                {isOnCorrectWorkspace ? <button class="client" cursor={pointer}>
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

@register()
class RotatedLabel extends Gtk.Label {

    @property(Number)
    private angle: number;
    constructor(props: {label: string, angle: number}) {
        super(props);
        this.angle = props.angle;
    }
    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        // Create a transform centered on the label
        const alloc = this.get_allocation();
        const center = new Graphene.Point({ x: alloc.width / 2, y: alloc.height / 2 });

        let transform = new Gsk.Transform();
        transform = transform.translate(center) as Gsk.Transform;
        transform = transform.rotate(this.angle) as Gsk.Transform;
        transform = transform.translate(new Graphene.Point({ x: -center.x, y: -center.y })) as Gsk.Transform;

        snapshot.transform(transform);

        // Let Gtk.Label draw itself with the transform applied
        super.vfunc_snapshot(snapshot);
    }

    vfunc_measure(orientation: Gtk.Orientation, for_size: number): [number, number, number, number] {
        let [min, nat, minBaseline, natBaseline] =
            super.vfunc_measure(orientation, for_size);

        if (this.angle % 180 !== 0) {
            // Swap horizontal/vertical
            if (orientation === Gtk.Orientation.HORIZONTAL) {
                let [minH, natH] =
                    super.vfunc_measure(Gtk.Orientation.VERTICAL, for_size);
                return [minH, natH, -1, -1]; // baselines don’t make sense after rotation
            } else {
                let [minW, natW] =
                    super.vfunc_measure(Gtk.Orientation.HORIZONTAL, for_size);
                return [minW, natW, -1, -1];
            }
        }

        return [min, nat, minBaseline, natBaseline];
    }

}

const MAX_TITLE_LENGTH = 20;

const title_modifier = (title: string) => {
    if(!title) return "Window";
    if(title.length > MAX_TITLE_LENGTH) {
        title = title.substring(0, MAX_TITLE_LENGTH - 3) + "...";
    }

    return title;
}

const ActiveClientInner = ({client}: {client: AstalHyprland.Client}) => {
    return <box halign={Gtk.Align.CENTER} hexpand={false}>
            <box orientation={Gtk.Orientation.VERTICAL} spacing={10} class="bar-section">
                <image icon_name={fixup_icons(client.initial_class)} pixel_size={24} />
                <RotatedLabel label={title_modifier(client.title)} angle={90}/>
                <button icon_name="close-symbolic" onClicked={() => {
                    client.kill();
                }} cursor={pointer}/>
            </box>
    </box>
}

export const ActiveClient = () => {
    const activeClient = createBinding(hyprland, "focused_client");
    return <Astal.Bin> 
        <With value={activeClient}>
            {c => c && <ActiveClientInner client={c} />}
        </With>
    </Astal.Bin>
}
