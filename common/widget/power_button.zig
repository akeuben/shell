const gtk = @import("gtk");
const widget = @import("root.zig");
const std = @import("std");
const glib = @import("glib");
const zdt = @import("zdt");
const bluetooth = @import("bluetooth");
const gobject = @import("gobject");
const network = @import("network");
const root = @import("../components/icon_button.zig");

pub const Params = struct {
    ignored: u1 = 0,
};

pub const Widget = struct {
    root: root.IconButton,
    base: *widget.WidgetBase,
    icon_name: []u8,
    details: widget.InitializationDetails,
    
    pub fn init(_: *widget.WidgetBase, self: *Widget, _: *const Params, details: widget.InitializationDetails) void {
        self.details = details;

        self.root = root.IconButton.new("system-shutdown-symbolic", .{}, self, &onClicked);
    }

    pub fn getRoot(self: *Widget) *gtk.Widget {
        return self.root.button.as(gtk.Widget);
    }

    pub fn onClicked(_: *gtk.Button, self: *Widget) callconv(.c) void {
        self.details.requestHandler("power");
    }

    pub fn deinit(_: *Widget) void {}
};

pub const PowerButton = widget.DefineComponent(Widget, Params, &Widget.init);
