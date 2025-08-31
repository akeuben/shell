import { Gtk } from "ags/gtk4";
import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import AstalNetwork from "gi://AstalNetwork?version=0.1";
import { Accessor, createBinding, createComputed, With } from "gnim";

const bluetooth = AstalBluetooth.get_default();
const network = AstalNetwork.get_default();

export const NetworkIcon = () => {
    const wifi = network.wifi;
    const wired = network.wired;

    return <With value={createBinding(network, "primary")}>
        {value => 
            value === AstalNetwork.Primary.WIFI ? <image pixel_size={24} icon_name={createBinding(wifi, "icon_name")} /> : 
            value === AstalNetwork.Primary.WIRED ? <image pixel_size={24} icon_name={createBinding(wired, "icon_name")} /> :
            <image icon_size={Gtk.IconSize.LARGE} icon_name="network-wireless-disabled-symbolic" /> 
        }
    </With>;
}

export const BluetoothIcon = () => {
    return <image pixel_size={24} icon_name={createBinding(bluetooth, "is_powered").as(powered => powered ? "preferences-system-bluetooth-symbolic" : "preferences-system-bluetooth-inactive-symbolic")} />
}
