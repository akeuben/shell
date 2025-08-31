import { pointer } from "../util/cursor"

export const IconButton = ({onClicked, icon_name, pixel_size}: {onClicked: () => void, icon_name: string, pixel_size: number}) => {
    return <button onClicked={onClicked} cursor={pointer}>
        <image icon_name={icon_name} pixel_size={pixel_size} />
    </button>
}
