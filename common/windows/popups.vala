namespace Kappashell {
    public class PopupSet {
        private Popup left;
        private Popup right;
        private Popup top;
        private Popup bottom;

        public PopupSet(Gdk.Monitor monitor) {
            left = new Popup(monitor, Astal.WindowAnchor.LEFT);
            right = new Popup(monitor, Astal.WindowAnchor.RIGHT);
            top = new Popup(monitor, Astal.WindowAnchor.TOP);
            bottom = new Popup(monitor, Astal.WindowAnchor.BOTTOM);
        }

        public void add_windows(Gtk.Application application) {
            application.add_window(top);
            application.add_window(bottom);
            application.add_window(left);
            application.add_window(right);
        }
    }

    public class Popup : Astal.Window {
        public Popup(Gdk.Monitor monitor, Astal.WindowAnchor anchor) {
            this.gdkmonitor = monitor;
            this.anchor = anchor;
            this.namespace = "kappashell.desktop.popup.%s".printf(name(anchor));
            this.exclusivity = Astal.Exclusivity.NORMAL;
            set_default_size(1, 1);

            var revealer = new Gtk.Revealer();
    
            var btn = new Gtk.Button();
            btn.label = "test";

            revealer.set_child(btn);

            revealer.reveal_child = true;

            set_child(revealer);

            present();
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
}
