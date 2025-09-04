import { Astal, Gdk, Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { createBinding, createComputed, createState } from "gnim";
import app from "ags/gtk4/app";
import { setTopMenuOpen, topMenuOpen } from "./GlobalState";
import { animateRadius, InvertedCorner } from "./InvertedCorner";
import { IconButton } from "./IconButton";
import { createPoll } from "ags/time";

const { BOTTOM, TOP, LEFT, RIGHT } = Astal.WindowAnchor

const hyprland = AstalHyprland.get_default();

export const TopMenu = (gdkmonitor: Gdk.Monitor) => {
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
    >
        <box orientation={Gtk.Orientation.VERTICAL} hexpand={true} vexpand={true} css="background: #00000044;" $={(e) => {
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
                            <WifiPage name="-1" $type="named"/>
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

const BluetoothPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="bluetooth" />
    </box>
}

const WifiPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="wifi" />
    </box>
} 

const ClockPage = ({name}: {name: string}) => {
    const time = createPoll("00", 1000, `date +"%H:%M"`)
    const second = createPoll("00", 1000, `date +"%S"`)
    const date = createPoll("", 500, `date +"%A %B %m, %Y"`)
    return <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} hexpand={true} name={name}>
        <box spacing={5}>
            <label valign={Gtk.Align.BASELINE_CENTER} hexpand class="time" label={time} />
            <label valign={Gtk.Align.BASELINE_CENTER} hexpand class="second" label={second} margin_bottom={5} />
        </box>
        <label class="date" label={date} />
    </box>
}

const CalendarPage = ({name}: {name: string}) => {

    const [page, setPage] = createState(0);
    
    return <box name={name} spacing={10}>
        <Gtk.Calendar />
        <box orientation={Gtk.Orientation.VERTICAL}>
            <box hexpand class="top-subsubmenu-header">
                <IconButton hexpand className={page.as(p => p === 0 ? "top-menu-selected-tab" : "")} icon_name="text-calendar-symbolic" pixel_size={16} onClicked={() => setPage(0)} />
                <IconButton hexpand className={page.as(p => p === 1 ? "top-menu-selected-tab" : "")} icon_name="task-list-symbolic" pixel_size={16} onClicked={() => setPage(1)} />
            </box>
            <stack visible_child_name={page.as(p => `${p}`)} $type="named" transition_type={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT} width_request={200} height_request={300}>
                <EventsPage name="0" $type="named" />
                <TodoPage name="1" $type="named" />
            </stack>
        </box>
    </box>
}

const EventsPage = ({name}: {name: string}) => {
    return <label label="events" name={name}/>
}

const TodoPage = ({name}: {name: string}) => {
    return <label label="todo" name={name}/>
}

const StopwatchPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="stopwatch" />
        
    </box>
}

const TimerPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="timer" />
        
    </box>
}

const TimePage = ({name}: {name: string}) => {
    const [page, setPage] = createState(0);
    return <box name={name}>
        <box>
            <box orientation={Gtk.Orientation.VERTICAL} spacing={20} margin_top={10} margin_bottom={10} class="top-submenu-selector">
                <IconButton vexpand className={page.as(p => p === 0 ? "top-menu-selected-tab" : "")} icon_name="clock-app-symbolic" pixel_size={24} onClicked={() => setPage(0)} />
                <IconButton vexpand className={page.as(p => p === 1 ? "top-menu-selected-tab" : "")} icon_name="text-calendar-symbolic" pixel_size={24} onClicked={() => setPage(1)} />
                <IconButton vexpand className={page.as(p => p === 2 ? "top-menu-selected-tab" : "")} icon_name="stopwatch-symbolic" pixel_size={24} onClicked={() => setPage(2)} />
                <IconButton vexpand className={page.as(p => p === 3 ? "top-menu-selected-tab" : "")} icon_name="tools-timer-symbolic" pixel_size={24} onClicked={() => setPage(3)} />
            </box>
            <stack visible_child_name={page.as(p => `${p}`)} $type="named" transition_type={Gtk.StackTransitionType.SLIDE_UP_DOWN}>
                <ClockPage name="0" $type="named" />
                <CalendarPage name="1" $type="named" />
                <StopwatchPage name="2" $type="named" />
                <TimerPage name="3" $type="named" />
            </stack>
        </box>
    </box>
}

const BatteryPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="battery" />
    </box>
}

const MusicPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="music" />
    </box>
}
