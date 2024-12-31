import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import AstalNetwork from "gi://AstalNetwork?version=0.1";
import AstalNotifd from "gi://AstalNotifd?version=0.1";
import Tray from "gi://AstalTray";
import AstalWp from "gi://AstalWp?version=0.1";
import Binding, { bind } from "gjs/binding";
import { App, Astal, Gdk, Gtk } from "gjs/gtk3";
import Variable from "gjs/variable";
import { bluetooth_state_to_icon, internet_type_to_icon } from "../../utils/icons";

const StatusBar = ({monitor}: {monitor: Gdk.Monitor}) => {
    const network = AstalNetwork.get_default();
    const bluetooth = AstalBluetooth.get_default();
    const wp = AstalWp.get_default();

    const internet_type = bind(network, "primary");
    const wifi = bind(network, "wifi");
    const wifi_icon = bind(network.wifi, "icon_name");
    const wired = bind(network, "wired");
    const wired_icon = network.wired ? bind(network.wired, "icon_name") : Variable("")();
    const internet_icon = Variable.derive([internet_type, wifi, wired, wifi_icon, wired_icon], (type, wifi, wired) => internet_type_to_icon(type, wifi, wired));

    const window = App.get_window(`control-center-${App.get_monitors().indexOf(monitor)}`);
    if(!window) return <></>;

    let audio_icon: string | Binding<string> = "audio-volume-muted-blocking-symbolic";
    if(wp) {
        audio_icon = bind(wp.default_speaker, "volume_icon");
    }

    const bluetooth_icon = bind(bluetooth.adapter, "powered").as(bluetooth_state_to_icon);
    return <button cursor="pointer" className={bind(window, "visible").as(visible => `bar-section-part last ${visible ? "active" : ""}`)} onClickRelease={() => {
        App.toggle_window(`control-center-${App.get_monitors().indexOf(monitor)}`);
    }}>
        <box spacing={10}>
            <icon icon={internet_icon()} />
            <icon icon={bluetooth_icon} />
            <icon icon={audio_icon} />
        </box>
    </button>
}

const ApplicationEntry = ({entry}: {entry: Tray.TrayItem}) => {
    let menu = entry.create_menu();

    return <button cursor="pointer" className={`bar-section-part`} onClickRelease={(button, event) => {
        if(event.button === Astal.MouseButton.PRIMARY) {
            entry.activate(event.x, event.y);
        } else if(event.button === Astal.MouseButton.SECONDARY) {
            menu?.popup_at_widget(button, Gdk.Gravity.NORTH, Gdk.Gravity.SOUTH, null);
        }
    }}>
        <icon gicon={bind(entry, "gicon")} pixbuf={bind(entry, "icon_pixbuf").as(pixbuf => pixbuf ? pixbuf : undefined)} />
    </button>
}

const NotificationTray = () => {
    const notifd = AstalNotifd.get_default();
    
    const notifications = bind(notifd, "notifications");

    return <button className="notification-badge-area">
        <overlay>
            <label label="󰂜" hexpand={false} vexpand={false}/>
            <label className="notification-badge" hexpand={false} halign={Gtk.Align.END} vexpand={false} valign={Gtk.Align.START} label={notifications.as(n => n.length + "")} />
        </overlay>
    </button>
}

export const SystemTrayWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    const tray = Tray.get_default();

    return <box spacing={3}>
        <NotificationTray />
        {bind(tray, "items").as(items =>
            items.map((item) => <ApplicationEntry entry={item} />)
        )}
        <StatusBar monitor={monitor}/>
    </box>
}
