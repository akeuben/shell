import app from "ags/gtk4/app"
import style from "./style.scss"
import {Bottom, Left, Right, Top} from "./widget/Bar"
import { handleRunner, PowerMenu, Runner } from "./widget/BottomMenu"
import { handleRequest, RequestHandlerRegistry } from "./util/requests"

const handlers: RequestHandlerRegistry = {
    "runner": handleRunner,
}

app.start({
    css: style,
    main() {
        app.get_monitors().map(Left)
        app.get_monitors().map(Right)
        app.get_monitors().map(Top)
        app.get_monitors().map(Bottom)
        app.get_monitors().map(PowerMenu)
        app.get_monitors().map(Runner)
    },
    requestHandler: handleRequest.bind(null, handlers),
})
