namespace Kappashell {
    public Gtk.Box WorkspaceWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        return new HyprlandWorkspaceWidget(config, env);
    }

    class HyprlandWorkspaceWidget : Gtk.Box {
        AstalHyprland.Monitor monitor;
        AstalHyprland.Hyprland hyprland;

        public HyprlandWorkspaceWidget(Json.Node config, WidgetEnvironment env) {
            orientation = env.orientation;
            spacing = 10;

            hyprland = AstalHyprland.get_default();
            monitor = hyprland.get_monitor_by_name(env.monitor.get_connector());
            
            add_css_class("bar-item");
            update_indicators();

            hyprland.workspace_added.connect(() => update_indicators());
            hyprland.workspace_removed.connect(() => update_indicators());

            monitor.notify.connect(() => update_highlights());
        }

        void update_indicators() {
            // Remove old indicators
            var child = get_first_child();
            while(child != null) {
                remove(child);
                child = get_first_child();
            }

            var workspaces = hyprland.workspaces;

            workspaces.sort((a, b) => a.id - b.id);

            foreach(var workspace in workspaces) {
                var btn = new Gtk.Button();
                btn.set_size_request(10, 10);
                btn.add_css_class("workspace");
                btn.hexpand = false;
                btn.vexpand = false;
                btn.halign = Gtk.Align.CENTER;
                btn.valign = Gtk.Align.CENTER;
                btn.set_data<AstalHyprland.Workspace>("workspace", workspace);
                // TODO: Cursor 

                if(monitor.active_workspace.id == workspace.id) {
                    btn.add_css_class("active");
                }

                btn.clicked.connect(() => {
                    workspace.move_to(monitor);
                    workspace.focus();
                });

                append(btn);
            }

        }

        void update_highlights() {
            var child = get_first_child();
            while(child != null) {
                var workspace = child.get_data<AstalHyprland.Workspace>("workspace");
                
                if(monitor.active_workspace.id == workspace.id) {
                    child.add_css_class("active");
                } else {
                    child.remove_css_class("active");
                }
                
                child = child.get_next_sibling();
            }
        }

    }
}
