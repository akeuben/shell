namespace Kappashell {
    private HashTable<string, PopupContent> registered_popups;

    public struct PopupEnvironment {
        Gtk.Orientation orientation;
        Gdk.Monitor monitor;
        Popup popup;
    }

    public abstract class PopupContent : Object {
        public abstract Gtk.Widget build(PopupEnvironment environment);
    }

    public void register_popup(string name, PopupContent content) {
        if(registered_popups == null) {
            registered_popups = new HashTable<string, PopupContent>((a) => a.hash(), (a, b) => a == b);
        }

        registered_popups.set(name, content);
    }

    public PopupContent lookup_popup(string name) {
        return registered_popups.lookup(name);
    }

    public bool popup_exists(string name) {
        return registered_popups.contains(name);
    }

    public GLib.List<weak string> popup_list() {
        return registered_popups.get_keys();
    }
}
