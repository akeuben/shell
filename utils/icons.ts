import AstalNetwork from "gi://AstalNetwork?version=0.1";

export const internet_type_to_icon = (type: AstalNetwork.Primary, wifi: AstalNetwork.Wifi, wired: AstalNetwork.Wired) => {
    switch(type) {
        case AstalNetwork.Primary.WIFI:
            return wifi.iconName;
        case AstalNetwork.Primary.WIRED:
            return wired.icon_name;
        default:
            return "network-wireless-offline-symbolic";
    }
}

export const bluetooth_state_to_icon = (powered: boolean) => {
    if(!powered) {
        return "bluetooth-disabled-symbolic";
    }

    return "bluetooth-active-symbolic";
}
