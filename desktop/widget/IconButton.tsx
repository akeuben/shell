import { Accessor } from "gnim"
import { pointer } from "../util/cursor"
import { Gtk } from "ags/gtk4"

export const IconButton = ({onClicked, icon_name, pixel_size, className, hexpand, vexpand, halign, valign}: {onClicked: () => void, icon_name: string, pixel_size: number, className: string | Accessor<string> | undefined, hexpand?: boolean | Accessor<boolean>, vexpand?: boolean |Accessor<boolean>, halign?: Gtk.Align | Accessor<Gtk.Align>, valign?: Gtk.Align | Accessor<Gtk.Align>}) => {
    return <button hexpand={hexpand} vexpand={vexpand} onClicked={onClicked} cursor={pointer} class={["undefined", "string"].includes(typeof className) ? `${className} icon-button` : (className as Accessor<String>).as(c => `${c} icon-button`)} halign={halign} valign={valign} >
        <image icon_name={icon_name} pixel_size={pixel_size}/>
    </button>
}
