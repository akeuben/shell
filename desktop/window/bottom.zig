const gtk = @import("gtk");
const gdk = @import("gdk");
const gobject = @import("gobject");
const astal = @import("astal");
const std = @import("std");
const InvertedCorner = @import("common").InvertedCorner;
const glib = @import("glib");
const apps = @import("apps");

pub const Runner = struct {
    root: *gtk.Box,
    menu: *anyopaque,
    closeCallback: *const fn(*anyopaque) void,
    entry: *gtk.SearchEntry,

    selected: ?*gtk.Widget,

    apps: *apps.Apps,
    resultContainer: *gtk.Box,

    pub fn init(allocator: *std.mem.Allocator, menu: *anyopaque, closeCallback: *const fn(*anyopaque) void, orientation: gtk.Orientation) *Runner {
        const self = allocator.create(Runner) catch unreachable;
        self.menu = menu;
        self.closeCallback = closeCallback;
        self.selected = null;

        self.apps = apps.Apps.new();
        self.apps.setExecutableMultiplier(2);
        self.apps.setNameMultiplier(2);

        self.root = gtk.Box.new(orientation, 20);
        self.root.f_parent_instance.addCssClass("runner");

        self.entry = gtk.SearchEntry.new();
        self.entry.setPlaceholderText("Search Anything");

        const controller = gtk.EventControllerKey.new();
        gtk.EventController.setPropagationPhase(controller.as(gtk.EventController), .capture);
        gtk.Widget.addController(self.entry.as(gtk.Widget), controller.as(gtk.EventController));
        _ = gtk.EventControllerKey.signals.key_released.connect(controller, *Runner, &onKeyPress, self, .{});

        _ = gtk.SearchEntry.signals.stop_search.connect(self.entry, *Runner, &onClose, self, .{});
        _ = gtk.SearchEntry.signals.search_changed.connect(self.entry, *Runner, &onSearch, self, .{});
        _ = gtk.SearchEntry.signals.next_match.connect(self.entry, *Runner, &onNext, self, .{});
        _ = gtk.SearchEntry.signals.previous_match.connect(self.entry, *Runner, &onPrev, self, .{});
        _ = gtk.SearchEntry.signals.activate.connect(self.entry, *Runner, &onActivate, self, .{});

        self.resultContainer = gtk.Box.new(orientation, 5);

        self.root.append(self.resultContainer.as(gtk.Widget));
        self.root.append(self.entry.as(gtk.Widget));

        return self;
    }
    fn onKeyPress(_: *gtk.EventControllerKey, keyval: c_uint, _: c_uint, mod: gdk.ModifierType, self: *Runner) callconv(.c) void {
        if(keyval == gdk.KEY_Down or keyval == gdk.KEY_Right or 
            (keyval == gdk.KEY_Tab and !mod.shift_mask) or
            (keyval == gdk.KEY_ISO_Left_Tab and !mod.shift_mask) or
            (keyval == gdk.KEY_KP_Tab and !mod.shift_mask)
        ) {
            gobject.signalEmitByName(self.entry.as(gobject.Object), "next-match");
        } else if(keyval == gdk.KEY_Up or keyval == gdk.KEY_Left or 
            (keyval == gdk.KEY_Tab and mod.shift_mask) or
            (keyval == gdk.KEY_ISO_Left_Tab and mod.shift_mask) or
            (keyval == gdk.KEY_KP_Tab and mod.shift_mask)
        ) {
            gobject.signalEmitByName(self.entry.as(gobject.Object), "previous-match");
        }
    }

    fn onSearch(entry: *gtk.SearchEntry, self: *Runner) callconv(.c) void {
        if(self.selected) |selected| {
            selected.removeCssClass("selected");
        }

        var child = self.resultContainer.f_parent_instance.getFirstChild();
        while(child) |c| {
            self.resultContainer.remove(c);

            child = self.resultContainer.f_parent_instance.getFirstChild();
        }

        var result: ?*glib.List = self.apps.fuzzyQuery(gtk.Editable.getText(entry.as(gtk.Editable)));

        var i: usize = 0;
        while(result) |appEntry| {
            const app: *apps.Application = @alignCast(@ptrCast(appEntry.f_data.?));

            self.resultContainer.append(self.generateResultWidget(app));

            result = appEntry.f_next;

            if(i > 4) break;
            i += 1;
        }

        self.selected = self.resultContainer.f_parent_instance.getFirstChild();
        if(self.selected) |selected| {
            selected.addCssClass("selected");
        }
    }

    fn onNext(_: *gtk.SearchEntry, self: *Runner) callconv(.c) void {
        if(self.selected) |selected| {
            selected.removeCssClass("selected");
            self.selected = selected.getNextSibling();
            if(self.selected == null) {
                self.selected = self.resultContainer.f_parent_instance.getFirstChild();
            }
        }
        if(self.selected) |selected| {
            selected.addCssClass("selected");
        }
    }

    fn onPrev(_: *gtk.SearchEntry, self: *Runner) callconv(.c) void {
        if(self.selected) |selected| {
            selected.removeCssClass("selected");
            self.selected = selected.getPrevSibling();
            if(self.selected == null) {
                self.selected = self.resultContainer.f_parent_instance.getLastChild();
            }
        }
        if(self.selected) |selected| {
            selected.addCssClass("selected");
        }
    }

    fn onActivate(_: *gtk.SearchEntry, self: *Runner) callconv(.c) void {
        if(self.selected) |selected| {
            const data = gobject.Object.getData(selected.as(gobject.Object), "application");
            const app: *apps.Application = @alignCast(@ptrCast(data.?));

            _ = app.launch();
        }

        self.closeCallback(self.menu);
    }

    fn generateResultWidget(_: *Runner, app: *apps.Application) *gtk.Widget {
        const box = gtk.Box.new(.horizontal, 20);
        box.f_parent_instance.addCssClass("runner-result");
        gobject.Object.setData(box.as(gobject.Object), "application", app);
        const icon = gtk.Image.newFromIconName(app.getIconName());
        icon.setPixelSize(64);
        box.append(icon.as(gtk.Widget));

        const details = gtk.Box.new(.vertical, 10);
        details.f_parent_instance.setHexpand(1);
        
        const name = gtk.Label.new(app.getName());
        name.setJustify(gtk.Justification.center);
        gtk.Widget.setHexpand(name.as(gtk.Widget), 1);
        details.append(name.as(gtk.Widget));

        const descriptionRaw: ?[*:0]const u8 = @ptrCast(app.getDescription());

        if(descriptionRaw) |d| {
            const description: [:0]const u8 = std.mem.span(d);
            var descriptionCut: [24:0]u8 = undefined;
            var i: usize = 0;
            for(description) |char| {
                descriptionCut[i] = char;
                i += 1;
                if(i == 20) break;
            }
            descriptionCut[i] = '.';
            descriptionCut[i+1] = '.';
            descriptionCut[i+2] = '.';
            descriptionCut[i+3] = 0;
            const desc = gtk.Label.new(@ptrCast(&descriptionCut));
            desc.setJustify(gtk.Justification.center);
            gtk.Widget.setHexpand(desc.as(gtk.Widget), 1);
            details.append(desc.as(gtk.Widget));
        }

        box.append(details.as(gtk.Widget));

        return box.as(gtk.Widget);
    }

    fn onClose(_: *gtk.SearchEntry, self: *Runner) callconv(.c) void {
        self.closeCallback(self.menu);
    }

    pub fn onOpen(self: *Runner) void {
        _ = gtk.Widget.grabFocus(self.entry.as(gtk.Widget));
    }
};

const BottomMenuCloseParamsStruct = struct {
    bottomMenu: *BottomMenu,
    app: *gtk.Application,
};

pub const BottomMenu = struct {
    window: *astal.Window,
    allocator: *std.mem.Allocator,

    runner: *Runner,

    corner_left: *InvertedCorner,
    corner_right: *InvertedCorner,
    revealer: *gtk.Revealer,

    lastApp: *gtk.Application,

    pub fn init(allocator: *std.mem.Allocator) *BottomMenu {
        const self = allocator.create(BottomMenu) catch unreachable;
        self.allocator = allocator;

        const window = astal.Window.new();
        window.setAnchor(.{.bottom = true, .top = true, .left = true, .right = true});
        window.setLayer(astal.Layer.overlay);
        window.setExclusivity(astal.Exclusivity.ignore);
        window.setKeymode(astal.Keymode.on_demand);
        window.f_parent_instance.f_parent_instance.addCssClass("transparent");

        self.corner_left = InvertedCorner.new(0, .BOTTOM_RIGHT);
        self.corner_right = InvertedCorner.new(0, .BOTTOM_LEFT);
        self.corner_left.parent_instance.f_widget.setValign(gtk.Align.end);
        self.corner_right.parent_instance.f_widget.setValign(gtk.Align.end);
        self.revealer = gtk.Revealer.new();
        self.revealer.setTransitionType(gtk.RevealerTransitionType.slide_up);
        self.revealer.setTransitionDuration(100);
        gtk.Widget.addCssClass(self.revealer.as(gtk.Widget), "menu");
        gtk.Widget.addCssClass(self.revealer.as(gtk.Widget), "bottom");

        const root = gtk.CenterBox.new();
        root.setStartWidget(self.corner_left.as(gtk.Widget));
        root.setEndWidget(self.corner_right.as(gtk.Widget));
        root.setCenterWidget(self.revealer.as(gtk.Widget));
        gtk.Widget.setValign(root.as(gtk.Widget), .end);
        gtk.Widget.setHalign(root.as(gtk.Widget), .center);
        gtk.Widget.setHexpand(root.as(gtk.Widget), 0);

        self.window = window;
        self.runner = Runner.init(self.allocator, @ptrCast(self), &closeCallback, .vertical);

        self.window.f_parent_instance.setChild(root.as(gtk.Widget));

        return self;
    }

    fn open(self: *BottomMenu, app: *gtk.Application) void {
        app.addWindow(self.window.as(gtk.Window));
        self.window.f_parent_instance.f_parent_instance.setVisible(1);

        self.corner_left.setRadiusAnimated(16, 0.1);
        self.corner_right.setRadiusAnimated(16, 0.1);
        self.revealer.setRevealChild(1);

        self.lastApp = app;
    }

    pub fn openRunner(self: *BottomMenu, app: *gtk.Application) void {
        self.revealer.setChild(self.runner.root.as(gtk.Widget));
        self.runner.onOpen();

        self.open(app);
    }

    pub fn close(self: *BottomMenu) void {
        self.revealer.setRevealChild(0);
        self.corner_left.setRadiusAnimated(0, 0.1);
        self.corner_right.setRadiusAnimated(0, 0.1);

        _ = glib.timeoutAdd(100, &closeFinalize, self);
        
    }

    fn closeCallback(selfRaw: *anyopaque) void {
        const self: *BottomMenu = @alignCast(@ptrCast(selfRaw));

        self.close();
    }

    fn closeFinalize(selfRaw: ?*anyopaque) callconv(.c) c_int {
        const self: *BottomMenu = @alignCast(@ptrCast(selfRaw.?));

        self.lastApp.removeWindow(self.window.as(gtk.Window));
        self.window.f_parent_instance.f_parent_instance.setVisible(0);

        return @intFromBool(glib.SOURCE_REMOVE);
    }
};
