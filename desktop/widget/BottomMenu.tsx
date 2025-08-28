import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { animateRadius, InvertedCorner } from "./InvertedCorner";
import { IconButton } from "./IconButton";
import { Accessor, createBinding, createComputed, createState, For, With } from "gnim";
import { exec } from "ags/process";
import { BaseResponse, RequestHandler, RunnerRequest } from "../util/requests";
import { bottomMenu, BottomMenuType, setBottomMenu } from "./GlobalState";
import GLib from "gi://GLib?version=2.0";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import AstalApps from "gi://AstalApps?version=0.1";
import { RunnerSettings } from "../util/runner";
import { RunnerAction } from "../types/runner_sources/source";

const { BOTTOM} = Astal.WindowAnchor

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
        anchor={BOTTOM }
        default_height={-1}
        application={app}
        focusable
        margin_bottom={5}
        namespace={`shell:${name}`}
    >
        <centerbox>
            <InvertedCorner $type="start" class="bar" radius={radius} corner="bottom-right" valign={Gtk.Align.END}/>
            <Gtk.Revealer $type="center" revealChild={open} transition_type={Gtk.RevealerTransitionType.SLIDE_UP} transition_duration={100} onNotifyRevealChild={(e) => {
                if(e.reveal_child) {
                    animateRadius(e, setRadius, 0, 16, 100);
                } else {
                    animateRadius(e, setRadius, 16, 0, 100);
                }
            }}>
                <box class={open.as(open => `bar bottom-menu-content ${open ? "open" : ""}`)}>
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

export const PowerMenu = (gdkmonitor: Gdk.Monitor) => {
    const open = bottomMenu.as(m => m === BottomMenuType.POWER_MENU);

    return <BottomMenu gdkmonitor={gdkmonitor} name="powermenu" revealed={open} close={() => setBottomMenu(BottomMenuType.NONE)}>
        <IconButton icon_name="system-shutdown-symbolic" onClicked={systemctl("poweroff")} pixel_size={32} />
        <IconButton icon_name="system-reboot-symbolic" onClicked={systemctl("reboot")} pixel_size={32} />
        <IconButton icon_name="system-hibernate-symbolic" onClicked={systemctl("sleep")} pixel_size={32} />
        <IconButton icon_name="exit-symbolic" onClicked={exec.bind(null, "hyprctl dispatch exit")} pixel_size={32} />
        <IconButton icon_name="application-exit-symbolic" onClicked={() => setBottomMenu(BottomMenuType.NONE)} pixel_size={32} />
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

const RunnerResults = ({results, selected, close}: {results: Accessor<RunnerAction[]>, selected: Accessor<number>, close: () => void}) => {

    
    return <box orientation={Gtk.Orientation.VERTICAL} spacing={16} vexpand={true}>
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

export const Runner = (gdkmonitor: Gdk.Monitor) => {
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
