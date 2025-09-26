import { Astal, Gtk } from "ags/gtk4";
import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import { IconButton } from "./IconButton";
import { createBinding, createComputed, createState, For, With } from "gnim";
import { WrappedMarqueeLabel } from "./Marquee";
import { execAsync } from "ags/process";

const pair_device = async (device: AstalBluetooth.Device) => {
    await execAsync(`bluetoothctl pair ${device.address}`)
    await execAsync(`bluetoothctl trust ${device.address}`)
    connect_device(device);
}

const connect_device = async(device: AstalBluetooth.Device) => {
    device.connect_device(async (_, res) => {
        try {
            device.connect_device_finish(res)
            setTimeout(() => {
                execAsync(`bluetoothctl pair ${device.address}`)
            }, 500);
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

export const BluetoothPage = ({name}: {name: string}) => {
    const [devices, setDevices] = createState<AstalBluetooth.Device[]>(bluetooth.devices);

    bluetooth.connect("device-added", (b, d) => {
        if(!d.name) return;
        if(devices.get().findIndex(d2 => d2.address == d.address) >= 0) {
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
                <box orientation={Gtk.Orientation.VERTICAL} spacing={10}>
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
    Grid.set_column_spacing(10);
    Grid.margin_top = 10;
    Grid.margin_bottom = 10;
    Grid.attach(InfoColumn as Gtk.Widget, 0, 0, 1, 1);
    Grid.attach(ListColumn as Gtk.Widget, 1, 0, 1, 1);

    return Grid;
}

