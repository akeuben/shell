import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./window/Bar"
import ControlCenter from "./window/ControlCenter"

const Windows = [Bar, ControlCenter]

App.start({
    css: style,
    main() {
        for(const Window of Windows) {
            App.get_monitors().map(Window)
        }
    },
})
