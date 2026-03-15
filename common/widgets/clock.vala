namespace Kappashell {
    public Gtk.Box ClockWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        var box = new Gtk.Box(env.orientation, 2);
        box.add_css_class("clock-container");

        var hour = new Gtk.Label("00");
        var min = new Gtk.Label("00");
        Gtk.Label? ampm = null;

        if(config.get_node_type() != Json.NodeType.OBJECT)
            throw new BarConfigError.WRONG_TYPE("clock config must be an object!");

        var c = config.get_object();

        var is_24_hour = use_24_hour_time() || c.get_boolean_member_with_default("24hour", false);

        if(!is_24_hour && !c.get_boolean_member_with_default("hide_ampm", false)){
            ampm = new Gtk.Label("AM");
            ampm.yalign = 1.0f;
        }

        hour.add_css_class("clock");
        hour.add_css_class("clock-hour");
        min.add_css_class("clock");
        min.add_css_class("clock-min");

        if(ampm != null) {
            ampm.add_css_class("clock");
            ampm.add_css_class("clock-ampm");
        }

        update(hour, min, is_24_hour, ampm);
        var interval = GLib.Timeout.add(100, () => {
            update(hour, min, is_24_hour, ampm);
            return Source.CONTINUE;
        }, GLib.Priority.DEFAULT);

        box.destroy.connect(() => {
            Source.remove(interval);
        });

        box.append(hour);
        box.append(min);

        if(ampm != null) {
            box.append(ampm);
        }

        return box;
    }
    
    bool use_24_hour_time() {
        var now = new GLib.DateTime.now_local();

        return !now.format("%X").contains("AM") && !now.format("%X").contains("PM") && false;
    }

    void update(Gtk.Label hour_label, Gtk.Label min_label, bool is_24_hour, Gtk.Label? ampm_label) {
        var now = new GLib.DateTime.now_local();

        var hour_str = now.format(is_24_hour ? "%H" : "%I");
        var min_str = "%02d".printf(now.get_minute());

        hour_label.set_label(hour_str);
        min_label.set_label(min_str);
    }
}
