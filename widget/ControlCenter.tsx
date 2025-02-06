import { Gdk, Gtk } from "gjs/gtk3";
import { BluetoothButton, DNDButton, InternetButton, MicMuteButton } from "./control_center/Button";
import { VolumeSlider } from "./control_center/Slider";
import { BluetoothPageWidget } from "./control_center/Bluetooth";
import Variable from "gjs/variable";
import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import Binding, { bind } from "gjs/binding";
import { Spinner } from "./generic/Spinner";
import { exec } from "gjs/process";
import Gtk30 from "gi://Gtk";
import AstalNetwork from "gi://AstalNetwork?version=0.1";
import { NetworkPageWidget } from "./control_center/Network";
import { PlaybackWidget } from "./control_center/Music";
import Pango from "gi://Pango?version=1.0";

const SPACING = 10;

const ControlCenterRow = ({child, children}: {children?: JSX.Element[], child?: JSX.Element}) => {
    return <box spacing={SPACING}>
        {child}
        {children}
    </box>
}

const get_greeting = () => {
    const hourOfDay = new Date().getHours();
    let time = "";
    if(hourOfDay < 3) {
        time = "Night";
    } else if(hourOfDay < 12) {
        time = "Morning";
    } else if(hourOfDay < 18) {
        time = "Afternoon"
    } else if(hourOfDay < 21) {
        time = "Evening";
    } else {
        time = "Night";
    }

    let user = exec('whoami');
    user = user[0].toUpperCase() + user.substring(1)

    return `Good ${time} ${user}!`
}

const Main = ({onBluetoothClicked, onNetworkClicked}: {onBluetoothClicked: () => void, onNetworkClicked: () => void}) => {
    const motd = new Variable(exec("cat /etc/issue"));
    
    return <box name="main" orientation={Gtk.Orientation.VERTICAL} spacing={SPACING * 2}>
        <box className="widget-page-header" hexpand={true} halign={Gtk.Align.CENTER}>
            <label label={get_greeting()} hexpand={true} halign={Gtk.Align.CENTER}/>
        </box>
        <ControlCenterRow>
            <InternetButton on_click={onNetworkClicked} />
            <BluetoothButton on_click={onBluetoothClicked}/>
        </ControlCenterRow>
        <ControlCenterRow>
            <DNDButton />
            <MicMuteButton />
        </ControlCenterRow>
        <VolumeSlider />
        <PlaybackWidget />
        <label css="opacity: 0.5" label={motd()} wrapMode={Pango.WrapMode.WORD} wrap={true} justify={Gtk.Justification.CENTER}/>
    </box>
}

const Page = ({child, name, header, on_click, refresh, refreshing}: {child?: JSX.Element, name: string, header: string, on_click: () => void, refresh?: () => void, refreshing?: Binding<boolean>}) => {
    let unsubscribe = () => {};
    return <box name={name} orientation={Gtk.Orientation.VERTICAL} spacing={SPACING * 2}>
        <centerbox className="widget-page-header">
            <button cursor="pointer" onClickRelease={on_click} hexpand={false} halign={Gtk.Align.START}><icon icon="go-next-rtl-symbolic" /></button>
            <label label={header} />
            {(refresh && refreshing) ? <button cursor="pointer" onClickRelease={refresh} hexpand={false} halign={Gtk.Align.END}>
                <Spinner css={`-gtk-icon-source: -gtk-icontheme("view-refresh-symbolic")`} hexpand={false} halign={Gtk.Align.END} setup={(s) => {
                    unsubscribe = refreshing.subscribe((refreshing) => {
                        if(refreshing) {
                            s.start();
                        } else {
                            s.stop();
                        }
                    })
                }} onDestroy={() => {
                    unsubscribe();
                }}/>
            </button> : <box />}
        </centerbox>
        {child}
    </box>
}

export default function ControlCenterWidget({monitor}: {monitor: Gdk.Monitor}) {
    const page = new Variable("main");

    return <stack className="control-center-core" shown={page()} transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT} margin={20}>
        <Main onBluetoothClicked={() => page.set("bluetooth")} onNetworkClicked={() => page.set("network")}/>
        <Page name="bluetooth" header="Bluetooth" on_click={() => page.set("main")} refresh={() => {
            const adapter = AstalBluetooth.get_default().adapter;
            if(adapter.discovering) return;

            adapter.start_discovery();
            setTimeout(() => adapter.stop_discovery(), 15E3);
        }} refreshing={bind(AstalBluetooth.get_default().adapter, "discovering")}>
            <BluetoothPageWidget />
        </Page>
        <Page name="network" header="Network" on_click={() => page.set("main")} refresh={() => {
            const wifi = AstalNetwork.get_default().wifi;
            if(wifi.scanning) return;

            wifi.scan();
        }} refreshing={bind(AstalNetwork.get_default().wifi, "scanning")}>
            <NetworkPageWidget monitor={monitor}/>
        </Page>
    </stack>
}
