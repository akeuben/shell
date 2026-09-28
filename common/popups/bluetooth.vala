namespace Kappashell {
    public class BluetoothPopup : PopupContent {
        public static BluetoothPopup create(ConfigNode config) throws PopupConfigError {
            return new BluetoothPopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);

            box.append(new Gtk.Label("Bluetooth"));

            return box;
        }
    }
}
