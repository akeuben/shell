import { App, Astal, Gdk } from "astal/gtk3";
import { LoginWidget } from "../widget/LoginWidget";

export default function Login(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Login"
        namespace="shell:login"
        name="shell:login"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        layer={Astal.Layer.TOP}
        anchor={Astal.WindowAnchor.NONE}
        keymode={Astal.Keymode.ON_DEMAND}
        application={App}>
        <LoginWidget />
    </window>
}
