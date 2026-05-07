namespace Kappashell {
    public class PopupSet {
        private Popup left;
        private Popup right;
        private Popup top;
        private Popup bottom;

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
    }

    public class Popup : Astal.Window {

        private InvertedCorner startCorner;
        private InvertedCorner endCorner;

        private PopupEnvironment environment;

        private Gtk.Revealer revealer;
        
        public Popup(Astal.WindowAnchor anchor) {
            this.anchor = anchor;
            this.namespace = "kappashell.desktop.popup.%s".printf(name(anchor));
            this.exclusivity = Astal.Exclusivity.NORMAL;
            set_default_size(1, 1);
            this.add_css_class("popup-window");

            this.environment.orientation = determineOrientation(anchor);

            var cbox = new Gtk.CenterBox();
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
                    print("Revealing child!");
                    this.visible = true;
                    revealer.add_css_class("open");
                    this.startCorner.set_radius_animated(30, 0.25);
                    this.endCorner.set_radius_animated(30, 0.25);
                } else {
                    print("Hiding child!");
                    revealer.remove_css_class("open");
                    this.startCorner.set_radius_animated(0, 0.25);
                    this.endCorner.set_radius_animated(0, 0.25);
                    GLib.Timeout.add_once(250, () => {
                        this.visible = false;
                    });
                }
            });

            cbox.center_widget = revealer;

            set_child(cbox);
            present();
        }

        public void open_popup(PopupContent content) {
            if (this.revealer.child_revealed) {
                this.close_popup();
                // we have to use add here and not add once since vala will 
                // not think that this function is async, resulting in content from 
                // being unref'ed and giving us a segfault.
                GLib.Timeout.add(500, () => {
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
