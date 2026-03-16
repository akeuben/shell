namespace Kappashell {
    public void setup_css(string? custom_sheet_location) {
        var provider = new Gtk.CssProvider();
        provider.load_from_resource("/styles/common.css");
        if(custom_sheet_location != null) {
            provider.load_from_resource(custom_sheet_location);
        }

        Gtk.StyleContext.add_provider_for_display(
            Gdk.Display.get_default(),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_USER
        );

        register_widget("logo", LogoWidget);
        register_widget("clock", ClockWidget);
        register_widget("workspace", WorkspaceWidget);
        register_widget("indicators", IndicatorsWidget);
    }    

    public delegate void OnConfigChanged(Json.Node json);
    public delegate void OnConfigError(GLib.Error error);

    public void setup_config_monitor(string path, OnConfigChanged changed, OnConfigError error) {
        var file = GLib.File.new_for_path(path);
        try {
            var monitor = file.monitor(GLib.FileMonitorFlags.NONE, null);
            monitor.ref();
            monitor.rate_limit = 100;

            monitor.changed.connect((file, other, type) => {
                if(type != GLib.FileMonitorEvent.CHANGED) 
                    return;
                read_config(path, changed, error);
            });
        } catch(GLib.Error e) {
            error(e);
            return;
        }
        
        GLib.Timeout.add_once(0, () => {
            read_config(path, changed, error);
        });
    }

    private void read_config(string path, OnConfigChanged changed, OnConfigError error) {
        var parser = new Json.Parser();
        try {
            parser.load_from_file(path);

            var node = parser.get_root();

            changed(node);
        } catch(GLib.Error e) {
            error(e);
            return;
        }
    }
}
