import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./window/Bar"
import ControlCenter from "./window/ControlCenter"
import NetworkAuth from "./window/NetworkAuth"
import { updateNetworkAuthRequest, updateNetworkAuthResponse } from "./widget/network_auth/Auth"
import Calendar from "./window/Calendar"

const Windows = [ControlCenter, Calendar, Bar, NetworkAuth]

App.start({
    css: style,
    main() {
        for(const Window of Windows) {
            App.get_monitors().map(Window)
        }
    },
    requestHandler(raw_request, res) {
        try {
            const request = JSON.parse(raw_request);
                
            switch(request.type) {
                case "network-auth": {
                    updateNetworkAuthRequest(request.ssid);
                    updateNetworkAuthResponse(res);
                    App.get_window(`network-auth-${request.monitor}`)?.set_visible(true);
                    break;
                }
                default: {
                    res("invalid request type");
                }
            }
        } catch {
            res("malformed request");
        }
    },
})
