// https://docs.gtk.org/gtk4/getting_started.html#hello-world

const std = @import("std");
const glib = @import("glib");
const gobject = @import("gobject");
const gio = @import("gio");
const gtk = @import("gtk");
const astal = @import("astal");

pub fn main() void {
    var app = gtk.Application.new("org.gtk.example", .{});
    defer app.unref();
    _ = gio.Application.signals.activate.connect(app, ?*anyopaque, &activate, null, .{});
    const status = gio.Application.run(app.as(gio.Application), @intCast(std.os.argv.len), std.os.argv.ptr);
    std.process.exit(@intCast(status));
}

fn activate(app: *gtk.Application, _: ?*anyopaque) callconv(.c) void {
    var window = astal.Window.new();
    window.setAnchor(.{.left = true, .bottom = true, .top = true});
    window.setExclusivity(astal.Exclusivity.exclusive);
    
    var button = gtk.Button.new();
    button.setLabel("Test");
    
    _ = gtk.Button.signals.clicked.connect(button, ?*anyopaque, &printHello, null, .{});

    gtk.Window.setChild(&window.f_parent_instance, button.as(gtk.Widget));
    
    app.addWindow(&window.f_parent_instance);

    gtk.Widget.show(window.as(gtk.Widget));
}

fn printHello(_: *gtk.Button, _: ?*anyopaque) callconv(.c) void {
    std.debug.print("Hello World\n", .{});
}

fn closeWindow(_: *gtk.Button, window: *gtk.ApplicationWindow) callconv(.c) void {
    gtk.Window.destroy(window.as(gtk.Window));
}
