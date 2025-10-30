pub const ext = @import("ext.zig");
const astal = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const astalio = @import("astalio0");
const gdk = @import("gdk4");
const cairo = @import("cairo1");
const pangocairo = @import("pangocairo1");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gdkpixbuf = @import("gdkpixbuf2");
const gtk = @import("gtk4");
const gsk = @import("gsk4");
const graphene = @import("graphene1");
/// A widget with one child. It is useful for deriving subclasses, since it provides common code needed for handling a single child widget.
pub const Bin = extern struct {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{gtk.Buildable};
    pub const Class = astal.BinClass;
    f_parent_instance: gtk.Widget,
    f_priv: ?*astal.BinPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const child = struct {
            pub const name = "child";

            pub const Type = ?**gtk.Widget;
        };
    };

    pub const signals = struct {};

    extern fn astal_bin_new() *astal.Bin;
    pub const new = astal_bin_new;

    extern fn astal_bin_get_child(p_self: *Bin) ?*gtk.Widget;
    pub const getChild = astal_bin_get_child;

    extern fn astal_bin_set_child(p_self: *Bin, p_value: ?*gtk.Widget) void;
    pub const setChild = astal_bin_set_child;

    extern fn astal_bin_get_type() usize;
    pub const getGObjectType = astal_bin_get_type;

    extern fn g_object_ref(p_self: *astal.Bin) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astal.Bin) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Bin, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Box = extern struct {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{};
    pub const Class = astal.BoxClass;
    f_parent_instance: gtk.Box,
    f_priv: ?*astal.BoxPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Corresponds to `gtk.@"Orientable ".properties.orientation`.
        pub const vertical = struct {
            pub const name = "vertical";

            pub const Type = c_int;
        };

        pub const children = struct {
            pub const name = "children";

            pub const Type = ?**glib.List;
        };

        pub const child = struct {
            pub const name = "child";

            pub const Type = ?**gtk.Widget;
        };
    };

    pub const signals = struct {};

    extern fn astal_box_new() *astal.Box;
    pub const new = astal_box_new;

    extern fn astal_box_get_vertical(p_self: *Box) c_int;
    pub const getVertical = astal_box_get_vertical;

    extern fn astal_box_set_vertical(p_self: *Box, p_value: c_int) void;
    pub const setVertical = astal_box_set_vertical;

    extern fn astal_box_get_children(p_self: *Box) *glib.List;
    pub const getChildren = astal_box_get_children;

    extern fn astal_box_set_children(p_self: *Box, p_value: *glib.List) void;
    pub const setChildren = astal_box_set_children;

    extern fn astal_box_get_child(p_self: *Box) ?*gtk.Widget;
    pub const getChild = astal_box_get_child;

    extern fn astal_box_set_child(p_self: *Box, p_value: ?*gtk.Widget) void;
    pub const setChild = astal_box_set_child;

    extern fn astal_box_get_type() usize;
    pub const getGObjectType = astal_box_get_type;

    extern fn g_object_ref(p_self: *astal.Box) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astal.Box) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Box, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Slider = extern struct {
    pub const Parent = gtk.Scale;
    pub const Implements = [_]type{};
    pub const Class = astal.SliderClass;
    f_parent_instance: gtk.Scale,
    f_priv: ?*astal.SliderPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Value of this slider. Defaults to `0`.
        pub const value = struct {
            pub const name = "value";

            pub const Type = f64;
        };

        /// Minimum possible value of this slider. Defaults to `0`.
        pub const min = struct {
            pub const name = "min";

            pub const Type = f64;
        };

        /// Maximum possible value of this slider. Defaults to `1`.
        pub const max = struct {
            pub const name = "max";

            pub const Type = f64;
        };

        /// Size of step increments. Defaults to `0.05`.
        pub const step = struct {
            pub const name = "step";

            pub const Type = f64;
        };

        /// Size of page increments. Defaults to `0.01`.
        pub const page = struct {
            pub const name = "page";

            pub const Type = f64;
        };
    };

    pub const signals = struct {};

    extern fn astal_slider_new() *astal.Slider;
    pub const new = astal_slider_new;

    extern fn astal_slider_get_value(p_self: *Slider) f64;
    pub const getValue = astal_slider_get_value;

    extern fn astal_slider_set_value(p_self: *Slider, p_value: f64) void;
    pub const setValue = astal_slider_set_value;

    extern fn astal_slider_get_min(p_self: *Slider) f64;
    pub const getMin = astal_slider_get_min;

    extern fn astal_slider_set_min(p_self: *Slider, p_value: f64) void;
    pub const setMin = astal_slider_set_min;

    extern fn astal_slider_get_max(p_self: *Slider) f64;
    pub const getMax = astal_slider_get_max;

    extern fn astal_slider_set_max(p_self: *Slider, p_value: f64) void;
    pub const setMax = astal_slider_set_max;

    extern fn astal_slider_get_step(p_self: *Slider) f64;
    pub const getStep = astal_slider_get_step;

    extern fn astal_slider_set_step(p_self: *Slider, p_value: f64) void;
    pub const setStep = astal_slider_set_step;

    extern fn astal_slider_get_page(p_self: *Slider) f64;
    pub const getPage = astal_slider_get_page;

    extern fn astal_slider_set_page(p_self: *Slider, p_value: f64) void;
    pub const setPage = astal_slider_set_page;

    extern fn astal_slider_get_type() usize;
    pub const getGObjectType = astal_slider_get_type;

    extern fn g_object_ref(p_self: *astal.Slider) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astal.Slider) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Slider, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Subclass of `gtk.Window` which integrates GtkLayerShell as class fields.
pub const Window = extern struct {
    pub const Parent = gtk.Window;
    pub const Implements = [_]type{};
    pub const Class = astal.WindowClass;
    f_parent_instance: gtk.Window,
    f_priv: ?*astal.WindowPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Namespace of this window. This can be used to target the layer in compositor rules.
        pub const namespace = struct {
            pub const name = "namespace";

            pub const Type = ?[*:0]u8;
        };

        /// Edges to anchor the window to.
        /// If two perpendicular edges are anchored, the surface will be anchored to that corner. If two opposite edges are anchored, the window will be
        /// stretched across the screen in that direction.
        pub const anchor = struct {
            pub const name = "anchor";

            pub const Type = astal.WindowAnchor;
        };

        /// Exclusivity of this window.
        pub const exclusivity = struct {
            pub const name = "exclusivity";

            pub const Type = astal.Exclusivity;
        };

        /// Which layer to appear this window on.
        pub const layer = struct {
            pub const name = "layer";

            pub const Type = astal.Layer;
        };

        /// Keyboard mode of this window.
        pub const keymode = struct {
            pub const name = "keymode";

            pub const Type = astal.Keymode;
        };

        /// Which monitor to appear this window on.
        pub const gdkmonitor = struct {
            pub const name = "gdkmonitor";

            pub const Type = ?**gdk.Monitor;
        };

        pub const margin_top = struct {
            pub const name = "margin-top";

            pub const Type = c_int;
        };

        pub const margin_bottom = struct {
            pub const name = "margin-bottom";

            pub const Type = c_int;
        };

        pub const margin_left = struct {
            pub const name = "margin-left";

            pub const Type = c_int;
        };

        pub const margin_right = struct {
            pub const name = "margin-right";

            pub const Type = c_int;
        };

        pub const margin = struct {
            pub const name = "margin";

            pub const Type = c_int;
        };

        /// Which monitor to appear this window on.
        /// CAUTION: the id might not be the same mapped by the compositor.
        pub const monitor = struct {
            pub const name = "monitor";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn astal_window_new() *astal.Window;
    pub const new = astal_window_new;

    /// Get the current `gdk.Monitor` this window resides in.
    extern fn astal_window_get_current_monitor(p_self: *Window) *gdk.Monitor;
    pub const getCurrentMonitor = astal_window_get_current_monitor;

    extern fn astal_window_get_namespace(p_self: *Window) [*:0]const u8;
    pub const getNamespace = astal_window_get_namespace;

    extern fn astal_window_set_namespace(p_self: *Window, p_value: [*:0]const u8) void;
    pub const setNamespace = astal_window_set_namespace;

    extern fn astal_window_get_anchor(p_self: *Window) astal.WindowAnchor;
    pub const getAnchor = astal_window_get_anchor;

    extern fn astal_window_set_anchor(p_self: *Window, p_value: astal.WindowAnchor) void;
    pub const setAnchor = astal_window_set_anchor;

    extern fn astal_window_get_exclusivity(p_self: *Window) astal.Exclusivity;
    pub const getExclusivity = astal_window_get_exclusivity;

    extern fn astal_window_set_exclusivity(p_self: *Window, p_value: astal.Exclusivity) void;
    pub const setExclusivity = astal_window_set_exclusivity;

    extern fn astal_window_get_layer(p_self: *Window) astal.Layer;
    pub const getLayer = astal_window_get_layer;

    extern fn astal_window_set_layer(p_self: *Window, p_value: astal.Layer) void;
    pub const setLayer = astal_window_set_layer;

    extern fn astal_window_get_keymode(p_self: *Window) astal.Keymode;
    pub const getKeymode = astal_window_get_keymode;

    extern fn astal_window_set_keymode(p_self: *Window, p_value: astal.Keymode) void;
    pub const setKeymode = astal_window_set_keymode;

    extern fn astal_window_get_gdkmonitor(p_self: *Window) *gdk.Monitor;
    pub const getGdkmonitor = astal_window_get_gdkmonitor;

    extern fn astal_window_set_gdkmonitor(p_self: *Window, p_value: *gdk.Monitor) void;
    pub const setGdkmonitor = astal_window_set_gdkmonitor;

    extern fn astal_window_get_margin_top(p_self: *Window) c_int;
    pub const getMarginTop = astal_window_get_margin_top;

    extern fn astal_window_set_margin_top(p_self: *Window, p_value: c_int) void;
    pub const setMarginTop = astal_window_set_margin_top;

    extern fn astal_window_get_margin_bottom(p_self: *Window) c_int;
    pub const getMarginBottom = astal_window_get_margin_bottom;

    extern fn astal_window_set_margin_bottom(p_self: *Window, p_value: c_int) void;
    pub const setMarginBottom = astal_window_set_margin_bottom;

    extern fn astal_window_get_margin_left(p_self: *Window) c_int;
    pub const getMarginLeft = astal_window_get_margin_left;

    extern fn astal_window_set_margin_left(p_self: *Window, p_value: c_int) void;
    pub const setMarginLeft = astal_window_set_margin_left;

    extern fn astal_window_get_margin_right(p_self: *Window) c_int;
    pub const getMarginRight = astal_window_get_margin_right;

    extern fn astal_window_set_margin_right(p_self: *Window, p_value: c_int) void;
    pub const setMarginRight = astal_window_set_margin_right;

    extern fn astal_window_set_margin(p_self: *Window, p_value: c_int) void;
    pub const setMargin = astal_window_set_margin;

    extern fn astal_window_get_monitor(p_self: *Window) c_int;
    pub const getMonitor = astal_window_get_monitor;

    extern fn astal_window_set_monitor(p_self: *Window, p_value: c_int) void;
    pub const setMonitor = astal_window_set_monitor;

    extern fn astal_window_get_type() usize;
    pub const getGObjectType = astal_window_get_type;

    extern fn g_object_ref(p_self: *astal.Window) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astal.Window) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Window, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Application = extern struct {
    pub const Parent = gtk.Application;
    pub const Implements = [_]type{astalio.Application};
    pub const Class = astal.ApplicationClass;
    f_parent_instance: gtk.Application,
    f_priv: ?*astal.ApplicationPrivate,

    pub const virtual_methods = struct {
        /// Handler for an incoming request.
        pub const request = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_request: [*:0]const u8, p_conn: *gio.SocketConnection) void {
                return gobject.ext.as(Application.Class, p_class).f_request.?(gobject.ext.as(Application, p_self), p_request, p_conn);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_request: [*:0]const u8, p_conn: *gio.SocketConnection) callconv(.c) void) void {
                gobject.ext.as(Application.Class, p_class).f_request = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Get all monitors from `gdk.Display`.
        pub const monitors = struct {
            pub const name = "monitors";

            pub const Type = ?**glib.List;
        };

        /// Windows that has been added to this app using `gtk.Application.addWindow`.
        pub const windows = struct {
            pub const name = "windows";

            pub const Type = ?**glib.List;
        };

        /// Shortcut for `gtk.Settings.properties.gtk_theme_name`
        pub const gtk_theme = struct {
            pub const name = "gtk-theme";

            pub const Type = ?[*:0]u8;
        };

        /// Shortcut for `gtk.Settings.properties.gtk_icon_theme_name`
        pub const icon_theme = struct {
            pub const name = "icon-theme";

            pub const Type = ?[*:0]u8;
        };

        /// Shortcut for `gtk.Settings.properties.gtk_cursor_theme_name`
        pub const cursor_theme = struct {
            pub const name = "cursor-theme";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when a window that has been added using `gtk.Application.addWindow` changes its visibility .
        pub const window_toggled = struct {
            pub const name = "window-toggled";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_window: **gtk.Window, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Application, p_instance))),
                    gobject.signalLookup("window-toggled", Application.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_application_new() *astal.Application;
    pub const new = astal_application_new;

    /// Remove all `gtk.StyleContext` providers.
    extern fn astal_application_reset_css(p_self: *Application) void;
    pub const resetCss = astal_application_reset_css;

    /// Get a window by its `gtk.Widget.properties.name` that has been added to this app using `gtk.Application.addWindow`.
    extern fn astal_application_get_window(p_self: *Application, p_name: [*:0]const u8) ?*gtk.Window;
    pub const getWindow = astal_application_get_window;

    /// Add a new `gtk.StyleContext` provider.
    extern fn astal_application_apply_css(p_self: *Application, p_style: [*:0]const u8, p_reset: c_int) void;
    pub const applyCss = astal_application_apply_css;

    /// Shortcut for `gtk.IconTheme.addSearchPath`.
    extern fn astal_application_add_icons(p_self: *Application, p_path: ?[*:0]const u8) void;
    pub const addIcons = astal_application_add_icons;

    /// Handler for an incoming request.
    extern fn astal_application_request(p_self: *Application, p_request: [*:0]const u8, p_conn: *gio.SocketConnection) void;
    pub const request = astal_application_request;

    extern fn astal_application_get_monitors(p_self: *Application) *glib.List;
    pub const getMonitors = astal_application_get_monitors;

    extern fn astal_application_get_windows(p_self: *Application) *glib.List;
    pub const getWindows = astal_application_get_windows;

    extern fn astal_application_get_gtk_theme(p_self: *Application) [*:0]u8;
    pub const getGtkTheme = astal_application_get_gtk_theme;

    extern fn astal_application_set_gtk_theme(p_self: *Application, p_value: [*:0]const u8) void;
    pub const setGtkTheme = astal_application_set_gtk_theme;

    extern fn astal_application_get_icon_theme(p_self: *Application) [*:0]u8;
    pub const getIconTheme = astal_application_get_icon_theme;

    extern fn astal_application_set_icon_theme(p_self: *Application, p_value: [*:0]const u8) void;
    pub const setIconTheme = astal_application_set_icon_theme;

    extern fn astal_application_get_cursor_theme(p_self: *Application) [*:0]u8;
    pub const getCursorTheme = astal_application_get_cursor_theme;

    extern fn astal_application_set_cursor_theme(p_self: *Application, p_value: [*:0]const u8) void;
    pub const setCursorTheme = astal_application_set_cursor_theme;

    extern fn astal_application_get_type() usize;
    pub const getGObjectType = astal_application_get_type;

    extern fn g_object_ref(p_self: *astal.Application) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astal.Application) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Application, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BinClass = extern struct {
    pub const Instance = astal.Bin;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *BinClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BinPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BoxClass = extern struct {
    pub const Instance = astal.Box;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *BoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BoxPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SliderClass = extern struct {
    pub const Instance = astal.Slider;

    f_parent_class: gtk.ScaleClass,

    pub fn as(p_instance: *SliderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SliderPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WindowClass = extern struct {
    pub const Instance = astal.Window;

    f_parent_class: gtk.WindowClass,

    pub fn as(p_instance: *WindowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WindowPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationClass = extern struct {
    pub const Instance = astal.Application;

    f_parent_class: gtk.ApplicationClass,
    f_request: ?*const fn (p_self: *astal.Application, p_request: [*:0]const u8, p_conn: *gio.SocketConnection) callconv(.c) void,

    pub fn as(p_instance: *ApplicationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Exclusivity = enum(c_int) {
    normal = 0,
    exclusive = 1,
    ignore = 2,
    _,

    extern fn astal_exclusivity_get_type() usize;
    pub const getGObjectType = astal_exclusivity_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Layer = enum(c_int) {
    background = 0,
    bottom = 1,
    top = 2,
    overlay = 3,
    _,

    extern fn astal_layer_get_type() usize;
    pub const getGObjectType = astal_layer_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Keymode = enum(c_int) {
    none = 0,
    exclusive = 1,
    on_demand = 2,
    _,

    extern fn astal_keymode_get_type() usize;
    pub const getGObjectType = astal_keymode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WindowAnchor = packed struct(c_uint) {
    none: bool = false,
    top: bool = false,
    right: bool = false,
    left: bool = false,
    bottom: bool = false,
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

    pub const flags_none: WindowAnchor = @bitCast(@as(c_uint, 1));
    pub const flags_top: WindowAnchor = @bitCast(@as(c_uint, 2));
    pub const flags_right: WindowAnchor = @bitCast(@as(c_uint, 4));
    pub const flags_left: WindowAnchor = @bitCast(@as(c_uint, 8));
    pub const flags_bottom: WindowAnchor = @bitCast(@as(c_uint, 16));
    extern fn astal_window_anchor_get_type() usize;
    pub const getGObjectType = astal_window_anchor_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MAJOR_VERSION = 4;
pub const MINOR_VERSION = 0;
pub const MICRO_VERSION = 0;
pub const VERSION = "4.0.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
