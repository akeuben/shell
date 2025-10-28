const gtk = @import("gtk");
const gdk = @import("gdk");
const widget = @import("root.zig");
const std = @import("std");
const glib = @import("glib");
const zdt = @import("zdt");
const gobject = @import("gobject");
const hyprland = @import("hyprland");
const icon_button = @import("../components/icon_button.zig");

pub const WorkspacesParams = struct {
    class: ?[]const u8 = null,
    show_empty: bool = false,
};

const Indicator = struct {
    box: *gtk.Button,
    workspace: *hyprland.Workspace,
    id: c_ulong
};

pub const WorkspacesWidget = struct {
    root: *gtk.Box,
    base: *widget.WidgetBase,
    monitor: *hyprland.Monitor,
    indicators: ?[]Indicator,
    
    pub fn init(base: *widget.WidgetBase, self: *WorkspacesWidget, params: *const WorkspacesParams, details: widget.InitializationDetails) void {
        self.root = gtk.Box.new(details.orientation, 10);
        self.base = base;
        self.indicators = null;
        if(params.class) |class|
            self.root.f_parent_instance.addCssClass(class[0..class.len :0]);

        self.monitor = hyprland.getDefault().getMonitorByName(details.monitor.getConnector().?).?;

        updateIndicators(self);

        _ = base.connect(self, hyprland.getDefault(), hyprland.Hyprland.signals.workspace_added, &onWorkspaceAdd);
        _ = base.connect(self, hyprland.getDefault(), hyprland.Hyprland.signals.workspace_removed, &onWorkspaceRemoved);
        _ = base.connectNotify(self, self.monitor, "active-workspace", &onActiveWorkspaceChanged);
    }

    fn onWorkspaceAdd(_: *hyprland.Hyprland, _: **hyprland.Workspace, self: *WorkspacesWidget) callconv(.c) void {
        self.updateIndicators();
    }

    fn onWorkspaceRemoved(_: *hyprland.Hyprland, _: c_int, self: *WorkspacesWidget) callconv(.c) void {
        self.updateIndicators();
    }

    fn onActiveWorkspaceChanged(_: *hyprland.Monitor, _: *gobject.ParamSpec, self: *WorkspacesWidget) callconv(.c) void {
        self.updateHighlights();
    }

    fn sort(_: void, a: Indicator, b: Indicator) bool {
        return a.workspace.getId() < b.workspace.getId();
    }

    pub fn updateIndicators(self: *WorkspacesWidget) void {
        var child = self.root.f_parent_instance.getFirstChild();
        while(child != null) {
            self.root.remove(child.?);
            child = self.root.f_parent_instance.getFirstChild();
        }
        var workspaceListEntry: ?*glib.List = hyprland.getDefault().getWorkspaces();
        const length = workspaceListEntry.?.length();

        if(self.indicators) |ind| {
            for(ind) |i| {
                self.base.disconnect(i.id);
            }
            self.base.allocator.free(ind);
        }
        self.indicators = self.base.allocator.alloc(Indicator, length) catch unreachable;

        var i: usize = 0;
        while(workspaceListEntry) |entry| {
            const workspace: *hyprland.Workspace = @alignCast(@ptrCast(entry.f_data));

            workspaceListEntry = entry.f_next;
            self.indicators.?[i].workspace = workspace;
            i += 1;
        }

        std.mem.sort(Indicator, self.indicators.?, {}, comptime sort);
        for(self.indicators.?, 0..) |indicator, idx| {
            const box = gtk.Button.new();
            box.f_parent_instance.setSizeRequest(12, 12);
            box.f_parent_instance.addCssClass("hypr-workspace");
            box.f_parent_instance.setHexpand(0);
            box.f_parent_instance.setVexpand(0);
            box.f_parent_instance.setHalign(.center);
            box.f_parent_instance.setValign(.center);
            box.f_parent_instance.setCursor(icon_button.getPointer());

            if(self.monitor.getActiveWorkspace().getId() == indicator.workspace.getId()) {
                box.f_parent_instance.addCssClass("active");
            }

            gobject.Object.setData(box.as(gobject.Object), "workspace", @alignCast(@ptrCast(indicator.workspace)));

            self.indicators.?[idx].box = box;

            self.indicators.?[idx].id = self.base.connect(self, box, gtk.Button.signals.clicked, &onIndicatorClicked);

            self.root.append(box.as(gtk.Widget));
        }
    }

    fn onIndicatorClicked(btn: *gtk.Button, self: *WorkspacesWidget) callconv(.c) void {
        const workspaceRaw = gobject.Object.getData(btn.as(gobject.Object), "workspace");
        const workspace: *hyprland.Workspace = @alignCast(@ptrCast(workspaceRaw.?));

        workspace.moveTo(self.monitor);
        workspace.focus();
    }

    pub fn updateHighlights(self: *WorkspacesWidget) void {
        for(self.indicators.?) |indicator| {
            if(self.monitor.getActiveWorkspace().getId() == indicator.workspace.getId()) {
                indicator.box.f_parent_instance.addCssClass("active");
            } else {
                indicator.box.f_parent_instance.removeCssClass("active");
            }
        }
    }

    pub fn getRoot(self: *WorkspacesWidget) *gtk.Widget {
        return self.root.as(gtk.Widget);
    }

    pub fn deinit(_: *WorkspacesWidget) void {}
};

pub const HyprlandWorkspaces = widget.DefineComponent(WorkspacesWidget, WorkspacesParams, &WorkspacesWidget.init);
