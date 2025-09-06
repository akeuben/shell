import app from "ags/gtk4/app"
import style from "./style.scss"
import {Bottom, Left, Right, Top} from "./widget/Bar"
import { handleRunner, handleScreenshot, PowerMenu, Runner, ScreenshotMenu } from "./widget/BottomMenu"
import { handleRequest, RequestHandlerRegistry } from "./util/requests"
import { programArgs } from "system"
import { sendRequest } from "ags/app"
import { TopMenu } from "./widget/TopMenu"

const handlers: RequestHandlerRegistry = {
    "runner": handleRunner,
    "screenshot": handleScreenshot,
}

if(programArgs.length === 0) {
    app.start({
        css: style,
        main() {
            app.get_monitors().map(Left)
            app.get_monitors().map(Right)
            app.get_monitors().map(Top)
            app.get_monitors().map(Bottom)
            app.get_monitors().map(PowerMenu)
            app.get_monitors().map(ScreenshotMenu)
            app.get_monitors().map(Runner)
            app.get_monitors().map(TopMenu)
        }
    })
    app.connect('request', (_, req, response) => handleRequest(handlers, req, response));
} else {
    await sendRequest("ags", ...programArgs);
}

