namespace Kappashell {
    public enum Corner {
        TOP_LEFT, 
        TOP_RIGHT, 
        BOTTOM_RIGHT, 
        BOTTOM_LEFT,
    }

    public class InvertedCorner : Gtk.DrawingArea {
        private Corner corner;
        private int radius;
        private double start;
        private int32 diff;
        private int from;
        private double duration;
        private uint? tick;

        public InvertedCorner(int radius, Corner corner) {
            set_content_width (radius);
            set_content_height (radius);

            add_css_class("inverted_corner");

            this.corner = corner;
            this.radius = radius;
        }

        public void set_radius_animated(int radius, double duration) {
            this.start = GLib.get_monotonic_time() / 1.0E6;
            this.diff = radius - this.radius;
            this.duration = duration;
            this.from = this.radius;

            if(this.tick != null) {
                this.remove_tick_callback(this.tick);
            }

            this.tick = this.add_tick_callback((widget, clock) => {
                var time = GLib.get_monotonic_time() / 1.0E6;
                var elapsed = time - this.start;
                var t = (float) (elapsed / this.duration);
                if(t > 1.0f) 
                    t = 1.0f;
                var r = (int) (this.from + this.diff * t);

                this.set_radius(r);

                if(t >= 1) {
                    return GLib.Source.REMOVE;
                }
                
                return GLib.Source.CONTINUE;
            });
        }

        public void set_radius(int radius) {
            this.radius = radius;
        }

        public override void snapshot(Gtk.Snapshot snapshot) {
            var radius = (float) this.radius;

            var builder = new Gsk.PathBuilder();

            switch (corner) {
                case Corner.TOP_LEFT:
                    builder.move_to(radius, 0);
                    builder.line_to(0, 0);
                    builder.line_to(0, radius);
                    builder.arc_to(0, 0, radius, 0);
                    break;
                case Corner.TOP_RIGHT:
                    builder.move_to(radius, radius);
                    builder.line_to(radius, 0);
                    builder.line_to(0, 0);
                    builder.arc_to(radius, 0, radius, radius);
                    break;
                case Corner.BOTTOM_RIGHT:
                    builder.move_to(0, radius);
                    builder.line_to(radius, radius);
                    builder.line_to(radius, 0);
                    builder.arc_to(radius, radius, 0, radius);
                    break;
                case Corner.BOTTOM_LEFT:
                    builder.move_to(radius, radius);
                    builder.line_to(0, radius);
                    builder.line_to(0, 0);
                    builder.arc_to(0, radius, radius, radius);
                    break;
            }

            var path = builder.to_path();
            builder.close();

            var color = get_color();

            snapshot.append_fill(path, Gsk.FillRule.WINDING, color);
        }
    }
}
