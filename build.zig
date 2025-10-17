const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const common = b.addModule("shell_zig", .{
        .root_source_file = b.path("common/root.zig"),
        .target = target,
    });

    const desktop = b.addExecutable(.{
        .name = "shell_zig",
        .root_module = b.createModule(.{
            .root_source_file = b.path("desktop/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "common", .module = common },
            },
        }),
    });

    b.installArtifact(desktop);

    const run_step = b.step("desktop", "Run the app");
    const run_cmd = b.addRunArtifact(desktop);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const common_tests = b.addTest(.{
        .root_module = common,
    });

    const run_mod_tests = b.addRunArtifact(common_tests);

    const desktop_tests = b.addTest(.{
        .root_module = desktop.root_module,
    });

    // A run step that will run the second test executable.
    const run_exe_tests = b.addRunArtifact(desktop_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
    test_step.dependOn(&run_exe_tests.step);
}
