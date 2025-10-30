pub const ext = @import("ext.zig");
const astaltray = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const gdkpixbuf = @import("gdkpixbuf2");
pub const Tray = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astaltray.TrayClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astaltray.TrayPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// List of currently registered tray items
        pub const items = struct {
            pub const name = "items";

            pub const Type = ?**glib.List;
        };
    };

    pub const signals = struct {
        /// emitted when a new tray item was added.
        pub const item_added = struct {
            pub const name = "item-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_item_id: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Tray, p_instance))),
                    gobject.signalLookup("item-added", Tray.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// emitted when a tray item was removed.
        pub const item_removed = struct {
            pub const name = "item-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_item_id: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Tray, p_instance))),
                    gobject.signalLookup("item-removed", Tray.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Get the singleton instance of `astaltray.Tray`
    extern fn astal_tray_tray_get_default() *astaltray.Tray;
    pub const getDefault = astal_tray_tray_get_default;

    extern fn astal_tray_tray_new() *astaltray.Tray;
    pub const new = astal_tray_tray_new;

    /// gets the TrayItem with the given item-id.
    extern fn astal_tray_tray_get_item(p_self: *Tray, p_item_id: [*:0]const u8) *astaltray.TrayItem;
    pub const getItem = astal_tray_tray_get_item;

    extern fn astal_tray_tray_get_items(p_self: *Tray) *glib.List;
    pub const getItems = astal_tray_tray_get_items;

    extern fn astal_tray_tray_get_type() usize;
    pub const getGObjectType = astal_tray_tray_get_type;

    extern fn g_object_ref(p_self: *astaltray.Tray) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astaltray.Tray) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Tray, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TrayItem = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astaltray.TrayItemClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astaltray.TrayItemPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The Title of the TrayItem
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// The category this item belongs to
        pub const category = struct {
            pub const name = "category";

            pub const Type = astaltray.Category;
        };

        /// The current status of this item
        pub const status = struct {
            pub const name = "status";

            pub const Type = astaltray.Status;
        };

        /// The tooltip of this item
        pub const tooltip = struct {
            pub const name = "tooltip";

            pub const Type = ?**astaltray.Tooltip;
        };

        /// A markup representation of the tooltip. This is basically equvivalent to `tooltip.title \n tooltip.description`
        pub const tooltip_markup = struct {
            pub const name = "tooltip-markup";

            pub const Type = ?[*:0]u8;
        };

        /// A text representation of the tooltip. This is basically equvivalent to `tooltip.title \n tooltip.description.`
        pub const tooltip_text = struct {
            pub const name = "tooltip-text";

            pub const Type = ?[*:0]u8;
        };

        /// the id of the item. This id is specified by the tray app.
        pub const id = struct {
            pub const name = "id";

            pub const Type = ?[*:0]u8;
        };

        /// If set, this only supports the menu, so showing the menu should be prefered over calling `astaltray.TrayItem.activate`.
        pub const is_menu = struct {
            pub const name = "is-menu";

            pub const Type = c_int;
        };

        /// The icon theme path, where to look for the `astaltray.TrayItem.properties.icon_name`. It is recommended to use the [property@
        /// AstalTray.TrayItem:gicon] property, which does the icon lookups for you.
        pub const icon_theme_path = struct {
            pub const name = "icon-theme-path";

            pub const Type = ?[*:0]u8;
        };

        /// The name of the icon. This should be looked up in the `astaltray.TrayItem.properties.icon_theme_path` if set or in the currently used icon
        /// theme otherwise. It is recommended to use the `astaltray.TrayItem.properties.gicon` property, which does the icon lookups for you.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// A pixbuf containing the icon. It is recommended to use the `astaltray.TrayItem.properties.gicon` property, which does the icon lookups for
        /// you.
        pub const icon_pixbuf = struct {
            pub const name = "icon-pixbuf";

            pub const Type = ?**gdkpixbuf.Pixbuf;
        };

        /// Contains the items icon. This property is intended to be used with the gicon property of the Icon widget and the recommended way to display the
        /// icon. This property unifies the `astaltray.TrayItem.properties.icon_name`, `astaltray.TrayItem.properties.icon_theme_path` and [property
        /// `AstalTray`.TrayItem:icon-pixbuf] properties.
        pub const gicon = struct {
            pub const name = "gicon";

            pub const Type = ?**gio.Icon;
        };

        /// The id of the item used to uniquely identify the TrayItems by this lib.
        pub const item_id = struct {
            pub const name = "item-id";

            pub const Type = ?[*:0]u8;
        };

        /// The object path to the dbusmenu
        pub const menu_path = struct {
            pub const name = "menu-path";

            pub const Type = ?*u8;
        };

        /// The MenuModel describing the menu for this TrayItem to be used with a MenuButton or PopoverMenu. The actions for this menu are defined in
        /// `astaltray.TrayItem.properties.action_group`.
        pub const menu_model = struct {
            pub const name = "menu-model";

            pub const Type = ?**gio.MenuModel;
        };

        /// The ActionGroup containing the actions for the menu. All actions have the `dbusmenu` prefix and are setup to work with the [property@
        /// AstalTray.TrayItem:menu-model]. Make sure to insert this action group into a parent widget of the menu, eg the MenuButton for which the MenuModel for
        /// this TrayItem is set.
        pub const action_group = struct {
            pub const name = "action-group";

            pub const Type = ?**gio.ActionGroup;
        };
    };

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TrayItem, p_instance))),
                    gobject.signalLookup("changed", TrayItem.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const ready = struct {
            pub const name = "ready";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TrayItem, p_instance))),
                    gobject.signalLookup("ready", TrayItem.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// tells the tray app that its menu is about to be opened, so it can update the menu if needed. You should call this method before openening the
    /// menu.
    extern fn astal_tray_tray_item_about_to_show(p_self: *TrayItem) void;
    pub const aboutToShow = astal_tray_tray_item_about_to_show;

    /// Send an activate request to the tray app.
    extern fn astal_tray_tray_item_activate(p_self: *TrayItem, p_x: c_int, p_y: c_int) void;
    pub const activate = astal_tray_tray_item_activate;

    /// Send a secondary activate request to the tray app.
    extern fn astal_tray_tray_item_secondary_activate(p_self: *TrayItem, p_x: c_int, p_y: c_int) void;
    pub const secondaryActivate = astal_tray_tray_item_secondary_activate;

    /// Send a scroll request to the tray app. valid values for the orientation are "horizontal" and "vertical".
    extern fn astal_tray_tray_item_scroll(p_self: *TrayItem, p_delta: c_int, p_orientation: [*:0]const u8) void;
    pub const scroll = astal_tray_tray_item_scroll;

    extern fn astal_tray_tray_item_to_json_string(p_self: *TrayItem) [*:0]u8;
    pub const toJsonString = astal_tray_tray_item_to_json_string;

    extern fn astal_tray_tray_item_get_title(p_self: *TrayItem) [*:0]const u8;
    pub const getTitle = astal_tray_tray_item_get_title;

    extern fn astal_tray_tray_item_get_category(p_self: *TrayItem) astaltray.Category;
    pub const getCategory = astal_tray_tray_item_get_category;

    extern fn astal_tray_tray_item_get_status(p_self: *TrayItem) astaltray.Status;
    pub const getStatus = astal_tray_tray_item_get_status;

    extern fn astal_tray_tray_item_get_tooltip(p_self: *TrayItem) ?*astaltray.Tooltip;
    pub const getTooltip = astal_tray_tray_item_get_tooltip;

    extern fn astal_tray_tray_item_get_tooltip_markup(p_self: *TrayItem) [*:0]u8;
    pub const getTooltipMarkup = astal_tray_tray_item_get_tooltip_markup;

    extern fn astal_tray_tray_item_get_tooltip_text(p_self: *TrayItem) [*:0]u8;
    pub const getTooltipText = astal_tray_tray_item_get_tooltip_text;

    extern fn astal_tray_tray_item_get_id(p_self: *TrayItem) [*:0]const u8;
    pub const getId = astal_tray_tray_item_get_id;

    extern fn astal_tray_tray_item_get_is_menu(p_self: *TrayItem) c_int;
    pub const getIsMenu = astal_tray_tray_item_get_is_menu;

    extern fn astal_tray_tray_item_get_icon_theme_path(p_self: *TrayItem) [*:0]const u8;
    pub const getIconThemePath = astal_tray_tray_item_get_icon_theme_path;

    extern fn astal_tray_tray_item_get_icon_name(p_self: *TrayItem) [*:0]u8;
    pub const getIconName = astal_tray_tray_item_get_icon_name;

    extern fn astal_tray_tray_item_get_icon_pixbuf(p_self: *TrayItem) *gdkpixbuf.Pixbuf;
    pub const getIconPixbuf = astal_tray_tray_item_get_icon_pixbuf;

    extern fn astal_tray_tray_item_get_gicon(p_self: *TrayItem) *gio.Icon;
    pub const getGicon = astal_tray_tray_item_get_gicon;

    extern fn astal_tray_tray_item_get_item_id(p_self: *TrayItem) [*:0]const u8;
    pub const getItemId = astal_tray_tray_item_get_item_id;

    extern fn astal_tray_tray_item_get_menu_path(p_self: *TrayItem) *const u8;
    pub const getMenuPath = astal_tray_tray_item_get_menu_path;

    extern fn astal_tray_tray_item_get_menu_model(p_self: *TrayItem) ?*gio.MenuModel;
    pub const getMenuModel = astal_tray_tray_item_get_menu_model;

    extern fn astal_tray_tray_item_get_action_group(p_self: *TrayItem) ?*gio.ActionGroup;
    pub const getActionGroup = astal_tray_tray_item_get_action_group;

    extern fn astal_tray_tray_item_get_type() usize;
    pub const getGObjectType = astal_tray_tray_item_get_type;

    extern fn g_object_ref(p_self: *astaltray.TrayItem) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astaltray.TrayItem) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TrayItem, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TrayClass = extern struct {
    pub const Instance = astaltray.Tray;

    f_parent_class: gobject.ObjectClass,
    f_item_added: ?*const fn (p_self: *astaltray.Tray, p_item_id: [*:0]const u8) callconv(.c) void,
    f_item_removed: ?*const fn (p_self: *astaltray.Tray, p_item_id: [*:0]const u8) callconv(.c) void,

    pub fn as(p_instance: *TrayClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TrayPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TrayItemClass = extern struct {
    pub const Instance = astaltray.TrayItem;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *TrayItemClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TrayItemPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Pixmap = extern struct {
    f_width: c_int,
    f_height: c_int,
    f_bytes: ?[*]u8,
    f_bytes_length1: c_int,

    extern fn astal_tray_pixmap_get_type() usize;
    pub const getGObjectType = astal_tray_pixmap_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Tooltip = extern struct {
    f_icon_name: ?[*:0]u8,
    f_icon: ?[*]astaltray.Pixmap,
    f_icon_length1: c_int,
    f_title: ?[*:0]u8,
    f_description: ?[*:0]u8,

    extern fn astal_tray_tooltip_get_type() usize;
    pub const getGObjectType = astal_tray_tooltip_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Category = enum(c_int) {
    application = 0,
    communications = 1,
    system = 2,
    hardware = 3,
    _,

    extern fn astal_tray_category_get_type() usize;
    pub const getGObjectType = astal_tray_category_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Status = enum(c_int) {
    passive = 0,
    active = 1,
    needs_attention = 2,
    _,

    extern fn astal_tray_status_get_type() usize;
    pub const getGObjectType = astal_tray_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn astal_tray_category_to_nick(p_self: astaltray.Category) [*:0]u8;
pub const categoryToNick = astal_tray_category_to_nick;

extern fn astal_tray_category_from_string(p_value: [*:0]const u8, p_error: ?*?*glib.Error) astaltray.Category;
pub const categoryFromString = astal_tray_category_from_string;

extern fn astal_tray_status_to_nick(p_self: astaltray.Status) [*:0]u8;
pub const statusToNick = astal_tray_status_to_nick;

extern fn astal_tray_status_from_string(p_value: [*:0]const u8, p_error: ?*?*glib.Error) astaltray.Status;
pub const statusFromString = astal_tray_status_from_string;

/// Get the singleton instance of `astaltray.Tray`
extern fn astal_tray_get_default() *astaltray.Tray;
pub const getDefault = astal_tray_get_default;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
