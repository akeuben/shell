import { Accessor } from "gnim"
import { pointer } from "../util/cursor"

export const IconButton = ({onClicked, icon_name, pixel_size, className, hexpand, vexpand}: {onClicked: () => void, icon_name: string, pixel_size: number, className: string | Accessor<string> | undefined, hexpand?: boolean | Accessor<boolean>, vexpand?: boolean |Accessor<boolean>}) => {
    return <button hexpand={hexpand} vexpand={vexpand} onClicked={onClicked} cursor={pointer} class={["undefined", "string"].includes(typeof className) ? `${className} icon-button` : (className as Accessor<String>).as(c => `${c} icon-button`)} >
        <image icon_name={icon_name} pixel_size={pixel_size}/>
    </button>
}
