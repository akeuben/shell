import { Scrollable } from "gjs/gtk3/widget"
import { bluetooth_state_to_icon } from "../../utils/icons"
import AstalBluetooth from "gi://AstalBluetooth?version=0.1"
import { bind } from "gjs/binding";
import { Gtk } from "gjs/gtk3";
import { ToggleSwitch } from "./Switch";
import { BtDevices } from "../../utils/BtDevices";

const Toggle = () => {
    const bluetooth = AstalBluetooth.get_default();
    const powered = bind(bluetooth.adapter, "powered");
    return <box className="widget-bluetooth-toggle" vexpand={false} spacing={10}>
        <label label={powered.as(bluetooth_state_to_icon)} />
        <label hexpand={true} halign={Gtk.Align.START} label={powered.as(p => p ? "On" : "Off")} />
        <ToggleSwitch enabled={powered} on_click={() => bluetooth.adapter.set_powered(!bluetooth.adapter.powered)}/>
    </box>
}

const get_status_message = (device: AstalBluetooth.Device) => {
    if(device.connected) return "Connected";
    if(device.connecting) return "Connecting";
    if(device.trusted) return "Trusted";
    if(device.paired) return "Paired";
    
    return "Not Paired";
}

const Device = ({device, className}: {device: AstalBluetooth.Device, className: string}) => {
    return <box hexpand={true} className={className} spacing={10}>
        <icon icon={device.icon} />
        <box orientation={Gtk.Orientation.VERTICAL}>
            <label label={device.name} hexpand={true} halign={Gtk.Align.START}/>
            <label label={get_status_message(device)} hexpand={true} halign={Gtk.Align.START}/>
        </box>
        <button cursor="pointer" onClickRelease={() => device.connect_device(() => {})}><label label="󱘖 " /></button>
    </box>
}

const List = () => {
    const bluetooth = AstalBluetooth.get_default();
    const powered = bind(bluetooth.adapter, "powered");
    const devices = new BtDevices();

    return <>
        { powered.as(powered => powered ? 
            <box orientation={Gtk.Orientation.VERTICAL} spacing={3}>
                {
                    bind(devices).as(devices => devices.map((device, i) => <Device device={device} className={`list-section-part ${i === 0 ? "first" : ""} ${i === devices.length - 1 ? "last" : ""}`}/>))
                }
            </box> :
            <label label="Bluetooth Disabled" />)
        }
    </>
}

export const BluetoothPageWidget = () => {
    return <Scrollable vexpand={true}>
        <box orientation={Gtk.Orientation.VERTICAL} spacing={10} marginRight={10}>
            <Toggle />
            <List />
        </box>
    </Scrollable>
}
