namespace Kappashell {

    public Gtk.Box ClientWidget(ConfigNode config, WidgetEnvironment env) throws BarConfigError {
        return new HyprlandClientWidget(config, env);
    }

    public Gtk.Box InactiveClientsWidget(ConfigNode config, WidgetEnvironment env) throws BarConfigError {
        return new HyprlandInactiveClientsWidget(config, env);
    }

    class HyprlandInactiveClientsWidget : Gtk.Box {
        AstalHyprland.Hyprland hyprland;
        AstalHyprland.Monitor? monitor = null;
        Gdk.Monitor gdk_monitor;

        ulong clients_id = 0;
        ulong focused_id = 0;
        ulong monitor_added_id = 0;
        ulong active_workspace_id = 0;

        public HyprlandInactiveClientsWidget(ConfigNode config, WidgetEnvironment env) {
            orientation = env.orientation;
            spacing = 10;

            hyprland = AstalHyprland.get_default();
            gdk_monitor = env.monitor;

            // Method handlers (not lambdas): weak ref to `this`
            clients_id = hyprland.notify["clients"].connect(on_changed);
            focused_id = hyprland.notify["focused-client"].connect(on_changed);
            monitor_added_id = hyprland.monitor_added.connect(on_monitor_added);

            try_attach_monitor();
        }

        public override void dispose() {
            if (clients_id != 0) {
                SignalHandler.disconnect(hyprland, clients_id);
                clients_id = 0;
            }
            if (focused_id != 0) {
                SignalHandler.disconnect(hyprland, focused_id);
                focused_id = 0;
            }
            if (monitor_added_id != 0) {
                SignalHandler.disconnect(hyprland, monitor_added_id);
                monitor_added_id = 0;
            }
            if (monitor != null && active_workspace_id != 0) {
                SignalHandler.disconnect(monitor, active_workspace_id);
            }
            active_workspace_id = 0;
            monitor = null;

            clear_children();
            base.dispose();
        }

        void on_changed() {
            update_list();
        }

        void on_monitor_added() {
            try_attach_monitor();
        }

        void try_attach_monitor() {
            if (monitor != null) return;

            var connector = gdk_monitor.get_connector();
            if (connector == null) return;          // GDK not ready; monitor_added will retry

            monitor = hyprland.get_monitor_by_name(connector);
            if (monitor == null) return;            // Hyprland hasn't announced it yet

            active_workspace_id = monitor.notify["active-workspace"].connect(on_changed);
            update_list();
        }

        void clear_children() {
            var child = get_first_child();
            while (child != null) {
                remove(child);
                child = get_first_child();
            }
        }

        void update_list() {
            clear_children();
            if (monitor == null) return;

            var workspace = monitor.active_workspace;
            if (workspace == null) return;

            var focused = hyprland.focused_client;

            foreach (var client in hyprland.clients) {
                if (workspace.clients.find_custom(client, compare_hypr_clients) == null)
                    continue;

                if (focused != null && compare_hypr_clients(client, focused) == 0)
                    continue;

                var btn = new Gtk.Button.from_icon_name(get_icon_name_for_hypr_client(client));
                btn.tooltip_text = client.title;
                ((Gtk.Image) btn.child).pixel_size = 24;

                btn.clicked.connect(client.focus);

                append(btn);
            }
        }
    }

    int compare_hypr_clients(AstalHyprland.Client a, AstalHyprland.Client b) {
        return (a.address == b.address) ? 0 : 1;
    }

    class HyprlandClientWidget : Gtk.Box {
        AstalHyprland.Hyprland hyprland;
        RotatedLabel label;
        Gtk.Image icon;
        ulong focused_id = 0;

        public HyprlandClientWidget(ConfigNode config, WidgetEnvironment env) {
            this.hyprland = AstalHyprland.get_default();
            this.orientation = env.orientation;
            this.spacing = 10;
            this.add_css_class("bar-item");
            this.add_css_class("client");

            icon = new Gtk.Image();
            icon.pixel_size = 24;
            label = new RotatedLabel("", 90);

            var btn = new Gtk.Button();
            btn.icon_name = "window-close-symbolic";
            btn.clicked.connect(on_kill_clicked);   // named method, not a lambda

            focused_id = hyprland.notify["focused-client"].connect(update_label);

            update_label();

            append(icon);
            append(label);
            append(btn);
        }

        public override void dispose() {
            if (focused_id != 0) {
                SignalHandler.disconnect(hyprland, focused_id);
                focused_id = 0;
            }
            base.dispose();   // GtkBox unparents its children
        }

        void on_kill_clicked() {
            var client = hyprland.focused_client;
            if (client != null) client.kill();
        }

        void update_label() {
            var client = hyprland.focused_client;
            if (client == null) {
                label.label = "";
                visible = false;
                return;
            }

            var title = client.title ?? "";
            if (title.char_count() > 25) {
                title = title.substring(0, title.index_of_nth_char(25)) + "...";
            }

            label.label = title;
            visible = true;
            icon.set_from_icon_name(get_icon_name_for_hypr_client(client));
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
