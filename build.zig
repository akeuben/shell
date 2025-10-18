const std = @import("std");

fn use(gobject: *std.Build.Dependency, name: []const u8, target: []const u8) std.Build.Module.Import {
    return .{ .name = name, .module = gobject.module(target)};
}

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const gobject = b.dependency("gobject", .{});

    const common = b.addLibrary(.{
        .name="common",
        .root_module = b.createModule(.{
            .root_source_file = b.path("common/root.zig"),
            .target = target,
            .imports = &.{
                use(gobject, "gtk", "gtk4"),
                use(gobject, "gdk", "gdk4"),
                use(gobject, "gio", "gio2"),
                use(gobject, "glib", "glib2"),
                use(gobject, "gobject", "gobject2"),
                use(gobject, "astal", "astal4"),
            }
        })
    });
    common.linkSystemLibrary("gtk4-layer-shell");

    const desktop = b.addExecutable(.{
        .name = "shell_zig",
        .root_module = b.createModule(.{
            .root_source_file = b.path("desktop/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "common", .module = common.root_module },
                use(gobject, "gtk", "gtk4"),
                use(gobject, "gdk", "gdk4"),
                use(gobject, "gio", "gio2"),
                use(gobject, "glib", "glib2"),
                use(gobject, "gobject", "gobject2"),
                use(gobject, "astal", "astal4"),
            },
        }),
    });
    desktop.linkSystemLibrary("gtk4-layer-shell");
    desktop.step.dependOn(&common.step);

    b.installArtifact(desktop);

    const desktop_step = b.step("desktop", "Run the app");

    const desktop_cmd = b.addRunArtifact(desktop);
    desktop_step.dependOn(&desktop_cmd.step);
    desktop_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        desktop_cmd.addArgs(args);
    }
}
