import { App, Astal, Gdk } from "astal/gtk3"
import BarWidget from "../widget/Bar"

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Bar"
        namespace="shell:bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.RIGHT}
        application={App}>
        <BarWidget monitor={gdkmonitor} />
    </window>
}
