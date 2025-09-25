import { Gdk, Gtk } from "ags/gtk4";
import { GObject, property, register } from "astal";
import Graphene from "gi://Graphene?version=1.0";
import Gsk from "gi://Gsk?version=4.0";
import Pango from "gi://Pango?version=1.0";
import { Accessor } from "gnim";
import { isAccessor } from "../util/generic";

@register()
export class Point extends GObject.Object {
    // Annotate $gtype for custom subclasses
    declare static $gtype: GObject.GType<Point>;

    @property(Number)
    x: number = 0;

    @property(Number)
    y: number = 0;

    constructor(params: Partial<Point> = {}) {
        super();
        this.x = params.x || 0;
        this.y = params.y || 0;
    }
}

@register()
export class PointsList extends GObject.Object {
    declare static $gtype: GObject.GType<PointsList>;

    points: Point[] = [];

    constructor(list: Point[]) {
        super();
        this.points = list;
    }
}

@register()
export class NumberArray extends GObject.Object {
    declare static $gtype: GObject.GType<NumberArray>;

    elements: number[] = [];

    constructor(list: number[]) {
        super();
        this.elements = list;
    }
}

type LineGraphProps = {points: PointsList | Accessor<PointsList>, xAxis: NumberArray, className: string | Accessor<string>, graphColor: string | Accessor<string>, axisColor: string | Accessor<string>};

// Register the widget so it has a proper GType
@register()
class LineGraphWidget extends Gtk.DrawingArea {

    @property(PointsList)
    private points: PointsList;

    @property(NumberArray)
    private xAxis: NumberArray

    @property(Number)
    private yMin: number = 0;
    @property(Number)
    private yMax: number = 100;

    @property(Number)
    private padding: number = 20;

    @property(String)
    private graphColor: string;
    @property(String)
    private axisColor: string = "#888888";

    constructor(props: LineGraphProps) {
        super();

        if(isAccessor(props.points)) {
            this.points = props.points.get();
            props.points.subscribe(() => {
                // @ts-ignore-next-line
                this.points = props.points.get();
                this.queue_draw();
            })
        } else {
            this.points = props.points;
        }
        if(isAccessor(props.className)) {
            this.cssClasses = props.className.get().split(" ");
            props.className.subscribe(() => {
                // @ts-ignore-next-line
                this.cssClasses = props.className.get().split(" ");
                this.queue_draw();
            });
        } else {
            this.cssClasses = props.className.split(" ");
        }
        if(isAccessor(props.graphColor)) {
            this.graphColor = props.graphColor.get();
            props.graphColor.subscribe(() => {
                // @ts-ignore-next-line
                this.graphColor = props.graphColor.get();
                this.queue_draw();
            })
        } else {
            this.graphColor = props.graphColor;
        }
        if(isAccessor(props.axisColor)) {
            this.axisColor = props.axisColor.get();
            props.axisColor.subscribe(() => {
                // @ts-ignore-next-line
                this.axisColor = props.axisColor.get();
                this.queue_draw();
            })
        } else {
            this.axisColor = props.axisColor;
        }
        this.xAxis = props.xAxis;

        this.hexpand = true;
        this.vexpand = true;
    }

    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        const width = this.get_allocated_width();
        const height = this.get_allocated_height();

        const layout = Pango.Layout.new(this.get_pango_context());

        // Scale points into widget coordinates
        const xs = this.xAxis.elements;
        const minX = Math.min(...xs);
        const maxX = Math.max(...xs);
        const minY = this.yMin;
        const maxY = this.yMax;

        const scaleX = (width - this.padding * 2) / (maxX - minX || 1);
        const scaleY = (height - this.padding * 2) / (maxY - minY || 1);

        const path = new Gsk.PathBuilder();
        const topPath = new Gsk.PathBuilder();

        let firstX = -1;
        let lastX = 0;

        // Draw vertical lines for each x
        const verticalPath = new Gsk.PathBuilder();
        for (const xp of xs) {
            const x = xp * scaleX;
            verticalPath.move_to(x + this.padding, this.padding);
            verticalPath.line_to(x + this.padding, height - this.padding * 1.5);
            const label = `${60 - xp}`;
            layout.set_text(label, label.length); // label for this line
            const point = new Graphene.Point({x: x + this.padding - layout.get_pixel_size()[0]/2, y: height - this.padding * 1.5});
            snapshot.translate(point);
            snapshot.append_layout(
                layout,
                new Gdk.RGBA({red: 0.8, green: 0.8, blue: 0.8, alpha: 1})
            );
            snapshot.translate(new Graphene.Point({x: -point.x, y: -point.y}));
        }

        const verticalStroke = new Gsk.Stroke(2.0);
        const axisColor = new Gdk.RGBA();
        axisColor.parse(this.axisColor);

        snapshot.append_stroke(verticalPath.to_path(), verticalStroke, axisColor);

        if (this.points.points.length == 0) return;

        this.points.points.forEach((p, i) => {
            let x = (p.x - minX) * scaleX + this.padding;
            const y = height - (p.y - minY) * scaleY - this.padding * 1.5; // invert y-axis
            if(i == 0) {
                x -= 2;
                firstX = x;
            }
            if(i == this.points.points.length - 1) {
                x += 2;
                lastX = x;
            }
            if (i === 0) {
                path.move_to(x, y);
                topPath.move_to(x, y);
            } else {
                path.line_to(x, y);
                topPath.line_to(x, y);
            }
        });


        // Close the path down to bottom
        path.line_to(lastX, height - this.padding * 1.5); // bottom right
        path.line_to(firstX, height - this.padding * 1.5); // bottom right
        path.close();

        const graphColor = new Gdk.RGBA();
        graphColor.parse(this.graphColor);

        snapshot.append_fill(path.to_path(), Gsk.FillRule.WINDING, graphColor);

        snapshot.append_stroke(topPath.to_path(), new Gsk.Stroke(5), axisColor);
    }
}

export const LineGraph = (props: LineGraphProps) => {
    const g = new LineGraphWidget(props);

    return g;
}
