pub const ext = @import("ext.zig");
const astalnotifd = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// Notification action.
pub const Action = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalnotifd.ActionClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalnotifd.ActionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Id of this action.
        pub const id = struct {
            pub const name = "id";

            pub const Type = ?[*:0]u8;
        };

        /// Label of this action that should be displayed to user.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when the notification this action was added to invoked this action.
        pub const invoked = struct {
            pub const name = "invoked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Action, p_instance))),
                    gobject.signalLookup("invoked", Action.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_notifd_action_new(p_id: [*:0]const u8, p_label: [*:0]const u8) *astalnotifd.Action;
    pub const new = astal_notifd_action_new;

    /// Invoke this action. Note that this method just notifies the client that this action was invoked by the user. If for example this notification
    /// persists through the lifetime of the sending application this action will have no effect.
    extern fn astal_notifd_action_invoke(p_self: *Action) void;
    pub const invoke = astal_notifd_action_invoke;

    extern fn astal_notifd_action_get_id(p_self: *Action) [*:0]const u8;
    pub const getId = astal_notifd_action_get_id;

    extern fn astal_notifd_action_set_id(p_self: *Action, p_value: [*:0]const u8) void;
    pub const setId = astal_notifd_action_set_id;

    extern fn astal_notifd_action_get_label(p_self: *Action) [*:0]const u8;
    pub const getLabel = astal_notifd_action_get_label;

    extern fn astal_notifd_action_set_label(p_self: *Action, p_value: [*:0]const u8) void;
    pub const setLabel = astal_notifd_action_set_label;

    extern fn astal_notifd_action_get_type() usize;
    pub const getGObjectType = astal_notifd_action_get_type;

    extern fn g_object_ref(p_self: *astalnotifd.Action) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalnotifd.Action) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Action, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The Notification daemon.
/// This class queues up to become the next daemon, while acting as a proxy in the meantime.
pub const Notifd = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalnotifd.NotifdClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalnotifd.NotifdPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Ignore the timeout specified by incoming notifications. By default notifications can specify a timeout in milliseconds after which the daemon
        /// will resolve them even without user input.
        pub const ignore_timeout = struct {
            pub const name = "ignore-timeout";

            pub const Type = c_int;
        };

        /// Indicate to frontends to not show popups to the user. This property does not have any effect on its own, its merely a value to use between the
        /// daemon process and proxies for frontends to use.
        pub const dont_disturb = struct {
            pub const name = "dont-disturb";

            pub const Type = c_int;
        };

        /// Timeout used for notifications that do not specify a timeout and let the server decide. Negative values result in no timeout. By default this
        /// is -1.
        pub const default_timeout = struct {
            pub const name = "default-timeout";

            pub const Type = c_int;
        };

        /// List of currently unresolved notifications.
        pub const notifications = struct {
            pub const name = "notifications";

            pub const Type = ?**glib.List;
        };
    };

    pub const signals = struct {
        /// Emitted when the daemon receives a `astalnotifd.Notification`.
        pub const notified = struct {
            pub const name = "notified";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_id: c_uint, p_replaced: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Notifd, p_instance))),
                    gobject.signalLookup("notified", Notifd.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a `astalnotifd.Notification` is resolved.
        pub const resolved = struct {
            pub const name = "resolved";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_id: c_uint, p_reason: astalnotifd.ClosedReason, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Notifd, p_instance))),
                    gobject.signalLookup("resolved", Notifd.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Get the singleton instance
    extern fn astal_notifd_notifd_get_default() *astalnotifd.Notifd;
    pub const getDefault = astal_notifd_notifd_get_default;

    extern fn astal_notifd_notifd_new() *astalnotifd.Notifd;
    pub const new = astal_notifd_notifd_new;

    /// Gets the `astalnotifd.Notification` with id or null if there is no such Notification.
    extern fn astal_notifd_notifd_get_notification(p_self: *Notifd, p_id: c_uint) ?*astalnotifd.Notification;
    pub const getNotification = astal_notifd_notifd_get_notification;

    extern fn astal_notifd_notifd_get_ignore_timeout(p_self: *Notifd) c_int;
    pub const getIgnoreTimeout = astal_notifd_notifd_get_ignore_timeout;

    extern fn astal_notifd_notifd_set_ignore_timeout(p_self: *Notifd, p_value: c_int) void;
    pub const setIgnoreTimeout = astal_notifd_notifd_set_ignore_timeout;

    extern fn astal_notifd_notifd_get_dont_disturb(p_self: *Notifd) c_int;
    pub const getDontDisturb = astal_notifd_notifd_get_dont_disturb;

    extern fn astal_notifd_notifd_set_dont_disturb(p_self: *Notifd, p_value: c_int) void;
    pub const setDontDisturb = astal_notifd_notifd_set_dont_disturb;

    extern fn astal_notifd_notifd_get_default_timeout(p_self: *Notifd) c_int;
    pub const getDefaultTimeout = astal_notifd_notifd_get_default_timeout;

    extern fn astal_notifd_notifd_set_default_timeout(p_self: *Notifd, p_value: c_int) void;
    pub const setDefaultTimeout = astal_notifd_notifd_set_default_timeout;

    extern fn astal_notifd_notifd_get_notifications(p_self: *Notifd) *glib.List;
    pub const getNotifications = astal_notifd_notifd_get_notifications;

    extern fn astal_notifd_notifd_get_type() usize;
    pub const getGObjectType = astal_notifd_notifd_get_type;

    extern fn g_object_ref(p_self: *astalnotifd.Notifd) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalnotifd.Notifd) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Notifd, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class representing a notification.
pub const Notification = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalnotifd.NotificationClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalnotifd.NotificationPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// State of the notification.
        pub const state = struct {
            pub const name = "state";

            pub const Type = astalnotifd.State;
        };

        /// Unix time of when the notification was sent or received.
        pub const time = struct {
            pub const name = "time";

            pub const Type = i64;
        };

        /// Id of the notification.
        pub const id = struct {
            pub const name = "id";

            pub const Type = u32;
        };

        /// Name of the sending application.
        pub const app_name = struct {
            pub const name = "app-name";

            pub const Type = ?[*:0]u8;
        };

        /// Icon name of the sending application.
        pub const app_icon = struct {
            pub const name = "app-icon";

            pub const Type = ?[*:0]u8;
        };

        /// Single line overview of the notification.
        pub const summary = struct {
            pub const name = "summary";

            pub const Type = ?[*:0]u8;
        };

        /// Multi-line body of text, where each line is a paragraph. May contain markup.
        pub const body = struct {
            pub const name = "body";

            pub const Type = ?[*:0]u8;
        };

        /// Time in milliseconds after the notification expires.
        pub const expire_timeout = struct {
            pub const name = "expire-timeout";

            pub const Type = i32;
        };

        /// List of `astalnotifd.Action` of the notification. Can be invoked by calling `astalnotifd.Notification.invoke` with
        /// the action's id.
        pub const actions = struct {
            pub const name = "actions";

            pub const Type = ?**glib.List;
        };

        /// Hints of the notification. Hints are a way to provide extra data to servers. To set hints on a `DRAFT` Notification use [method@
        /// AstalNotifd.Notification.set_hint] or the property setters for standard hints.
        pub const hints = struct {
            pub const name = "hints";

            pub const Type = ?**glib.Variant;
        };

        /// Standard `image-path` hint. Path of an image
        pub const image = struct {
            pub const name = "image";

            pub const Type = ?[*:0]u8;
        };

        /// Standard `action-icons` hint. Indicates whether `astalnotifd.Action` identifier should be interpreted as a named icon.
        pub const action_icons = struct {
            pub const name = "action-icons";

            pub const Type = c_int;
        };

        /// Standard `category` hint. [](https://specifications.freedesktop.org/notification-spec/latest/categories.html)
        pub const category = struct {
            pub const name = "category";

            pub const Type = ?[*:0]u8;
        };

        /// Standard `desktop-entry` hint. Specifies the name of the desktop filename representing the calling program.
        pub const desktop_entry = struct {
            pub const name = "desktop-entry";

            pub const Type = ?[*:0]u8;
        };

        /// Standard `resident` hint. Indicates whether notification is kept after action invocation.
        pub const resident = struct {
            pub const name = "resident";

            pub const Type = c_int;
        };

        /// Standard `sound-file` hint. The path to a sound file to play when the notification pops up.
        pub const sound_file = struct {
            pub const name = "sound-file";

            pub const Type = ?[*:0]u8;
        };

        /// Standard `sound-name` hint. A themeable named sound from to play when the notification pops up
        pub const sound_name = struct {
            pub const name = "sound-name";

            pub const Type = ?[*:0]u8;
        };

        /// Standard `suppress-sound` hint. Indicates to suppress playing any sounds.
        pub const suppress_sound = struct {
            pub const name = "suppress-sound";

            pub const Type = c_int;
        };

        /// Standard `transient` hint. Indicates that the notification should be excluded from persistency.
        pub const transient = struct {
            pub const name = "transient";

            pub const Type = c_int;
        };

        /// Standard `x` hint. Specifies the X location on the screen that the notification should point to. The "y" hint must also be specified.
        ///
        pub const x = struct {
            pub const name = "x";

            pub const Type = c_int;
        };

        /// Standard `y` hint. Specifies the Y location on the screen that the notification should point to. The "x" hint must also be specified.
        ///
        pub const y = struct {
            pub const name = "y";

            pub const Type = c_int;
        };

        /// Standard `urgency` hint. `astalnotifd.Urgency` level of the notification.
        pub const urgency = struct {
            pub const name = "urgency";

            pub const Type = astalnotifd.Urgency;
        };
    };

    pub const signals = struct {
        /// Emitted when this this notification is resolved.
        pub const resolved = struct {
            pub const name = "resolved";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_reason: astalnotifd.ClosedReason, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Notification, p_instance))),
                    gobject.signalLookup("resolved", Notification.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `astalnotifd.Action` of this notification is invoked.
        pub const invoked = struct {
            pub const name = "invoked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_action_id: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Notification, p_instance))),
                    gobject.signalLookup("invoked", Notification.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_notifd_notification_new() *astalnotifd.Notification;
    pub const new = astal_notifd_notification_new;

    /// Resolve this notification with `astalnotifd.@"ClosedReason.DISMISSED_BY_USER"`.
    extern fn astal_notifd_notification_dismiss(p_self: *Notification) void;
    pub const dismiss = astal_notifd_notification_dismiss;

    /// Resolve this notification with `astalnotifd.@"ClosedReason.EXPIRED"`. Note that there should be no reason to use this method because
    /// expiration should be left to the daemon.
    extern fn astal_notifd_notification_expire(p_self: *Notification) void;
    pub const expire = astal_notifd_notification_expire;

    /// Invoke an `astalnotifd.Action` of this notification.
    extern fn astal_notifd_notification_invoke(p_self: *Notification, p_action_id: [*:0]const u8) void;
    pub const invoke = astal_notifd_notification_invoke;

    extern fn astal_notifd_notification_add_action(p_self: *Notification, p_action: *astalnotifd.Action) *astalnotifd.Notification;
    pub const addAction = astal_notifd_notification_add_action;

    extern fn astal_notifd_notification_set_hint(p_self: *Notification, p_name: [*:0]const u8, p_value: *glib.Variant) *astalnotifd.Notification;
    pub const setHint = astal_notifd_notification_set_hint;

    extern fn astal_notifd_notification_get_hint(p_self: *Notification, p_name: [*:0]const u8) ?*glib.Variant;
    pub const getHint = astal_notifd_notification_get_hint;

    extern fn astal_notifd_notification_get_state(p_self: *Notification) astalnotifd.State;
    pub const getState = astal_notifd_notification_get_state;

    extern fn astal_notifd_notification_get_time(p_self: *Notification) i64;
    pub const getTime = astal_notifd_notification_get_time;

    extern fn astal_notifd_notification_get_id(p_self: *Notification) u32;
    pub const getId = astal_notifd_notification_get_id;

    extern fn astal_notifd_notification_set_id(p_self: *Notification, p_value: u32) void;
    pub const setId = astal_notifd_notification_set_id;

    extern fn astal_notifd_notification_get_app_name(p_self: *Notification) [*:0]const u8;
    pub const getAppName = astal_notifd_notification_get_app_name;

    extern fn astal_notifd_notification_set_app_name(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setAppName = astal_notifd_notification_set_app_name;

    extern fn astal_notifd_notification_get_app_icon(p_self: *Notification) [*:0]const u8;
    pub const getAppIcon = astal_notifd_notification_get_app_icon;

    extern fn astal_notifd_notification_set_app_icon(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setAppIcon = astal_notifd_notification_set_app_icon;

    extern fn astal_notifd_notification_get_summary(p_self: *Notification) [*:0]const u8;
    pub const getSummary = astal_notifd_notification_get_summary;

    extern fn astal_notifd_notification_set_summary(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setSummary = astal_notifd_notification_set_summary;

    extern fn astal_notifd_notification_get_body(p_self: *Notification) [*:0]const u8;
    pub const getBody = astal_notifd_notification_get_body;

    extern fn astal_notifd_notification_set_body(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setBody = astal_notifd_notification_set_body;

    extern fn astal_notifd_notification_get_expire_timeout(p_self: *Notification) i32;
    pub const getExpireTimeout = astal_notifd_notification_get_expire_timeout;

    extern fn astal_notifd_notification_set_expire_timeout(p_self: *Notification, p_value: i32) void;
    pub const setExpireTimeout = astal_notifd_notification_set_expire_timeout;

    extern fn astal_notifd_notification_get_actions(p_self: *Notification) *glib.List;
    pub const getActions = astal_notifd_notification_get_actions;

    extern fn astal_notifd_notification_get_hints(p_self: *Notification) *glib.Variant;
    pub const getHints = astal_notifd_notification_get_hints;

    extern fn astal_notifd_notification_get_image(p_self: *Notification) [*:0]u8;
    pub const getImage = astal_notifd_notification_get_image;

    extern fn astal_notifd_notification_set_image(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setImage = astal_notifd_notification_set_image;

    extern fn astal_notifd_notification_get_action_icons(p_self: *Notification) c_int;
    pub const getActionIcons = astal_notifd_notification_get_action_icons;

    extern fn astal_notifd_notification_set_action_icons(p_self: *Notification, p_value: c_int) void;
    pub const setActionIcons = astal_notifd_notification_set_action_icons;

    extern fn astal_notifd_notification_get_category(p_self: *Notification) [*:0]u8;
    pub const getCategory = astal_notifd_notification_get_category;

    extern fn astal_notifd_notification_set_category(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setCategory = astal_notifd_notification_set_category;

    extern fn astal_notifd_notification_get_desktop_entry(p_self: *Notification) [*:0]u8;
    pub const getDesktopEntry = astal_notifd_notification_get_desktop_entry;

    extern fn astal_notifd_notification_set_desktop_entry(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setDesktopEntry = astal_notifd_notification_set_desktop_entry;

    extern fn astal_notifd_notification_get_resident(p_self: *Notification) c_int;
    pub const getResident = astal_notifd_notification_get_resident;

    extern fn astal_notifd_notification_set_resident(p_self: *Notification, p_value: c_int) void;
    pub const setResident = astal_notifd_notification_set_resident;

    extern fn astal_notifd_notification_get_sound_file(p_self: *Notification) [*:0]u8;
    pub const getSoundFile = astal_notifd_notification_get_sound_file;

    extern fn astal_notifd_notification_set_sound_file(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setSoundFile = astal_notifd_notification_set_sound_file;

    extern fn astal_notifd_notification_get_sound_name(p_self: *Notification) [*:0]u8;
    pub const getSoundName = astal_notifd_notification_get_sound_name;

    extern fn astal_notifd_notification_set_sound_name(p_self: *Notification, p_value: [*:0]const u8) void;
    pub const setSoundName = astal_notifd_notification_set_sound_name;

    extern fn astal_notifd_notification_get_suppress_sound(p_self: *Notification) c_int;
    pub const getSuppressSound = astal_notifd_notification_get_suppress_sound;

    extern fn astal_notifd_notification_set_suppress_sound(p_self: *Notification, p_value: c_int) void;
    pub const setSuppressSound = astal_notifd_notification_set_suppress_sound;

    extern fn astal_notifd_notification_get_transient(p_self: *Notification) c_int;
    pub const getTransient = astal_notifd_notification_get_transient;

    extern fn astal_notifd_notification_set_transient(p_self: *Notification, p_value: c_int) void;
    pub const setTransient = astal_notifd_notification_set_transient;

    extern fn astal_notifd_notification_get_x(p_self: *Notification) c_int;
    pub const getX = astal_notifd_notification_get_x;

    extern fn astal_notifd_notification_set_x(p_self: *Notification, p_value: c_int) void;
    pub const setX = astal_notifd_notification_set_x;

    extern fn astal_notifd_notification_get_y(p_self: *Notification) c_int;
    pub const getY = astal_notifd_notification_get_y;

    extern fn astal_notifd_notification_set_y(p_self: *Notification, p_value: c_int) void;
    pub const setY = astal_notifd_notification_set_y;

    extern fn astal_notifd_notification_get_urgency(p_self: *Notification) astalnotifd.Urgency;
    pub const getUrgency = astal_notifd_notification_get_urgency;

    extern fn astal_notifd_notification_set_urgency(p_self: *Notification, p_value: astalnotifd.Urgency) void;
    pub const setUrgency = astal_notifd_notification_set_urgency;

    extern fn astal_notifd_notification_get_type() usize;
    pub const getGObjectType = astal_notifd_notification_get_type;

    extern fn g_object_ref(p_self: *astalnotifd.Notification) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalnotifd.Notification) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Notification, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ActionClass = extern struct {
    pub const Instance = astalnotifd.Action;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ActionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ActionPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NotifdClass = extern struct {
    pub const Instance = astalnotifd.Notifd;

    f_parent_class: gobject.ObjectClass,
    f_notified: ?*const fn (p_self: *astalnotifd.Notifd, p_id: c_uint, p_replaced: c_int) callconv(.c) void,
    f_resolved: ?*const fn (p_self: *astalnotifd.Notifd, p_id: c_uint, p_reason: astalnotifd.ClosedReason) callconv(.c) void,

    pub fn as(p_instance: *NotifdClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NotifdPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NotificationClass = extern struct {
    pub const Instance = astalnotifd.Notification;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *NotificationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NotificationPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Urgency = enum(c_int) {
    low = 0,
    normal = 1,
    critical = 2,
    _,

    extern fn astal_notifd_urgency_get_type() usize;
    pub const getGObjectType = astal_notifd_urgency_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClosedReason = enum(c_int) {
    expired = 1,
    dismissed_by_user = 2,
    closed = 3,
    undefined = 4,
    _,

    extern fn astal_notifd_closed_reason_get_type() usize;
    pub const getGObjectType = astal_notifd_closed_reason_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const State = enum(c_int) {
    draft = 0,
    sent = 1,
    received = 2,
    _,

    extern fn astal_notifd_state_get_type() usize;
    pub const getGObjectType = astal_notifd_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Get the singleton instance of `astalnotifd.Notifd`
extern fn astal_notifd_get_default() *astalnotifd.Notifd;
pub const getDefault = astal_notifd_get_default;

/// Send a notification. This function does not depend on Notifd and can be used with any notification server. The [class@
/// AstalNotifd.Notification] passed to this function is never the same instance that `astalnotifd.Notifd.getNotification` returns. This
/// function will set the state of the passed notification from `DRAFT` to `SENT` after which the notification can no longer be mutated.
extern fn astal_notifd_send_notification(p_notification: *astalnotifd.Notification, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
pub const sendNotification = astal_notifd_send_notification;

extern fn astal_notifd_send_notification_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
pub const sendNotificationFinish = astal_notifd_send_notification_finish;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
