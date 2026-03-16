namespace Kappashell {
    const string BT_ICON_DISCONNECTED = "preferences-system-bluetooth-inactive-symbolic";
    const string BT_ICON_CONNECTED = "preferences-system-bluetooth-symbolic";
    const string NW_ICON_UNKNOWN = "preferences-system-bluetooth-symbolic";

    delegate void NotifyHandler();

    public Gtk.Box IndicatorsWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        var box = new Gtk.Box(env.orientation, 10);
        box.add_css_class("bar-item");
        box.hexpand = false;
        box.halign = Gtk.Align.CENTER;

        box.append(NetworkIndicator());
        box.append(BluetoothIndicator());

        return box;
    }

    Gtk.Widget BluetoothIndicator() {
        var bluetooth = AstalBluetooth.get_default();

        var img = new Gtk.Image();
        img.set_pixel_size(22);
        img.hexpand = false;
        img.halign = Gtk.Align.CENTER;

        NotifyHandler update_icon = () => {
            if(bluetooth.is_powered) {
                img.set_from_icon_name(BT_ICON_CONNECTED);
            } else {
                img.set_from_icon_name(BT_ICON_DISCONNECTED);
            }
        };

        bluetooth.notify["is-powered"].connect(() => update_icon());

        update_icon();

        var bin = new Astal.Bin();
        bin.child = img;

        return bin;
    }

    Gtk.Widget NetworkIndicator() {
        var network = AstalNetwork.get_default();
        var img = new Gtk.Image();
        img.set_pixel_size(22);
        img.hexpand = false;
        img.halign = Gtk.Align.CENTER;

        ulong wifi_icon_connect = 0;
        ulong wired_icon_connect = 0;

        NotifyHandler update_icon = () => {
            switch (network.primary) {
                case AstalNetwork.Primary.WIFI:
                    img.set_from_icon_name(
                            network.wifi != null ? network.wifi.icon_name : NW_ICON_UNKNOWN
                            );
                    break;
                case AstalNetwork.Primary.WIRED:
                    img.set_from_icon_name(
                            network.wired != null ? network.wired.icon_name : NW_ICON_UNKNOWN
                            );
                    break;
                default:
                    img.set_from_icon_name(NW_ICON_UNKNOWN);
                    break;
            }
        };

        network.notify["primary"].connect(() => update_icon());

        network.notify["wifi"].connect(() => {
                if (wifi_icon_connect != 0) {
                network.wifi.disconnect(wifi_icon_connect);
                wifi_icon_connect = 0;
                }
                if (network.wifi != null) {
                wifi_icon_connect = network.wifi.notify["icon-name"].connect(() => update_icon());
                }
                update_icon();
                });

        network.notify["wired"].connect(() => {
                if (wired_icon_connect != 0) {
                network.wired.disconnect(wired_icon_connect);
                wired_icon_connect = 0;
                }
                if (network.wired != null) {
                wired_icon_connect = network.wired.notify["icon-name"].connect(() => update_icon());
                }
                update_icon();
                });

        if (network.wifi != null) {
            wifi_icon_connect = network.wifi.notify["icon-name"].connect(() => update_icon());
        }
        if (network.wired != null) {
            wired_icon_connect = network.wired.notify["icon-name"].connect(() => update_icon());
        }

        update_icon();

        var bin = new Astal.Bin();
        bin.child = img;

        return bin;
    }

}
