const gtk = @import("gtk");
const widget = @import("root.zig");
const std = @import("std");
const glib = @import("glib");
const zdt = @import("zdt");
const bluetooth = @import("bluetooth");
const gobject = @import("gobject");
const network = @import("network");

pub const Params = struct {
    icon_name: []const u8,
    icon_size: c_int = 24,
    margins: struct {
        left: c_int = 0,
        right: c_int = 0,
        top: c_int = 0,
        bottom: c_int = 0,
    } = .{},
};

pub const Widget = struct {
    root: *gtk.Image,
    base: *widget.WidgetBase,
    icon_name: []u8,
    
    pub fn init(base: *widget.WidgetBase, self: *Widget, params: *const Params, _: widget.InitializationDetails) void {
        self.base = base;
        self.icon_name = base.allocator.alloc(u8, params.icon_name.len + 1) catch unreachable;

        for(params.icon_name, 0..) |byte, i| {
            self.icon_name[i] = byte;
        }
        self.icon_name[params.icon_name.len] = 0;
        
        self.root = gtk.Image.newFromIconName(@ptrCast(self.icon_name.ptr));
        self.root.setPixelSize(params.icon_size);
        gtk.Widget.setValign(self.root.as(gtk.Widget), .center);
        gtk.Widget.setHalign(self.root.as(gtk.Widget), .center);
        gtk.Widget.setMarginStart(self.root.as(gtk.Widget), params.margins.left);
        gtk.Widget.setMarginEnd(self.root.as(gtk.Widget), params.margins.right);
        gtk.Widget.setMarginTop(self.root.as(gtk.Widget), params.margins.top);
        gtk.Widget.setMarginBottom(self.root.as(gtk.Widget), params.margins.bottom);
    }

    pub fn getRoot(self: *Widget) *gtk.Widget {
        return self.root.as(gtk.Widget);
    }

    pub fn deinit(_: *Widget) void {}
};

pub const Icon = widget.DefineComponent(Widget, Params, &Widget.init);
