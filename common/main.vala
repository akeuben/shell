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
    }    
}
