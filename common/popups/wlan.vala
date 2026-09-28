namespace Kappashell {
    public class WlanPopup : PopupContent {
        public static WlanPopup create(ConfigNode config) throws PopupConfigError {
            return new WlanPopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);

            box.append(new Gtk.Label("Wlan"));

            return box;
        }
    }
}
