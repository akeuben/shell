import { App, Astal, Gdk } from "gjs/gtk3";
import ControlCenterWidget from "../widget/ControlCenter";

export default function ControlCenter(gdkmonitor: Gdk.Monitor) {
    return <window
        className="ControlCenter"
        name={`control-center-${App.get_monitors().indexOf(gdkmonitor)}`}
        visible={false}
        margin={20}
        namespace="shell:control_center"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.RIGHT}
        application={App}>
        <ControlCenterWidget monitor={gdkmonitor} />
    </window>
}
