import { App, Astal, Gdk } from "astal/gtk3";
import ControlCenterWidget from "../../common/widget/ControlCenter";

export default function ControlCenter(gdkmonitor: Gdk.Monitor) {
    return <window
        className="ControlCenter"
        name={`control-center-${App.get_monitors().indexOf(gdkmonitor)}`}
        visible={false}
        namespace="shell:control_center"
        gdkmonitor={gdkmonitor}
        layer={Astal.Layer.TOP}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        canFocus={true}
        focus_on_click={true}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.RIGHT}
        application={App}>
        <ControlCenterWidget monitor={gdkmonitor} disabledWidgets={{}}/>
    </window>
}
