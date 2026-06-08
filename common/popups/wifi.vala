namespace Kappashell {
    public class WifiPopup : PopupContent {
        public static WifiPopup create(ConfigNode config) throws PopupConfigError {
            return new WifiPopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);

            box.append(new Gtk.Label("Wifi"));

            return box;
        }
    }
}
