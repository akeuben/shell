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
        Config.EnsureExists(config_path, "config/config.yaml");
        desktop_config = new Config(config_path);
    }

    public override int command_line(ApplicationCommandLine command_line) {
        if(command_line.is_remote) {
            var cmd = new Command.Builder("Kappashell")
                .description("A custom desktop shell")
                .subcommand("debug", new Command.Builder("debug")
                    .description("Display the debugger")
                    .handler(() => {
                        Gtk.Window.set_interactive_debugging(true);
                    })
                    .build()
                )
                .subcommand("popup", new Command.Builder("popup")
                    .description("Manage popup menus")
                    .subcommand("open", new Command.Builder("popup:open")
                        .description("Open a given popup")
                        .argument(new EnumArgument("popup", list_to_array(Kappashell.popup_list())))
                        .argument(new EnumArgument("side", new string[] {"left", "right", "top", "bottom"}))
                        .handler((ctx) => {
                            var popup = ctx.get_string("popup");
                            var side = ctx.get_string("side");
                            openPopup(popup, side);
                        })
                        .build()
                    )
                    .subcommand("close", new Command.Builder("popup:close")
                        .description("Close a given popup")
                        .argument(new EnumArgument("side", new string[] {"left", "right", "top", "bottom"}))
                        .handler((ctx) => {
                            var side = ctx.get_string("side");
                            closePopup(side);
                        })
                        .build()
                    )
                    .build()
                )
                .build();

            cmd.execute(command_line);
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

    public void openPopup(string popup, string side) {
        var content = Kappashell.lookup_popup(popup);

        var anchor = Astal.WindowAnchor.NONE;
        if(side == "left") anchor = Astal.WindowAnchor.LEFT;
        else if(side == "right") anchor = Astal.WindowAnchor.RIGHT;
        else if(side == "top") anchor = Astal.WindowAnchor.TOP;
        else if(side == "bottom") anchor = Astal.WindowAnchor.BOTTOM;                            

        popups.open_popup(content, anchor);
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

    public void closePopup(string side) {
        var anchor = Astal.WindowAnchor.NONE;
        if(side == "left") anchor = Astal.WindowAnchor.LEFT;
        else if(side == "right") anchor = Astal.WindowAnchor.RIGHT;
        else if(side == "top") anchor = Astal.WindowAnchor.TOP;
        else if(side == "bottom") anchor = Astal.WindowAnchor.BOTTOM;                            

        popups.close_popup(anchor);
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
