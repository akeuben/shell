const std = @import("std");
const glib = @import("glib");
const gobject = @import("gobject");
const gio = @import("gio");
const gtk = @import("gtk");
const gdk = @import("gdk");
const astal = @import("astal");

fn addBar(app: *gtk.Application, monitor: *gdk.Monitor, anchor: astal.WindowAnchor, child: *gtk.Widget) void {
    var window = astal.Window.new();
    window.setAnchor(anchor);
    window.setExclusivity(astal.Exclusivity.exclusive);
    window.setGdkmonitor(monitor);
    window.f_parent_instance.f_parent_instance.addCssClass("bar");
    window.setLayer(astal.Layer.top);

    gtk.Window.setChild(&window.f_parent_instance, child);

    app.addWindow(&window.f_parent_instance);
    gtk.Widget.show(window.as(gtk.Widget));
}

pub fn addLeftBar(app: *gtk.Application, monitor: *gdk.Monitor) void {
    var button = gtk.Button.new();
    button.setLabel("Test");
    button.f_parent_instance.setValign(gtk.Align.center);

    _ = gtk.Button.signals.clicked.connect(button, ?*anyopaque, &printHello, null, .{});

    addBar(app, monitor, .{.left = true, .top = true, .bottom = true}, button.as(gtk.Widget));
}

pub fn addTopBar(app: *gtk.Application, monitor: *gdk.Monitor) void {
    var box = gtk.Box.new(gtk.Orientation.horizontal, 0);
    box.f_parent_instance.setSizeRequest(0, 5);

    addBar(app, monitor, .{.left = true, .top = true, .right = true}, box.as(gtk.Widget));
}

pub fn addBottomBar(app: *gtk.Application, monitor: *gdk.Monitor) void {
    var box = gtk.Box.new(gtk.Orientation.horizontal, 0);
    box.f_parent_instance.setSizeRequest(0, 5);

    addBar(app, monitor, .{.left = true, .bottom = true, .right = true}, box.as(gtk.Widget));
}

pub fn addRightBar(app: *gtk.Application, monitor: *gdk.Monitor) void {
    var box = gtk.Box.new(gtk.Orientation.horizontal, 0);
    box.f_parent_instance.setSizeRequest(5, 0);

    addBar(app, monitor, .{.right = true, .bottom = true, .top = true}, box.as(gtk.Widget));
}

fn printHello(_: *gtk.Button, _: ?*anyopaque) callconv(.c) void {
    std.debug.print("Hello World\n", .{});
}
