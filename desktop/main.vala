public class KappashellDesktop : Gtk.Application { 
    static KappashellDesktop instance;

    private KappashellDesktop() {
        application_id = "kappashell.desktop";
        flags = ApplicationFlags.HANDLES_COMMAND_LINE;
    }

    public override int command_line(ApplicationCommandLine command_line) {
        var argv = command_line.get_arguments();

        if(command_line.is_remote) {
            command_line.print_literal("You called?\n");
        } else {
            command_line.print_literal("Hello from the main instance\n");

            var monitors = Gdk.Display.get_default().get_monitors();

            for(var i = 0; i < monitors.get_n_items (); i++) {
                var monitor = (Gdk.Monitor) monitors.get_item(i);

                add_window(new WindowBar(monitor));
            }
        }

        return 0;
    }

    public static int main(string[] args) {
        var app = new KappashellDesktop();
        return app.run(args);
    }
}
