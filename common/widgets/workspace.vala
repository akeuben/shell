namespace Kappashell {
    public Gtk.Box WorkspaceWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        return HyprlandWorkspaceWidget(config, env);
    }

    public Gtk.Box HyprlandWorkspaceWidget(Json.Node config, WidgetEnvironment env) {
        var box = new Gtk.Box(env.orientation, 10);

        return box;
    }
    
}
