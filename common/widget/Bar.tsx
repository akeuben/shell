import Gtk from "gi://Gtk?version=3.0"
import Gdk from "gi://Gdk?version=3.0"
import { ClientsWidget, WorkspacesWidget } from "./bar/Hyprland"
import { TimeWidget } from "./bar/Time"
import { WeatherWidget } from "./bar/Weather"
import { SystemTrayWidget } from "./bar/SystemTray"
import { BatteryWidget } from "./bar/Battery"

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

type BarWidgetMask = {
    workspaces?: boolean,
    client?: boolean,
    time?: boolean,
    weather?: boolean,
    tray?: boolean,
    battery?: boolean,
};

export default function BarWidget({monitor, disabledWidgets}: {monitor: Gdk.Monitor, disabledWidgets: BarWidgetMask}) {
    return <centerbox>
        <BarArea align={Gtk.Align.START}>
            {disabledWidgets.workspaces ? <></> : <WorkspacesWidget monitor={monitor}/>}
            {disabledWidgets.client ? <></> : <ClientsWidget />}
        </BarArea>
        <BarArea align={Gtk.Align.CENTER}>
        {disabledWidgets.time ? <></> : <TimeWidget monitor={monitor} />}
        </BarArea>
        <BarArea align={Gtk.Align.END}>
            {disabledWidgets.weather ? <></> : <WeatherWidget />}
            {disabledWidgets.tray ? <></> : <SystemTrayWidget monitor={monitor}/>}
            {disabledWidgets.battery ? <></> : <BatteryWidget />}
        </BarArea>
    </centerbox>
}
