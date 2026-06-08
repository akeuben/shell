namespace Kappashell {
    public class BatteryPopup : PopupContent {
        public static BatteryPopup create(ConfigNode config) throws PopupConfigError {
            return new BatteryPopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);

            box.append(new Gtk.Label("Battery"));

            return box;
        }
    }
}
