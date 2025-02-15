import Binding from "astal/binding"
import { Gtk } from "astal/gtk3"

export const ToggleSwitch = ({enabled, on_click}: {enabled: boolean | Binding<boolean>, on_click: () => void}) => {
    const get_class_name = (enabled: boolean | Binding<Boolean>) => {
        if(typeof enabled === "boolean") {
            return `widget-toggle-switch ${enabled ? "enabled" : ""}`;
        }
        
        return enabled.as(d => `widget-toggle-switch ${d ? "enabled" : ""}`);
    }
    return <button className={get_class_name(enabled)} vexpand={false} valign={Gtk.Align.CENTER} onClickRelease={on_click}>
        <box className="widget-toggle-switch-handle"/>
    </button>
}
