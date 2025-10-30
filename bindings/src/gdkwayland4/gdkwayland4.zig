pub const ext = @import("ext.zig");
const gdkwayland = @This();

const std = @import("std");
const compat = @import("compat");
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
/// The Wayland implementation of `GdkDevice`.
///
/// Beyond the regular `gdk.Device` API, the Wayland implementation
/// provides access to Wayland objects such as the `wl_seat` with
/// `gdkwayland.WaylandDevice.getWlSeat`, the `wl_keyboard` with
/// `gdkwayland.WaylandDevice.getWlKeyboard` and the `wl_pointer` with
/// `gdkwayland.WaylandDevice.getWlPointer`.
pub const WaylandDevice = opaque {
    pub const Parent = gdk.Device;
    pub const Implements = [_]type{};
    pub const Class = gdkwayland.WaylandDeviceClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the `/dev/input/event*` path of this device.
    ///
    /// For `GdkDevice`s that possibly coalesce multiple hardware
    /// devices (eg. mouse, keyboard, touch,...), this function
    /// will return `NULL`.
    ///
    /// This is most notably implemented for devices of type
    /// `GDK_SOURCE_PEN`, `GDK_SOURCE_TABLET_PAD`.
    extern fn gdk_wayland_device_get_node_path(p_device: *WaylandDevice) ?[*:0]const u8;
    pub const getNodePath = gdk_wayland_device_get_node_path;

    /// Returns the Wayland `wl_keyboard` of a `GdkDevice`.
    extern fn gdk_wayland_device_get_wl_keyboard(p_device: *WaylandDevice) ?*anyopaque;
    pub const getWlKeyboard = gdk_wayland_device_get_wl_keyboard;

    /// Returns the Wayland `wl_pointer` of a `GdkDevice`.
    extern fn gdk_wayland_device_get_wl_pointer(p_device: *WaylandDevice) ?*anyopaque;
    pub const getWlPointer = gdk_wayland_device_get_wl_pointer;

    /// Returns the Wayland `wl_seat` of a `GdkDevice`.
    extern fn gdk_wayland_device_get_wl_seat(p_device: *WaylandDevice) ?*anyopaque;
    pub const getWlSeat = gdk_wayland_device_get_wl_seat;

    /// Returns the `xkb_keymap` of a `GdkDevice`.
    extern fn gdk_wayland_device_get_xkb_keymap(p_device: *WaylandDevice) ?*anyopaque;
    pub const getXkbKeymap = gdk_wayland_device_get_xkb_keymap;

    extern fn gdk_wayland_device_get_type() usize;
    pub const getGObjectType = gdk_wayland_device_get_type;

    extern fn g_object_ref(p_self: *gdkwayland.WaylandDevice) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkwayland.WaylandDevice) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WaylandDevice, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The Wayland implementation of `GdkDisplay`.
///
/// Beyond the regular `gdk.Display` API, the Wayland implementation
/// provides access to Wayland objects such as the `wl_display` with
/// `gdkwayland.WaylandDisplay.getWlDisplay`, the `wl_compositor` with
/// `gdkwayland.WaylandDisplay.getWlCompositor`.
///
/// You can find out what Wayland globals are supported by a display
/// with `gdkwayland.WaylandDisplay.queryRegistry`.
pub const WaylandDisplay = opaque {
    pub const Parent = gdk.Display;
    pub const Implements = [_]type{};
    pub const Class = gdkwayland.WaylandDisplayClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Retrieves the EGL display connection object for the given GDK display.
    extern fn gdk_wayland_display_get_egl_display(p_display: *WaylandDisplay) ?*anyopaque;
    pub const getEglDisplay = gdk_wayland_display_get_egl_display;

    /// Gets the startup notification ID for a Wayland display, or `NULL`
    /// if no ID has been defined.
    extern fn gdk_wayland_display_get_startup_notification_id(p_display: *WaylandDisplay) ?[*:0]const u8;
    pub const getStartupNotificationId = gdk_wayland_display_get_startup_notification_id;

    /// Returns the Wayland `wl_compositor` of a `GdkDisplay`.
    extern fn gdk_wayland_display_get_wl_compositor(p_display: *WaylandDisplay) ?*anyopaque;
    pub const getWlCompositor = gdk_wayland_display_get_wl_compositor;

    /// Returns the Wayland `wl_display` of a `GdkDisplay`.
    extern fn gdk_wayland_display_get_wl_display(p_display: *WaylandDisplay) ?*anyopaque;
    pub const getWlDisplay = gdk_wayland_display_get_wl_display;

    /// Returns `TRUE` if the interface was found in the display
    /// `wl_registry.global` handler.
    extern fn gdk_wayland_display_query_registry(p_display: *WaylandDisplay, p_global: [*:0]const u8) c_int;
    pub const queryRegistry = gdk_wayland_display_query_registry;

    /// Sets the cursor theme for the given `display`.
    extern fn gdk_wayland_display_set_cursor_theme(p_display: *WaylandDisplay, p_name: [*:0]const u8, p_size: c_int) void;
    pub const setCursorTheme = gdk_wayland_display_set_cursor_theme;

    /// Sets the startup notification ID for a display.
    ///
    /// This is usually taken from the value of the `DESKTOP_STARTUP_ID`
    /// environment variable, but in some cases (such as the application not
    /// being launched using `exec`) it can come from other sources.
    ///
    /// The startup ID is also what is used to signal that the startup is
    /// complete (for example, when opening a window or when calling
    /// `gdk.Display.notifyStartupComplete`).
    extern fn gdk_wayland_display_set_startup_notification_id(p_display: *WaylandDisplay, p_startup_id: [*:0]const u8) void;
    pub const setStartupNotificationId = gdk_wayland_display_set_startup_notification_id;

    extern fn gdk_wayland_display_get_type() usize;
    pub const getGObjectType = gdk_wayland_display_get_type;

    extern fn g_object_ref(p_self: *gdkwayland.WaylandDisplay) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkwayland.WaylandDisplay) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WaylandDisplay, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The Wayland implementation of `GdkGLContext`.
pub const WaylandGLContext = opaque {
    pub const Parent = gdk.GLContext;
    pub const Implements = [_]type{};
    pub const Class = gdkwayland.WaylandGLContextClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_wayland_gl_context_get_type() usize;
    pub const getGObjectType = gdk_wayland_gl_context_get_type;

    extern fn g_object_ref(p_self: *gdkwayland.WaylandGLContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkwayland.WaylandGLContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WaylandGLContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The Wayland implementation of `GdkMonitor`.
///
/// Beyond the `gdk.Monitor` API, the Wayland implementation
/// offers access to the Wayland `wl_output` object with
/// `gdkwayland.WaylandMonitor.getWlOutput`.
pub const WaylandMonitor = opaque {
    pub const Parent = gdk.Monitor;
    pub const Implements = [_]type{};
    pub const Class = gdkwayland.WaylandMonitorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the Wayland `wl_output` of a `GdkMonitor`.
    extern fn gdk_wayland_monitor_get_wl_output(p_monitor: *WaylandMonitor) ?*anyopaque;
    pub const getWlOutput = gdk_wayland_monitor_get_wl_output;

    extern fn gdk_wayland_monitor_get_type() usize;
    pub const getGObjectType = gdk_wayland_monitor_get_type;

    extern fn g_object_ref(p_self: *gdkwayland.WaylandMonitor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkwayland.WaylandMonitor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WaylandMonitor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The Wayland implementation of `GdkPopup`.
pub const WaylandPopup = opaque {
    pub const Parent = gdkwayland.WaylandSurface;
    pub const Implements = [_]type{gdk.Popup};
    pub const Class = opaque {
        pub const Instance = WaylandPopup;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_wayland_popup_get_type() usize;
    pub const getGObjectType = gdk_wayland_popup_get_type;

    extern fn g_object_ref(p_self: *gdkwayland.WaylandPopup) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkwayland.WaylandPopup) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WaylandPopup, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The Wayland implementation of `GdkSeat`.
///
/// Beyond the regular `gdk.Seat` API, the Wayland implementation
/// provides access to the Wayland `wl_seat` object with
/// `gdkwayland.WaylandSeat.getWlSeat`.
pub const WaylandSeat = opaque {
    pub const Parent = gdk.Seat;
    pub const Implements = [_]type{};
    pub const Class = gdkwayland.WaylandSeatClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the Wayland `wl_seat` of a `GdkSeat`.
    extern fn gdk_wayland_seat_get_wl_seat(p_seat: *WaylandSeat) ?*anyopaque;
    pub const getWlSeat = gdk_wayland_seat_get_wl_seat;

    extern fn gdk_wayland_seat_get_type() usize;
    pub const getGObjectType = gdk_wayland_seat_get_type;

    extern fn g_object_ref(p_self: *gdkwayland.WaylandSeat) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkwayland.WaylandSeat) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WaylandSeat, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The Wayland implementation of `GdkSurface`.
///
/// Beyond the `gdk.Surface` API, the Wayland implementation offers
/// access to the Wayland `wl_surface` object with
/// `gdkwayland.WaylandSurface.getWlSurface`.
pub const WaylandSurface = opaque {
    pub const Parent = gdk.Surface;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = WaylandSurface;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Forces next commit.
    extern fn gdk_wayland_surface_force_next_commit(p_surface: *WaylandSurface) void;
    pub const forceNextCommit = gdk_wayland_surface_force_next_commit;

    /// Returns the Wayland `wl_surface` of a `GdkSurface`.
    extern fn gdk_wayland_surface_get_wl_surface(p_surface: *WaylandSurface) ?*anyopaque;
    pub const getWlSurface = gdk_wayland_surface_get_wl_surface;

    extern fn gdk_wayland_surface_get_type() usize;
    pub const getGObjectType = gdk_wayland_surface_get_type;

    extern fn g_object_ref(p_self: *gdkwayland.WaylandSurface) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkwayland.WaylandSurface) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WaylandSurface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The Wayland implementation of `GdkToplevel`.
///
/// Beyond the `gdk.Toplevel` API, the Wayland implementation
/// has API to set up cross-process parent-child relationships between
/// surfaces with `gdkwayland.WaylandToplevel.exportHandle` and
/// `gdkwayland.WaylandToplevel.setTransientForExported`.
pub const WaylandToplevel = opaque {
    pub const Parent = gdkwayland.WaylandSurface;
    pub const Implements = [_]type{gdk.Toplevel};
    pub const Class = opaque {
        pub const Instance = WaylandToplevel;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Destroy a handle that was obtained with `gdkwayland.WaylandToplevel.exportHandle`.
    ///
    /// Note that this API depends on an unstable Wayland protocol,
    /// and thus may require changes in the future.
    extern fn gdk_wayland_toplevel_drop_exported_handle(p_toplevel: *WaylandToplevel, p_handle: [*:0]const u8) void;
    pub const dropExportedHandle = gdk_wayland_toplevel_drop_exported_handle;

    /// Asynchronously obtains a handle for a surface that can be passed
    /// to other processes.
    ///
    /// When the handle has been obtained, `callback` will be called.
    ///
    /// It is an error to call this function on a surface that is already
    /// exported.
    ///
    /// When the handle is no longer needed, `gdkwayland.WaylandToplevel.unexportHandle`
    /// should be called to clean up resources.
    ///
    /// The main purpose for obtaining a handle is to mark a surface
    /// from another surface as transient for this one, see
    /// `gdkwayland.WaylandToplevel.setTransientForExported`.
    ///
    /// Before 4.12, this API could not safely be used multiple times,
    /// since there was no reference counting for handles. Starting with
    /// 4.12, every call to this function obtains a new handle, and every
    /// call to `gdkwayland.WaylandToplevel.dropExportedHandle` drops
    /// just the handle that it is given.
    ///
    /// Note that this API depends on an unstable Wayland protocol,
    /// and thus may require changes in the future.
    extern fn gdk_wayland_toplevel_export_handle(p_toplevel: *WaylandToplevel, p_callback: gdkwayland.WaylandToplevelExported, p_user_data: ?*anyopaque, p_destroy_func: ?glib.DestroyNotify) c_int;
    pub const exportHandle = gdk_wayland_toplevel_export_handle;

    /// Sets the application id on a `GdkToplevel`.
    extern fn gdk_wayland_toplevel_set_application_id(p_toplevel: *WaylandToplevel, p_application_id: [*:0]const u8) void;
    pub const setApplicationId = gdk_wayland_toplevel_set_application_id;

    /// Marks `toplevel` as transient for the surface to which the given
    /// `parent_handle_str` refers.
    ///
    /// Typically, the handle will originate from a
    /// `gdkwayland.WaylandToplevel.exportHandle` call in another process.
    ///
    /// Note that this API depends on an unstable Wayland protocol,
    /// and thus may require changes in the future.
    extern fn gdk_wayland_toplevel_set_transient_for_exported(p_toplevel: *WaylandToplevel, p_parent_handle_str: [*:0]const u8) c_int;
    pub const setTransientForExported = gdk_wayland_toplevel_set_transient_for_exported;

    /// Destroys the handle that was obtained with
    /// `gdkwayland.WaylandToplevel.exportHandle`.
    ///
    /// It is an error to call this function on a surface that
    /// does not have a handle.
    ///
    /// Since 4.12, this function does nothing. Use
    /// `gdkwayland.WaylandToplevel.dropExportedHandle` instead to drop a
    /// handle that was obtained with `gdkwayland.WaylandToplevel.exportHandle`.
    ///
    /// Note that this API depends on an unstable Wayland protocol,
    /// and thus may require changes in the future.
    extern fn gdk_wayland_toplevel_unexport_handle(p_toplevel: *WaylandToplevel) void;
    pub const unexportHandle = gdk_wayland_toplevel_unexport_handle;

    extern fn gdk_wayland_toplevel_get_type() usize;
    pub const getGObjectType = gdk_wayland_toplevel_get_type;

    extern fn g_object_ref(p_self: *gdkwayland.WaylandToplevel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkwayland.WaylandToplevel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WaylandToplevel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WaylandDeviceClass = opaque {
    pub const Instance = gdkwayland.WaylandDevice;

    pub fn as(p_instance: *WaylandDeviceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WaylandDisplayClass = opaque {
    pub const Instance = gdkwayland.WaylandDisplay;

    pub fn as(p_instance: *WaylandDisplayClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WaylandGLContextClass = opaque {
    pub const Instance = gdkwayland.WaylandGLContext;

    pub fn as(p_instance: *WaylandGLContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WaylandMonitorClass = opaque {
    pub const Instance = gdkwayland.WaylandMonitor;

    pub fn as(p_instance: *WaylandMonitorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WaylandSeatClass = opaque {
    pub const Instance = gdkwayland.WaylandSeat;

    pub fn as(p_instance: *WaylandSeatClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Callback that gets called when the handle for a surface has been
/// obtained from the Wayland compositor.
///
/// This callback is used in `gdkwayland.WaylandToplevel.exportHandle`.
///
/// The `handle` can be passed to other processes, for the purpose of
/// marking surfaces as transient for out-of-process surfaces.
pub const WaylandToplevelExported = *const fn (p_toplevel: *gdkwayland.WaylandToplevel, p_handle: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
