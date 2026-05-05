using Kappashell;

public void register_widgets() {
    register_widget("logo", LogoWidget);
    register_widget("clock", ClockWidget);
    register_widget("workspace", WorkspaceWidget);
    register_widget("indicators", IndicatorsWidget);
    register_widget("client", ClientWidget);
    register_widget("clients", InactiveClientsWidget);
    register_widget("tray", SystemTrayWidget);
}
