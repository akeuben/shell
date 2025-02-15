import { App, Astal, Gdk } from "astal/gtk3";
import { NetworkAuthWidget } from "../../common/widget/NetworkAuth";

export default function NetworkAuth(gdkmonitor: Gdk.Monitor) {
    return <window
        className="NetworkAuth"
        name={`network-auth-${App.get_monitors().indexOf(gdkmonitor)}`}
        visible={false}
        namespace="shell:network_auth"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.BOTTOM
            | Astal.WindowAnchor.RIGHT}
        application={App}>
        <NetworkAuthWidget monitor={gdkmonitor} />
    </window>
}
