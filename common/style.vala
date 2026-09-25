namespace Kappashell {
    [CCode (cname = "kappashell_add_css_provider")]
    extern void add_css_provider(Gdk.Display display, Gtk.StyleProvider provider, uint priority);

    [CCode (cname = "kappashell_add_css_provider_for_widget")]
    extern void add_css_provider_widget(Gtk.Widget widget, Gtk.StyleProvider provider, uint priority);

    public void setup_css() {
        var provider = new Gtk.CssProvider();
        provider.load_from_resource("/styles/common.css");

        add_css_provider(
            Gdk.Display.get_default(),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

    }    

    public void add_user_override_css(string custom_sheet_location) {
        var f = GLib.File.new_for_path(custom_sheet_location);
        var custom = new Gtk.CssProvider();
        if(f.query_exists()) {
            custom.load_from_resource(custom_sheet_location);
            add_css_provider(Gdk.Display.get_default(), custom, Gtk.STYLE_PROVIDER_PRIORITY_USER);
        }

    }

    public void add_widget_css(Gtk.Widget widget, Gtk.StyleProvider provider) {
        add_css_provider_widget(widget, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
    }
}
