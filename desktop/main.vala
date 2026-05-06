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

    private ErrorWindow error_window;

    private Config desktop_config;

    private string config_dir;
    private string config_path;

    private KappashellDesktop() {
        application_id = "kappashell.desktop";
        flags = ApplicationFlags.HANDLES_COMMAND_LINE;
        bars = new HashTable<Gdk.Monitor, Kappashell.BarSet>(monitor_hash, monitor_equal);

        register_widgets();

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

            if(argv.length > 1) {
                if(argv[1] == "debug") {
                    Gtk.Window.set_interactive_debugging(true);
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

            for(var i = 0; i < monitors.get_n_items (); i++) {
                var monitor = (Gdk.Monitor) monitors.get_item(i);

                var barset = new Kappashell.BarSet(monitor);
                var popupset = new Kappashell.PopupSet(monitor);

                barset.add_windows(this);
                popupset.add_windows(this);

                bars.set(monitor, barset);
            }
        }

        return 0;
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
