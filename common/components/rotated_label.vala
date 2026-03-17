namespace Kappashell {
    public class RotatedLabel : Gtk.Widget {

        private Gtk.Label label_widget;
        public float angle;

        public RotatedLabel(string text, float angle) {
            this.angle = angle;
            this.label_widget = new Gtk.Label(text);
            this.label_widget.set_parent(this);
        }

        public string label {
            get { return label_widget.label; }
            set { label_widget.label = value; }
        }

        ~RotatedLabel() {
            label_widget.unparent();
        }

        public override void snapshot(Gtk.Snapshot snapshot) {
            var width = (float)this.get_width();
            var height = (float)this.get_height();
            var transform = new Gsk.Transform();
            transform = transform.translate({
                x: width / 2,
                y: height / 2,
            });
            transform = transform.rotate(this.angle);
            transform = transform.translate({
                x: -width / 2,
                y: -height / 2,
            });
            snapshot.save();
            snapshot.transform(transform);
            base.snapshot(snapshot);
            snapshot.restore();
        }

        public override void measure(Gtk.Orientation orientation, int for_size,
                                     out int min, out int nat,
                                     out int min_baseline, out int nat_baseline) {
            int min_w, nat_w, min_h, nat_h, dummy1, dummy2;
            label_widget.measure(Gtk.Orientation.HORIZONTAL, -1, out min_w, out nat_w, out dummy1, out dummy2);
            label_widget.measure(Gtk.Orientation.VERTICAL, -1, out min_h, out nat_h, out dummy1, out dummy2);

            double rad = angle * Math.PI / 180.0;
            double cos_a = Math.fabs(Math.cos(rad));
            double sin_a = Math.fabs(Math.sin(rad));

            if (orientation == Gtk.Orientation.HORIZONTAL) {
                min = (int)Math.ceil(min_w * cos_a + min_h * sin_a);
                nat = (int)Math.ceil(nat_w * cos_a + nat_h * sin_a);
            } else {
                min = (int)Math.ceil(min_w * sin_a + min_h * cos_a);
                nat = (int)Math.ceil(nat_w * sin_a + nat_h * cos_a);
            }

            min_baseline = -1;
            nat_baseline = -1;
        }

        public override void size_allocate(int width, int height, int baseline) {
            int child_w, child_h, dummy1, dummy2;
            label_widget.measure(Gtk.Orientation.HORIZONTAL, -1, out dummy1, out child_w, out dummy1, out dummy2);
            label_widget.measure(Gtk.Orientation.VERTICAL, -1, out dummy1, out child_h, out dummy1, out dummy2);

            var transform = new Gsk.Transform();
            transform = transform.translate({
                x: (float)(width - child_w) / 2,
                y: (float)(height - child_h) / 2,
            });
            label_widget.allocate(child_w, child_h, -1, transform);
        }
    }
}
