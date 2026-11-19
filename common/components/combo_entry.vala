/* Compile with your app: valac --pkg gtk4 combo_entry.vala your_app.vala
 * Needs GTK 4.12+ (Gtk.ListView.scroll_to).
 *
 * ComboEntry<T> is a text entry with a dropdown list of arbitrary objects.
 * The label function turns each T into the string shown in the list and
 * used for filtering. T should be a reference type (class instance, string).
 */

public delegate string LabelFunc<T> (T item);

/* Type-agnostic row used by the list model; maps back to T by index. */
internal class ComboRow : Object {
    public string label { get; construct; }
    public uint index { get; construct; }

    public ComboRow (string label, uint index) {
        Object (label: label, index: index);
    }
}

public class ComboEntry<T> : Gtk.Box {
    private LabelFunc<T> label_func;
    private GenericArray<T> values;
    private int picked = -1;

    public Gtk.Entry entry { public get; private set; }
    private Gtk.Popover? popover;
    private Gtk.ListView list_view;
    private GLib.ListStore store;
    private Gtk.StringFilter filter;
    private Gtk.FilterListModel filtered;
    private Gtk.SingleSelection selection;
    private bool updating = false;
    private bool hovering = false;
    private Gtk.EventControllerFocus focus_controller;

    /** Current text, whether typed or picked from the list. */
    public string text {
        get { return entry.text; }
        set { set_text_silently (value); }
    }

    /**
     * Emitted when the user picks a row or presses Enter.
     * item is the matching object, or null for free-form text.
     */
    public signal void activated (string text, T? item);

    public ComboEntry (owned LabelFunc<T> label_func) {
        Object ();
        this.label_func = (owned) label_func;
    }

    construct {
        orientation = Gtk.Orientation.HORIZONTAL;

        values = new GenericArray<T> ();
        store = new GLib.ListStore (typeof (ComboRow));

        var expression = new Gtk.PropertyExpression (typeof (ComboRow), null, "label");
        filter = new Gtk.StringFilter (expression) {
            ignore_case = true,
            match_mode = Gtk.StringFilterMatchMode.SUBSTRING
        };
        filtered = new Gtk.FilterListModel (store, filter);
        selection = new Gtk.SingleSelection (filtered) {
            autoselect = false,
            can_unselect = true
        };

        var factory = new Gtk.SignalListItemFactory ();
        factory.setup.connect ((obj) => {
            var list_item = (Gtk.ListItem) obj;
            list_item.child = new Gtk.Label (null) {
                xalign = 0,
                margin_start = 6,
                margin_end = 6,
                margin_top = 6,
                margin_bottom = 6
            };
        });
        factory.bind.connect ((obj) => {
            var list_item = (Gtk.ListItem) obj;
            var label = (Gtk.Label) list_item.child;
            label.label = ((ComboRow) list_item.item).label;
        });

        list_view = new Gtk.ListView (selection, factory) {
            single_click_activate = true,
            can_focus = false
        };
        list_view.activate.connect ((position) => commit (position));

        var scrolled = new Gtk.ScrolledWindow () {
            child = list_view,
            hscrollbar_policy = Gtk.PolicyType.NEVER,
            propagate_natural_height = true,
            max_content_height = 240
        };

        entry = new Gtk.Entry () {
            hexpand = true,
            secondary_icon_name = "pan-down-symbolic",
            secondary_icon_activatable = true
        };
        append (entry);

        popover = new Gtk.Popover () {
            has_arrow = false,
            autohide = false,        // keep keyboard focus in the entry
            can_focus = false,       // also covers descendants
            position = Gtk.PositionType.BOTTOM,
            halign = Gtk.Align.START,
            child = scrolled
        };
        popover.add_css_class ("menu");
        popover.set_parent (this);

        entry.changed.connect (on_text_changed);
        entry.activate.connect (() => {
            popover.popdown ();
            activated (entry.text, get_selected_item ());
        });
        entry.icon_press.connect ((icon_pos) => {
            if (icon_pos != Gtk.EntryIconPosition.SECONDARY) return;
            if (popover.visible) {
                popover.popdown ();
                return;
            }
            filter.search = "";                      // arrow shows the full list
            selection.selected = Gtk.INVALID_LIST_POSITION;
            entry.grab_focus_without_selecting ();
            show_popup ();
        });

        var keys = new Gtk.EventControllerKey () {
            propagation_phase = Gtk.PropagationPhase.CAPTURE
        };
        keys.key_pressed.connect (on_key_pressed);
        entry.add_controller (keys);

        var motion = new Gtk.EventControllerMotion ();
        motion.enter.connect ((x, y) => hovering = true);
        motion.leave.connect (() => hovering = false);
        ((Gtk.Widget) popover).add_controller (motion);
        popover.closed.connect (() => hovering = false);

        focus_controller = new Gtk.EventControllerFocus ();
        focus_controller.leave.connect (on_focus_leave);
        entry.add_controller (focus_controller);
    }

    public void set_items (List<T> items) {
        var array = new GenericArray<T> ();
        foreach (unowned T item in items) {
            array.add (item);
        }
        replace_items ((owned) array);
    }

    public void set_items_array (T[] items) {
        var array = new GenericArray<T> ();
        foreach (unowned T item in items) {
            array.add (item);
        }
        replace_items ((owned) array);
    }

    /**
     * The object matching the current text: the row last picked, or
     * the first item whose label equals the text. Null for free-form text.
     */
    public T? get_selected_item () {
        if (picked >= 0 && picked < values.length) {
            return values[picked];
        }
        for (uint i = 0; i < store.get_n_items (); i++) {
            var row = (ComboRow) store.get_item (i);
            if (row.label == entry.text) {
                return values[(int) row.index];
            }
        }
        return null;
    }

    public override void dispose () {
        if (popover != null) {
            popover.unparent ();
            popover = null;
        }
        base.dispose ();
    }

    private void replace_items (owned GenericArray<T> array) {
        values = (owned) array;
        picked = -1;

        Object[] rows = {};
        for (int i = 0; i < values.length; i++) {
            rows += new ComboRow (label_func (values[i]), (uint) i);
        }
        store.splice (0, store.get_n_items (), rows);
    }

    /* Close when focus moves to another widget, however that happens
     * (Tab, click, a programmatic grab_focus ()). Entering the popover's own
     * surface, or the window deactivating, can also report a focus leave
     * while focus stays on our entry; in that case only close if the pointer
     * isn't over the popover. */
    private void on_focus_leave () {
        Idle.add (() => {
            if (popover == null || !popover.visible) return Source.REMOVE;
            if (focus_controller.contains_focus) return Source.REMOVE;

            var root = get_root ();
            var focused = (root != null) ? root.get_focus () : null;
            bool moved_elsewhere = focused != null
                && focused != this
                && !focused.is_ancestor (this);

            if (moved_elsewhere || !hovering) {
                popover.popdown ();
            } else {
                entry.grab_focus_without_selecting ();
            }
            return Source.REMOVE;
        });
    }

    private void set_text_silently (string value) {
        updating = true;
        entry.text = value;
        entry.set_position (-1);
        updating = false;
    }

    private void on_text_changed () {
        if (updating) return;

        picked = -1;

        /* Text set from code (e.g. on the underlying entry) while the entry
         * isn't focused must not pop the list open. */
        if (!focus_controller.contains_focus) {
            popover.popdown ();
            return;
        }

        filter.search = entry.text;
        selection.selected = Gtk.INVALID_LIST_POSITION;

        if (filtered.get_n_items () > 0) {
            show_popup ();
        } else {
            popover.popdown ();
        }
    }

    private void show_popup () {
        if (filtered.get_n_items () == 0) return;
        popover.width_request = get_width ();
        popover.popup ();
    }

    private void commit (uint position) {
        var row = filtered.get_item (position) as ComboRow;
        if (row == null) return;

        set_text_silently (row.label);
        picked = (int) row.index;
        popover.popdown ();
        activated (row.label, values[picked]);
    }

    private void move_selection (int delta) {
        if (!popover.visible) show_popup ();

        uint count = filtered.get_n_items ();
        if (count == 0) return;

        uint current = selection.selected;
        uint next;
        if (current == Gtk.INVALID_LIST_POSITION) {
            next = delta > 0 ? 0 : count - 1;
        } else {
            next = (uint) ((int) current + delta).clamp (0, (int) count - 1);
        }

        selection.selected = next;
        list_view.scroll_to (next, Gtk.ListScrollFlags.NONE, null);
    }

    private bool on_key_pressed (uint keyval, uint keycode, Gdk.ModifierType state) {
        switch (keyval) {
            case Gdk.Key.Down:
                move_selection (1);
                return true;
            case Gdk.Key.Up:
                move_selection (-1);
                return true;
            case Gdk.Key.Escape:
                if (popover.visible) {
                    popover.popdown ();
                    return true;
                }
                return false;
            case Gdk.Key.Return:
            case Gdk.Key.KP_Enter:
                if (popover.visible && selection.selected != Gtk.INVALID_LIST_POSITION) {
                    commit (selection.selected);
                    return true;
                }
                return false;     // no row selected: entry's own "activate" fires
            default:
                return false;
        }
    }
}
