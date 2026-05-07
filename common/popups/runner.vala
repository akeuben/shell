namespace Kappashell {
    public class RunnerPopup : PopupContent {
        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var label = new Gtk.Label("Runner");
            return label;
        }
    }
}
