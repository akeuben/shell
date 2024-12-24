import { Gdk, Gtk } from "astal/gtk3"
import { WorkspacesWidget } from "./bar/desktop/Desktop"
import { Variable } from "astal";

const time = Variable("").poll(1000, "date")

export default function BarWidget({monitor}: {monitor: Gdk.Monitor}) {
    return <centerbox>
        <WorkspacesWidget monitor={monitor}/>
        <WorkspacesWidget monitor={monitor}/>
        <button
            onClick={() => print("hello")}
            halign={Gtk.Align.CENTER} >
            <label label={time()} />
        </button>
    </centerbox>
}
