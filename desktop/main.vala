using Kappashell;

uint monitor_hash(Gdk.Monitor monitor) {
    return monitor.connector.hash();
}

bool monitor_equal(Gdk.Monitor a, Gdk.Monitor b) {
    return a.connector == b.connector;
}

public class KappashellDesktop : Gtk.Application { 
    public static KappashellDesktop instance;

    private HashTable<Gdk.Monitor, Kappashell.BarSet> bars;
    private Kappashell.PopupSet popups;

    private ErrorWindow error_window;

    private Config desktop_config;

    private string config_dir;
    private string config_path;

    private HashTable<string, Kappashell.PopupContent> popup_registry;

    private KappashellDesktop() {
        application_id = "kappashell.desktop";
        flags = ApplicationFlags.HANDLES_COMMAND_LINE;
        bars = new HashTable<Gdk.Monitor, Kappashell.BarSet>(monitor_hash, monitor_equal);
        popup_registry = new HashTable<string, Kappashell.PopupContent>(str_hash, str_equal);

        register_widgets();
        register_popup("runner", new Kappashell.RunnerPopup());
        register_popup("power", new Kappashell.PowerPopup());

        config_dir = GLib.Path.build_path("/", GLib.Environment.get_user_config_dir(), "kappashell");
        config_path = GLib.Path.build_path("/", config_dir, "config.yaml");
        print("Bar config path: %s\n", config_path);
        var config_file = GLib.File.new_for_path(config_path);
        if(!config_file.query_exists()) {
            try {
                var resource_stream = GLib.resources_open_stream("/config/config.yaml", GLib.ResourceLookupFlags.NONE);
                var dest_file = GLib.File.new_for_path(config_path);
                var dest_stream = dest_file.create(GLib.FileCreateFlags.NONE);
                dest_stream.splice(resource_stream, GLib.OutputStreamSpliceFlags.CLOSE_SOURCE | GLib.OutputStreamSpliceFlags.CLOSE_TARGET);
            } catch (Error e) {
                print("Error copying config: %s", e.message);
            }
        }
        desktop_config = new Config(config_path);
    }

    public override int command_line(ApplicationCommandLine command_line) {
        var argv = command_line.get_arguments();

        if(command_line.is_remote) {
            command_line.print_literal("You called?\n");

            // TODO: Make this into some kind of object tree for convenience!
            if(argv.length > 1) {
                if(argv[1] == "debug") {
                    Gtk.Window.set_interactive_debugging(true);
                } else if(argv[1] == "popup") {
                    if(argv[2] == "open") {
                        if(argv.length != 5) {
                            command_line.printerr("Usage: %s popup open <popup> left|right|top|bottom", argv[0]);
                            return 1;
                        }
                        var popup = argv[3];
                        var side = argv[4];
                        var anchor = Astal.WindowAnchor.NONE;

                        if(!Kappashell.popup_exists(popup)) {
                            command_line.printerr("Unknown popup %s. Known popups:", popup);
                            Kappashell.popup_list().foreach((p) => {
                                command_line.printerr("\t%s", p);
                            });
                            return 1;
                        }
                        
                        if(side == "left") anchor = Astal.WindowAnchor.LEFT;
                        else if(side == "right") anchor = Astal.WindowAnchor.RIGHT;
                        else if(side == "top") anchor = Astal.WindowAnchor.TOP;
                        else if(side == "bottom") anchor = Astal.WindowAnchor.BOTTOM;
                        else {
                            command_line.printerr("Usage: %s popup open <popup> left|right|top|bottom", argv[0]);
                            return 1;
                        }
                        
                        openPopup(popup, anchor);
                    } else if(argv[2] == "close") {
                        if(argv.length != 4) {
                            command_line.printerr("Usage: %s popup close left|right|top|bottom", argv[0]);
                            return 1;
                        }
                        var side = argv[3];
                        var anchor = Astal.WindowAnchor.NONE;

                        if(side == "left") anchor = Astal.WindowAnchor.LEFT;
                        else if(side == "right") anchor = Astal.WindowAnchor.RIGHT;
                        else if(side == "top") anchor = Astal.WindowAnchor.TOP;
                        else if(side == "bottom") anchor = Astal.WindowAnchor.BOTTOM;
                        else {
                            command_line.printerr("Usage: %s popup close left|right|top|bottom", argv[0]);
                            return 1;
                        }
                        
                        closePopup(anchor);
                    } else {
                        command_line.printerr("Usage: %s popup open|close", argv[0]);
                        return 1;
                    }
                }
            }
        } else {
            command_line.print_literal("Hello from the main instance\n");

            setup_css(GLib.Path.build_path("/", config_dir, "style.css"));
            var monitors = Gdk.Display.get_default().get_monitors();

            error_window = new ErrorWindow();

            this.desktop_config.config_changed.connect(on_bar_config_changed);
            this.desktop_config.config_error.connect((error) => {
                error_window.add_error(error.message);
            });

            popups = new Kappashell.PopupSet();
            for(var i = 0; i < monitors.get_n_items (); i++) {
                var monitor = (Gdk.Monitor) monitors.get_item(i);

                var barset = new Kappashell.BarSet(monitor);

                barset.add_windows(this);

                bars.set(monitor, barset);
            }
        }

        return 0;
    }

    public void openPopup(string popup, Astal.WindowAnchor side) {
        var content = Kappashell.lookup_popup(popup);

        popups.open_popup(content, side);
    }

    public void dim() {
        print("Dimming on %u monitors\n", this.bars.length);
        this.bars.foreach((monitor, bar) => {
            bar.dim();
        });
    }

    public void undim() {
        this.bars.foreach((monitor, bar) => {
            bar.undim();
        });
    }

    public void closePopup(Astal.WindowAnchor side) {
        popups.close_popup(side);
    }

    private void on_bar_config_changed(ConfigNode node) {
        error_window.reset();

        var c = node.get_object();

        if(c.get_bool_member_with_default("default", false)) {
            error_window.add_error("Welcome to Kappashell. Edit the config file at %s to remove this message!".printf(this.config_path));
        }

        try {
            foreach(var barset in bars.get_values()) {
                barset.on_bar_config_changed(node);
            }
        } catch (BarConfigError e) {
            error_window.add_error("Bar Config Error: %s".printf(e.message));
        }
    }

    public static int main(string[] args) {
        var app = new KappashellDesktop();
        return app.run(args);
    }
}
