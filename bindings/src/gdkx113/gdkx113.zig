pub const ext = @import("ext.zig");
const gdkx11 = @This();

const std = @import("std");
const compat = @import("compat");
const xlib = @import("xlib2");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const gdkpixbuf = @import("gdkpixbuf2");
const gdk = @import("gdk3");
pub const X11AppLaunchContext = opaque {
    pub const Parent = gdk.AppLaunchContext;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11AppLaunchContextClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_x11_app_launch_context_get_type() usize;
    pub const getGObjectType = gdk_x11_app_launch_context_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11AppLaunchContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11AppLaunchContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11AppLaunchContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11Cursor = opaque {
    pub const Parent = gdk.Cursor;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11CursorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the X cursor belonging to a `gdk.Cursor`.
    extern fn gdk_x11_cursor_get_xcursor(p_cursor: *X11Cursor) xlib.Cursor;
    pub const getXcursor = gdk_x11_cursor_get_xcursor;

    /// Returns the display of a `gdk.Cursor`.
    extern fn gdk_x11_cursor_get_xdisplay(p_cursor: *X11Cursor) *xlib.Display;
    pub const getXdisplay = gdk_x11_cursor_get_xdisplay;

    extern fn gdk_x11_cursor_get_type() usize;
    pub const getGObjectType = gdk_x11_cursor_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Cursor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Cursor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Cursor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceCore = opaque {
    pub const Parent = gdk.Device;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DeviceCoreClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_x11_device_core_get_type() usize;
    pub const getGObjectType = gdk_x11_device_core_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11DeviceCore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11DeviceCore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11DeviceCore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceManagerCore = opaque {
    pub const Parent = gdk.DeviceManager;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DeviceManagerCoreClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_x11_device_manager_core_get_type() usize;
    pub const getGObjectType = gdk_x11_device_manager_core_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11DeviceManagerCore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11DeviceManagerCore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11DeviceManagerCore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceManagerXI2 = opaque {
    pub const Parent = gdkx11.X11DeviceManagerCore;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DeviceManagerXI2Class;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const major = struct {
            pub const name = "major";

            pub const Type = c_int;
        };

        pub const minor = struct {
            pub const name = "minor";

            pub const Type = c_int;
        };

        pub const opcode = struct {
            pub const name = "opcode";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn gdk_x11_device_manager_xi2_get_type() usize;
    pub const getGObjectType = gdk_x11_device_manager_xi2_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11DeviceManagerXI2) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11DeviceManagerXI2) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11DeviceManagerXI2, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceXI2 = opaque {
    pub const Parent = gdk.Device;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DeviceXI2Class;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const device_id = struct {
            pub const name = "device-id";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn gdk_x11_device_xi2_get_type() usize;
    pub const getGObjectType = gdk_x11_device_xi2_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11DeviceXI2) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11DeviceXI2) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11DeviceXI2, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11Display = opaque {
    pub const Parent = gdk.Display;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DisplayClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Retrieves the version of the GLX implementation.
    extern fn gdk_x11_display_get_glx_version(p_display: *gdk.Display, p_major: *c_int, p_minor: *c_int) c_int;
    pub const getGlxVersion = gdk_x11_display_get_glx_version;

    /// Sends a startup notification message of type `message_type` to
    /// `display`.
    ///
    /// This is a convenience function for use by code that implements the
    /// freedesktop startup notification specification. Applications should
    /// not normally need to call it directly. See the
    /// [Startup Notification Protocol specification](http://standards.freedesktop.org/startup-notification-spec/startup-notification-latest.txt)
    /// for definitions of the message types and keys that can be used.
    extern fn gdk_x11_display_broadcast_startup_message(p_display: *X11Display, p_message_type: [*:0]const u8, ...) void;
    pub const broadcastStartupMessage = gdk_x11_display_broadcast_startup_message;

    /// Pops the error trap pushed by `gdkx11.X11Display.errorTrapPush`.
    /// Will `XSync` if necessary and will always block until
    /// the error is known to have occurred or not occurred,
    /// so the error code can be returned.
    ///
    /// If you don’t need to use the return value,
    /// `gdkx11.X11Display.errorTrapPopIgnored` would be more efficient.
    ///
    /// See `gdk.errorTrapPop` for the all-displays-at-once
    /// equivalent.
    extern fn gdk_x11_display_error_trap_pop(p_display: *X11Display) c_int;
    pub const errorTrapPop = gdk_x11_display_error_trap_pop;

    /// Pops the error trap pushed by `gdkx11.X11Display.errorTrapPush`.
    /// Does not block to see if an error occurred; merely records the
    /// range of requests to ignore errors for, and ignores those errors
    /// if they arrive asynchronously.
    ///
    /// See `gdk.errorTrapPopIgnored` for the all-displays-at-once
    /// equivalent.
    extern fn gdk_x11_display_error_trap_pop_ignored(p_display: *X11Display) void;
    pub const errorTrapPopIgnored = gdk_x11_display_error_trap_pop_ignored;

    /// Begins a range of X requests on `display` for which X error events
    /// will be ignored. Unignored errors (when no trap is pushed) will abort
    /// the application. Use `gdkx11.X11Display.errorTrapPop` or
    /// `gdkx11.X11Display.errorTrapPopIgnored`to lift a trap pushed
    /// with this function.
    ///
    /// See also `gdk.errorTrapPush` to push a trap on all displays.
    extern fn gdk_x11_display_error_trap_push(p_display: *X11Display) void;
    pub const errorTrapPush = gdk_x11_display_error_trap_push;

    /// Gets the startup notification ID for a display.
    extern fn gdk_x11_display_get_startup_notification_id(p_display: *X11Display) [*:0]const u8;
    pub const getStartupNotificationId = gdk_x11_display_get_startup_notification_id;

    /// Returns the timestamp of the last user interaction on
    /// `display`. The timestamp is taken from events caused
    /// by user interaction such as key presses or pointer
    /// movements. See `gdkx11.X11Window.setUserTime`.
    extern fn gdk_x11_display_get_user_time(p_display: *X11Display) u32;
    pub const getUserTime = gdk_x11_display_get_user_time;

    /// Returns the X display of a `gdk.Display`.
    extern fn gdk_x11_display_get_xdisplay(p_display: *X11Display) *xlib.Display;
    pub const getXdisplay = gdk_x11_display_get_xdisplay;

    /// Call `XGrabServer` on `display`.
    /// To ungrab the display again, use `gdkx11.X11Display.ungrab`.
    ///
    /// `gdkx11.X11Display.grab`/`gdkx11.X11Display.ungrab` calls can be nested.
    extern fn gdk_x11_display_grab(p_display: *X11Display) void;
    pub const grab = gdk_x11_display_grab;

    /// Sets the cursor theme from which the images for cursor
    /// should be taken.
    ///
    /// If the windowing system supports it, existing cursors created
    /// with `gdk.Cursor.new`, `gdk.Cursor.newForDisplay` and
    /// `gdk.Cursor.newFromName` are updated to reflect the theme
    /// change. Custom cursors constructed with
    /// `gdk.Cursor.newFromPixbuf` will have to be handled
    /// by the application (GTK+ applications can learn about
    /// cursor theme changes by listening for change notification
    /// for the corresponding `GtkSetting`).
    extern fn gdk_x11_display_set_cursor_theme(p_display: *X11Display, p_theme: ?[*:0]const u8, p_size: c_int) void;
    pub const setCursorTheme = gdk_x11_display_set_cursor_theme;

    /// Sets the startup notification ID for a display.
    ///
    /// This is usually taken from the value of the DESKTOP_STARTUP_ID
    /// environment variable, but in some cases (such as the application not
    /// being launched using `exec`) it can come from other sources.
    ///
    /// If the ID contains the string "_TIME" then the portion following that
    /// string is taken to be the X11 timestamp of the event that triggered
    /// the application to be launched and the GDK current event time is set
    /// accordingly.
    ///
    /// The startup ID is also what is used to signal that the startup is
    /// complete (for example, when opening a window or when calling
    /// `gdk.notifyStartupComplete`).
    extern fn gdk_x11_display_set_startup_notification_id(p_display: *X11Display, p_startup_id: [*:0]const u8) void;
    pub const setStartupNotificationId = gdk_x11_display_set_startup_notification_id;

    /// Forces a specific window scale for all windows on this display,
    /// instead of using the default or user configured scale. This
    /// is can be used to disable scaling support by setting `scale` to
    /// 1, or to programmatically set the window scale.
    ///
    /// Once the scale is set by this call it will not change in response
    /// to later user configuration changes.
    extern fn gdk_x11_display_set_window_scale(p_display: *X11Display, p_scale: c_int) void;
    pub const setWindowScale = gdk_x11_display_set_window_scale;

    /// Convert a string from the encoding of the current
    /// locale into a form suitable for storing in a window property.
    extern fn gdk_x11_display_string_to_compound_text(p_display: *X11Display, p_str: [*:0]const u8, p_encoding: *gdk.Atom, p_format: *c_int, p_ctext: *[*]u8, p_length: *c_int) c_int;
    pub const stringToCompoundText = gdk_x11_display_string_to_compound_text;

    /// Convert a text string from the encoding as it is stored
    /// in a property into an array of strings in the encoding of
    /// the current locale. (The elements of the array represent the
    /// nul-separated elements of the original text string.)
    extern fn gdk_x11_display_text_property_to_text_list(p_display: *X11Display, p_encoding: gdk.Atom, p_format: c_int, p_text: *const u8, p_length: c_int, p_list: **[*:0]u8) c_int;
    pub const textPropertyToTextList = gdk_x11_display_text_property_to_text_list;

    /// Ungrab `display` after it has been grabbed with
    /// `gdkx11.X11Display.grab`.
    extern fn gdk_x11_display_ungrab(p_display: *X11Display) void;
    pub const ungrab = gdk_x11_display_ungrab;

    /// Converts from UTF-8 to compound text.
    extern fn gdk_x11_display_utf8_to_compound_text(p_display: *X11Display, p_str: [*:0]const u8, p_encoding: *gdk.Atom, p_format: *c_int, p_ctext: *[*]u8, p_length: *c_int) c_int;
    pub const utf8ToCompoundText = gdk_x11_display_utf8_to_compound_text;

    extern fn gdk_x11_display_get_type() usize;
    pub const getGObjectType = gdk_x11_display_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Display) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Display) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Display, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DisplayManager = opaque {
    pub const Parent = gdk.DisplayManager;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DisplayManagerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_x11_display_manager_get_type() usize;
    pub const getGObjectType = gdk_x11_display_manager_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11DisplayManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11DisplayManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11DisplayManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DragContext = opaque {
    pub const Parent = gdk.DragContext;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DragContextClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_x11_drag_context_get_type() usize;
    pub const getGObjectType = gdk_x11_drag_context_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11DragContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11DragContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11DragContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11GLContext = opaque {
    pub const Parent = gdk.GLContext;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11GLContextClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_x11_gl_context_get_type() usize;
    pub const getGObjectType = gdk_x11_gl_context_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11GLContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11GLContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11GLContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11Keymap = opaque {
    pub const Parent = gdk.Keymap;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11KeymapClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts the group from the state field sent in an X Key event.
    /// This is only needed for code processing raw X events, since `gdk.EventKey`
    /// directly includes an is_modifier field.
    extern fn gdk_x11_keymap_get_group_for_state(p_keymap: *X11Keymap, p_state: c_uint) c_int;
    pub const getGroupForState = gdk_x11_keymap_get_group_for_state;

    /// Determines whether a particular key code represents a key that
    /// is a modifier. That is, it’s a key that normally just affects
    /// the keyboard state and the behavior of other keys rather than
    /// producing a direct effect itself. This is only needed for code
    /// processing raw X events, since `gdk.EventKey` directly includes
    /// an is_modifier field.
    extern fn gdk_x11_keymap_key_is_modifier(p_keymap: *X11Keymap, p_keycode: c_uint) c_int;
    pub const keyIsModifier = gdk_x11_keymap_key_is_modifier;

    extern fn gdk_x11_keymap_get_type() usize;
    pub const getGObjectType = gdk_x11_keymap_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Keymap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Keymap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Keymap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11Monitor = opaque {
    pub const Parent = gdk.Monitor;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11MonitorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_x11_monitor_get_output(p_monitor: *gdk.Monitor) xlib.XID;
    pub const getOutput = gdk_x11_monitor_get_output;

    extern fn gdk_x11_monitor_get_type() usize;
    pub const getGObjectType = gdk_x11_monitor_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Monitor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Monitor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Monitor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11Screen = opaque {
    pub const Parent = gdk.Screen;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11ScreenClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const window_manager_changed = struct {
            pub const name = "window-manager-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(X11Screen, p_instance))),
                    gobject.signalLookup("window-manager-changed", X11Screen.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns the current workspace for `screen` when running under a
    /// window manager that supports multiple workspaces, as described
    /// in the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec) specification.
    extern fn gdk_x11_screen_get_current_desktop(p_screen: *X11Screen) u32;
    pub const getCurrentDesktop = gdk_x11_screen_get_current_desktop;

    /// Gets the XID of the specified output/monitor.
    /// If the X server does not support version 1.2 of the RANDR
    /// extension, 0 is returned.
    extern fn gdk_x11_screen_get_monitor_output(p_screen: *X11Screen, p_monitor_num: c_int) xlib.XID;
    pub const getMonitorOutput = gdk_x11_screen_get_monitor_output;

    /// Returns the number of workspaces for `screen` when running under a
    /// window manager that supports multiple workspaces, as described
    /// in the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec) specification.
    extern fn gdk_x11_screen_get_number_of_desktops(p_screen: *X11Screen) u32;
    pub const getNumberOfDesktops = gdk_x11_screen_get_number_of_desktops;

    /// Returns the index of a `gdk.Screen`.
    extern fn gdk_x11_screen_get_screen_number(p_screen: *X11Screen) c_int;
    pub const getScreenNumber = gdk_x11_screen_get_screen_number;

    /// Returns the name of the window manager for `screen`.
    extern fn gdk_x11_screen_get_window_manager_name(p_screen: *X11Screen) [*:0]const u8;
    pub const getWindowManagerName = gdk_x11_screen_get_window_manager_name;

    /// Returns the screen of a `gdk.Screen`.
    extern fn gdk_x11_screen_get_xscreen(p_screen: *X11Screen) *xlib.Screen;
    pub const getXscreen = gdk_x11_screen_get_xscreen;

    /// Looks up the `gdk.Visual` for a particular screen and X Visual ID.
    extern fn gdk_x11_screen_lookup_visual(p_screen: *X11Screen, p_xvisualid: xlib.VisualID) *gdkx11.X11Visual;
    pub const lookupVisual = gdk_x11_screen_lookup_visual;

    /// This function is specific to the X11 backend of GDK, and indicates
    /// whether the window manager supports a certain hint from the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec) specification.
    ///
    /// When using this function, keep in mind that the window manager
    /// can change over time; so you shouldn’t use this function in
    /// a way that impacts persistent application state. A common bug
    /// is that your application can start up before the window manager
    /// does when the user logs in, and before the window manager starts
    /// `gdkx11.X11Screen.supportsNetWmHint` will return `FALSE` for every property.
    /// You can monitor the window_manager_changed signal on `gdk.Screen` to detect
    /// a window manager change.
    extern fn gdk_x11_screen_supports_net_wm_hint(p_screen: *X11Screen, p_property: gdk.Atom) c_int;
    pub const supportsNetWmHint = gdk_x11_screen_supports_net_wm_hint;

    extern fn gdk_x11_screen_get_type() usize;
    pub const getGObjectType = gdk_x11_screen_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Screen) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Screen) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Screen, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11Visual = opaque {
    pub const Parent = gdk.Visual;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11VisualClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the X visual belonging to a `gdk.Visual`.
    extern fn gdk_x11_visual_get_xvisual(p_visual: *X11Visual) *xlib.Visual;
    pub const getXvisual = gdk_x11_visual_get_xvisual;

    extern fn gdk_x11_visual_get_type() usize;
    pub const getGObjectType = gdk_x11_visual_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Visual) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Visual) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Visual, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11Window = opaque {
    pub const Parent = gdk.Window;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11WindowClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Looks up the `gdk.Window` that wraps the given native window handle.
    extern fn gdk_x11_window_lookup_for_display(p_display: *gdkx11.X11Display, p_window: xlib.Window) *gdkx11.X11Window;
    pub const lookupForDisplay = gdk_x11_window_lookup_for_display;

    /// Wraps a native window in a `gdk.Window`. The function will try to
    /// look up the window using `gdkx11.X11Window.lookupForDisplay` first.
    /// If it does not find it there, it will create a new window.
    ///
    /// This may fail if the window has been destroyed. If the window
    /// was already known to GDK, a new reference to the existing
    /// `gdk.Window` is returned.
    extern fn gdk_x11_window_foreign_new_for_display(p_display: *gdkx11.X11Display, p_window: xlib.Window) *gdkx11.X11Window;
    pub const foreignNewForDisplay = gdk_x11_window_foreign_new_for_display;

    /// Gets the number of the workspace `window` is on.
    extern fn gdk_x11_window_get_desktop(p_window: *X11Window) u32;
    pub const getDesktop = gdk_x11_window_get_desktop;

    /// Returns the X resource (window) belonging to a `gdk.Window`.
    extern fn gdk_x11_window_get_xid(p_window: *X11Window) xlib.Window;
    pub const getXid = gdk_x11_window_get_xid;

    /// Moves the window to the correct workspace when running under a
    /// window manager that supports multiple workspaces, as described
    /// in the [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec) specification.
    /// Will not do anything if the window is already on all workspaces.
    extern fn gdk_x11_window_move_to_current_desktop(p_window: *X11Window) void;
    pub const moveToCurrentDesktop = gdk_x11_window_move_to_current_desktop;

    /// Moves the window to the given workspace when running unde a
    /// window manager that supports multiple workspaces, as described
    /// in the [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec) specification.
    extern fn gdk_x11_window_move_to_desktop(p_window: *X11Window, p_desktop: u32) void;
    pub const moveToDesktop = gdk_x11_window_move_to_desktop;

    /// This is the same as `gdk.Window.setShadowWidth` but it only works
    /// on GdkX11Window.
    extern fn gdk_x11_window_set_frame_extents(p_window: *X11Window, p_left: c_int, p_right: c_int, p_top: c_int, p_bottom: c_int) void;
    pub const setFrameExtents = gdk_x11_window_set_frame_extents;

    /// This function can be used to disable frame synchronization for a window.
    /// Normally frame synchronziation will be enabled or disabled based on whether
    /// the system has a compositor that supports frame synchronization, but if
    /// the window is not directly managed by the window manager, then frame
    /// synchronziation may need to be disabled. This is the case for a window
    /// embedded via the XEMBED protocol.
    extern fn gdk_x11_window_set_frame_sync_enabled(p_window: *X11Window, p_frame_sync_enabled: c_int) void;
    pub const setFrameSyncEnabled = gdk_x11_window_set_frame_sync_enabled;

    /// Set a hint for the window manager, requesting that the titlebar
    /// should be hidden when the window is maximized.
    ///
    /// Note that this property is automatically updated by GTK+, so this
    /// function should only be used by applications which do not use GTK+
    /// to create toplevel windows.
    extern fn gdk_x11_window_set_hide_titlebar_when_maximized(p_window: *X11Window, p_hide_titlebar_when_maximized: c_int) void;
    pub const setHideTitlebarWhenMaximized = gdk_x11_window_set_hide_titlebar_when_maximized;

    /// GTK+ applications can request a dark theme variant. In order to
    /// make other applications - namely window managers using GTK+ for
    /// themeing - aware of this choice, GTK+ uses this function to
    /// export the requested theme variant as _GTK_THEME_VARIANT property
    /// on toplevel windows.
    ///
    /// Note that this property is automatically updated by GTK+, so this
    /// function should only be used by applications which do not use GTK+
    /// to create toplevel windows.
    extern fn gdk_x11_window_set_theme_variant(p_window: *X11Window, p_variant: [*:0]u8) void;
    pub const setThemeVariant = gdk_x11_window_set_theme_variant;

    /// The application can use this call to update the _NET_WM_USER_TIME
    /// property on a toplevel window.  This property stores an Xserver
    /// time which represents the time of the last user input event
    /// received for this window.  This property may be used by the window
    /// manager to alter the focus, stacking, and/or placement behavior of
    /// windows when they are mapped depending on whether the new window
    /// was created by a user action or is a "pop-up" window activated by a
    /// timer or some other event.
    ///
    /// Note that this property is automatically updated by GDK, so this
    /// function should only be used by applications which handle input
    /// events bypassing GDK.
    extern fn gdk_x11_window_set_user_time(p_window: *X11Window, p_timestamp: u32) void;
    pub const setUserTime = gdk_x11_window_set_user_time;

    /// This function modifies or removes an arbitrary X11 window
    /// property of type UTF8_STRING.  If the given `window` is
    /// not a toplevel window, it is ignored.
    extern fn gdk_x11_window_set_utf8_property(p_window: *X11Window, p_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
    pub const setUtf8Property = gdk_x11_window_set_utf8_property;

    extern fn gdk_x11_window_get_type() usize;
    pub const getGObjectType = gdk_x11_window_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Window) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Window) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Window, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11AppLaunchContextClass = opaque {
    pub const Instance = gdkx11.X11AppLaunchContext;

    pub fn as(p_instance: *X11AppLaunchContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11CursorClass = opaque {
    pub const Instance = gdkx11.X11Cursor;

    pub fn as(p_instance: *X11CursorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceCoreClass = opaque {
    pub const Instance = gdkx11.X11DeviceCore;

    pub fn as(p_instance: *X11DeviceCoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceManagerCoreClass = opaque {
    pub const Instance = gdkx11.X11DeviceManagerCore;

    pub fn as(p_instance: *X11DeviceManagerCoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceManagerXI2Class = opaque {
    pub const Instance = gdkx11.X11DeviceManagerXI2;

    pub fn as(p_instance: *X11DeviceManagerXI2Class, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceXI2Class = opaque {
    pub const Instance = gdkx11.X11DeviceXI2;

    pub fn as(p_instance: *X11DeviceXI2Class, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DisplayClass = opaque {
    pub const Instance = gdkx11.X11Display;

    pub fn as(p_instance: *X11DisplayClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DisplayManagerClass = opaque {
    pub const Instance = gdkx11.X11DisplayManager;

    pub fn as(p_instance: *X11DisplayManagerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DragContextClass = opaque {
    pub const Instance = gdkx11.X11DragContext;

    pub fn as(p_instance: *X11DragContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11GLContextClass = opaque {
    pub const Instance = gdkx11.X11GLContext;

    pub fn as(p_instance: *X11GLContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11KeymapClass = opaque {
    pub const Instance = gdkx11.X11Keymap;

    pub fn as(p_instance: *X11KeymapClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11MonitorClass = opaque {
    pub const Instance = gdkx11.X11Monitor;

    pub fn as(p_instance: *X11MonitorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11ScreenClass = opaque {
    pub const Instance = gdkx11.X11Screen;

    pub fn as(p_instance: *X11ScreenClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11VisualClass = opaque {
    pub const Instance = gdkx11.X11Visual;

    pub fn as(p_instance: *X11VisualClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11WindowClass = opaque {
    pub const Instance = gdkx11.X11Window;

    pub fn as(p_instance: *X11WindowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Converts from a `gdk.Atom` to the X atom for the default GDK display
/// with the same string value.
extern fn gdk_x11_atom_to_xatom(p_atom: gdk.Atom) xlib.Atom;
pub const x11AtomToXatom = gdk_x11_atom_to_xatom;

/// Converts from a `gdk.Atom` to the X atom for a `gdk.Display`
/// with the same string value. The special value `GDK_NONE`
/// is converted to `None`.
extern fn gdk_x11_atom_to_xatom_for_display(p_display: *gdkx11.X11Display, p_atom: gdk.Atom) xlib.Atom;
pub const x11AtomToXatomForDisplay = gdk_x11_atom_to_xatom_for_display;

/// Returns the device ID as seen by XInput2.
///
/// > If `gdk.disableMultidevice` has been called, this function
/// > will respectively return 2/3 for the core pointer and keyboard,
/// > (matching the IDs for the Virtual Core Pointer and Keyboard in
/// > XInput 2), but calling this function on any slave devices (i.e.
/// > those managed via XInput 1.x), will return 0.
extern fn gdk_x11_device_get_id(p_device: *gdkx11.X11DeviceCore) c_int;
pub const x11DeviceGetId = gdk_x11_device_get_id;

/// Returns the `gdk.Device` that wraps the given device ID.
extern fn gdk_x11_device_manager_lookup(p_device_manager: *gdkx11.X11DeviceManagerCore, p_device_id: c_int) ?*gdkx11.X11DeviceCore;
pub const x11DeviceManagerLookup = gdk_x11_device_manager_lookup;

/// Frees the data returned from `gdkx11.X11Display.stringToCompoundText`.
extern fn gdk_x11_free_compound_text(p_ctext: *u8) void;
pub const x11FreeCompoundText = gdk_x11_free_compound_text;

/// Frees the array of strings created by
/// `gdkx11.X11Display.textPropertyToTextList`.
extern fn gdk_x11_free_text_list(p_list: *[*:0]u8) void;
pub const x11FreeTextList = gdk_x11_free_text_list;

/// Gets the root window of the default screen
/// (see `gdkx11.x11GetDefaultScreen`).
extern fn gdk_x11_get_default_root_xwindow() xlib.Window;
pub const x11GetDefaultRootXwindow = gdk_x11_get_default_root_xwindow;

/// Gets the default GTK+ screen number.
extern fn gdk_x11_get_default_screen() c_int;
pub const x11GetDefaultScreen = gdk_x11_get_default_screen;

/// Gets the default GTK+ display.
extern fn gdk_x11_get_default_xdisplay() *xlib.Display;
pub const x11GetDefaultXdisplay = gdk_x11_get_default_xdisplay;

/// Used with `gdk.Window.setBackgroundPattern` to inherit background from
/// parent window. Useful for imitating transparency when compositing is not
/// available. Otherwise behaves like a transparent pattern.
extern fn gdk_x11_get_parent_relative_pattern() *cairo.Pattern;
pub const x11GetParentRelativePattern = gdk_x11_get_parent_relative_pattern;

/// Routine to get the current X server time stamp.
extern fn gdk_x11_get_server_time(p_window: *gdkx11.X11Window) u32;
pub const x11GetServerTime = gdk_x11_get_server_time;

/// Returns the X atom for GDK’s default display corresponding to `atom_name`.
/// This function caches the result, so if called repeatedly it is much
/// faster than `XInternAtom`, which is a round trip to the server each time.
extern fn gdk_x11_get_xatom_by_name(p_atom_name: [*:0]const u8) xlib.Atom;
pub const x11GetXatomByName = gdk_x11_get_xatom_by_name;

/// Returns the X atom for a `gdk.Display` corresponding to `atom_name`.
/// This function caches the result, so if called repeatedly it is much
/// faster than `XInternAtom`, which is a round trip to the server each time.
extern fn gdk_x11_get_xatom_by_name_for_display(p_display: *gdkx11.X11Display, p_atom_name: [*:0]const u8) xlib.Atom;
pub const x11GetXatomByNameForDisplay = gdk_x11_get_xatom_by_name_for_display;

/// Returns the name of an X atom for GDK’s default display. This
/// function is meant mainly for debugging, so for convenience, unlike
/// `XAtomName` and `gdk.Atom.name`, the result
/// doesn’t need to be freed. Also, this function will never return `NULL`,
/// even if `xatom` is invalid.
extern fn gdk_x11_get_xatom_name(p_xatom: xlib.Atom) [*:0]const u8;
pub const x11GetXatomName = gdk_x11_get_xatom_name;

/// Returns the name of an X atom for its display. This
/// function is meant mainly for debugging, so for convenience, unlike
/// `XAtomName` and `gdk.Atom.name`, the result doesn’t need to
/// be freed.
extern fn gdk_x11_get_xatom_name_for_display(p_display: *gdkx11.X11Display, p_xatom: xlib.Atom) [*:0]const u8;
pub const x11GetXatomNameForDisplay = gdk_x11_get_xatom_name_for_display;

/// Call `gdkx11.X11Display.grab` on the default display.
/// To ungrab the server again, use `gdkx11.x11UngrabServer`.
///
/// `gdkx11.x11GrabServer`/`gdkx11.x11UngrabServer` calls can be nested.
extern fn gdk_x11_grab_server() void;
pub const x11GrabServer = gdk_x11_grab_server;

/// Find the `gdk.Display` corresponding to `xdisplay`, if any exists.
extern fn gdk_x11_lookup_xdisplay(p_xdisplay: *xlib.Display) *gdkx11.X11Display;
pub const x11LookupXdisplay = gdk_x11_lookup_xdisplay;

/// Registers interest in receiving extension events with type codes
/// between `event_base` and `event_base + n_events - 1`.
/// The registered events must have the window field in the same place
/// as core X events (this is not the case for e.g. XKB extension events).
///
/// If an event type is registered, events of this type will go through
/// global and window-specific filters (see `gdk.Window.addFilter`).
/// Unregistered events will only go through global filters.
/// GDK may register the events of some X extensions on its own.
///
/// This function should only be needed in unusual circumstances, e.g.
/// when filtering XInput extension events on the root window.
extern fn gdk_x11_register_standard_event_type(p_display: *gdkx11.X11Display, p_event_base: c_int, p_n_events: c_int) void;
pub const x11RegisterStandardEventType = gdk_x11_register_standard_event_type;

/// Sets the `SM_CLIENT_ID` property on the application’s leader window so that
/// the window manager can save the application’s state using the X11R6 ICCCM
/// session management protocol.
///
/// See the X Session Management Library documentation for more information on
/// session management and the Inter-Client Communication Conventions Manual
extern fn gdk_x11_set_sm_client_id(p_sm_client_id: ?[*:0]const u8) void;
pub const x11SetSmClientId = gdk_x11_set_sm_client_id;

/// Ungrab the default display after it has been grabbed with
/// `gdkx11.x11GrabServer`.
extern fn gdk_x11_ungrab_server() void;
pub const x11UngrabServer = gdk_x11_ungrab_server;

/// Convert from an X atom for the default display to the corresponding
/// `gdk.Atom`.
extern fn gdk_x11_xatom_to_atom(p_xatom: xlib.Atom) gdk.Atom;
pub const x11XatomToAtom = gdk_x11_xatom_to_atom;

/// Convert from an X atom for a `gdk.Display` to the corresponding
/// `gdk.Atom`.
extern fn gdk_x11_xatom_to_atom_for_display(p_display: *gdkx11.X11Display, p_xatom: xlib.Atom) gdk.Atom;
pub const x11XatomToAtomForDisplay = gdk_x11_xatom_to_atom_for_display;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
