namespace Kappashell {
    public class PowerPopup : PopupContent {

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box (environment.orientation, 10);

            box.append(create_systemctl_button("system-shutdown-symbolic", "poweroff"));
            box.append(create_systemctl_button("system-suspend-symbolic", "sleep"));
            box.append(create_systemctl_button("system-suspend-hibernate-symbolic", "hibernate"));
            box.append(create_cmd_button("lock-symbolic", "echo todo"));

            return box;
        }

        private static Gtk.Button create_systemctl_button(string icon, string cmd) {
            var btn = new Gtk.Button.from_icon_name(icon);
            ((Gtk.Image) btn.child).pixel_size = 24;
            btn.clicked.connect(() => systemctl(cmd));
            btn.tooltip_text = cmd;

            return btn;
        }

        private static Gtk.Button create_cmd_button(string icon, string cmd) {
            var btn = new Gtk.Button.from_icon_name(icon);
            ((Gtk.Image) btn.child).pixel_size = 24;
            btn.clicked.connect(() => {
                try {
                    GLib.Process.spawn_command_line_async(cmd);
                } catch(Error e) {

                }
            });
            btn.tooltip_text = cmd;

            return btn;
        }

        private static void systemctl(string cmd) {
            try {
                GLib.Process.spawn_command_line_async ("systemctl %s".printf(cmd));
            } catch (Error e) {

            }
        }
    }
}
