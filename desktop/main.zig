const std = @import("std");
const glib = @import("glib");
const gobject = @import("gobject");
const gio = @import("gio");
const gtk = @import("gtk");
const gdk = @import("gdk");
const astal = @import("astal");

const bar = @import("window/bar.zig");
const config = @import("config.zig");

fn handleSigInt(_: c_int) callconv(.c) void {
    if(mainApp) |app| {
        gio.Application.quit(app.as(gio.Application));
    }
}

pub fn main() void {
    const action = std.posix.Sigaction{
        .handler = .{ .handler = handleSigInt },
        .flags = 0,
        .mask = std.posix.sigemptyset(),
    };
    std.posix.sigaction(std.posix.SIG.INT, &action, null);

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var app = gtk.Application.new("net.akeuben.kappashell", .{.handles_command_line = true,});
    defer app.unref();
    _ = gio.Application.signals.activate.connect(app, *std.mem.Allocator, &activate, &allocator, .{});
    _ = gio.Application.signals.command_line.connect(app, *std.mem.Allocator, &commandLine, &allocator, .{});
    const status = gio.Application.run(app.as(gio.Application), @intCast(std.os.argv.len), std.os.argv.ptr);
    std.log.debug("Exiting...\n", .{});
    std.process.exit(@intCast(status));
}

var configManager: *config.ConfigManager(?*anyopaque) = undefined;
var mainApp: ?*gtk.Application = null;

fn activate(app: *gtk.Application, allocator: *std.mem.Allocator) callconv(.c) void {
    const display = gdk.Display.getDefault() orelse unreachable;
    const monitors = display.getMonitors();

    mainApp = app;
    
    barSets = std.ArrayList(*bar.MonitorWindows).empty;

    const monitor_count = monitors.getNItems();

    const cssProvider = gtk.CssProvider.new();

    var env = std.process.getEnvMap(allocator.*) catch unreachable;
    defer env.deinit();

    cssProvider.loadFromPath("desktop/style.css");
    gtk.StyleContext.addProviderForDisplay(display, cssProvider.as(gtk.StyleProvider), gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

    configManager = config.ConfigManager(?*anyopaque).init(allocator, null, &onNewConfig);
    const intitialConfig = configManager.readConfig();

    for(0..monitor_count) |i| {
        const monitor: *gdk.Monitor = @ptrCast(monitors.getItem(@intCast(i)) orelse unreachable);

         barSets.append(allocator.*, bar.MonitorWindows.init(app, monitor, allocator, &intitialConfig.widgets) catch @panic("Failed to init windows for monitor")) catch unreachable;
    }

    configManager.manualUpdate();
}

var barSets: std.ArrayList(*bar.MonitorWindows) = undefined;

fn onNewConfig(_: ?*anyopaque, cfg: *const config.Config) void {
    for(barSets.items) |barSet| {
        barSet.updateBarWidgets(&cfg.widgets);
    }
}

fn commandLine(app: *gtk.Application, cmd: *gio.ApplicationCommandLine, _: *std.mem.Allocator) callconv(.c) c_int {
    if(cmd.getIsRemote() == 0) {
        app.f_parent_instance.activate();
        return 0;
    }
    
    var argc: c_int = 0;
    const argv = cmd.getArguments(&argc);

    cmd.printerr("The CLI interface in still WIP.\n");

    for(0..@intCast(argc)) |i| {
        const msg = argv[i];
        std.log.debug("argument: {s}", .{msg});
    }

    return 0;
}
