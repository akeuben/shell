namespace Kappashell {
    public class CalendarPopup : PopupContent {
        public static CalendarPopup create(ConfigNode config) throws PopupConfigError {
            return new CalendarPopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);
            box.homogeneous = true;

            var cal = new Gtk.Calendar();
            cal.hexpand = true;
            box.append(cal);

            var details = new Gtk.Stack();
            var selector = new Gtk.StackSwitcher();
            selector.stack = details;

            var events = details.add_titled(new Gtk.Label("events"), "events", "Events");
            var todo = details.add_titled(new Gtk.Label("todo"), "todo", "Todo");
            events.icon_name = "x-office-calendar-symbolic";
            todo.icon_name = "view-pin-symbolic";

            var details_box = new Gtk.Box (orthogonal(environment.orientation), 10);
            details_box.add_css_class("meta-header-%s".printf(environment.orientation == Gtk.Orientation.VERTICAL ? "v" : "h"));

            details_box.append(selector);
            details_box.append(details);

            box.append (details_box);

            return box;
        }
    }
}
