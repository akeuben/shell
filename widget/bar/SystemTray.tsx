import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import AstalNetwork from "gi://AstalNetwork?version=0.1";
import AstalNotifd from "gi://AstalNotifd?version=0.1";
import Tray from "gi://AstalTray";
import AstalWp from "gi://AstalWp?version=0.1";
import Binding, { bind } from "gjs/binding";
import { App, Astal, Gdk, Gtk } from "gjs/gtk3";
import Variable from "gjs/variable";
import { audio_state_to_icon, bluetooth_state_to_icon, internet_type_to_icon } from "../../utils/icons";

const StatusBar = ({monitor}: {monitor: Gdk.Monitor}) => {
    const network = AstalNetwork.get_default();
    const bluetooth = AstalBluetooth.get_default();
    const wp = AstalWp.get_default();

    const internet_type = bind(network, "primary");
    const wifi = bind(network, "wifi");
    const internet_icon = Variable.derive([internet_type, wifi], (type, wifi) => internet_type_to_icon(type, wifi));
    let volume: Binding<number | null> = new Variable(null)();
    let mute: Binding<boolean> = new Variable(false)();
    if(wp) {
        volume = bind(wp.audio.default_speaker, "volume").as(v => v * 100);
        mute = bind(wp.audio.default_speaker, "mute");
    }
    const audio_icon = Variable.derive([volume, mute], (v, m) => audio_state_to_icon(v === null ? v : (v-54) / (100-54) * 100, m));

    const bluetooth_icon = bind(bluetooth.adapter, "powered").as(bluetooth_state_to_icon);
    return <button cursor="pointer" className="bar-section-part last" onClickRelease={() => {
        App.toggle_window(`control-center-${App.get_monitors().indexOf(monitor)}`);
    }}>
        <box spacing={10}>
            <label label={internet_icon()} />
            <label label={bluetooth_icon} />
            <label label={audio_icon()} />
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
        <icon pixbuf={entry.icon_pixbuf || undefined} />
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
