import AstalBattery from "gi://AstalBattery?version=0.1";
import { bind } from "gjs/binding";

export const BatteryWidget = () => {
    const battery = AstalBattery.get_default();

    if(battery.device_type != AstalBattery.Type.BATTERY || !battery.powerSupply) {
        return <></>
    }

    return <box className="bar-section accent-background" spacing={10}>
        <icon icon={bind(battery, "icon_name")} />
        <label label={bind(battery, "percentage").as(p => `${Math.round(p * 100)}%`)} />
    </box>
}
