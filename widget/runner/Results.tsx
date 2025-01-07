import Binding, { bind } from "gjs/binding"
import Variable from "gjs/variable"
import { App, Gdk, Gtk } from "gjs/gtk3";
import { RunnerSettings } from "../../utils/runner";

export const Results = ({searchTerm, monitor}: {searchTerm: Variable<string>, monitor: Gdk.Monitor}) => {
    const results = bind(searchTerm).as(RunnerSettings.find_all_results);
    return <box orientation={Gtk.Orientation.VERTICAL} spacing={3}>
        {results.as(results => results.map((result, i) => <button className={`list-section-part ${i === results.length - 1 ? "last" : ""} runner-result ${result.type}`} onClickRelease={() => {
            result.action();
            App.get_window(`runner-${App.get_monitors().indexOf(monitor)}`)?.hide();
            searchTerm.set("");
        }} onKeyPressEvent={(s, e) => {
            const [keyval, keycode] = e.get_keycode();
            if(keyval && [36, 104].includes(keycode)) {
                result.action();
                App.get_window(`runner-${App.get_monitors().indexOf(monitor)}`)?.hide();
                searchTerm.set("");
            } else if(keyval && keycode === 9) {
                App.get_window(`runner-${App.get_monitors().indexOf(monitor)}`)?.hide();
            }
        }}>
            <box height_request={i === 0 ? 64 : 48} spacing={20}>
            {result.icon ? <icon icon={result.icon} vexpand={true} css={"font-size: 32px"} valign={Gtk.Align.CENTER}/> : <></> }
                <box orientation={Gtk.Orientation.VERTICAL} vexpand={true} hexpand={true} halign={Gtk.Align.START} valign={Gtk.Align.CENTER}>
                    <label className="title" hexpand={true} valign={Gtk.Align.CENTER} halign={Gtk.Align.START} label={result.name.slice(0, 80) + (result.name.length > 80 ? "..." : "")} />
                    {result.description ? <label className="description" valign={Gtk.Align.CENTER} hexpand={true} halign={Gtk.Align.START} label={result.description.slice(0, 80) + (result.description.length > 80 ? "..." : "")} /> : <></>}
                </box>
            </box>
        </button>))}
    </box>
}
