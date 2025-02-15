import { Gdk } from "astal/gtk3";
import { MonthWidget } from "./calendar/Calendar";

export const CalendarWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    return <box>
        <MonthWidget />
    </box>
}
