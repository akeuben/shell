import { App, Astal, Gdk } from "gjs/gtk3";
import { RunnerWidget } from "../widget/Runner";

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
