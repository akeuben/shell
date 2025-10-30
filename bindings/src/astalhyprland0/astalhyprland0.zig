pub const ext = @import("ext.zig");
const astalhyprland = @This();

const std = @import("std");
const compat = @import("compat");
const glib = @import("glib2");
const gio = @import("gio2");
const gobject = @import("gobject2");
const gmodule = @import("gmodule2");
pub const Client = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalhyprland.ClientClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalhyprland.ClientPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const address = struct {
            pub const name = "address";

            pub const Type = ?[*:0]u8;
        };

        pub const mapped = struct {
            pub const name = "mapped";

            pub const Type = c_int;
        };

        pub const hidden = struct {
            pub const name = "hidden";

            pub const Type = c_int;
        };

        pub const x = struct {
            pub const name = "x";

            pub const Type = c_int;
        };

        pub const y = struct {
            pub const name = "y";

            pub const Type = c_int;
        };

        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };

        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        pub const workspace = struct {
            pub const name = "workspace";

            pub const Type = ?**astalhyprland.Workspace;
        };

        pub const floating = struct {
            pub const name = "floating";

            pub const Type = c_int;
        };

        pub const monitor = struct {
            pub const name = "monitor";

            pub const Type = ?**astalhyprland.Monitor;
        };

        pub const class = struct {
            pub const name = "class";

            pub const Type = ?[*:0]u8;
        };

        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        pub const initial_class = struct {
            pub const name = "initial-class";

            pub const Type = ?[*:0]u8;
        };

        pub const initial_title = struct {
            pub const name = "initial-title";

            pub const Type = ?[*:0]u8;
        };

        pub const pid = struct {
            pub const name = "pid";

            pub const Type = c_uint;
        };

        pub const xwayland = struct {
            pub const name = "xwayland";

            pub const Type = c_int;
        };

        pub const pinned = struct {
            pub const name = "pinned";

            pub const Type = c_int;
        };

        pub const fullscreen = struct {
            pub const name = "fullscreen";

            pub const Type = astalhyprland.Fullscreen;
        };

        pub const fullscreen_client = struct {
            pub const name = "fullscreen-client";

            pub const Type = astalhyprland.Fullscreen;
        };

        pub const swallowing = struct {
            pub const name = "swallowing";

            pub const Type = ?[*:0]u8;
        };

        pub const focus_history_id = struct {
            pub const name = "focus-history-id";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        pub const removed = struct {
            pub const name = "removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Client, p_instance))),
                    gobject.signalLookup("removed", Client.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const moved_to = struct {
            pub const name = "moved-to";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_workspace: **astalhyprland.Workspace, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Client, p_instance))),
                    gobject.signalLookup("moved-to", Client.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_hyprland_client_new() *astalhyprland.Client;
    pub const new = astal_hyprland_client_new;

    extern fn astal_hyprland_client_kill(p_self: *Client) void;
    pub const kill = astal_hyprland_client_kill;

    extern fn astal_hyprland_client_focus(p_self: *Client) void;
    pub const focus = astal_hyprland_client_focus;

    extern fn astal_hyprland_client_move_to(p_self: *Client, p_ws: *astalhyprland.Workspace) void;
    pub const moveTo = astal_hyprland_client_move_to;

    extern fn astal_hyprland_client_toggle_floating(p_self: *Client) void;
    pub const toggleFloating = astal_hyprland_client_toggle_floating;

    extern fn astal_hyprland_client_get_address(p_self: *Client) [*:0]const u8;
    pub const getAddress = astal_hyprland_client_get_address;

    extern fn astal_hyprland_client_get_mapped(p_self: *Client) c_int;
    pub const getMapped = astal_hyprland_client_get_mapped;

    extern fn astal_hyprland_client_get_hidden(p_self: *Client) c_int;
    pub const getHidden = astal_hyprland_client_get_hidden;

    extern fn astal_hyprland_client_get_x(p_self: *Client) c_int;
    pub const getX = astal_hyprland_client_get_x;

    extern fn astal_hyprland_client_get_y(p_self: *Client) c_int;
    pub const getY = astal_hyprland_client_get_y;

    extern fn astal_hyprland_client_get_width(p_self: *Client) c_int;
    pub const getWidth = astal_hyprland_client_get_width;

    extern fn astal_hyprland_client_get_height(p_self: *Client) c_int;
    pub const getHeight = astal_hyprland_client_get_height;

    extern fn astal_hyprland_client_get_workspace(p_self: *Client) *astalhyprland.Workspace;
    pub const getWorkspace = astal_hyprland_client_get_workspace;

    extern fn astal_hyprland_client_get_floating(p_self: *Client) c_int;
    pub const getFloating = astal_hyprland_client_get_floating;

    extern fn astal_hyprland_client_get_monitor(p_self: *Client) *astalhyprland.Monitor;
    pub const getMonitor = astal_hyprland_client_get_monitor;

    extern fn astal_hyprland_client_get_class(p_self: *Client) [*:0]const u8;
    pub const getClass = astal_hyprland_client_get_class;

    extern fn astal_hyprland_client_get_title(p_self: *Client) [*:0]const u8;
    pub const getTitle = astal_hyprland_client_get_title;

    extern fn astal_hyprland_client_get_initial_class(p_self: *Client) [*:0]const u8;
    pub const getInitialClass = astal_hyprland_client_get_initial_class;

    extern fn astal_hyprland_client_get_initial_title(p_self: *Client) [*:0]const u8;
    pub const getInitialTitle = astal_hyprland_client_get_initial_title;

    extern fn astal_hyprland_client_get_pid(p_self: *Client) c_uint;
    pub const getPid = astal_hyprland_client_get_pid;

    extern fn astal_hyprland_client_get_xwayland(p_self: *Client) c_int;
    pub const getXwayland = astal_hyprland_client_get_xwayland;

    extern fn astal_hyprland_client_get_pinned(p_self: *Client) c_int;
    pub const getPinned = astal_hyprland_client_get_pinned;

    extern fn astal_hyprland_client_get_fullscreen(p_self: *Client) astalhyprland.Fullscreen;
    pub const getFullscreen = astal_hyprland_client_get_fullscreen;

    extern fn astal_hyprland_client_get_fullscreen_client(p_self: *Client) astalhyprland.Fullscreen;
    pub const getFullscreenClient = astal_hyprland_client_get_fullscreen_client;

    extern fn astal_hyprland_client_get_swallowing(p_self: *Client) [*:0]const u8;
    pub const getSwallowing = astal_hyprland_client_get_swallowing;

    extern fn astal_hyprland_client_get_focus_history_id(p_self: *Client) c_int;
    pub const getFocusHistoryId = astal_hyprland_client_get_focus_history_id;

    extern fn astal_hyprland_client_get_type() usize;
    pub const getGObjectType = astal_hyprland_client_get_type;

    extern fn g_object_ref(p_self: *astalhyprland.Client) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalhyprland.Client) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Client, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Hyprland = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalhyprland.HyprlandClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalhyprland.HyprlandPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const monitors = struct {
            pub const name = "monitors";

            pub const Type = ?**glib.List;
        };

        pub const workspaces = struct {
            pub const name = "workspaces";

            pub const Type = ?**glib.List;
        };

        pub const clients = struct {
            pub const name = "clients";

            pub const Type = ?**glib.List;
        };

        pub const focused_workspace = struct {
            pub const name = "focused-workspace";

            pub const Type = ?**astalhyprland.Workspace;
        };

        pub const focused_monitor = struct {
            pub const name = "focused-monitor";

            pub const Type = ?**astalhyprland.Monitor;
        };

        pub const focused_client = struct {
            pub const name = "focused-client";

            pub const Type = ?**astalhyprland.Client;
        };

        pub const binds = struct {
            pub const name = "binds";

            pub const Type = ?**glib.List;
        };

        pub const cursor_position = struct {
            pub const name = "cursor-position";

            pub const Type = ?**astalhyprland.Position;
        };
    };

    pub const signals = struct {
        pub const event = struct {
            pub const name = "event";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_event: [*:0]const u8, p_args: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("event", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const minimize = struct {
            pub const name = "minimize";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_client: **astalhyprland.Client, p_minimize: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("minimize", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const floating = struct {
            pub const name = "floating";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_client: **astalhyprland.Client, p_floating: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("floating", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const urgent = struct {
            pub const name = "urgent";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_client: **astalhyprland.Client, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("urgent", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const client_moved = struct {
            pub const name = "client-moved";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_client: **astalhyprland.Client, p_ws: **astalhyprland.Workspace, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("client-moved", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const submap = struct {
            pub const name = "submap";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_name: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("submap", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const keyboard_layout = struct {
            pub const name = "keyboard-layout";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_keyboard: [*:0]const u8, p_layout: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("keyboard-layout", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const config_reloaded = struct {
            pub const name = "config-reloaded";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("config-reloaded", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const client_added = struct {
            pub const name = "client-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_client: **astalhyprland.Client, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("client-added", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const client_removed = struct {
            pub const name = "client-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_address: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("client-removed", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const workspace_added = struct {
            pub const name = "workspace-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_workspace: **astalhyprland.Workspace, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("workspace-added", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const workspace_removed = struct {
            pub const name = "workspace-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_id: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("workspace-removed", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const monitor_added = struct {
            pub const name = "monitor-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_monitor: **astalhyprland.Monitor, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("monitor-added", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const monitor_removed = struct {
            pub const name = "monitor-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_id: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyprland, p_instance))),
                    gobject.signalLookup("monitor-removed", Hyprland.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_hyprland_hyprland_get_default() ?*astalhyprland.Hyprland;
    pub const getDefault = astal_hyprland_hyprland_get_default;

    extern fn astal_hyprland_hyprland_new() *astalhyprland.Hyprland;
    pub const new = astal_hyprland_hyprland_new;

    extern fn astal_hyprland_hyprland_get_monitor(p_self: *Hyprland, p_id: c_int) *astalhyprland.Monitor;
    pub const getMonitor = astal_hyprland_hyprland_get_monitor;

    extern fn astal_hyprland_hyprland_get_workspace(p_self: *Hyprland, p_id: c_int) *astalhyprland.Workspace;
    pub const getWorkspace = astal_hyprland_hyprland_get_workspace;

    extern fn astal_hyprland_hyprland_get_client(p_self: *Hyprland, p_address: [*:0]const u8) ?*astalhyprland.Client;
    pub const getClient = astal_hyprland_hyprland_get_client;

    extern fn astal_hyprland_hyprland_get_monitor_by_name(p_self: *Hyprland, p_name: [*:0]const u8) ?*astalhyprland.Monitor;
    pub const getMonitorByName = astal_hyprland_hyprland_get_monitor_by_name;

    extern fn astal_hyprland_hyprland_get_workspace_by_name(p_self: *Hyprland, p_name: [*:0]const u8) ?*astalhyprland.Workspace;
    pub const getWorkspaceByName = astal_hyprland_hyprland_get_workspace_by_name;

    extern fn astal_hyprland_hyprland_message(p_self: *Hyprland, p_message: [*:0]const u8) [*:0]u8;
    pub const message = astal_hyprland_hyprland_message;

    extern fn astal_hyprland_hyprland_message_async(p_self: *Hyprland, p_message: [*:0]const u8, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const messageAsync = astal_hyprland_hyprland_message_async;

    extern fn astal_hyprland_hyprland_message_finish(p_self: *Hyprland, p__res_: *gio.AsyncResult) [*:0]u8;
    pub const messageFinish = astal_hyprland_hyprland_message_finish;

    extern fn astal_hyprland_hyprland_dispatch(p_self: *Hyprland, p_dispatcher: [*:0]const u8, p_args: [*:0]const u8) void;
    pub const dispatch = astal_hyprland_hyprland_dispatch;

    extern fn astal_hyprland_hyprland_move_cursor(p_self: *Hyprland, p_x: c_int, p_y: c_int) void;
    pub const moveCursor = astal_hyprland_hyprland_move_cursor;

    extern fn astal_hyprland_hyprland_sync_monitors(p_self: *Hyprland, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const syncMonitors = astal_hyprland_hyprland_sync_monitors;

    extern fn astal_hyprland_hyprland_sync_monitors_finish(p_self: *Hyprland, p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
    pub const syncMonitorsFinish = astal_hyprland_hyprland_sync_monitors_finish;

    extern fn astal_hyprland_hyprland_sync_workspaces(p_self: *Hyprland, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const syncWorkspaces = astal_hyprland_hyprland_sync_workspaces;

    extern fn astal_hyprland_hyprland_sync_workspaces_finish(p_self: *Hyprland, p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
    pub const syncWorkspacesFinish = astal_hyprland_hyprland_sync_workspaces_finish;

    extern fn astal_hyprland_hyprland_sync_clients(p_self: *Hyprland, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const syncClients = astal_hyprland_hyprland_sync_clients;

    extern fn astal_hyprland_hyprland_sync_clients_finish(p_self: *Hyprland, p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
    pub const syncClientsFinish = astal_hyprland_hyprland_sync_clients_finish;

    extern fn astal_hyprland_hyprland_get_monitors(p_self: *Hyprland) *glib.List;
    pub const getMonitors = astal_hyprland_hyprland_get_monitors;

    extern fn astal_hyprland_hyprland_get_workspaces(p_self: *Hyprland) *glib.List;
    pub const getWorkspaces = astal_hyprland_hyprland_get_workspaces;

    extern fn astal_hyprland_hyprland_get_clients(p_self: *Hyprland) *glib.List;
    pub const getClients = astal_hyprland_hyprland_get_clients;

    extern fn astal_hyprland_hyprland_get_focused_workspace(p_self: *Hyprland) *astalhyprland.Workspace;
    pub const getFocusedWorkspace = astal_hyprland_hyprland_get_focused_workspace;

    extern fn astal_hyprland_hyprland_get_focused_monitor(p_self: *Hyprland) *astalhyprland.Monitor;
    pub const getFocusedMonitor = astal_hyprland_hyprland_get_focused_monitor;

    extern fn astal_hyprland_hyprland_get_focused_client(p_self: *Hyprland) *astalhyprland.Client;
    pub const getFocusedClient = astal_hyprland_hyprland_get_focused_client;

    extern fn astal_hyprland_hyprland_get_binds(p_self: *Hyprland) *glib.List;
    pub const getBinds = astal_hyprland_hyprland_get_binds;

    extern fn astal_hyprland_hyprland_get_cursor_position(p_self: *Hyprland) *astalhyprland.Position;
    pub const getCursorPosition = astal_hyprland_hyprland_get_cursor_position;

    extern fn astal_hyprland_hyprland_get_type() usize;
    pub const getGObjectType = astal_hyprland_hyprland_get_type;

    extern fn g_object_ref(p_self: *astalhyprland.Hyprland) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalhyprland.Hyprland) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Hyprland, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Monitor = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalhyprland.MonitorClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalhyprland.MonitorPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_int;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        pub const make = struct {
            pub const name = "make";

            pub const Type = ?[*:0]u8;
        };

        pub const model = struct {
            pub const name = "model";

            pub const Type = ?[*:0]u8;
        };

        pub const serial = struct {
            pub const name = "serial";

            pub const Type = ?[*:0]u8;
        };

        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };

        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        pub const refresh_rate = struct {
            pub const name = "refresh-rate";

            pub const Type = f64;
        };

        pub const x = struct {
            pub const name = "x";

            pub const Type = c_int;
        };

        pub const y = struct {
            pub const name = "y";

            pub const Type = c_int;
        };

        pub const active_workspace = struct {
            pub const name = "active-workspace";

            pub const Type = ?**astalhyprland.Workspace;
        };

        pub const special_workspace = struct {
            pub const name = "special-workspace";

            pub const Type = ?**astalhyprland.Workspace;
        };

        pub const reserved_top = struct {
            pub const name = "reserved-top";

            pub const Type = c_int;
        };

        pub const reserved_bottom = struct {
            pub const name = "reserved-bottom";

            pub const Type = c_int;
        };

        pub const reserved_left = struct {
            pub const name = "reserved-left";

            pub const Type = c_int;
        };

        pub const reserved_right = struct {
            pub const name = "reserved-right";

            pub const Type = c_int;
        };

        pub const scale = struct {
            pub const name = "scale";

            pub const Type = f64;
        };

        pub const transform = struct {
            pub const name = "transform";

            pub const Type = astalhyprland.MonitorTransform;
        };

        pub const focused = struct {
            pub const name = "focused";

            pub const Type = c_int;
        };

        pub const dpms_status = struct {
            pub const name = "dpms-status";

            pub const Type = c_int;
        };

        pub const vrr = struct {
            pub const name = "vrr";

            pub const Type = c_int;
        };

        pub const actively_tearing = struct {
            pub const name = "actively-tearing";

            pub const Type = c_int;
        };

        pub const disabled = struct {
            pub const name = "disabled";

            pub const Type = c_int;
        };

        pub const current_format = struct {
            pub const name = "current-format";

            pub const Type = ?[*:0]u8;
        };

        pub const available_modes = struct {
            pub const name = "available-modes";

            pub const Type = ?**glib.Array;
        };
    };

    pub const signals = struct {
        pub const removed = struct {
            pub const name = "removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Monitor, p_instance))),
                    gobject.signalLookup("removed", Monitor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_hyprland_monitor_new() *astalhyprland.Monitor;
    pub const new = astal_hyprland_monitor_new;

    extern fn astal_hyprland_monitor_focus(p_self: *Monitor) void;
    pub const focus = astal_hyprland_monitor_focus;

    extern fn astal_hyprland_monitor_get_id(p_self: *Monitor) c_int;
    pub const getId = astal_hyprland_monitor_get_id;

    extern fn astal_hyprland_monitor_get_name(p_self: *Monitor) [*:0]const u8;
    pub const getName = astal_hyprland_monitor_get_name;

    extern fn astal_hyprland_monitor_get_description(p_self: *Monitor) [*:0]const u8;
    pub const getDescription = astal_hyprland_monitor_get_description;

    extern fn astal_hyprland_monitor_get_make(p_self: *Monitor) [*:0]const u8;
    pub const getMake = astal_hyprland_monitor_get_make;

    extern fn astal_hyprland_monitor_get_model(p_self: *Monitor) [*:0]const u8;
    pub const getModel = astal_hyprland_monitor_get_model;

    extern fn astal_hyprland_monitor_get_serial(p_self: *Monitor) [*:0]const u8;
    pub const getSerial = astal_hyprland_monitor_get_serial;

    extern fn astal_hyprland_monitor_get_width(p_self: *Monitor) c_int;
    pub const getWidth = astal_hyprland_monitor_get_width;

    extern fn astal_hyprland_monitor_get_height(p_self: *Monitor) c_int;
    pub const getHeight = astal_hyprland_monitor_get_height;

    extern fn astal_hyprland_monitor_get_refresh_rate(p_self: *Monitor) f64;
    pub const getRefreshRate = astal_hyprland_monitor_get_refresh_rate;

    extern fn astal_hyprland_monitor_get_x(p_self: *Monitor) c_int;
    pub const getX = astal_hyprland_monitor_get_x;

    extern fn astal_hyprland_monitor_get_y(p_self: *Monitor) c_int;
    pub const getY = astal_hyprland_monitor_get_y;

    extern fn astal_hyprland_monitor_get_active_workspace(p_self: *Monitor) *astalhyprland.Workspace;
    pub const getActiveWorkspace = astal_hyprland_monitor_get_active_workspace;

    extern fn astal_hyprland_monitor_get_special_workspace(p_self: *Monitor) *astalhyprland.Workspace;
    pub const getSpecialWorkspace = astal_hyprland_monitor_get_special_workspace;

    extern fn astal_hyprland_monitor_get_reserved_top(p_self: *Monitor) c_int;
    pub const getReservedTop = astal_hyprland_monitor_get_reserved_top;

    extern fn astal_hyprland_monitor_get_reserved_bottom(p_self: *Monitor) c_int;
    pub const getReservedBottom = astal_hyprland_monitor_get_reserved_bottom;

    extern fn astal_hyprland_monitor_get_reserved_left(p_self: *Monitor) c_int;
    pub const getReservedLeft = astal_hyprland_monitor_get_reserved_left;

    extern fn astal_hyprland_monitor_get_reserved_right(p_self: *Monitor) c_int;
    pub const getReservedRight = astal_hyprland_monitor_get_reserved_right;

    extern fn astal_hyprland_monitor_get_scale(p_self: *Monitor) f64;
    pub const getScale = astal_hyprland_monitor_get_scale;

    extern fn astal_hyprland_monitor_get_transform(p_self: *Monitor) astalhyprland.MonitorTransform;
    pub const getTransform = astal_hyprland_monitor_get_transform;

    extern fn astal_hyprland_monitor_get_focused(p_self: *Monitor) c_int;
    pub const getFocused = astal_hyprland_monitor_get_focused;

    extern fn astal_hyprland_monitor_get_dpms_status(p_self: *Monitor) c_int;
    pub const getDpmsStatus = astal_hyprland_monitor_get_dpms_status;

    extern fn astal_hyprland_monitor_get_vrr(p_self: *Monitor) c_int;
    pub const getVrr = astal_hyprland_monitor_get_vrr;

    extern fn astal_hyprland_monitor_get_actively_tearing(p_self: *Monitor) c_int;
    pub const getActivelyTearing = astal_hyprland_monitor_get_actively_tearing;

    extern fn astal_hyprland_monitor_get_disabled(p_self: *Monitor) c_int;
    pub const getDisabled = astal_hyprland_monitor_get_disabled;

    extern fn astal_hyprland_monitor_get_current_format(p_self: *Monitor) [*:0]const u8;
    pub const getCurrentFormat = astal_hyprland_monitor_get_current_format;

    extern fn astal_hyprland_monitor_get_available_modes(p_self: *Monitor) *glib.Array;
    pub const getAvailableModes = astal_hyprland_monitor_get_available_modes;

    extern fn astal_hyprland_monitor_get_type() usize;
    pub const getGObjectType = astal_hyprland_monitor_get_type;

    extern fn g_object_ref(p_self: *astalhyprland.Monitor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalhyprland.Monitor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Monitor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Bind = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalhyprland.BindClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalhyprland.BindPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const locked = struct {
            pub const name = "locked";

            pub const Type = c_int;
        };

        pub const mouse = struct {
            pub const name = "mouse";

            pub const Type = c_int;
        };

        pub const release = struct {
            pub const name = "release";

            pub const Type = c_int;
        };

        pub const repeat = struct {
            pub const name = "repeat";

            pub const Type = c_int;
        };

        pub const long_press = struct {
            pub const name = "long-press";

            pub const Type = c_int;
        };

        pub const non_consuming = struct {
            pub const name = "non-consuming";

            pub const Type = c_int;
        };

        pub const has_description = struct {
            pub const name = "has-description";

            pub const Type = c_int;
        };

        pub const modmask = struct {
            pub const name = "modmask";

            pub const Type = i64;
        };

        pub const submap = struct {
            pub const name = "submap";

            pub const Type = ?[*:0]u8;
        };

        pub const key = struct {
            pub const name = "key";

            pub const Type = ?[*:0]u8;
        };

        pub const keycode = struct {
            pub const name = "keycode";

            pub const Type = i64;
        };

        pub const catch_all = struct {
            pub const name = "catch-all";

            pub const Type = c_int;
        };

        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        pub const dispatcher = struct {
            pub const name = "dispatcher";

            pub const Type = ?[*:0]u8;
        };

        pub const arg = struct {
            pub const name = "arg";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_hyprland_bind_new() *astalhyprland.Bind;
    pub const new = astal_hyprland_bind_new;

    extern fn astal_hyprland_bind_get_locked(p_self: *Bind) c_int;
    pub const getLocked = astal_hyprland_bind_get_locked;

    extern fn astal_hyprland_bind_set_locked(p_self: *Bind, p_value: c_int) void;
    pub const setLocked = astal_hyprland_bind_set_locked;

    extern fn astal_hyprland_bind_get_mouse(p_self: *Bind) c_int;
    pub const getMouse = astal_hyprland_bind_get_mouse;

    extern fn astal_hyprland_bind_set_mouse(p_self: *Bind, p_value: c_int) void;
    pub const setMouse = astal_hyprland_bind_set_mouse;

    extern fn astal_hyprland_bind_get_release(p_self: *Bind) c_int;
    pub const getRelease = astal_hyprland_bind_get_release;

    extern fn astal_hyprland_bind_set_release(p_self: *Bind, p_value: c_int) void;
    pub const setRelease = astal_hyprland_bind_set_release;

    extern fn astal_hyprland_bind_get_repeat(p_self: *Bind) c_int;
    pub const getRepeat = astal_hyprland_bind_get_repeat;

    extern fn astal_hyprland_bind_set_repeat(p_self: *Bind, p_value: c_int) void;
    pub const setRepeat = astal_hyprland_bind_set_repeat;

    extern fn astal_hyprland_bind_get_long_press(p_self: *Bind) c_int;
    pub const getLongPress = astal_hyprland_bind_get_long_press;

    extern fn astal_hyprland_bind_set_long_press(p_self: *Bind, p_value: c_int) void;
    pub const setLongPress = astal_hyprland_bind_set_long_press;

    extern fn astal_hyprland_bind_get_non_consuming(p_self: *Bind) c_int;
    pub const getNonConsuming = astal_hyprland_bind_get_non_consuming;

    extern fn astal_hyprland_bind_set_non_consuming(p_self: *Bind, p_value: c_int) void;
    pub const setNonConsuming = astal_hyprland_bind_set_non_consuming;

    extern fn astal_hyprland_bind_get_has_description(p_self: *Bind) c_int;
    pub const getHasDescription = astal_hyprland_bind_get_has_description;

    extern fn astal_hyprland_bind_set_has_description(p_self: *Bind, p_value: c_int) void;
    pub const setHasDescription = astal_hyprland_bind_set_has_description;

    extern fn astal_hyprland_bind_get_modmask(p_self: *Bind) i64;
    pub const getModmask = astal_hyprland_bind_get_modmask;

    extern fn astal_hyprland_bind_set_modmask(p_self: *Bind, p_value: i64) void;
    pub const setModmask = astal_hyprland_bind_set_modmask;

    extern fn astal_hyprland_bind_get_submap(p_self: *Bind) [*:0]const u8;
    pub const getSubmap = astal_hyprland_bind_get_submap;

    extern fn astal_hyprland_bind_set_submap(p_self: *Bind, p_value: [*:0]const u8) void;
    pub const setSubmap = astal_hyprland_bind_set_submap;

    extern fn astal_hyprland_bind_get_key(p_self: *Bind) [*:0]const u8;
    pub const getKey = astal_hyprland_bind_get_key;

    extern fn astal_hyprland_bind_set_key(p_self: *Bind, p_value: [*:0]const u8) void;
    pub const setKey = astal_hyprland_bind_set_key;

    extern fn astal_hyprland_bind_get_keycode(p_self: *Bind) i64;
    pub const getKeycode = astal_hyprland_bind_get_keycode;

    extern fn astal_hyprland_bind_set_keycode(p_self: *Bind, p_value: i64) void;
    pub const setKeycode = astal_hyprland_bind_set_keycode;

    extern fn astal_hyprland_bind_get_catch_all(p_self: *Bind) c_int;
    pub const getCatchAll = astal_hyprland_bind_get_catch_all;

    extern fn astal_hyprland_bind_set_catch_all(p_self: *Bind, p_value: c_int) void;
    pub const setCatchAll = astal_hyprland_bind_set_catch_all;

    extern fn astal_hyprland_bind_get_description(p_self: *Bind) [*:0]const u8;
    pub const getDescription = astal_hyprland_bind_get_description;

    extern fn astal_hyprland_bind_set_description(p_self: *Bind, p_value: [*:0]const u8) void;
    pub const setDescription = astal_hyprland_bind_set_description;

    extern fn astal_hyprland_bind_get_dispatcher(p_self: *Bind) [*:0]const u8;
    pub const getDispatcher = astal_hyprland_bind_get_dispatcher;

    extern fn astal_hyprland_bind_set_dispatcher(p_self: *Bind, p_value: [*:0]const u8) void;
    pub const setDispatcher = astal_hyprland_bind_set_dispatcher;

    extern fn astal_hyprland_bind_get_arg(p_self: *Bind) [*:0]const u8;
    pub const getArg = astal_hyprland_bind_get_arg;

    extern fn astal_hyprland_bind_set_arg(p_self: *Bind, p_value: [*:0]const u8) void;
    pub const setArg = astal_hyprland_bind_set_arg;

    extern fn astal_hyprland_bind_get_type() usize;
    pub const getGObjectType = astal_hyprland_bind_get_type;

    extern fn g_object_ref(p_self: *astalhyprland.Bind) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalhyprland.Bind) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Bind, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Position = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalhyprland.PositionClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalhyprland.PositionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const x = struct {
            pub const name = "x";

            pub const Type = c_int;
        };

        pub const y = struct {
            pub const name = "y";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn astal_hyprland_position_new() *astalhyprland.Position;
    pub const new = astal_hyprland_position_new;

    extern fn astal_hyprland_position_get_x(p_self: *Position) c_int;
    pub const getX = astal_hyprland_position_get_x;

    extern fn astal_hyprland_position_set_x(p_self: *Position, p_value: c_int) void;
    pub const setX = astal_hyprland_position_set_x;

    extern fn astal_hyprland_position_get_y(p_self: *Position) c_int;
    pub const getY = astal_hyprland_position_get_y;

    extern fn astal_hyprland_position_set_y(p_self: *Position, p_value: c_int) void;
    pub const setY = astal_hyprland_position_set_y;

    extern fn astal_hyprland_position_get_type() usize;
    pub const getGObjectType = astal_hyprland_position_get_type;

    extern fn g_object_ref(p_self: *astalhyprland.Position) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalhyprland.Position) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Position, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Workspace = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalhyprland.WorkspaceClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalhyprland.WorkspacePrivate,
    f__clients: ?*glib.List,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_int;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const monitor = struct {
            pub const name = "monitor";

            pub const Type = ?**astalhyprland.Monitor;
        };

        pub const clients = struct {
            pub const name = "clients";

            pub const Type = ?**glib.List;
        };

        pub const has_fullscreen = struct {
            pub const name = "has-fullscreen";

            pub const Type = c_int;
        };

        pub const last_client = struct {
            pub const name = "last-client";

            pub const Type = ?**astalhyprland.Client;
        };
    };

    pub const signals = struct {
        pub const removed = struct {
            pub const name = "removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Workspace, p_instance))),
                    gobject.signalLookup("removed", Workspace.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_hyprland_workspace_new_dummy(p_id: c_int, p_monitor: ?*astalhyprland.Monitor) *astalhyprland.Workspace;
    pub const dummy = astal_hyprland_workspace_new_dummy;

    extern fn astal_hyprland_workspace_new() *astalhyprland.Workspace;
    pub const new = astal_hyprland_workspace_new;

    extern fn astal_hyprland_workspace_focus(p_self: *Workspace) void;
    pub const focus = astal_hyprland_workspace_focus;

    extern fn astal_hyprland_workspace_move_to(p_self: *Workspace, p_m: *astalhyprland.Monitor) void;
    pub const moveTo = astal_hyprland_workspace_move_to;

    extern fn astal_hyprland_workspace_get_id(p_self: *Workspace) c_int;
    pub const getId = astal_hyprland_workspace_get_id;

    extern fn astal_hyprland_workspace_get_name(p_self: *Workspace) [*:0]const u8;
    pub const getName = astal_hyprland_workspace_get_name;

    extern fn astal_hyprland_workspace_get_monitor(p_self: *Workspace) *astalhyprland.Monitor;
    pub const getMonitor = astal_hyprland_workspace_get_monitor;

    extern fn astal_hyprland_workspace_get_clients(p_self: *Workspace) *glib.List;
    pub const getClients = astal_hyprland_workspace_get_clients;

    extern fn astal_hyprland_workspace_get_has_fullscreen(p_self: *Workspace) c_int;
    pub const getHasFullscreen = astal_hyprland_workspace_get_has_fullscreen;

    extern fn astal_hyprland_workspace_get_last_client(p_self: *Workspace) *astalhyprland.Client;
    pub const getLastClient = astal_hyprland_workspace_get_last_client;

    extern fn astal_hyprland_workspace_get_type() usize;
    pub const getGObjectType = astal_hyprland_workspace_get_type;

    extern fn g_object_ref(p_self: *astalhyprland.Workspace) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalhyprland.Workspace) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Workspace, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClientClass = extern struct {
    pub const Instance = astalhyprland.Client;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ClientClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClientPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HyprlandClass = extern struct {
    pub const Instance = astalhyprland.Hyprland;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *HyprlandClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HyprlandPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MonitorClass = extern struct {
    pub const Instance = astalhyprland.Monitor;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *MonitorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MonitorPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BindClass = extern struct {
    pub const Instance = astalhyprland.Bind;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *BindClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BindPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PositionClass = extern struct {
    pub const Instance = astalhyprland.Position;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PositionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PositionPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WorkspaceClass = extern struct {
    pub const Instance = astalhyprland.Workspace;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *WorkspaceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WorkspacePrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MonitorTransform = enum(c_int) {
    normal = 0,
    rotate_90_deg = 1,
    rotate_180_deg = 2,
    rotate_270_deg = 3,
    flipped = 4,
    flipped_rotate_90_deg = 5,
    flipped_rotate_180_deg = 6,
    flipped_rotate_270_deg = 7,
    _,

    extern fn astal_hyprland_monitor_transform_get_type() usize;
    pub const getGObjectType = astal_hyprland_monitor_transform_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Fullscreen = packed struct(c_uint) {
    maximized: bool = false,
    fullscreen: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_current: Fullscreen = @bitCast(@as(c_int, -1));
    pub const flags_none: Fullscreen = @bitCast(@as(c_uint, 0));
    pub const flags_maximized: Fullscreen = @bitCast(@as(c_uint, 1));
    pub const flags_fullscreen: Fullscreen = @bitCast(@as(c_uint, 2));
    extern fn astal_hyprland_fullscreen_get_type() usize;
    pub const getGObjectType = astal_hyprland_fullscreen_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn astal_hyprland_get_default() *astalhyprland.Hyprland;
pub const getDefault = astal_hyprland_get_default;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
