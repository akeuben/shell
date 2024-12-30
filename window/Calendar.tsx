import { App, Astal, Gdk } from "gjs/gtk3";
import { CalendarWidget } from "../widget/Calendar";

export default function Calendar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Calendar"
        name={`calendar-${App.get_monitors().indexOf(gdkmonitor)}`}
        visible={false}
        namespace="shell:calendar"
        gdkmonitor={gdkmonitor}
        layer={Astal.Layer.TOP}
        exclusivity={Astal.Exclusivity.NORMAL}
        canFocus={true}
        focus_on_click={true}
        anchor={Astal.WindowAnchor.TOP}
        application={App}>
        <CalendarWidget monitor={gdkmonitor} />
    </window>
}
