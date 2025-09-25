import { Gtk } from "ags/gtk4";
import { GLib, property, register } from "astal";
import Graphene from "gi://Graphene?version=1.0";
import Gsk from "gi://Gsk?version=4.0";
import Pango from "gi://Pango?version=1.0";
import { Accessor } from "gnim";

@register()
export class MarqueeLabel extends Gtk.Label {

    @property(Number)
    private offset: number = 0;
    @property(Number)
    private timeoutId: number = 0;
    @property(Boolean)
    private needsScroll: boolean = false;
    @property(Number)
    private dir: number = -0.25;

    constructor(props: { label: string | Accessor<string>, cssClass?: string }) {
        super({
            label: props.label instanceof Accessor ? (props.label.get()) : (props.label),
            ellipsize: Pango.EllipsizeMode.NONE,
            xalign: 0,
            halign: Gtk.Align.FILL,
            hexpand: true,
        });
        if (props.cssClass) {
            this.add_css_class(props.cssClass);
        }

        if(props.label instanceof Accessor) {
            props.label.subscribe(() => {
                this.set_label((props.label as Accessor<string>).get())
            })
        }
    }

    vfunc_size_allocate(width: number, height: number, baseline: number) {
        // Call parent first to store allocation
        super.vfunc_size_allocate(width, height, baseline);

        // Now the widget has a real allocation
        this._resetMarquee();
    }

    private _updateMarquee() {
        if (!this.get_realized()) return GLib.SOURCE_REMOVE;

        const alloc = this.get_allocation();
        const nat = super.vfunc_measure(Gtk.Orientation.HORIZONTAL, 1000)[0];

        this.needsScroll = nat > alloc.width;

        if (this.needsScroll) {
            this.timeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, 30, () => {
                const maxOffset = nat - alloc.width;
                if ((this.offset < -maxOffset && this.dir < 0) || (this.offset > 0 && this.dir > 0)) {
                    this.dir *= -1;
                    GLib.timeout_add(GLib.PRIORITY_DEFAULT, 1000, this._updateMarquee.bind(this))
                    if(this.dir < 0) {
                        this.offset = 0;
                    }
                    if(this.dir > 0) {
                        this.offset = -maxOffset;
                    }
                    this.queue_draw();
                    return GLib.SOURCE_REMOVE;
                } else {
                    this.offset += this.dir * nat/75;
                }
                this.queue_draw();
                return GLib.SOURCE_CONTINUE;
            });
        }
        
        return GLib.SOURCE_REMOVE;
    }

    private _resetMarquee() {
        if (this.timeoutId) {
            GLib.source_remove(this.timeoutId);
            this.timeoutId = 0;
        }
        this.offset = 0;

        GLib.idle_add(GLib.PRIORITY_DEFAULT_IDLE, this._updateMarquee.bind(this));
    }

    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        function easeInOut(t: number) {
            return t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2;
        }
        const alloc = this.get_allocation();
        const nat = super.vfunc_measure(Gtk.Orientation.HORIZONTAL, 1000)[0];
        const maxOffset = nat - alloc.width;
        if (this.needsScroll) {
            const progress = Math.min(Math.max(-this.offset / maxOffset, 0), 1);
            const easedProgress = easeInOut(progress);

            const easedOffset = -easedProgress * maxOffset;
            const transform = new Gsk.Transform().translate(
                new Graphene.Point({ x: easedOffset, y: 0 })
            );
            snapshot.transform(transform);
            super.vfunc_snapshot(snapshot);
        } else {
            const text_width = super.vfunc_measure(Gtk.Orientation.HORIZONTAL, -1)[0];
            const transform = new Gsk.Transform().translate(
                new Graphene.Point({ x: (alloc.width - text_width) / 2, y: 0 })
            );
            snapshot.transform(transform);
            super.vfunc_snapshot(snapshot);
        }
    }

    vfunc_measure(orientation: Gtk.Orientation, for_size: number): [number, number, number, number] {
        const [a, b, c, d] = super.vfunc_measure(orientation, for_size);

        if(orientation === Gtk.Orientation.HORIZONTAL) {
            return [100, for_size > 0 ? for_size : 100, -1, -1]
        }
        return [a, b, c, d]
    }
}

export const WrappedMarqueeLabel = ({label, cssClass}: {label: string | Accessor<string>, cssClass?: string}) => {
    const marquee = new MarqueeLabel({
        label,
        cssClass: cssClass || "",
    });

    return <box hexpand overflow={Gtk.Overflow.HIDDEN}>
        {marquee}
    </box>
}

