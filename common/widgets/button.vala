namespace Kappashell {
    public Gtk.Button ButtonWidget(ConfigNode config, WidgetEnvironment env) throws BarConfigError {
        var btn = new Gtk.Button();
        var image = new Gtk.Image();
        
        image.icon_name = "error-app-symbolic";
        image.pixel_size = 16;

        if(env.orientation == Gtk.Orientation.VERTICAL) {
            image.margin_top = 10;
            image.margin_bottom = 10;
        } else {
            image.margin_start = 10;
            image.margin_end = 10;
        }

        if(config.get_node_type() != ConfigNodeType.Object) {
            throw new BarConfigError.WRONG_TYPE("Button Widget config must be a composite object");
        }
        var c = config.get_object();
        image.icon_name = c.get_string_member_with_default("icon", "error-app-symbolic");
        image.pixel_size = (int) c.get_integer_member_with_default("size", 16);

        if(!c.has_string_member("action_type")) {
            throw new BarConfigError.MISSING_VALUE("Button Widget config must have a action_type (string)");
        }

        if(!c.has_string_member("action")) {
            throw new BarConfigError.MISSING_VALUE("Button Widget config must have a action (string)");
        }

        var action_type = c.get_string_member("action_type");
        var action = c.get_string_member("action");

        if(action_type == "action") {
            btn.clicked.connect(() => KappashellApplication.instance.run_action("> " + action));
        } else if(action_type == "shell") {
            btn.clicked.connect(() => printerr("TODO!\n"));
        } else {
            throw new BarConfigError.WRONG_TYPE("Button Widget action must be one of `action` or `shell`");
        }

        btn.child = image;
        return btn;
    }
}
