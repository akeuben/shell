import { Scrollable } from "astal/gtk3/widget"
import { bluetooth_state_to_icon } from "../../utils/icons"
import AstalBluetooth from "gi://AstalBluetooth?version=0.1"
import { bind } from "astal/binding";
import { Gtk } from "astal/gtk3";
import { ToggleSwitch } from "./Switch";
import { BtDevices } from "../../utils/BtDevices";
import { exec } from "astal/process";

const Toggle = () => {
    const bluetooth = AstalBluetooth.get_default();
    const powered = bind(bluetooth.adapter, "powered");
    return <box className="widget-bluetooth-toggle" vexpand={false} spacing={10}>
        <icon icon={powered.as(bluetooth_state_to_icon)} />
        <label hexpand={true} halign={Gtk.Align.START} label={powered.as(p => p ? "On" : "Off")} />
        <ToggleSwitch enabled={powered} on_click={() => bluetooth.adapter.set_powered(!bluetooth.adapter.powered)}/>
    </box>
}

const get_status_message = (device: AstalBluetooth.Device) => {
    if(device.connected) return "Connected";
    if(device.connecting) return "Connecting";
    if(device.paired) return "Paired";
    
    return "Not Paired";
}

const Device = ({adapter, device, className}: {adapter: AstalBluetooth.Adapter, device: AstalBluetooth.Device, className: string}) => {
    const action_buttons: Record<string, () => void> = {};
    if(device.connected) {
        action_buttons["list-remove-symbolic"] = () => device.disconnect_device(() => {});
    } else if(device.paired) {
        action_buttons["list-add-symbolic"] = () => device.connect_device(() => {});
        action_buttons["list-remove-symbolic"] = () => adapter.remove_device(device);
    } else {
        action_buttons["list-add-symbolic"] = () => device.connect_device(() => {});
    }
    return <box hexpand={true} className={className} spacing={10}>
        <icon icon={device.icon ? device.icon + "-symbolic" : "bluetooth-active-symbolic"} />
        <box orientation={Gtk.Orientation.VERTICAL}>
            <label label={device.name} hexpand={true} halign={Gtk.Align.START}/>
            <label label={get_status_message(device)} hexpand={true} halign={Gtk.Align.START}/>
        </box>
        {
            Object.keys(action_buttons).map(icon => <button cursor="pointer" onClickRelease={action_buttons[icon]}><icon icon={icon}/></button>)
        }
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
                    bind(devices).as(devices => devices.filter(d => d.name).map((device, i) => <Device adapter={bluetooth.adapter} device={device} className={`list-section-part ${i === 0 ? "first" : ""} ${i === devices.length - 1 ? "last" : ""}`}/>))
                }
            </box> :
            <label label="Bluetooth Disabled" />)
        }
    </>
}

export const BluetoothPageWidget = () => {
    return <Scrollable vexpand={true}>
        <box orientation={Gtk.Orientation.VERTICAL} spacing={10} css="margin-right: 10px">
            <Toggle />
            <List />
        </box>
    </Scrollable>
}
