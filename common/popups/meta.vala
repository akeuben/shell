namespace Kappashell {
    private struct Child {
        string title;
        string icon;
        PopupContent content;
    }
    public class MetaPopup : PopupContent {
        private GLib.List<Child?> children;
        private string default_child = null;

        public static MetaPopup create(ConfigNode config) throws PopupConfigError {
            var popup = new MetaPopup();
            popup.children = new GLib.List<Child?>();

            if(config.get_node_type() != ConfigNodeType.Array)
                throw new PopupConfigError.WRONG_TYPE("Meta popup config must be a list of popups");

            var c = config.get_array();
            foreach(var cconfig in c.children) {
                if(cconfig.get_node_type() != ConfigNodeType.Object)
                    throw new PopupConfigError.WRONG_TYPE("Meta Children must be objects");
                var cc = cconfig.get_object();
                if(!cc.has_string_member("title"))
                    throw new PopupConfigError.MISSING_VALUE("Meta child must have a title (string)");
                if(!cc.has_member("popup"))
                    throw new PopupConfigError.MISSING_VALUE("Meta child must have a popup");
                var pconfig = cc.get_member("popup");
                if(pconfig.get_node_type() != ConfigNodeType.Object) {
                    throw new PopupConfigError.WRONG_TYPE("Popups must be of type `Object`");
                }
                var pc = pconfig.get_object();
                if(!pc.has_member("type")) {
                    throw new PopupConfigError.MISSING_VALUE("Popups must declare a `type` property.");
                }
                var type = pc.get_string_member("type");
                var cfg = pc.get_member_with_default("config", new NoneConfigNode());

                if(!popup_type_exists(type)) {
                    throw new PopupConfigError.WRONG_TYPE("Popup type is not valid.");
                }

                var pu = lookup_popup_type(type).constructor(cfg);

                popup.children.append({
                    title: cc.get_string_member("title"),
                    icon: cc.get_string_member_with_default("icon", "help-symbolic"),
                    content: pu
                });

                if(cc.get_bool_member_with_default("default", false)) {
                    popup.default_child = cc.get_string_member("title");
                }
            }

            return popup;
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(orthogonal(environment.meta_orientation), 10);
            box.add_css_class("meta-header-%s".printf(environment.meta_orientation == Gtk.Orientation.VERTICAL ? "v" : "h"));

            var content = new Gtk.Stack();
            content.vhomogeneous = true;
            content.hhomogeneous = true;
            content.transition_type = environment.meta_orientation == Gtk.Orientation.HORIZONTAL ? Gtk.StackTransitionType.SLIDE_LEFT_RIGHT : Gtk.StackTransitionType.SLIDE_UP_DOWN;

            var switcher = new Gtk.StackSwitcher();
            switcher.orientation = environment.meta_orientation;
            switcher.stack = content;

            foreach(var tab in children) {
                var popup = tab.content.build({
                    orientation: environment.orientation,
                    meta_orientation: orthogonal(environment.meta_orientation),
                    monitor: environment.monitor,
                    popup: environment.popup,
                });
                content.add_titled(popup, tab.title, tab.title);
                content.get_page(popup).icon_name = tab.icon;
            }

            if(default_child != null) {
                content.set_visible_child_name(default_child);
            }

            box.append(switcher);
            box.append(content);
            return box;
        }

    }
}
