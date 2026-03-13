namespace Kappashell {
    public class BarSet {
        private Bar top;
        private Bar bottom;
        private Bar left;
        private Bar right;
        private Overlay overlay;

        public BarSet(Gdk.Monitor monitor) {
            top = new Bar(monitor, Astal.WindowAnchor.TOP);
            bottom = new Bar(monitor, Astal.WindowAnchor.BOTTOM);
            left = new Bar(monitor, Astal.WindowAnchor.LEFT);
            right = new Bar(monitor, Astal.WindowAnchor.RIGHT);
            overlay = new Overlay(monitor);
        }

        public void add_windows(Gtk.Application application) {
            application.add_window(top);
            application.add_window(bottom);
            application.add_window(left);
            application.add_window(right);
            application.add_window(overlay);
        }
        
    }

    class Bar : Astal.Window {
        public Bar(Gdk.Monitor monitor, Astal.WindowAnchor mainAnchor) {
            namespace = "kappashell.desktop.bar.%s".printf(name(mainAnchor));
            exclusivity = Astal.Exclusivity.EXCLUSIVE;
            layer = Astal.Layer.TOP;
            keymode = Astal.Keymode.NONE;
            gdkmonitor = monitor;
            anchor = adjacent(mainAnchor);

            var cbox = new Gtk.CenterBox();
            cbox.orientation = orientation(mainAnchor);
            
            var btn = new Gtk.Button.with_label("Test");
            btn.clicked.connect (() => {
                print("Hello, world!");
            });

            cbox.center_widget = btn;
            
            set_child(cbox);

            add_css_class("bar");

            present();
        }

        private static Astal.WindowAnchor adjacent(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP) {
                return Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT;
            }
            if(anchor == Astal.WindowAnchor.BOTTOM) {
                return Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT;
            }
            if(anchor == Astal.WindowAnchor.LEFT) {
                return Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT;
            }
            if(anchor == Astal.WindowAnchor.RIGHT) {
                return Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT;
            }

            return 0;
        }

        private static Gtk.Orientation orientation(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP || anchor == Astal.WindowAnchor.BOTTOM) {
                return Gtk.Orientation.HORIZONTAL;
            }
            return Gtk.Orientation.VERTICAL;
        }

        private static new string name(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP) {
                return "top";
            }
            if(anchor == Astal.WindowAnchor.BOTTOM) {
                return "bottom";
            }
            if(anchor == Astal.WindowAnchor.LEFT) {
                return "left";
            }
            if(anchor == Astal.WindowAnchor.RIGHT) {
                return "right";
            }

            GLib.error("Invalid side passed to Bar::name");

        }
    }

    class Overlay : Astal.Window {
        public Overlay(Gdk.Monitor monitor) {
            namespace = "kappashell.desktop.bar.overlay";
            exclusivity = Astal.Exclusivity.NORMAL;
            layer = Astal.Layer.TOP;
            keymode = Astal.Keymode.NONE;
            gdkmonitor = monitor;
            anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT;

            present();

            var grid = new Gtk.Grid();

            child = grid;

            grid.hexpand = true;
            grid.vexpand = true;

            var fake1 = new Astal.Bin();
            var fake2 = new Astal.Bin();

            fake1.hexpand = true;
            fake1.vexpand = true;

            fake2.hexpand = true;
            fake2.vexpand = true;

            grid.attach(fake1, 0, 1, 1, 1);
            grid.attach(fake2, 1, 0, 1, 1);

            grid.attach(new InvertedCorner(35, Corner.TOP_LEFT), 0, 0, 1, 1);
            grid.attach(new InvertedCorner(35, Corner.TOP_RIGHT), 2, 0, 1, 1);
            grid.attach(new InvertedCorner(35, Corner.BOTTOM_LEFT), 0, 2, 1, 1);
            grid.attach(new InvertedCorner(35, Corner.BOTTOM_RIGHT), 2, 2, 1, 1);
            

            Cairo.RectangleInt rect = {
                x: 0,
                y: 0,
                width: 0,
                height: 10,
            };

            add_css_class("overlay");

            var region = new Cairo.Region.rectangle(rect);

            get_native().get_surface().set_input_region(region);
        }
    }
}
