namespace Kappashell {
    public class ClockPopup : PopupContent {
        public static ClockPopup create(ConfigNode config) throws PopupConfigError {
            return new ClockPopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);

            box.append(new Gtk.Label("Clock"));

            return box;
        }
    }
}
