const gtk = @import("gtk");
const widget = @import("root.zig");
const std = @import("std");
const glib = @import("glib");
const zdt = @import("zdt");
const bluetooth = @import("bluetooth");
const gobject = @import("gobject");
const network = @import("network");

const NW_ICON_UNKNOWN: [*:0]const u8 = "preferences-system-bluetooth-symbolic";
const BT_ICON_CONNECTED: [*:0]const u8 = "preferences-system-bluetooth-symbolic";
const BT_ICON_DISCONNECTED: [*:0]const u8 = "preferences-system-bluetooth-inactive-symbolic";

pub const Params = struct {
    class: ?[]const u8 = null,
    bluetooth: bool = true,
    network: bool = true,
};

pub const Widget = struct {
    base: *widget.WidgetBase,
    root: *gtk.Box,
    networkIndicator: ?*gtk.Image,
    bluetoothIndicator: ?*gtk.Image,

    wired_icon_connect: ?c_ulong,
    wifi_icon_connect: ?c_ulong,

    pub fn init(base: *widget.WidgetBase, self: *Widget, params: *const Params, details: widget.InitializationDetails) void {
        const bt = bluetooth.getDefault();
        const nw = network.getDefault();
        self.base = base;
        self.root = gtk.Box.new(details.orientation, 10);
        self.root.f_parent_instance.setHexpand(0);
        self.root.f_parent_instance.setHalign(.center);
        self.root.f_parent_instance.addCssClass("bar-item");
        self.networkIndicator = null;
        self.bluetoothIndicator = null;

        if(params.bluetooth) {
            self.bluetoothIndicator = gtk.Image.new();
            self.bluetoothIndicator.?.setPixelSize(24);
            self.root.append(self.bluetoothIndicator.?.as(gtk.Widget));

            _ = base.connectNotify(self, bt, "is-powered", &onBluetoothPowerStateChange);
            self.updateBTIcon(bt);
        }

        if(params.network) {
            self.networkIndicator = gtk.Image.new();
            self.networkIndicator.?.setPixelSize(24);
            self.root.append(self.networkIndicator.?.as(gtk.Widget));
            _ = base.connectNotify(self, nw, "primary", &onNetworkChange);
            _ = base.connectNotify(self, nw, "wired", &onWiredChange);
            _ = base.connectNotify(self, nw, "wifi", &onWifiChange);

            self.wifi_icon_connect = null;
            self.wired_icon_connect = null;

            if(nw.getWifi()) |wifi| {
                self.wifi_icon_connect = base.connectNotify(self, wifi, "icon-name", &onNetworkWifiChange);
            }

            if(nw.getWired()) |wired| {
                self.wired_icon_connect = base.connectNotify(self, wired, "icon-name", &onNetworkWiredChange);
            }

            self.updateNetworkIcon();
        }
    }

    fn onBluetoothPowerStateChange(bt: *bluetooth.Bluetooth, _: *gobject.ParamSpec, self: *Widget) callconv(.c) void {
        self.updateBTIcon(bt);
    }

    fn onNetworkChange(_: *network.Network, _: *gobject.ParamSpec, self: *Widget) callconv(.c) void {
        self.updateNetworkIcon();
    }

    fn onWifiChange(nw: *network.Network, _: *gobject.ParamSpec, self: *Widget) callconv(.c) void {
        if(self.wifi_icon_connect) |wifi_icon_connect| {
            self.base.disconnect(wifi_icon_connect);
            self.wifi_icon_connect = null;

            if(nw.getWifi()) |wifi| {
                self.wifi_icon_connect = self.base.connectNotify(self, wifi, "icon-name", &onNetworkWifiChange);
            }
        }

        self.updateNetworkIcon();
    }

    fn onWiredChange(nw: *network.Network, _: *gobject.ParamSpec, self: *Widget) callconv(.c) void {
        if(self.wired_icon_connect) |wired_icon_connect| {
            self.base.disconnect(wired_icon_connect);
            self.wired_icon_connect = null;

            if(nw.getWired()) |wired| {
                self.wired_icon_connect = self.base.connectNotify(self, wired, "icon-name", &onNetworkWiredChange);
            }
        }
        self.updateNetworkIcon();
    }

    fn onNetworkWiredChange(_: *network.Wired, _: *gobject.ParamSpec, self: *Widget) callconv(.c) void {
        self.updateNetworkIcon();
    }

    fn onNetworkWifiChange(_: *network.Wifi, _: *gobject.ParamSpec, self: *Widget) callconv(.c) void {
        self.updateNetworkIcon();
    }

    fn updateBTIcon(self: *Widget, bt: *bluetooth.Bluetooth) void {
        self.bluetoothIndicator.?.setFromIconName(
            if(bt.getIsPowered() > 0) BT_ICON_CONNECTED 
            else BT_ICON_DISCONNECTED
        );
    }

    fn updateNetworkIcon(self: *Widget) void {
        const nw = network.getDefault();
        const primary = nw.getPrimary();
        
        const icon_name: [*:0]const u8 = switch(primary) {
            .wifi => if(nw.getWifi()) |wifi| wifi.getIconName() else NW_ICON_UNKNOWN,
            .wired => if(nw.getWired()) |wired| wired.getIconName() else NW_ICON_UNKNOWN,
            else => NW_ICON_UNKNOWN,
        };

        if(self.networkIndicator) |networkIndicator| {
            networkIndicator.setFromIconName(icon_name);
        }
    }

    pub fn getRoot(self: *Widget) *gtk.Widget {
        return self.root.as(gtk.Widget);
    }

    pub fn deinit(_: *Widget) void {}
};

pub const Indicators = widget.DefineComponent(Widget, Params, &Widget.init);
