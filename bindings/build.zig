const std = @import("std");

/// A library accessible through the generated bindings.
///
/// While the generated bindings are typically used through modules
/// (e.g. `gobject.module("glib-2.0")`), there are cases where it is
/// useful to have additional information about the libraries exposed
/// to the build script. For example, if any files in the root module
/// of the application want to import a library's C headers directly,
/// it will be necessary to link the library directly to the root module
/// using `Library.linkTo` so the include paths will be available.
pub const Library = struct {
    /// System libraries to be linked using pkg-config.
    system_libraries: []const []const u8,

    /// Links `lib` to `module`.
    pub fn linkTo(lib: Library, module: *std.Build.Module) void {
        module.link_libc = true;
        for (lib.system_libraries) |system_lib| {
            module.linkSystemLibrary(system_lib, .{});
        }
    }
};

/// Returns a `std.Build.Module` created by compiling the GResources file at `path`.
///
/// This requires the `glib-compile-resources` system command to be available.
pub fn addCompileResources(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    path: std.Build.LazyPath,
) *std.Build.Module {
    const compile_resources, const module = addCompileResourcesInternal(b, target, path);
    compile_resources.addArg("--sourcedir");
    compile_resources.addDirectoryArg(path.dirname());
    compile_resources.addArg("--dependency-file");
    _ = compile_resources.addDepFileOutputArg("gresources-deps");

    return module;
}

fn addCompileResourcesInternal(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    path: std.Build.LazyPath,
) struct { *std.Build.Step.Run, *std.Build.Module } {
    const compile_resources = b.addSystemCommand(&.{ "glib-compile-resources", "--generate-source" });
    compile_resources.addArg("--target");
    const gresources_c = compile_resources.addOutputFileArg("gresources.c");
    compile_resources.addFileArg(path);

    const module = b.createModule(.{ .target = target });
    module.addCSourceFile(.{ .file = gresources_c });
    @This().libraries.gio2.linkTo(module);
    return .{ compile_resources, module };
}

/// Returns a builder for a compiled GResource bundle.
///
/// Calling `CompileResources.build` on the returned builder requires the
/// `glib-compile-resources` system command to be installed.
pub fn buildCompileResources(gobject_dependency: *std.Build.Dependency) CompileResources {
    return .{ .b = gobject_dependency.builder };
}

/// A builder for a compiled GResource bundle.
pub const CompileResources = struct {
    b: *std.Build,
    groups: std.ArrayListUnmanaged(*Group) = .{},

    var build_gresources_xml_exe: ?*std.Build.Step.Compile = null;

    /// Builds the GResource bundle as a module. The module must be imported
    /// into the compilation for the resources to be loaded.
    pub fn build(cr: CompileResources, target: std.Build.ResolvedTarget) *std.Build.Module {
        const run = cr.b.addRunArtifact(build_gresources_xml_exe orelse exe: {
            const exe = cr.b.addExecutable(.{
                .name = "build-gresources-xml",
                .root_module = cr.b.createModule(.{
                    .root_source_file = cr.b.path("build/build_gresources_xml.zig"),
                    .target = cr.b.graph.host,
                    .optimize = .Debug,
                }),
            });
            build_gresources_xml_exe = exe;
            break :exe exe;
        });

        for (cr.groups.items) |group| {
            run.addArg(cr.b.fmt("--prefix={s}", .{group.prefix}));
            for (group.files.items) |file| {
                run.addArg(cr.b.fmt("--alias={s}", .{file.name}));
                if (file.options.compressed) {
                    run.addArg("--compressed");
                }
                for (file.options.preprocess) |preprocessor| {
                    run.addArg(cr.b.fmt("--preprocess={s}", .{preprocessor.name()}));
                }
                run.addPrefixedFileArg("--path=", file.path);
            }
        }
        const xml = run.addPrefixedOutputFileArg("--output=", "gresources.xml");

        _, const module = addCompileResourcesInternal(cr.b, target, xml);
        return module;
    }

    /// Adds a group of resources showing a common prefix.
    pub fn addGroup(cr: *CompileResources, prefix: []const u8) *Group {
        const group = cr.b.allocator.create(Group) catch @panic("OOM");
        group.* = .{ .owner = cr, .prefix = prefix };
        cr.groups.append(cr.b.allocator, group) catch @panic("OOM");
        return group;
    }

    pub const Group = struct {
        owner: *CompileResources,
        prefix: []const u8,
        files: std.ArrayListUnmanaged(File) = .{},

        /// Adds the file at `path` as a resource named `name` (within the
        /// prefix of the containing group).
        pub fn addFile(g: *Group, name: []const u8, path: std.Build.LazyPath, options: File.Options) void {
            g.files.append(g.owner.b.allocator, .{
                .name = name,
                .path = path,
                .options = options,
            }) catch @panic("OOM");
        }
    };

    pub const File = struct {
        name: []const u8,
        path: std.Build.LazyPath,
        options: Options = .{},

        pub const Options = struct {
            compressed: bool = false,
            preprocess: []const Preprocessor = &.{},
        };

        pub const Preprocessor = union(enum) {
            xml_stripblanks,
            json_stripblanks,
            other: []const u8,

            pub fn name(p: Preprocessor) []const u8 {
                return switch (p) {
                    .xml_stripblanks => "xml-stripblanks",
                    .json_stripblanks => "json-stripblanks",
                    .other => |s| s,
                };
            }
        };
    };
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const docs_step = b.step("docs", "Generate documentation");
    const test_step = b.step("test", "Run tests");

    const compat = b.createModule(.{
        .root_source_file = b.path("src/compat/compat.zig"),
        .target = target,
        .optimize = optimize,
    });

    const icalglib3 = b.addModule("icalglib3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "icalglib3", "icalglib3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.icalglib3.linkTo(icalglib3);
    icalglib3.addImport("compat", compat);

    const icalglib3_test = b.addTest(.{
        .root_module = icalglib3,
    });
    test_step.dependOn(&b.addRunArtifact(icalglib3_test).step);

    const gobject2 = b.addModule("gobject2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gobject2", "gobject2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gobject2.linkTo(gobject2);
    gobject2.addImport("compat", compat);

    const gobject2_test = b.addTest(.{
        .root_module = gobject2,
    });
    test_step.dependOn(&b.addRunArtifact(gobject2_test).step);

    const glib2 = b.addModule("glib2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "glib2", "glib2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.glib2.linkTo(glib2);
    glib2.addImport("compat", compat);

    const glib2_test_mod = b.createModule(.{
        .root_source_file = b.path("src/glib2/glib2.zig"),
        .target = target,
        .optimize = optimize,
    });
    libraries.glib2.linkTo(glib2_test_mod);
    libraries.gobject2.linkTo(glib2_test_mod);
    // Some deprecated thread functions require linking gthread-2.0
    glib2_test_mod.linkSystemLibrary("gthread-2.0", .{});
    glib2_test_mod.addImport("compat", compat);
    glib2_test_mod.addImport("glib2", glib2_test_mod);

    const glib2_test = b.addTest(.{
        .root_module = glib2_test_mod,
    });
    test_step.dependOn(&b.addRunArtifact(glib2_test).step);

    const ical3 = b.addModule("ical3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "ical3", "ical3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.ical3.linkTo(ical3);
    ical3.addImport("compat", compat);

    const ical3_test = b.addTest(.{
        .root_module = ical3,
    });
    test_step.dependOn(&b.addRunArtifact(ical3_test).step);

    const json1 = b.addModule("json1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "json1", "json1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.json1.linkTo(json1);
    json1.addImport("compat", compat);

    const json1_test = b.addTest(.{
        .root_module = json1,
    });
    test_step.dependOn(&b.addRunArtifact(json1_test).step);

    const gio2 = b.addModule("gio2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gio2", "gio2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gio2.linkTo(gio2);
    gio2.addImport("compat", compat);

    const gio2_test = b.addTest(.{
        .root_module = gio2,
    });
    test_step.dependOn(&b.addRunArtifact(gio2_test).step);

    const gmodule2 = b.addModule("gmodule2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gmodule2", "gmodule2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gmodule2.linkTo(gmodule2);
    gmodule2.addImport("compat", compat);

    const gmodule2_test = b.addTest(.{
        .root_module = gmodule2,
    });
    test_step.dependOn(&b.addRunArtifact(gmodule2_test).step);

    const soup3 = b.addModule("soup3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "soup3", "soup3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.soup3.linkTo(soup3);
    soup3.addImport("compat", compat);

    const soup3_test = b.addTest(.{
        .root_module = soup3,
    });
    test_step.dependOn(&b.addRunArtifact(soup3_test).step);

    const nm1 = b.addModule("nm1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "nm1", "nm1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.nm1.linkTo(nm1);
    nm1.addImport("compat", compat);

    const nm1_test = b.addTest(.{
        .root_module = nm1,
    });
    test_step.dependOn(&b.addRunArtifact(nm1_test).step);

    const gtk4sessionlock1 = b.addModule("gtk4sessionlock1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gtk4sessionlock1", "gtk4sessionlock1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gtk4sessionlock1.linkTo(gtk4sessionlock1);
    gtk4sessionlock1.addImport("compat", compat);

    const gtk4sessionlock1_test = b.addTest(.{
        .root_module = gtk4sessionlock1,
    });
    test_step.dependOn(&b.addRunArtifact(gtk4sessionlock1_test).step);

    const gtk4 = b.addModule("gtk4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gtk4", "gtk4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gtk4.linkTo(gtk4);
    gtk4.addImport("compat", compat);

    const gtk4_test = b.addTest(.{
        .root_module = gtk4,
    });
    test_step.dependOn(&b.addRunArtifact(gtk4_test).step);

    const gsk4 = b.addModule("gsk4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gsk4", "gsk4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gsk4.linkTo(gsk4);
    gsk4.addImport("compat", compat);

    const gsk4_test = b.addTest(.{
        .root_module = gsk4,
    });
    test_step.dependOn(&b.addRunArtifact(gsk4_test).step);

    const graphene1 = b.addModule("graphene1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "graphene1", "graphene1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.graphene1.linkTo(graphene1);
    graphene1.addImport("compat", compat);

    const graphene1_test = b.addTest(.{
        .root_module = graphene1,
    });
    test_step.dependOn(&b.addRunArtifact(graphene1_test).step);

    const gdk4 = b.addModule("gdk4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdk4", "gdk4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdk4.linkTo(gdk4);
    gdk4.addImport("compat", compat);

    const gdk4_test = b.addTest(.{
        .root_module = gdk4,
    });
    test_step.dependOn(&b.addRunArtifact(gdk4_test).step);

    const cairo1 = b.addModule("cairo1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "cairo1", "cairo1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.cairo1.linkTo(cairo1);
    cairo1.addImport("compat", compat);

    const cairo1_test = b.addTest(.{
        .root_module = cairo1,
    });
    test_step.dependOn(&b.addRunArtifact(cairo1_test).step);

    const pangocairo1 = b.addModule("pangocairo1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pangocairo1", "pangocairo1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pangocairo1.linkTo(pangocairo1);
    pangocairo1.addImport("compat", compat);

    const pangocairo1_test = b.addTest(.{
        .root_module = pangocairo1,
    });
    test_step.dependOn(&b.addRunArtifact(pangocairo1_test).step);

    const pango1 = b.addModule("pango1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pango1", "pango1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pango1.linkTo(pango1);
    pango1.addImport("compat", compat);

    const pango1_test = b.addTest(.{
        .root_module = pango1,
    });
    test_step.dependOn(&b.addRunArtifact(pango1_test).step);

    const harfbuzz0 = b.addModule("harfbuzz0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "harfbuzz0", "harfbuzz0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.harfbuzz0.linkTo(harfbuzz0);
    harfbuzz0.addImport("compat", compat);

    const harfbuzz0_test = b.addTest(.{
        .root_module = harfbuzz0,
    });
    test_step.dependOn(&b.addRunArtifact(harfbuzz0_test).step);

    const freetype22 = b.addModule("freetype22", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "freetype22", "freetype22" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.freetype22.linkTo(freetype22);
    freetype22.addImport("compat", compat);

    const freetype22_test = b.addTest(.{
        .root_module = freetype22,
    });
    test_step.dependOn(&b.addRunArtifact(freetype22_test).step);

    const gdkpixbuf2 = b.addModule("gdkpixbuf2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkpixbuf2", "gdkpixbuf2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkpixbuf2.linkTo(gdkpixbuf2);
    gdkpixbuf2.addImport("compat", compat);

    const gdkpixbuf2_test = b.addTest(.{
        .root_module = gdkpixbuf2,
    });
    test_step.dependOn(&b.addRunArtifact(gdkpixbuf2_test).step);

    const gtk4layershell1 = b.addModule("gtk4layershell1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gtk4layershell1", "gtk4layershell1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gtk4layershell1.linkTo(gtk4layershell1);
    gtk4layershell1.addImport("compat", compat);

    const gtk4layershell1_test = b.addTest(.{
        .root_module = gtk4layershell1,
    });
    test_step.dependOn(&b.addRunArtifact(gtk4layershell1_test).step);

    const adw1 = b.addModule("adw1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "adw1", "adw1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.adw1.linkTo(adw1);
    adw1.addImport("compat", compat);

    const adw1_test = b.addTest(.{
        .root_module = adw1,
    });
    test_step.dependOn(&b.addRunArtifact(adw1_test).step);

    const edataserverui1 = b.addModule("edataserverui1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "edataserverui1", "edataserverui1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.edataserverui1.linkTo(edataserverui1);
    edataserverui1.addImport("compat", compat);

    const edataserverui1_test = b.addTest(.{
        .root_module = edataserverui1,
    });
    test_step.dependOn(&b.addRunArtifact(edataserverui1_test).step);

    const gtk3 = b.addModule("gtk3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gtk3", "gtk3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gtk3.linkTo(gtk3);
    gtk3.addImport("compat", compat);

    const gtk3_test = b.addTest(.{
        .root_module = gtk3,
    });
    test_step.dependOn(&b.addRunArtifact(gtk3_test).step);

    const xlib2 = b.addModule("xlib2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "xlib2", "xlib2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.xlib2.linkTo(xlib2);
    xlib2.addImport("compat", compat);

    const xlib2_test = b.addTest(.{
        .root_module = xlib2,
    });
    test_step.dependOn(&b.addRunArtifact(xlib2_test).step);

    const gdk3 = b.addModule("gdk3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdk3", "gdk3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdk3.linkTo(gdk3);
    gdk3.addImport("compat", compat);

    const gdk3_test = b.addTest(.{
        .root_module = gdk3,
    });
    test_step.dependOn(&b.addRunArtifact(gdk3_test).step);

    const atk1 = b.addModule("atk1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "atk1", "atk1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.atk1.linkTo(atk1);
    atk1.addImport("compat", compat);

    const atk1_test = b.addTest(.{
        .root_module = atk1,
    });
    test_step.dependOn(&b.addRunArtifact(atk1_test).step);

    const edataserver1 = b.addModule("edataserver1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "edataserver1", "edataserver1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.edataserver1.linkTo(edataserver1);
    edataserver1.addImport("compat", compat);

    const edataserver1_test = b.addTest(.{
        .root_module = edataserver1,
    });
    test_step.dependOn(&b.addRunArtifact(edataserver1_test).step);

    const libxml22 = b.addModule("libxml22", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "libxml22", "libxml22" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.libxml22.linkTo(libxml22);
    libxml22.addImport("compat", compat);

    const libxml22_test = b.addTest(.{
        .root_module = libxml22,
    });
    test_step.dependOn(&b.addRunArtifact(libxml22_test).step);

    const camel1 = b.addModule("camel1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "camel1", "camel1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.camel1.linkTo(camel1);
    camel1.addImport("compat", compat);

    const camel1_test = b.addTest(.{
        .root_module = camel1,
    });
    test_step.dependOn(&b.addRunArtifact(camel1_test).step);

    const ecal2 = b.addModule("ecal2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "ecal2", "ecal2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.ecal2.linkTo(ecal2);
    ecal2.addImport("compat", compat);

    const ecal2_test = b.addTest(.{
        .root_module = ecal2,
    });
    test_step.dependOn(&b.addRunArtifact(ecal2_test).step);

    const edatacal2 = b.addModule("edatacal2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "edatacal2", "edatacal2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.edatacal2.linkTo(edatacal2);
    edatacal2.addImport("compat", compat);

    const edatacal2_test = b.addTest(.{
        .root_module = edatacal2,
    });
    test_step.dependOn(&b.addRunArtifact(edatacal2_test).step);

    const ebackend1 = b.addModule("ebackend1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "ebackend1", "ebackend1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.ebackend1.linkTo(ebackend1);
    ebackend1.addImport("compat", compat);

    const ebackend1_test = b.addTest(.{
        .root_module = ebackend1,
    });
    test_step.dependOn(&b.addRunArtifact(ebackend1_test).step);

    const edatabook1 = b.addModule("edatabook1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "edatabook1", "edatabook1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.edatabook1.linkTo(edatabook1);
    edatabook1.addImport("compat", compat);

    const edatabook1_test = b.addTest(.{
        .root_module = edatabook1,
    });
    test_step.dependOn(&b.addRunArtifact(edatabook1_test).step);

    const ebookcontacts1 = b.addModule("ebookcontacts1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "ebookcontacts1", "ebookcontacts1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.ebookcontacts1.linkTo(ebookcontacts1);
    ebookcontacts1.addImport("compat", compat);

    const ebookcontacts1_test = b.addTest(.{
        .root_module = ebookcontacts1,
    });
    test_step.dependOn(&b.addRunArtifact(ebookcontacts1_test).step);

    const ebook1 = b.addModule("ebook1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "ebook1", "ebook1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.ebook1.linkTo(ebook1);
    ebook1.addImport("compat", compat);

    const ebook1_test = b.addTest(.{
        .root_module = ebook1,
    });
    test_step.dependOn(&b.addRunArtifact(ebook1_test).step);

    const astalgreet0 = b.addModule("astalgreet0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalgreet0", "astalgreet0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalgreet0.linkTo(astalgreet0);
    astalgreet0.addImport("compat", compat);

    const astalgreet0_test = b.addTest(.{
        .root_module = astalgreet0,
    });
    test_step.dependOn(&b.addRunArtifact(astalgreet0_test).step);

    const astalbattery0 = b.addModule("astalbattery0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalbattery0", "astalbattery0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalbattery0.linkTo(astalbattery0);
    astalbattery0.addImport("compat", compat);

    const astalbattery0_test = b.addTest(.{
        .root_module = astalbattery0,
    });
    test_step.dependOn(&b.addRunArtifact(astalbattery0_test).step);

    const astalmpris0 = b.addModule("astalmpris0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalmpris0", "astalmpris0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalmpris0.linkTo(astalmpris0);
    astalmpris0.addImport("compat", compat);

    const astalmpris0_test = b.addTest(.{
        .root_module = astalmpris0,
    });
    test_step.dependOn(&b.addRunArtifact(astalmpris0_test).step);

    const astalnotifd0 = b.addModule("astalnotifd0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalnotifd0", "astalnotifd0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalnotifd0.linkTo(astalnotifd0);
    astalnotifd0.addImport("compat", compat);

    const astalnotifd0_test = b.addTest(.{
        .root_module = astalnotifd0,
    });
    test_step.dependOn(&b.addRunArtifact(astalnotifd0_test).step);

    const astalwp0 = b.addModule("astalwp0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalwp0", "astalwp0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalwp0.linkTo(astalwp0);
    astalwp0.addImport("compat", compat);

    const astalwp0_test = b.addTest(.{
        .root_module = astalwp0,
    });
    test_step.dependOn(&b.addRunArtifact(astalwp0_test).step);

    const astalbluetooth0 = b.addModule("astalbluetooth0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalbluetooth0", "astalbluetooth0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalbluetooth0.linkTo(astalbluetooth0);
    astalbluetooth0.addImport("compat", compat);

    const astalbluetooth0_test = b.addTest(.{
        .root_module = astalbluetooth0,
    });
    test_step.dependOn(&b.addRunArtifact(astalbluetooth0_test).step);

    const astalnetwork0 = b.addModule("astalnetwork0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalnetwork0", "astalnetwork0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalnetwork0.linkTo(astalnetwork0);
    astalnetwork0.addImport("compat", compat);

    const astalnetwork0_test = b.addTest(.{
        .root_module = astalnetwork0,
    });
    test_step.dependOn(&b.addRunArtifact(astalnetwork0_test).step);

    const astaltray0 = b.addModule("astaltray0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astaltray0", "astaltray0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astaltray0.linkTo(astaltray0);
    astaltray0.addImport("compat", compat);

    const astaltray0_test = b.addTest(.{
        .root_module = astaltray0,
    });
    test_step.dependOn(&b.addRunArtifact(astaltray0_test).step);

    const astalapps0 = b.addModule("astalapps0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalapps0", "astalapps0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalapps0.linkTo(astalapps0);
    astalapps0.addImport("compat", compat);

    const astalapps0_test = b.addTest(.{
        .root_module = astalapps0,
    });
    test_step.dependOn(&b.addRunArtifact(astalapps0_test).step);

    const astalhyprland0 = b.addModule("astalhyprland0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalhyprland0", "astalhyprland0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalhyprland0.linkTo(astalhyprland0);
    astalhyprland0.addImport("compat", compat);

    const astalhyprland0_test = b.addTest(.{
        .root_module = astalhyprland0,
    });
    test_step.dependOn(&b.addRunArtifact(astalhyprland0_test).step);

    const astal4 = b.addModule("astal4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astal4", "astal4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astal4.linkTo(astal4);
    astal4.addImport("compat", compat);

    const astal4_test = b.addTest(.{
        .root_module = astal4,
    });
    test_step.dependOn(&b.addRunArtifact(astal4_test).step);

    const astalio0 = b.addModule("astalio0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "astalio0", "astalio0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.astalio0.linkTo(astalio0);
    astalio0.addImport("compat", compat);

    const astalio0_test = b.addTest(.{
        .root_module = astalio0,
    });
    test_step.dependOn(&b.addRunArtifact(astalio0_test).step);

    const xrandr1 = b.addModule("xrandr1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "xrandr1", "xrandr1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.xrandr1.linkTo(xrandr1);
    xrandr1.addImport("compat", compat);

    const xrandr1_test = b.addTest(.{
        .root_module = xrandr1,
    });
    test_step.dependOn(&b.addRunArtifact(xrandr1_test).step);

    const xft2 = b.addModule("xft2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "xft2", "xft2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.xft2.linkTo(xft2);
    xft2.addImport("compat", compat);

    const xft2_test = b.addTest(.{
        .root_module = xft2,
    });
    test_step.dependOn(&b.addRunArtifact(xft2_test).step);

    const xfixes4 = b.addModule("xfixes4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "xfixes4", "xfixes4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.xfixes4.linkTo(xfixes4);
    xfixes4.addImport("compat", compat);

    const xfixes4_test = b.addTest(.{
        .root_module = xfixes4,
    });
    test_step.dependOn(&b.addRunArtifact(xfixes4_test).step);

    const win321 = b.addModule("win321", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "win321", "win321" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.win321.linkTo(win321);
    win321.addImport("compat", compat);

    const win321_test = b.addTest(.{
        .root_module = win321,
    });
    test_step.dependOn(&b.addRunArtifact(win321_test).step);

    const fontconfig2 = b.addModule("fontconfig2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "fontconfig2", "fontconfig2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.fontconfig2.linkTo(fontconfig2);
    fontconfig2.addImport("compat", compat);

    const fontconfig2_test = b.addTest(.{
        .root_module = fontconfig2,
    });
    test_step.dependOn(&b.addRunArtifact(fontconfig2_test).step);

    const vulkan1 = b.addModule("vulkan1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "vulkan1", "vulkan1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.vulkan1.linkTo(vulkan1);
    vulkan1.addImport("compat", compat);

    const vulkan1_test = b.addTest(.{
        .root_module = vulkan1,
    });
    test_step.dependOn(&b.addRunArtifact(vulkan1_test).step);

    const gl1 = b.addModule("gl1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gl1", "gl1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gl1.linkTo(gl1);
    gl1.addImport("compat", compat);

    const gl1_test = b.addTest(.{
        .root_module = gl1,
    });
    test_step.dependOn(&b.addRunArtifact(gl1_test).step);

    const girepository2 = b.addModule("girepository2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "girepository2", "girepository2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.girepository2.linkTo(girepository2);
    girepository2.addImport("compat", compat);

    const girepository2_test = b.addTest(.{
        .root_module = girepository2,
    });
    test_step.dependOn(&b.addRunArtifact(girepository2_test).step);

    const dbusglib1 = b.addModule("dbusglib1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "dbusglib1", "dbusglib1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.dbusglib1.linkTo(dbusglib1);
    dbusglib1.addImport("compat", compat);

    const dbusglib1_test = b.addTest(.{
        .root_module = dbusglib1,
    });
    test_step.dependOn(&b.addRunArtifact(dbusglib1_test).step);

    const dbus1 = b.addModule("dbus1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "dbus1", "dbus1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.dbus1.linkTo(dbus1);
    dbus1.addImport("compat", compat);

    const dbus1_test = b.addTest(.{
        .root_module = dbus1,
    });
    test_step.dependOn(&b.addRunArtifact(dbus1_test).step);

    const atspi2 = b.addModule("atspi2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "atspi2", "atspi2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.atspi2.linkTo(atspi2);
    atspi2.addImport("compat", compat);

    const atspi2_test = b.addTest(.{
        .root_module = atspi2,
    });
    test_step.dependOn(&b.addRunArtifact(atspi2_test).step);

    const gdkpixdata2 = b.addModule("gdkpixdata2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkpixdata2", "gdkpixdata2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkpixdata2.linkTo(gdkpixdata2);
    gdkpixdata2.addImport("compat", compat);

    const gdkpixdata2_test = b.addTest(.{
        .root_module = gdkpixdata2,
    });
    test_step.dependOn(&b.addRunArtifact(gdkpixdata2_test).step);

    const pangoxft1 = b.addModule("pangoxft1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pangoxft1", "pangoxft1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pangoxft1.linkTo(pangoxft1);
    pangoxft1.addImport("compat", compat);

    const pangoxft1_test = b.addTest(.{
        .root_module = pangoxft1,
    });
    test_step.dependOn(&b.addRunArtifact(pangoxft1_test).step);

    const pangoot1 = b.addModule("pangoot1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pangoot1", "pangoot1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pangoot1.linkTo(pangoot1);
    pangoot1.addImport("compat", compat);

    const pangoot1_test = b.addTest(.{
        .root_module = pangoot1,
    });
    test_step.dependOn(&b.addRunArtifact(pangoot1_test).step);

    const pangofc1 = b.addModule("pangofc1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pangofc1", "pangofc1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pangofc1.linkTo(pangofc1);
    pangofc1.addImport("compat", compat);

    const pangofc1_test = b.addTest(.{
        .root_module = pangofc1,
    });
    test_step.dependOn(&b.addRunArtifact(pangofc1_test).step);

    const pangoft21 = b.addModule("pangoft21", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pangoft21", "pangoft21" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pangoft21.linkTo(pangoft21);
    pangoft21.addImport("compat", compat);

    const pangoft21_test = b.addTest(.{
        .root_module = pangoft21,
    });
    test_step.dependOn(&b.addRunArtifact(pangoft21_test).step);

    const gdkx113 = b.addModule("gdkx113", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkx113", "gdkx113" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkx113.linkTo(gdkx113);
    gdkx113.addImport("compat", compat);

    const gdkx113_test = b.addTest(.{
        .root_module = gdkx113,
    });
    test_step.dependOn(&b.addRunArtifact(gdkx113_test).step);

    const gdkx114 = b.addModule("gdkx114", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkx114", "gdkx114" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkx114.linkTo(gdkx114);
    gdkx114.addImport("compat", compat);

    const gdkx114_test = b.addTest(.{
        .root_module = gdkx114,
    });
    test_step.dependOn(&b.addRunArtifact(gdkx114_test).step);

    const gdkwayland4 = b.addModule("gdkwayland4", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkwayland4", "gdkwayland4" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkwayland4.linkTo(gdkwayland4);
    gdkwayland4.addImport("compat", compat);

    const gdkwayland4_test = b.addTest(.{
        .root_module = gdkwayland4,
    });
    test_step.dependOn(&b.addRunArtifact(gdkwayland4_test).step);

    const giounix2 = b.addModule("giounix2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "giounix2", "giounix2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.giounix2.linkTo(giounix2);
    giounix2.addImport("compat", compat);

    const giounix2_test = b.addTest(.{
        .root_module = giounix2,
    });
    test_step.dependOn(&b.addRunArtifact(giounix2_test).step);

    const glibunix2 = b.addModule("glibunix2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "glibunix2", "glibunix2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.glibunix2.linkTo(glibunix2);
    glibunix2.addImport("compat", compat);

    const glibunix2_test = b.addTest(.{
        .root_module = glibunix2,
    });
    test_step.dependOn(&b.addRunArtifact(glibunix2_test).step);

    const girepository3 = b.addModule("girepository3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "girepository3", "girepository3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.girepository3.linkTo(girepository3);
    girepository3.addImport("compat", compat);

    const girepository3_test = b.addTest(.{
        .root_module = girepository3,
    });
    test_step.dependOn(&b.addRunArtifact(girepository3_test).step);

    icalglib3.addImport("gobject2", gobject2);
    icalglib3.addImport("glib2", glib2);
    icalglib3.addImport("icalglib3", icalglib3);
    gobject2.addImport("glib2", glib2);
    gobject2.addImport("gobject2", gobject2);
    glib2.addImport("glib2", glib2);
    ical3.addImport("gobject2", gobject2);
    ical3.addImport("glib2", glib2);
    ical3.addImport("ical3", ical3);
    json1.addImport("gio2", gio2);
    json1.addImport("gobject2", gobject2);
    json1.addImport("glib2", glib2);
    json1.addImport("gmodule2", gmodule2);
    json1.addImport("json1", json1);
    gio2.addImport("gobject2", gobject2);
    gio2.addImport("glib2", glib2);
    gio2.addImport("gmodule2", gmodule2);
    gio2.addImport("gio2", gio2);
    gmodule2.addImport("glib2", glib2);
    gmodule2.addImport("gmodule2", gmodule2);
    soup3.addImport("gio2", gio2);
    soup3.addImport("gobject2", gobject2);
    soup3.addImport("glib2", glib2);
    soup3.addImport("gmodule2", gmodule2);
    soup3.addImport("soup3", soup3);
    nm1.addImport("gio2", gio2);
    nm1.addImport("gobject2", gobject2);
    nm1.addImport("glib2", glib2);
    nm1.addImport("gmodule2", gmodule2);
    nm1.addImport("nm1", nm1);
    gtk4sessionlock1.addImport("gtk4", gtk4);
    gtk4sessionlock1.addImport("gsk4", gsk4);
    gtk4sessionlock1.addImport("graphene1", graphene1);
    gtk4sessionlock1.addImport("gobject2", gobject2);
    gtk4sessionlock1.addImport("glib2", glib2);
    gtk4sessionlock1.addImport("gdk4", gdk4);
    gtk4sessionlock1.addImport("cairo1", cairo1);
    gtk4sessionlock1.addImport("pangocairo1", pangocairo1);
    gtk4sessionlock1.addImport("pango1", pango1);
    gtk4sessionlock1.addImport("harfbuzz0", harfbuzz0);
    gtk4sessionlock1.addImport("freetype22", freetype22);
    gtk4sessionlock1.addImport("gio2", gio2);
    gtk4sessionlock1.addImport("gmodule2", gmodule2);
    gtk4sessionlock1.addImport("gdkpixbuf2", gdkpixbuf2);
    gtk4sessionlock1.addImport("gtk4sessionlock1", gtk4sessionlock1);
    gtk4.addImport("gsk4", gsk4);
    gtk4.addImport("graphene1", graphene1);
    gtk4.addImport("gobject2", gobject2);
    gtk4.addImport("glib2", glib2);
    gtk4.addImport("gdk4", gdk4);
    gtk4.addImport("cairo1", cairo1);
    gtk4.addImport("pangocairo1", pangocairo1);
    gtk4.addImport("pango1", pango1);
    gtk4.addImport("harfbuzz0", harfbuzz0);
    gtk4.addImport("freetype22", freetype22);
    gtk4.addImport("gio2", gio2);
    gtk4.addImport("gmodule2", gmodule2);
    gtk4.addImport("gdkpixbuf2", gdkpixbuf2);
    gtk4.addImport("gtk4", gtk4);
    gsk4.addImport("graphene1", graphene1);
    gsk4.addImport("gobject2", gobject2);
    gsk4.addImport("glib2", glib2);
    gsk4.addImport("gdk4", gdk4);
    gsk4.addImport("cairo1", cairo1);
    gsk4.addImport("pangocairo1", pangocairo1);
    gsk4.addImport("pango1", pango1);
    gsk4.addImport("harfbuzz0", harfbuzz0);
    gsk4.addImport("freetype22", freetype22);
    gsk4.addImport("gio2", gio2);
    gsk4.addImport("gmodule2", gmodule2);
    gsk4.addImport("gdkpixbuf2", gdkpixbuf2);
    gsk4.addImport("gsk4", gsk4);
    graphene1.addImport("gobject2", gobject2);
    graphene1.addImport("glib2", glib2);
    graphene1.addImport("graphene1", graphene1);
    gdk4.addImport("cairo1", cairo1);
    gdk4.addImport("gobject2", gobject2);
    gdk4.addImport("glib2", glib2);
    gdk4.addImport("pangocairo1", pangocairo1);
    gdk4.addImport("pango1", pango1);
    gdk4.addImport("harfbuzz0", harfbuzz0);
    gdk4.addImport("freetype22", freetype22);
    gdk4.addImport("gio2", gio2);
    gdk4.addImport("gmodule2", gmodule2);
    gdk4.addImport("gdkpixbuf2", gdkpixbuf2);
    gdk4.addImport("gdk4", gdk4);
    cairo1.addImport("gobject2", gobject2);
    cairo1.addImport("glib2", glib2);
    cairo1.addImport("cairo1", cairo1);
    pangocairo1.addImport("cairo1", cairo1);
    pangocairo1.addImport("gobject2", gobject2);
    pangocairo1.addImport("glib2", glib2);
    pangocairo1.addImport("pango1", pango1);
    pangocairo1.addImport("harfbuzz0", harfbuzz0);
    pangocairo1.addImport("freetype22", freetype22);
    pangocairo1.addImport("gio2", gio2);
    pangocairo1.addImport("gmodule2", gmodule2);
    pangocairo1.addImport("pangocairo1", pangocairo1);
    pango1.addImport("cairo1", cairo1);
    pango1.addImport("gobject2", gobject2);
    pango1.addImport("glib2", glib2);
    pango1.addImport("harfbuzz0", harfbuzz0);
    pango1.addImport("freetype22", freetype22);
    pango1.addImport("gio2", gio2);
    pango1.addImport("gmodule2", gmodule2);
    pango1.addImport("pango1", pango1);
    harfbuzz0.addImport("freetype22", freetype22);
    harfbuzz0.addImport("gobject2", gobject2);
    harfbuzz0.addImport("glib2", glib2);
    harfbuzz0.addImport("harfbuzz0", harfbuzz0);
    freetype22.addImport("freetype22", freetype22);
    gdkpixbuf2.addImport("gio2", gio2);
    gdkpixbuf2.addImport("gobject2", gobject2);
    gdkpixbuf2.addImport("glib2", glib2);
    gdkpixbuf2.addImport("gmodule2", gmodule2);
    gdkpixbuf2.addImport("gdkpixbuf2", gdkpixbuf2);
    gtk4layershell1.addImport("gtk4", gtk4);
    gtk4layershell1.addImport("gsk4", gsk4);
    gtk4layershell1.addImport("graphene1", graphene1);
    gtk4layershell1.addImport("gobject2", gobject2);
    gtk4layershell1.addImport("glib2", glib2);
    gtk4layershell1.addImport("gdk4", gdk4);
    gtk4layershell1.addImport("cairo1", cairo1);
    gtk4layershell1.addImport("pangocairo1", pangocairo1);
    gtk4layershell1.addImport("pango1", pango1);
    gtk4layershell1.addImport("harfbuzz0", harfbuzz0);
    gtk4layershell1.addImport("freetype22", freetype22);
    gtk4layershell1.addImport("gio2", gio2);
    gtk4layershell1.addImport("gmodule2", gmodule2);
    gtk4layershell1.addImport("gdkpixbuf2", gdkpixbuf2);
    gtk4layershell1.addImport("gtk4layershell1", gtk4layershell1);
    adw1.addImport("gtk4", gtk4);
    adw1.addImport("gsk4", gsk4);
    adw1.addImport("graphene1", graphene1);
    adw1.addImport("gobject2", gobject2);
    adw1.addImport("glib2", glib2);
    adw1.addImport("gdk4", gdk4);
    adw1.addImport("cairo1", cairo1);
    adw1.addImport("pangocairo1", pangocairo1);
    adw1.addImport("pango1", pango1);
    adw1.addImport("harfbuzz0", harfbuzz0);
    adw1.addImport("freetype22", freetype22);
    adw1.addImport("gio2", gio2);
    adw1.addImport("gmodule2", gmodule2);
    adw1.addImport("gdkpixbuf2", gdkpixbuf2);
    adw1.addImport("adw1", adw1);
    edataserverui1.addImport("soup3", soup3);
    edataserverui1.addImport("gio2", gio2);
    edataserverui1.addImport("gobject2", gobject2);
    edataserverui1.addImport("glib2", glib2);
    edataserverui1.addImport("gmodule2", gmodule2);
    edataserverui1.addImport("gtk3", gtk3);
    edataserverui1.addImport("xlib2", xlib2);
    edataserverui1.addImport("gdk3", gdk3);
    edataserverui1.addImport("cairo1", cairo1);
    edataserverui1.addImport("pango1", pango1);
    edataserverui1.addImport("harfbuzz0", harfbuzz0);
    edataserverui1.addImport("freetype22", freetype22);
    edataserverui1.addImport("gdkpixbuf2", gdkpixbuf2);
    edataserverui1.addImport("atk1", atk1);
    edataserverui1.addImport("edataserver1", edataserver1);
    edataserverui1.addImport("libxml22", libxml22);
    edataserverui1.addImport("json1", json1);
    edataserverui1.addImport("camel1", camel1);
    edataserverui1.addImport("ecal2", ecal2);
    edataserverui1.addImport("icalglib3", icalglib3);
    edataserverui1.addImport("edataserverui1", edataserverui1);
    gtk3.addImport("xlib2", xlib2);
    gtk3.addImport("gdk3", gdk3);
    gtk3.addImport("cairo1", cairo1);
    gtk3.addImport("gobject2", gobject2);
    gtk3.addImport("glib2", glib2);
    gtk3.addImport("pango1", pango1);
    gtk3.addImport("harfbuzz0", harfbuzz0);
    gtk3.addImport("freetype22", freetype22);
    gtk3.addImport("gio2", gio2);
    gtk3.addImport("gmodule2", gmodule2);
    gtk3.addImport("gdkpixbuf2", gdkpixbuf2);
    gtk3.addImport("atk1", atk1);
    gtk3.addImport("gtk3", gtk3);
    xlib2.addImport("xlib2", xlib2);
    gdk3.addImport("cairo1", cairo1);
    gdk3.addImport("gobject2", gobject2);
    gdk3.addImport("glib2", glib2);
    gdk3.addImport("pango1", pango1);
    gdk3.addImport("harfbuzz0", harfbuzz0);
    gdk3.addImport("freetype22", freetype22);
    gdk3.addImport("gio2", gio2);
    gdk3.addImport("gmodule2", gmodule2);
    gdk3.addImport("gdkpixbuf2", gdkpixbuf2);
    gdk3.addImport("gdk3", gdk3);
    atk1.addImport("gobject2", gobject2);
    atk1.addImport("glib2", glib2);
    atk1.addImport("atk1", atk1);
    edataserver1.addImport("libxml22", libxml22);
    edataserver1.addImport("soup3", soup3);
    edataserver1.addImport("gio2", gio2);
    edataserver1.addImport("gobject2", gobject2);
    edataserver1.addImport("glib2", glib2);
    edataserver1.addImport("gmodule2", gmodule2);
    edataserver1.addImport("json1", json1);
    edataserver1.addImport("camel1", camel1);
    edataserver1.addImport("edataserver1", edataserver1);
    libxml22.addImport("libxml22", libxml22);
    camel1.addImport("libxml22", libxml22);
    camel1.addImport("gio2", gio2);
    camel1.addImport("gobject2", gobject2);
    camel1.addImport("glib2", glib2);
    camel1.addImport("gmodule2", gmodule2);
    camel1.addImport("camel1", camel1);
    ecal2.addImport("icalglib3", icalglib3);
    ecal2.addImport("gobject2", gobject2);
    ecal2.addImport("glib2", glib2);
    ecal2.addImport("gio2", gio2);
    ecal2.addImport("gmodule2", gmodule2);
    ecal2.addImport("edataserver1", edataserver1);
    ecal2.addImport("libxml22", libxml22);
    ecal2.addImport("soup3", soup3);
    ecal2.addImport("json1", json1);
    ecal2.addImport("camel1", camel1);
    ecal2.addImport("ecal2", ecal2);
    edatacal2.addImport("icalglib3", icalglib3);
    edatacal2.addImport("gobject2", gobject2);
    edatacal2.addImport("glib2", glib2);
    edatacal2.addImport("gio2", gio2);
    edatacal2.addImport("gmodule2", gmodule2);
    edatacal2.addImport("edataserver1", edataserver1);
    edatacal2.addImport("libxml22", libxml22);
    edatacal2.addImport("soup3", soup3);
    edatacal2.addImport("json1", json1);
    edatacal2.addImport("camel1", camel1);
    edatacal2.addImport("ecal2", ecal2);
    edatacal2.addImport("ebackend1", ebackend1);
    edatacal2.addImport("edatacal2", edatacal2);
    ebackend1.addImport("gio2", gio2);
    ebackend1.addImport("gobject2", gobject2);
    ebackend1.addImport("glib2", glib2);
    ebackend1.addImport("gmodule2", gmodule2);
    ebackend1.addImport("edataserver1", edataserver1);
    ebackend1.addImport("libxml22", libxml22);
    ebackend1.addImport("soup3", soup3);
    ebackend1.addImport("json1", json1);
    ebackend1.addImport("camel1", camel1);
    ebackend1.addImport("ebackend1", ebackend1);
    edatabook1.addImport("gio2", gio2);
    edatabook1.addImport("gobject2", gobject2);
    edatabook1.addImport("glib2", glib2);
    edatabook1.addImport("gmodule2", gmodule2);
    edatabook1.addImport("edataserver1", edataserver1);
    edatabook1.addImport("libxml22", libxml22);
    edatabook1.addImport("soup3", soup3);
    edatabook1.addImport("json1", json1);
    edatabook1.addImport("camel1", camel1);
    edatabook1.addImport("ebookcontacts1", ebookcontacts1);
    edatabook1.addImport("ebackend1", ebackend1);
    edatabook1.addImport("edatabook1", edatabook1);
    ebookcontacts1.addImport("gio2", gio2);
    ebookcontacts1.addImport("gobject2", gobject2);
    ebookcontacts1.addImport("glib2", glib2);
    ebookcontacts1.addImport("gmodule2", gmodule2);
    ebookcontacts1.addImport("edataserver1", edataserver1);
    ebookcontacts1.addImport("libxml22", libxml22);
    ebookcontacts1.addImport("soup3", soup3);
    ebookcontacts1.addImport("json1", json1);
    ebookcontacts1.addImport("camel1", camel1);
    ebookcontacts1.addImport("ebookcontacts1", ebookcontacts1);
    ebook1.addImport("libxml22", libxml22);
    ebook1.addImport("gio2", gio2);
    ebook1.addImport("gobject2", gobject2);
    ebook1.addImport("glib2", glib2);
    ebook1.addImport("gmodule2", gmodule2);
    ebook1.addImport("edataserver1", edataserver1);
    ebook1.addImport("soup3", soup3);
    ebook1.addImport("json1", json1);
    ebook1.addImport("camel1", camel1);
    ebook1.addImport("ebookcontacts1", ebookcontacts1);
    ebook1.addImport("ebook1", ebook1);
    astalgreet0.addImport("gio2", gio2);
    astalgreet0.addImport("gobject2", gobject2);
    astalgreet0.addImport("glib2", glib2);
    astalgreet0.addImport("gmodule2", gmodule2);
    astalgreet0.addImport("astalgreet0", astalgreet0);
    astalbattery0.addImport("glib2", glib2);
    astalbattery0.addImport("gobject2", gobject2);
    astalbattery0.addImport("astalbattery0", astalbattery0);
    astalmpris0.addImport("glib2", glib2);
    astalmpris0.addImport("gio2", gio2);
    astalmpris0.addImport("gobject2", gobject2);
    astalmpris0.addImport("gmodule2", gmodule2);
    astalmpris0.addImport("astalmpris0", astalmpris0);
    astalnotifd0.addImport("gio2", gio2);
    astalnotifd0.addImport("gobject2", gobject2);
    astalnotifd0.addImport("glib2", glib2);
    astalnotifd0.addImport("gmodule2", gmodule2);
    astalnotifd0.addImport("astalnotifd0", astalnotifd0);
    astalwp0.addImport("gio2", gio2);
    astalwp0.addImport("gobject2", gobject2);
    astalwp0.addImport("glib2", glib2);
    astalwp0.addImport("gmodule2", gmodule2);
    astalwp0.addImport("astalwp0", astalwp0);
    astalbluetooth0.addImport("gio2", gio2);
    astalbluetooth0.addImport("gobject2", gobject2);
    astalbluetooth0.addImport("glib2", glib2);
    astalbluetooth0.addImport("gmodule2", gmodule2);
    astalbluetooth0.addImport("astalbluetooth0", astalbluetooth0);
    astalnetwork0.addImport("gio2", gio2);
    astalnetwork0.addImport("gobject2", gobject2);
    astalnetwork0.addImport("glib2", glib2);
    astalnetwork0.addImport("gmodule2", gmodule2);
    astalnetwork0.addImport("nm1", nm1);
    astalnetwork0.addImport("astalnetwork0", astalnetwork0);
    astaltray0.addImport("gio2", gio2);
    astaltray0.addImport("gobject2", gobject2);
    astaltray0.addImport("glib2", glib2);
    astaltray0.addImport("gmodule2", gmodule2);
    astaltray0.addImport("gdkpixbuf2", gdkpixbuf2);
    astaltray0.addImport("astaltray0", astaltray0);
    astalapps0.addImport("glib2", glib2);
    astalapps0.addImport("gobject2", gobject2);
    astalapps0.addImport("astalapps0", astalapps0);
    astalhyprland0.addImport("glib2", glib2);
    astalhyprland0.addImport("gio2", gio2);
    astalhyprland0.addImport("gobject2", gobject2);
    astalhyprland0.addImport("gmodule2", gmodule2);
    astalhyprland0.addImport("astalhyprland0", astalhyprland0);
    astal4.addImport("gio2", gio2);
    astal4.addImport("gobject2", gobject2);
    astal4.addImport("glib2", glib2);
    astal4.addImport("gmodule2", gmodule2);
    astal4.addImport("astalio0", astalio0);
    astal4.addImport("gdk4", gdk4);
    astal4.addImport("cairo1", cairo1);
    astal4.addImport("pangocairo1", pangocairo1);
    astal4.addImport("pango1", pango1);
    astal4.addImport("harfbuzz0", harfbuzz0);
    astal4.addImport("freetype22", freetype22);
    astal4.addImport("gdkpixbuf2", gdkpixbuf2);
    astal4.addImport("gtk4", gtk4);
    astal4.addImport("gsk4", gsk4);
    astal4.addImport("graphene1", graphene1);
    astal4.addImport("astal4", astal4);
    astalio0.addImport("glib2", glib2);
    astalio0.addImport("gobject2", gobject2);
    astalio0.addImport("gio2", gio2);
    astalio0.addImport("gmodule2", gmodule2);
    astalio0.addImport("astalio0", astalio0);
    xrandr1.addImport("xrandr1", xrandr1);
    xft2.addImport("xlib2", xlib2);
    xft2.addImport("xft2", xft2);
    xfixes4.addImport("xfixes4", xfixes4);
    win321.addImport("win321", win321);
    fontconfig2.addImport("fontconfig2", fontconfig2);
    vulkan1.addImport("vulkan1", vulkan1);
    gl1.addImport("gl1", gl1);
    girepository2.addImport("gobject2", gobject2);
    girepository2.addImport("glib2", glib2);
    girepository2.addImport("girepository2", girepository2);
    dbusglib1.addImport("gobject2", gobject2);
    dbusglib1.addImport("glib2", glib2);
    dbusglib1.addImport("dbusglib1", dbusglib1);
    dbus1.addImport("dbus1", dbus1);
    atspi2.addImport("gobject2", gobject2);
    atspi2.addImport("glib2", glib2);
    atspi2.addImport("dbus1", dbus1);
    atspi2.addImport("atspi2", atspi2);
    gdkpixdata2.addImport("gdkpixbuf2", gdkpixbuf2);
    gdkpixdata2.addImport("gio2", gio2);
    gdkpixdata2.addImport("gobject2", gobject2);
    gdkpixdata2.addImport("glib2", glib2);
    gdkpixdata2.addImport("gmodule2", gmodule2);
    gdkpixdata2.addImport("gdkpixdata2", gdkpixdata2);
    pangoxft1.addImport("xlib2", xlib2);
    pangoxft1.addImport("xft2", xft2);
    pangoxft1.addImport("pangoot1", pangoot1);
    pangoxft1.addImport("freetype22", freetype22);
    pangoxft1.addImport("pangofc1", pangofc1);
    pangoxft1.addImport("fontconfig2", fontconfig2);
    pangoxft1.addImport("pango1", pango1);
    pangoxft1.addImport("cairo1", cairo1);
    pangoxft1.addImport("gobject2", gobject2);
    pangoxft1.addImport("glib2", glib2);
    pangoxft1.addImport("harfbuzz0", harfbuzz0);
    pangoxft1.addImport("gio2", gio2);
    pangoxft1.addImport("gmodule2", gmodule2);
    pangoxft1.addImport("pangoft21", pangoft21);
    pangoxft1.addImport("pangoxft1", pangoxft1);
    pangoot1.addImport("freetype22", freetype22);
    pangoot1.addImport("pangofc1", pangofc1);
    pangoot1.addImport("fontconfig2", fontconfig2);
    pangoot1.addImport("pango1", pango1);
    pangoot1.addImport("cairo1", cairo1);
    pangoot1.addImport("gobject2", gobject2);
    pangoot1.addImport("glib2", glib2);
    pangoot1.addImport("harfbuzz0", harfbuzz0);
    pangoot1.addImport("gio2", gio2);
    pangoot1.addImport("gmodule2", gmodule2);
    pangoot1.addImport("pangoot1", pangoot1);
    pangofc1.addImport("fontconfig2", fontconfig2);
    pangofc1.addImport("pango1", pango1);
    pangofc1.addImport("cairo1", cairo1);
    pangofc1.addImport("gobject2", gobject2);
    pangofc1.addImport("glib2", glib2);
    pangofc1.addImport("harfbuzz0", harfbuzz0);
    pangofc1.addImport("freetype22", freetype22);
    pangofc1.addImport("gio2", gio2);
    pangofc1.addImport("gmodule2", gmodule2);
    pangofc1.addImport("pangofc1", pangofc1);
    pangoft21.addImport("freetype22", freetype22);
    pangoft21.addImport("pangofc1", pangofc1);
    pangoft21.addImport("fontconfig2", fontconfig2);
    pangoft21.addImport("pango1", pango1);
    pangoft21.addImport("cairo1", cairo1);
    pangoft21.addImport("gobject2", gobject2);
    pangoft21.addImport("glib2", glib2);
    pangoft21.addImport("harfbuzz0", harfbuzz0);
    pangoft21.addImport("gio2", gio2);
    pangoft21.addImport("gmodule2", gmodule2);
    pangoft21.addImport("pangoft21", pangoft21);
    gdkx113.addImport("xlib2", xlib2);
    gdkx113.addImport("cairo1", cairo1);
    gdkx113.addImport("gobject2", gobject2);
    gdkx113.addImport("glib2", glib2);
    gdkx113.addImport("pango1", pango1);
    gdkx113.addImport("harfbuzz0", harfbuzz0);
    gdkx113.addImport("freetype22", freetype22);
    gdkx113.addImport("gio2", gio2);
    gdkx113.addImport("gmodule2", gmodule2);
    gdkx113.addImport("gdkpixbuf2", gdkpixbuf2);
    gdkx113.addImport("gdk3", gdk3);
    gdkx113.addImport("gdkx113", gdkx113);
    gdkx114.addImport("xlib2", xlib2);
    gdkx114.addImport("gdk4", gdk4);
    gdkx114.addImport("cairo1", cairo1);
    gdkx114.addImport("gobject2", gobject2);
    gdkx114.addImport("glib2", glib2);
    gdkx114.addImport("pangocairo1", pangocairo1);
    gdkx114.addImport("pango1", pango1);
    gdkx114.addImport("harfbuzz0", harfbuzz0);
    gdkx114.addImport("freetype22", freetype22);
    gdkx114.addImport("gio2", gio2);
    gdkx114.addImport("gmodule2", gmodule2);
    gdkx114.addImport("gdkpixbuf2", gdkpixbuf2);
    gdkx114.addImport("gdkx114", gdkx114);
    gdkwayland4.addImport("gdk4", gdk4);
    gdkwayland4.addImport("cairo1", cairo1);
    gdkwayland4.addImport("gobject2", gobject2);
    gdkwayland4.addImport("glib2", glib2);
    gdkwayland4.addImport("pangocairo1", pangocairo1);
    gdkwayland4.addImport("pango1", pango1);
    gdkwayland4.addImport("harfbuzz0", harfbuzz0);
    gdkwayland4.addImport("freetype22", freetype22);
    gdkwayland4.addImport("gio2", gio2);
    gdkwayland4.addImport("gmodule2", gmodule2);
    gdkwayland4.addImport("gdkpixbuf2", gdkpixbuf2);
    gdkwayland4.addImport("gdkwayland4", gdkwayland4);
    giounix2.addImport("gio2", gio2);
    giounix2.addImport("gobject2", gobject2);
    giounix2.addImport("glib2", glib2);
    giounix2.addImport("gmodule2", gmodule2);
    giounix2.addImport("giounix2", giounix2);
    glibunix2.addImport("glib2", glib2);
    glibunix2.addImport("glibunix2", glibunix2);
    girepository3.addImport("gio2", gio2);
    girepository3.addImport("gobject2", gobject2);
    girepository3.addImport("glib2", glib2);
    girepository3.addImport("gmodule2", gmodule2);
    girepository3.addImport("girepository3", girepository3);
    const docs_mod = b.createModule(.{
        .root_source_file = b.path("src/root/root.zig"),
        .target = target,
        .optimize = .Debug,
    });
    const docs_obj = b.addObject(.{
        .name = "docs",
        .root_module = docs_mod,
    });
    const install_docs = b.addInstallDirectory(.{
        .source_dir = docs_obj.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs",
    });
    docs_step.dependOn(&install_docs.step);
    docs_mod.addImport("icalglib3", icalglib3);
    docs_mod.addImport("gobject2", gobject2);
    docs_mod.addImport("glib2", glib2);
    docs_mod.addImport("ical3", ical3);
    docs_mod.addImport("json1", json1);
    docs_mod.addImport("gio2", gio2);
    docs_mod.addImport("gmodule2", gmodule2);
    docs_mod.addImport("soup3", soup3);
    docs_mod.addImport("nm1", nm1);
    docs_mod.addImport("gtk4sessionlock1", gtk4sessionlock1);
    docs_mod.addImport("gtk4", gtk4);
    docs_mod.addImport("gsk4", gsk4);
    docs_mod.addImport("graphene1", graphene1);
    docs_mod.addImport("gdk4", gdk4);
    docs_mod.addImport("cairo1", cairo1);
    docs_mod.addImport("pangocairo1", pangocairo1);
    docs_mod.addImport("pango1", pango1);
    docs_mod.addImport("harfbuzz0", harfbuzz0);
    docs_mod.addImport("freetype22", freetype22);
    docs_mod.addImport("gdkpixbuf2", gdkpixbuf2);
    docs_mod.addImport("gtk4layershell1", gtk4layershell1);
    docs_mod.addImport("adw1", adw1);
    docs_mod.addImport("edataserverui1", edataserverui1);
    docs_mod.addImport("gtk3", gtk3);
    docs_mod.addImport("xlib2", xlib2);
    docs_mod.addImport("gdk3", gdk3);
    docs_mod.addImport("atk1", atk1);
    docs_mod.addImport("edataserver1", edataserver1);
    docs_mod.addImport("libxml22", libxml22);
    docs_mod.addImport("camel1", camel1);
    docs_mod.addImport("ecal2", ecal2);
    docs_mod.addImport("edatacal2", edatacal2);
    docs_mod.addImport("ebackend1", ebackend1);
    docs_mod.addImport("edatabook1", edatabook1);
    docs_mod.addImport("ebookcontacts1", ebookcontacts1);
    docs_mod.addImport("ebook1", ebook1);
    docs_mod.addImport("astalgreet0", astalgreet0);
    docs_mod.addImport("astalbattery0", astalbattery0);
    docs_mod.addImport("astalmpris0", astalmpris0);
    docs_mod.addImport("astalnotifd0", astalnotifd0);
    docs_mod.addImport("astalwp0", astalwp0);
    docs_mod.addImport("astalbluetooth0", astalbluetooth0);
    docs_mod.addImport("astalnetwork0", astalnetwork0);
    docs_mod.addImport("astaltray0", astaltray0);
    docs_mod.addImport("astalapps0", astalapps0);
    docs_mod.addImport("astalhyprland0", astalhyprland0);
    docs_mod.addImport("astal4", astal4);
    docs_mod.addImport("astalio0", astalio0);
    docs_mod.addImport("xrandr1", xrandr1);
    docs_mod.addImport("xft2", xft2);
    docs_mod.addImport("xfixes4", xfixes4);
    docs_mod.addImport("win321", win321);
    docs_mod.addImport("fontconfig2", fontconfig2);
    docs_mod.addImport("vulkan1", vulkan1);
    docs_mod.addImport("gl1", gl1);
    docs_mod.addImport("girepository2", girepository2);
    docs_mod.addImport("dbusglib1", dbusglib1);
    docs_mod.addImport("dbus1", dbus1);
    docs_mod.addImport("atspi2", atspi2);
    docs_mod.addImport("gdkpixdata2", gdkpixdata2);
    docs_mod.addImport("pangoxft1", pangoxft1);
    docs_mod.addImport("pangoot1", pangoot1);
    docs_mod.addImport("pangofc1", pangofc1);
    docs_mod.addImport("pangoft21", pangoft21);
    docs_mod.addImport("gdkx113", gdkx113);
    docs_mod.addImport("gdkx114", gdkx114);
    docs_mod.addImport("gdkwayland4", gdkwayland4);
    docs_mod.addImport("giounix2", giounix2);
    docs_mod.addImport("glibunix2", glibunix2);
    docs_mod.addImport("girepository3", girepository3);
}

pub const libraries = struct {
    pub const icalglib3: Library = .{
        .system_libraries = &.{"libical-glib"},
    };

    pub const gobject2: Library = .{
        .system_libraries = &.{"gobject-2.0"},
    };

    pub const glib2: Library = .{
        .system_libraries = &.{"glib-2.0"},
    };

    pub const ical3: Library = .{
        .system_libraries = &.{"libical"},
    };

    pub const json1: Library = .{
        .system_libraries = &.{"json-glib-1.0"},
    };

    pub const gio2: Library = .{
        .system_libraries = &.{ "gio-2.0", "gio-unix-2.0" },
    };

    pub const gmodule2: Library = .{
        .system_libraries = &.{"gmodule-2.0"},
    };

    pub const soup3: Library = .{
        .system_libraries = &.{"libsoup-3.0"},
    };

    pub const nm1: Library = .{
        .system_libraries = &.{"libnm"},
    };

    pub const gtk4sessionlock1: Library = .{
        .system_libraries = &.{"gtk4-layer-shell-0"},
    };

    pub const gtk4: Library = .{
        .system_libraries = &.{"gtk4"},
    };

    pub const gsk4: Library = .{
        .system_libraries = &.{"gtk4"},
    };

    pub const graphene1: Library = .{
        .system_libraries = &.{"graphene-gobject-1.0"},
    };

    pub const gdk4: Library = .{
        .system_libraries = &.{"gtk4"},
    };

    pub const cairo1: Library = .{
        .system_libraries = &.{"cairo-gobject"},
    };

    pub const pangocairo1: Library = .{
        .system_libraries = &.{"pangocairo"},
    };

    pub const pango1: Library = .{
        .system_libraries = &.{"pango"},
    };

    pub const harfbuzz0: Library = .{
        .system_libraries = &.{ "harfbuzz", "harfbuzz-gobject" },
    };

    pub const freetype22: Library = .{
        .system_libraries = &.{},
    };

    pub const gdkpixbuf2: Library = .{
        .system_libraries = &.{"gdk-pixbuf-2.0"},
    };

    pub const gtk4layershell1: Library = .{
        .system_libraries = &.{"gtk4-layer-shell-0"},
    };

    pub const adw1: Library = .{
        .system_libraries = &.{"libadwaita-1"},
    };

    pub const edataserverui1: Library = .{
        .system_libraries = &.{"libedataserverui-1.2"},
    };

    pub const gtk3: Library = .{
        .system_libraries = &.{"gtk+-3.0"},
    };

    pub const xlib2: Library = .{
        .system_libraries = &.{},
    };

    pub const gdk3: Library = .{
        .system_libraries = &.{"gdk-3.0"},
    };

    pub const atk1: Library = .{
        .system_libraries = &.{"atk"},
    };

    pub const edataserver1: Library = .{
        .system_libraries = &.{"libedataserver-1.2"},
    };

    pub const libxml22: Library = .{
        .system_libraries = &.{"libxml-2.0"},
    };

    pub const camel1: Library = .{
        .system_libraries = &.{"camel-1.2"},
    };

    pub const ecal2: Library = .{
        .system_libraries = &.{"libecal-2.0"},
    };

    pub const edatacal2: Library = .{
        .system_libraries = &.{"libedata-cal-2.0"},
    };

    pub const ebackend1: Library = .{
        .system_libraries = &.{"libebackend-1.2"},
    };

    pub const edatabook1: Library = .{
        .system_libraries = &.{"libedata-book-1.2"},
    };

    pub const ebookcontacts1: Library = .{
        .system_libraries = &.{"libebook-contacts-1.2"},
    };

    pub const ebook1: Library = .{
        .system_libraries = &.{"libebook-1.2"},
    };

    pub const astalgreet0: Library = .{
        .system_libraries = &.{"astal-greet"},
    };

    pub const astalbattery0: Library = .{
        .system_libraries = &.{"astal-battery"},
    };

    pub const astalmpris0: Library = .{
        .system_libraries = &.{"astal-mpris"},
    };

    pub const astalnotifd0: Library = .{
        .system_libraries = &.{"astal-notifd"},
    };

    pub const astalwp0: Library = .{
        .system_libraries = &.{"astal-wireplumber-0.1"},
    };

    pub const astalbluetooth0: Library = .{
        .system_libraries = &.{"astal-bluetooth"},
    };

    pub const astalnetwork0: Library = .{
        .system_libraries = &.{"astal-network"},
    };

    pub const astaltray0: Library = .{
        .system_libraries = &.{"astal-tray"},
    };

    pub const astalapps0: Library = .{
        .system_libraries = &.{"astal-apps"},
    };

    pub const astalhyprland0: Library = .{
        .system_libraries = &.{"astal-hyprland"},
    };

    pub const astal4: Library = .{
        .system_libraries = &.{"astal-4"},
    };

    pub const astalio0: Library = .{
        .system_libraries = &.{"astal-io"},
    };

    pub const xrandr1: Library = .{
        .system_libraries = &.{},
    };

    pub const xft2: Library = .{
        .system_libraries = &.{},
    };

    pub const xfixes4: Library = .{
        .system_libraries = &.{},
    };

    pub const win321: Library = .{
        .system_libraries = &.{},
    };

    pub const fontconfig2: Library = .{
        .system_libraries = &.{},
    };

    pub const vulkan1: Library = .{
        .system_libraries = &.{},
    };

    pub const gl1: Library = .{
        .system_libraries = &.{},
    };

    pub const girepository2: Library = .{
        .system_libraries = &.{"gobject-introspection-1.0"},
    };

    pub const dbusglib1: Library = .{
        .system_libraries = &.{"dbus-glib-1"},
    };

    pub const dbus1: Library = .{
        .system_libraries = &.{"dbus-1"},
    };

    pub const atspi2: Library = .{
        .system_libraries = &.{"atspi-2"},
    };

    pub const gdkpixdata2: Library = .{
        .system_libraries = &.{"gdk-pixbuf-2.0"},
    };

    pub const pangoxft1: Library = .{
        .system_libraries = &.{"pangoxft"},
    };

    pub const pangoot1: Library = .{
        .system_libraries = &.{"pangoot"},
    };

    pub const pangofc1: Library = .{
        .system_libraries = &.{"pangofc"},
    };

    pub const pangoft21: Library = .{
        .system_libraries = &.{"pangoft2"},
    };

    pub const gdkx113: Library = .{
        .system_libraries = &.{"gdk-x11-3.0"},
    };

    pub const gdkx114: Library = .{
        .system_libraries = &.{"gtk4-x11"},
    };

    pub const gdkwayland4: Library = .{
        .system_libraries = &.{"gtk4-wayland"},
    };

    pub const giounix2: Library = .{
        .system_libraries = &.{"gio-unix-2.0"},
    };

    pub const glibunix2: Library = .{
        .system_libraries = &.{"glib-2.0"},
    };

    pub const girepository3: Library = .{
        .system_libraries = &.{"girepository-2.0"},
    };
};
