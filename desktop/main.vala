using Kappashell;

private const string[] SIDES = {"left", "right", "top", "bottom"};

public class KappashellDesktop : KappashellApplication { 

    private Config desktop_config;

    private string config_dir;
    private string config_path;

    private KappashellDesktop() {
        base("ca.kappashell.desktop", build_command());

        register_popup_type("runner", Kappashell.RunnerPopup.create);
        register_popup_type("power", Kappashell.PowerPopup.create);
        register_popup_type("meta", Kappashell.MetaPopup.create);
        register_popup_type("calendar", Kappashell.CalendarPopup.create);
    }

    private static Command build_command() {
        return new Command.Builder("Kappashell")
            .description("A custom desktop shell")
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
        config_dir = GLib.Path.build_path("/", GLib.Environment.get_user_config_dir(), "kappashell");
        config_path = GLib.Path.build_path("/", config_dir, "config.yaml");
        Config.EnsureExists(config_path, "config/config.yaml");
        desktop_config = new Config(config_path);
        this.desktop_config.config_changed.connect(on_bar_config_changed);
        this.desktop_config.config_error.connect((error) => {
            error_window.add_error(error.message);
        });

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

        var popupConfig = c.get_object_member_with_default("popups", new Kappashell.ObjectConfigNode());
        try {
            popups.on_popup_config_changed(popupConfig);
        } catch (PopupConfigError e) {
            error_window.add_error("Popup Config Error: %s".printf(e.message));
        }
    }

    public static int main(string[] args) {
        var app = new KappashellDesktop();
        return app.run(args);
    }
}
