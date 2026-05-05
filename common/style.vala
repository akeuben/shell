namespace Kappashell {
    public void setup_css(string? custom_sheet_location) {
        var provider = new Gtk.CssProvider();
        provider.load_from_resource("/styles/common.css");
        var custom = new Gtk.CssProvider();
        if(custom_sheet_location != null) {
            var f = GLib.File.new_for_path(custom_sheet_location);
            if(f.query_exists()) {
                custom.load_from_resource(custom_sheet_location);
                Gtk.StyleContext.add_provider_for_display(Gdk.Display.get_default(), custom, Gtk.STYLE_PROVIDER_PRIORITY_USER);
            }
        }

        Gtk.StyleContext.add_provider_for_display(
            Gdk.Display.get_default(),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

    }    
}
