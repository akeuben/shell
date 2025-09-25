import { Gtk } from "ags/gtk4";
import { Gio } from "astal";
import AstalBattery from "gi://AstalBattery?version=0.1";
import { Accessor, createBinding, createComputed, createExternal } from "gnim";
import { Variant } from "gnim/dbus";
import { LineGraph, NumberArray, Point, PointsList } from "./LineGraph";

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

export const BatteryPage = ({name}: {name: string}) => {

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

const seconds_to_formatted_time = (seconds: number): string => {
    if(seconds === 0) return "Unknown";

    const hours = Math.floor(seconds / (60 * 60));
    seconds = seconds - (hours * 60 * 60);
    const minutes = Math.floor(seconds / 60);

    const minutesString = `${minutes}`.padStart(2, '0');

    return `${hours}:${minutesString}`;
}

