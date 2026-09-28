namespace Kappashell {
    public class ErrorWindow : Astal.Window {
        private GLib.List<string> error_message;

        public ErrorWindow() {
            anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT;
            exclusivity = Astal.Exclusivity.IGNORE;
            add_css_class("error-window");

            present();
            rebuild();
        }

        public void reset() {
            while(!error_message.is_empty()) {
                error_message.remove(error_message.first().data);
            }
            rebuild();
        }

        public void add_error(string error) {
            error_message.append(error);
            rebuild();
        }

        private void rebuild() {
            if(error_message.length() > 0) {
                visible = true;
            } else {
                visible = false;
            }

            var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            
            foreach(var item in error_message) {
                box.append(new Gtk.Label(item));
            }

            child = box;
        }
    }
}
