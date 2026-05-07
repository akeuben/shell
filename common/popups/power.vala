namespace Kappashell {
    public class PowerPopup : PopupContent {
        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var label = new Gtk.Label("Power Menu");
            return label;
        }
    }
}
