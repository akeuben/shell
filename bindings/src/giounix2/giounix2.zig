pub const ext = @import("ext.zig");
const giounix = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// `GDesktopAppInfo` is an implementation of `gio.AppInfo` based on
/// desktop files.
///
/// Note that `<gio/gdesktopappinfo.h>` belongs to the UNIX-specific
/// GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
/// file or the `GioUnix-2.0` GIR namespace when using it.
pub const DesktopAppInfo = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.AppInfo};
    pub const Class = giounix.DesktopAppInfoClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The origin filename of this `gio.DesktopAppInfo`
        pub const filename = struct {
            pub const name = "filename";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Gets the user-visible display name of the
    /// [‘additional application actions’](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s11.html)
    /// specified by `action_name`.
    ///
    /// This corresponds to the `Name` key within the keyfile group for the
    /// action.
    extern fn g_desktop_app_info_get_action_name(p_info: *gio.DesktopAppInfo, p_action_name: [*:0]const u8) [*:0]u8;
    pub const getActionName = g_desktop_app_info_get_action_name;

    /// Looks up a boolean value in the keyfile backing `info`.
    ///
    /// The `key` is looked up in the `Desktop Entry` group.
    extern fn g_desktop_app_info_get_boolean(p_info: *gio.DesktopAppInfo, p_key: [*:0]const u8) c_int;
    pub const getBoolean = g_desktop_app_info_get_boolean;

    /// Gets the categories from the desktop file.
    extern fn g_desktop_app_info_get_categories(p_info: *gio.DesktopAppInfo) ?[*:0]const u8;
    pub const getCategories = g_desktop_app_info_get_categories;

    /// When `info` was created from a known filename, return it.  In some
    /// situations such as a `gio.DesktopAppInfo` returned from
    /// `gio.DesktopAppInfo.newFromKeyfile`, this function will return `NULL`.
    extern fn g_desktop_app_info_get_filename(p_info: *gio.DesktopAppInfo) ?[*:0]const u8;
    pub const getFilename = g_desktop_app_info_get_filename;

    /// Gets the generic name from the desktop file.
    extern fn g_desktop_app_info_get_generic_name(p_info: *gio.DesktopAppInfo) ?[*:0]const u8;
    pub const getGenericName = g_desktop_app_info_get_generic_name;

    /// Gets all applications that implement `interface`.
    ///
    /// An application implements an interface if that interface is listed in
    /// the `Implements` line of the desktop file of the application.
    extern fn g_desktop_app_info_get_implementations(p_interface: [*:0]const u8) *glib.List;
    pub const getImplementations = g_desktop_app_info_get_implementations;

    /// A desktop file is hidden if the
    /// [`Hidden` key](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html`key`-hidden)
    /// in it is set to `True`.
    extern fn g_desktop_app_info_get_is_hidden(p_info: *gio.DesktopAppInfo) c_int;
    pub const getIsHidden = g_desktop_app_info_get_is_hidden;

    /// Gets the keywords from the desktop file.
    extern fn g_desktop_app_info_get_keywords(p_info: *gio.DesktopAppInfo) [*]const [*:0]const u8;
    pub const getKeywords = g_desktop_app_info_get_keywords;

    /// Looks up a localized string value in the keyfile backing `info`
    /// translated to the current locale.
    ///
    /// The `key` is looked up in the `Desktop Entry` group.
    extern fn g_desktop_app_info_get_locale_string(p_info: *gio.DesktopAppInfo, p_key: [*:0]const u8) ?[*:0]u8;
    pub const getLocaleString = g_desktop_app_info_get_locale_string;

    /// Gets the value of the
    /// [`NoDisplay` key](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html`key`-nodisplay)
    ///  which helps determine if the application info should be shown in menus. See
    /// `G_KEY_FILE_DESKTOP_KEY_NO_DISPLAY` and `gio.AppInfo.shouldShow`.
    extern fn g_desktop_app_info_get_nodisplay(p_info: *gio.DesktopAppInfo) c_int;
    pub const getNodisplay = g_desktop_app_info_get_nodisplay;

    /// Checks if the application info should be shown in menus that list available
    /// applications for a specific name of the desktop, based on the
    /// [`OnlyShowIn`](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html`key`-onlyshowin)
    /// and [`NotShowIn`](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html`key`-notshowin)
    /// keys.
    ///
    /// `desktop_env` should typically be given as `NULL`, in which case the
    /// `XDG_CURRENT_DESKTOP` environment variable is consulted.  If you want
    /// to override the default mechanism then you may specify `desktop_env`,
    /// but this is not recommended.
    ///
    /// Note that `gio.AppInfo.shouldShow` for `info` will include this check
    /// (with `NULL` for `desktop_env`) as well as additional checks.
    extern fn g_desktop_app_info_get_show_in(p_info: *gio.DesktopAppInfo, p_desktop_env: ?[*:0]const u8) c_int;
    pub const getShowIn = g_desktop_app_info_get_show_in;

    /// Retrieves the `StartupWMClass` field from `info`. This represents the
    /// `WM_CLASS` property of the main window of the application, if launched
    /// through `info`.
    extern fn g_desktop_app_info_get_startup_wm_class(p_info: *gio.DesktopAppInfo) ?[*:0]const u8;
    pub const getStartupWmClass = g_desktop_app_info_get_startup_wm_class;

    /// Looks up a string value in the keyfile backing `info`.
    ///
    /// The `key` is looked up in the `Desktop Entry` group.
    extern fn g_desktop_app_info_get_string(p_info: *gio.DesktopAppInfo, p_key: [*:0]const u8) ?[*:0]u8;
    pub const getString = g_desktop_app_info_get_string;

    /// Looks up a string list value in the keyfile backing `info`.
    ///
    /// The `key` is looked up in the `Desktop Entry` group.
    extern fn g_desktop_app_info_get_string_list(p_info: *gio.DesktopAppInfo, p_key: [*:0]const u8, p_length: ?*usize) [*:null]?[*:0]u8;
    pub const getStringList = g_desktop_app_info_get_string_list;

    /// Returns whether `key` exists in the `Desktop Entry` group
    /// of the keyfile backing `info`.
    extern fn g_desktop_app_info_has_key(p_info: *gio.DesktopAppInfo, p_key: [*:0]const u8) c_int;
    pub const hasKey = g_desktop_app_info_has_key;

    /// Activates the named application action.
    ///
    /// You may only call this function on action names that were
    /// returned from `gio.DesktopAppInfo.listActions`.
    ///
    /// Note that if the main entry of the desktop file indicates that the
    /// application supports startup notification, and `launch_context` is
    /// non-`NULL`, then startup notification will be used when activating the
    /// action (and as such, invocation of the action on the receiving side
    /// must signal the end of startup notification when it is completed).
    /// This is the expected behaviour of applications declaring additional
    /// actions, as per the
    /// [desktop file specification](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s11.html).
    ///
    /// As with `gio.AppInfo.launch` there is no way to detect failures that
    /// occur while using this function.
    extern fn g_desktop_app_info_launch_action(p_info: *gio.DesktopAppInfo, p_action_name: [*:0]const u8, p_launch_context: ?*gio.AppLaunchContext) void;
    pub const launchAction = g_desktop_app_info_launch_action;

    /// This function performs the equivalent of `gio.AppInfo.launchUris`,
    /// but is intended primarily for operating system components that
    /// launch applications.  Ordinary applications should use
    /// `gio.AppInfo.launchUris`.
    ///
    /// If the application is launched via GSpawn, then `spawn_flags`, `user_setup`
    /// and `user_setup_data` are used for the call to `glib.spawnAsync`.
    /// Additionally, `pid_callback` (with `pid_callback_data`) will be called to
    /// inform about the PID of the created process. See
    /// `glib.spawnAsyncWithPipes` for information on certain parameter
    /// conditions that can enable an optimized [``posix_spawn``](man:posix_spawn(3))
    /// code path to be used.
    ///
    /// If application launching occurs via some other mechanism (for example, D-Bus
    /// activation) then `spawn_flags`, `user_setup`, `user_setup_data`,
    /// `pid_callback` and `pid_callback_data` are ignored.
    extern fn g_desktop_app_info_launch_uris_as_manager(p_appinfo: *gio.DesktopAppInfo, p_uris: *glib.List, p_launch_context: ?*gio.AppLaunchContext, p_spawn_flags: glib.SpawnFlags, p_user_setup: ?glib.SpawnChildSetupFunc, p_user_setup_data: ?*anyopaque, p_pid_callback: ?gio.DesktopAppLaunchCallback, p_pid_callback_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const launchUrisAsManager = g_desktop_app_info_launch_uris_as_manager;

    /// Equivalent to `gio.DesktopAppInfo.launchUrisAsManager` but allows
    /// you to pass in file descriptors for the stdin, stdout and stderr streams
    /// of the launched process.
    ///
    /// If application launching occurs via some non-spawn mechanism (e.g. D-Bus
    /// activation) then `stdin_fd`, `stdout_fd` and `stderr_fd` are ignored.
    extern fn g_desktop_app_info_launch_uris_as_manager_with_fds(p_appinfo: *gio.DesktopAppInfo, p_uris: *glib.List, p_launch_context: ?*gio.AppLaunchContext, p_spawn_flags: glib.SpawnFlags, p_user_setup: ?glib.SpawnChildSetupFunc, p_user_setup_data: ?*anyopaque, p_pid_callback: ?gio.DesktopAppLaunchCallback, p_pid_callback_data: ?*anyopaque, p_stdin_fd: c_int, p_stdout_fd: c_int, p_stderr_fd: c_int, p_error: ?*?*glib.Error) c_int;
    pub const launchUrisAsManagerWithFds = g_desktop_app_info_launch_uris_as_manager_with_fds;

    /// Returns the list of
    /// [‘additional application actions’](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s11.html)
    /// supported on the desktop file, as per the desktop file specification.
    ///
    /// As per the specification, this is the list of actions that are
    /// explicitly listed in the `Actions` key of the `Desktop Entry` group.
    extern fn g_desktop_app_info_list_actions(p_info: *gio.DesktopAppInfo) [*]const [*:0]const u8;
    pub const listActions = g_desktop_app_info_list_actions;

    /// Searches desktop files for ones that match `search_string`.
    ///
    /// The return value is an array of strvs.  Each strv contains a list of
    /// applications that matched `search_string` with an equal score.  The
    /// outer list is sorted by score so that the first strv contains the
    /// best-matching applications, and so on.
    /// The algorithm for determining matches is undefined and may change at
    /// any time.
    ///
    /// None of the search results are subjected to the normal validation
    /// checks performed by `gio.DesktopAppInfo.new` (for example, checking that
    /// the executable referenced by a result exists), and so it is possible for
    /// `gio.DesktopAppInfo.new` to return `NULL` when passed an app ID returned
    /// by this function. It is expected that calling code will do this when
    /// subsequently creating a `gio.DesktopAppInfo` for each result.
    extern fn g_desktop_app_info_search(p_search_string: [*:0]const u8) [*][*][*:0]u8;
    pub const search = g_desktop_app_info_search;

    /// Sets the name of the desktop that the application is running in.
    ///
    /// This is used by `gio.AppInfo.shouldShow` and
    /// `gio.DesktopAppInfo.getShowIn` to evaluate the
    /// [`OnlyShowIn`](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html`key`-onlyshowin)
    /// and [`NotShowIn`](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html`key`-notshowin)
    /// keys.
    ///
    /// Should be called only once; subsequent calls are ignored.
    extern fn g_desktop_app_info_set_desktop_env(p_desktop_env: [*:0]const u8) void;
    pub const setDesktopEnv = g_desktop_app_info_set_desktop_env;

    /// Creates a new `gio.DesktopAppInfo` based on a desktop file ID.
    ///
    /// A desktop file ID is the basename of the desktop file, including the
    /// `.desktop` extension. GIO is looking for a desktop file with this name
    /// in the `applications` subdirectories of the XDG
    /// data directories (i.e. the directories specified in the `XDG_DATA_HOME`
    /// and `XDG_DATA_DIRS` environment variables). GIO also supports the
    /// prefix-to-subdirectory mapping that is described in the
    /// [Menu Spec](http://standards.freedesktop.org/menu-spec/latest/)
    /// (i.e. a desktop ID of `kde-foo.desktop` will match
    /// `/usr/share/applications/kde/foo.desktop`).
    extern fn g_desktop_app_info_new(p_desktop_id: [*:0]const u8) ?*giounix.DesktopAppInfo;
    pub const new = g_desktop_app_info_new;

    /// Creates a new `gio.DesktopAppInfo`.
    extern fn g_desktop_app_info_new_from_filename(p_filename: [*:0]const u8) ?*giounix.DesktopAppInfo;
    pub const newFromFilename = g_desktop_app_info_new_from_filename;

    /// Creates a new `gio.DesktopAppInfo`.
    extern fn g_desktop_app_info_new_from_keyfile(p_key_file: *glib.KeyFile) ?*giounix.DesktopAppInfo;
    pub const newFromKeyfile = g_desktop_app_info_new_from_keyfile;

    extern fn g_desktop_app_info_get_type() usize;
    pub const getGObjectType = g_desktop_app_info_get_type;

    extern fn g_object_ref(p_self: *giounix.DesktopAppInfo) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *giounix.DesktopAppInfo) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DesktopAppInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This `gio.SocketControlMessage` contains a `gio.UnixFDList`.
/// It may be sent using `gio.Socket.sendMessage` and received using
/// `gio.Socket.receiveMessage` over UNIX sockets (ie: sockets in the
/// `G_SOCKET_FAMILY_UNIX` family). The file descriptors are copied
/// between processes by the kernel.
///
/// For an easier way to send and receive file descriptors over
/// stream-oriented UNIX sockets, see `gio.UnixConnection.sendFd` and
/// `gio.UnixConnection.receiveFd`.
///
/// Note that `<gio/gunixfdmessage.h>` belongs to the UNIX-specific GIO
/// interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
/// file or the `GioUnix-2.0` GIR namespace when using it.
pub const FDMessage = extern struct {
    pub const Parent = gio.SocketControlMessage;
    pub const Implements = [_]type{};
    pub const Class = giounix.FDMessageClass;
    f_parent_instance: gio.SocketControlMessage,
    f_priv: ?*gio.UnixFDMessagePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `gio.UnixFDList` object to send with the message.
        pub const fd_list = struct {
            pub const name = "fd-list";

            pub const Type = ?*gio.UnixFDList;
        };
    };

    pub const signals = struct {};

    /// Adds a file descriptor to `message`.
    ///
    /// The file descriptor is duplicated using `dup`. You keep your copy
    /// of the descriptor and the copy contained in `message` will be closed
    /// when `message` is finalized.
    ///
    /// A possible cause of failure is exceeding the per-process or
    /// system-wide file descriptor limit.
    extern fn g_unix_fd_message_append_fd(p_message: *gio.UnixFDMessage, p_fd: c_int, p_error: ?*?*glib.Error) c_int;
    pub const appendFd = g_unix_fd_message_append_fd;

    /// Gets the `gio.UnixFDList` contained in `message`.  This function does not
    /// return a reference to the caller, but the returned list is valid for
    /// the lifetime of `message`.
    extern fn g_unix_fd_message_get_fd_list(p_message: *gio.UnixFDMessage) *gio.UnixFDList;
    pub const getFdList = g_unix_fd_message_get_fd_list;

    /// Returns the array of file descriptors that is contained in this
    /// object.
    ///
    /// After this call, the descriptors are no longer contained in
    /// `message`. Further calls will return an empty list (unless more
    /// descriptors have been added).
    ///
    /// The return result of this function must be freed with `glib.free`.
    /// The caller is also responsible for closing all of the file
    /// descriptors.
    ///
    /// If `length` is non-`NULL` then it is set to the number of file
    /// descriptors in the returned array. The returned array is also
    /// terminated with -1.
    ///
    /// This function never returns `NULL`. In case there are no file
    /// descriptors contained in `message`, an empty array is returned.
    extern fn g_unix_fd_message_steal_fds(p_message: *gio.UnixFDMessage, p_length: ?*c_int) [*]c_int;
    pub const stealFds = g_unix_fd_message_steal_fds;

    /// Creates a new `gio.UnixFDMessage` containing an empty file descriptor
    /// list.
    extern fn g_unix_fd_message_new() *giounix.FDMessage;
    pub const new = g_unix_fd_message_new;

    /// Creates a new `gio.UnixFDMessage` containing `list`.
    extern fn g_unix_fd_message_new_with_fd_list(p_fd_list: *gio.UnixFDList) *giounix.FDMessage;
    pub const newWithFdList = g_unix_fd_message_new_with_fd_list;

    extern fn g_unix_fd_message_get_type() usize;
    pub const getGObjectType = g_unix_fd_message_get_type;

    extern fn g_object_ref(p_self: *giounix.FDMessage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *giounix.FDMessage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FDMessage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GUnixInputStream` implements `gio.InputStream` for reading from a UNIX
/// file descriptor, including asynchronous operations. (If the file
/// descriptor refers to a socket or pipe, this will use ``poll`` to do
/// asynchronous I/O. If it refers to a regular file, it will fall back
/// to doing asynchronous I/O in another thread.)
///
/// Note that `<gio/gunixinputstream.h>` belongs to the UNIX-specific GIO
/// interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
/// file or the `GioUnix-2.0` GIR namespace when using it.
pub const InputStream = extern struct {
    pub const Parent = gio.InputStream;
    pub const Implements = [_]type{ gio.PollableInputStream, giounix.FileDescriptorBased };
    pub const Class = giounix.InputStreamClass;
    f_parent_instance: gio.InputStream,
    f_priv: ?*gio.UnixInputStreamPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to close the file descriptor when the stream is closed.
        pub const close_fd = struct {
            pub const name = "close-fd";

            pub const Type = c_int;
        };

        /// The file descriptor that the stream reads from.
        pub const fd = struct {
            pub const name = "fd";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns whether the file descriptor of `stream` will be
    /// closed when the stream is closed.
    extern fn g_unix_input_stream_get_close_fd(p_stream: *gio.UnixInputStream) c_int;
    pub const getCloseFd = g_unix_input_stream_get_close_fd;

    /// Return the UNIX file descriptor that the stream reads from.
    extern fn g_unix_input_stream_get_fd(p_stream: *gio.UnixInputStream) c_int;
    pub const getFd = g_unix_input_stream_get_fd;

    /// Sets whether the file descriptor of `stream` shall be closed
    /// when the stream is closed.
    extern fn g_unix_input_stream_set_close_fd(p_stream: *gio.UnixInputStream, p_close_fd: c_int) void;
    pub const setCloseFd = g_unix_input_stream_set_close_fd;

    /// Creates a new `gio.UnixInputStream` for the given `fd`.
    ///
    /// If `close_fd` is `TRUE`, the file descriptor will be closed
    /// when the stream is closed.
    extern fn g_unix_input_stream_new(p_fd: c_int, p_close_fd: c_int) *giounix.InputStream;
    pub const new = g_unix_input_stream_new;

    extern fn g_unix_input_stream_get_type() usize;
    pub const getGObjectType = g_unix_input_stream_get_type;

    extern fn g_object_ref(p_self: *giounix.InputStream) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *giounix.InputStream) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *InputStream, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Watches for changes to the set of mount entries and mount points in the
/// system.
///
/// Connect to the `giounix.MountMonitor.signals.mounts_changed` signal to be
/// notified of changes to the `giounix.MountEntry` list.
///
/// Connect to the `giounix.MountMonitor.signals.mountpoints_changed` signal to
/// be notified of changes to the `giounix.MountPoint` list.
pub const MountMonitor = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = giounix.MountMonitorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when the Unix mount points have changed.
        pub const mountpoints_changed = struct {
            pub const name = "mountpoints-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MountMonitor, p_instance))),
                    gobject.signalLookup("mountpoints-changed", MountMonitor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the Unix mount entries have changed.
        pub const mounts_changed = struct {
            pub const name = "mounts-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MountMonitor, p_instance))),
                    gobject.signalLookup("mounts-changed", MountMonitor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the `giounix.MountMonitor` for the current thread-default main
    /// context.
    ///
    /// The mount monitor can be used to monitor for changes to the list of
    /// mounted filesystems as well as the list of mount points (ie: fstab
    /// entries).
    ///
    /// You must only call `gobject.Object.unref` on the return value from
    /// under the same main context as you called this function.
    extern fn g_unix_mount_monitor_get() *gio.UnixMountMonitor;
    pub const get = g_unix_mount_monitor_get;

    /// This function does nothing.
    ///
    /// Before 2.44, this was a partially-effective way of controlling the
    /// rate at which events would be reported under some uncommon
    /// circumstances.  Since `mount_monitor` is a singleton, it also meant
    /// that calling this function would have side effects for other users of
    /// the monitor.
    extern fn g_unix_mount_monitor_set_rate_limit(p_mount_monitor: *gio.UnixMountMonitor, p_limit_msec: c_int) void;
    pub const setRateLimit = g_unix_mount_monitor_set_rate_limit;

    /// Deprecated alias for `giounix.MountMonitor.get`.
    ///
    /// This function was never a true constructor, which is why it was
    /// renamed.
    extern fn g_unix_mount_monitor_new() *giounix.MountMonitor;
    pub const new = g_unix_mount_monitor_new;

    extern fn g_unix_mount_monitor_get_type() usize;
    pub const getGObjectType = g_unix_mount_monitor_get_type;

    extern fn g_object_ref(p_self: *giounix.MountMonitor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *giounix.MountMonitor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MountMonitor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GUnixOutputStream` implements `gio.OutputStream` for writing to a UNIX
/// file descriptor, including asynchronous operations. (If the file
/// descriptor refers to a socket or pipe, this will use ``poll`` to do
/// asynchronous I/O. If it refers to a regular file, it will fall back
/// to doing asynchronous I/O in another thread.)
///
/// Note that `<gio/gunixoutputstream.h>` belongs to the UNIX-specific GIO
/// interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config file
/// file or the `GioUnix-2.0` GIR namespace when using it.
pub const OutputStream = extern struct {
    pub const Parent = gio.OutputStream;
    pub const Implements = [_]type{ gio.PollableOutputStream, giounix.FileDescriptorBased };
    pub const Class = giounix.OutputStreamClass;
    f_parent_instance: gio.OutputStream,
    f_priv: ?*gio.UnixOutputStreamPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to close the file descriptor when the stream is closed.
        pub const close_fd = struct {
            pub const name = "close-fd";

            pub const Type = c_int;
        };

        /// The file descriptor that the stream writes to.
        pub const fd = struct {
            pub const name = "fd";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns whether the file descriptor of `stream` will be
    /// closed when the stream is closed.
    extern fn g_unix_output_stream_get_close_fd(p_stream: *gio.UnixOutputStream) c_int;
    pub const getCloseFd = g_unix_output_stream_get_close_fd;

    /// Return the UNIX file descriptor that the stream writes to.
    extern fn g_unix_output_stream_get_fd(p_stream: *gio.UnixOutputStream) c_int;
    pub const getFd = g_unix_output_stream_get_fd;

    /// Sets whether the file descriptor of `stream` shall be closed
    /// when the stream is closed.
    extern fn g_unix_output_stream_set_close_fd(p_stream: *gio.UnixOutputStream, p_close_fd: c_int) void;
    pub const setCloseFd = g_unix_output_stream_set_close_fd;

    /// Creates a new `gio.UnixOutputStream` for the given `fd`.
    ///
    /// If `close_fd`, is `TRUE`, the file descriptor will be closed when
    /// the output stream is destroyed.
    extern fn g_unix_output_stream_new(p_fd: c_int, p_close_fd: c_int) *giounix.OutputStream;
    pub const new = g_unix_output_stream_new;

    extern fn g_unix_output_stream_get_type() usize;
    pub const getGObjectType = g_unix_output_stream_get_type;

    extern fn g_object_ref(p_self: *giounix.OutputStream) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *giounix.OutputStream) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OutputStream, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gio.DesktopAppInfoLookup` is an opaque data structure and can only be accessed
/// using the following functions.
pub const DesktopAppInfoLookup = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = giounix.DesktopAppInfoLookupIface;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the default application for launching applications
    /// using this URI scheme for a particular `gio.DesktopAppInfoLookup`
    /// implementation.
    ///
    /// The `gio.DesktopAppInfoLookup` interface and this function is used
    /// to implement `gio.AppInfo.getDefaultForUriScheme` backends
    /// in a GIO module. There is no reason for applications to use it
    /// directly. Applications should use
    /// `gio.AppInfo.getDefaultForUriScheme`.
    extern fn g_desktop_app_info_lookup_get_default_for_uri_scheme(p_lookup: *gio.DesktopAppInfoLookup, p_uri_scheme: [*:0]const u8) ?*gio.AppInfo;
    pub const getDefaultForUriScheme = g_desktop_app_info_lookup_get_default_for_uri_scheme;

    extern fn g_desktop_app_info_lookup_get_type() usize;
    pub const getGObjectType = g_desktop_app_info_lookup_get_type;

    extern fn g_object_ref(p_self: *giounix.DesktopAppInfoLookup) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *giounix.DesktopAppInfoLookup) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DesktopAppInfoLookup, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GFileDescriptorBased` is an interface for file descriptor based IO.
///
/// It is implemented by streams (implementations of `gio.InputStream` or
/// `gio.OutputStream`) that are based on file descriptors.
///
/// Note that `<gio/gfiledescriptorbased.h>` belongs to the UNIX-specific
/// GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
/// file or the `GioUnix-2.0` GIR namespace when using it.
pub const FileDescriptorBased = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = giounix.FileDescriptorBasedIface;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the underlying file descriptor.
    extern fn g_file_descriptor_based_get_fd(p_fd_based: *gio.FileDescriptorBased) c_int;
    pub const getFd = g_file_descriptor_based_get_fd;

    extern fn g_file_descriptor_based_get_type() usize;
    pub const getGObjectType = g_file_descriptor_based_get_type;

    extern fn g_object_ref(p_self: *giounix.FileDescriptorBased) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *giounix.FileDescriptorBased) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FileDescriptorBased, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DesktopAppInfoClass = extern struct {
    pub const Instance = giounix.DesktopAppInfo;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *DesktopAppInfoClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interface that is used by backends to associate default
/// handlers with URI schemes.
pub const DesktopAppInfoLookupIface = extern struct {
    pub const Instance = giounix.DesktopAppInfoLookup;

    f_g_iface: gobject.TypeInterface,
    /// Virtual method for
    ///  `gio.DesktopAppInfoLookup.getDefaultForUriScheme`.
    f_get_default_for_uri_scheme: ?*const fn (p_lookup: *gio.DesktopAppInfoLookup, p_uri_scheme: [*:0]const u8) callconv(.c) *gio.AppInfo,

    pub fn as(p_instance: *DesktopAppInfoLookupIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FDMessageClass = extern struct {
    pub const Instance = giounix.FDMessage;

    f_parent_class: gio.SocketControlMessageClass,
    f__g_reserved1: ?*const fn () callconv(.c) void,
    f__g_reserved2: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *FDMessageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FDMessagePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface for file descriptor based io objects.
pub const FileDescriptorBasedIface = extern struct {
    pub const Instance = giounix.FileDescriptorBased;

    /// The parent interface.
    f_g_iface: gobject.TypeInterface,
    /// Gets the underlying file descriptor.
    f_get_fd: ?*const fn (p_fd_based: *gio.FileDescriptorBased) callconv(.c) c_int,

    pub fn as(p_instance: *FileDescriptorBasedIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InputStreamClass = extern struct {
    pub const Instance = giounix.InputStream;

    f_parent_class: gio.InputStreamClass,
    f__g_reserved1: ?*const fn () callconv(.c) void,
    f__g_reserved2: ?*const fn () callconv(.c) void,
    f__g_reserved3: ?*const fn () callconv(.c) void,
    f__g_reserved4: ?*const fn () callconv(.c) void,
    f__g_reserved5: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *InputStreamClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const InputStreamPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines a Unix mount entry (e.g. `/media/cdrom`).
/// This corresponds roughly to a mtab entry.
pub const MountEntry = opaque {
    /// Gets a `giounix.MountEntry` for a given mount path.
    ///
    /// If `time_read` is set, it will be filled with a Unix timestamp for checking
    /// if the mounts have changed since with
    /// `giounix.mountEntriesChangedSince`.
    ///
    /// If more mounts have the same mount path, the last matching mount
    /// is returned.
    ///
    /// This will return `NULL` if there is no mount point at `mount_path`.
    extern fn g_unix_mount_entry_at(p_mount_path: [*:0]const u8, p_time_read: ?*u64) ?*gio.UnixMountEntry;
    pub const at = g_unix_mount_entry_at;

    /// Compares two Unix mounts.
    extern fn g_unix_mount_entry_compare(p_mount1: *gio.UnixMountEntry, p_mount2: *gio.UnixMountEntry) c_int;
    pub const compare = g_unix_mount_entry_compare;

    /// Makes a copy of `mount_entry`.
    extern fn g_unix_mount_entry_copy(p_mount_entry: *gio.UnixMountEntry) *gio.UnixMountEntry;
    pub const copy = g_unix_mount_entry_copy;

    /// Gets a `giounix.MountEntry` for a given file path.
    ///
    /// If `time_read` is set, it will be filled with a Unix timestamp for checking
    /// if the mounts have changed since with
    /// `giounix.mountEntriesChangedSince`.
    ///
    /// If more mounts have the same mount path, the last matching mount
    /// is returned.
    ///
    /// This will return `NULL` if looking up the mount entry fails, if
    /// `file_path` doesn’t exist or there is an I/O error.
    extern fn g_unix_mount_entry_for(p_file_path: [*:0]const u8, p_time_read: ?*u64) ?*gio.UnixMountEntry;
    pub const @"for" = g_unix_mount_entry_for;

    /// Frees a Unix mount.
    extern fn g_unix_mount_entry_free(p_mount_entry: *gio.UnixMountEntry) void;
    pub const free = g_unix_mount_entry_free;

    /// Gets the device path for a Unix mount.
    extern fn g_unix_mount_entry_get_device_path(p_mount_entry: *gio.UnixMountEntry) [*:0]const u8;
    pub const getDevicePath = g_unix_mount_entry_get_device_path;

    /// Gets the filesystem type for the Unix mount.
    extern fn g_unix_mount_entry_get_fs_type(p_mount_entry: *gio.UnixMountEntry) [*:0]const u8;
    pub const getFsType = g_unix_mount_entry_get_fs_type;

    /// Gets the mount path for a Unix mount.
    extern fn g_unix_mount_entry_get_mount_path(p_mount_entry: *gio.UnixMountEntry) [*:0]const u8;
    pub const getMountPath = g_unix_mount_entry_get_mount_path;

    /// Gets a comma separated list of mount options for the Unix mount.
    ///
    /// For example: `rw,relatime,seclabel,data=ordered`.
    ///
    /// This is similar to `giounix.MountPoint.getOptions`, but it takes
    /// a `giounix.MountEntry` as an argument.
    extern fn g_unix_mount_entry_get_options(p_mount_entry: *gio.UnixMountEntry) ?[*:0]const u8;
    pub const getOptions = g_unix_mount_entry_get_options;

    /// Gets the root of the mount within the filesystem. This is useful e.g. for
    /// mounts created by bind operation, or btrfs subvolumes.
    ///
    /// For example, the root path is equal to `/` for a mount created by
    /// `mount /dev/sda1 /mnt/foo` and `/bar` for
    /// `mount --bind /mnt/foo/bar /mnt/bar`.
    extern fn g_unix_mount_entry_get_root_path(p_mount_entry: *gio.UnixMountEntry) ?[*:0]const u8;
    pub const getRootPath = g_unix_mount_entry_get_root_path;

    /// Guesses whether a Unix mount entry can be ejected.
    extern fn g_unix_mount_entry_guess_can_eject(p_mount_entry: *gio.UnixMountEntry) c_int;
    pub const guessCanEject = g_unix_mount_entry_guess_can_eject;

    /// Guesses the icon of a Unix mount entry.
    extern fn g_unix_mount_entry_guess_icon(p_mount_entry: *gio.UnixMountEntry) *gio.Icon;
    pub const guessIcon = g_unix_mount_entry_guess_icon;

    /// Guesses the name of a Unix mount entry.
    ///
    /// The result is a translated string.
    extern fn g_unix_mount_entry_guess_name(p_mount_entry: *gio.UnixMountEntry) [*:0]u8;
    pub const guessName = g_unix_mount_entry_guess_name;

    /// Guesses whether a Unix mount entry should be displayed in the UI.
    extern fn g_unix_mount_entry_guess_should_display(p_mount_entry: *gio.UnixMountEntry) c_int;
    pub const guessShouldDisplay = g_unix_mount_entry_guess_should_display;

    /// Guesses the symbolic icon of a Unix mount entry.
    extern fn g_unix_mount_entry_guess_symbolic_icon(p_mount_entry: *gio.UnixMountEntry) *gio.Icon;
    pub const guessSymbolicIcon = g_unix_mount_entry_guess_symbolic_icon;

    /// Checks if a Unix mount is mounted read only.
    extern fn g_unix_mount_entry_is_readonly(p_mount_entry: *gio.UnixMountEntry) c_int;
    pub const isReadonly = g_unix_mount_entry_is_readonly;

    /// Checks if a Unix mount is a system mount.
    ///
    /// This is the Boolean OR of
    /// `giounix.isSystemFsType`, `giounix.isSystemDevicePath` and
    /// `giounix.isMountPathSystemInternal` on `mount_entry`’s properties.
    ///
    /// The definition of what a ‘system’ mount entry is may change over time as new
    /// file system types and device paths are ignored.
    extern fn g_unix_mount_entry_is_system_internal(p_mount_entry: *gio.UnixMountEntry) c_int;
    pub const isSystemInternal = g_unix_mount_entry_is_system_internal;

    extern fn g_unix_mount_entry_get_type() usize;
    pub const getGObjectType = g_unix_mount_entry_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MountMonitorClass = opaque {
    pub const Instance = giounix.MountMonitor;

    pub fn as(p_instance: *MountMonitorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines a Unix mount point (e.g. `/dev`).
/// This corresponds roughly to a fstab entry.
pub const MountPoint = opaque {
    /// Gets a `giounix.MountPoint` for a given mount path.
    ///
    /// If `time_read` is set, it will be filled with a Unix timestamp for checking if
    /// the mount points have changed since with
    /// `giounix.mountPointsChangedSince`.
    ///
    /// If more mount points have the same mount path, the last matching mount point
    /// is returned.
    extern fn g_unix_mount_point_at(p_mount_path: [*:0]const u8, p_time_read: ?*u64) ?*gio.UnixMountPoint;
    pub const at = g_unix_mount_point_at;

    /// Compares two Unix mount points.
    extern fn g_unix_mount_point_compare(p_mount1: *gio.UnixMountPoint, p_mount2: *gio.UnixMountPoint) c_int;
    pub const compare = g_unix_mount_point_compare;

    /// Makes a copy of `mount_point`.
    extern fn g_unix_mount_point_copy(p_mount_point: *gio.UnixMountPoint) *gio.UnixMountPoint;
    pub const copy = g_unix_mount_point_copy;

    /// Frees a Unix mount point.
    extern fn g_unix_mount_point_free(p_mount_point: *gio.UnixMountPoint) void;
    pub const free = g_unix_mount_point_free;

    /// Gets the device path for a Unix mount point.
    extern fn g_unix_mount_point_get_device_path(p_mount_point: *gio.UnixMountPoint) [*:0]const u8;
    pub const getDevicePath = g_unix_mount_point_get_device_path;

    /// Gets the file system type for the mount point.
    extern fn g_unix_mount_point_get_fs_type(p_mount_point: *gio.UnixMountPoint) [*:0]const u8;
    pub const getFsType = g_unix_mount_point_get_fs_type;

    /// Gets the mount path for a Unix mount point.
    extern fn g_unix_mount_point_get_mount_path(p_mount_point: *gio.UnixMountPoint) [*:0]const u8;
    pub const getMountPath = g_unix_mount_point_get_mount_path;

    /// Gets the options for the mount point.
    extern fn g_unix_mount_point_get_options(p_mount_point: *gio.UnixMountPoint) ?[*:0]const u8;
    pub const getOptions = g_unix_mount_point_get_options;

    /// Guesses whether a Unix mount point can be ejected.
    extern fn g_unix_mount_point_guess_can_eject(p_mount_point: *gio.UnixMountPoint) c_int;
    pub const guessCanEject = g_unix_mount_point_guess_can_eject;

    /// Guesses the icon of a Unix mount point.
    extern fn g_unix_mount_point_guess_icon(p_mount_point: *gio.UnixMountPoint) *gio.Icon;
    pub const guessIcon = g_unix_mount_point_guess_icon;

    /// Guesses the name of a Unix mount point.
    ///
    /// The result is a translated string.
    extern fn g_unix_mount_point_guess_name(p_mount_point: *gio.UnixMountPoint) [*:0]u8;
    pub const guessName = g_unix_mount_point_guess_name;

    /// Guesses the symbolic icon of a Unix mount point.
    extern fn g_unix_mount_point_guess_symbolic_icon(p_mount_point: *gio.UnixMountPoint) *gio.Icon;
    pub const guessSymbolicIcon = g_unix_mount_point_guess_symbolic_icon;

    /// Checks if a Unix mount point is a loopback device.
    extern fn g_unix_mount_point_is_loopback(p_mount_point: *gio.UnixMountPoint) c_int;
    pub const isLoopback = g_unix_mount_point_is_loopback;

    /// Checks if a Unix mount point is read only.
    extern fn g_unix_mount_point_is_readonly(p_mount_point: *gio.UnixMountPoint) c_int;
    pub const isReadonly = g_unix_mount_point_is_readonly;

    /// Checks if a Unix mount point is mountable by the user.
    extern fn g_unix_mount_point_is_user_mountable(p_mount_point: *gio.UnixMountPoint) c_int;
    pub const isUserMountable = g_unix_mount_point_is_user_mountable;

    extern fn g_unix_mount_point_get_type() usize;
    pub const getGObjectType = g_unix_mount_point_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OutputStreamClass = extern struct {
    pub const Instance = giounix.OutputStream;

    f_parent_class: gio.OutputStreamClass,
    f__g_reserved1: ?*const fn () callconv(.c) void,
    f__g_reserved2: ?*const fn () callconv(.c) void,
    f__g_reserved3: ?*const fn () callconv(.c) void,
    f__g_reserved4: ?*const fn () callconv(.c) void,
    f__g_reserved5: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *OutputStreamClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OutputStreamPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Determines if `mount_path` is considered an implementation of the
/// OS.
///
/// This is primarily used for hiding mountable and mounted volumes
/// that only are used in the OS and has little to no relevance to the
/// casual user.
extern fn g_unix_is_mount_path_system_internal(p_mount_path: [*:0]const u8) c_int;
pub const isMountPathSystemInternal = g_unix_is_mount_path_system_internal;

/// Determines if `device_path` is considered a block device path which is only
/// used in implementation of the OS.
///
/// This is primarily used for hiding mounted volumes that are intended as APIs
/// for programs to read, and system administrators at a shell; rather than
/// something that should, for example, appear in a GUI. For example, the Linux
/// `/proc` filesystem.
///
/// The list of device paths considered ‘system’ ones may change over time.
extern fn g_unix_is_system_device_path(p_device_path: [*:0]const u8) c_int;
pub const isSystemDevicePath = g_unix_is_system_device_path;

/// Determines if `fs_type` is considered a type of file system which is only
/// used in implementation of the OS.
///
/// This is primarily used for hiding mounted volumes that are intended as APIs
/// for programs to read, and system administrators at a shell; rather than
/// something that should, for example, appear in a GUI. For example, the Linux
/// `/proc` filesystem.
///
/// The list of file system types considered ‘system’ ones may change over time.
extern fn g_unix_is_system_fs_type(p_fs_type: [*:0]const u8) c_int;
pub const isSystemFsType = g_unix_is_system_fs_type;

/// Gets a `giounix.MountEntry` for a given mount path.
///
/// If `time_read` is set, it will be filled with a Unix timestamp for checking
/// if the mounts have changed since with
/// `giounix.mountEntriesChangedSince`.
///
/// If more mounts have the same mount path, the last matching mount
/// is returned.
///
/// This will return `NULL` if there is no mount point at `mount_path`.
extern fn g_unix_mount_at(p_mount_path: [*:0]const u8, p_time_read: ?*u64) ?*gio.UnixMountEntry;
pub const mountAt = g_unix_mount_at;

/// Compares two Unix mounts.
extern fn g_unix_mount_compare(p_mount1: *gio.UnixMountEntry, p_mount2: *gio.UnixMountEntry) c_int;
pub const mountCompare = g_unix_mount_compare;

/// Makes a copy of `mount_entry`.
extern fn g_unix_mount_copy(p_mount_entry: *gio.UnixMountEntry) *gio.UnixMountEntry;
pub const mountCopy = g_unix_mount_copy;

/// Checks if the Unix mounts have changed since a given Unix time.
///
/// This can only work reliably if a `giounix.MountMonitor` is running in
/// the process, otherwise changes in the mount entries file (such as
/// `/proc/self/mountinfo` on Linux) cannot be detected and, as a result, this
/// function has to conservatively always return `TRUE`.
///
/// It is more efficient to use `giounix.MountMonitor.signals.mounts_changed` to
/// be signalled of changes to the mount entries, rather than polling using this
/// function. This function is more appropriate for infrequently determining
/// cache validity.
extern fn g_unix_mount_entries_changed_since(p_time: u64) c_int;
pub const mountEntriesChangedSince = g_unix_mount_entries_changed_since;

/// Gets a list of `giounix.MountEntry` instances representing the Unix
/// mounts.
///
/// If `time_read` is set, it will be filled with the mount timestamp, allowing
/// for checking if the mounts have changed with
/// `giounix.mountEntriesChangedSince`.
extern fn g_unix_mount_entries_get(p_time_read: ?*u64) *glib.List;
pub const mountEntriesGet = g_unix_mount_entries_get;

/// Gets an array of `gio.UnixMountEntry`s containing the Unix mounts
/// listed in `table_path`.
///
/// This is a generalized version of `giounix.mountEntriesGet`, mainly
/// intended for internal testing use. Note that `giounix.mountEntriesGet`
/// may parse multiple hierarchical table files, so this function is not a direct
/// superset of its functionality.
///
/// If there is an error reading or parsing the file, `NULL` will be returned
/// and both out parameters will be set to `0`.
extern fn g_unix_mount_entries_get_from_file(p_table_path: [*:0]const u8, p_time_read_out: ?*u64, p_n_entries_out: ?*usize) ?[*]*gio.UnixMountEntry;
pub const mountEntriesGetFromFile = g_unix_mount_entries_get_from_file;

/// Gets a `giounix.MountEntry` for a given file path.
///
/// If `time_read` is set, it will be filled with a Unix timestamp for checking
/// if the mounts have changed since with
/// `giounix.mountEntriesChangedSince`.
///
/// If more mounts have the same mount path, the last matching mount
/// is returned.
///
/// This will return `NULL` if looking up the mount entry fails, if
/// `file_path` doesn’t exist or there is an I/O error.
extern fn g_unix_mount_for(p_file_path: [*:0]const u8, p_time_read: ?*u64) ?*gio.UnixMountEntry;
pub const mountFor = g_unix_mount_for;

/// Frees a Unix mount.
extern fn g_unix_mount_free(p_mount_entry: *gio.UnixMountEntry) void;
pub const mountFree = g_unix_mount_free;

/// Gets the device path for a Unix mount.
extern fn g_unix_mount_get_device_path(p_mount_entry: *gio.UnixMountEntry) [*:0]const u8;
pub const mountGetDevicePath = g_unix_mount_get_device_path;

/// Gets the filesystem type for the Unix mount.
extern fn g_unix_mount_get_fs_type(p_mount_entry: *gio.UnixMountEntry) [*:0]const u8;
pub const mountGetFsType = g_unix_mount_get_fs_type;

/// Gets the mount path for a Unix mount.
extern fn g_unix_mount_get_mount_path(p_mount_entry: *gio.UnixMountEntry) [*:0]const u8;
pub const mountGetMountPath = g_unix_mount_get_mount_path;

/// Gets a comma separated list of mount options for the Unix mount.
///
/// For example: `rw,relatime,seclabel,data=ordered`.
///
/// This is similar to `giounix.MountPoint.getOptions`, but it takes
/// a `giounix.MountEntry` as an argument.
extern fn g_unix_mount_get_options(p_mount_entry: *gio.UnixMountEntry) ?[*:0]const u8;
pub const mountGetOptions = g_unix_mount_get_options;

/// Gets the root of the mount within the filesystem. This is useful e.g. for
/// mounts created by bind operation, or btrfs subvolumes.
///
/// For example, the root path is equal to `/` for a mount created by
/// `mount /dev/sda1 /mnt/foo` and `/bar` for
/// `mount --bind /mnt/foo/bar /mnt/bar`.
extern fn g_unix_mount_get_root_path(p_mount_entry: *gio.UnixMountEntry) ?[*:0]const u8;
pub const mountGetRootPath = g_unix_mount_get_root_path;

/// Guesses whether a Unix mount entry can be ejected.
extern fn g_unix_mount_guess_can_eject(p_mount_entry: *gio.UnixMountEntry) c_int;
pub const mountGuessCanEject = g_unix_mount_guess_can_eject;

/// Guesses the icon of a Unix mount entry.
extern fn g_unix_mount_guess_icon(p_mount_entry: *gio.UnixMountEntry) *gio.Icon;
pub const mountGuessIcon = g_unix_mount_guess_icon;

/// Guesses the name of a Unix mount entry.
///
/// The result is a translated string.
extern fn g_unix_mount_guess_name(p_mount_entry: *gio.UnixMountEntry) [*:0]u8;
pub const mountGuessName = g_unix_mount_guess_name;

/// Guesses whether a Unix mount entry should be displayed in the UI.
extern fn g_unix_mount_guess_should_display(p_mount_entry: *gio.UnixMountEntry) c_int;
pub const mountGuessShouldDisplay = g_unix_mount_guess_should_display;

/// Guesses the symbolic icon of a Unix mount entry.
extern fn g_unix_mount_guess_symbolic_icon(p_mount_entry: *gio.UnixMountEntry) *gio.Icon;
pub const mountGuessSymbolicIcon = g_unix_mount_guess_symbolic_icon;

/// Checks if a Unix mount is mounted read only.
extern fn g_unix_mount_is_readonly(p_mount_entry: *gio.UnixMountEntry) c_int;
pub const mountIsReadonly = g_unix_mount_is_readonly;

/// Checks if a Unix mount is a system mount.
///
/// This is the Boolean OR of
/// `giounix.isSystemFsType`, `giounix.isSystemDevicePath` and
/// `giounix.isMountPathSystemInternal` on `mount_entry`’s properties.
///
/// The definition of what a ‘system’ mount entry is may change over time as new
/// file system types and device paths are ignored.
extern fn g_unix_mount_is_system_internal(p_mount_entry: *gio.UnixMountEntry) c_int;
pub const mountIsSystemInternal = g_unix_mount_is_system_internal;

/// Checks if the Unix mount points have changed since a given Unix time.
///
/// Unlike `giounix.mountEntriesChangedSince`, this function can work
/// reliably without a `giounix.MountMonitor` running, as it accesses the
/// static mount point information (such as `/etc/fstab` on Linux), which has a
/// valid modification time.
///
/// It is more efficient to use `giounix.MountMonitor.signals.mountpoints_changed`
/// to be signalled of changes to the mount points, rather than polling using
/// this function. This function is more appropriate for infrequently determining
/// cache validity.
extern fn g_unix_mount_points_changed_since(p_time: u64) c_int;
pub const mountPointsChangedSince = g_unix_mount_points_changed_since;

/// Gets a list of `giounix.MountPoint` instances representing the Unix
/// mount points.
///
/// If `time_read` is set, it will be filled with the mount timestamp, allowing
/// for checking if the mounts have changed with
/// `giounix.mountPointsChangedSince`.
extern fn g_unix_mount_points_get(p_time_read: ?*u64) *glib.List;
pub const mountPointsGet = g_unix_mount_points_get;

/// Gets an array of `gio.UnixMountPoint`s containing the Unix mount
/// points listed in `table_path`.
///
/// This is a generalized version of `giounix.mountPointsGet`, mainly
/// intended for internal testing use. Note that `giounix.mountPointsGet`
/// may parse multiple hierarchical table files, so this function is not a direct
/// superset of its functionality.
///
/// If there is an error reading or parsing the file, `NULL` will be returned
/// and both out parameters will be set to `0`.
extern fn g_unix_mount_points_get_from_file(p_table_path: [*:0]const u8, p_time_read_out: ?*u64, p_n_points_out: ?*usize) ?[*]*gio.UnixMountPoint;
pub const mountPointsGetFromFile = g_unix_mount_points_get_from_file;

/// Checks if the Unix mounts have changed since a given Unix time.
extern fn g_unix_mounts_changed_since(p_time: u64) c_int;
pub const mountsChangedSince = g_unix_mounts_changed_since;

/// Gets a list of `giounix.MountEntry` instances representing the Unix
/// mounts.
///
/// If `time_read` is set, it will be filled with the mount timestamp, allowing
/// for checking if the mounts have changed with
/// `giounix.mountEntriesChangedSince`.
extern fn g_unix_mounts_get(p_time_read: ?*u64) *glib.List;
pub const mountsGet = g_unix_mounts_get;

/// Gets an array of `gio.UnixMountEntry`s containing the Unix mounts
/// listed in `table_path`.
///
/// This is a generalized version of `giounix.mountEntriesGet`, mainly
/// intended for internal testing use. Note that `giounix.mountEntriesGet`
/// may parse multiple hierarchical table files, so this function is not a direct
/// superset of its functionality.
///
/// If there is an error reading or parsing the file, `NULL` will be returned
/// and both out parameters will be set to `0`.
extern fn g_unix_mounts_get_from_file(p_table_path: [*:0]const u8, p_time_read_out: ?*u64, p_n_entries_out: ?*usize) ?[*]*gio.UnixMountEntry;
pub const mountsGetFromFile = g_unix_mounts_get_from_file;

/// During invocation, `gio.DesktopAppInfo.launchUrisAsManager` may
/// create one or more child processes.  This callback is invoked once
/// for each, providing the process ID.
pub const DesktopAppLaunchCallback = *const fn (p_appinfo: *gio.DesktopAppInfo, p_pid: glib.Pid, p_user_data: ?*anyopaque) callconv(.c) void;

/// Extension point for default handler to URI association. See
/// [Extending GIO](overview.html`extending`-gio).
pub const DESKTOP_APP_INFO_LOOKUP_EXTENSION_POINT_NAME = "gio-desktop-app-info-lookup";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
