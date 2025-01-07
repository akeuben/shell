import { Gdk, Gtk } from "gjs/gtk3"
import { Search } from "./runner/Search"
import { Results } from "./runner/Results"
import Variable from "gjs/variable"

export const RunnerWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    const searchTerm = new Variable("");
    return <box orientation={Gtk.Orientation.VERTICAL} spacing={3} width_request={750}>
        <Search monitor={monitor} searchTerm={searchTerm} />
        <Results monitor={monitor} searchTerm={searchTerm} />
    </box>
} 
