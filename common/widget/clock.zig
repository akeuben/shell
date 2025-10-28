const gtk = @import("gtk");
const widget = @import("root.zig");
const std = @import("std");
const glib = @import("glib");
const zdt = @import("zdt");

var timeout: c_uint = 0;
var instances = std.ArrayList(*Widget).empty;

var buf1: [3]u8 = undefined;
var buf2: [3]u8 = undefined;

var currentHour: [*:0]const u8 = "00";
var currentMinute: [*:0]const u8 = "00";

fn start() void {
    timeout = glib.timeoutAdd(500, &update, null);

    _ = update(null);
}

fn update(_: ?*anyopaque) callconv(.c) c_int {
    const datetime = glib.DateTime.newNowLocal().?;

    const hour: u32 = @intCast(datetime.getHour());
    const minute: u32 = @intCast(datetime.getMinute());

    // Format integer into buffer with zero-padding
    const hourStr = std.fmt.bufPrint(&buf1, "{d:0>2}\x00", .{hour}) catch unreachable;
    const minStr = std.fmt.bufPrint(&buf2, "{d:0>2}\x00", .{minute}) catch unreachable;

    for(instances.items) |instance| {
        instance.hours.setLabel(@ptrCast(hourStr.ptr));
        instance.minutes.setLabel(@ptrCast(minStr.ptr));
    }

    currentHour = @ptrCast(hourStr.ptr);
    currentMinute = @ptrCast(minStr.ptr);

    return @intFromBool(glib.SOURCE_CONTINUE);
}

pub const Params = struct {
    class: ?[]const u8 = null,
};

pub const Widget = struct {
    root: *gtk.Box,
    hours: *gtk.Label,
    minutes: *gtk.Label,

    pub fn init(base: *widget.WidgetBase, self: *Widget, params: *const Params, details: widget.InitializationDetails) void {
        self.hours = gtk.Label.new(currentHour);
        gtk.Widget.setValign(self.hours.as(gtk.Widget), .center);
        gtk.Widget.setVexpand(self.hours.as(gtk.Widget), 0);
        gtk.Widget.setHalign(self.hours.as(gtk.Widget), .center);
        self.hours.setYalign(0.5);

        self.minutes = gtk.Label.new(currentMinute);
        gtk.Widget.setValign(self.minutes.as(gtk.Widget), .center);
        gtk.Widget.setVexpand(self.minutes.as(gtk.Widget), 0);
        gtk.Widget.setHalign(self.minutes.as(gtk.Widget), .center);
        self.minutes.setYalign(0.5);

        self.root = gtk.Box.new(details.orientation, 5);
        self.root.f_parent_instance.setVexpand(0);
        self.root.f_parent_instance.setValign(.center);
        self.root.f_parent_instance.setHexpand(0);
        self.root.f_parent_instance.setHalign(.center);
        self.root.append(self.hours.as(gtk.Widget));
        self.root.append(self.minutes.as(gtk.Widget));

        self.root.f_parent_instance.addCssClass("clock");
        if(params.class) |class| {
            self.root.f_parent_instance.addCssClass(class[0..class.len :0]);
        }

        if(instances.items.len == 0) start();
        instances.append(base.allocator.*, self) catch unreachable;
    }

    pub fn getRoot(self: *const Widget) *gtk.Widget {
        return self.root.as(gtk.Widget);
    }

    pub fn deinit(self: *@This()) void {
        var pos: ?usize = null;
        for(instances.items, 0..) |item, i| {
            if(item == self) 
                pos = i;
        }
        if(pos) |i| {
            _ = instances.orderedRemove(i);
        }
        if(instances.items.len == 0) {
            _ = glib.Source.remove(timeout);
        }
    }
};

pub const Clock = widget.DefineComponent(Widget, Params, &Widget.init);
