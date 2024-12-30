import { Gdk } from "gjs/gtk3";
import { NetworkAuthenticationWidget } from "./network_auth/Auth";

export const NetworkAuthWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    return <box className="cover" hexpand={true} vexpand={true}>
        <NetworkAuthenticationWidget monitor={monitor} />
    </box>
} 
