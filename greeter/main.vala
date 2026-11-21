using Kappashell;

private const string[] SIDES = {"left", "right", "top", "bottom"};

public class KappashellGreeter : KappashellApplication { 

    private Config greeter_config;

    private string config_dir;
    private string config_path;

    private HashTable<Gdk.Monitor, Background> backgrounds;
    private WallpaperConfig wallpaper_config;

    private KappashellGreeter() {
        base("ca.kappashell.greeter", build_command());

        backgrounds = new HashTable<Gdk.Monitor, Background>(direct_hash, direct_equal);
        wallpaper_config = new WallpaperConfig();

        register_popup_type("battery", Kappashell.BatteryPopup.create);
        register_popup_type("clock", Kappashell.ClockPopup.create);
        register_popup_type("meta", Kappashell.MetaPopup.create);
        register_popup_type("power", Kappashell.PowerPopup.create);
        register_popup_type("wifi", Kappashell.WifiPopup.create);
        register_popup_type("wlan", Kappashell.WlanPopup.create);
    }

    private static Command build_command() {
        return new Command.Builder("Kappashell")
            .description("A custom greeter shell")
            .subcommand("debug", new Command.Builder("debug")
                .description("Display the debugger")
                .handler(() => {
                    Gtk.Window.set_interactive_debugging(true);
                })
                .build()
            )
            .subcommand("popup", new Command.Builder("Popup")
                .description("Manage popup menus")
                .subcommand("open", new Command.Builder("Open")
                    .description("Open a given popup")
                    .argument(new StringArgument("popup"))
                    .argument(new EnumArgument("side", SIDES))
                    .handler((ctx) => {
                        var popup = ctx.get_string("popup");
                        if(!ctx.app.popups.popup_exists(popup)) {
                            ctx.printerr("Invalid popup: %s. Valid popups: ", popup);                   
                            foreach(var p in ctx.app.popups.popup_list()) {
                                ctx.printerr("%s ", p);
                            }
                            ctx.printerr("\n");
                            return;
                        }
                        ctx.app.openPopup(popup, ctx.get_string("side"));
                    })
                    .build()
                )
                .subcommand("close", new Command.Builder("Close")
                    .description("Close a given popup")
                    .argument(new EnumArgument("side", SIDES))
                    .handler((ctx) => {
                        ctx.app.closePopup(ctx.get_string("side"));
                    })
                    .build()
                )
                .build()
            )
            .build();
    }

    protected override void setup() {
        add_bundled_css("/styles/colors.css", Gtk.STYLE_PROVIDER_PRIORITY_SETTINGS);
        config_dir = "/etc/kappashell";
        config_path = GLib.Path.build_path("/", config_dir, "config.yaml");
        greeter_config = new Config(config_path, "/config/config.yaml");
        this.greeter_config.config_changed.connect(on_bar_config_changed);
        this.greeter_config.config_error.connect((error) => {
            error_window.add_error(error.message);
        });

        var monitors = Gdk.Display.get_default().get_monitors();
        for(uint i = 0; i < monitors.get_n_items(); i++) {
            var monitor = (Gdk.Monitor) monitors.get_item(i);
            var background = new Background(this, this.wallpaper_config, monitor);
            backgrounds.set(monitor, background);
            this.add_window(background);
        }

        this.monitor_connected.connect((monitor, bar) => {
            var current = this.greeter_config.current_config;
            if (current == null) return;
            try {
                bar.on_bar_config_changed(current.get_object().get_object_member_with_default("bars", new Kappashell.ObjectConfigNode()));

                var background = new Background(this, this.wallpaper_config, monitor);
                backgrounds.set(monitor, background);
                this.add_window(background);
            } catch(BarConfigError e) {
                error_window.add_error("Bar Config Error: %s".printf(e.message));
            }

        });

        this.monitor_disconnected.connect((monitor) => {
            backgrounds.get(monitor).close();
            backgrounds.remove(monitor);
        });

        this.add_window(new Greeter());

        add_user_override_css(GLib.Path.build_path("/", config_dir, "style.css"));
    }

    private void on_bar_config_changed(ConfigNode node) {
        error_window.reset();

        var c = node.get_object();

        if(c.get_bool_member_with_default("default", false)) {
            error_window.add_error("Welcome to Kappashell. Edit the config file at %s to remove this message!".printf(this.config_path));
        }

        var barConfig = c.get_object_member_with_default("bars", new Kappashell.ObjectConfigNode());
        try {
            foreach(var barset in bars.get_values()) {
                barset.on_bar_config_changed(barConfig);
            }
        } catch (BarConfigError e) {
            error_window.add_error("Bar Config Error: %s".printf(e.message));
        }

        print("Updating popup config!\n");
        var popupConfig = c.get_object_member_with_default("popups", new Kappashell.ObjectConfigNode());
        try {
            popups.on_popup_config_changed(popupConfig);
        } catch (PopupConfigError e) {
            error_window.add_error("Popup Config Error: %s".printf(e.message));
        }
    }

    public static void updateCurrentWallpaper(string? username) {
        var instance = (KappashellGreeter) KappashellApplication.instance;
        instance.backgrounds.for_each((monitor, background) => {
            background.show_user(username);
        });
    }

    public static int main(string[] args) {
        var app = new KappashellGreeter();
        return app.run(args);
    }
}
