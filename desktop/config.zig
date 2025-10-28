const config = @import("common").config;
const std = @import("std");
const gio = @import("gio");
const MonitorWindows = @import("window/bar.zig").MonitorWindows;

const clock = @import("common").widget.clock;
const indicators = @import("common").widget.indicators;
const icon = @import("common").widget.icon;
const hyprland = @import("common").widget.hyprland;

pub const BarConfig = struct {
    start: []const ConfigWidgetConfig = &.{},
    middle: []const ConfigWidgetConfig = &.{},
    end: []const ConfigWidgetConfig = &.{},
    spacing: c_int = 10,
};

pub const Config = struct {
    widgets: WidgetConfig = .{},
};

pub const ConfigWidgetConfig = union(enum) {
    example_widget_1: struct {
        label: []const u8,
    },
    clock: clock.Params,
    indicators: indicators.Params,
    icon: icon.Params,
    hyprland_workspaces: hyprland.WorkspacesParams,
};

pub const WidgetConfig = struct {
    top: BarConfig = .{},
    bottom: BarConfig = .{},
    left: BarConfig = .{},
    right: BarConfig = .{},
    prioritize: enum {
        left_right,
        top_bottom,
    } = .left_right,
};

pub const defaultConfig: Config = .{
};

pub fn ConfigManager(comptime T: type) type {
    return struct {
        ctx: T,
        allocator: *std.mem.Allocator,
        newConfigCallback: *const fn (T, *const Config) void,

        pub fn init(allocator: *std.mem.Allocator, ctx: T, newConfigCallback: *const fn (T, *const Config) void) *@This() {
            const self = allocator.create(@This()) catch unreachable;
            self.allocator = allocator;
            self.ctx = ctx;
            self.newConfigCallback = newConfigCallback;
            
            config.monitorConfigFile(allocator, self, &onConfigChanged);
            
            return self;
        }

        pub fn readConfig(self: *@This()) Config {
            const path = config.getConfigPath(self.allocator);
            defer self.allocator.free(path);
            const file = gio.File.newForPath(@ptrCast(path.ptr));

            return config.readFile(self.allocator, file, Config) catch defaultConfig;
        }
        
        fn onConfigChanged(_: *gio.FileMonitor, file: *gio.File, _: ?*gio.File, eventType: gio.FileMonitorEvent, self: *@This()) callconv(.c) void {
            if(eventType != gio.FileMonitorEvent.changed) {
                return;
            }
            const cfg: ?Config = config.readFile(self.allocator, file, Config) catch null;

            if(cfg) |c| {
                self.newConfigCallback(self.ctx, &c);
            }
        }

        pub fn manualUpdate(self: *@This()) void {
            const path = config.getConfigPath(self.allocator);
            defer self.allocator.free(path);
            const file = gio.File.newForPath(@ptrCast(path.ptr));

            const cfg: ?Config = config.readFile(self.allocator, file, Config) catch null;

            if(cfg) |c| {
                self.newConfigCallback(self.ctx, &c);
            }
        }
    };
}
