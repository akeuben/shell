namespace Kappashell {

    public Gtk.Box ClientWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        return new HyprlandClientWidget(config, env);
    }

    public Gtk.Box InactiveClientsWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        return new HyprlandInactiveClientsWidget(config, env);
    }

    class HyprlandInactiveClientsWidget : Gtk.Box {
        AstalHyprland.Hyprland hyprland;
        AstalHyprland.Monitor monitor;

        public HyprlandInactiveClientsWidget(Json.Node config, WidgetEnvironment env) {
            this.hyprland = AstalHyprland.get_default();
            this.monitor = hyprland.get_monitor_by_name(env.monitor.get_connector());
            this.orientation = env.orientation;
            this.spacing = 10;

            hyprland.notify["clients"].connect(update_list);
            hyprland.notify["focused-client"].connect(update_list);
            monitor.notify["active-workspace"].connect(update_list);

            destroy.connect(() => {
                hyprland.notify.disconnect(update_list);
            });

            update_list();
        }

        void update_list() {
            var child = this.get_first_child();
            while(child != null) {
                remove(child);
                child = this.get_first_child();
            }

            foreach(var client in hyprland.clients) {
                if(monitor.active_workspace.clients.find_custom(client, compare_hypr_clients) == null)
                    continue;

                if(compare_hypr_clients(client, hyprland.focused_client) == 0)
                    continue;

                var btn = new Gtk.Button.from_icon_name(get_icon_name_for_hypr_client(client));

                btn.clicked.connect(() => client.focus());

                append(btn);
            }
        }
    }

    int compare_hypr_clients(AstalHyprland.Client a, AstalHyprland.Client b) {
        if(a.pid != b.pid) {
            return 1;
        }

        if(a.title != b.title) {
            return 1;
        }

        return 0;
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

                icon.set_from_icon_name(get_icon_name_for_hypr_client(hyprland.focused_client));
            };

            hyprland.notify["focused-client"].connect(() => update_label());

            update_label();

            append(icon);
            append(label);
            append(btn);
        }

    }

    string get_icon_name_for_hypr_client(AstalHyprland.Client client) {
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
