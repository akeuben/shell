import app from "ags/gtk4/app"
import style from "./style.scss"
import {Bottom, Left, Right, Top} from "./widget/Bar"
import { handleRunner, PowerMenu, Runner } from "./widget/BottomMenu"
import { handleRequest, RequestHandlerRegistry } from "./util/requests"
import { programArgs } from "system"
import AstalIO from "gi://AstalIO?version=0.1"
import Gio from "gi://Gio?version=2.0"
import { AppDBus } from "../../../../../../../nix/store/3w64qxd3jd6pw4lvz7kdzmi6dva0h6g2-ags-js-lib/lib/app/dbus"

const handlers: RequestHandlerRegistry = {
    "runner": handleRunner,
}

if(programArgs.length === 0) {
    app.start({
        css: style,
        main() {
            app.get_monitors().map(PowerMenu)
            app.get_monitors().map(Runner)
            app.get_monitors().map(Left)
            app.get_monitors().map(Right)
            app.get_monitors().map(Top)
            app.get_monitors().map(Bottom)
        }
    })
    app.connect('request', (app, req, response) => handleRequest(handlers, req, response));
} else {
    console.log(AstalIO.get_instances())
    console.log(programArgs.join(" "))
    const a = await AppDBus.proxy("ags")
    a.Request(programArgs);
}

