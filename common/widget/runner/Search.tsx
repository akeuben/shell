import Variable from "astal/variable"
import { RunnerSettings } from "../../utils/runner";
import { App, Gdk, Gtk } from "astal/gtk3";
import { bind } from "astal";

export const Search = ({searchTerm, monitor}: {searchTerm: Variable<string>, monitor: Gdk.Monitor}) => {
    return <overlay className="search" hexpand={true} vexpand={true}>
        <entry hexpand={true} vexpand={true} className={searchTerm(term => `list-section-part first ${RunnerSettings.find_all_results(term).length > 0 ? "" : "last"}`)} text={searchTerm()} placeholder_text="Search Anything" onChanged={(e) => {
            searchTerm.set(e.text);
        }} onKeyPressEvent={(s, e) => {
            const [keyval, keycode] = e.get_keycode();
            if(keyval && [36, 104].includes(keycode)) {
                const results = RunnerSettings.find_all_results(s.text);
                if(results.length > 0) {
                    results[0].action();
                    App.get_window(`runner-${App.get_monitors().indexOf(monitor)}`)?.hide();
                    searchTerm.set("");
                }
            } else if(keyval && keycode === 9) {
                App.get_window(`runner-${App.get_monitors().indexOf(monitor)}`)?.hide();
            }
        }}/>
        <label label={bind(searchTerm).as(t => t ? "" : "Search Anything...")} hexpand={true} vexpand={true} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} />
    </overlay>
}
