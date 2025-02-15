import { App, Astal, Gdk } from "astal/gtk3";
import { RunnerWidget } from "../../common/widget/Runner";

export default function Runner(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Runner"
        name={`runner-${App.get_monitors().indexOf(gdkmonitor)}`}
        visible={false}
        namespace="shell:runner"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.ON_DEMAND}
        application={App}>
        <RunnerWidget monitor={gdkmonitor}/>
    </window>
}
