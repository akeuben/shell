import { Astal, Gdk, Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { Accessor, createBinding, createComputed, createExternal, createState, For, onCleanup, With} from "gnim";
import app from "ags/gtk4/app";
import { setTopMenuOpen, topMenuOpen } from "./GlobalState";
import { animateRadius, InvertedCorner } from "./InvertedCorner";
import { IconButton } from "./IconButton";
import { createPoll } from "ags/time";
import AstalBattery from "gi://AstalBattery?version=0.1";
import { Variant } from "gnim/dbus";
import Gsk from "gi://Gsk?version=4.0";
import GObject, { property, register } from "gnim/gobject";
import Pango from "gi://Pango?version=1.0";
import Graphene from "gi://Graphene?version=1.0";
import Gio from "gi://Gio?version=2.0";
import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import { derive, execAsync, GLib } from "astal";
import AstalNetwork from "gi://AstalNetwork?version=0.1";
import NM from "gi://NM?version=1.0";

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

const pair_device = async (device: AstalBluetooth.Device) => {
    await execAsync(`bluetoothctl pair ${device.address}`)
    await execAsync(`bluetoothctl trust ${device.address}`)
    connect_device(device);
}

const connect_device = async(device: AstalBluetooth.Device) => {
    device.connect_device(async (_, res) => {
        try {
            device.connect_device_finish(res)
            await execAsync(`bluetoothctl pair ${device.address}`)
            await execAsync(`bluetoothctl trust ${device.address}`)
        } catch {}
    });
}

const disconnect_device = async(device: AstalBluetooth.Device) => {
    await execAsync(`bluetoothctl disconnect ${device.address}`)
    device.disconnect_device((_, res) => {
        device.disconnect_device_finish(res);
    });
}

const bluetooth = AstalBluetooth.get_default();
const BluetoothButtons = ({device, connected, connecting, paired}: {device: AstalBluetooth.Device, connected: boolean, connecting: boolean, paired: boolean}) => {
    if(!paired) {
        return <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
            <IconButton className={undefined} icon_name="blueman-pair-symbolic" pixel_size={24} onClicked={() => {
                pair_device(device);
            }} />
        </box>
    } 

    if(connecting) {
        return <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
            <Gtk.Spinner spinning width_request={32} height_request={32}/>
        </box>
    }

    if(!connected) {
        return <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
            <IconButton className={undefined} icon_name="plus-symbolic" pixel_size={24} onClicked={() => {
                connect_device(device);
            }} />
            <IconButton className={undefined} icon_name="minus-symbolic" pixel_size={24} onClicked={() => {
                bluetooth.adapter.remove_device(device);
            }} />
        </box>
    }


    return <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
        <IconButton className={undefined} icon_name="minus-symbolic" pixel_size={24} onClicked={() => {
            disconnect_device(device);
        }} />
    </box>
}

@register()
export class MarqueeLabel extends Gtk.Label {

    @property(Number)
    private offset: number = 0;
    @property(Number)
    private timeoutId: number = 0;
    @property(Boolean)
    private needsScroll: boolean = false;
    @property(Number)
    private dir: number = -0.25;

    constructor(props: { label: string | Accessor<string>, cssClass?: string }) {
        super({
            label: props.label instanceof Accessor ? (props.label.get()) : (props.label),
            ellipsize: Pango.EllipsizeMode.NONE,
            xalign: 0,
            halign: Gtk.Align.FILL,
            hexpand: true,
        });
        if (props.cssClass) {
            this.add_css_class(props.cssClass);
        }

        if(props.label instanceof Accessor) {
            props.label.subscribe(() => {
                this.set_label((props.label as Accessor<string>).get())
            })
        }
    }

    vfunc_size_allocate(width: number, height: number, baseline: number) {
        // Call parent first to store allocation
        super.vfunc_size_allocate(width, height, baseline);

        // Now the widget has a real allocation
        this._resetMarquee();
    }

    private _updateMarquee() {
        if (!this.get_realized()) return GLib.SOURCE_REMOVE;

        const alloc = this.get_allocation();
        const nat = super.vfunc_measure(Gtk.Orientation.HORIZONTAL, 1000)[0];

        this.needsScroll = nat > alloc.width;

        if (this.needsScroll) {
            this.timeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, 30, () => {
                const maxOffset = nat - alloc.width;
                if ((this.offset < -maxOffset && this.dir < 0) || (this.offset > 0 && this.dir > 0)) {
                    this.dir *= -1;
                    GLib.timeout_add(GLib.PRIORITY_DEFAULT, 1000, this._updateMarquee.bind(this))
                    if(this.dir < 0) {
                        this.offset = 0;
                    }
                    if(this.dir > 0) {
                        this.offset = -maxOffset;
                    }
                    this.queue_draw();
                    return GLib.SOURCE_REMOVE;
                } else {
                    this.offset += this.dir * nat/75;
                }
                this.queue_draw();
                return GLib.SOURCE_CONTINUE;
            });
        }
        
        return GLib.SOURCE_REMOVE;
    }

    private _resetMarquee() {
        if (this.timeoutId) {
            GLib.source_remove(this.timeoutId);
            this.timeoutId = 0;
        }
        this.offset = 0;

        GLib.idle_add(GLib.PRIORITY_DEFAULT_IDLE, this._updateMarquee.bind(this));
    }

    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        function easeInOut(t: number) {
            return t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2;
        }
        const alloc = this.get_allocation();
        const nat = super.vfunc_measure(Gtk.Orientation.HORIZONTAL, 1000)[0];
        const maxOffset = nat - alloc.width;
        if (this.needsScroll) {
            const progress = Math.min(Math.max(-this.offset / maxOffset, 0), 1);
            const easedProgress = easeInOut(progress);

            const easedOffset = -easedProgress * maxOffset;
            const transform = new Gsk.Transform().translate(
                new Graphene.Point({ x: easedOffset, y: 0 })
            );
            snapshot.transform(transform);
            super.vfunc_snapshot(snapshot);
        } else {
            const text_width = super.vfunc_measure(Gtk.Orientation.HORIZONTAL, -1)[0];
            console.log(text_width, alloc.width);
            const transform = new Gsk.Transform().translate(
                new Graphene.Point({ x: (alloc.width - text_width) / 2, y: 0 })
            );
            snapshot.transform(transform);
            super.vfunc_snapshot(snapshot);
        }
    }

    vfunc_measure(orientation: Gtk.Orientation, for_size: number): [number, number, number, number] {
        const [a, b, c, d] = super.vfunc_measure(orientation, for_size);

        console.log(a, b, c, d);

        console.log("O: " + orientation);
        
        if(orientation === Gtk.Orientation.HORIZONTAL) {
            return [100, for_size > 0 ? for_size : 100, -1, -1]
        }
        return [a, b, c, d]
    }
}

const WrappedMarqueeLabel = ({label, cssClass}: {label: string | Accessor<string>, cssClass?: string}) => {
    const marquee = new MarqueeLabel({
        label,
        cssClass: cssClass || "",
    });

    return <box hexpand overflow={Gtk.Overflow.HIDDEN}>
        {marquee}
    </box>
}

const BluetoothDeviceCard = ({device}: {device: AstalBluetooth.Device}) => {

    const statusData = createComputed([
        createBinding(device, "connected"),
        createBinding(device, "connecting"),
        createBinding(device, "paired"),
    ], (a, b, c) => ({
        connected: a,
        connecting: b,
        paired: c,
    }))

    return <box spacing={10} orientation={Gtk.Orientation.HORIZONTAL} vexpand={false} valign={Gtk.Align.START} class="top-section">
        <image icon_name={createBinding(device, "icon").as(i => i ? (i.includes("symbolic") ? i : `${i}-symbolic`) : "bluetooth-active-symbolic")} pixel_size={32} />
        <box orientation={Gtk.Orientation.VERTICAL} hexpand valign={Gtk.Align.CENTER}>
            <WrappedMarqueeLabel cssClass="connectable-title" label={createBinding(device, "name").as(name => name ? (name.length > 25 ? name.substring(0, 25) + "..." : name) : "Unknown Network")} />
            <label label={createComputed([
                createBinding(device, "connected"),
                createBinding(device, "connecting"),
                createBinding(device, "paired"),
            ], state)} />
            <With value={createBinding(device, "battery_percentage")}>
                {(percentage: number) => percentage == -1 ? <box /> :
                    <label label={`${Math.round(percentage * 100)}%`} />
                }
            </With>
        </box>
        <With value={statusData}>
            {statusData => <Astal.Bin width_request={50} height_request={75}>
                <BluetoothButtons device={device} {...statusData}/>
            </Astal.Bin>}
        </With>
    </box>
}

const score = (device: AstalBluetooth.Device) => {
    if(device.connected) return 3;
    if(device.connecting) return 2;
    if(device.paired) return 1;

    return 0;
}

const state = (connected: boolean, connecting:boolean, paired:boolean) => {
    if(connected) return "Connected";
    if(connecting) return "Connecting";
    if(paired) return "Paired";
    return "New Device";
}

const BluetoothPage = ({name}: {name: string}) => {
    const [devices, setDevices] = createState<AstalBluetooth.Device[]>(bluetooth.devices);

    bluetooth.connect("device-added", (b, d) => {
        if(!d.name) return;
        if(devices.get().findIndex(d2 => d2.address == d.address) >= 0) {
            console.log(`The device ${d.name} is already in the list`);
            return;
        }
        setDevices([...devices.get(), d].sort((a, b) => score(b) - score(a)));
    })

    bluetooth.connect("device-removed", (b, d) => {
        setDevices(devices.get().filter(d2 => d2.address !== d.address));
    })

    const InfoColumn = <box hexpand orientation={Gtk.Orientation.VERTICAL} spacing={10}>
        <label hexpand halign={Gtk.Align.CENTER} label="Bluetooth" class="toggle-label" />
        <box hexpand valign={Gtk.Align.CENTER} class="top-section" orientation={Gtk.Orientation.VERTICAL}>
            <box hexpand spacing={10} height_request={48}>
                <label hexpand halign={Gtk.Align.START} label="Enable:" />
                <Gtk.Switch halign={Gtk.Align.END} valign={Gtk.Align.CENTER} active={bluetooth.adapter.powered} $={(self) => {
                        bluetooth.adapter.connect("notify::powered", (e) => {
                            self.set_active(e.powered);
                        })
                    }} onNotifyActive={(e) => {
                    bluetooth.adapter.set_powered(e.active);
                }}/>
            </box>
            <box hexpand spacing={10} height_request={48}>
                <label hexpand halign={Gtk.Align.START} label="Discoverable:" />
                <Gtk.Switch halign={Gtk.Align.END} valign={Gtk.Align.CENTER} active={bluetooth.adapter.discoverable} $={(self) => {
                    bluetooth.adapter.connect("notify::discoverable", (e) => {
                        self.set_active(e.discoverable);
                    })
                }} onNotifyActive={(e) => {
                        execAsync(`bluetoothctl discoverable ${e.active ? "on" : "off"}`)
                }}/>
            </box>
            <box orientation={Gtk.Orientation.HORIZONTAL} height_request={48} hexpand>
                <With value={createBinding(bluetooth.adapter, "discovering")}>
                    {discovering => <box hexpand>
                        <label halign={Gtk.Align.START} hexpand label="Scan:" />
                        {discovering ? 
                            <Gtk.Spinner halign={Gtk.Align.END} spinning width_request={16} height_request={16}/> :
                            <IconButton halign={Gtk.Align.END} className="" icon_name="view-refresh-symbolic" pixel_size={16} onClicked={() => {
                                bluetooth.adapter.start_discovery();
                                setTimeout(() => {
                                    bluetooth.adapter.stop_discovery();
                                }, 5E3)
                            }} />
                        }
                    </box>}
                </With>
            </box>
            <box height_request={48}>
                <label label="Hostname:" hexpand halign={Gtk.Align.START} />
                <label halign={Gtk.Align.END} label={createBinding(bluetooth, "adapter").as(a => `${a.name}`)} class="details"/>
            </box>
        </box>
    </box>

    const ListColumn = <box hexpand vexpand>
        <With value={createBinding(bluetooth.adapter, "powered")}>
        { 
            (powered: boolean) => powered && <scrolledwindow hexpand vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC} hscrollbar_policy={Gtk.PolicyType.NEVER}> 
                <box orientation={Gtk.Orientation.VERTICAL} spacing={20}>
                    <For each={devices.as(d => d.filter(d => d.name))}>
                        {(device: AstalBluetooth.Device) => <BluetoothDeviceCard device={device} />}
                    </For>
                </box>
            </scrolledwindow>
        }
        </With>
    </box>

    const Grid = Gtk.Grid.new();
    Grid.name = name;
    Grid.column_homogeneous = true;
    Grid.column_spacing = 10;
    Grid.margin_top = 10;
    Grid.margin_bottom = 10;
    Grid.attach(InfoColumn as Gtk.Widget, 0, 0, 1, 1);
    Grid.attach(ListColumn as Gtk.Widget, 1, 0, 1, 1);

    return Grid;
}

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


    if(wifi) {
        console.log(wifi.get_device().get_active_connection().get_ip4_config().get_addresses().map(a => a.get_address()))
    }
    
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
            <WrappedMarqueeLabel label={createBinding(ap, "ssid").as(name => name ? (name.length > 25 ? name.substring(0, 25) + "..." : name) : "Unknown")} cssClass="connectable-title" />
            <label label={createBinding(ap, "requires_password").as(p => p ? "Secured" : "Open")} />
        </box>
        <box width_request={50} height_request={75} orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
                <IconButton className={undefined} icon_name="plus-symbolic" pixel_size={24} onClicked={() => {
                }} />
                <IconButton className={undefined} icon_name="minus-symbolic" pixel_size={24} onClicked={() => {
                }} />
        </box>
    </box>
}

function unique<T>(list: T[], id: (arg0: T) => string) {
    return list.filter((e, i, l) => l.findIndex(e2 => id(e) === id(e2)) === i);
}

const NetworkList = ({wifi}: {wifi: AstalNetwork.Wifi}) => {
    const aps = createBinding(wifi, "access_points").as(aps => unique(aps.sort((a, b) => b.strength - a.strength), ap => ap.ssid));
    const active_ssid = createBinding(wifi, "ssid");

    const connectable = createComputed([aps, active_ssid], (aps, active_ssid) => aps.filter(a => a.ssid !== active_ssid));

    return <box hexpand>
        <With value={createBinding(wifi, "enabled")}>
        { 
            (powered: boolean) => powered && <scrolledwindow hexpand vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC} hscrollbar_policy={Gtk.PolicyType.NEVER}> 
                <box orientation={Gtk.Orientation.VERTICAL} spacing={20}>
                    <For each={connectable}>
                        {(ap: AstalNetwork.AccessPoint) => <NetworkAPCard ap={ap} />}
                    </For>
                </box>
            </scrolledwindow>
        }
        </With>
    </box>

}

type Subpage = {
    icon: string,
    idx: number,
    widget: JSX.Element,
}

const NetworkPage = ({name}: {name: string}) => {
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
            {wifi => <NetworkDetails wifi={wifi} />}
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
    Grid.column_spacing = 10;
    Grid.margin_top = 10;
    Grid.margin_bottom = 10;
    Grid.attach(InfoColumn as Gtk.Widget, 0, 0, 1, 1);
    Grid.attach(ListColumn as Gtk.Widget, 1, 0, 1, 1);

    return Grid;
} 

const ClockPage = ({name}: {name: string}) => {
    const time = createPoll("00", 1000, `date +"%H:%M"`)
    const second = createPoll("00", 1000, `date +"%S"`)
    const date = createPoll("", 500, `date +"%A %B %d, %Y"`)
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
            <box margin_top={10} margin_bottom={10} class="top-submenu-selector">
                <Gtk.FlowBox max_children_per_line={1}>
                    <IconButton valign={Gtk.Align.CENTER} className={page.as(p => p === 0 ? "top-menu-selected-tab" : "")} icon_name="clock-app-symbolic" pixel_size={24} onClicked={() => setPage(0)} />
                    <IconButton valign={Gtk.Align.CENTER} className={page.as(p => p === 1 ? "top-menu-selected-tab" : "")} icon_name="text-calendar-symbolic" pixel_size={24} onClicked={() => setPage(1)} />
                    <IconButton valign={Gtk.Align.CENTER} className={page.as(p => p === 2 ? "top-menu-selected-tab" : "")} icon_name="stopwatch-symbolic" pixel_size={24} onClicked={() => setPage(2)} />
                    <IconButton valign={Gtk.Align.CENTER} className={page.as(p => p === 3 ? "top-menu-selected-tab" : "")} icon_name="tools-timer-symbolic" pixel_size={24} onClicked={() => setPage(3)} />
                </Gtk.FlowBox>
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


@register()
export class Point extends GObject.Object {
    // Annotate $gtype for custom subclasses
    declare static $gtype: GObject.GType<Point>;

    @property(Number)
    x: number = 0;

    @property(Number)
    y: number = 0;

    constructor(params: Partial<Point> = {}) {
        super();
        this.x = params.x || 0;
        this.y = params.y || 0;
    }
}

@register()
class PointsList extends GObject.Object {
    declare static $gtype: GObject.GType<PointsList>;

    points: Point[] = [];

    constructor(list: Point[]) {
        super();
        this.points = list;
    }
}

@register()
class NumberArray extends GObject.Object {
    declare static $gtype: GObject.GType<NumberArray>;

    elements: number[] = [];

    constructor(list: number[]) {
        super();
        this.elements = list;
    }
}

function isAccessor<T>(value: any): value is Accessor<T> {
  return value && typeof value.get === "function" && typeof value.subscribe === "function";
}

type LineGraphProps = {points: PointsList | Accessor<PointsList>, xAxis: NumberArray, className: string | Accessor<string>, graphColor: string | Accessor<string>, axisColor: string | Accessor<string>};

// Register the widget so it has a proper GType
@register()
class LineGraphWidget extends Gtk.DrawingArea {

    @property(PointsList)
    private points: PointsList;

    @property(NumberArray)
    private xAxis: NumberArray

    @property(Number)
    private yMin: number = 0;
    @property(Number)
    private yMax: number = 100;

    @property(Number)
    private padding: number = 20;

    @property(String)
    private graphColor: string;
    @property(String)
    private axisColor: string = "#888888";

    constructor(props: LineGraphProps) {
        super();

        if(isAccessor(props.points)) {
            console.log('test');
            this.points = props.points.get();
            props.points.subscribe(() => {
                // @ts-ignore-next-line
                this.points = props.points.get();
                this.queue_draw();
            })
        } else {
            this.points = props.points;
        }
        if(isAccessor(props.className)) {
            this.cssClasses = props.className.get().split(" ");
            props.className.subscribe(() => {
                // @ts-ignore-next-line
                this.cssClasses = props.className.get().split(" ");
                this.queue_draw();
            });
        } else {
            this.cssClasses = props.className.split(" ");
        }
        if(isAccessor(props.graphColor)) {
            this.graphColor = props.graphColor.get();
            props.graphColor.subscribe(() => {
                // @ts-ignore-next-line
                this.graphColor = props.graphColor.get();
                console.log("Changed graph color");
                this.queue_draw();
            })
        } else {
            this.graphColor = props.graphColor;
        }
        if(isAccessor(props.axisColor)) {
            this.axisColor = props.axisColor.get();
            props.axisColor.subscribe(() => {
                // @ts-ignore-next-line
                this.axisColor = props.axisColor.get();
                this.queue_draw();
            })
        } else {
            this.axisColor = props.axisColor;
        }
        this.xAxis = props.xAxis;

        this.hexpand = true;
        this.vexpand = true;
    }

    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        const width = this.get_allocated_width();
        const height = this.get_allocated_height();

        const layout = Pango.Layout.new(this.get_pango_context());

        // Scale points into widget coordinates
        const xs = this.xAxis.elements;
        const minX = Math.min(...xs);
        const maxX = Math.max(...xs);
        const minY = this.yMin;
        const maxY = this.yMax;

        const scaleX = (width - this.padding * 2) / (maxX - minX || 1);
        const scaleY = (height - this.padding * 2) / (maxY - minY || 1);

        const path = new Gsk.PathBuilder();
        const topPath = new Gsk.PathBuilder();

        let firstX = -1;
        let lastX = 0;

        // Draw vertical lines for each x
        const verticalPath = new Gsk.PathBuilder();
        for (const xp of xs) {
            const x = xp * scaleX;
            verticalPath.move_to(x + this.padding, this.padding);
            verticalPath.line_to(x + this.padding, height - this.padding * 1.5);
            const label = `${60 - xp}`;
            layout.set_text(label, label.length); // label for this line
            const point = new Graphene.Point({x: x + this.padding - layout.get_pixel_size()[0]/2, y: height - this.padding * 1.5});
            snapshot.translate(point);
            snapshot.append_layout(
                layout,
                new Gdk.RGBA({red: 0.8, green: 0.8, blue: 0.8, alpha: 1})
            );
            snapshot.translate(new Graphene.Point({x: -point.x, y: -point.y}));
        }

        const verticalStroke = new Gsk.Stroke(2.0);
        const axisColor = new Gdk.RGBA();
        axisColor.parse(this.axisColor);

        snapshot.append_stroke(verticalPath.to_path(), verticalStroke, axisColor);

        if (this.points.points.length == 0) return;

        this.points.points.forEach((p, i) => {
            let x = (p.x - minX) * scaleX + this.padding;
            const y = height - (p.y - minY) * scaleY - this.padding * 1.5; // invert y-axis
            if(i == 0) {
                x -= 2;
                firstX = x;
            }
            if(i == this.points.points.length - 1) {
                x += 2;
                lastX = x;
            }
            if (i === 0) {
                path.move_to(x, y);
                topPath.move_to(x, y);
            } else {
                path.line_to(x, y);
                topPath.line_to(x, y);
            }
        });


        // Close the path down to bottom
        path.line_to(lastX, height - this.padding * 1.5); // bottom right
        path.line_to(firstX, height - this.padding * 1.5); // bottom right
        path.close();

        const graphColor = new Gdk.RGBA();
        graphColor.parse(this.graphColor);

        snapshot.append_fill(path.to_path(), Gsk.FillRule.WINDING, graphColor);

        snapshot.append_stroke(topPath.to_path(), new Gsk.Stroke(5), axisColor);
    }
}

const LineGraph = (props: LineGraphProps) => {
    const g = new LineGraphWidget(props);

    return g;
}

const seconds_to_formatted_time = (seconds: number): string => {
    if(seconds === 0) return "Unknown";

    const hours = Math.floor(seconds / (60 * 60));
    seconds = seconds - (hours * 60 * 60);
    const minutes = Math.floor(seconds / 60);

    const minutesString = `${minutes}`.padStart(2, '0');

    return `${hours}:${minutesString}`;
}

function getStatistics(devicePath: string) {
    const bus = Gio.bus_get_sync(Gio.BusType.SYSTEM, null);

    const proxy = Gio.DBusProxy.new_sync(
        bus,
        Gio.DBusProxyFlags.NONE,
        null,
        "org.freedesktop.UPower",
        devicePath,
        "org.freedesktop.UPower.Device",
        null
    );

    const args = Variant.new("(suu)", ["charge", 0 * 2, Math.pow(2, 31) - 1]);

    const result = proxy.call_sync(
        "GetHistory",
        args,
        Gio.DBusCallFlags.NONE,
        -1,
        null
    );

    const [stats] = result.deep_unpack() as [Array<[number, number, number]>];
    return stats.map(([time, value, state]) => ({ time, value, state }));
}

const generate_points = (history: ReturnType<typeof getStatistics>, current_battery: number): Point[] => {
    const now = Math.floor(Date.now() / 1000);
    const oneHourAgo = now - 3600;

    if (history.length === 0) return new Array(61).fill(0).map((_, i) => new Point({x: i, y: current_battery}));

    // Sort history by time ascending
    const points = [...history].sort((a, b) => a.time - b.time);

    const result: Point[] = [];

    // Generate a timestamp for every minute in the past hour
    for (let t = oneHourAgo; t <= now; t += 60) {
        // Skip timestamps before the first history point
        if (t < points[0].time) {
            let point: number = -1;
            for(let i = 0; i < points.length - 1; i++) {
                if(t >= points[i + 1].time) {
                    point = i;
                    break;
                }
            }
            if(point == -1) {
                result.push(new Point({ x: (t - oneHourAgo)/60, y: current_battery }));
                continue;
            } else {
                result.push(new Point({ x: (t - oneHourAgo)/60, y: points[point].value}));
                continue;
            }
        };

        // If timestamp is after the last history point, use last value
        if (t >= points[points.length - 1].time) {
            result.push(new Point({ x: (t - oneHourAgo)/60, y: current_battery }));
            continue;
        }

        // Find surrounding points for interpolation
        let prev = points[0];
        let next = points[points.length - 1];
        for (let i = 0; i < points.length - 1; i++) {
            if (points[i].time <= t && t <= points[i + 1].time) {
                prev = points[i];
                next = points[i + 1];
                break;
            }
        }

        // Linear interpolation
        let interpValue: number;
        if (prev.time === next.time) {
            interpValue = prev.value;
        } else {
            const alpha = (t - prev.time) / (next.time - prev.time);
            interpValue = prev.value + (next.value - prev.value) * alpha;
        }

        result.push(new Point({ x: (t - oneHourAgo)/60, y: interpValue }));
    }

    return result;
}

const PCBattery = ({battery}: {battery: AstalBattery.Device}) => {
    const icon = createBinding(battery, "icon_name");
    const percentage = createBinding(battery, "percentage");
    const time_to_empty = createBinding(battery, "time_to_empty");
    const time_to_full = createBinding(battery, "time_to_full");
    const state = createBinding(battery, "state");

    const history = createExternal(new PointsList([]), (set) => {
        const update = () => {
            const history = getStatistics(`/org/freedesktop/UPower/devices/battery_${battery.native_path}`).filter(d => d.value !== 0);
            set(new PointsList(generate_points(history, percentage.get() * 100)));
        }

        const i = setInterval(update, 1E3);

        update();

        return () => {
            clearInterval(i);
        }
    });

    const msg = createComputed([state, time_to_empty, time_to_full], (state, time_to_empty, time_to_full) => {
        switch(state) {
            case AstalBattery.State.CHARGING:
            case AstalBattery.State.PENDING_CHARGE:
                return time_to_full === 0 ? `Charging` : `Charged in: ${seconds_to_formatted_time(time_to_full)}`;
            case AstalBattery.State.DISCHARGING:
            case AstalBattery.State.PENDING_DISCHARGE:
                return time_to_empty === 0 ? `Discharging` : `Remaining: ${seconds_to_formatted_time(time_to_empty)}`;
            case AstalBattery.State.FULLY_CHARGED:
                return `Fully Charged`;
            case AstalBattery.State.EMPTY:
                return `Fully Discharged`;
            default:
                return "Unknown Battery State";
        }
    })
    
    return <box orientation={Gtk.Orientation.VERTICAL} hexpand margin_bottom={15} spacing={10}>
        <box orientation={Gtk.Orientation.HORIZONTAL} halign={Gtk.Align.CENTER} spacing={10}>
            <image icon_name={icon} pixel_size={48} />
            <label label={percentage.as(p => `${Math.round(p * 100)}%`)} class="main-battery battery" halign={Gtk.Align.CENTER} />
        </box>
        <label label={msg} halign={Gtk.Align.CENTER} />
        <box hexpand vexpand class="graph">
            <LineGraph points={history} xAxis={new NumberArray([0, 10, 20, 30, 40, 50, 60])} className="test" axisColor="#888888" graphColor={state.as(s => s === AstalBattery.State.DISCHARGING ? "#ff000044" : "#00ff0044")} />
        </box>
    </box>
}
const PCNoBattery = () => {
    return <>

    </>
}

const BatteryPage = ({name}: {name: string}) => {

    const battery = AstalBattery.UPower.new().devices.find(d => d.native_path != "" && d.device_type === AstalBattery.Type.BATTERY);

    return <box name={name} orientation={Gtk.Orientation.HORIZONTAL}>
        {/* Left side - Main device battery */}
        <box>
            {
                battery ? <PCBattery battery={battery} /> : <PCNoBattery />
            }
        </box>
        {/* Right side - Other Devices (Bluetooth, phone) */}
    </box>
}

const MusicPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="music" />
    </box>
}
