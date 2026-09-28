namespace Kappashell {
    public class PhonePopup : PopupContent {
        public static PhonePopup create(ConfigNode config) throws PopupConfigError {
            return new PhonePopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);

            box.append(new Gtk.Label("Phone"));

            return box;
        }
    }
}
