import { Gtk } from "ags/gtk4";
import GLib from "gi://GLib?version=2.0";
import Gsk from "gi://Gsk?version=4.0";
import { Accessor } from "gnim";
import { property, register } from "gnim/gobject";

type InvertedCornerProps = {class: string, radius: number | Accessor<number>, corner: "top-left" | "top-right" | "bottom-left" | "bottom-right", valign?: Gtk.Align, halign?: Gtk.Align};

export function animateRadius(widget: Gtk.Widget, setter: (a: number) => void, from: number, to: number, duration: number) {
    const start = GLib.get_monotonic_time();
    const diff = to - from;

    widget.add_tick_callback(() => {
        const elapsed = (GLib.get_monotonic_time() - start) / 1000; // ms
        const t = Math.min(1, elapsed / duration);

        const newRadius = from + diff * t;
        setter(newRadius);

        if (t >= 1) {
            return GLib.SOURCE_REMOVE;
        }
        return GLib.SOURCE_CONTINUE;
    });
}

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
        this.radius = typeof props.radius === "number" ? props.radius : props.radius.get();
        this.corner = props.corner;

        this.add_css_class(this.class);

        if(props.radius instanceof Accessor) {
            props.radius.subscribe(() => {
                // @ts-ignore-next-line
                this.radius = props.radius.get();
            })
        }
    }

    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        const r = this.radius;

        const builder = Gsk.PathBuilder.new();

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

    const {radius, valign, halign} = props;
    
    return <box width_request={radius} height_request={radius} valign={valign} halign={halign}>
        {box}
    </box>
}

