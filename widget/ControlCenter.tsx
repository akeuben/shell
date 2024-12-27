import { Gdk, Gtk } from "gjs/gtk3";
import { BluetoothButton, DNDButton, InternetButton, MicMuteButton } from "./control_center/Button";
import { VolumeSlider } from "./control_center/Slider";
import { BluetoothPageWidget } from "./control_center/Bluetooth";
import Variable from "gjs/variable";

const SPACING = 10;

const ControlCenterRow = ({child, children}: {children?: JSX.Element[], child?: JSX.Element}) => {
    return <box spacing={SPACING}>
        {child}
        {children}
    </box>
}

const Main = ({onBluetoothClicked}: {onBluetoothClicked: () => void}) => {
    return <box name="main" orientation={Gtk.Orientation.VERTICAL} spacing={SPACING}>
        <ControlCenterRow>
            <InternetButton />
            <BluetoothButton on_click={onBluetoothClicked}/>
        </ControlCenterRow>
        <ControlCenterRow>
            <DNDButton />
            <MicMuteButton />
        </ControlCenterRow>
        <VolumeSlider />
    </box>
}

const Page = ({child, name, header, on_click}: {child?: JSX.Element, name: string, header: string, on_click: () => void}) => {
    return <box name={name} orientation={Gtk.Orientation.VERTICAL}>
        <centerbox className="widget-page-header">
            <button cursor="pointer" onClickRelease={on_click} hexpand={false} halign={Gtk.Align.START}><label label="⏴" /></button>
            <label label={header} />
            <box/>
        </centerbox>
        {child}
    </box>
}

export default function ControlCenterWidget({monitor}: {monitor: Gdk.Monitor}) {
    const page = new Variable("bluetooth");

    return <stack className="control-center-core" shown={page()} transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT} margin={20}>
        <Main onBluetoothClicked={() => page.set("bluetooth")} />
        <Page name="bluetooth" header="Bluetooth" on_click={() => page.set("main")}>
            <BluetoothPageWidget />
        </Page>
    </stack>
}
