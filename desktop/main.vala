using Kappashell;

public class KappashellDesktop : KappashellApplication { 

    private Config desktop_config;

    private string config_dir;
    private string config_path;

    private KappashellDesktop() {
        register_popup("runner", new Kappashell.RunnerPopup());
        register_popup("power", new Kappashell.PowerPopup());
        base("ca.kappashell.desktop");
        base.cmd = build_commands(this);
    }

    private static Command build_commands(KappashellDesktop self) {
        KappashellDesktop owned_self = self;  // forces a ref
        return new Command.Builder("Kappashell")
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
                        owned_self.openPopup(ctx.get_string("popup"), ctx.get_string("side"));
                    })
                    .build()
                )
                .subcommand("close", new Command.Builder("popup:close")
                    .description("Close a given popup")
                    .argument(new EnumArgument("side", new string[] {"left", "right", "top", "bottom"}))
                    .handler((ctx) => {
                        owned_self.closePopup(ctx.get_string("side"));
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
