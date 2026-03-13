public class WindowBar : Astal.Window {
    public WindowBar(Gdk.Monitor monitor) {
        namespace = "kappashell.desktop.bar.%s".printf("top");
        exclusivity = Astal.Exclusivity.EXCLUSIVE;
        layer = Astal.Layer.TOP;
        keymode = Astal.Keymode.NONE;
        gdkmonitor = monitor;
        anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT;

        child = new Gtk.Button.with_label("Test");

        present();
    }
}
