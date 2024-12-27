import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import AstalNetwork from "gi://AstalNetwork?version=0.1";

export const strength_to_icon = (icon_set: string[], strength: number) => {
    strength = strength / 100 * icon_set.length;
    strength = Math.ceil(strength);

    if(strength >= icon_set.length) {
        strength = icon_set.length - 1;
    }
    if(strength < 0) strength = 0;

    return icon_set[strength];
}

export const internet_type_to_icon = (type: AstalNetwork.Primary, wifi: AstalNetwork.Wifi) => {
    switch(type) {
        case AstalNetwork.Primary.WIFI:
            return strength_to_icon(["󰤯 ", "󰤟 ", "󰤢 ", "󰤥 ", "󰤨 "], wifi.strength)
        case AstalNetwork.Primary.WIRED:
            return "󰲝 ";
        default:
            return "󰤭 ";
    }
}

export const bluetooth_state_to_icon = (powered: boolean) => {
    if(!powered) {
        return "󰂲";
    }

    return "󰂯";
}

export const audio_state_to_icon = (volume: number | null, mute: boolean) => {
    if(volume === null || mute) return "󰖁 ";

    return strength_to_icon(["󰝟 ", "󰕿 ", "󰖀 ", "󰕾 "], volume);
}

