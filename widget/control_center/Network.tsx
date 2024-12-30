import { Scrollable } from "gjs/gtk3/widget"
import { bind } from "gjs/binding";
import { App, Gdk, Gtk } from "gjs/gtk3";
import { ToggleSwitch } from "./Switch";
import AstalNetwork from "gi://AstalNetwork?version=0.1";
import Variable from "gjs/variable";
import NM from "gi://NM?version=1.0";
import { execAsync } from "gjs/process";

const get_state_description = (state: AstalNetwork.DeviceState) => {
    switch(state) {
        case AstalNetwork.DeviceState.ACTIVATED:
            return "Connected";
        case AstalNetwork.DeviceState.FAILED:
            return "Failed to Connect";
        case AstalNetwork.DeviceState.NEED_AUTH:
            return "Requires Authentication";
        case AstalNetwork.DeviceState.IP_CHECK:
        case AstalNetwork.DeviceState.IP_CONFIG:
            return "Aquiring IP";
        case AstalNetwork.DeviceState.UNKNOWN:
        case AstalNetwork.DeviceState.DISCONNECTED:
            return "Disconnected";
        case AstalNetwork.DeviceState.UNMANAGED:
            return "Unmanaged";
        case AstalNetwork.DeviceState.DEACTIVATING:
            return "Disconnecting...";
        default:
            return "Connecting...";
    }
}

const Toggle = () => {
    const network = AstalNetwork.get_default();
    const wifi_icon = bind(network.wifi, "icon_name");
    const wired_icon = bind(network.wired, "icon_name");

    const wired_state = bind(network.wired, "state").as(get_state_description);
    const wifi_state = Variable.derive([bind(network.wifi, "enabled"), bind(network.wifi, "state")], (enabled, state) => enabled ? get_state_description(state) : "Disabled");

    const wifi_active = Variable.derive([bind(network.wifi, "enabled"), bind(network.wifi, "state"), bind(network.wifi, "ssid")], (enabled, state, ssid) => {
        if(!enabled) return false;
        if(state === AstalNetwork.DeviceState.DISCONNECTED || AstalNetwork.DeviceState.UNKNOWN) return false;
        if(!ssid) return;

        return true;
    })

    return <>
        {bind(network, "wired").as(wired => wired && <box className="widget-wifi-toggle" vexpand={false} spacing={10}>
            <icon icon={wired_icon} />
            <label hexpand={true} halign={Gtk.Align.START} label={wired_state} />
        </box>)}
        {bind(network, "wifi").as(wifi => wifi && <box className="widget-wifi-toggle" vexpand={false} spacing={10}>
            <icon icon={wifi_icon} />
            <box hexpand={true} halign={Gtk.Align.START} orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
                {wifi_active().as(active => active ? <label halign={Gtk.Align.START} label={bind(network.wifi, "ssid").as(ssid => ssid ? ssid : "Unknown")} /> : <></>)}
                <label halign={Gtk.Align.START} label={wifi_state()} />
            </box>
            <ToggleSwitch enabled={bind(network.wifi, "enabled")} on_click={() => network.wifi.set_enabled(!network.wifi.enabled)}/>
        </box>)}
    </>
}

const connect = (ap: AstalNetwork.AccessPoint, monitor: Gdk.Monitor, password?: string) => {
    execAsync(`nmcli device wifi connect "${ap.ssid}"${password ? ` password ${password}` : ""}`).catch((err: string) => {
        if(err.toString().includes("Secrets")) {
            execAsync(["ags", "request", JSON.stringify({
                monitor: App.get_monitors().indexOf(monitor),
                type: "network-auth",
                ssid: ap.ssid
            })]).then(result => result ? connect(ap, monitor, result) : {})
                .catch(er => console.error(er))
        }
    })
}

const AccessPoint = ({ap, className, monitor}: {ap: AstalNetwork.AccessPoint, className: string, monitor: Gdk.Monitor}) => {
    return <box hexpand={true} className={className} spacing={10}>
        <icon icon={ap.icon_name} />
        <box orientation={Gtk.Orientation.VERTICAL}>
            <label label={ap.ssid} hexpand={true} halign={Gtk.Align.START}/>
            <label label="Disconnected" hexpand={true} halign={Gtk.Align.START}/>
        </box>
        <button onClickRelease={() => {
            connect(ap, monitor);
        }}><icon icon="list-add-symbolic"/></button>
    </box>
}

const List = ({monitor}: {monitor: Gdk.Monitor}) => {
    const network = AstalNetwork.get_default();
    const powered = bind(network.wifi, "enabled");
    const aps = bind(network.wifi, "access_points").as(aps => [...new Map(aps.map(ap => [ap.ssid, ap])).values()]);

    const disconnected_aps = Variable.derive([aps, bind(network.wifi, "ssid")], (aps, ssid) => aps.filter(ap => ap.ssid !== ssid && ap.ssid));

    return <>
        { powered.as(powered => powered ? 
            <box orientation={Gtk.Orientation.VERTICAL} spacing={3}>
                {
                    disconnected_aps().as(aps => aps.map((ap, i) => <AccessPoint ap={ap} className={`list-section-part ${i === 0 ? "first" : ""} ${i === aps.length - 1 ? "last" : ""}`} monitor={monitor}/>))
                }
            </box> :
            <label label="Bluetooth Disabled" />)
        }
    </>
}

export const NetworkPageWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    return <Scrollable vexpand={true}>
        <box orientation={Gtk.Orientation.VERTICAL} spacing={10} css="margin-right: 10px">
            <Toggle />
            <List monitor={monitor} />
        </box>
    </Scrollable>
}
