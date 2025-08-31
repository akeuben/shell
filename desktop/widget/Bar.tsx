import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import Cairo10 from "gi://cairo"
import giCairo from "cairo"
import { Accessor } from "gnim"
const { TOP, LEFT, RIGHT, BOTTOM} = Astal.WindowAnchor
import { BluetoothIcon, NetworkIcon } from "./Indicator";
import { Clock, SystemTray } from "./Tray"
import { WorkspaceIndicator } from "./Workspace"
import { ActiveClient, ClientList } from "./Clients"
import { InvertedCorner } from "./InvertedCorner"
import { BottomMenuType, setBottomMenu, setTopMenuOpen } from "./GlobalState"

const LEFT_BAR_SIZE = 52;

export function Left(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      visible
      name="left"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | BOTTOM }
      application={app}
      layer={Astal.Layer.TOP}
    >
        <centerbox width_request={LEFT_BAR_SIZE} class="bar left" orientation={Gtk.Orientation.VERTICAL}>
            <box $type="start" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                <image icon_name="nix-snowflake-white" pixel_size={24} />
                <WorkspaceIndicator gdkmonitor={gdkmonitor} />
                <ClientList gdkmonitor={gdkmonitor} />
            </box>
            <ActiveClient $type="center"/>
            <box $type="end" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                <SystemTray />
                <Clock />
                <box class="bar-section" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                        <NetworkIcon />
                        <BluetoothIcon />
                    </box>
                    <button cursor={Gdk.Cursor.new_from_name("pointer", null)} onClicked={() => setBottomMenu(m => {
                        if(m === BottomMenuType.POWER_MENU) {
                            return BottomMenuType.NONE;
                        }
                        return BottomMenuType.POWER_MENU;
                    })
                    } hexpand={false} vexpand={false}>
                        <image icon_name="system-shutdown-symbolic" pixel_size={24} />
                </button>
            </box>
        </centerbox>
    </window>
  )
}

export function Right(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      visible
      name="right"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | RIGHT | BOTTOM }
      application={app}
      layer={Astal.Layer.TOP}
    >
        <box orientation={Gtk.Orientation.HORIZONTAL}>
            <box width_request={5} class="bar" >
            </box>
        </box>
    </window>
  )
}

export function Top(gdkmonitor: Gdk.Monitor) {
    return <window
        visible
        name="top"
        class="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        anchor={TOP | RIGHT | LEFT }
        application={app}
      layer={Astal.Layer.TOP}
        $={(window) => {
            updateBounds(window, new Gdk.Rectangle({x: 0, y: 0, width: gdkmonitor.geometry.width, height: 5}));
        }}
    >
        <box orientation={Gtk.Orientation.VERTICAL}>
            <box margin_start={LEFT_BAR_SIZE} height_request={5} class="bar">
                <box width_request={1000} halign={Gtk.Align.CENTER} hexpand={true} $={(e) => {
                    const controller = Gtk.GestureClick.new();
                    controller.connect("released", () => {
                        setTopMenuOpen(true)
                        console.log("OPEN");
                    });
                    e.add_controller(controller);
                }}/>
            </box>
            <centerbox orientation={Gtk.Orientation.HORIZONTAL} margin_start={LEFT_BAR_SIZE} margin_end={5}>
                <InvertedCorner $type="start" class="bar" radius={34} corner="top-left" />
                    <box $type="center" class="bar" />
                <InvertedCorner $type="end" class="bar" radius={34} corner="top-right" />
            </centerbox>
        </box>
    </window>
}

export function Bottom(gdkmonitor: Gdk.Monitor) {
  return (
    <window
        visible
        name="bottom"
        class="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        anchor={BOTTOM | RIGHT | LEFT }
        application={app}
      layer={Astal.Layer.TOP}
        $={(window) => {
            updateBounds(window, new Gdk.Rectangle({x: 0, y: 0, width: gdkmonitor.geometry.width, height: 5}));
        }}
    >
        <box orientation={Gtk.Orientation.VERTICAL} >
            <centerbox orientation={Gtk.Orientation.HORIZONTAL} margin_start={LEFT_BAR_SIZE} margin_end={5}>
                <InvertedCorner  $type="start" class="bar" radius={34} corner="bottom-left" />
                    <box $type="center" class="bar" />
                <InvertedCorner $type="end" class="bar" radius={34} corner="bottom-right" />
            </centerbox>
            <box height_request={5} class="bar">
            </box>
        </box>
    </window>
  )
}

export function updateBounds(window: Astal.Window, clickableArea: Gdk.Rectangle) {
    const region = new giCairo.Region();

    const rectangle = new Cairo10.Rectangle({
        x: clickableArea.x,
        y: clickableArea.y,
        width: clickableArea.width,
        height: clickableArea.height,
    });

    // @ts-ignore
    region.unionRectangle(
        rectangle
    )
    const surface = window.get_native()?.get_surface() as Gdk.Surface;
    surface.set_input_region(region);
}
