using Kappashell;

public void register_widgets() {
    register_widget("logo", LogoWidget);
    register_widget("clock", ClockWidget);
    register_widget("workspace", WorkspaceWidget);
    register_widget("indicators", IndicatorsWidget);
    register_widget("client", ClientWidget);
    register_widget("clients", InactiveClientsWidget);
    register_widget("tray", SystemTrayWidget);
    register_widget("button", ButtonWidget);
}

private delegate void run_action(string action);

public abstract class KappashellApplication : Gtk.Application {
    public static KappashellApplication instance {private set; public get;}
    protected HashTable<Gdk.Monitor, Kappashell.BarSet> bars {protected get; private set;}
    protected Kappashell.PopupSet popups {protected get; private set;}
    protected ErrorWindow error_window {protected get; private set;}

    protected HashTable<string, Kappashell.PopupContent> popup_registry {protected get; private set;}

    protected Command cmd;

    protected KappashellApplication(string application_id) {
        KappashellApplication.instance = this;
        this.application_id = application_id;
        flags = ApplicationFlags.HANDLES_COMMAND_LINE;
        bars = new HashTable<Gdk.Monitor, Kappashell.BarSet>(monitor_hash, monitor_equal);
        popup_registry = new HashTable<string, Kappashell.PopupContent>(str_hash, str_equal);
    }

    protected abstract void setup();

    public void run_action(string action) {
        var args = new string[0];
        try {
            if(!Shell.parse_argv(action, out args)) {
                printerr("Invalid command! Parsing error.\n");
                return;
            }
            cmd.execute(new CommandLine.fromArgs(args));
        } catch(Error e) {
            printerr("Invalid command! Parsing error: %s\n", e.message);
        }
    }

    public override int command_line(ApplicationCommandLine command_line) {
        if(command_line.is_remote) {
            cmd.execute(new CommandLine.fromGLib(command_line));
        } else {
            command_line.print_literal("Hello from the main instance\n");
            var monitors = Gdk.Display.get_default().get_monitors();

            register_widgets();
            setup_css();
            setup();

            error_window = new ErrorWindow();
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
}

uint monitor_hash(Gdk.Monitor monitor) {
    return monitor.connector.hash();
}

bool monitor_equal(Gdk.Monitor a, Gdk.Monitor b) {
    return a.connector == b.connector;
}
