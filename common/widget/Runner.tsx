import { App, Gdk, Gtk } from "astal/gtk3"
import { Search } from "./runner/Search"
import { Results } from "./runner/Results"
import Variable from "astal/variable"

export const RunnerWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    const searchTerm = new Variable("");
    return <box orientation={Gtk.Orientation.VERTICAL} spacing={3} width_request={750} setup={(s) => {
        s.connect("realize", () => {
            const window = App.get_window(`runner-${App.get_monitors().indexOf(monitor)}`);
            if(!window) return;
            window.connect("notify::visible", () => {
                searchTerm.set("");
            })
        });
    }}>
        <Search monitor={monitor} searchTerm={searchTerm} />
        <Results monitor={monitor} searchTerm={searchTerm} />
    </box>
} 
