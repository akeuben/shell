namespace Kappashell {
    public Gtk.Widget RegionWidget(ConfigNode config, WidgetEnvironment env) throws BarConfigError {
        var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

        if(config.get_node_type() != ConfigNodeType.Object)
            throw new BarConfigError.WRONG_TYPE("Config must be an object");

        var c = config.get_object();
        var debug = c.get_bool_member_with_default("debug", false);

        box.hexpand = env.orientation == Gtk.Orientation.VERTICAL;
        box.vexpand = env.orientation == Gtk.Orientation.HORIZONTAL;

        if(env.orientation == Gtk.Orientation.HORIZONTAL) {
            box.width_request = c.get_integer_member_with_default("size", 100);
        } else if(env.orientation == Gtk.Orientation.VERTICAL) {
            box.height_request = c.get_integer_member_with_default("size", 100);
        }

        if(!c.has_string_member("action_type")) {
            throw new BarConfigError.MISSING_VALUE("Button Widget config must have a action_type (string)");
        }

        if(!c.has_string_member("action")) {
            throw new BarConfigError.MISSING_VALUE("Button Widget config must have a action (string)");
        }

        var action_type = c.get_string_member("action_type");
        var action = c.get_string_member("action");

        var btn = new Gtk.GestureClick();
        box.add_controller(btn);

        if(action_type == "action") {
            btn.released.connect(() => KappashellApplication.instance.run_action("> " + action));
        } else if(action_type == "shell") {
            btn.released.connect(() => printerr("TODO!\n"));
        } else {
            throw new BarConfigError.WRONG_TYPE("Button Widget action must be one of `action` or `shell`");
        }

        if(debug) {
            box.add_css_class("debug");
        }
        
        box.add_css_class("region");
        return box;
    }
}
