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
import { derive, execAsync } from "astal";

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
        <image icon_name={createBinding(device, "icon").as(i => i ? (i.includes("symbolic") ? i : `${i}-symbolic`) : "bluetooth-active-symbolic")} pixel_size={48} />
        <box orientation={Gtk.Orientation.VERTICAL} hexpand valign={Gtk.Align.CENTER}>
            <label label={createBinding(device, "name")} class="connectable-title" />
            <label label={createComputed([
                createBinding(device, "connected"),
                createBinding(device, "connecting"),
                createBinding(device, "paired"),
            ], state)} />
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
        setDevices([...devices.get(), d]);
    })

    bluetooth.connect("device-removed", (b, d) => {
        setDevices(devices.get().filter(d2 => d2.address !== d.address));
    })

    const connectedCount = devices.as((d) => d.filter(d => d.connected).length);

    return <box name={name} spacing={10} margin_bottom={10} margin_end={10} margin_start={10} margin_top={10}>
        <box hexpand halign={Gtk.Align.START} valign={Gtk.Align.CENTER} orientation={Gtk.Orientation.VERTICAL}>
            <box hexpand valign={Gtk.Align.CENTER} vexpand={false} class="top-section" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                <box hexpand spacing={10}>
                    <Gtk.Switch halign={Gtk.Align.START} active={bluetooth.adapter.powered} onNotifyActive={(e) => {
                        console.log(`setting powered to ${e.active}`);
                        bluetooth.adapter.set_powered(e.active);
                    }}/>
                    <label hexpand halign={Gtk.Align.CENTER} label="Bluetooth" class="toggle-label" />
                </box>
                <label halign={Gtk.Align.START} label={connectedCount.as(c => `Connected: ${c}`)} class="details"/>
                <label halign={Gtk.Align.START} label={createBinding(bluetooth, "adapter").as(a => `Hostname: ${a.name}`)} class="details" />
                <label halign={Gtk.Align.START} label={createBinding(bluetooth, "adapter").as(a => `Address: ${a.address}`)} class="details" />
                <box orientation={Gtk.Orientation.HORIZONTAL} height_request={64} hexpand>
                    <With value={createBinding(bluetooth.adapter, "discovering")}>
                        {discovering => <box halign={Gtk.Align.CENTER} hexpand>
                            {discovering ? 
                                <Gtk.Spinner spinning width_request={32} height_request={32}/> :
                                <IconButton className="" icon_name="view-refresh-symbolic" pixel_size={32} onClicked={() => {
                                    bluetooth.adapter.start_discovery();
                                    setTimeout(() => {
                                        bluetooth.adapter.stop_discovery();
                                    }, 5E3)
                                }} />
                            }
                        </box>}
                    </With>
                </box>
            </box>
        </box>
        <box hexpand halign={Gtk.Align.END}>
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
