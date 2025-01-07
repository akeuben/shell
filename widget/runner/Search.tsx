import Variable from "gjs/variable"
import { RunnerSettings } from "../../utils/runner";
import { App, Gdk } from "gjs/gtk3";

export const Search = ({searchTerm, monitor}: {searchTerm: Variable<string>, monitor: Gdk.Monitor}) => {
    return <entry className={searchTerm(term => `list-section-part first ${RunnerSettings.find_all_results(term).length > 0 ? "" : "last"}`)} text={searchTerm()} placeholder_text="Search Anything" onChanged={(e) => {
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
}
