namespace Kappashell {
    const int BAR_MARGIN = 5;

    public errordomain BarConfigError {
        WRONG_TYPE,
        MISSING_VALUE,
    }
    public class BarSet {
        private Bar top;
        private Bar bottom;
        private Bar left;
        private Bar right;
        private Overlay overlay;

        public BarSet(Gdk.Monitor monitor) {
            left = new Bar(monitor, Astal.WindowAnchor.LEFT);
            right = new Bar(monitor, Astal.WindowAnchor.RIGHT);
            top = new Bar(monitor, Astal.WindowAnchor.TOP);
            bottom = new Bar(monitor, Astal.WindowAnchor.BOTTOM);
            overlay = new Overlay(monitor);
        }

        public void add_windows(Gtk.Application application) {
            application.add_window(top);
            application.add_window(bottom);
            application.add_window(left);
            application.add_window(right);
            application.add_window(overlay);
        }

        public void on_bar_config_changed(Json.Node config) throws BarConfigError {
            if(config.get_node_type() != Json.NodeType.OBJECT)
                throw new BarConfigError.WRONG_TYPE("root should be of type `Object`");

            var c = config.get_object();

            this.top.remove_old_widgets();
            this.bottom.remove_old_widgets();
            this.left.remove_old_widgets();
            this.right.remove_old_widgets();

            if(c.has_member("top")) {
                this.top.update_config(c.get_member("top"));
            }
            if(c.has_member("bottom")) {
                this.bottom.update_config(c.get_member("bottom"));
            }
            if(c.has_member("left")) {
                this.left.update_config(c.get_member("left"));
            }
            if(c.has_member("right")) {
                this.right.update_config(c.get_member("right"));
            }
        }
    }

    class Bar : Astal.Window {
        private Astal.WindowAnchor main_anchor;

        private Gtk.CenterBox center_box;

        public Bar(Gdk.Monitor monitor, Astal.WindowAnchor mainAnchor) {
            namespace = "kappashell.desktop.bar.%s".printf(name(mainAnchor));
            exclusivity = Astal.Exclusivity.EXCLUSIVE;
            layer = Astal.Layer.TOP;
            keymode = Astal.Keymode.NONE;
            gdkmonitor = monitor;
            anchor = adjacent(mainAnchor);
            main_anchor = mainAnchor;
            set_default_size(1, 1);

            center_box = new Gtk.CenterBox();
            center_box.orientation = orientation(mainAnchor);
            
            set_child(center_box);

            add_css_class("bar");

            present();
        }

        private static Astal.WindowAnchor adjacent(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP) {
                return Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT;
            }
            if(anchor == Astal.WindowAnchor.BOTTOM) {
                return Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT;
            }
            if(anchor == Astal.WindowAnchor.LEFT) {
                return Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT;
            }
            if(anchor == Astal.WindowAnchor.RIGHT) {
                return Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT;
            }

            return 0;
        }

        private static Gtk.Orientation orientation(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP || anchor == Astal.WindowAnchor.BOTTOM) {
                return Gtk.Orientation.HORIZONTAL;
            }
            return Gtk.Orientation.VERTICAL;
        }

        private static new string name(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP) {
                return "top";
            }
            if(anchor == Astal.WindowAnchor.BOTTOM) {
                return "bottom";
            }
            if(anchor == Astal.WindowAnchor.LEFT) {
                return "left";
            }
            if(anchor == Astal.WindowAnchor.RIGHT) {
                return "right";
            }

            GLib.error("Invalid side passed to Bar::name");
        }

        public void remove_old_widgets() {
            center_box.start_widget = null;
            center_box.center_widget = null;
            center_box.end_widget = null;
        }

        public void update_config(Json.Node config) throws BarConfigError {
            if(config.get_node_type() != Json.NodeType.OBJECT)
                throw new BarConfigError.WRONG_TYPE("%s should be of type `Object`", name(main_anchor));


            var c = config.get_object();

            if(c.has_member("start")) {
                var list_root = c.get_member("start");
                if(list_root.get_node_type() != Json.NodeType.ARRAY) 
                    throw new BarConfigError.WRONG_TYPE("start should be of type `Array`");
                
                var list = list_root.get_array();

                var widgets = gen_widget_list(list);

                var box = new Gtk.Box(orientation(main_anchor), 10);

                if(widgets.length() > 0) {
                    box.margin_top = BAR_MARGIN;
                    box.margin_bottom = BAR_MARGIN;
                    box.margin_start = BAR_MARGIN;
                    box.margin_end = BAR_MARGIN;

                }

                foreach(var widget in widgets) {
                    box.append(widget);
                }

                center_box.start_widget = box;
            }

            if(c.has_member("middle")) {
                var list_root = c.get_member("middle");
                if(list_root.get_node_type() != Json.NodeType.ARRAY) 
                    throw new BarConfigError.WRONG_TYPE("middle should be of type `Array`");
                
                var list = list_root.get_array();

                var widgets = gen_widget_list(list);

                var box = new Gtk.Box(orientation(main_anchor), 10);

                if(widgets.length() > 0) {
                    box.margin_top = BAR_MARGIN;
                    box.margin_bottom = BAR_MARGIN;
                    box.margin_start = BAR_MARGIN;
                    box.margin_end = BAR_MARGIN;

                }

                foreach(var widget in widgets) {
                    box.append(widget);
                }

                center_box.center_widget = box;
            }

            if(c.has_member("end")) {
                var list_root = c.get_member("end");
                if(list_root.get_node_type() != Json.NodeType.ARRAY) 
                    throw new BarConfigError.WRONG_TYPE("end should be of type `Array`");
                
                var list = list_root.get_array();

                var widgets = gen_widget_list(list);

                var box = new Gtk.Box(orientation(main_anchor), 10);

                if(widgets.length() > 0) {
                    box.margin_top = BAR_MARGIN;
                    box.margin_bottom = BAR_MARGIN;
                    box.margin_start = BAR_MARGIN;
                    box.margin_end = BAR_MARGIN;

                }

                foreach(var widget in widgets) {
                    box.append(widget);
                }

                center_box.end_widget = box;
            }
        }

        private GLib.List<Gtk.Widget> gen_widget_list(Json.Array array) throws BarConfigError {
            var widgets = new GLib.List<Gtk.Widget>();

            var elements = array.get_elements();

            WidgetEnvironment env = {
                orientation: orientation(this.main_anchor),
                bar: this.main_anchor,
                monitor: this.gdkmonitor,
            };

            foreach(var element in elements) {
                if(element.get_node_type() != Json.NodeType.OBJECT)
                    throw new BarConfigError.WRONG_TYPE("Elements of widget list must be of type `Object`");

                var config = element.get_object();

                if(!config.has_member("type"))
                    throw new BarConfigError.MISSING_VALUE("Elements of widget list must contain a `type` property.");

                var typeNode = config.get_member("type");

                if(typeNode.get_node_type() != Json.NodeType.VALUE || typeNode.get_string() == null)
                    throw new BarConfigError.WRONG_TYPE("`type` property must be a string");

                var type = typeNode.get_string();

                if(!config.has_member("config"))
                    throw new BarConfigError.MISSING_VALUE("Elements of widget list must contain a `config` property.");

                var widget_config = config.get_member("config");

                var widget = instantiate_widget(type, widget_config, env);

                widgets.append(widget);
            }

            return widgets;
        }
    }

    class Overlay : Astal.Window {
        public Overlay(Gdk.Monitor monitor) {
            namespace = "kappashell.desktop.bar.overlay";
            exclusivity = Astal.Exclusivity.NORMAL;
            layer = Astal.Layer.TOP;
            keymode = Astal.Keymode.NONE;
            gdkmonitor = monitor;
            anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT;

            present();

            var grid = new Gtk.Grid();

            child = grid;

            grid.hexpand = true;
            grid.vexpand = true;

            var fake1 = new Astal.Bin();
            var fake2 = new Astal.Bin();

            fake1.hexpand = true;
            fake1.vexpand = true;

            fake2.hexpand = true;
            fake2.vexpand = true;

            grid.attach(fake1, 0, 1, 1, 1);
            grid.attach(fake2, 1, 0, 1, 1);

            grid.attach(new InvertedCorner(35, Corner.TOP_LEFT), 0, 0, 1, 1);
            grid.attach(new InvertedCorner(35, Corner.TOP_RIGHT), 2, 0, 1, 1);
            grid.attach(new InvertedCorner(35, Corner.BOTTOM_LEFT), 0, 2, 1, 1);
            grid.attach(new InvertedCorner(35, Corner.BOTTOM_RIGHT), 2, 2, 1, 1);
            

            Cairo.RectangleInt rect = {
                x: 0,
                y: 0,
                width: 0,
                height: 10,
            };

            add_css_class("overlay");

            var region = new Cairo.Region.rectangle(rect);

            get_native().get_surface().set_input_region(region);
        }
    }
}
