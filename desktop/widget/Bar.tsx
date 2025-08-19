import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import Gsk from "gi://Gsk?version=4.0"
import { property, register } from "gnim/gobject"
import Cairo10 from "gi://cairo"
import giCairo from "cairo"
import { Accessor, createState } from "gnim"
const { TOP, LEFT, RIGHT, BOTTOM} = Astal.WindowAnchor
import { BluetoothIcon, NetworkIcon } from "./Indicator";
import { Clock, SystemTray } from "./Tray"
import { WorkspaceIndicator } from "./Workspace"
import { ActiveClient, ClientList } from "./Clients"

const LEFT_BAR_SIZE = 52;

type InvertedCornerProps = {class: string, radius: number, corner: "top-left" | "top-right" | "bottom-left" | "bottom-right"};

// Register the widget so it has a proper GType
@register()
class InvertedCornerWidget extends Gtk.DrawingArea {
    @property(String)
    private class: string;

    @property(Number)
    private radius: number;

    @property(String)
    private corner: string;

    constructor(props: InvertedCornerProps) {
        super();
        this.class = props.class;
        this.radius = props.radius;
        this.corner = props.corner;

        this.add_css_class(this.class);
    }

    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        const r = this.radius;

        const builder = Gsk.PathBuilder.new();

        const color = this.get_color();
        
        switch (this.corner) {
            case "top-left":
                builder.move_to(r, 0);
                builder.line_to(0, 0);
                builder.line_to(0, r);
                builder.arc_to(0, 0, r, 0);
                break;
            case "top-right":
                builder.move_to(r, r);
                builder.line_to(r, 0);
                builder.line_to(0, 0);
                builder.arc_to(r, 0, r, r);
                break;
            case "bottom-right":
                builder.move_to(0, r);
                builder.line_to(r, r);
                builder.line_to(r, 0);
                builder.arc_to(r, r, 0, r);
                break;
            case "bottom-left":
                builder.move_to(r, r);
                builder.line_to(0, r);
                builder.line_to(0, 0);
                builder.arc_to(0, r, r, r);
                break;
        }

        const style = this.get_style_context()

        const path = builder.to_path();
        builder.close();

        snapshot.push_fill(path, Gsk.FillRule.WINDING);
        snapshot.render_background(style, 0, 0, r, r);
        snapshot.pop();
    }
}

// JSX wrapper function for Astal
export function InvertedCorner(props: InvertedCornerProps) {
    const box = new InvertedCornerWidget(props);

    const {radius} = props;
    
    return <box width_request={radius} height_request={radius}>
        {box}
    </box>
}

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
    >
        <centerbox width_request={LEFT_BAR_SIZE} class="bar left" orientation={Gtk.Orientation.VERTICAL}>
            <box $type="start" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                <image icon_name="nix-snowflake-white" pixel_size={24} />
                <WorkspaceIndicator gdkmonitor={gdkmonitor} />
                <ClientList gdkmonitor={gdkmonitor} />
            </box>
            <ActiveClient $type="center" gdkmonitor={gdkmonitor}/>
            <box $type="end" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                <SystemTray />
                <Clock />
                <box class="bar-section" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
                    <NetworkIcon />
                    <BluetoothIcon />
                </box>
                <button cursor={Gdk.Cursor.new_from_name("pointer", null)} onClicked={console.log.bind(null, "Click!")} hexpand={false} vexpand={false}>
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
        $={(window) => {
            updateBounds(window, new Gdk.Rectangle({x: 0, y: 0, width: gdkmonitor.geometry.width, height: 5}));
        }}
    >
        <box orientation={Gtk.Orientation.VERTICAL}>
            <box margin_start={LEFT_BAR_SIZE} height_request={5} class="bar">
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
