import { App, Gdk } from "astal/gtk3"
import Variable from "astal/variable"

const time = Variable("").poll(1000, `date +"%a %e %b %I:%M%P"`)

export const TimeWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    return <button className="bar-section" cursor="pointer" label={time()} onClickRelease={() => {
        App.toggle_window(`calendar-${App.get_monitors().indexOf(monitor)}`);
    }}/>
}
