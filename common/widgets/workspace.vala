namespace Kappashell {
    public Gtk.Box WorkspaceWidget(ConfigNode config, WidgetEnvironment env) throws BarConfigError {
        return new HyprlandWorkspaceWidget(config, env);
    }

    class HyprlandWorkspaceWidget : Gtk.Box {
        AstalHyprland.Hyprland hyprland;
        AstalHyprland.Monitor? monitor = null;
        Gdk.Monitor gdk_monitor;

        ulong workspace_added_id = 0;
        ulong workspace_removed_id = 0;
        ulong monitor_added_id = 0;
        ulong active_workspace_id = 0;

        public HyprlandWorkspaceWidget(ConfigNode config, WidgetEnvironment env) {
            orientation = env.orientation;
            spacing = 10;
            add_css_class("bar-item");

            hyprland = AstalHyprland.get_default();
            gdk_monitor = env.monitor;

            // Method handlers (not lambdas): weak ref to `this`, so dispose() can run
            workspace_added_id = hyprland.workspace_added.connect(on_workspaces_changed);
            workspace_removed_id = hyprland.workspace_removed.connect(on_workspaces_changed);
            monitor_added_id = hyprland.monitor_added.connect(on_monitor_added);

            try_attach_monitor();
        }

        public override void dispose() {
            if (workspace_added_id != 0) {
                SignalHandler.disconnect(hyprland, workspace_added_id);
                workspace_added_id = 0;
            }
            if (workspace_removed_id != 0) {
                SignalHandler.disconnect(hyprland, workspace_removed_id);
                workspace_removed_id = 0;
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

            // Drop children (and their click handlers) before chaining up
            var child = get_first_child();
            while (child != null) {
                remove(child);
                child = get_first_child();
            }

            base.dispose(); // dispose can run more than once; everything above is idempotent
        }

        void on_workspaces_changed() {
            update_indicators();
        }

        void on_monitor_added() {
            try_attach_monitor();
        }

        void on_active_workspace_changed(Object o, ParamSpec p) {
            update_highlights();
        }

        void on_workspace_clicked(Gtk.Button btn) {
            if (monitor == null) return;
            var workspace = btn.get_data<AstalHyprland.Workspace>("workspace");
            if (workspace == null) return;
            workspace.move_to(monitor);
            workspace.focus();
        }

        void try_attach_monitor() {
            if (monitor != null) return;

            var connector = gdk_monitor.get_connector();
            if (connector == null) return;          // GDK not ready; monitor_added will retry

            monitor = hyprland.get_monitor_by_name(connector);
            if (monitor == null) return;            // Hyprland hasn't announced it yet

            active_workspace_id = monitor.notify["active-workspace"].connect(on_active_workspace_changed);
            update_indicators();
        }

        void update_indicators() {
            if (monitor == null) return;

            var child = get_first_child();
            while (child != null) {
                remove(child);
                child = get_first_child();
            }

            var workspaces = hyprland.workspaces;
            workspaces.sort((a, b) => a.id - b.id);

            var active = monitor.active_workspace;
            foreach (var workspace in workspaces) {
                var btn = new Gtk.Button();
                btn.set_size_request(10, 10);
                btn.add_css_class("workspace");
                btn.hexpand = false;
                btn.vexpand = false;
                btn.halign = Gtk.Align.CENTER;
                btn.valign = Gtk.Align.CENTER;
                btn.set_data<AstalHyprland.Workspace>("workspace", workspace);

                if (active != null && active.id == workspace.id) {
                    btn.add_css_class("active");
                }

                btn.clicked.connect(on_workspace_clicked);
                append(btn);
            }
        }

        void update_highlights() {
            if (monitor == null) return;
            var active = monitor.active_workspace;

            var child = get_first_child();
            while (child != null) {
                var workspace = child.get_data<AstalHyprland.Workspace>("workspace");
                if (active != null && workspace != null && active.id == workspace.id) {
                    child.add_css_class("active");
                } else {
                    child.remove_css_class("active");
                }
                child = child.get_next_sibling();
            }
        }
    }
}
