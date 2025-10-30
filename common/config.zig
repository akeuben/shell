const std = @import("std");
const glib = @import("glib");
const gio = @import("gio");


pub fn getConfigPath(allocator: *std.mem.Allocator) []const u8 {
    const path = glib.getUserConfigDir();

    const pathslice = std.mem.span(path);

    return std.fs.path.join(allocator.*, &.{pathslice, "kappashell", "config.zon"}) catch "~/.config/kappashell/config.zon";
}

pub fn readFile(allocator: *std.mem.Allocator, file: *gio.File, comptime T: type) !T {
    var content: [*]u8 = undefined;
    var len: usize = 0;
    _ = glib.fileGetContents(file.getPath().?, &content, &len, null);
    defer glib.free(content);

    const contentSlice = try std.mem.concatWithSentinel(allocator.*, u8, &.{content[0..len]}, 0);
    defer allocator.free(contentSlice);

    // Declare diagnostics on the stack
    var diagnostics: std.zon.parse.Diagnostics = .{};

    // Parse with diagnostics
    @setEvalBranchQuota(5000);
    const result = std.zon.parse.fromSlice(T, allocator.*, contentSlice, &diagnostics, .{.ignore_unknown_fields = true}) catch {
        var stdout_buffer: [1024]u8 = undefined;
        var stdout = std.fs.File.stdout().writer(&stdout_buffer).interface;
        try diagnostics.format(&stdout);
        stdout.flush() catch {};
        return error.ParseError;
    };

    return result;

}

pub fn monitorConfigFile(allocator: *std.mem.Allocator, ctx: anytype, p_callback: *const fn (*gio.FileMonitor, *gio.File, ?*gio.File, gio.FileMonitorEvent, @TypeOf(ctx)) callconv(.c) void) void {
    const path = getConfigPath(allocator);
    defer allocator.free(path);
    const file = gio.File.newForPath(@ptrCast(path.ptr));
    const monitor = file.monitor(.{}, null, null).?;
    _ = gio.FileMonitor.signals.changed.connect(monitor, @TypeOf(ctx), p_callback, ctx, .{});

    p_callback(monitor, file, null, .changed, ctx);
} 
