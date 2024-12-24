import Gdk from "gi://Gdk?version=3.0";
import { Variable } from "../../../../../.local/share/ags";

const DesktopEnvironment = Variable('unknown').watch('bash -c "echo $XDG_CURRENT_DESKTOP"');

export const WorkspacesWidget = ({monitor}: {monitor: Gdk.Monitor}) => {
    return <box hexpand={false}>
        <button label={DesktopEnvironment()} />
    </box>
}
