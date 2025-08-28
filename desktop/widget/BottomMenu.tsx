import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { animateRadius, InvertedCorner } from "./InvertedCorner";
import { IconButton } from "./IconButton";
import { Accessor, createState } from "gnim";
import { powerMenuOpen } from "./GlobalState";
import { exec } from "ags/process";

const { BOTTOM} = Astal.WindowAnchor

export const BottomMenu = ({children, gdkmonitor, name, revealed}: {children: any, gdkmonitor: Gdk.Monitor, name: string, revealed: Accessor<boolean>}) => {

    const [radius, setRadius] = createState(0);

    return <window
        visible
        name={name}
        class="bottom-menu"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        anchor={BOTTOM }
        default_height={-1}
        application={app}
        margin_bottom={5}
    >
        <centerbox>
            <InvertedCorner $type="start" class="bar" radius={radius} corner="bottom-right" valign={Gtk.Align.END}/>
            <Gtk.Revealer $type="center" revealChild={revealed} transition_type={Gtk.RevealerTransitionType.SLIDE_UP} transition_duration={100} onNotifyRevealChild={(e) => {
                if(e.reveal_child) {
                    animateRadius(e, setRadius, 0, 16, 100);
                } else {
                    animateRadius(e, setRadius, 16, 0, 100);
                }
            }}>
                <box class={powerMenuOpen[0].as(open => `bar bottom-menu-content ${open ? "open" : ""}`)}>
                    {children}
                </box>
            </Gtk.Revealer>
            <InvertedCorner $type="end" class="bar" radius={radius} corner="bottom-left"  valign={Gtk.Align.END}/>
        </centerbox>
    </window>
}

const systemctl = (cmd: string) => {
    return exec.bind(null, `systemctl ${cmd}`);
}

export const PowerMenu = (gdkmonitor: Gdk.Monitor) => (
    <BottomMenu gdkmonitor={gdkmonitor} name="powermenu" revealed={powerMenuOpen[0]}>
        <IconButton icon_name="system-shutdown-symbolic" onClicked={systemctl("shutdown")} pixel_size={32} />
        <IconButton icon_name="system-reboot-symbolic" onClicked={systemctl("reboot")} pixel_size={32} />
        <IconButton icon_name="system-hibernate-symbolic" onClicked={systemctl("sleep")} pixel_size={32} />
        <IconButton icon_name="exit-symbolic" onClicked={exec.bind(null, "hyprctl dispatch exit")} pixel_size={32} />
        <IconButton icon_name="application-exit-symbolic" onClicked={() => powerMenuOpen[1](false)} pixel_size={32} />
    </BottomMenu>
)
