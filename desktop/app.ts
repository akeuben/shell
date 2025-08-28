import app from "ags/gtk4/app"
import style from "./style.scss"
import {Bottom, Left, Right, Top} from "./widget/Bar"
import { PowerMenu } from "./widget/BottomMenu"

app.start({
  css: style,
  main() {
    app.get_monitors().map(Left)
    app.get_monitors().map(Right)
    app.get_monitors().map(Top)
    app.get_monitors().map(Bottom)
    app.get_monitors().map(PowerMenu)
  },
})
