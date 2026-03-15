namespace Kappashell {
    public Gtk.Image LogoWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        var image = new Gtk.Image();
        
        image.icon_name = "error-app-symbolic";
        image.pixel_size = 16;

        if(config.get_node_type() == Json.NodeType.OBJECT) {
            var c = config.get_object();
            image.icon_name = c.get_string_member_with_default("icon", "error-app-symbolic");
            image.pixel_size = (int) c.get_int_member_with_default("size", 16);
        }

        return image;
    }
}
