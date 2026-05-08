namespace Kappashell {
    private HashTable<string, PopupContent> registered_popups;

    public struct PopupEnvironment {
        Gtk.Orientation orientation;
        Gdk.Monitor monitor;
        Popup popup;
    }

    public abstract class PopupContent : Object {
        public abstract Gtk.Widget build(PopupEnvironment environment);

        protected Gtk.Orientation orthogonal(Gtk.Orientation original) {
            return original == Gtk.Orientation.VERTICAL ? Gtk.Orientation.HORIZONTAL : Gtk.Orientation.VERTICAL;
        }

        protected Gtk.Align opposite(Gtk.Align align) {
            if(align == Gtk.Align.START) {
                return Gtk.Align.END;
            } else if(align == Gtk.Align.END) {
                return Gtk.Align.START;
            } else {
                return align;
            }
        }

        protected void clear_children(Gtk.Box box) {
            while (box.get_first_child() != null)
                box.remove(box.get_first_child());
        }

        protected string truncate(string s, int max) {
            return s.char_count() > max ? s.substring(0, s.index_of_nth_char(max)) + "…" : s;
        }
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
