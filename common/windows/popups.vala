namespace Kappashell {
    public class PopupSet {
        private Popup left;
        private Popup right;
        private Popup top;
        private Popup bottom;
        private HashTable<string, PopupContent> registered_popups;

        public PopupSet() {
            left = new Popup(Astal.WindowAnchor.LEFT);
            right = new Popup(Astal.WindowAnchor.RIGHT);
            top = new Popup(Astal.WindowAnchor.TOP);
            bottom = new Popup(Astal.WindowAnchor.BOTTOM);
        }

        public void add_windows(Gtk.Application application) {
            application.add_window(top);
            application.add_window(bottom);
            application.add_window(left);
            application.add_window(right);
        }

        public void open_popup(PopupContent popup, Astal.WindowAnchor side) {
            switch(side) {
                case Astal.WindowAnchor.TOP:
                    top.open_popup(popup);
                    break;
                case Astal.WindowAnchor.BOTTOM:
                    bottom.open_popup(popup);
                    break;
                case Astal.WindowAnchor.LEFT:
                    left.open_popup(popup);
                    break;
                case Astal.WindowAnchor.RIGHT:
                    right.open_popup(popup);
                    break;
                default:
                    break;
            }
        }

        public void close_popup(Astal.WindowAnchor side) {
            switch(side) {
                case Astal.WindowAnchor.TOP:
                    top.close_popup();
                    break;
                case Astal.WindowAnchor.BOTTOM:
                    bottom.close_popup();
                    break;
                case Astal.WindowAnchor.LEFT:
                    left.close_popup();
                    break;
                case Astal.WindowAnchor.RIGHT:
                    right.close_popup();
                    break;
                default:
                    break;
            }
        }

        public void on_popup_config_changed(ConfigNode config) throws PopupConfigError {
            if(config.get_node_type() != ConfigNodeType.Object)
                throw new PopupConfigError.WRONG_TYPE("root should be of type `Object`");

            var c = config.get_object();

            if(registered_popups == null)
                registered_popups = new GLib.HashTable<string, PopupContent>((a) => a.hash(), (a, b) => a == b, null, (o) => o.dispose());

            registered_popups.remove_all();

            foreach(var name in c.get_keys()) {
                var pconfig = c.get_member(name);
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

                var popup = lookup_popup_type(type).constructor(cfg);
                
                registered_popups.insert(name, popup);
            }
        }

        public PopupContent lookup_popup(string name) {
            return registered_popups.lookup(name);
        }

        public bool popup_exists(string name) {
            return registered_popups.contains(name);
        }

        public GLib.List<weak string> popup_list() {
            return registered_popups.get_keys();
        }
    }

    public class Popup : Astal.Window {

        private InvertedCorner startCorner;
        private InvertedCorner endCorner;

        private PopupEnvironment environment;

        private Gtk.Revealer revealer;

        private bool open = false;
        
        public Popup(Astal.WindowAnchor anchor) {
            this.anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT; 
            this.namespace = "kappashell.desktop.popup.%s".printf(name(anchor));
            this.exclusivity = Astal.Exclusivity.NORMAL;
            this.keymode = Astal.Keymode.NONE;
            set_default_size(1, 1);
            this.add_css_class("popup-window");
            this.environment.orientation = determineOrientation(anchor);
            this.environment.popup = this;

            var keyhandler = new Gtk.EventControllerKey();
            keyhandler.key_released.connect((keyval) => {
                if(keyval == Gdk.Key.Escape) {
                    close_popup();
                }
            });
            var mouseHandler = new Gtk.GestureClick();
            mouseHandler.propagation_phase = Gtk.PropagationPhase.TARGET;
            mouseHandler.pressed.connect(() => {
                close_popup();
            });
            ((Gtk.Widget) this).add_controller(keyhandler);
            ((Gtk.Widget) this).add_controller(mouseHandler);

            var cbox = new Gtk.CenterBox();
            switch(anchor) {
                case Astal.WindowAnchor.TOP:
                    cbox.halign = Gtk.Align.CENTER;
                    cbox.valign = Gtk.Align.START;
                    break;
                case Astal.WindowAnchor.BOTTOM:
                    cbox.halign = Gtk.Align.CENTER;
                    cbox.valign = Gtk.Align.END;
                    break;
                case Astal.WindowAnchor.LEFT:
                    cbox.halign = Gtk.Align.START;
                    cbox.valign = Gtk.Align.CENTER;
                    break;
                case Astal.WindowAnchor.RIGHT:
                    cbox.halign = Gtk.Align.END;
                    cbox.valign = Gtk.Align.CENTER;
                    break;
                case Astal.WindowAnchor.NONE: break;
            }
            cbox.orientation = determineOrientation(anchor);
            startCorner = new InvertedCorner(0, determineStartCorner(anchor));
            endCorner = new InvertedCorner(0, determineEndCorner(anchor));
            tweakCorner(startCorner, anchor);
            tweakCorner(endCorner, anchor);
            cbox.start_widget = startCorner;
            cbox.end_widget = endCorner;

            revealer = new Gtk.Revealer();
            revealer.add_css_class("popup-content");
            revealer.add_css_class(name(anchor));
            switch(anchor) {
                case Astal.WindowAnchor.TOP:
                    revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_DOWN);
                    break;
                case Astal.WindowAnchor.BOTTOM:
                    revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_UP);
                    break;
                case Astal.WindowAnchor.LEFT:
                    revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_RIGHT);
                    break;
                case Astal.WindowAnchor.RIGHT:
                    revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_LEFT);
                    break;
                default:
                    break;
            }
            revealer.set_transition_duration(250);

            revealer.notify["reveal-child"].connect(() => {
                if(revealer.reveal_child) {
                    this.visible = true;
                    this.keymode = Astal.Keymode.EXCLUSIVE;
                    revealer.add_css_class("open");
                    this.startCorner.set_radius_animated(15, 0.125);
                    this.endCorner.set_radius_animated(15, 0.125);
                } else {
                    revealer.remove_css_class("open");
                    this.startCorner.set_radius_animated(0, 0.125);
                    this.endCorner.set_radius_animated(0, 0.125);
                }
            });

            revealer.notify["child-revealed"].connect(() => {
                if (!revealer.child_revealed && !open) {
                    this.visible = false;
                    this.keymode = Astal.Keymode.NONE;
                }
            });

            cbox.center_widget = revealer;

            set_child(cbox);
            present();
            this.visible = false;
        }

        public void open_popup(PopupContent content) {
            this.add_css_class("dim");
            open = true;
            if (this.revealer.child_revealed) {
                this.revealer.reveal_child = false;
                // we have to use add here and not add once since vala will 
                // not think that this function is async, resulting in content from 
                // being unref'ed and giving us a segfault.
                GLib.Timeout.add(250, () => {
                    this.revealer.set_child(content.build(environment));
                    this.revealer.reveal_child = true;
                    return GLib.Source.REMOVE;
                });
            } else {
                this.revealer.set_child(content.build(environment));
                this.revealer.reveal_child = true;
            }
        }

        public void close_popup() {
            open = false;
            this.remove_css_class("dim");
            this.revealer.reveal_child = false;
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

        private static Corner determineStartCorner(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP) {
                return Corner.TOP_RIGHT;
            }
            if(anchor == Astal.WindowAnchor.BOTTOM) {
                return Corner.BOTTOM_RIGHT;
            }
            if(anchor == Astal.WindowAnchor.LEFT) {
                return Corner.BOTTOM_LEFT;
            }
            if(anchor == Astal.WindowAnchor.RIGHT) {
                return Corner.BOTTOM_RIGHT;
            }

            GLib.error("Invalid side passed to Bar::determineStartCorner");
        }

        private static Corner determineEndCorner(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP) {
                return Corner.TOP_LEFT;
            }
            if(anchor == Astal.WindowAnchor.BOTTOM) {
                return Corner.BOTTOM_LEFT;
            }
            if(anchor == Astal.WindowAnchor.LEFT) {
                return Corner.TOP_LEFT;
            }
            if(anchor == Astal.WindowAnchor.RIGHT) {
                return Corner.TOP_RIGHT;
            }

            GLib.error("Invalid side passed to Bar::determineStartCorner");
        }

        private static Gtk.Orientation determineOrientation(Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.TOP) {
                return Gtk.Orientation.HORIZONTAL;
            }
            if(anchor == Astal.WindowAnchor.BOTTOM) {
                return Gtk.Orientation.HORIZONTAL;
            }
            if(anchor == Astal.WindowAnchor.LEFT) {
                return Gtk.Orientation.VERTICAL;
            }
            if(anchor == Astal.WindowAnchor.RIGHT) {
                return Gtk.Orientation.VERTICAL;
            }

            GLib.error("Invalid side passed to Bar::determineStartCorner");
        }

        private static void tweakCorner(InvertedCorner corner, Astal.WindowAnchor anchor) {
            if(anchor == Astal.WindowAnchor.RIGHT) {
                corner.valign = Gtk.Align.END;
                corner.halign = Gtk.Align.END;
            }
            if(anchor == Astal.WindowAnchor.BOTTOM) {
                corner.valign = Gtk.Align.END;
                corner.halign = Gtk.Align.END;
            }
        }
    }
}
