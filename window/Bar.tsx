import { App, Astal, Gdk } from "astal/gtk3"
import BarWidget from "../widget/Bar"

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.RIGHT}
        marginLeft={20}
        marginRight={20}
        marginTop={10}
        application={App}>
        <BarWidget monitor={gdkmonitor} />
    </window>
}
