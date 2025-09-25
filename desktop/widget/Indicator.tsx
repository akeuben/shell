import { Astal, Gtk } from "ags/gtk4";
import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import AstalNetwork from "gi://AstalNetwork?version=0.1";
import { Accessor, createBinding, createComputed, With } from "gnim";

const bluetooth = AstalBluetooth.get_default();
const network = AstalNetwork.get_default();

const InternalNetworkIcon = ({network}: {network: AstalNetwork.Wifi | AstalNetwork.Wired}) => {
    const device = createBinding(network, "device");
    
    return <Astal.Bin>
        <With value={device}>
            {device => {
                return device ? <image pixel_size={24} icon_name={createBinding(network, "icon_name")} />
                : <></>
            }}
        </With>
    </Astal.Bin>
}

export const NetworkIcon = () => {
    const wifi = createBinding(network, "wifi");
    const wired = createBinding(network, "wired");

    return <Astal.Bin>
        <With value={createBinding(network, "primary")}>
            {value => <Astal.Bin>
                {
                    value === AstalNetwork.Primary.WIFI ? <With value={wifi}>{n => <InternalNetworkIcon network={n} />}</With> : 
                    value === AstalNetwork.Primary.WIRED ? <With value={wired}>{n => <InternalNetworkIcon network={n} />}</With> :
                    <image pixel_size={24} icon_name="network-wireless-connected-00-symbolic" /> 
                }
                </Astal.Bin>
            }
        </With>
    </Astal.Bin>;
}

export const BluetoothIcon = () => {
    return <image pixel_size={24} icon_name={createBinding(bluetooth, "is_powered").as(powered => powered ? "preferences-system-bluetooth-symbolic" : "preferences-system-bluetooth-inactive-symbolic")} />
}
