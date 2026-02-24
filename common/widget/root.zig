pub const clock = @import("clock.zig");
pub const indicators = @import("indicators.zig");
pub const icon = @import("icon.zig");
pub const hyprland = @import("hyprland.zig");
pub const power_button = @import("power_button.zig");

const std = @import("std");
const gtk = @import("gtk");
const gdk = @import("gdk");
const gobject = @import("gobject");

const SignalEntry = struct {
    handler_id: c_ulong,
    obj: *gobject.Object,

    pub fn disconnect(self: SignalEntry) void {
        _ = self;
        //gobject.signalHandlerDisconnect(self.obj, self.handler_id);
    }
};

pub const InitializationDetails = struct {
    orientation: gtk.Orientation,
    spacing: c_int,
    monitor: *gdk.Monitor,
    requestHandler: *const fn ([:0]const u8) void,
};

pub const WidgetBase = struct {
    allocator: *std.mem.Allocator,
    root: *gtk.Widget,
    signals: std.ArrayList(SignalEntry),

    pub fn connect(
        self: *WidgetBase, 
        widget: anytype,
        p_instance: anytype, 
        comptime signal: anytype, 
        p_callback: anytype,
    ) c_ulong {
        const id = signal.connect(p_instance, @TypeOf(widget), p_callback, widget, .{});
        self.signals.append(self.allocator.*, .{
            .handler_id = id,
            .obj = p_instance.as(gobject.Object),
        }) catch {
            @panic("Failed to connect signal");
        };
        return id;
    }

    pub fn disconnect(
        self: *WidgetBase,
        id: c_ulong,
    ) void {
        for(self.signals.items, 0..) |signal, i| {
            if(signal.handler_id == id) {
                //gobject.signalHandlerDisconnect(signal.obj, signal.handler_id);
                _ = self.signals.orderedRemove(i);
            }
        }
    }

    pub fn connectNotify(
        self: *WidgetBase,
        widget: anytype,
        p_instance: anytype,
        comptime property: [:0]const u8,
        p_callback: *const fn (@TypeOf(p_instance), *gobject.ParamSpec, @TypeOf(widget)) callconv(.c) void,
    ) c_ulong {
        const id = gobject.Object.signals.notify.connect(p_instance, @TypeOf(widget), p_callback, widget,.{ .detail = property });
        self.signals.append(self.allocator.*, .{
            .handler_id = id,
            .obj = p_instance.as(gobject.Object),
        }) catch {
            @panic("Failed to connect signal");
        };

        return id;
    }

    pub fn deinit(self: WidgetBase) void {
        _ = self;
    }
};

pub const Component = struct {
    ptr: *anyopaque,
    getBase: *const fn(*anyopaque) *WidgetBase,
    deinit: *const fn(*anyopaque) void,
};

pub fn wrapDefineComponent(comptime T: type, instance: *T) Component {
    const wrapper = struct {
        pub fn getBase(p: *anyopaque) *WidgetBase {
            const concrete = @as(*T, @alignCast(@ptrCast(p)));
            return &concrete.base;
        }
        pub fn deinit(p: *anyopaque) void {
            const concrete = @as(*T, @alignCast(@ptrCast(p)));
            concrete.deinit();
        }
    };
    return Component{
        .ptr = instance,
        .getBase = wrapper.getBase,
        .deinit = wrapper.deinit,
    };
}

pub fn DefineComponent(comptime Widget: type, comptime WidgetParams: type, initFn: *const fn(*WidgetBase, *Widget, *const WidgetParams, InitializationDetails) void) type {
    return struct {
        base: WidgetBase,
        fields: *Widget,

        pub fn init(allocator: *std.mem.Allocator, params: WidgetParams, details: InitializationDetails) !*@This() {
            const self = try allocator.create(@This());
            self.base.allocator = allocator;
            self.base.signals = std.ArrayList(SignalEntry).empty;

            self.fields = try allocator.create(Widget);
            initFn(&self.base, self.fields, &params, details);

            self.base.root = self.fields.getRoot();

            return self;
        }

        pub fn getBase(self: *@This()) WidgetBase {
            return self.base;
        }

        pub fn getFields(self: *@This()) *Widget {
            return self.fields;
        }

        pub fn deinit(self: *@This()) void {
            self.base.deinit();
            self.fields.deinit();
        }
    };
}

pub const ExampleComponentParams = struct {
    label: []const u8,
};

pub const ExampleComponentFields = struct {
    root: *gtk.Box,
    label: *gtk.Label,
    button: *gtk.Button,

    pub fn init(base: *WidgetBase, self: *ExampleComponentFields, params: *const ExampleComponentParams, details: InitializationDetails) void {
        self.root = gtk.Box.new(details.orientation, 0);
        self.root.f_parent_instance.setValign(gtk.Align.center);
        self.label = gtk.Label.new(@ptrCast(params.label.ptr));
        self.button = gtk.Button.new();
        self.button.setLabel("Do it!");

        self.root.append(self.label.as(gtk.Widget));
        self.root.append(self.button.as(gtk.Widget));

        _ = base.connect(self, self.button, gtk.Button.signals.clicked, &handleBtnPressed);
    }

    fn getRoot(self: *const ExampleComponentFields) *gtk.Widget {
        return self.root.as(gtk.Widget);
    }

    fn handleBtnPressed(_: *gtk.Button, _: *ExampleComponentFields) callconv(.c) void {
        std.debug.print("Hello, World!", .{});
    }

    pub fn deinit(_: *@This()) void {
    }
};

pub const ExampleWidget = DefineComponent(ExampleComponentFields, ExampleComponentParams, &ExampleComponentFields.init);
