namespace Kappashell {
    public class MusicPopup : PopupContent {
        public static MusicPopup create(ConfigNode config) throws PopupConfigError {
            return new MusicPopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);

            box.append(new Gtk.Label("Music"));

            return box;
        }
    }
}
