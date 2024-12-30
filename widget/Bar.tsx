import Gtk from "gi://Gtk?version=3.0"
import Gdk from "gi://Gdk?version=3.0"
import { ClientsWidget, WorkspacesWidget } from "./bar/Hyprland"
import { TimeWidget } from "./bar/Time"
import { WeatherWidget } from "./bar/Weather"
import { SystemTrayWidget } from "./bar/SystemTray"

const BarArea = ({child, children, align}: {child?: JSX.Element, children?: JSX.Element[], align: Gtk.Align}) => {
    return <box 
        className="bar-area"
        spacing={10}
        hexpand={false}
        halign={align}>
        {child}
        {children}
    </box>
}

export default function BarWidget({monitor}: {monitor: Gdk.Monitor}) {
    return <centerbox>
        <BarArea align={Gtk.Align.START}>
            <WorkspacesWidget monitor={monitor}/>
            <ClientsWidget />
        </BarArea>
        <BarArea align={Gtk.Align.CENTER}>
            <TimeWidget monitor={monitor} />
        </BarArea>
        <BarArea align={Gtk.Align.END}>
            <WeatherWidget />
            <SystemTrayWidget monitor={monitor}/>
        </BarArea>
    </centerbox>
}
