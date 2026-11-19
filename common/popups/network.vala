namespace Kappashell {

    // ------------------------------------------------------------------
    // Shared helpers
    // ------------------------------------------------------------------

    private string symbolic_icon(string? icon, string fallback) {
        if (icon == null || icon == "") return fallback;
        return icon.contains("symbolic") ? icon : @"$icon-symbolic";
    }

    // Adjust if your theme's .top-section / .inset already add padding
    private const int POPUP_PADDING = 20;
    private const int CARD_PADDING = 10;

    // Pads the contents of a box: all children get cross-axis padding, and the
    // first/last children get padding along the main axis. Keeps the box's
    // own background flush while insetting what's inside it.
    private void pad_box(Gtk.Box box, int pad) {
        bool horizontal = box.orientation == Gtk.Orientation.HORIZONTAL;
        Gtk.Widget? first = box.get_first_child();
        Gtk.Widget? last = box.get_last_child();
        if (first == null) return;

        for (Gtk.Widget? c = first; c != null; c = c.get_next_sibling()) {
            if (horizontal) { c.margin_top += pad; c.margin_bottom += pad; }
            else            { c.margin_start += pad; c.margin_end += pad; }
        }
        if (horizontal) { first.margin_start += pad; last.margin_end += pad; }
        else            { first.margin_top += pad;   last.margin_bottom += pad; }
    }

    private bool is_disconnected_state(AstalNetwork.DeviceState state) {
        return state == AstalNetwork.DeviceState.DISCONNECTED
            || state == AstalNetwork.DeviceState.UNAVAILABLE
            || state == AstalNetwork.DeviceState.UNMANAGED;
    }

    // Reads the optional "interface" key, only if the config is an object
    // and the key is a string; otherwise falls back to the default.
    private string read_interface(ConfigNode? config, string default_iface) {
        if (config == null) return default_iface;

        var type = config.get_node_type();
        if (type != ConfigNodeType.Object) {
            return default_iface;
        }

        var obj = config.get_object();
        if (!obj.has_member("interface")) return default_iface;
        if (!obj.has_string_member("interface")) {
            warning("Network popup 'interface' must be a string; ignoring it");
            return default_iface;
        }
        return obj.get_string_member("interface");
    }

    private string pretty_print_status(AstalNetwork.DeviceState status) {
        switch (status) {
            case AstalNetwork.DeviceState.ACTIVATED:    return "Connected";
            case AstalNetwork.DeviceState.CONFIG:       return "Configuring";
            case AstalNetwork.DeviceState.DEACTIVATING: return "Disconnecting";
            case AstalNetwork.DeviceState.DISCONNECTED: return "Disconnected";
            case AstalNetwork.DeviceState.FAILED:
            case AstalNetwork.DeviceState.UNAVAILABLE:  return "Failed";
            case AstalNetwork.DeviceState.NEED_AUTH:    return "Authentication Failed";
            case AstalNetwork.DeviceState.IP_CHECK:
            case AstalNetwork.DeviceState.IP_CONFIG:    return "Acquiring IP";
            case AstalNetwork.DeviceState.PREPARE:      return "Connecting";
            default:                                    return "Unknown";
        }
    }

    private Gtk.Widget make_row(string label, Gtk.Widget trailing) {
        var row = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);
        row.set_size_request(-1, 48);
        var l = new Gtk.Label(label);
        l.hexpand = true;
        l.halign = Gtk.Align.START;
        row.append(l);
        trailing.halign = Gtk.Align.END;
        trailing.valign = Gtk.Align.CENTER;
        row.append(trailing);
        return row;
    }

    private string? first_ip4(NM.Device? device) {
        if (device == null) return null;
        var cfg = device.get_ip4_config();
        if (cfg == null) return null;
        var addrs = cfg.get_addresses();
        if (addrs == null || addrs.length == 0) return null;
        return addrs[0].get_address();
    }

    private NM.Client? nm_client = null;

    // Returns the device for `iface`, or `fallback` when no interface was
    // configured (or it already matches the default device).
    private NM.Device? resolve_device(string? iface, NM.Device? fallback) {
        if (iface == null || iface == "") return fallback;
        if (fallback != null && fallback.get_iface() == iface) return fallback;
        try {
            if (nm_client == null) nm_client = new NM.Client();
        } catch (Error e) {
            warning("Failed to create NM client: %s", e.message);
            return fallback;
        }
        var dev = nm_client.get_device_by_iface(iface);
        if (dev == null) {
            warning("Network interface '%s' not found", iface);
            return fallback;
        }
        return dev;
    }

    // ------------------------------------------------------------------
    // Details section (Enable / Scan / Status / IP) shared by both popups
    // ------------------------------------------------------------------

    private class NetworkDetailsWidget : Gtk.Box {
        NM.Device? device;
        AstalNetwork.Wifi? wifi;

        Gtk.Label status_label;
        Gtk.Label ip_label;
        uint ip_poll_id = 0;

        ulong device_state_notify_id = 0;
        ulong enabled_notify_id = 0;
        ulong scanning_notify_id = 0;
        ulong switch_handler_id = 0;

        Gtk.Switch? enable_switch = null;
        Gtk.Stack? scan_stack = null;

        // `wifi` is only passed for the wireless popup; it provides the
        // enable switch and scan controls. `device` is the NM device used for
        // status and IP, and may be a user-configured interface.
        public NetworkDetailsWidget(string title_text, NM.Device? device, AstalNetwork.Wifi? wifi) {
            Object(orientation: Gtk.Orientation.VERTICAL, spacing: 10);
            this.device = device;
            this.wifi = wifi;

            add_css_class("inset");

            hexpand = true;
            valign = Gtk.Align.START;

            var title = new Gtk.Label(title_text);
            title.hexpand = true;
            title.halign = Gtk.Align.CENTER;
            append(title);

            var section = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            section.hexpand = true;
            append(section);

            if (wifi != null) {
                // Enable switch
                enable_switch = new Gtk.Switch();
                enable_switch.active = wifi.enabled;
                switch_handler_id = enable_switch.notify["active"].connect(() => {
                    if (wifi.enabled != enable_switch.active) {
                        wifi.enabled = enable_switch.active;
                    }
                });
                enabled_notify_id = wifi.notify["enabled"].connect(() => {
                    if (enable_switch.active != wifi.enabled) {
                        SignalHandler.block(enable_switch, switch_handler_id);
                        enable_switch.active = wifi.enabled;
                        SignalHandler.unblock(enable_switch, switch_handler_id);
                    }
                });
                section.append(make_row("Enable:", enable_switch));

                // Scan button / spinner
                scan_stack = new Gtk.Stack();
                var scan_btn = new Gtk.Button.from_icon_name("view-refresh-symbolic");
                scan_btn.clicked.connect(() => wifi.scan());
                var spinner = new Gtk.Spinner();
                spinner.spinning = true;
                spinner.set_size_request(16, 16);
                scan_stack.add_named(scan_btn, "idle");
                scan_stack.add_named(spinner, "scanning");
                scan_stack.visible_child_name = wifi.scanning ? "scanning" : "idle";
                scanning_notify_id = wifi.notify["scanning"].connect(() => {
                    scan_stack.visible_child_name = wifi.scanning ? "scanning" : "idle";
                });
                section.append(make_row("Scan:", scan_stack));
            }

            status_label = new Gtk.Label("");
            section.append(make_row("Status:", status_label));

            ip_label = new Gtk.Label("");
            section.append(make_row("IP:", ip_label));

            pad_box(section, CARD_PADDING);

            update_status();
            if (device != null) {
                device_state_notify_id = device.notify["state"].connect(() => update_status());
            }

            update_ip();
            ip_poll_id = Timeout.add(500, () => {
                update_ip();
                return Source.CONTINUE;
            });
        }

        void update_status() {
            bool active = device != null && device.get_state() == NM.DeviceState.ACTIVATED;
            status_label.label = active ? "Active" : "Inactive";
        }

        void update_ip() {
            ip_label.label = first_ip4(device) ?? "N/A";
        }

        public override void dispose() {
            if (ip_poll_id != 0) { Source.remove(ip_poll_id); ip_poll_id = 0; }
            if (device != null && device_state_notify_id != 0) {
                SignalHandler.disconnect(device, device_state_notify_id);
                device_state_notify_id = 0;
            }
            if (wifi != null) {
                if (enabled_notify_id != 0) { wifi.disconnect(enabled_notify_id); enabled_notify_id = 0; }
                if (scanning_notify_id != 0) { wifi.disconnect(scanning_notify_id); scanning_notify_id = 0; }
            }
            base.dispose();
        }
    }

    // ------------------------------------------------------------------
    // Card for a connectable access point
    // ------------------------------------------------------------------

    private class AccessPointCard : Gtk.Box {
        AstalNetwork.AccessPoint ap;
        Gtk.Image icon;
        Gtk.Label ssid_label;
        Gtk.Label security_label;
        ulong icon_notify_id = 0;
        ulong ssid_notify_id = 0;
        ulong secured_notify_id = 0;

        public AccessPointCard(AstalNetwork.AccessPoint ap) {
            Object(orientation: Gtk.Orientation.HORIZONTAL, spacing: 10);
            this.ap = ap;
            add_css_class("inset");
            vexpand = false;
            valign = Gtk.Align.START;

            icon = new Gtk.Image();
            icon.pixel_size = 48;
            append(icon);

            var info = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            info.hexpand = true;
            info.valign = Gtk.Align.CENTER;

            ssid_label = new Gtk.Label("");
            ssid_label.ellipsize = Pango.EllipsizeMode.END;
            ssid_label.halign = Gtk.Align.START;
            info.append(ssid_label);

            security_label = new Gtk.Label("");
            security_label.halign = Gtk.Align.START;
            info.append(security_label);
            append(info);

            var connect_btn = new Gtk.Button.from_icon_name("list-add-symbolic");
            connect_btn.valign = Gtk.Align.CENTER;
            connect_btn.set_size_request(50, -1);
            connect_btn.clicked.connect(() => {
                ap.activate.begin(null, (_, res) => {
                    try {
                        ap.activate.end(res);
                    } catch (Error e) {
                        warning("Failed to activate access point: %s", e.message);
                    }
                });
            });
            append(connect_btn);

            refresh();
            icon_notify_id = ap.notify["icon-name"].connect(() => refresh());
            ssid_notify_id = ap.notify["ssid"].connect(() => refresh());
            secured_notify_id = ap.notify["requires-password"].connect(() => refresh());

            pad_box(this, CARD_PADDING);
        }

        void refresh() {
            icon.icon_name = symbolic_icon(ap.icon_name, "network-wireless-symbolic");
            ssid_label.label = (ap.ssid != null && ap.ssid != "") ? ap.ssid : "Unknown";
            security_label.label = ap.requires_password ? "Secured" : "Open";
        }

        public override void dispose() {
            if (icon_notify_id != 0) { ap.disconnect(icon_notify_id); icon_notify_id = 0; }
            if (ssid_notify_id != 0) { ap.disconnect(ssid_notify_id); ssid_notify_id = 0; }
            if (secured_notify_id != 0) { ap.disconnect(secured_notify_id); secured_notify_id = 0; }
            base.dispose();
        }
    }

    // ------------------------------------------------------------------
    // Card for the currently active network (with inline password prompt)
    // ------------------------------------------------------------------

    private class ActiveNetworkCard : Gtk.Box {
        AstalNetwork.Wifi wifi;

        Gtk.Stack stack;
        Gtk.Image icon;
        Gtk.Label ssid_label;
        Gtk.Label status_label;
        Gtk.Stack action_stack;
        Gtk.Button disconnect_btn;
        Gtk.Spinner spinner;

        // Password prompt
        Gtk.Image pw_icon;
        Gtk.Label pw_ssid_label;
        Gtk.PasswordEntry pw_entry;
        AstalNetwork.AccessPoint? needs_password = null;

        ulong state_notify_id = 0;
        ulong ssid_notify_id = 0;
        ulong icon_notify_id = 0;

        public ActiveNetworkCard(AstalNetwork.Wifi wifi) {
            Object(orientation: Gtk.Orientation.VERTICAL, spacing: 0);
            this.wifi = wifi;

            const int HEIGHT = 110;
            const int WIDTH = 350;

            stack = new Gtk.Stack();
            stack.set_size_request(WIDTH, HEIGHT);
            stack.vexpand = false;
            stack.valign = Gtk.Align.START;
            append(stack);

            // --- Normal page ---
            var normal = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);
            add_css_class("inset");

            icon = new Gtk.Image();
            icon.pixel_size = 48;
            normal.append(icon);

            var info = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            info.hexpand = true;
            info.valign = Gtk.Align.CENTER;
            ssid_label = new Gtk.Label("");
            ssid_label.ellipsize = Pango.EllipsizeMode.END;
            ssid_label.halign = Gtk.Align.START;
            info.append(ssid_label);
            status_label = new Gtk.Label("");
            status_label.halign = Gtk.Align.START;
            info.append(status_label);
            normal.append(info);

            action_stack = new Gtk.Stack();
            action_stack.set_size_request(50, -1);
            action_stack.valign = Gtk.Align.CENTER;
            disconnect_btn = new Gtk.Button.from_icon_name("list-remove-symbolic");
            disconnect_btn.clicked.connect(() => {
                wifi.deactivate_connection.begin((_, res) => {
                    try {
                        wifi.deactivate_connection.end(res);
                    } catch (Error e) {
                        warning("Failed to disconnect: %s", e.message);
                    }
                });
            });
            spinner = new Gtk.Spinner();
            spinner.spinning = true;
            spinner.set_size_request(32, 32);
            action_stack.add_named(disconnect_btn, "disconnect");
            action_stack.add_named(spinner, "busy");
            action_stack.add_named(new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0), "none");
            normal.append(action_stack);

            pad_box(normal, CARD_PADDING);
            stack.add_named(normal, "normal");

            // --- Password page ---
            var pw_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);
            pw_icon = new Gtk.Image();
            pw_icon.pixel_size = 48;
            pw_box.append(pw_icon);

            var pw_info = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            pw_info.hexpand = true;
            pw_info.valign = Gtk.Align.CENTER;
            pw_ssid_label = new Gtk.Label("");
            pw_ssid_label.ellipsize = Pango.EllipsizeMode.END;
            pw_ssid_label.halign = Gtk.Align.START;
            pw_info.append(pw_ssid_label);

            pw_entry = new Gtk.PasswordEntry();
            pw_entry.placeholder_text = "Enter Password";
            pw_entry.activate.connect(submit_password);

            var key_ctl = new Gtk.EventControllerKey();
            key_ctl.set_propagation_phase(Gtk.PropagationPhase.CAPTURE);
            key_ctl.key_released.connect((keyval, keycode, state) => {
                if (keyval == Gdk.Key.Escape) {
                    hide_password_prompt();
                }
            });
            pw_entry.add_controller(key_ctl);

            var focus_ctl = new Gtk.EventControllerFocus();
            focus_ctl.leave.connect(() => hide_password_prompt());
            pw_entry.add_controller(focus_ctl);

            pw_info.append(pw_entry);
            pw_box.append(pw_info);
            pad_box(pw_box, CARD_PADDING);
            stack.add_named(pw_box, "password");

            // --- Wiring ---
            refresh();
            state_notify_id = wifi.notify["state"].connect(() => {
                if (wifi.state == AstalNetwork.DeviceState.FAILED) {
                    show_password_prompt();
                }
                refresh();
            });
            ssid_notify_id = wifi.notify["ssid"].connect(() => refresh());
            icon_notify_id = wifi.notify["icon-name"].connect(() => refresh());
        }

        void refresh() {
            var state = wifi.state;

            // Don't show the last known network when we're not connected
            if (is_disconnected_state(state)) {
                icon.icon_name = "network-wireless-offline-symbolic";
                ssid_label.label = "Disconnected";
                status_label.visible = false;
                action_stack.visible_child_name = "none";
                return;
            }

            status_label.visible = true;
            icon.icon_name = symbolic_icon(wifi.icon_name, "network-wireless-acquiring-symbolic");
            ssid_label.label = (wifi.ssid != null && wifi.ssid != "") ? wifi.ssid : "Unknown";
            status_label.label = pretty_print_status(state);
            action_stack.visible_child_name =
                state == AstalNetwork.DeviceState.ACTIVATED ? "disconnect" : "busy";
        }

        void show_password_prompt() {
            AstalNetwork.AccessPoint? found = null;
            foreach (var ap in wifi.access_points) {
                if (ap.ssid == wifi.ssid) { found = ap; break; }
            }
            if (found == null) return;

            needs_password = found;
            pw_icon.icon_name = symbolic_icon(found.icon_name, "network-wireless-acquiring-symbolic");
            pw_ssid_label.label = (found.ssid != null && found.ssid != "") ? found.ssid : "Unknown";
            pw_entry.text = "";
            stack.visible_child_name = "password";

            Timeout.add(100, () => {
                pw_entry.grab_focus();
                return Source.REMOVE;
            });
        }

        void hide_password_prompt() {
            needs_password = null;
            stack.visible_child_name = "normal";
        }

        void submit_password() {
            if (needs_password == null) return;
            var ap = needs_password;
            ap.activate.begin(pw_entry.text, (_, res) => {
                try {
                    ap.activate.end(res);
                } catch (Error e) {
                    warning("Failed to activate access point: %s", e.message);
                }
            });
            hide_password_prompt();
        }

        public override void dispose() {
            if (state_notify_id != 0) { wifi.disconnect(state_notify_id); state_notify_id = 0; }
            if (ssid_notify_id != 0) { wifi.disconnect(ssid_notify_id); ssid_notify_id = 0; }
            if (icon_notify_id != 0) { wifi.disconnect(icon_notify_id); icon_notify_id = 0; }
            base.dispose();
        }
    }

    // ------------------------------------------------------------------
    // Scrollable list of connectable access points
    // ------------------------------------------------------------------

    private class AccessPointList : Gtk.Box {
        AstalNetwork.Wifi wifi;
        Gtk.Box list_box;
        Gtk.ScrolledWindow scroller;
        ulong aps_notify_id = 0;
        ulong ssid_notify_id = 0;
        ulong enabled_notify_id = 0;
        ulong state_notify_id = 0;

        public AccessPointList(AstalNetwork.Wifi wifi) {
            Object(orientation: Gtk.Orientation.VERTICAL, spacing: 10);
            this.wifi = wifi;
            hexpand = true;
            vexpand = true;

            list_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            scroller = new Gtk.ScrolledWindow();
            scroller.hexpand = true;
            scroller.vexpand = true;
            scroller.vscrollbar_policy = Gtk.PolicyType.EXTERNAL;
            scroller.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scroller.set_child(list_box);
            append(scroller);

            rebuild();
            aps_notify_id = wifi.notify["access-points"].connect(() => rebuild());
            ssid_notify_id = wifi.notify["ssid"].connect(() => rebuild());
            enabled_notify_id = wifi.notify["enabled"].connect(() => rebuild());
            state_notify_id = wifi.notify["state"].connect(() => rebuild());
        }

        void rebuild() {
            Gtk.Widget? child;
            while ((child = list_box.get_first_child()) != null) {
                list_box.remove(child);
            }

            scroller.visible = wifi.enabled;
            if (!wifi.enabled) return;

            var sorted = new GenericArray<AstalNetwork.AccessPoint>();
            foreach (var ap in wifi.access_points) {
                sorted.add(ap);
            }
            sorted.sort((a, b) => (int) b.strength - (int) a.strength);

            // Unique by SSID, skipping the currently active one (if any)
            bool connected = !is_disconnected_state(wifi.state);
            var seen = new GenericSet<string>(str_hash, str_equal);
            for (int i = 0; i < sorted.length; i++) {
                var ap = sorted[i];
                string ssid = ap.ssid ?? "";
                if (ssid == "" || (connected && ssid == wifi.ssid) || seen.contains(ssid)) continue;
                seen.add(ssid);
                list_box.append(new AccessPointCard(ap));
            }
        }

        public override void dispose() {
            if (aps_notify_id != 0) { wifi.disconnect(aps_notify_id); aps_notify_id = 0; }
            if (ssid_notify_id != 0) { wifi.disconnect(ssid_notify_id); ssid_notify_id = 0; }
            if (enabled_notify_id != 0) { wifi.disconnect(enabled_notify_id); enabled_notify_id = 0; }
            if (state_notify_id != 0) { wifi.disconnect(state_notify_id); state_notify_id = 0; }
            base.dispose();
        }
    }

    // ------------------------------------------------------------------
    // WifiPopup: details + active network on the left, AP list on the right
    // Config: interface (optional) - NM interface name used for status / IP
    // ------------------------------------------------------------------

    public class WifiPopup : PopupContent {

        private static AstalNetwork.Network network = null;
        private string? iface;

        public WifiPopup(string? iface = null) {
            this.iface = iface;
        }

        public static WifiPopup create(ConfigNode config) throws PopupConfigError {
            var wifi = AstalNetwork.get_default().wifi;
            string default_iface = (wifi != null && wifi.device != null) ? wifi.device.get_iface() : "";
            var iface = read_interface(config, default_iface);
            return new WifiPopup(iface);
        }

        public override Gtk.Widget build(Kappashell.PopupEnvironment environment) {
            if (network == null) {
                network = AstalNetwork.get_default();
            }

            var root = new Gtk.Box(environment.orientation, 10);

            var wifi = network.wifi;
            if (wifi == null) {
                root.append(new Gtk.Label("No wireless support found!"));
                return root;
            }

            NM.Device? device = resolve_device(iface, wifi.device);

            var grid = new Gtk.Grid();
            grid.column_homogeneous = true;
            grid.column_spacing = 10;
            grid.hexpand = true;

            var info_column = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            info_column.hexpand = true;
            info_column.append(new NetworkDetailsWidget("Wifi", device, wifi));
            info_column.append(new ActiveNetworkCard(wifi));

            var list_column = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            list_column.hexpand = true;
            list_column.append(new AccessPointList(wifi));

            grid.attach(info_column, 0, 0, 1, 1);
            grid.attach(list_column, 1, 0, 1, 1);
            root.append(grid);

            return root;
        }
    }

    // ------------------------------------------------------------------
    // WlanPopup: wired (Ethernet) details
    // Config: interface (optional) - NM interface name to show
    // ------------------------------------------------------------------

    public class WlanPopup : PopupContent {

        private static AstalNetwork.Network network = null;
        private string? iface;

        public WlanPopup(string? iface = null) {
            this.iface = iface;
        }

        public static WlanPopup create(ConfigNode config) throws PopupConfigError {
            var wired = AstalNetwork.get_default().wired;
            string default_iface = (wired != null && wired.device != null) ? wired.device.get_iface() : "";
            var iface = read_interface(config, default_iface);
            return new WlanPopup(iface);
        }

        public override Gtk.Widget build(Kappashell.PopupEnvironment environment) {
            if (network == null) {
                network = AstalNetwork.get_default();
            }

            var root = new Gtk.Box(environment.orientation, 10);

            var wired = network.wired;
            if (wired == null) {
                root.append(new Gtk.Label("No wired networking support found!"));
                return root;
            }

            NM.Device? device = resolve_device(iface, wired.device);

            var column = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            column.hexpand = true;
            column.append(new NetworkDetailsWidget("Ethernet", device, null));
            root.append(column);

            return root;
        }
    }
}
