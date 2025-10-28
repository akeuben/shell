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
