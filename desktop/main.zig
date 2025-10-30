const std = @import("std");
const glib = @import("glib");
const gobject = @import("gobject");
const gio = @import("gio");
const gtk = @import("gtk");
const gdk = @import("gdk");
const astal = @import("astal");
const BottomMenu = @import("window/bottom.zig").BottomMenu;

const bar = @import("window/bar.zig");
const config = @import("config.zig");

pub const Application = struct {
    configManager: *config.ConfigManager(?*anyopaque),
    app: *gtk.Application,
    allocator: *std.mem.Allocator,
    bottomMenu: *BottomMenu,

    pub var instance: ?*Application = null;

    pub fn init(allocator: *std.mem.Allocator) *Application {
        const self = allocator.create(Application) catch unreachable;
        self.allocator = allocator;
        self.app = gtk.Application.new("net.akeuben.kappashell", .{.handles_command_line = true,});
        _ = gio.Application.signals.activate.connect(self.app, *Application, &activate, self, .{});
        _ = gio.Application.signals.command_line.connect(self.app, *Application, &commandLine, self, .{});

        instance = self;

        return self;
    }

    pub fn run(self: *Application) c_int {
        return gio.Application.run(self.app.as(gio.Application), @intCast(std.os.argv.len), std.os.argv.ptr);
    }

    fn activate(app: *gtk.Application, self: *Application) callconv(.c) void {
        const display = gdk.Display.getDefault() orelse unreachable;
        const monitors = display.getMonitors();
        
        barSets = std.ArrayList(*bar.MonitorWindows).empty;

        const monitor_count = monitors.getNItems();

        const cssProvider = gtk.CssProvider.new();

        var env = std.process.getEnvMap(self.allocator.*) catch unreachable;
        defer env.deinit();

        cssProvider.loadFromPath("desktop/style.css");
        gtk.StyleContext.addProviderForDisplay(display, cssProvider.as(gtk.StyleProvider), gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        self.configManager = config.ConfigManager(?*anyopaque).init(self.allocator, null, &onNewConfig);
        const intitialConfig = self.configManager.readConfig();

        for(0..monitor_count) |i| {
            const monitor: *gdk.Monitor = @ptrCast(monitors.getItem(@intCast(i)) orelse unreachable);

             barSets.append(self.allocator.*, bar.MonitorWindows.init(app, monitor, self.allocator, &intitialConfig.widgets, @ptrCast(self), &onResize) catch @panic("Failed to init windows for monitor")) catch unreachable;
        }

        self.bottomMenu = BottomMenu.init(self.allocator);

        self.configManager.manualUpdate();
    }

    fn onResize(selfRaw: *anyopaque, top: c_int, left: c_int, right: c_int, bottom: c_int) void {
        const self: *Application = @alignCast(@ptrCast(selfRaw));

        self.bottomMenu.window.setMarginTop(top);
        self.bottomMenu.window.setMarginLeft(left);
        self.bottomMenu.window.setMarginRight(right);
        self.bottomMenu.window.setMarginBottom(bottom);
    }

    var barSets: std.ArrayList(*bar.MonitorWindows) = undefined;

    fn onNewConfig(_: ?*anyopaque, cfg: *const config.Config) void {
        for(barSets.items) |barSet| {
            barSet.updateBarWidgets(&cfg.widgets);
        }
    }

    fn commandLine(app: *gtk.Application, cmd: *gio.ApplicationCommandLine, self: *Application) callconv(.c) c_int {
        if(cmd.getIsRemote() == 0) {
            app.f_parent_instance.activate();
            return 0;
        }
        
        var argc: usize = 0;
        const argv = cmd.getArguments(@ptrCast(&argc));

        cmd.printerr("The CLI interface in still WIP.\n");

        if(argc != 2) 
            cmd.printerr("Please specify an action");

        self.handleRequest(std.mem.span(argv[1]));

        return 0;
    }

    pub fn handleRequest(self: *Application, request: [:0]const u8) void {
        if(std.mem.eql(u8, request, "runner")) {
            self.bottomMenu.openRunner(self.app);
        }

        if(std.mem.eql(u8, request, "power")) {
            self.bottomMenu.openPower(self.app);
        }

        if(std.mem.eql(u8, request, "close")) {
            self.bottomMenu.close();
        }
    }
};

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    const application = Application.init(&allocator);

    const status = application.run();

    std.log.debug("Exiting...\n", .{});
    std.process.exit(@intCast(status));
    
}

