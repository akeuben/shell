import { Astal, Gdk, Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { Accessor, createBinding, createComputed, createState, onCleanup} from "gnim";
import app from "ags/gtk4/app";
import { setTopMenuOpen, topMenuOpen } from "./GlobalState";
import { animateRadius, InvertedCorner } from "./InvertedCorner";
import { IconButton } from "./IconButton";
import { MusicPage } from "./Music";
import { BatteryPage } from "./Battery";
import { TimePage } from "./DateTime";
import { NetworkPage } from "./Network";
import { BluetoothPage } from "./Bluetooth";

const { BOTTOM, TOP, LEFT, RIGHT } = Astal.WindowAnchor

const hyprland = AstalHyprland.get_default();

export const TopMenu = ({gdkmonitor}: {gdkmonitor: Gdk.Monitor}) => {
    const monitor = createBinding(hyprland, "focused_monitor");
    const open = createComputed([monitor, topMenuOpen], (m, r) => r && m.name === gdkmonitor.connector);

    const [visible, setVisible] = createState(false);
    const [page, setPage] = createState(0);

    open.subscribe(() => {
        if(open.get()) {
            setVisible(true);
        } else {
            setTimeout(() => {
                setVisible(false);
                setPage(0);
            }, 100)
        }
    })
    
    const [radius, setRadius] = createState(0);


    return <window
        visible={visible}
        name="top-menu"
        class="top-menu"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.ON_DEMAND}
        anchor={BOTTOM | TOP | LEFT | RIGHT}
        application={app}
        focusable
        namespace={`shell:top-menu`}
        $={(window) => {
            onCleanup(() => window.destroy())
        }}
>
        <box focus_on_click orientation={Gtk.Orientation.VERTICAL} hexpand={true} vexpand={true} css="background: #00000044;" $={(e) => {
            const gesture = new Gtk.GestureClick();
            gesture.connect("released", () => {
                setTopMenuOpen(false);
            })
            e.add_controller(gesture);
        }}>
            <box hexpand valign={Gtk.Align.START} height_request={5} class="bar-overlay" />
            <centerbox hexpand={true} halign={Gtk.Align.CENTER} valign={Gtk.Align.START}>
                <InvertedCorner $type="start" class="bar" radius={radius} corner="top-right" valign={Gtk.Align.START}/>
                <Gtk.Revealer hexpand $type="center" revealChild={open} transition_type={Gtk.RevealerTransitionType.SLIDE_DOWN} transition_duration={100} onNotifyRevealChild={(e) => {
                    if(e.reveal_child) {
                        animateRadius(e, setRadius, 0, 16, 100);
                    } else {
                        animateRadius(e, setRadius, 16, 0, 100);
                    }
                }}>
                    <box hexpand class={open.as(open => `bar top-menu-content ${open ? "open" : ""}`)} orientation={Gtk.Orientation.VERTICAL} $={(e) => {
                        const gesture = new Gtk.GestureClick();
                        gesture.connect("released", (controller) => {
                            controller.set_state(Gtk.EventSequenceState.CLAIMED);
                        })
                        e.add_controller(gesture);
                    }}>
                        <box spacing={30} hexpand margin_top={10} margin_bottom={5} margin_start={10} margin_end={10} class="top-menu-header">
                            <IconButton hexpand className={page.as(p => p === -2 ? "top-menu-selected-tab" : "")} icon_name="preferences-bluetooth-symbolic" pixel_size={32} onClicked={() => setPage(-2)} />
                            <IconButton hexpand className={page.as(p => p === -1 ? "top-menu-selected-tab" : "")} icon_name="network-wireless-symbolic" pixel_size={32} onClicked={() => setPage(-1)} />
                            <IconButton hexpand className={page.as(p => p === 0 ? "top-menu-selected-tab" : "")} icon_name="text-calendar-symbolic" pixel_size={32} onClicked={() => setPage(0)} />
                            <IconButton hexpand className={page.as(p => p === 1 ? "top-menu-selected-tab" : "")} icon_name="battery-symbolic" pixel_size={32} onClicked={() => setPage(1)} />
                            <IconButton hexpand className={page.as(p => p === 2 ? "top-menu-selected-tab" : "")} icon_name="music-note-symbolic" pixel_size={32} onClicked={() => setPage(2)} />
                        </box>
                        <stack visible_child_name={page.as(p => `${p}`)} $type="named" transition_type={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT} margin_start={10} margin_end={10} >
                            <BluetoothPage name="-2" $type="named"/>
                            <NetworkPage name="-1" $type="named"/>
                            <TimePage name="0" $type="named"/>
                            <BatteryPage name="1" $type="named"/>
                            <MusicPage name="2" $type="named"/>
                        </stack>
                    </box>
                </Gtk.Revealer>
                <InvertedCorner $type="end" class="bar" radius={radius} corner="top-left"  valign={Gtk.Align.START}/>
            </centerbox>
        </box>
    </window>
}

