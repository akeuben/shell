import AstalNetwork from "gi://AstalNetwork?version=0.1"
import Binding, { bind } from "gjs/binding"
import { Gtk } from "gjs/gtk3"
import Variable from "gjs/variable"
import { bluetooth_state_to_icon, internet_type_to_icon } from "../../utils/icons"
import AstalBluetooth from "gi://AstalBluetooth?version=0.1"
import { BtDevices } from "../../utils/BtDevices"
import AstalNotifd from "gi://AstalNotifd?version=0.1"
import AstalWp from "gi://AstalWp?version=0.1"

const MAX_TITLE_LENGTH = 14;

const ActionButton = ({is_active, click_action, icon, title, className}: {is_active: boolean | Binding<boolean>, click_action: () => void, icon: string | Binding<string>, title: string | Binding<string>, className?: string}) => {
    const get_class = (is_active: boolean | Binding<Boolean>) => {
        if(typeof is_active === "boolean") {
            return `widget-action-button ${className || ""} ${is_active ? "active" : ""}`;
        }

        return is_active.as(a => `widget-action-button ${className || ""} ${a ? "active" : ""}`);
    } 
    const get_title = (title: string | Binding<string>) => {
        if(typeof title === "string") {
            return title.substring(0, MAX_TITLE_LENGTH) + (title.length > MAX_TITLE_LENGTH ? "..." : "");
        }

        return title.as(t => t.substring(0, MAX_TITLE_LENGTH) + (t.length > MAX_TITLE_LENGTH ? "..." : ""));
    }
    return <button cursor="pointer" className={get_class(is_active)} onClick={click_action}>
        <box spacing={10}>
            <label label={icon} />
            <label label={get_title(title)} hexpand={true} halign={Gtk.Align.START} />
            <label label="󰐊" />
        </box>
    </button>
}

const ToggleButton = ({is_active, click_action, title, icon, className}: {is_active: boolean | Binding<boolean>, click_action: () => void, icon: string | Binding<string>, title: string | Binding<string>, className?: string}) => {
    const get_class = (is_active: boolean | Binding<Boolean>) => {
        if(typeof is_active === "boolean") {
            return `widget-action-button ${className || ""} ${is_active ? "active" : ""}`;
        }

        return is_active.as(a => `widget-action-button ${className || ""} ${a ? "active" : ""}`);
    } 
    const get_title = (title: string | Binding<string>) => {
        if(typeof title === "string") {
            return title.substring(0, MAX_TITLE_LENGTH) + (title.length > MAX_TITLE_LENGTH ? "..." : "");
        }

        return title.as(t => t.substring(0, MAX_TITLE_LENGTH) + (t.length > MAX_TITLE_LENGTH ? "..." : ""));
    }
    return <button cursor="pointer" className={get_class(is_active)} onClick={click_action}>
        <box spacing={10}>
            <label label={icon} />
            <label label={get_title(title)} hexpand={true} halign={Gtk.Align.START} />
        </box>
    </button>
}

const network_name = (internet_type: AstalNetwork.Primary, wifi: AstalNetwork.Wifi) => {
    if(internet_type === AstalNetwork.Primary.WIRED) {
        return "Ethernet";
    }
    if(internet_type === AstalNetwork.Primary.UNKNOWN) {
        return "Disconnected";
    }

    return wifi.ssid;
}

const get_bluetooth_name = (devices: AstalBluetooth.Device[]) => {
    const connected = devices.filter(device => device.connected);

    if(connected.length === 0) {
        return "Bluetooth";
    }

    return connected[0].name;
}

export const InternetButton = () => {
    const internet = AstalNetwork.get_default();
    const internet_type = bind(internet, "primary");
    const wifi = bind(internet, "wifi");
    const internet_icon = Variable.derive([internet_type, wifi], (type, wifi) => internet_type_to_icon(type, wifi));
    const internet_name = Variable.derive([internet_type, wifi], (type, wifi) => network_name(type, wifi));
    return <ActionButton is_active={bind(internet, "connectivity").as(c => 
        [AstalNetwork.Connectivity.FULL, AstalNetwork.Connectivity.LIMITED, AstalNetwork.Connectivity.PORTAL].includes(c)
    )} click_action={() => {}} icon={internet_icon()} title={internet_name()}/>
}

export const BluetoothButton = ({on_click}: {on_click: () => void}) => {
    const bluetooth = AstalBluetooth.get_default();
    const devices = new BtDevices();
    const bluetooth_icon = bind(bluetooth.adapter, "powered").as(bluetooth_state_to_icon);
    const bluetooth_name = bind(devices).as(get_bluetooth_name);

    return <ActionButton is_active={bind(bluetooth.adapter, "powered")} click_action={on_click} icon={bluetooth_icon} title={bluetooth_name}/>
}

export const DNDButton = () => {
    const notifd = AstalNotifd.get_default();

    return <ToggleButton is_active={bind(notifd, "dont_disturb")} click_action={() => notifd.set_dont_disturb(!notifd.dontDisturb)} title="Do Not Disturb" icon="󰽥" className="dnd"/>
}

export const MicMuteButton = () => {
    const audio = AstalWp.get_default();
    if(!audio) return <></>
    const muted = bind(audio.default_microphone, "mute");

    return <ToggleButton is_active={muted.as(m => !m)} click_action={() => audio.default_microphone.set_mute(!audio.default_microphone.mute)} title={muted.as(m => `Mic is ${m ? "Off" : "On"}`)} icon={muted.as(m => m ? "󰍭 " : "󰍬 ")}/>
}
