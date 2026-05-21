namespace Kappashell {
    [CCode (has_target = false)]
    public delegate PopupContent PopupConstructor(ConfigNode config) throws PopupConfigError;

    private HashTable<string, RegisteredPopup?> registered_popup_types;
    public struct RegisteredPopup {
        public string name;
        public PopupConstructor constructor;
    }

    public errordomain PopupConfigError {
        WRONG_TYPE,
        MISSING_VALUE,
    }

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

    public void register_popup_type(string name, PopupConstructor constructor) {
        if(registered_popup_types == null) {
            registered_popup_types = new HashTable<string, RegisteredPopup?>((a) => a.hash(), (a, b) => a == b);
        }

        registered_popup_types.set(name, {
            name: name,
            constructor: constructor,
        });
    }

    public RegisteredPopup lookup_popup_type(string name) {
        if(registered_popup_types == null) {
            registered_popup_types = new HashTable<string, RegisteredPopup?>((a) => a.hash(), (a, b) => a == b);
        }
        
        return registered_popup_types.lookup(name);
    }

    public bool popup_type_exists(string name) {
        if(registered_popup_types == null) {
            registered_popup_types = new HashTable<string, RegisteredPopup?>((a) => a.hash(), (a, b) => a == b);
        }

        return registered_popup_types.contains(name);
    }

    public GLib.List<weak string> popup_type_list() {
        if(registered_popup_types == null) {
            registered_popup_types = new HashTable<string, RegisteredPopup?>((a) => a.hash(), (a, b) => a == b);
        }

        return registered_popup_types.get_keys();
    }
}
