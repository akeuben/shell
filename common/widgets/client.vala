namespace Kappashell {

    public Gtk.Box ClientWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        return new HyprlandClientWidget(config, env);
    }

    class HyprlandClientWidget : Gtk.Box {

        AstalHyprland.Hyprland hyprland;
        
        public HyprlandClientWidget(Json.Node config, WidgetEnvironment env) {
            this.hyprland = AstalHyprland.get_default();
            this.orientation = env.orientation;
            this.spacing = 10;
            this.add_css_class("bar-item");
            this.add_css_class("client");

            var icon = new Gtk.Image();
            icon.pixel_size = 24;
            var label = new RotatedLabel("", 90);
            var btn = new Gtk.Button();
            btn.icon_name = "close-symbolic";

            NotifyHandler update_label = () => {
                if(hyprland.focused_client == null) {
                    label.label = "";
                    visible = false;
                    return;
                }

                label.label = hyprland.focused_client.title;
                visible = true;
                if(label.label.length > 25) {
                    label.label = "%s...".printf(label.label.substring(0, 25));
                }

                icon.set_from_icon_name(get_icon_name_for_client(hyprland.focused_client));
            };

            hyprland.notify["focused-client"].connect(() => update_label());

            update_label();

            append(icon);
            append(label);
            append(btn);
        }

        string get_icon_name_for_client(AstalHyprland.Client client) {
            var app_id = client.initial_class ?? client.class;
            if (app_id == null) return "application-x-executable";

            var icon_theme = Gtk.IconTheme.get_for_display(Gdk.Display.get_default());
            if (icon_theme.has_icon(app_id)) return app_id;

            var lower = app_id.down();
            if (icon_theme.has_icon(lower)) return lower;

            var app_info = new GLib.DesktopAppInfo(app_id + ".desktop")
                ?? new GLib.DesktopAppInfo(lower + ".desktop");

            if (app_info != null) {
                var icon = app_info.get_icon();
                if (icon is GLib.ThemedIcon) {
                    return ((GLib.ThemedIcon)icon).get_names()[0];
                }
            }

            return "application-x-executable";
        }
    }
}
