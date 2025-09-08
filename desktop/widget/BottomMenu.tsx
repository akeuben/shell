import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { animateRadius, InvertedCorner } from "./InvertedCorner";
import { IconButton } from "./IconButton";
import { Accessor, createBinding, createComputed, createState, For, onCleanup } from "gnim";
import { exec } from "ags/process";
import { BaseResponse, RequestHandler, RunnerRequest, ScreenshotRequest} from "../util/requests";
import { bottomMenu, BottomMenuType, setBottomMenu } from "./GlobalState";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { RunnerSettings } from "../util/runner";
import { RunnerAction } from "../types/runner_sources/source";
import { execAsync } from "astal";

const { BOTTOM, TOP, LEFT, RIGHT } = Astal.WindowAnchor

const hyprland = AstalHyprland.get_default();

export const BottomMenu = ({children, gdkmonitor, name, revealed, close}: {children: any, gdkmonitor: Gdk.Monitor, name: string, revealed: Accessor<boolean>, close: () => void}) => {

    const monitor = createBinding(hyprland, "focused_monitor");
    const open = createComputed([monitor, revealed], (m, r) => r && m.name === gdkmonitor.connector);

    const [visible, setVisible] = createState(false);

    open.subscribe(() => {

        if(open.get()) {
            setVisible(true);
        } else {
            setTimeout(() => {
                setVisible(false);
            }, 100)
        }
    })
    
    const [radius, setRadius] = createState(0);

    return <window
        visible={visible}
        name={name}
        class="bottom-menu"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.ON_DEMAND}
        anchor={BOTTOM | TOP | LEFT | RIGHT}
        application={app}
        focusable
        namespace={`shell:${name}`}
        $={(window) => {
            onCleanup(() => window.destroy())
        }}
    >
        <box orientation={Gtk.Orientation.VERTICAL} hexpand={true} vexpand={true} css="background: #00000044;" $={(e) => {
            const gesture = new Gtk.GestureClick();
            gesture.connect("released", () => {
                close();
            })
            e.add_controller(gesture);
        }}>
            <centerbox vexpand hexpand={true} halign={Gtk.Align.CENTER} valign={Gtk.Align.END}>
                <InvertedCorner $type="start" class="bar" radius={radius} corner="bottom-right" valign={Gtk.Align.END}/>
                <Gtk.Revealer $type="center" revealChild={open} transition_type={Gtk.RevealerTransitionType.SLIDE_UP} transition_duration={100} onNotifyRevealChild={(e) => {
                    if(e.reveal_child) {
                        animateRadius(e, setRadius, 0, 16, 100);
                    } else {
                        animateRadius(e, setRadius, 16, 0, 100);
                    }
                }}>
                    <box class={open.as(open => `bar bottom-menu-content ${open ? "open" : ""}`)} $={(e) => {
                        const gesture = new Gtk.GestureClick();
                        gesture.connect("released", (controller) => {
                            controller.set_state(Gtk.EventSequenceState.CLAIMED);
                        })
                        e.add_controller(gesture);
                    }}>
                        {children}
                    </box>
                </Gtk.Revealer>
                <InvertedCorner $type="end" class="bar" radius={radius} corner="bottom-left"  valign={Gtk.Align.END}/>
            </centerbox>
            <box hexpand valign={Gtk.Align.END} height_request={5} class="bar-overlay" />
        </box>
    </window>
}

const systemctl = (cmd: string) => {
    return exec.bind(null, `systemctl ${cmd}`);
}

export const PowerMenu = ({gdkmonitor}: {gdkmonitor: Gdk.Monitor}) => {
    const open = bottomMenu.as(m => m === BottomMenuType.POWER_MENU);

    return <BottomMenu gdkmonitor={gdkmonitor} name="powermenu" revealed={open} close={() => setBottomMenu(BottomMenuType.NONE)}>
        <IconButton icon_name="system-shutdown-symbolic" onClicked={systemctl("poweroff")} pixel_size={32} className="" />
        <IconButton icon_name="system-reboot-symbolic" onClicked={systemctl("reboot")} pixel_size={32} className="" />
        <IconButton icon_name="system-hibernate-symbolic" onClicked={systemctl("sleep")} pixel_size={32} className="" />
        <IconButton icon_name="exit-symbolic" onClicked={exec.bind(null, "hyprctl dispatch exit")} pixel_size={32} className="" />
        <IconButton icon_name="application-exit-symbolic" onClicked={() => setBottomMenu(BottomMenuType.NONE)} pixel_size={32} className="" />
    </BottomMenu>
}

const hyprshot = (cmd: string) => {
    return () => {
        setBottomMenu(BottomMenuType.NONE);
        setTimeout(() => {
            execAsync(`hyprshot -m ${cmd}`);
        }, 200);
    }
}

export const ScreenshotMenu = ({gdkmonitor}: {gdkmonitor: Gdk.Monitor}) => {
    const open = bottomMenu.as(m => m === BottomMenuType.SCREENSHOT);

    return <BottomMenu gdkmonitor={gdkmonitor} name="screenshot" revealed={open} close={() => setBottomMenu(BottomMenuType.NONE)}>
        <IconButton icon_name="screenshot-app-symbolic" onClicked={hyprshot("region")} pixel_size={32} className="" />
        <IconButton icon_name="screenshot-area-symbolic" onClicked={hyprshot("window")} pixel_size={32} className="" />
        <IconButton icon_name="screenshot-fullscreen-symbolic" onClicked={hyprshot("output")} pixel_size={32} className="" />
        <IconButton icon_name="application-exit-symbolic" onClicked={() => setBottomMenu(BottomMenuType.NONE)} pixel_size={32} className="" />
    </BottomMenu>
}

export const handleRunner: RequestHandler<RunnerRequest, {open: boolean}> = async (_) => {
    const result = new Promise<BaseResponse<{open: boolean}>>((resolve) => {
        setBottomMenu(m => {
            if(m === BottomMenuType.RUNNER) {
                resolve({
                    type: "success",
                    payload: {
                        open: false
                    }
                })
                return BottomMenuType.NONE;
            }
            resolve({
                type: "success",
                payload: {
                    open: true
                }
            })
            return BottomMenuType.RUNNER;
        })
    });   

    return result;
    
}

export const handleScreenshot: RequestHandler<ScreenshotRequest, {open: boolean}> = async (_) => {
    const result = new Promise<BaseResponse<{open: boolean}>>((resolve) => {
        setBottomMenu(m => {
            if(m === BottomMenuType.SCREENSHOT) {
                resolve({
                    type: "success",
                    payload: {
                        open: false
                    }
                })
                return BottomMenuType.NONE;
            }
            resolve({
                type: "success",
                payload: {
                    open: true
                }
            })
            return BottomMenuType.SCREENSHOT;
        })
    });   

    return result;
    
}


const RunnerResults = ({results, selected, close}: {results: Accessor<RunnerAction[]>, selected: Accessor<number>, close: () => void}) => {

    
    return <box orientation={Gtk.Orientation.VERTICAL} spacing={16} vexpand={false} valign={Gtk.Align.START}>
        <For each={results}>
            {(result, i) => {
                const s = createComputed([selected, i], (s, i) => s === i);
                return <button focusable={false} class={s.as(s => `runner-result ${s ? "selected" : ""}`)} onClicked={() => {
                    result.action()
                    close();
                }}>
                    <box spacing={20}>
                        {result.icon ? <image icon_name={result.icon} /> : <></> }
                        <box orientation={Gtk.Orientation.VERTICAL} vexpand={true} hexpand={true} halign={Gtk.Align.START} valign={Gtk.Align.CENTER}>
                            <label class="title" hexpand={true} valign={Gtk.Align.CENTER} halign={Gtk.Align.START} label={result.name.slice(0, 80) + (result.name.length > 80 ? "..." : "")} />
                            {result.description ? <label class="description" valign={Gtk.Align.CENTER} hexpand={true} halign={Gtk.Align.START} label={result.description.slice(0, 80) + (result.description.length > 80 ? "..." : "")} /> : <></>}
                        </box>
                    </box>
                </button>
            }}
        </For>
    </box>
}

export const Runner = ({gdkmonitor}: {gdkmonitor: Gdk.Monitor}) => {
    const open = bottomMenu.as(m => m === BottomMenuType.RUNNER);
    const close = () => setBottomMenu(BottomMenuType.NONE);

    const [search, setSearch] = createState<string>("");
    const results = search.as(searchTerm => RunnerSettings.find_all_results(searchTerm));
    const [selected, setSelected] = createState(0);

    search.subscribe(() => {
        setSelected(0);
    })


    return <BottomMenu gdkmonitor={gdkmonitor} name="appmenu" revealed={open} close={close}>
        <box orientation={Gtk.Orientation.VERTICAL} spacing={search.as(s => s ? 16 : 0)} width_request={1000}> 
            <RunnerResults selected={selected} results={results} close={close} />
            <Gtk.SearchEntry vexpand={false} valign={Gtk.Align.END} $={(e) => {
                open.subscribe(() => {
                    if(!open.get()) {
                        return;
                    }
                    e.set_text("");
                    e.grab_focus();
                })
                const controller = Gtk.EventControllerKey.new();
                controller.set_propagation_phase(Gtk.PropagationPhase.CAPTURE);
                controller.connect("key-released", (_controller, key, _keycode, _state) => {
                    if([Gdk.KEY_Return, Gdk.KEY_KP_Enter].includes(key)) {
                        if(results.get().length === 0) return;
                        results.get()[selected.get()].action();
                        close();
                        return Gdk.EVENT_STOP;
                    }
                    if(key === Gdk.KEY_Up) {
                        setSelected(selected => Math.max(0, selected - 1));
                        return Gdk.EVENT_STOP;
                    }
                    if(key === Gdk.KEY_Down) {
                        setSelected(selected => Math.min(selected + 1, results.get().length - 1));
                        return Gdk.EVENT_STOP;
                    }
                    if(key === Gdk.KEY_Escape) {
                        close();
                        return Gdk.EVENT_STOP;
                    }
                    return Gdk.EVENT_PROPAGATE;
                })
                e.add_controller(controller);
            }} placeholder_text="Search Anything..." onSearchChanged={e => {
                setSearch(e.text);
            }}/>
        </box>
    </BottomMenu>
}
