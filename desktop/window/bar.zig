const std = @import("std");
const glib = @import("glib");
const gobject = @import("gobject");
const gio = @import("gio");
const gtk = @import("gtk");
const gdk = @import("gdk");
const astal = @import("astal");
const coner = @import("common");
const widget = @import("common").widget;
const gsk = @import("gsk");
const cairo = @import("cairo");
const WidgetConfig = @import("../config.zig").WidgetConfig;
const BarConfig = @import("../config.zig").BarConfig;
const widgets = @import("../widgets.zig");

const Application = @import("root").Application;

fn addBar(monitor: *gdk.Monitor, anchor: astal.WindowAnchor, allocator: *std.mem.Allocator, orientation: gtk.Orientation) *Window {
    var window = astal.Window.new();
    window.setAnchor(anchor);
    window.setExclusivity(astal.Exclusivity.exclusive);
    window.setGdkmonitor(monitor);
    window.f_parent_instance.f_parent_instance.addCssClass("bar");
    window.f_parent_instance.setDefaultSize(5, 5);
    window.setLayer(astal.Layer.top);
    window.setMarginTop(-1);
    window.setMarginLeft(-1);

    gtk.Widget.show(window.as(gtk.Widget));

    return Window.init(allocator, window, orientation, monitor) catch unreachable;
}

pub fn addLeftBar(monitor: *gdk.Monitor, allocator: *std.mem.Allocator) *Window {
    return addBar(monitor, .{.left = true, .top = true, .bottom = true}, allocator, .vertical);
}

pub fn addTopBar(monitor: *gdk.Monitor, allocator: *std.mem.Allocator) *Window {
    return addBar(monitor, .{.left = true, .top = true, .right = true}, allocator, .horizontal);
}

pub fn addBottomBar(monitor: *gdk.Monitor, allocator: *std.mem.Allocator) *Window {
    return addBar(monitor, .{.left = true, .bottom = true, .right = true}, allocator, .horizontal);
}

pub fn addRightBar(monitor: *gdk.Monitor, allocator: *std.mem.Allocator) *Window {
    return addBar(monitor, .{.right = true, .bottom = true, .top = true}, allocator, .vertical);
}

pub fn addCorners(monitor: *gdk.Monitor) *astal.Window {
    const corner1 = coner.InvertedCorner.new(35, .TOP_LEFT);
    const corner2 = coner.InvertedCorner.new(35, .TOP_RIGHT);
    const corner3 = coner.InvertedCorner.new(35, .BOTTOM_LEFT);
    const corner4 = coner.InvertedCorner.new(35, .BOTTOM_RIGHT);

    const centerTop = gtk.CenterBox.new();
    centerTop.setStartWidget(corner1.as(gtk.Widget));
    centerTop.setEndWidget(corner2.as(gtk.Widget));

    const centerBottom = gtk.CenterBox.new();
    centerBottom.setStartWidget(corner3.as(gtk.Widget));
    centerBottom.setEndWidget(corner4.as(gtk.Widget));

    const center = gtk.CenterBox.new();
    gtk.Orientable.setOrientation(center.as(gtk.Orientable), gtk.Orientation.vertical);
    center.setStartWidget(centerTop.as(gtk.Widget));
    center.setEndWidget(centerBottom.as(gtk.Widget));

    var window = astal.Window.new();
    window.setAnchor(.{.left = true, .top = true, .right = true, .bottom = true});
    window.setExclusivity(astal.Exclusivity.ignore);
    window.setGdkmonitor(monitor);
    window.f_parent_instance.f_parent_instance.addCssClass("transparent");
    window.setLayer(astal.Layer.top);
    window.setKeymode(astal.Keymode.none);

    gtk.Window.setChild(&window.f_parent_instance, center.as(gtk.Widget));

    gtk.Widget.show(window.as(gtk.Widget));

    const rect = cairo.RectangleInt{
        .x = 0,
        .y = 0,
        .width = 0,
        .height = 0,
    };
    const region = cairo.Region.createRectangle(&rect);

    window.f_parent_instance.f_parent_instance.getNative().?.getSurface().?.setInputRegion(region);

    return window;
}

pub const Window = struct {
    window: *astal.Window,
    monitor: *gdk.Monitor,
    start_widgets: []widget.Component,
    middle_widgets: []widget.Component,
    end_widgets: []widget.Component,
    allocator: *std.mem.Allocator,
    orientation: gtk.Orientation,

    pub fn init(allocator: *std.mem.Allocator, window: *astal.Window, orientation: gtk.Orientation, monitor: *gdk.Monitor) !*Window {
        const self = allocator.create(Window) catch unreachable;
        self.allocator = allocator;
        self.window = window;
        self.orientation = orientation;

        self.start_widgets = &.{};
        self.middle_widgets = &.{};
        self.end_widgets = &.{};

        self.monitor = monitor;

        return self;
    }

    fn updateSingleBarWidgets(self: *Window, config: *const BarConfig) void {
        const center = gtk.CenterBox.new();
        if(self.orientation == .horizontal) {
            gtk.Widget.setMarginStart(center.as(gtk.Widget), 5);
            gtk.Widget.setMarginEnd(center.as(gtk.Widget), 5);
        }
        if(self.orientation == .vertical) {
            gtk.Widget.setMarginTop(center.as(gtk.Widget), 5);
            gtk.Widget.setMarginBottom(center.as(gtk.Widget), 5);
        }
        gtk.Orientable.setOrientation(center.as(gtk.Orientable), self.orientation);
        
        self.cleanupWidgets();

        self.start_widgets = self.allocator.alloc(widget.Component, config.start.len) catch unreachable;
        self.middle_widgets = self.allocator.alloc(widget.Component, config.middle.len) catch unreachable;
        self.end_widgets = self.allocator.alloc(widget.Component, config.end.len) catch unreachable;

        if(config.start.len + config.middle.len + config.end.len > 0) {
            self.window.f_parent_instance.f_parent_instance.addCssClass("contentful");
        } else {
            self.window.f_parent_instance.f_parent_instance.removeCssClass("contentful");
        }

        const startBox = gtk.Box.new(self.orientation, config.spacing);
        const middleBox = gtk.Box.new(self.orientation, config.spacing);
        const endBox = gtk.Box.new(self.orientation, config.spacing);

        const details: widget.InitializationDetails = .{ 
            .monitor = self.monitor, 
            .orientation = self.orientation, 
            .spacing = config.spacing,
            .requestHandler = &handleRequest,
        };
        
        for(config.start, 0..) |wconfig, i| {
            const w = widgets.mapWidgetConfigToWidget(self.allocator, wconfig, details) catch {
                @panic("Failed to create widget");
            };
            self.start_widgets[i] = w;

            startBox.append(w.getBase(w.ptr).root);
        }

        for(config.middle, 0..) |wconfig, i| {
            const w = widgets.mapWidgetConfigToWidget(self.allocator, wconfig, details) catch {
                @panic("Failed to create widget");
            };
            self.middle_widgets[i] = w;

            middleBox.append(w.getBase(w.ptr).root);
        }

        for(config.end, 0..) |wconfig, i| {
            const w = widgets.mapWidgetConfigToWidget(self.allocator, wconfig, details) catch {
                @panic("Failed to create widget");
            };
            self.end_widgets[i] = w;

            endBox.append(w.getBase(w.ptr).root);
        }

        center.setStartWidget(startBox.as(gtk.Widget));
        center.setCenterWidget(middleBox.as(gtk.Widget));
        center.setEndWidget(endBox.as(gtk.Widget));

        self.window.f_parent_instance.setChild(center.as(gtk.Widget));
    }

    fn handleRequest(request: [:0]const u8) void {
        if(Application.instance) |app| {
            app.handleRequest(request);
        }
    }

    fn cleanupWidgets(self: *Window) void {
        for(self.start_widgets) |w| {
            w.deinit(w.ptr);
        }
        for(self.middle_widgets) |w| {
            w.deinit(w.ptr);
        }
        for(self.end_widgets) |w| {
            w.deinit(w.ptr);
        }
        
        self.allocator.free(self.start_widgets);
        self.allocator.free(self.middle_widgets);
        self.allocator.free(self.end_widgets);
    }

    pub fn deinit(self: *Window) void {
        self.allocator.destroy(self);
        self.window.f_parent_instance.destroy();
    }
};

pub const MonitorWindows = struct {
    topWindow: *Window,
    bottomWindow: *Window,
    leftWindow: *Window,
    rightWindow: *Window,

    corners: *astal.Window,

    allocator: std.mem.Allocator,
    app: *gtk.Application,
    monitor: *gdk.Monitor,

    signals: [8]c_ulong,

    context: *anyopaque,
    callback: *const fn (*anyopaque, top: c_int, left: c_int, right: c_int, bottom: c_int) void,
    

    pub fn init(app: *gtk.Application, monitor: *gdk.Monitor, allocator: *std.mem.Allocator, initialConfig: *const WidgetConfig, context: *anyopaque, resizeCallback: *const fn (*anyopaque, top: c_int, left: c_int, right: c_int, bottom: c_int) void) !*MonitorWindows {
        const self = try allocator.create(MonitorWindows);
        self.app = app;
        self.monitor = monitor;

        if(initialConfig.prioritize == .left_right) {
            self.leftWindow = addLeftBar(monitor, allocator);
            self.rightWindow = addRightBar(monitor, allocator);
            self.topWindow = addTopBar(monitor, allocator);
            self.bottomWindow = addBottomBar(monitor, allocator);
        } else {
            self.topWindow = addTopBar(monitor, allocator);
            self.bottomWindow = addBottomBar(monitor, allocator);
            self.leftWindow = addLeftBar(monitor, allocator);
            self.rightWindow = addRightBar(monitor, allocator);
        }

        self.corners = addCorners(monitor);

        self.context = context;
        self.callback = resizeCallback;

        self.addResizeHandler(0, self.topWindow.window);
        self.addResizeHandler(1, self.bottomWindow.window);
        self.addResizeHandler(2, self.leftWindow.window);
        self.addResizeHandler(3, self.rightWindow.window);

        app.addWindow(self.leftWindow.window.as(gtk.Window));
        app.addWindow(self.rightWindow.window.as(gtk.Window));
        app.addWindow(self.topWindow.window.as(gtk.Window));
        app.addWindow(self.bottomWindow.window.as(gtk.Window));
        app.addWindow(self.corners.as(gtk.Window));

        return self;
    }

    fn addResizeHandler(self: *MonitorWindows, i: usize, window: *astal.Window) void {

        const native = window.f_parent_instance.f_parent_instance.getNative().?;
        const surface = native.getSurface().?;
        self.signals[i] = gdk.Surface.signals.layout.connect(surface, *MonitorWindows, &onResize, self, .{});
    }

    fn removeResizeHandler(self: *MonitorWindows, i: usize, window: *astal.Window) void {
        const native = window.f_parent_instance.f_parent_instance.getNative().?;
        const surface = native.getSurface().?;
        gobject.signalHandlerDisconnect(surface.as(gobject.Object), self.signals[i]);
    }

    fn onResize(_: *gdk.Surface, _: c_int, _: c_int, self: *MonitorWindows) callconv(.c) void {
        _ = updateMargins(self);
    }

    pub fn updateBarWidgets(self: *MonitorWindows, config: *const WidgetConfig) void {
        self.topWindow.updateSingleBarWidgets(&config.top);
        self.bottomWindow.updateSingleBarWidgets(&config.bottom);
        self.leftWindow.updateSingleBarWidgets(&config.left);
        self.rightWindow.updateSingleBarWidgets(&config.right);
    }

    fn updateMargins(self: *MonitorWindows) callconv(.c) void {
        const topMargin = self.topWindow.window.f_parent_instance.f_parent_instance.getSize(gtk.Orientation.vertical);
        const bottomMargin = self.bottomWindow.window.f_parent_instance.f_parent_instance.getSize(gtk.Orientation.vertical);
        const leftMargin = self.leftWindow.window.f_parent_instance.f_parent_instance.getSize(gtk.Orientation.horizontal);
        const rightMargin = self.rightWindow.window.f_parent_instance.f_parent_instance.getSize(gtk.Orientation.horizontal);

        self.corners.setMarginLeft(leftMargin - 2);
        self.corners.setMarginRight(rightMargin);
        self.corners.setMarginTop(topMargin - 2);
        self.corners.setMarginBottom(bottomMargin);

        self.callback(self.context, topMargin, leftMargin, rightMargin, bottomMargin);
    }

    pub fn deinit(self: *MonitorWindows) void {
        self.bottomWindow.cleanupWidgets();
        self.topWindow.cleanupWidgets();
        self.leftWindow.cleanupWidgets();
        self.rightWindow.cleanupWidgets();

        self.app.removeWindow(self.bottomWindow.window.as(gtk.Window));
        self.app.removeWindow(self.topWindow.window.as(gtk.Window));
        self.app.removeWindow(self.leftWindow.window.as(gtk.Window));
        self.app.removeWindow(self.rightWindow.window.as(gtk.Window));
        std.log.debug("Removed windows from app", .{});

        self.bottomWindow.deinit();
        self.topWindow.deinit();
        self.leftWindow.deinit();
        self.rightWindow.deinit();
    }
};
