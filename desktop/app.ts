import app from "ags/gtk4/app"
import style from "./style.scss"
import {Bottom, Left, Right, Top} from "./widget/Bar"
import { handleRunner, handleScreenshot, PowerMenu, Runner, ScreenshotMenu } from "./widget/BottomMenu"
import { handleRequest, RequestHandlerRegistry } from "./util/requests"
import { programArgs } from "system"
import { sendRequest } from "ags/app"
import { TopMenu } from "./widget/TopMenu"
import { main } from "./main"

const handlers: RequestHandlerRegistry = {
    "runner": handleRunner,
    "screenshot": handleScreenshot,
}

if(programArgs.length === 0) {
    app.start({
        css: style,
        main: main
    })
    app.connect('request', (_, req, response) => handleRequest(handlers, req, response));
} else {
    await sendRequest("ags", ...programArgs);
}

