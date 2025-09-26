import { Gdk, Gtk } from "ags/gtk4";
import { createPoll } from "ags/time";
import AstalNetwork from "gi://AstalNetwork?version=0.1";
import { createBinding, createComputed, createState, For, With } from "gnim";
import { IconButton } from "./IconButton";
import { WrappedMarqueeLabel } from "./Marquee";

const network = AstalNetwork.get_default();

const NetworkDetails = ({wifi}: {wifi: AstalNetwork.Wifi | AstalNetwork.Wired}) => {
    
    const active = createBinding(network, "primary").as(
        primary => (primary === AstalNetwork.Primary.WIFI && wifi instanceof AstalNetwork.Wifi) 
                || (primary === AstalNetwork.Primary.WIRED && wifi instanceof AstalNetwork.Wired)
    )

    const ip = createPoll(null, 500, () => {
        const addresses = wifi?.device?.get_active_connection()?.get_ip4_config()?.get_addresses();
        if(!addresses || addresses.length == 0) return null;
        return addresses[0].get_address();
    })

    if(!wifi) return <box />


    return <box valign={Gtk.Align.START} hexpand orientation={Gtk.Orientation.VERTICAL} spacing={10}>
        <label hexpand halign={Gtk.Align.CENTER} label={wifi instanceof AstalNetwork.Wifi ? "Wifi" : "Ethernet"} class="toggle-label" />
        <box hexpand class="top-section" orientation={Gtk.Orientation.VERTICAL}>
            {wifi instanceof AstalNetwork.Wifi && 
                <box height_request={48} hexpand spacing={10}>
                    <label hexpand halign={Gtk.Align.START} label="Enable:" />
                    <Gtk.Switch halign={Gtk.Align.END} valign={Gtk.Align.CENTER} active={wifi.enabled} $={(self) => {
                        wifi.connect("notify::enabled", (e) => {
                            self.set_active(e.enabled);
                        })
                    }} onNotifyActive={(e) => {
                        wifi.set_enabled(e.active);
                    }}/>
                </box>
            }
            {wifi instanceof AstalNetwork.Wifi &&
                <box orientation={Gtk.Orientation.HORIZONTAL} height_request={48} hexpand>
                    <With value={createBinding(wifi, "scanning")}>
                        {scanning => <box hexpand>
                            <label hexpand halign={Gtk.Align.START} label="Scan:" />
                            {scanning ? 
                                <Gtk.Spinner halign={Gtk.Align.END} spinning width_request={16} height_request={16}/> :
                                <IconButton halign={Gtk.Align.END} className="" icon_name="view-refresh-symbolic" pixel_size={16} onClicked={() => {
                                    wifi.scan();
                                }} />
                            }
                        </box>}
                    </With>
                </box>
            }
            <box height_request={48}>
                <label label="Status:" hexpand halign={Gtk.Align.START} />
                <label vexpand valign={Gtk.Align.CENTER} halign={Gtk.Align.END} label={active.as(a => a ? "Active" : "Inactive")} class="details" />
            </box>
            <box height_request={48}>
                <label label="IP:" hexpand halign={Gtk.Align.START} />
                <label vexpand valign={Gtk.Align.CENTER} halign={Gtk.Align.END} label={ip.as(ip => `${ip}`)} class="details" />
            </box>
        </box>
    </box>

}

const NetworkAPCard = ({ap}: {ap: AstalNetwork.AccessPoint}) => {
    return <box spacing={10} orientation={Gtk.Orientation.HORIZONTAL} vexpand={false} valign={Gtk.Align.START} class="top-section">
        <image icon_name={createBinding(ap, "icon_name").as(i => i ? (i.includes("symbolic") ? i : `${i}-symbolic`) : "bluetooth-active-symbolic")} pixel_size={48} />
        <box orientation={Gtk.Orientation.VERTICAL} hexpand valign={Gtk.Align.CENTER}>
            <WrappedMarqueeLabel label={createBinding(ap, "ssid").as(name => name ? name : "Unknown")} cssClass="connectable-title" />
            <label label={createBinding(ap, "requires_password").as(p => p ? "Secured" : "Open")} />
        </box>
        <box width_request={50} orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
                <IconButton className={undefined} icon_name="plus-symbolic" pixel_size={24} onClicked={() => {
                ap.get_connections()[0]
                    ap.activate(null, (_, res) => {
                    })
                }} />
        </box>
    </box>
}

function unique<T>(list: T[], id: (arg0: T) => string) {
    return list.filter((e, i, l) => l.findIndex(e2 => id(e) === id(e2)) === i);
}

const prettyPrintStatus = (status: AstalNetwork.DeviceState) => {
    switch(status) {
        case AstalNetwork.DeviceState.ACTIVATED:
            return "Connected";
        case AstalNetwork.DeviceState.CONFIG:
            return "Configuring";
        case AstalNetwork.DeviceState.DEACTIVATING:
            return "Disconnecting";
        case AstalNetwork.DeviceState.DISCONNECTED:
            return "Disconnected";
        case AstalNetwork.DeviceState.FAILED:
        case AstalNetwork.DeviceState.UNAVAILABLE:
            return "Failed";
        case AstalNetwork.DeviceState.NEED_AUTH:
            return "Authentication Failed";
        case AstalNetwork.DeviceState.IP_CHECK:
        case AstalNetwork.DeviceState.IP_CONFIG:
            return "Acquiring IP";
        case AstalNetwork.DeviceState.PREPARE:
            return "Connecting";
        case AstalNetwork.DeviceState.SECONDARIES:
        case AstalNetwork.DeviceState.UNKNOWN:
        case AstalNetwork.DeviceState.UNMANAGED:
            return "Unknown";
    }
}

const NetworkActiveCard = ({wifi}: {wifi: AstalNetwork.Wifi}) => {
    const ssid = createBinding(wifi, "ssid");
    const icon = createBinding(wifi, "icon_name");
    const status = createBinding(wifi, "state");

    const [needPassword, setNeedPassword] = createState<AstalNetwork.AccessPoint | null>(null);

    wifi.connect("notify::state", () => {
        if(wifi.state === AstalNetwork.DeviceState.FAILED) {
            setNeedPassword(wifi.access_points.find(ap => ap.ssid === wifi.ssid) || null);
        }
    })
    wifi.connect("notify::ssid", () => {
        console.log(wifi.ssid)
    })

    const height = 110;
    const width = 350;

    return <With value={needPassword}>
        {needPassword => !needPassword ? 
            <box height_request={height} width_request={width} spacing={10} orientation={Gtk.Orientation.HORIZONTAL} vexpand={false} valign={Gtk.Align.START} class="top-section">
                <image icon_name={icon.as(i => i ? (i.includes("symbolic") ? i : `${i}-symbolic`) : "network-wireless-acquiring-symbolic")} pixel_size={48} />
                <box orientation={Gtk.Orientation.VERTICAL} hexpand valign={Gtk.Align.CENTER}>
                    <WrappedMarqueeLabel label={ssid.as(name => name ? name : "Unknown")} cssClass="connectable-title" />
                    <label label={status.as(prettyPrintStatus)} />
                </box>
                <With value={status}>
                    {state => <box width_request={50} orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
                        {state === AstalNetwork.DeviceState.ACTIVATED ? 
                            <IconButton className={undefined} icon_name="minus-symbolic" pixel_size={24} onClicked={() => {
                                wifi.deactivate_connection((_, res) => {
                                    wifi.deactivate_connection_finish(res);
                                });
                            }} />
                         : 
                        <Gtk.Spinner spinning width_request={32} height_request={32} />}
                    </box>}
                </With>
            </box> : 
            <box height_request={height} width_request={width} spacing={10} orientation={Gtk.Orientation.HORIZONTAL} vexpand={false} valign={Gtk.Align.START} class="top-section">
                <image icon_name={createBinding(needPassword, "icon_name").as(i => i ? (i.includes("symbolic") ? i : `${i}-symbolic`) : "network-wireless-acquiring-symbolic")} pixel_size={48} />
                <box orientation={Gtk.Orientation.VERTICAL} hexpand valign={Gtk.Align.CENTER} spacing={10}>
                    <WrappedMarqueeLabel label={createBinding(needPassword, "ssid").as(name => name ? name : "Unknown")} cssClass="connectable-title" />
                    <Gtk.PasswordEntry placeholder_text="Enter Password" $={(self) => {
                        setTimeout(() => {
                            self.grab_focus();
                        }, 100);

                        const controller = Gtk.EventControllerKey.new();
                        controller.set_propagation_phase(Gtk.PropagationPhase.CAPTURE);
                        controller.connect("key-released", (_controller, key, _keycode, _state) => {
                            if([Gdk.KEY_Return, Gdk.KEY_KP_Enter].includes(key)) {
                                console.log(self.text);
                                needPassword.activate(self.text, (_, res) => {
                                    needPassword.activate_finish(res);
                                    setNeedPassword(null);
                                })
                                return Gdk.EVENT_STOP;
                            }
                            if(key === Gdk.KEY_Escape) {
                                setNeedPassword(null);
                                return Gdk.EVENT_STOP;
                            }
                            return Gdk.EVENT_PROPAGATE;
                        })

                        const controller2 = Gtk.EventControllerFocus.new();
                        controller2.connect("leave", () => {
                            setNeedPassword(null);
                            return Gdk.EVENT_STOP;
                        })
                        self.add_controller(controller);
                    }}/>
                </box>
            </box>
        }
    </With>
}

const NetworkList = ({wifi}: {wifi: AstalNetwork.Wifi}) => {
    const aps = createBinding(wifi, "access_points").as(aps => unique(aps.sort((a, b) => b.strength - a.strength), ap => ap.ssid));
    const active_ssid = createBinding(wifi, "ssid");

    const connectable = createComputed([aps, active_ssid], (aps, active_ssid) => aps.filter(a => a.ssid !== active_ssid));

    return <box hexpand vexpand orientation={Gtk.Orientation.VERTICAL} spacing={10}>
        <box vexpand>
            <With value={createBinding(wifi, "enabled")}>
            { 
                (powered: boolean) => powered && <scrolledwindow hexpand vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC} hscrollbar_policy={Gtk.PolicyType.NEVER}> 
                    <box orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                        <For each={connectable}>
                            {(ap: AstalNetwork.AccessPoint) => <NetworkAPCard ap={ap} />}
                        </For>
                    </box>
                </scrolledwindow>
            }
            </With>
        </box>
    </box>

}

type Subpage = {
    icon: string,
    idx: number,
    widget: JSX.Element,
}

export const NetworkPage = ({name}: {name: string}) => {
    const wifi = createBinding(network, "wifi");
    const wired = createBinding(network, "wired")

    const [page, setPage] = createState(0);

    const pages = createComputed([wifi, wired], (wifi, wired) => {
        const pages: Subpage[] = [];
        if(wifi) {
            pages.push({
                icon: "network-wireless-connected-symbolic",
                idx: 0,
                widget: <WifiPage $type="named" name="0" />
            })
        }
        if(wired) {
            pages.push({
                icon: "preferences-system-network-symbolic",
                idx: 1,
                widget: <WiredPage $type="named" name="1" />
            })
        }

        return pages;
    })
    
    return <box name={name}>
        <With value={pages}>
            {pages => {
                if(pages.length == 0) {
                    return <label label="No networking support found!" />
                }
                if(pages.length == 1) {
                    return pages[0].widget;
                }

                return <box>
                    <box vexpand margin_top={10} margin_bottom={10} class="top-submenu-selector">
                        <Gtk.FlowBox max_children_per_line={1}>
                            {pages.map(p => (
                                <IconButton valign={Gtk.Align.CENTER} className={page.as(p2 => p2 === p.idx ? "top-menu-selected-tab" : "")} icon_name={p.icon} pixel_size={24} onClicked={() => setPage(p.idx)} />
                            ))}
                        </Gtk.FlowBox>
                    </box>
                    <stack visible_child_name={page.as(p => `${p}`)} $type="named" transition_type={Gtk.StackTransitionType.SLIDE_UP_DOWN}>
                        {pages.map(p => p.widget)}
                    </stack>
                </box>

            }}
        </With>
    </box>
}

const WiredPage = ({name}: {name: string}) => {
    const wired = createBinding(network, "wired");

    return <box name={name} hexpand spacing={10} orientation={Gtk.Orientation.VERTICAL}>
        <With value={wired}>
            {wifi => <NetworkDetails wifi={wifi} />}
        </With>
    </box>
} 

const WifiPage = ({name}: {name: string}) => {
    const wifi = createBinding(network, "wifi");

    const InfoColumn = <box hexpand spacing={10} orientation={Gtk.Orientation.VERTICAL}>
        <With value={wifi}>
            {wifi => <box orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                <NetworkDetails wifi={wifi} />
                <NetworkActiveCard wifi={wifi} />
            </box>}
        </With>
    </box>

    const ListColumn = <box hexpand>
        <With value={wifi}>
            {wifi => <NetworkList wifi={wifi} />}
        </With>
    </box>

    const Grid = Gtk.Grid.new();
    Grid.name = name;
    Grid.column_homogeneous = true;
    Grid.set_column_spacing(10);
    Grid.margin_top = 10;
    Grid.margin_bottom = 10;
    Grid.attach(InfoColumn as Gtk.Widget, 0, 0, 1, 1);
    Grid.attach(ListColumn as Gtk.Widget, 1, 0, 1, 1);

    return Grid;
} 

