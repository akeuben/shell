const std = @import("std");
const glib = @import("glib");
const gobject = @import("gobject");
const gio = @import("gio");
const gtk = @import("gtk");
const gdk = @import("gdk");
const cairo = @import("cairo");
const astal = @import("astal");
const gsk = @import("gsk");

pub const Corner = enum(usize) {
    TOP_LEFT = 0,
    TOP_RIGHT = 1,
    BOTTOM_RIGHT = 2,
    BOTTOM_LEFT = 3,
};

pub const InvertedCorner = extern struct {
    parent_instance: Parent,

    pub const Parent = gtk.DrawingArea;

    const Private = struct {
        corner: Corner,
        radius: u32,

        start: f32,
        diff: i32,

        from: u32,
        duration: f32,
        tick: ?c_uint,

        var offset: c_int = 0;
    };

    pub const getGObjectType = gobject.ext.defineClass(InvertedCorner, .{
        .classInit = &Class.init,
        .private = .{ .Type = Private, .offset = &Private.offset },
    });

    pub fn new(radius: u32, corner: Corner) *InvertedCorner {
        const instance = gobject.ext.newInstance(InvertedCorner, .{});

        instance.parent_instance.setContentWidth(@intCast(radius));
        instance.parent_instance.setContentHeight(@intCast(radius));

        instance.private().corner = corner;
        instance.private().radius = radius;
        
        return instance;
    }

    pub fn as(self: *InvertedCorner, comptime T: type) *T {
        return gobject.ext.as(T, self);
    }

    pub fn setRadius(self: *InvertedCorner, radius: u32) void {
        self.private().radius = radius;
        self.parent_instance.setContentWidth(@intCast(radius));
        self.parent_instance.setContentHeight(@intCast(radius));

        self.parent_instance.f_widget.queueResize();
        self.parent_instance.f_widget.queueDraw();
    }

    pub fn setRadiusAnimated(self: *InvertedCorner, radius: u32, duration: f32) void {
        self.private().start = @as(f32, @floatFromInt(glib.getMonotonicTime())) / 1.0E6;
        self.private().diff = @as(i32, @intCast(radius)) - @as(i32, @intCast(self.private().radius));
        self.private().duration = duration;
        self.private().from = self.private().radius;

        if(self.private().tick) |tick| {
            self.parent_instance.f_widget.removeTickCallback(tick);
        }
        
        self.private().tick = self.parent_instance.f_widget.addTickCallback(&onAnimateCallback, @ptrCast(self), null);
    }

    fn onAnimateCallback(_: *gtk.Widget, _: *gdk.FrameClock, selfRaw: ?*anyopaque) callconv(.c) c_int {
        const self: *InvertedCorner = @alignCast(@ptrCast(selfRaw));
        const time = @as(f32, @floatFromInt(glib.getMonotonicTime())) / 1.0E6;

        const elapsed = time - self.private().start;

        const t = @min(1.0, elapsed / self.private().duration);

        const radius: u32 = @intFromFloat(@as(f32, @floatFromInt(self.private().from)) + @as(f32, @floatFromInt(self.private().diff)) * t);

        self.setRadius(radius);

        if(t >= 1) {
            return @intFromBool(glib.SOURCE_REMOVE);
        }
        return @intFromBool(glib.SOURCE_CONTINUE);
    }

    pub fn snapshotImpl(self: *InvertedCorner, snapshot: *gtk.Snapshot) callconv(.c) void {
        const corner = private(self).corner;
        const radius: f32 = @floatFromInt(private(self).radius);

        const builder = gsk.PathBuilder.new();

        switch (corner) {
            .TOP_LEFT => {
                builder.moveTo(radius, 0);
                builder.lineTo(0, 0);
                builder.lineTo(0, radius);
                builder.arcTo(0, 0, radius, 0);
            },
            .TOP_RIGHT => {
                builder.moveTo(radius, radius);
                builder.lineTo(radius, 0);
                builder.lineTo(0, 0);
                builder.arcTo(radius, 0, radius, radius);
            },
            .BOTTOM_RIGHT => {
                builder.moveTo(0, radius);
                builder.lineTo(radius, radius);
                builder.lineTo(radius, 0);
                builder.arcTo(radius, radius, 0, radius);
            },
            .BOTTOM_LEFT => {
                builder.moveTo(radius, radius);
                builder.lineTo(0, radius);
                builder.lineTo(0, 0);
                builder.arcTo(0, radius, radius, radius);
            },
        }

        const style = gtk.Widget.getStyleContext(self.as(gtk.Widget));

        const path = builder.toPath();
        builder.close();

        var color: gdk.RGBA = undefined;

        _ = style.lookupColor("window_bg_color", &color);

        snapshot.appendFill(path, gsk.FillRule.winding, &color);

        path.unref();
    }

    fn private(self: *InvertedCorner) *Private {
        return gobject.ext.impl_helpers.getPrivate(self, Private, Private.offset);
    }
    
    pub const Class = extern struct {
        parent_class: Parent.Class,

        pub const Instance = InvertedCorner;

        pub fn as(class: *Class, comptime T: type) *T {
            return gobject.ext.as(T, class);
        }

        pub fn init(class: *Class) callconv(.c) void {
            gtk.Widget.virtual_methods.snapshot.implement(class, &snapshotImpl);
        }
    };
};
