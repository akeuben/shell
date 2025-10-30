pub const ext = @import("ext.zig");
const gdkx11 = @This();

const std = @import("std");
const compat = @import("compat");
const xlib = @import("xlib2");
const gdk = @import("gdk4");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const pangocairo = @import("pangocairo1");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const gdkpixbuf = @import("gdkpixbuf2");
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

pub const X11DeviceManagerXI2 = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DeviceManagerXI2Class;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

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

    pub const signals = struct {
        /// The ::xevent signal is a low level signal that is emitted
        /// whenever an XEvent has been received.
        ///
        /// When handlers to this signal return `TRUE`, no other handlers will be
        /// invoked. In particular, the default handler for this function is
        /// GDK's own event handling mechanism, so by returning `TRUE` for an event
        /// that GDK expects to translate, you may break GDK and/or GTK+ in
        /// interesting ways. You have been warned.
        ///
        /// If you want this signal handler to queue a `GdkEvent`, you can use
        /// `gdk.Display.putEvent`.
        ///
        /// If you are interested in X GenericEvents, bear in mind that
        /// `XGetEventData` has been already called on the event, and
        /// `XFreeEventData` will be called afterwards.
        pub const xevent = struct {
            pub const name = "xevent";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_xevent: ?*anyopaque, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(X11Display, p_instance))),
                    gobject.signalLookup("xevent", X11Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Tries to open a new display to the X server given by
    /// `display_name`. If opening the display fails, `NULL` is
    /// returned.
    extern fn gdk_x11_display_open(p_display_name: ?[*:0]const u8) ?*gdk.Display;
    pub const open = gdk_x11_display_open;

    /// Sets the program class.
    ///
    /// The X11 backend uses the program class to set the class name part
    /// of the `WM_CLASS` property on toplevel windows; see the ICCCM.
    extern fn gdk_x11_display_set_program_class(p_display: *gdk.Display, p_program_class: [*:0]const u8) void;
    pub const setProgramClass = gdk_x11_display_set_program_class;

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
    extern fn gdk_x11_display_error_trap_pop(p_display: *X11Display) c_int;
    pub const errorTrapPop = gdk_x11_display_error_trap_pop;

    /// Pops the error trap pushed by `gdkx11.X11Display.errorTrapPush`.
    /// Does not block to see if an error occurred; merely records the
    /// range of requests to ignore errors for, and ignores those errors
    /// if they arrive asynchronously.
    extern fn gdk_x11_display_error_trap_pop_ignored(p_display: *X11Display) void;
    pub const errorTrapPopIgnored = gdk_x11_display_error_trap_pop_ignored;

    /// Begins a range of X requests on `display` for which X error events
    /// will be ignored. Unignored errors (when no trap is pushed) will abort
    /// the application. Use `gdkx11.X11Display.errorTrapPop` or
    /// `gdkx11.X11Display.errorTrapPopIgnored`to lift a trap pushed
    /// with this function.
    extern fn gdk_x11_display_error_trap_push(p_display: *X11Display) void;
    pub const errorTrapPush = gdk_x11_display_error_trap_push;

    /// Returns the default group leader surface for all toplevel surfaces
    /// on `display`. This surface is implicitly created by GDK.
    /// See `gdkx11.X11Surface.setGroup`.
    extern fn gdk_x11_display_get_default_group(p_display: *X11Display) *gdk.Surface;
    pub const getDefaultGroup = gdk_x11_display_get_default_group;

    /// Retrieves the EGL display connection object for the given GDK display.
    ///
    /// This function returns `NULL` if GDK is using GLX.
    extern fn gdk_x11_display_get_egl_display(p_display: *X11Display) ?*anyopaque;
    pub const getEglDisplay = gdk_x11_display_get_egl_display;

    /// Retrieves the version of the EGL implementation.
    extern fn gdk_x11_display_get_egl_version(p_display: *X11Display, p_major: *c_int, p_minor: *c_int) c_int;
    pub const getEglVersion = gdk_x11_display_get_egl_version;

    /// Retrieves the version of the GLX implementation.
    extern fn gdk_x11_display_get_glx_version(p_display: *X11Display, p_major: *c_int, p_minor: *c_int) c_int;
    pub const getGlxVersion = gdk_x11_display_get_glx_version;

    /// Gets the primary monitor for the display.
    ///
    /// The primary monitor is considered the monitor where the “main desktop”
    /// lives. While normal application surfaces typically allow the window
    /// manager to place the surfaces, specialized desktop applications
    /// such as panels should place themselves on the primary monitor.
    ///
    /// If no monitor is the designated primary monitor, any monitor
    /// (usually the first) may be returned.
    extern fn gdk_x11_display_get_primary_monitor(p_display: *X11Display) *gdk.Monitor;
    pub const getPrimaryMonitor = gdk_x11_display_get_primary_monitor;

    /// Retrieves the `GdkX11Screen` of the `display`.
    extern fn gdk_x11_display_get_screen(p_display: *X11Display) *gdkx11.X11Screen;
    pub const getScreen = gdk_x11_display_get_screen;

    /// Gets the startup notification ID for a display.
    extern fn gdk_x11_display_get_startup_notification_id(p_display: *X11Display) [*:0]const u8;
    pub const getStartupNotificationId = gdk_x11_display_get_startup_notification_id;

    /// Returns the timestamp of the last user interaction on
    /// `display`. The timestamp is taken from events caused
    /// by user interaction such as key presses or pointer
    /// movements. See `gdkx11.X11Surface.setUserTime`.
    extern fn gdk_x11_display_get_user_time(p_display: *X11Display) u32;
    pub const getUserTime = gdk_x11_display_get_user_time;

    /// Returns the X cursor belonging to a `GdkCursor`, potentially
    /// creating the cursor.
    ///
    /// Be aware that the returned cursor may not be unique to `cursor`.
    /// It may for example be shared with its fallback cursor. On old
    /// X servers that don't support the XCursor extension, all cursors
    /// may even fall back to a few default cursors.
    extern fn gdk_x11_display_get_xcursor(p_display: *X11Display, p_cursor: *gdk.Cursor) xlib.Cursor;
    pub const getXcursor = gdk_x11_display_get_xcursor;

    /// Returns the X display of a `GdkDisplay`.
    extern fn gdk_x11_display_get_xdisplay(p_display: *X11Display) *xlib.Display;
    pub const getXdisplay = gdk_x11_display_get_xdisplay;

    /// Returns the root X window used by `GdkDisplay`.
    extern fn gdk_x11_display_get_xrootwindow(p_display: *X11Display) xlib.Window;
    pub const getXrootwindow = gdk_x11_display_get_xrootwindow;

    /// Returns the X Screen used by `GdkDisplay`.
    extern fn gdk_x11_display_get_xscreen(p_display: *X11Display) *xlib.Screen;
    pub const getXscreen = gdk_x11_display_get_xscreen;

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
    /// with `gdk.Cursor.newFromName` are updated to reflect the theme
    /// change. Custom cursors constructed with `gdk.Cursor.newFromTexture`
    /// will have to be handled by the application (GTK applications can learn
    /// about cursor theme changes by listening for change notification
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
    /// `gdk.Display.notifyStartupComplete`).
    extern fn gdk_x11_display_set_startup_notification_id(p_display: *X11Display, p_startup_id: [*:0]const u8) void;
    pub const setStartupNotificationId = gdk_x11_display_set_startup_notification_id;

    /// Forces a specific window scale for all windows on this display,
    /// instead of using the default or user configured scale. This
    /// is can be used to disable scaling support by setting `scale` to
    /// 1, or to programmatically set the window scale.
    ///
    /// Once the scale is set by this call it will not change in response
    /// to later user configuration changes.
    extern fn gdk_x11_display_set_surface_scale(p_display: *X11Display, p_scale: c_int) void;
    pub const setSurfaceScale = gdk_x11_display_set_surface_scale;

    /// Convert a string from the encoding of the current
    /// locale into a form suitable for storing in a window property.
    extern fn gdk_x11_display_string_to_compound_text(p_display: *X11Display, p_str: [*:0]const u8, p_encoding: *[*:0]const u8, p_format: *c_int, p_ctext: *[*]u8, p_length: *c_int) c_int;
    pub const stringToCompoundText = gdk_x11_display_string_to_compound_text;

    /// Convert a text string from the encoding as it is stored
    /// in a property into an array of strings in the encoding of
    /// the current locale. (The elements of the array represent the
    /// nul-separated elements of the original text string.)
    extern fn gdk_x11_display_text_property_to_text_list(p_display: *X11Display, p_encoding: [*:0]const u8, p_format: c_int, p_text: *const u8, p_length: c_int, p_list: **[*:0]u8) c_int;
    pub const textPropertyToTextList = gdk_x11_display_text_property_to_text_list;

    /// Ungrab `display` after it has been grabbed with
    /// `gdkx11.X11Display.grab`.
    extern fn gdk_x11_display_ungrab(p_display: *X11Display) void;
    pub const ungrab = gdk_x11_display_ungrab;

    /// Converts from UTF-8 to compound text.
    extern fn gdk_x11_display_utf8_to_compound_text(p_display: *X11Display, p_str: [*:0]const u8, p_encoding: *[*:0]const u8, p_format: *c_int, p_ctext: *[*]u8, p_length: *c_int) c_int;
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

pub const X11Drag = opaque {
    pub const Parent = gdk.Drag;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11DragClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_x11_drag_get_type() usize;
    pub const getGObjectType = gdk_x11_drag_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Drag) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Drag) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Drag, comptime P_T: type) *P_T {
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

pub const X11Monitor = opaque {
    pub const Parent = gdk.Monitor;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11MonitorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the XID of the Output corresponding to `monitor`.
    extern fn gdk_x11_monitor_get_output(p_monitor: *X11Monitor) xlib.XID;
    pub const getOutput = gdk_x11_monitor_get_output;

    /// Retrieves the size and position of the “work area” on a monitor
    /// within the display coordinate space.
    ///
    /// The returned geometry is in ”application pixels”, not in ”device pixels”
    /// (see `gdk.Monitor.getScaleFactor`).
    extern fn gdk_x11_monitor_get_workarea(p_monitor: *X11Monitor, p_workarea: *gdk.Rectangle) void;
    pub const getWorkarea = gdk_x11_monitor_get_workarea;

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
    pub const Parent = gobject.Object;
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

    /// Returns the index of a `GdkX11Screen`.
    extern fn gdk_x11_screen_get_screen_number(p_screen: *X11Screen) c_int;
    pub const getScreenNumber = gdk_x11_screen_get_screen_number;

    /// Returns the name of the window manager for `screen`.
    extern fn gdk_x11_screen_get_window_manager_name(p_screen: *X11Screen) [*:0]const u8;
    pub const getWindowManagerName = gdk_x11_screen_get_window_manager_name;

    /// Returns the screen of a `GdkX11Screen`.
    extern fn gdk_x11_screen_get_xscreen(p_screen: *X11Screen) *xlib.Screen;
    pub const getXscreen = gdk_x11_screen_get_xscreen;

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
    /// You can monitor the window_manager_changed signal on `GdkX11Screen` to detect
    /// a window manager change.
    extern fn gdk_x11_screen_supports_net_wm_hint(p_screen: *X11Screen, p_property_name: [*:0]const u8) c_int;
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

pub const X11Surface = opaque {
    pub const Parent = gdk.Surface;
    pub const Implements = [_]type{};
    pub const Class = gdkx11.X11SurfaceClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Looks up the `GdkSurface` that wraps the given native window handle.
    extern fn gdk_x11_surface_lookup_for_display(p_display: *gdkx11.X11Display, p_window: xlib.Window) *gdkx11.X11Surface;
    pub const lookupForDisplay = gdk_x11_surface_lookup_for_display;

    /// Gets the number of the workspace `surface` is on.
    extern fn gdk_x11_surface_get_desktop(p_surface: *X11Surface) u32;
    pub const getDesktop = gdk_x11_surface_get_desktop;

    /// Returns the group this surface belongs to.
    extern fn gdk_x11_surface_get_group(p_surface: *X11Surface) ?*gdk.Surface;
    pub const getGroup = gdk_x11_surface_get_group;

    /// Returns the X resource (surface) belonging to a `GdkSurface`.
    extern fn gdk_x11_surface_get_xid(p_surface: *X11Surface) xlib.Window;
    pub const getXid = gdk_x11_surface_get_xid;

    /// Moves the surface to the correct workspace when running under a
    /// window manager that supports multiple workspaces, as described
    /// in the [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec) specification.
    /// Will not do anything if the surface is already on all workspaces.
    extern fn gdk_x11_surface_move_to_current_desktop(p_surface: *X11Surface) void;
    pub const moveToCurrentDesktop = gdk_x11_surface_move_to_current_desktop;

    /// Moves the surface to the given workspace when running unde a
    /// window manager that supports multiple workspaces, as described
    /// in the [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec) specification.
    extern fn gdk_x11_surface_move_to_desktop(p_surface: *X11Surface, p_desktop: u32) void;
    pub const moveToDesktop = gdk_x11_surface_move_to_desktop;

    /// This function can be used to disable frame synchronization for a surface.
    /// Normally frame synchronziation will be enabled or disabled based on whether
    /// the system has a compositor that supports frame synchronization, but if
    /// the surface is not directly managed by the window manager, then frame
    /// synchronziation may need to be disabled. This is the case for a surface
    /// embedded via the XEMBED protocol.
    extern fn gdk_x11_surface_set_frame_sync_enabled(p_surface: *X11Surface, p_frame_sync_enabled: c_int) void;
    pub const setFrameSyncEnabled = gdk_x11_surface_set_frame_sync_enabled;

    /// Sets the group leader of `surface` to be `leader`.
    /// See the ICCCM for details.
    extern fn gdk_x11_surface_set_group(p_surface: *X11Surface, p_leader: *gdk.Surface) void;
    pub const setGroup = gdk_x11_surface_set_group;

    /// Sets a hint on `surface` that pagers should not
    /// display it. See the EWMH for details.
    extern fn gdk_x11_surface_set_skip_pager_hint(p_surface: *X11Surface, p_skips_pager: c_int) void;
    pub const setSkipPagerHint = gdk_x11_surface_set_skip_pager_hint;

    /// Sets a hint on `surface` that taskbars should not
    /// display it. See the EWMH for details.
    extern fn gdk_x11_surface_set_skip_taskbar_hint(p_surface: *X11Surface, p_skips_taskbar: c_int) void;
    pub const setSkipTaskbarHint = gdk_x11_surface_set_skip_taskbar_hint;

    /// GTK applications can request a dark theme variant. In order to
    /// make other applications - namely window managers using GTK for
    /// themeing - aware of this choice, GTK uses this function to
    /// export the requested theme variant as _GTK_THEME_VARIANT property
    /// on toplevel surfaces.
    ///
    /// Note that this property is automatically updated by GTK, so this
    /// function should only be used by applications which do not use GTK
    /// to create toplevel surfaces.
    extern fn gdk_x11_surface_set_theme_variant(p_surface: *X11Surface, p_variant: [*:0]const u8) void;
    pub const setThemeVariant = gdk_x11_surface_set_theme_variant;

    /// Sets a hint on `surface` that it needs user attention.
    /// See the ICCCM for details.
    extern fn gdk_x11_surface_set_urgency_hint(p_surface: *X11Surface, p_urgent: c_int) void;
    pub const setUrgencyHint = gdk_x11_surface_set_urgency_hint;

    /// The application can use this call to update the _NET_WM_USER_TIME
    /// property on a toplevel surface.  This property stores an Xserver
    /// time which represents the time of the last user input event
    /// received for this surface.  This property may be used by the window
    /// manager to alter the focus, stacking, and/or placement behavior of
    /// surfaces when they are mapped depending on whether the new surface
    /// was created by a user action or is a "pop-up" surface activated by a
    /// timer or some other event.
    ///
    /// Note that this property is automatically updated by GDK, so this
    /// function should only be used by applications which handle input
    /// events bypassing GDK.
    extern fn gdk_x11_surface_set_user_time(p_surface: *X11Surface, p_timestamp: u32) void;
    pub const setUserTime = gdk_x11_surface_set_user_time;

    /// This function modifies or removes an arbitrary X11 window
    /// property of type UTF8_STRING.  If the given `surface` is
    /// not a toplevel surface, it is ignored.
    extern fn gdk_x11_surface_set_utf8_property(p_surface: *X11Surface, p_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
    pub const setUtf8Property = gdk_x11_surface_set_utf8_property;

    extern fn gdk_x11_surface_get_type() usize;
    pub const getGObjectType = gdk_x11_surface_get_type;

    extern fn g_object_ref(p_self: *gdkx11.X11Surface) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkx11.X11Surface) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *X11Surface, comptime P_T: type) *P_T {
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

pub const X11DragClass = opaque {
    pub const Instance = gdkx11.X11Drag;

    pub fn as(p_instance: *X11DragClass, comptime P_T: type) *P_T {
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

pub const X11SurfaceClass = opaque {
    pub const Instance = gdkx11.X11Surface;

    pub fn as(p_instance: *X11SurfaceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const X11DeviceType = enum(c_int) {
    logical = 0,
    physical = 1,
    floating = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Returns the device ID as seen by XInput2.
extern fn gdk_x11_device_get_id(p_device: *gdkx11.X11DeviceXI2) c_int;
pub const x11DeviceGetId = gdk_x11_device_get_id;

/// Returns the `GdkDevice` that wraps the given device ID.
extern fn gdk_x11_device_manager_lookup(p_device_manager: *gdkx11.X11DeviceManagerXI2, p_device_id: c_int) ?*gdkx11.X11DeviceXI2;
pub const x11DeviceManagerLookup = gdk_x11_device_manager_lookup;

/// Frees the data returned from `gdkx11.X11Display.stringToCompoundText`.
extern fn gdk_x11_free_compound_text(p_ctext: *u8) void;
pub const x11FreeCompoundText = gdk_x11_free_compound_text;

/// Frees the array of strings created by
/// `gdkx11.X11Display.textPropertyToTextList`.
extern fn gdk_x11_free_text_list(p_list: *[*:0]u8) void;
pub const x11FreeTextList = gdk_x11_free_text_list;

/// Routine to get the current X server time stamp.
extern fn gdk_x11_get_server_time(p_surface: *gdkx11.X11Surface) u32;
pub const x11GetServerTime = gdk_x11_get_server_time;

/// Returns the X atom for a `GdkDisplay` corresponding to `atom_name`.
/// This function caches the result, so if called repeatedly it is much
/// faster than `XInternAtom`, which is a round trip to the server each time.
extern fn gdk_x11_get_xatom_by_name_for_display(p_display: *gdkx11.X11Display, p_atom_name: [*:0]const u8) xlib.Atom;
pub const x11GetXatomByNameForDisplay = gdk_x11_get_xatom_by_name_for_display;

/// Returns the name of an X atom for its display. This
/// function is meant mainly for debugging, so for convenience, unlike
/// `XAtomName` and the result doesn’t need to
/// be freed.
extern fn gdk_x11_get_xatom_name_for_display(p_display: *gdkx11.X11Display, p_xatom: xlib.Atom) [*:0]const u8;
pub const x11GetXatomNameForDisplay = gdk_x11_get_xatom_name_for_display;

/// Find the `GdkDisplay` corresponding to `xdisplay`, if any exists.
extern fn gdk_x11_lookup_xdisplay(p_xdisplay: *xlib.Display) *gdkx11.X11Display;
pub const x11LookupXdisplay = gdk_x11_lookup_xdisplay;

/// Sets the `SM_CLIENT_ID` property on the application’s leader window so that
/// the window manager can save the application’s state using the X11R6 ICCCM
/// session management protocol.
///
/// See the X Session Management Library documentation for more information on
/// session management and the Inter-Client Communication Conventions Manual
extern fn gdk_x11_set_sm_client_id(p_sm_client_id: ?[*:0]const u8) void;
pub const x11SetSmClientId = gdk_x11_set_sm_client_id;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
