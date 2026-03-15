namespace Kappashell {
    [CCode (has_target = false)]
    public delegate Gtk.Widget WidgetConstructor(Json.Node config, WidgetEnvironment env) throws BarConfigError;

    private HashTable<string, RegisteredWidget?> registered_widgets;
    public struct RegisteredWidget {
        public string name;
        public WidgetConstructor constructor;
    }

    public struct WidgetEnvironment {
        public Gtk.Orientation orientation;
        public Astal.WindowAnchor bar;
        public Gdk.Monitor monitor;
    }

    public void register_widget(string name, WidgetConstructor constructor) {
        if(registered_widgets == null) {
            registered_widgets = new HashTable<string, RegisteredWidget?>((a) => a.hash(), (a, b) => a == b);
        }

        registered_widgets.set(name, {
            name: name,
            constructor: constructor,
        });
    }
    
    public Gtk.Widget instantiate_widget(string widgetType, Json.Node config, WidgetEnvironment env) throws BarConfigError {
        var entry = registered_widgets.lookup(widgetType);

        if(entry == null)
            throw new BarConfigError.WRONG_TYPE("Unknown widget type `%s`", widgetType);

        return entry.constructor(config, env);
    }
}
