using Kappashell;

uint monitor_hash(Gdk.Monitor monitor) {
    return monitor.connector.hash();
}

bool monitor_equal(Gdk.Monitor a, Gdk.Monitor b) {
    return a.connector == b.connector;
}

public class KappashellDesktop : Gtk.Application { 
    static KappashellDesktop instance;

    private HashTable<Gdk.Monitor, Kappashell.BarSet> bars;

    private ErrorWindow error_window;

    private KappashellDesktop() {
        application_id = "kappashell.desktop";
        flags = ApplicationFlags.HANDLES_COMMAND_LINE;
        bars = new HashTable<Gdk.Monitor, Kappashell.BarSet>(monitor_hash, monitor_equal);
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

            var config_dir = GLib.Environment.get_user_config_dir();
            var bar_config = GLib.Path.build_path("/", config_dir, "kappashell", "bars.json");
            print("Bar config path: %s\n", bar_config);
            setup_config_monitor(bar_config, this.on_bar_config_changed, (error) => {
                error_window.add_error("Bar Config Error: %s".printf(error.message));
            });

            setup_css(null);

            var monitors = Gdk.Display.get_default().get_monitors();

            error_window = new ErrorWindow();

            for(var i = 0; i < monitors.get_n_items (); i++) {
                var monitor = (Gdk.Monitor) monitors.get_item(i);

                var barset = new Kappashell.BarSet(monitor);

                barset.add_windows(this);

                bars.set(monitor, barset);
            }
        }

        return 0;
    }

    private void on_bar_config_changed(Json.Node root) {
        error_window.reset();

        try {
            foreach(var barset in bars.get_values()) {

                barset.on_bar_config_changed(root);
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
