pub const ext = @import("ext.zig");
const edatacal = @This();

const std = @import("std");
const compat = @import("compat");
const icalglib = @import("icalglib3");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const edataserver = @import("edataserver1");
const libxml2 = @import("libxml22");
const soup = @import("soup3");
const json = @import("json1");
const camel = @import("camel1");
const ecal = @import("ecal2");
const ebackend = @import("ebackend1");
/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CalBackend = extern struct {
    pub const Parent = ebackend.Backend;
    pub const Implements = [_]type{ecal.TimezoneCache};
    pub const Class = edatacal.CalBackendClass;
    f_parent: ebackend.Backend,
    f_priv: ?*edatacal.CalBackendPrivate,

    pub const virtual_methods = struct {
        /// A signal notifying that the backend was closed
        pub const closed = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sender: [*:0]const u8) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_closed.?(gobject.ext.as(CalBackend, p_backend), p_sender);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sender: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_closed = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_add_timezone = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_tzobject: [*:0]const u8) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_add_timezone.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_tzobject);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_tzobject: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_add_timezone = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_create_objects = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_opflags: ecal.OperationFlags) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_create_objects.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_calobjs, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_opflags: ecal.OperationFlags) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_create_objects = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_discard_alarm = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_discard_alarm.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_uid, p_rid, p_auid, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_discard_alarm = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_get_attachment_uris = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_get_attachment_uris.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_uid, p_rid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_get_attachment_uris = @ptrCast(p_implementation);
            }
        };

        /// Fetch a property value by name from the backend
        pub const impl_get_backend_property = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8) [*:0]u8 {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_get_backend_property.?(gobject.ext.as(CalBackend, p_backend), p_prop_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8) callconv(.c) [*:0]u8) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_get_backend_property = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_get_free_busy = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_users: *const glib.SList, p_start: std.posix.time_t, p_end: std.posix.time_t) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_get_free_busy.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_users, p_start, p_end);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_users: *const glib.SList, p_start: std.posix.time_t, p_end: std.posix.time_t) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_get_free_busy = @ptrCast(p_implementation);
            }
        };

        /// Fetch a calendar object
        pub const impl_get_object = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_get_object.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_uid, p_rid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_get_object = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_get_object_list = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_sexp: [*:0]const u8) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_get_object_list.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_sexp);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_sexp: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_get_object_list = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_get_timezone = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_tzid: [*:0]const u8) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_get_timezone.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_tzid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_tzid: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_get_timezone = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_modify_objects = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_modify_objects.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_calobjs, p_mod, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_modify_objects = @ptrCast(p_implementation);
            }
        };

        /// Open the backend
        pub const impl_open = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_open.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_open = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_receive_objects = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_receive_objects.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_calobj, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_receive_objects = @ptrCast(p_implementation);
            }
        };

        /// Refresh the backend
        pub const impl_refresh = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_refresh.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_refresh = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_remove_objects = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_remove_objects.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_ids, p_mod, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_remove_objects = @ptrCast(p_implementation);
            }
        };

        /// FIXME: Document me
        pub const impl_send_objects = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_send_objects.?(gobject.ext.as(CalBackend, p_backend), p_cal, p_opid, p_cancellable, p_calobj, p_opflags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_send_objects = @ptrCast(p_implementation);
            }
        };

        /// Start up the specified view
        pub const impl_start_view = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view: *edatacal.DataCalView) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_start_view.?(gobject.ext.as(CalBackend, p_backend), p_view);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view: *edatacal.DataCalView) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_start_view = @ptrCast(p_implementation);
            }
        };

        /// Stop the specified view
        pub const impl_stop_view = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view: *edatacal.DataCalView) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_impl_stop_view.?(gobject.ext.as(CalBackend, p_backend), p_view);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_view: *edatacal.DataCalView) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_impl_stop_view = @ptrCast(p_implementation);
            }
        };

        /// A signal notifying that the backend is being shut down
        pub const shutdown = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(CalBackend.Class, p_class).f_shutdown.?(gobject.ext.as(CalBackend, p_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(CalBackend.Class, p_class).f_shutdown = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const cache_dir = struct {
            pub const name = "cache-dir";

            pub const Type = ?[*:0]u8;
        };

        pub const kind = struct {
            pub const name = "kind";

            pub const Type = c_ulong;
        };

        pub const proxy_resolver = struct {
            pub const name = "proxy-resolver";

            pub const Type = ?*gio.ProxyResolver;
        };

        pub const registry = struct {
            pub const name = "registry";

            pub const Type = ?*edataserver.SourceRegistry;
        };

        pub const writable = struct {
            pub const name = "writable";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted when a client destroys its `ecal.Client` for `backend`
        pub const closed = struct {
            pub const name = "closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_sender: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CalBackend, p_instance))),
                    gobject.signalLookup("closed", CalBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the last client destroys its `ecal.Client` for
        /// `backend`.  This signals the `backend` to begin final cleanup
        /// tasks such as synchronizing data to permanent storage.
        pub const shutdown = struct {
            pub const name = "shutdown";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CalBackend, p_instance))),
                    gobject.signalLookup("shutdown", CalBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Retrieve the default mail account as stored in Evolution configuration.
    extern fn e_cal_backend_mail_account_get_default(p_registry: *edataserver.SourceRegistry, p_address: *[*:0]u8, p_name: *[*:0]u8) c_int;
    pub const mailAccountGetDefault = e_cal_backend_mail_account_get_default;

    /// Checks that a mail account is valid, and returns its name.
    extern fn e_cal_backend_mail_account_is_valid(p_registry: *edataserver.SourceRegistry, p_user: [*:0]const u8, p_name: *[*:0]u8) c_int;
    pub const mailAccountIsValid = e_cal_backend_mail_account_is_valid;

    extern fn e_cal_backend_user_declined(p_registry: *edataserver.SourceRegistry, p_icalcomp: *icalglib.Component) c_int;
    pub const userDeclined = e_cal_backend_user_declined;

    /// Asynchronously adds the timezone described by `tzobject` to `backend`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `edatacal.CalBackend.addTimezoneFinish` to get the result of
    /// the operation.
    extern fn e_cal_backend_add_timezone(p_backend: *CalBackend, p_tzobject: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const addTimezone = e_cal_backend_add_timezone;

    /// Finishes the operation started with `edatacal.CalBackend.addTimezone`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_add_timezone_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const addTimezoneFinish = e_cal_backend_add_timezone_finish;

    /// Adds the timezone described by `tzobject` to `backend`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_add_timezone_sync(p_backend: *CalBackend, p_tzobject: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const addTimezoneSync = e_cal_backend_add_timezone_sync;

    /// Adds a view to the list of live views being run by the given backend.
    /// Doing so means that any listener on the view will get notified of any
    /// change that affect the live view.
    extern fn e_cal_backend_add_view(p_backend: *CalBackend, p_view: *edatacal.DataCalView) void;
    pub const addView = e_cal_backend_add_view;

    extern fn e_cal_backend_create_cache_filename(p_backend: *CalBackend, p_uid: [*:0]const u8, p_filename: ?[*:0]const u8, p_fileindex: c_int) [*:0]u8;
    pub const createCacheFilename = e_cal_backend_create_cache_filename;

    /// Asynchronously creates one or more new iCalendar objects from `calobjs`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.createObjectsFinish` to get the result of the
    /// operation.
    extern fn e_cal_backend_create_objects(p_backend: *CalBackend, p_calobjs: *const [*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const createObjects = e_cal_backend_create_objects;

    /// Finishes the operation started with `edatacal.CalBackend.createObjects`.
    ///
    /// A unique ID string for each newly-created object is deposited in `out_uids`.
    /// Free the returned ID strings with `glib.free` when finished with them.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_create_objects_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_out_uids: *glib.Queue, p_error: ?*?*glib.Error) c_int;
    pub const createObjectsFinish = e_cal_backend_create_objects_finish;

    /// Creates one or more new iCalendar objects from `calobjs`, and deposits
    /// the unique ID string for each newly-created object in `out_uids`.
    ///
    /// Free the returned ID strings with `glib.free` when finished with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_create_objects_sync(p_backend: *CalBackend, p_calobjs: *const [*:0]const u8, p_opflags: ecal.OperationFlags, p_out_uids: *glib.Queue, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const createObjectsSync = e_cal_backend_create_objects_sync;

    /// Asynchronously discards the VALARM object with a unique ID of `alarm_uid`
    /// from the iCalendar object identified by `uid` and, optionally, `rid`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `edatacal.CalBackend.discardAlarmFinish` to get the result of
    /// the operation.
    extern fn e_cal_backend_discard_alarm(p_backend: *CalBackend, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_alarm_uid: [*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const discardAlarm = e_cal_backend_discard_alarm;

    /// Finishes the operation started with `edatacal.CalBackend.discardAlarm`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_discard_alarm_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const discardAlarmFinish = e_cal_backend_discard_alarm_finish;

    /// Discards the VALARM object with a unique ID of `alarm_uid` from the
    /// iCalendar object identified by `uid` and, optionally, `rid`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_discard_alarm_sync(p_backend: *CalBackend, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_alarm_uid: [*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const discardAlarmSync = e_cal_backend_discard_alarm_sync;

    /// Thread-safe variation of `edatacal.CalBackend.getCacheDir`.
    /// Use this function when accessing `backend` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_cal_backend_dup_cache_dir(p_backend: *CalBackend) [*:0]u8;
    pub const dupCacheDir = e_cal_backend_dup_cache_dir;

    /// Calls `func` for each existing view (as returned by `edatacal.CalBackend.listViews`).
    /// The `func` can return `FALSE` to stop early.
    extern fn e_cal_backend_foreach_view(p_backend: *CalBackend, p_func: edatacal.CalBackendForeachViewFunc, p_user_data: ?*anyopaque) c_int;
    pub const foreachView = e_cal_backend_foreach_view;

    /// Notifies each view of the `backend` about progress. When `only_completed_views`
    /// is `TRUE`, notifies only completed views.
    extern fn e_cal_backend_foreach_view_notify_progress(p_backend: *CalBackend, p_only_completed_views: c_int, p_percent: c_int, p_message: ?[*:0]const u8) void;
    pub const foreachViewNotifyProgress = e_cal_backend_foreach_view_notify_progress;

    /// Asynchronously inspects the iCalendar object specified by `uid` and,
    /// optionally, `rid` for attachments.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.getAttachmentUrisFinish` to get the result of the
    /// operation.
    extern fn e_cal_backend_get_attachment_uris(p_backend: *CalBackend, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getAttachmentUris = e_cal_backend_get_attachment_uris;

    /// Finishes the operation started with `edatacal.CalBackend.getAttachmentUris`.
    ///
    /// The requested attachment URI strings are deposited in `out_attachment_uris`.
    /// Free the returned strings with `glib.free` when finished with them.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_cal_backend_get_attachment_uris_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_out_attachment_uris: *glib.Queue, p_error: ?*?*glib.Error) c_int;
    pub const getAttachmentUrisFinish = e_cal_backend_get_attachment_uris_finish;

    /// Inspects the iCalendar object specified by `uid` and, optionally, `rid`
    /// for attachments and deposits a URI string for each attachment in
    /// `out_attachment_uris`.  Free the returned strings with `glib.free` when
    /// finished with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_cal_backend_get_attachment_uris_sync(p_backend: *CalBackend, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_out_attachment_uris: *glib.Queue, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getAttachmentUrisSync = e_cal_backend_get_attachment_uris_sync;

    /// Obtains the value of the backend property named `prop_name`.
    /// Freed the returned string with `glib.free` when finished with it.
    extern fn e_cal_backend_get_backend_property(p_backend: *CalBackend, p_prop_name: [*:0]const u8) [*:0]u8;
    pub const getBackendProperty = e_cal_backend_get_backend_property;

    /// Returns the cache directory path used by `backend`.
    extern fn e_cal_backend_get_cache_dir(p_backend: *CalBackend) [*:0]const u8;
    pub const getCacheDir = e_cal_backend_get_cache_dir;

    /// Asynchronously obtains a free/busy object for the list of `users` in the
    /// time interval between `start` and `end`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `edatacal.CalBackend.getFreeBusyFinish` to get the result of
    /// the operation.
    extern fn e_cal_backend_get_free_busy(p_backend: *CalBackend, p_start: std.posix.time_t, p_end: std.posix.time_t, p_users: [*]const [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getFreeBusy = e_cal_backend_get_free_busy;

    /// Finishes the operation started with `edatacal.CalBackend.getFreeBusy`.
    ///
    /// The free/busy results can be returned through the
    /// `edatacal.DataCal.reportFreeBusyData` function asynchronously. The out_freebusy
    /// will contain all the returned data, possibly again, thus the client is
    /// responsible for the data merge, if needed.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_get_free_busy_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_out_freebusy: **glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const getFreeBusyFinish = e_cal_backend_get_free_busy_finish;

    /// Obtains a free/busy object for the list of `users` in the time interval
    /// between `start` and `end`.
    ///
    /// The free/busy results can be returned through the
    /// `edatacal.DataCal.reportFreeBusyData` function asynchronously. The out_freebusy
    /// will contain all the returned data, possibly again, thus the client is
    /// responsible for the data merge, if needed.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_get_free_busy_sync(p_backend: *CalBackend, p_start: std.posix.time_t, p_end: std.posix.time_t, p_users: [*]const [*:0]const u8, p_out_freebusy: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getFreeBusySync = e_cal_backend_get_free_busy_sync;

    /// Gets the kind of components the given backend stores.
    extern fn e_cal_backend_get_kind(p_backend: *CalBackend) icalglib.ComponentKind;
    pub const getKind = e_cal_backend_get_kind;

    /// Asynchronously obtains an `ecal.Component` by its `uid` and, optionally, `rid`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.getObjectFinish` to get the result of the operation.
    extern fn e_cal_backend_get_object(p_backend: *CalBackend, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getObject = e_cal_backend_get_object;

    /// Finishes the operation started with `edatacal.CalBackend.getObject`.
    ///
    /// The returned string is an iCalendar object describing either single component
    /// or a vCalendar object, which includes also detached instances. It should be
    /// freed when no longer needed.
    ///
    /// If an error occurs, the function will set `error` and return `NULL`.
    extern fn e_cal_backend_get_object_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getObjectFinish = e_cal_backend_get_object_finish;

    /// Asynchronously obtains a set of iCalendar instances which satisfy
    /// the criteria specified in `query`.
    ///
    /// When the operation in finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.getObjectListFinish` to get the result of the
    /// operation.
    extern fn e_cal_backend_get_object_list(p_backend: *CalBackend, p_query: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getObjectList = e_cal_backend_get_object_list;

    /// Finishes the operation started with `edatacal.CalBackend.getObjectList`.
    ///
    /// The matching iCalendar instances are deposited in `out_objects`.
    /// The returned instances should be freed with `glib.free` when finished with them.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_cal_backend_get_object_list_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_out_objects: *glib.Queue, p_error: ?*?*glib.Error) c_int;
    pub const getObjectListFinish = e_cal_backend_get_object_list_finish;

    /// Obtains a set of iCalendar string instances which satisfy the criteria
    /// specified in `query`, and deposits them in `out_objects`.
    ///
    /// The returned instances should be freed with `glib.free` when finished with them.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    /// Note that an empty result set does not necessarily imply an error.
    extern fn e_cal_backend_get_object_list_sync(p_backend: *CalBackend, p_query: [*:0]const u8, p_out_objects: *glib.Queue, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getObjectListSync = e_cal_backend_get_object_list_sync;

    /// Obtains an iCalendar string for an object identified by its `uid` and,
    /// optionally, `rid`.
    ///
    /// The returned string should be freed with `glib.free` when finished with it.
    ///
    /// If an error occurs, the function will set `error` and return `NULL`.
    extern fn e_cal_backend_get_object_sync(p_backend: *CalBackend, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getObjectSync = e_cal_backend_get_object_sync;

    /// Returns the data source registry to which `ebackend.Backend.properties.source` belongs.
    extern fn e_cal_backend_get_registry(p_backend: *CalBackend) *edataserver.SourceRegistry;
    pub const getRegistry = e_cal_backend_get_registry;

    /// Asynchronously obtains the VTIMEZONE object identified by `tzid`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `edatacal.CalBackend.getTimezoneFinish` to get the result of
    /// the operation.
    extern fn e_cal_backend_get_timezone(p_backend: *CalBackend, p_tzid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getTimezone = e_cal_backend_get_timezone;

    /// Finishes the operation started with `edatacal.CalBackend.getTimezone`.
    ///
    /// Free the returned string with `glib.free` when finished with it.
    ///
    /// If an error occurred, the function will set `error` and return `NULL`.
    extern fn e_cal_backend_get_timezone_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getTimezoneFinish = e_cal_backend_get_timezone_finish;

    /// Obtains the VTIMEZONE object identified by `tzid`.  Free the returned
    /// string with `glib.free` when finished with it.
    ///
    /// If an error occurs, the function will set `error` and return `NULL`.
    extern fn e_cal_backend_get_timezone_sync(p_backend: *CalBackend, p_tzid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getTimezoneSync = e_cal_backend_get_timezone_sync;

    /// Returns whether `backend` will accept changes to its data content.
    extern fn e_cal_backend_get_writable(p_backend: *CalBackend) c_int;
    pub const getWritable = e_cal_backend_get_writable;

    /// Checks if `backend`'s storage has been opened (and
    /// authenticated, if necessary) and the backend itself
    /// is ready for accessing. This property is changed automatically
    /// after the `backend` is successfully opened.
    extern fn e_cal_backend_is_opened(p_backend: *CalBackend) c_int;
    pub const isOpened = e_cal_backend_is_opened;

    extern fn e_cal_backend_is_readonly(p_backend: *CalBackend) c_int;
    pub const isReadonly = e_cal_backend_is_readonly;

    /// Returns a list of `edatacal.DataCalView` instances added with
    /// `edatacal.CalBackend.addView`.
    ///
    /// The views returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned list itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_cal_backend_list_views(p_backend: *CalBackend) *glib.List;
    pub const listViews = e_cal_backend_list_views;

    /// Asynchronously modifies one or more iCalendar objects according to
    /// `calobjs` and `mod`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.modifyObjectsFinish` to get the result of the
    /// operation.
    extern fn e_cal_backend_modify_objects(p_backend: *CalBackend, p_calobjs: *const [*:0]const u8, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const modifyObjects = e_cal_backend_modify_objects;

    /// Finishes the operation started with `edatacal.CalBackend.modifyObjects`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_modify_objects_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const modifyObjectsFinish = e_cal_backend_modify_objects_finish;

    /// Modifies one or more iCalendar objects according to `calobjs` and `mod`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_modify_objects_sync(p_backend: *CalBackend, p_calobjs: *const [*:0]const u8, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const modifyObjectsSync = e_cal_backend_modify_objects_sync;

    /// Notifies each of the backend's listeners about a new object.
    ///
    /// Uses the `edatacal.DataCalView`'s fields-of-interest to filter out unwanted
    /// information from ical strings sent over the bus.
    extern fn e_cal_backend_notify_component_created(p_backend: *CalBackend, p_component: *ecal.Component) void;
    pub const notifyComponentCreated = e_cal_backend_notify_component_created;

    /// Notifies each of the backend's listeners about a modified object.
    ///
    /// Uses the `edatacal.DataCalView`'s fields-of-interest to filter out unwanted
    /// information from ical strings sent over the bus.
    extern fn e_cal_backend_notify_component_modified(p_backend: *CalBackend, p_old_component: *ecal.Component, p_new_component: *ecal.Component) void;
    pub const notifyComponentModified = e_cal_backend_notify_component_modified;

    /// Notifies each of the backend's listeners about a removed object.
    ///
    /// Uses the `edatacal.DataCalView`'s fields-of-interest to filter out unwanted
    /// information from ical strings sent over the bus.
    extern fn e_cal_backend_notify_component_removed(p_backend: *CalBackend, p_id: *const ecal.ComponentId, p_old_component: *ecal.Component, p_new_component: *ecal.Component) void;
    pub const notifyComponentRemoved = e_cal_backend_notify_component_removed;

    /// Notifies each of the backend's listeners about an error
    extern fn e_cal_backend_notify_error(p_backend: *CalBackend, p_message: [*:0]const u8) void;
    pub const notifyError = e_cal_backend_notify_error;

    /// Notifies client about property value change.
    extern fn e_cal_backend_notify_property_changed(p_backend: *CalBackend, p_prop_name: [*:0]const u8, p_prop_value: ?[*:0]const u8) void;
    pub const notifyPropertyChanged = e_cal_backend_notify_property_changed;

    /// Asynchronously "opens" the `backend`.  Opening a backend is something of
    /// an outdated concept, but the operation is hanging around for a little
    /// while longer.  This usually involves some custom initialization logic,
    /// and testing of remote authentication if applicable.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.openFinish` to get the result of the operation.
    extern fn e_cal_backend_open(p_backend: *CalBackend, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const open = e_cal_backend_open;

    /// Finishes the operation started with `edatacal.CalBackend.open`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_open_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const openFinish = e_cal_backend_open_finish;

    /// "Opens" the `backend`.  Opening a backend is something of an outdated
    /// concept, but the operation is hanging around for a little while longer.
    /// This usually involves some custom initialization logic, and testing of
    /// remote authentication if applicable.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_open_sync(p_backend: *CalBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const openSync = e_cal_backend_open_sync;

    /// Obtains the `gio.Task` for `opid`.
    ///
    /// <note>
    ///   <para>
    ///     This is a temporary function to serve `edatacal.DataCal`'s "respond"
    ///     functions until they can be removed.  Nothing else should be
    ///     calling this function.
    ///   </para>
    /// </note>
    extern fn e_cal_backend_prepare_for_completion(p_backend: *CalBackend, p_opid: c_uint) *gio.Task;
    pub const prepareForCompletion = e_cal_backend_prepare_for_completion;

    /// Asynchronously receives the set of iCalendar objects specified by
    /// `calobj`.  This is used for iTIP confirmation and cancellation messages
    /// for scheduled meetings.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.receiveObjectsFinish` to get the result of the
    /// operation.
    extern fn e_cal_backend_receive_objects(p_backend: *CalBackend, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const receiveObjects = e_cal_backend_receive_objects;

    /// Finishes the operation started with `edatacal.CalBackend.receiveObjects`.
    ///
    /// If an error occurred, the function will set `error` and erturn `FALSE`.
    extern fn e_cal_backend_receive_objects_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const receiveObjectsFinish = e_cal_backend_receive_objects_finish;

    /// Receives the set of iCalendar objects specified by `calobj`.  This is used
    /// for iTIP confirmation and cancellation messages for scheduled meetings.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_receive_objects_sync(p_backend: *CalBackend, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const receiveObjectsSync = e_cal_backend_receive_objects_sync;

    /// Returns the `edatacal.DataCal` for `backend`.  The `edatacal.DataCal` is essentially
    /// the glue between incoming D-Bus requests and `backend`'s native API.
    ///
    /// An `edatacal.DataCal` should be set only once after `backend` is first created.
    /// If an `edatacal.DataCal` has not yet been set, the function returns `NULL`.
    ///
    /// The returned `edatacal.DataCal` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_cal_backend_ref_data_cal(p_backend: *CalBackend) ?*edatacal.DataCal;
    pub const refDataCal = e_cal_backend_ref_data_cal;

    /// Returns the `gio.ProxyResolver` for `backend` (if applicable), as indicated
    /// by the `edataserver.SourceAuthentication.properties.proxy`-uid of `backend`'s `ebackend.Backend.properties.source`
    /// or one of its ancestors.
    ///
    /// The returned `gio.ProxyResolver` is referenced for thread-safety and must
    /// be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_cal_backend_ref_proxy_resolver(p_backend: *CalBackend) ?*gio.ProxyResolver;
    pub const refProxyResolver = e_cal_backend_ref_proxy_resolver;

    /// Asynchronously initiates a refresh for `backend`, if the `backend` supports
    /// refreshing.  The actual refresh operation completes on its own time.  This
    /// function, along with `edatacal.CalBackend.refreshFinish`, merely initiates the
    /// operation.
    ///
    /// Once the refresh is initiated, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.refreshFinish` to get the result of the initiation.
    extern fn e_cal_backend_refresh(p_backend: *CalBackend, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const refresh = e_cal_backend_refresh;

    /// Finishes the refresh initiation started with `edatacal.CalBackend.refresh`.
    ///
    /// If an error occurred while initiating the refresh, the function will set
    /// `error` and return `FALSE`.  If the `backend` does not support refreshing,
    /// the function will set an `E_CLIENT_ERROR_NOT_SUPPORTED` error and return
    /// `FALSE`.
    extern fn e_cal_backend_refresh_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const refreshFinish = e_cal_backend_refresh_finish;

    /// Initiates a refresh for `backend`, if the `backend` supports refreshing.
    /// The actual refresh operation completes on its own time.  This function
    /// merely initiates the operation.
    ///
    /// If an error occrs while initiating the refresh, the function will set
    /// `error` and return `FALSE`.  If the `backend` does not support refreshing,
    /// the function will set an `E_CLIENT_ERROR_NOT_SUPPORTED` error and return
    /// `FALSE`.
    extern fn e_cal_backend_refresh_sync(p_backend: *CalBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshSync = e_cal_backend_refresh_sync;

    /// Asynchronously removes one or more iCalendar objects according to
    /// `component_ids` and `mod`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.removeObjectsFinish` to get the result of the
    /// operation.
    extern fn e_cal_backend_remove_objects(p_backend: *CalBackend, p_component_ids: *glib.List, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const removeObjects = e_cal_backend_remove_objects;

    /// Finishes the operation started with `edatacal.CalBackend.removeObjects`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_remove_objects_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeObjectsFinish = e_cal_backend_remove_objects_finish;

    /// Removes one or more iCalendar objects according to `component_ids` and `mod`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_cal_backend_remove_objects_sync(p_backend: *CalBackend, p_component_ids: *glib.List, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeObjectsSync = e_cal_backend_remove_objects_sync;

    /// Removes view from the list of live views for the backend.
    extern fn e_cal_backend_remove_view(p_backend: *CalBackend, p_view: *edatacal.DataCalView) void;
    pub const removeView = e_cal_backend_remove_view;

    /// Schedules user function `func` to be run in a dedicated thread as
    /// a blocking operation.
    ///
    /// The function adds its own reference to `use_cancellable`, if not `NULL`.
    ///
    /// The error returned from `func` is propagated to client using
    /// `edatacal.CalBackend.notifyError` function. If it's not desired,
    /// then left the error unchanged and notify about errors manually.
    extern fn e_cal_backend_schedule_custom_operation(p_cal_backend: *CalBackend, p_use_cancellable: ?*gio.Cancellable, p_func: edatacal.CalBackendCustomOpFunc, p_user_data: ?*anyopaque, p_user_data_free: ?glib.DestroyNotify) void;
    pub const scheduleCustomOperation = e_cal_backend_schedule_custom_operation;

    /// Asynchronously sends meeting information in `calobj`.  The `backend` may
    /// modify `calobj` and send meeting information only to particular users.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edatacal.CalBackend.sendObjectsFinish` to get the result of the operation.
    extern fn e_cal_backend_send_objects(p_backend: *CalBackend, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const sendObjects = e_cal_backend_send_objects;

    /// Finishes the operation started with `edatacal.CalBackend.sendObjects`.
    ///
    /// The function returns a string representation of a sent, or to be send,
    /// vCalendar and deposits the list of users the meeting information was sent
    /// to, or to be send to, in `out_users`.
    ///
    /// Free the returned pointer with `glib.free`, when no longer needed.
    ///
    /// If an error occurs, the function will set `error` and return `NULL`.
    extern fn e_cal_backend_send_objects_finish(p_backend: *CalBackend, p_result: *gio.AsyncResult, p_out_users: *glib.Queue, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const sendObjectsFinish = e_cal_backend_send_objects_finish;

    /// Sends meeting information in `calobj`.  The `backend` may modify `calobj`
    /// and send meeting information only to particular users.  The function
    /// returns the (maybe) modified `calobj` and deposits the list of users the
    /// meeting information was sent (to be send) to in `out_users`.
    ///
    /// The returned pointer should be freed with `glib.free`, when no londer needed.
    ///
    /// If an error occurs, the function will set `error` and return `NULL`.
    extern fn e_cal_backend_send_objects_sync(p_backend: *CalBackend, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_out_users: *glib.Queue, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const sendObjectsSync = e_cal_backend_send_objects_sync;

    /// Sets the cache directory path for use by `backend`.
    ///
    /// Note that `edatacal.CalBackend` is initialized with a default cache directory
    /// path which should suffice for most cases.  Backends should not override
    /// the default path without good reason.
    extern fn e_cal_backend_set_cache_dir(p_backend: *CalBackend, p_cache_dir: [*:0]const u8) void;
    pub const setCacheDir = e_cal_backend_set_cache_dir;

    /// Sets the `edatacal.DataCal` for `backend`.  The `edatacal.DataCal` is essentially the
    /// glue between incoming D-Bus requests and `backend`'s native API.
    ///
    /// An `edatacal.DataCal` should be set only once after `backend` is first created.
    ///
    /// The `backend` adds its own reference on the `data_cal`.
    extern fn e_cal_backend_set_data_cal(p_backend: *CalBackend, p_data_cal: *edatacal.DataCal) void;
    pub const setDataCal = e_cal_backend_set_data_cal;

    /// Sets whether `backend` will accept changes to its data content.
    extern fn e_cal_backend_set_writable(p_backend: *CalBackend, p_writable: c_int) void;
    pub const setWritable = e_cal_backend_set_writable;

    /// Starts a new live view on the given backend.
    extern fn e_cal_backend_start_view(p_backend: *CalBackend, p_view: *edatacal.DataCalView) void;
    pub const startView = e_cal_backend_start_view;

    /// Stops a previously started live view on the given backend.
    extern fn e_cal_backend_stop_view(p_backend: *CalBackend, p_view: *edatacal.DataCalView) void;
    pub const stopView = e_cal_backend_stop_view;

    extern fn e_cal_backend_get_type() usize;
    pub const getGObjectType = e_cal_backend_get_type;

    extern fn g_object_ref(p_self: *edatacal.CalBackend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.CalBackend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CalBackend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CalBackendFactory = extern struct {
    pub const Parent = ebackend.BackendFactory;
    pub const Implements = [_]type{};
    pub const Class = edatacal.CalBackendFactoryClass;
    f_parent: ebackend.BackendFactory,
    f_priv: ?*edatacal.CalBackendFactoryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_cal_backend_factory_get_type() usize;
    pub const getGObjectType = e_cal_backend_factory_get_type;

    extern fn g_object_ref(p_self: *edatacal.CalBackendFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.CalBackendFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CalBackendFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalBackendSExp = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edatacal.CalBackendSExpClass;
    f_parent: gobject.Object,
    f_priv: ?*edatacal.CalBackendSExpPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// (make-time ISODATE)
    /// ISODATE - string, ISO 8601 date/time representation
    ///
    /// Constructs a time_t value for the specified date.
    extern fn e_cal_backend_sexp_func_make_time(p_esexp: *anyopaque, p_argc: c_int, p_argv: *anyopaque, p_data: ?*anyopaque) *anyopaque;
    pub const funcMakeTime = e_cal_backend_sexp_func_make_time;

    /// (time-add-day TIME N)
    /// TIME - time_t, base time
    /// N - int, number of days to add
    ///
    /// Adds the specified number of days to a time value.
    ///
    /// FIXME: TIMEZONES - need to use a timezone or daylight saving changes will
    /// make the result incorrect.
    extern fn e_cal_backend_sexp_func_time_add_day(p_esexp: *anyopaque, p_argc: c_int, p_argv: *anyopaque, p_data: ?*anyopaque) *anyopaque;
    pub const funcTimeAddDay = e_cal_backend_sexp_func_time_add_day;

    /// (time-day-begin TIME)
    /// TIME - time_t, base time
    ///
    /// Returns the start of the day, according to the local time.
    ///
    /// FIXME: TIMEZONES - this uses the current Unix timezone.
    extern fn e_cal_backend_sexp_func_time_day_begin(p_esexp: *anyopaque, p_argc: c_int, p_argv: *anyopaque, p_data: ?*anyopaque) *anyopaque;
    pub const funcTimeDayBegin = e_cal_backend_sexp_func_time_day_begin;

    /// (time-day-end TIME)
    /// TIME - time_t, base time
    ///
    /// Returns the end of the day, according to the local time.
    ///
    /// FIXME: TIMEZONES - this uses the current Unix timezone.
    extern fn e_cal_backend_sexp_func_time_day_end(p_esexp: *anyopaque, p_argc: c_int, p_argv: *anyopaque, p_data: ?*anyopaque) *anyopaque;
    pub const funcTimeDayEnd = e_cal_backend_sexp_func_time_day_end;

    /// Processes the (time-now) sexp expression.
    extern fn e_cal_backend_sexp_func_time_now(p_esexp: *anyopaque, p_argc: c_int, p_argv: *anyopaque, p_data: ?*anyopaque) *anyopaque;
    pub const funcTimeNow = e_cal_backend_sexp_func_time_now;

    extern fn e_cal_backend_sexp_new(p_text: [*:0]const u8) *edatacal.CalBackendSExp;
    pub const new = e_cal_backend_sexp_new;

    /// Determines biggest time window given by expressions "occur-in-range" in sexp.
    extern fn e_cal_backend_sexp_evaluate_occur_times(p_sexp: *CalBackendSExp, p_start: *std.posix.time_t, p_end: *std.posix.time_t) c_int;
    pub const evaluateOccurTimes = e_cal_backend_sexp_evaluate_occur_times;

    /// Locks the `sexp`. Other threads cannot use it until
    /// it's unlocked with `edatacal.CalBackendSExp.unlock`.
    extern fn e_cal_backend_sexp_lock(p_sexp: *CalBackendSExp) void;
    pub const lock = e_cal_backend_sexp_lock;

    /// Checks if `comp` matches `sexp`.
    extern fn e_cal_backend_sexp_match_comp(p_sexp: *CalBackendSExp, p_comp: *ecal.Component, p_cache: *ecal.TimezoneCache) c_int;
    pub const matchComp = e_cal_backend_sexp_match_comp;

    /// Checks if `object` matches `sexp`.
    extern fn e_cal_backend_sexp_match_object(p_sexp: *CalBackendSExp, p_object: [*:0]const u8, p_cache: *ecal.TimezoneCache) c_int;
    pub const matchObject = e_cal_backend_sexp_match_object;

    /// Retrieve the text expression for the given `edatacal.CalBackendSExp` object.
    extern fn e_cal_backend_sexp_text(p_sexp: *CalBackendSExp) [*:0]const u8;
    pub const text = e_cal_backend_sexp_text;

    /// Unlocks the `sexp`, previously locked by `edatacal.CalBackendSExp.lock`.
    extern fn e_cal_backend_sexp_unlock(p_sexp: *CalBackendSExp) void;
    pub const unlock = e_cal_backend_sexp_unlock;

    extern fn e_cal_backend_sexp_get_type() usize;
    pub const getGObjectType = e_cal_backend_sexp_get_type;

    extern fn g_object_ref(p_self: *edatacal.CalBackendSExp) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.CalBackendSExp) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CalBackendSExp, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CalBackendSync = extern struct {
    pub const Parent = edatacal.CalBackend;
    pub const Implements = [_]type{ecal.TimezoneCache};
    pub const Class = edatacal.CalBackendSyncClass;
    f_parent: edatacal.CalBackend,
    f_priv: ?*edatacal.CalBackendSyncPrivate,

    pub const virtual_methods = struct {
        /// Add specified timezone
        pub const add_timezone_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_tzobject: [*:0]const u8, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_add_timezone_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_tzobject, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_tzobject: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_add_timezone_sync = @ptrCast(p_implementation);
            }
        };

        /// Create objects
        pub const create_objects_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_opflags: ecal.OperationFlags, p_uids: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_create_objects_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_calobjs, p_opflags, p_uids, p_new_components, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_opflags: ecal.OperationFlags, p_uids: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_create_objects_sync = @ptrCast(p_implementation);
            }
        };

        /// Discard alarm
        pub const discard_alarm_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_discard_alarm_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_uid, p_rid, p_auid, p_opflags, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_discard_alarm_sync = @ptrCast(p_implementation);
            }
        };

        /// Get attachments uris for given object
        pub const get_attachment_uris_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_attachments: **glib.SList, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_get_attachment_uris_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_uid, p_rid, p_attachments, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_attachments: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_get_attachment_uris_sync = @ptrCast(p_implementation);
            }
        };

        /// Get Free/Busy objects
        pub const get_free_busy_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_users: *const glib.SList, p_start: std.posix.time_t, p_end: std.posix.time_t, p_freebusyobjs: **glib.SList, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_get_free_busy_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_users, p_start, p_end, p_freebusyobjs, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_users: *const glib.SList, p_start: std.posix.time_t, p_end: std.posix.time_t, p_freebusyobjs: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_get_free_busy_sync = @ptrCast(p_implementation);
            }
        };

        /// Get multiple objects at once
        pub const get_object_list_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_sexp: [*:0]const u8, p_calobjs: **glib.SList, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_get_object_list_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_sexp, p_calobjs, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_sexp: [*:0]const u8, p_calobjs: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_get_object_list_sync = @ptrCast(p_implementation);
            }
        };

        /// Get single object
        pub const get_object_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_calobj: *[*:0]u8, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_get_object_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_uid, p_rid, p_calobj, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_calobj: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_get_object_sync = @ptrCast(p_implementation);
            }
        };

        /// Get specified timezone
        pub const get_timezone_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_tzid: [*:0]const u8, p_tzobject: *[*:0]u8, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_get_timezone_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_tzid, p_tzobject, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_tzid: [*:0]const u8, p_tzobject: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_get_timezone_sync = @ptrCast(p_implementation);
            }
        };

        /// Modify objects
        pub const modify_objects_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_old_components: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_modify_objects_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_calobjs, p_mod, p_opflags, p_old_components, p_new_components, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_old_components: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_modify_objects_sync = @ptrCast(p_implementation);
            }
        };

        /// Open the calendar
        pub const open_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_open_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_open_sync = @ptrCast(p_implementation);
            }
        };

        /// Receive objects
        pub const receive_objects_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_receive_objects_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_calobj, p_opflags, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_receive_objects_sync = @ptrCast(p_implementation);
            }
        };

        /// Refresh the calendar
        pub const refresh_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_refresh_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_refresh_sync = @ptrCast(p_implementation);
            }
        };

        /// Remove objects
        pub const remove_objects_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_old_components: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_remove_objects_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_ids, p_mod, p_opflags, p_old_components, p_new_components, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_old_components: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_remove_objects_sync = @ptrCast(p_implementation);
            }
        };

        /// Send objects
        pub const send_objects_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_users: **glib.SList, p_modified_calobj: *[*:0]u8, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(CalBackendSync.Class, p_class).f_send_objects_sync.?(gobject.ext.as(CalBackendSync, p_backend), p_cal, p_cancellable, p_calobj, p_opflags, p_users, p_modified_calobj, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_users: **glib.SList, p_modified_calobj: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(CalBackendSync.Class, p_class).f_send_objects_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Calls the add_timezone_sync method on the given backend.
    extern fn e_cal_backend_sync_add_timezone(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_tzobject: [*:0]const u8, p_error: ?*?*glib.Error) void;
    pub const addTimezone = e_cal_backend_sync_add_timezone;

    /// Calls the create_objects_sync method on the given backend.
    extern fn e_cal_backend_sync_create_objects(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_opflags: ecal.OperationFlags, p_uids: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) void;
    pub const createObjects = e_cal_backend_sync_create_objects;

    /// Calls the discard_alarm_sync method on the given backend.
    extern fn e_cal_backend_sync_discard_alarm(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags, p_error: ?*?*glib.Error) void;
    pub const discardAlarm = e_cal_backend_sync_discard_alarm;

    /// Calls the get_attachment_uris_sync method on the given backend.
    extern fn e_cal_backend_sync_get_attachment_uris(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_attachments: **glib.SList, p_error: ?*?*glib.Error) void;
    pub const getAttachmentUris = e_cal_backend_sync_get_attachment_uris;

    /// Calls the get_free_busy_sync method on the given backend.
    extern fn e_cal_backend_sync_get_free_busy(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_users: *const glib.SList, p_start: std.posix.time_t, p_end: std.posix.time_t, p_freebusyobjects: **glib.SList, p_error: ?*?*glib.Error) void;
    pub const getFreeBusy = e_cal_backend_sync_get_free_busy;

    /// Calls the get_object_sync method on the given backend.
    extern fn e_cal_backend_sync_get_object(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_calobj: *[*:0]u8, p_error: ?*?*glib.Error) void;
    pub const getObject = e_cal_backend_sync_get_object;

    /// Calls the get_object_list_sync method on the given backend.
    extern fn e_cal_backend_sync_get_object_list(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_sexp: [*:0]const u8, p_calobjs: **glib.SList, p_error: ?*?*glib.Error) void;
    pub const getObjectList = e_cal_backend_sync_get_object_list;

    /// Calls the get_timezone_sync method on the given backend.
    /// This method is not mandatory on the backend, because here
    /// is used internal_get_timezone call to fetch timezone from
    /// it and that is transformed to a string. In other words,
    /// any object deriving from ECalBackendSync can implement only
    /// internal_get_timezone and can skip implementation of
    /// get_timezone_sync completely.
    extern fn e_cal_backend_sync_get_timezone(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_tzid: [*:0]const u8, p_tzobject: *[*:0]u8, p_error: ?*?*glib.Error) void;
    pub const getTimezone = e_cal_backend_sync_get_timezone;

    /// Calls the modify_objects_sync method on the given backend.
    extern fn e_cal_backend_sync_modify_objects(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_old_components: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) void;
    pub const modifyObjects = e_cal_backend_sync_modify_objects;

    /// Calls the open_sync method on the given backend.
    extern fn e_cal_backend_sync_open(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) void;
    pub const open = e_cal_backend_sync_open;

    /// Calls the receive_objects_sync method on the given backend.
    extern fn e_cal_backend_sync_receive_objects(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_error: ?*?*glib.Error) void;
    pub const receiveObjects = e_cal_backend_sync_receive_objects;

    /// Calls the refresh_sync method on the given backend.
    extern fn e_cal_backend_sync_refresh(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) void;
    pub const refresh = e_cal_backend_sync_refresh;

    /// Calls the remove_objects_sync method on the given backend.
    extern fn e_cal_backend_sync_remove_objects(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_old_components: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) void;
    pub const removeObjects = e_cal_backend_sync_remove_objects;

    /// Calls the send_objects_sync method on the given backend.
    extern fn e_cal_backend_sync_send_objects(p_backend: *CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_users: **glib.SList, p_modified_calobj: *[*:0]u8, p_error: ?*?*glib.Error) void;
    pub const sendObjects = e_cal_backend_sync_send_objects;

    extern fn e_cal_backend_sync_get_type() usize;
    pub const getGObjectType = e_cal_backend_sync_get_type;

    extern fn g_object_ref(p_self: *edatacal.CalBackendSync) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.CalBackendSync) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CalBackendSync, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using
/// the functions below.
pub const CalCache = extern struct {
    pub const Parent = ebackend.Cache;
    pub const Implements = [_]type{ ecal.TimezoneCache, edataserver.Extensible };
    pub const Class = edatacal.CalCacheClass;
    f_parent: ebackend.Cache,
    f_priv: ?*edatacal.CalCachePrivate,

    pub const virtual_methods = struct {
        /// Returns the `icomp` revision, used to detect changes.
        /// The returned string should be freed with `glib.free`, when
        /// no longer needed.
        pub const dup_component_revision = struct {
            pub fn call(p_class: anytype, p_cal_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_icomp: *icalglib.Component) [*:0]u8 {
                return gobject.ext.as(CalCache.Class, p_class).f_dup_component_revision.?(gobject.ext.as(CalCache, p_cal_cache), p_icomp);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cal_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_icomp: *icalglib.Component) callconv(.c) [*:0]u8) void {
                gobject.ext.as(CalCache.Class, p_class).f_dup_component_revision = @ptrCast(p_implementation);
            }
        };

        pub const get_timezone = struct {
            pub fn call(p_class: anytype, p_cal_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_tzid: [*:0]const u8) *icalglib.Timezone {
                return gobject.ext.as(CalCache.Class, p_class).f_get_timezone.?(gobject.ext.as(CalCache, p_cal_cache), p_tzid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cal_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_tzid: [*:0]const u8) callconv(.c) *icalglib.Timezone) void {
                gobject.ext.as(CalCache.Class, p_class).f_get_timezone = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const dup_component_revision = struct {
            pub const name = "dup-component-revision";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *icalglib.Component, P_Data) callconv(.c) [*:0]u8, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CalCache, p_instance))),
                    gobject.signalLookup("dup-component-revision", CalCache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// A signal being called to get timezone when putting component
        /// into the cache. It's used to make sure the cache contains
        /// all timezones which are needed by the component. The returned
        /// ICalTimezone will not be freed.
        pub const get_timezone = struct {
            pub const name = "get-timezone";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tzid: [*:0]u8, P_Data) callconv(.c) *icalglib.Timezone, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CalCache, p_instance))),
                    gobject.signalLookup("get-timezone", CalCache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// An `ecal.RecurResolveTimezoneCb` callback, which can be used
    /// with `ecal.recurGenerateInstancesSync`. The `cal_cache`
    /// is supposed to be an `edatacal.CalCache` instance.
    extern fn e_cal_cache_resolve_timezone_cb(p_tzid: [*:0]const u8, p_cal_cache: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*icalglib.Timezone;
    pub const resolveTimezoneCb = e_cal_cache_resolve_timezone_cb;

    /// Creates a new `edatacal.CalCache`.
    extern fn e_cal_cache_new(p_filename: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatacal.CalCache;
    pub const new = e_cal_cache_new;

    /// Checkes whether the `cal_cache` contains an object with
    /// the given `uid` and `rid`. The `rid` can be an empty string
    /// or `NULL` to search for the master object, otherwise the check
    /// is done for a detached instance, not for a recurrence instance.
    extern fn e_cal_cache_contains(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_deleted_flag: ebackend.CacheDeletedFlag) c_int;
    pub const contains = e_cal_cache_contains;

    /// Deletes all locally stored attachments beside the cache file from the disk.
    /// This doesn't modify the `component`. It's usually called before the `component`
    /// is being removed from the `cal_cache`.
    extern fn e_cal_cache_delete_attachments(p_cal_cache: *CalCache, p_component: *icalglib.Component, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deleteAttachments = e_cal_cache_delete_attachments;

    /// Returns the `icomp` revision, used to detect changes.
    /// The returned string should be freed with `glib.free`, when
    /// no longer needed.
    extern fn e_cal_cache_dup_component_revision(p_cal_cache: *CalCache, p_icomp: *icalglib.Component) [*:0]u8;
    pub const dupComponentRevision = e_cal_cache_dup_component_revision;

    /// Gets a timezone with given `tzid`, which had been previously put
    /// into the `cal_cache` with `edatacal.CalCache.putTimezone`.
    /// The returned string is an iCal string for that ICalTimezone and
    /// should be freed with `glib.free` when no longer needed.
    extern fn e_cal_cache_dup_timezone_as_string(p_cal_cache: *CalCache, p_tzid: [*:0]const u8, p_out_zone_string: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dupTimezoneAsString = e_cal_cache_dup_timezone_as_string;

    /// Gets a component identified by `uid`, and optionally by the `rid`,
    /// from the `cal_cache`. The returned `out_component` should be freed with
    /// `gobject.Object.unref`, when no longer needed.
    extern fn e_cal_cache_get_component(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_out_component: **ecal.Component, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getComponent = e_cal_cache_get_component;

    /// Gets a component identified by `uid`, and optionally by the `rid`,
    /// from the `cal_cache`. The returned `out_icalstring` should be freed with
    /// `glib.free`, when no longer needed.
    extern fn e_cal_cache_get_component_as_string(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_out_icalstring: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getComponentAsString = e_cal_cache_get_component_as_string;

    /// Gets the custom flags previously set for `uid` and `rid`, either with
    /// `edatacal.CalCache.setComponentCustomFlags`, when adding components or
    /// when removing components in offline.
    extern fn e_cal_cache_get_component_custom_flags(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_out_custom_flags: *u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getComponentCustomFlags = e_cal_cache_get_component_custom_flags;

    /// Gets the extra data previously set for `uid` and `rid`, either with
    /// `edatacal.CalCache.setComponentExtra` or when adding components.
    extern fn e_cal_cache_get_component_extra(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getComponentExtra = e_cal_cache_get_component_extra;

    /// Gets the master object and all detached instances for a component
    /// identified by the `uid`. Free the returned `glib.SList` with
    /// g_slist_free_full (components, g_object_unref); when
    /// no longer needed.
    extern fn e_cal_cache_get_components_by_uid(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_out_components: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getComponentsByUid = e_cal_cache_get_components_by_uid;

    /// Gets the master object and all detached instances as string
    /// for a component identified by the `uid`. Free the returned `glib.SList`
    /// with g_slist_free_full (icalstrings, g_free); when no longer needed.
    extern fn e_cal_cache_get_components_by_uid_as_string(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_out_icalstrings: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getComponentsByUidAsString = e_cal_cache_get_components_by_uid_as_string;

    /// Gets a list of components which occur in the given time range.
    /// It's not an error if none is found.
    extern fn e_cal_cache_get_components_in_range(p_cal_cache: *CalCache, p_range_start: std.posix.time_t, p_range_end: std.posix.time_t, p_out_components: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getComponentsInRange = e_cal_cache_get_components_in_range;

    /// Gets a list of components, as iCal strings, which occur in the given time range.
    extern fn e_cal_cache_get_components_in_range_as_strings(p_cal_cache: *CalCache, p_range_start: std.posix.time_t, p_range_end: std.posix.time_t, p_out_icalstrings: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getComponentsInRangeAsStrings = e_cal_cache_get_components_in_range_as_strings;

    /// Gets all the ID-s the `extra` data is set for.
    ///
    /// The `out_ids` should be freed with
    /// g_slist_free_full (ids, (GDestroyNotify) e_cal_component_id_free);
    /// when no longer needed.
    extern fn e_cal_cache_get_ids_with_extra(p_cal_cache: *CalCache, p_extra: [*:0]const u8, p_out_ids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getIdsWithExtra = e_cal_cache_get_ids_with_extra;

    /// The same as `ebackend.Cache.getOfflineChanges`, only splits the saved UID
    /// into UID and RID and saved the data into `edatacal.CalCacheOfflineChange` structure.
    extern fn e_cal_cache_get_offline_changes(p_cal_cache: *CalCache, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.SList;
    pub const getOfflineChanges = e_cal_cache_get_offline_changes;

    /// This is a wrapper of `ebackend.Cache.getOfflineState`, ensuring that
    /// a correct `ebackend.Cache` UID will be used.
    extern fn e_cal_cache_get_offline_state(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ebackend.OfflineState;
    pub const getOfflineState = e_cal_cache_get_offline_state;

    /// Gets a timezone with given `tzid`, which had been previously put
    /// into the `cal_cache` with `edatacal.CalCache.putTimezone`.
    /// The returned ICalTimezone is owned by the `cal_cache` and should
    /// not be freed.
    extern fn e_cal_cache_get_timezone(p_cal_cache: *CalCache, p_tzid: [*:0]const u8, p_out_zone: **icalglib.Timezone, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getTimezone = e_cal_cache_get_timezone;

    /// Gets a list of all stored timezones by the `cal_cache`.
    /// Only the returned list should be freed with `glib.List.free`
    /// when no longer needed; the `ICalTimezone`-s are owned
    /// by the `cal_cache`.
    ///
    /// Note: The list can contain timezones previously stored
    /// in the cache, but removed from it since they were loaded,
    /// because these are freed only when also the `cal_cache` is freed.
    extern fn e_cal_cache_list_timezones(p_cal_cache: *CalCache, p_out_timezones: **glib.List, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const listTimezones = e_cal_cache_list_timezones;

    /// Adds a `component` into the `cal_cache`. Any existing with the same UID
    /// and RID is replaced.
    extern fn e_cal_cache_put_component(p_cal_cache: *CalCache, p_component: *ecal.Component, p_extra: ?[*:0]const u8, p_custom_flags: u32, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const putComponent = e_cal_cache_put_component;

    /// Adds a list of `components` into the `cal_cache`. Any existing with the same UID
    /// and RID are replaced.
    ///
    /// If `extras` is not `NULL`, its length should be the same as the length
    /// of the `components`. Similarly the non-NULL `custom_flags` length
    /// should be the same as the length of the `components`.
    extern fn e_cal_cache_put_components(p_cal_cache: *CalCache, p_components: *const glib.SList, p_extras: ?*const glib.SList, p_custom_flags: ?*const glib.SList, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const putComponents = e_cal_cache_put_components;

    /// Puts the `zone` into the `cal_cache` using its timezone ID as
    /// an identificator. The function adds a new or replaces existing,
    /// if any such already exists in the `cal_cache`. The function does
    /// nothing and returns `TRUE`, when the passed-in `zone` is libical
    /// builtin timezone.
    extern fn e_cal_cache_put_timezone(p_cal_cache: *CalCache, p_zone: *const icalglib.Timezone, p_inc_ref_counts: c_uint, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const putTimezone = e_cal_cache_put_timezone;

    /// Removes a component identified by `uid` and `rid` from the `cal_cache`.
    /// When the `rid` is `NULL`, or an empty string, then removes the master
    /// object only, without any detached instance.
    extern fn e_cal_cache_remove_component(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_custom_flags: u32, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeComponent = e_cal_cache_remove_component;

    /// Removes components identified by `uid` and `rid` from the `cal_cache`
    /// in the `ids` list. When the `rid` is `NULL`, or an empty string, then
    /// removes the master object only, without any detached instance.
    /// The `custom_flags` is used, if not `NULL`, only if the `offline_flag`
    /// is `E_CACHE_IS_OFFLINE`. Otherwise it's ignored. The length of
    /// the `custom_flags` should match the length of `ids`, when not `NULL`.
    extern fn e_cal_cache_remove_components(p_cal_cache: *CalCache, p_ids: *const glib.SList, p_custom_flags: ?*const glib.SList, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeComponents = e_cal_cache_remove_components;

    /// Dereferences use count of the time zone with ID `tzid` by `dec_ref_counts`
    /// and removes the timezone from the cache when the reference count reaches
    /// zero. Special case is with `dec_ref_counts` being zero, in which case
    /// the corresponding timezone is removed regardless of the current reference
    /// count.
    ///
    /// It's not an error when the timezone doesn't exist in the cache.
    extern fn e_cal_cache_remove_timezone(p_cal_cache: *CalCache, p_tzid: [*:0]const u8, p_dec_ref_counts: c_uint, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeTimezone = e_cal_cache_remove_timezone;

    /// Removes all stored timezones from the `cal_cache`.
    extern fn e_cal_cache_remove_timezones(p_cal_cache: *CalCache, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeTimezones = e_cal_cache_remove_timezones;

    /// Searches the `cal_cache` with the given `sexp` and
    /// returns those components which satisfy the search
    /// expression as a `glib.SList` of `edatacal.CalCacheSearchData`.
    /// The `out_data` should be freed with
    /// g_slist_free_full (data, e_cal_cache_search_data_free);
    /// when no longer needed.
    extern fn e_cal_cache_search(p_cal_cache: *CalCache, p_sexp: ?[*:0]const u8, p_out_data: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const search = e_cal_cache_search;

    /// Searches the `cal_cache` with the given `sexp` and
    /// returns those components which satisfy the search
    /// expression. The `out_components` should be freed with
    /// g_slist_free_full (components, g_object_unref); when
    /// no longer needed.
    extern fn e_cal_cache_search_components(p_cal_cache: *CalCache, p_sexp: ?[*:0]const u8, p_out_components: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchComponents = e_cal_cache_search_components;

    /// Searches the `cal_cache` with the given `sexp` and returns ECalComponentId
    /// for those components which satisfy the search expression.
    /// The `out_ids` should be freed with
    /// g_slist_free_full (ids, (GDestroyNotify) e_cal_component_id_free);
    /// when no longer needed.
    extern fn e_cal_cache_search_ids(p_cal_cache: *CalCache, p_sexp: ?[*:0]const u8, p_out_ids: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchIds = e_cal_cache_search_ids;

    /// Searches the `cal_cache` with the given `sexp` and calls `func` for each
    /// row which satisfy the search expression.
    extern fn e_cal_cache_search_with_callback(p_cal_cache: *CalCache, p_sexp: ?[*:0]const u8, p_func: edatacal.CalCacheSearchFunc, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchWithCallback = e_cal_cache_search_with_callback;

    /// Sets or replaces the custom flags associated with a component
    /// identified by `uid` and optionally `rid`.
    extern fn e_cal_cache_set_component_custom_flags(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_custom_flags: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setComponentCustomFlags = e_cal_cache_set_component_custom_flags;

    /// Sets or replaces the extra data associated with a component
    /// identified by `uid` and optionally `rid`.
    extern fn e_cal_cache_set_component_extra(p_cal_cache: *CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_extra: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setComponentExtra = e_cal_cache_set_component_extra;

    extern fn e_cal_cache_get_type() usize;
    pub const getGObjectType = e_cal_cache_get_type;

    extern fn g_object_ref(p_self: *edatacal.CalCache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.CalCache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CalCache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using
/// the functions below.
pub const CalMetaBackend = extern struct {
    pub const Parent = edatacal.CalBackendSync;
    pub const Implements = [_]type{ecal.TimezoneCache};
    pub const Class = edatacal.CalMetaBackendClass;
    f_parent: edatacal.CalBackendSync,
    f_priv: ?*edatacal.CalMetaBackendPrivate,

    pub const virtual_methods = struct {
        /// This is called always before any operation which requires a connection
        /// to the remote side. It can fail with an `E_CLIENT_ERROR_REPOSITORY_OFFLINE`
        /// error to indicate that the remote side cannot be currently reached. Other
        /// errors are propagated to the caller/client side. This method is not called
        /// when the backend is offline.
        ///
        /// The descendant should also call `edatacal.CalBackend.setWritable` after successful
        /// connect to the remote side. This value is stored for later use, when being
        /// opened offline.
        ///
        /// The `credentials` parameter consists of the previously used credentials.
        /// It's always `NULL` with the first connection attempt. To get the credentials,
        /// just set the `out_auth_result` to `E_SOURCE_AUTHENTICATION_REQUIRED` for
        /// the first time and the function will be called again once the credentials
        /// are available. See the documentation of `edataserver.SourceAuthenticationResult` for
        /// other available results.
        ///
        /// The out parameters are passed to `ebackend.Backend.scheduleCredentialsRequired`
        /// and are ignored when the descendant returns `TRUE`, aka they are used
        /// only if the connection fails. The `out_certificate_pem` and `out_certificate_errors`
        /// should be used together and they can be left untouched if the failure reason was
        /// not related to certificate. Use `out_auth_result` `E_SOURCE_AUTHENTICATION_UNKNOWN`
        /// to indicate other error than `credentials` error, otherwise the `error` is used
        /// according to `out_auth_result` value.
        ///
        /// It is mandatory to implement this virtual method by the descendant.
        pub const connect_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_credentials: ?*const edataserver.NamedParameters, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_connect_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_credentials, p_out_auth_result, p_out_certificate_pem, p_out_certificate_errors, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_credentials: ?*const edataserver.NamedParameters, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_connect_sync = @ptrCast(p_implementation);
            }
        };

        /// This is called when the backend goes into offline mode or
        /// when the disconnect is required. The implementation should
        /// not report any error when it is called and the `meta_backend`
        /// is not connected.
        ///
        /// It is mandatory to implement this virtual method by the descendant.
        pub const disconnect_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_disconnect_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_disconnect_sync = @ptrCast(p_implementation);
            }
        };

        /// Gathers the changes since the last check which had been done
        /// on the remote side.
        ///
        /// The `last_sync_tag` can be used as a tag of the last check. This can be `NULL`,
        /// when there was no previous call or when the descendant doesn't store any
        /// such tags. The `out_new_sync_tag` can be populated with a value to be stored
        /// and used the next time.
        ///
        /// The `out_repeat` can be set to `TRUE` when the descendant didn't finish
        /// read of all the changes. In that case the `meta_backend` calls this
        /// function again with the `out_new_sync_tag` as the `last_sync_tag`, but also
        /// notifies about the found changes immediately. The `is_repeat` is set
        /// to `TRUE` as well in this case, otherwise it's `FALSE`.
        ///
        /// The descendant can populate also ECalMetaBackendInfo::object of
        /// the `out_created_objects` and `out_modified_objects`, if known, in which
        /// case this will be used instead of loading it with `edatacal.CalMetaBackend.loadComponentSync`.
        ///
        /// It is optional to implement this virtual method by the descendant.
        /// The default implementation calls `edatacal.CalMetaBackend.listExistingSync`
        /// and then compares the list with the current content of the local cache
        /// and populates the respective lists appropriately.
        ///
        /// Each output `glib.SList` should be freed with
        /// g_slist_free_full (objects, e_cal_meta_backend_info_free);
        /// when no longer needed.
        pub const get_changes_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_last_sync_tag: ?[*:0]const u8, p_is_repeat: c_int, p_out_new_sync_tag: *[*:0]u8, p_out_repeat: *c_int, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_get_changes_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_last_sync_tag, p_is_repeat, p_out_new_sync_tag, p_out_repeat, p_out_created_objects, p_out_modified_objects, p_out_removed_objects, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_last_sync_tag: ?[*:0]const u8, p_is_repeat: c_int, p_out_new_sync_tag: *[*:0]u8, p_out_repeat: *c_int, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_get_changes_sync = @ptrCast(p_implementation);
            }
        };

        /// It is optional to implement this virtual method by the descendants.
        /// It is used to receive SSL error details when any online operation
        /// returns E_CLIENT_ERROR, E_CLIENT_ERROR_TLS_NOT_AVAILABLE error.
        pub const get_ssl_error_details = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_get_ssl_error_details.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_out_certificate_pem, p_out_certificate_errors);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_get_ssl_error_details = @ptrCast(p_implementation);
            }
        };

        /// Used to get list of all existing objects on the remote side. The descendant
        /// can optionally provide `out_new_sync_tag`, which will be stored on success, if
        /// not `NULL`. The descendant can populate also ECalMetaBackendInfo::object of
        /// the `out_existing_objects`, if known, in which case this will be used instead
        /// of loading it with `edatacal.CalMetaBackend.loadComponentSync`.
        ///
        /// It is mandatory to implement this virtual method by the descendant, unless
        /// it implements its own `edatacal.CalMetaBackendClass.virtual_methods.get_changes_sync`.
        ///
        /// The `out_existing_objects` `glib.SList` should be freed with
        /// g_slist_free_full (objects, e_cal_meta_backend_info_free);
        /// when no longer needed.
        pub const list_existing_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_new_sync_tag: *[*:0]u8, p_out_existing_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_list_existing_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_out_new_sync_tag, p_out_existing_objects, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_out_new_sync_tag: *[*:0]u8, p_out_existing_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_list_existing_sync = @ptrCast(p_implementation);
            }
        };

        /// Loads a component from the remote side. Any detached instances should be
        /// returned together with the master object. The `out_component` can be either
        /// a VCALENDAR component, which would contain the master object and all of
        /// its detached instances, eventually also used time zones, or the requested
        /// component of type VEVENT, VJOURNAL or VTODO.
        ///
        /// It is mandatory to implement this virtual method by the descendant.
        ///
        /// The returned `out_component` should be freed with `gobject.Object.unref`,
        /// when no longer needed.
        ///
        /// The returned `out_extra` should be freed with `glib.free`, when no longer
        /// needed.
        pub const load_component_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_out_component: **icalglib.Component, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_load_component_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_uid, p_extra, p_out_component, p_out_extra, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_out_component: **icalglib.Component, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_load_component_sync = @ptrCast(p_implementation);
            }
        };

        /// Removes a component from the remote side, with all its detached instances.
        /// The `object` is not `NULL` when it's removing locally deleted object
        /// in offline mode. Being it `NULL`, the descendant can obtain the object
        /// from the `edatacal.CalCache`.
        ///
        /// It is mandatory to implement this virtual method by the writable descendant.
        pub const remove_component_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_conflict_resolution: edataserver.ConflictResolution, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_object: ?[*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_remove_component_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_conflict_resolution, p_uid, p_extra, p_object, p_opflags, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_conflict_resolution: edataserver.ConflictResolution, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_object: ?[*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_remove_component_sync = @ptrCast(p_implementation);
            }
        };

        /// Determines, whether current source content requires reconnect of the backend.
        ///
        /// It is optional to implement this virtual method by the descendant. The default
        /// implementation compares `E_SOURCE_EXTENSION_AUTHENTICATION` and
        /// `E_SOURCE_EXTENSION_WEBDAV_BACKEND`, if existing in the source,
        /// with the values after the last successful connect and returns
        /// `TRUE` when they changed. It always return `TRUE` when there was
        /// no successful connect done yet.
        pub const requires_reconnect = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_requires_reconnect.?(gobject.ext.as(CalMetaBackend, p_meta_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_requires_reconnect = @ptrCast(p_implementation);
            }
        };

        /// Saves one component into the remote side. The `instances` contain the master
        /// object and all the detached instances of the same component (all have the same UID).
        /// When the `overwrite_existing` is `TRUE`, then the descendant can overwrite an object
        /// with the same UID on the remote side (usually used for modify). The `conflict_resolution`
        /// defines what to do when the remote side had made any changes to the object since
        /// the last update.
        ///
        /// The descendant can use `edatacal.CalMetaBackend.mergeInstances` to merge
        /// the instances into one VCALENDAR component, which will contain also
        /// used time zones.
        ///
        /// The components in `instances` have already converted locally stored attachments
        /// into inline attachments, thus it's not needed to call
        /// `edatacal.CalMetaBackend.inlineLocalAttachmentsSync` by the descendant.
        ///
        /// The `out_new_uid` can be populated with a UID of the saved component as the server
        /// assigned it to it. This UID, if set, is loaded from the remote side afterwards,
        /// also to see whether any changes had been made to the component by the remote side.
        ///
        /// The `out_new_extra` can be populated with a new extra data to save with the component.
        /// Left it `NULL`, to keep the same value as the `extra`.
        ///
        /// The descendant can use an `E_CLIENT_ERROR_OUT_OF_SYNC` error to indicate that
        /// the save failed due to made changes on the remote side, and let the `meta_backend`
        /// to resolve this conflict based on the `conflict_resolution` on its own.
        /// The `E_CLIENT_ERROR_OUT_OF_SYNC` error should not be used when the descendant
        /// is able to resolve the conflicts itself.
        ///
        /// It is mandatory to implement this virtual method by the writable descendant.
        pub const save_component_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_overwrite_existing: c_int, p_conflict_resolution: edataserver.ConflictResolution, p_instances: *const glib.SList, p_extra: ?[*:0]const u8, p_opflags: ecal.OperationFlags, p_out_new_uid: *[*:0]u8, p_out_new_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_save_component_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_overwrite_existing, p_conflict_resolution, p_instances, p_extra, p_opflags, p_out_new_uid, p_out_new_extra, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_overwrite_existing: c_int, p_conflict_resolution: edataserver.ConflictResolution, p_instances: *const glib.SList, p_extra: ?[*:0]const u8, p_opflags: ecal.OperationFlags, p_out_new_uid: *[*:0]u8, p_out_new_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_save_component_sync = @ptrCast(p_implementation);
            }
        };

        /// Searches `meta_backend` with given expression `expr` and returns
        /// found components as a `glib.SList` of `ecal.Component` `out_components`.
        /// Free the returned `out_components` with g_slist_free_full (components, g_object_unref);
        /// when no longer needed.
        /// When the `expr` is `NULL`, all objects are returned. To get iCal
        /// strings instead, call `edatacal.CalMetaBackend.searchSync`.
        ///
        /// It is optional to implement this virtual method by the descendant.
        /// The default implementation searches `meta_backend`'s cache. It's also
        /// not required to be online for searching, thus `meta_backend` doesn't
        /// ensure it.
        pub const search_components_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expr: ?[*:0]const u8, p_out_components: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_search_components_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_expr, p_out_components, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expr: ?[*:0]const u8, p_out_components: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_search_components_sync = @ptrCast(p_implementation);
            }
        };

        /// Searches `meta_backend` with given expression `expr` and returns
        /// found components as a `glib.SList` of iCal strings `out_icalstrings`.
        /// Free the returned `out_icalstrings` with g_slist_free_full (icalstrings, g_free);
        /// when no longer needed.
        /// When the `expr` is `NULL`, all objects are returned. To get
        /// `ecal.Component`-s instead, call `edatacal.CalMetaBackend.searchComponentsSync`.
        ///
        /// It is optional to implement this virtual method by the descendant.
        /// The default implementation searches `meta_backend`'s cache. It's also
        /// not required to be online for searching, thus `meta_backend` doesn't
        /// ensure it.
        pub const search_sync = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expr: ?[*:0]const u8, p_out_icalstrings: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_search_sync.?(gobject.ext.as(CalMetaBackend, p_meta_backend), p_expr, p_out_icalstrings, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_expr: ?[*:0]const u8, p_out_icalstrings: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_search_sync = @ptrCast(p_implementation);
            }
        };

        pub const source_changed = struct {
            pub fn call(p_class: anytype, p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(CalMetaBackend.Class, p_class).f_source_changed.?(gobject.ext.as(CalMetaBackend, p_meta_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_meta_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(CalMetaBackend.Class, p_class).f_source_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The `edatacal.CalCache` being used for this meta backend.
        pub const cache = struct {
            pub const name = "cache";

            pub const Type = ?*edatacal.CalCache;
        };
    };

    pub const signals = struct {
        pub const refresh_completed = struct {
            pub const name = "refresh-completed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CalMetaBackend, p_instance))),
                    gobject.signalLookup("refresh-completed", CalMetaBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted whenever the underlying backend `edataserver.Source`
        /// changes. Unlike the `edataserver.Source`'s 'changed' signal this one is
        /// tight to the `edatacal.CalMetaBackend` itself and is emitted from
        /// a dedicated thread, thus it doesn't block the main thread.
        pub const source_changed = struct {
            pub const name = "source-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CalMetaBackend, p_instance))),
                    gobject.signalLookup("source-changed", CalMetaBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// This is called always before any operation which requires a connection
    /// to the remote side. It can fail with an `E_CLIENT_ERROR_REPOSITORY_OFFLINE`
    /// error to indicate that the remote side cannot be currently reached. Other
    /// errors are propagated to the caller/client side. This method is not called
    /// when the backend is offline.
    ///
    /// The descendant should also call `edatacal.CalBackend.setWritable` after successful
    /// connect to the remote side. This value is stored for later use, when being
    /// opened offline.
    ///
    /// The `credentials` parameter consists of the previously used credentials.
    /// It's always `NULL` with the first connection attempt. To get the credentials,
    /// just set the `out_auth_result` to `E_SOURCE_AUTHENTICATION_REQUIRED` for
    /// the first time and the function will be called again once the credentials
    /// are available. See the documentation of `edataserver.SourceAuthenticationResult` for
    /// other available results.
    ///
    /// The out parameters are passed to `ebackend.Backend.scheduleCredentialsRequired`
    /// and are ignored when the descendant returns `TRUE`, aka they are used
    /// only if the connection fails. The `out_certificate_pem` and `out_certificate_errors`
    /// should be used together and they can be left untouched if the failure reason was
    /// not related to certificate. Use `out_auth_result` `E_SOURCE_AUTHENTICATION_UNKNOWN`
    /// to indicate other error than `credentials` error, otherwise the `error` is used
    /// according to `out_auth_result` value.
    ///
    /// It is mandatory to implement this virtual method by the descendant.
    extern fn e_cal_meta_backend_connect_sync(p_meta_backend: *CalMetaBackend, p_credentials: ?*const edataserver.NamedParameters, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const connectSync = e_cal_meta_backend_connect_sync;

    /// This is called when the backend goes into offline mode or
    /// when the disconnect is required. The implementation should
    /// not report any error when it is called and the `meta_backend`
    /// is not connected.
    ///
    /// It is mandatory to implement this virtual method by the descendant.
    extern fn e_cal_meta_backend_disconnect_sync(p_meta_backend: *CalMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const disconnectSync = e_cal_meta_backend_disconnect_sync;

    /// Returns the last known synchronization tag, the same as used to
    /// call `edatacal.CalMetaBackend.getChangesSync`.
    ///
    /// Free the returned string with `glib.free`, when no longer needed.
    extern fn e_cal_meta_backend_dup_sync_tag(p_meta_backend: *CalMetaBackend) ?[*:0]u8;
    pub const dupSyncTag = e_cal_meta_backend_dup_sync_tag;

    /// Empties the local cache by removing all known components from it
    /// and notifies about such removal any opened views. It removes also
    /// all known time zones.
    extern fn e_cal_meta_backend_empty_cache_sync(p_meta_backend: *CalMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const emptyCacheSync = e_cal_meta_backend_empty_cache_sync;

    /// Ensures that the `meta_backend` is connected to its destination.
    extern fn e_cal_meta_backend_ensure_connected_sync(p_meta_backend: *CalMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const ensureConnectedSync = e_cal_meta_backend_ensure_connected_sync;

    /// Extracts all VTIMEZONE components from the `vcalendar` and adds them
    /// to the memory cache, thus they are available when needed. The function does
    /// nothing when the `vcalendar` doesn't hold a VCALENDAR component.
    ///
    /// Set the `remove_existing` argument to `TRUE` to remove all cached timezones
    /// first and then add the existing in the `vcalendar`, or set it to `FALSE`
    /// to preserver existing timezones and merge them with those in `vcalendar`.
    extern fn e_cal_meta_backend_gather_timezones_sync(p_meta_backend: *CalMetaBackend, p_vcalendar: *icalglib.Component, p_remove_existing: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const gatherTimezonesSync = e_cal_meta_backend_gather_timezones_sync;

    extern fn e_cal_meta_backend_get_capabilities(p_meta_backend: *CalMetaBackend) [*:0]const u8;
    pub const getCapabilities = e_cal_meta_backend_get_capabilities;

    /// Gathers the changes since the last check which had been done
    /// on the remote side.
    ///
    /// The `last_sync_tag` can be used as a tag of the last check. This can be `NULL`,
    /// when there was no previous call or when the descendant doesn't store any
    /// such tags. The `out_new_sync_tag` can be populated with a value to be stored
    /// and used the next time.
    ///
    /// The `out_repeat` can be set to `TRUE` when the descendant didn't finish
    /// read of all the changes. In that case the `meta_backend` calls this
    /// function again with the `out_new_sync_tag` as the `last_sync_tag`, but also
    /// notifies about the found changes immediately. The `is_repeat` is set
    /// to `TRUE` as well in this case, otherwise it's `FALSE`.
    ///
    /// The descendant can populate also ECalMetaBackendInfo::object of
    /// the `out_created_objects` and `out_modified_objects`, if known, in which
    /// case this will be used instead of loading it with `edatacal.CalMetaBackend.loadComponentSync`.
    ///
    /// It is optional to implement this virtual method by the descendant.
    /// The default implementation calls `edatacal.CalMetaBackend.listExistingSync`
    /// and then compares the list with the current content of the local cache
    /// and populates the respective lists appropriately.
    ///
    /// Each output `glib.SList` should be freed with
    /// g_slist_free_full (objects, e_cal_meta_backend_info_free);
    /// when no longer needed.
    extern fn e_cal_meta_backend_get_changes_sync(p_meta_backend: *CalMetaBackend, p_last_sync_tag: ?[*:0]const u8, p_is_repeat: c_int, p_out_new_sync_tag: *[*:0]u8, p_out_repeat: *c_int, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getChangesSync = e_cal_meta_backend_get_changes_sync;

    /// This value has meaning only if `edatacal.CalMetaBackend.getEverConnected`
    /// is `TRUE`.
    extern fn e_cal_meta_backend_get_connected_writable(p_meta_backend: *CalMetaBackend) c_int;
    pub const getConnectedWritable = e_cal_meta_backend_get_connected_writable;

    extern fn e_cal_meta_backend_get_ever_connected(p_meta_backend: *CalMetaBackend) c_int;
    pub const getEverConnected = e_cal_meta_backend_get_ever_connected;

    /// It is optional to implement this virtual method by the descendants.
    /// It is used to receive SSL error details when any online operation
    /// returns E_CLIENT_ERROR, E_CLIENT_ERROR_TLS_NOT_AVAILABLE error.
    extern fn e_cal_meta_backend_get_ssl_error_details(p_meta_backend: *CalMetaBackend, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags) c_int;
    pub const getSslErrorDetails = e_cal_meta_backend_get_ssl_error_details;

    /// Changes all URL attachments which point to a local file in `component`
    /// to inline attachments, aka adds the file content into the `component`.
    /// It also populates FILENAME parameter on the attachment.
    /// This is called automatically before `edatacal.CalMetaBackend.saveComponentSync`.
    ///
    /// The reverse operation is `edatacal.CalMetaBackend.storeInlineAttachmentsSync`.
    extern fn e_cal_meta_backend_inline_local_attachments_sync(p_meta_backend: *CalMetaBackend, p_component: *icalglib.Component, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const inlineLocalAttachmentsSync = e_cal_meta_backend_inline_local_attachments_sync;

    /// Used to get list of all existing objects on the remote side. The descendant
    /// can optionally provide `out_new_sync_tag`, which will be stored on success, if
    /// not `NULL`. The descendant can populate also ECalMetaBackendInfo::object of
    /// the `out_existing_objects`, if known, in which case this will be used instead
    /// of loading it with `edatacal.CalMetaBackend.loadComponentSync`.
    ///
    /// It is mandatory to implement this virtual method by the descendant, unless
    /// it implements its own `edatacal.CalMetaBackendClass.virtual_methods.get_changes_sync`.
    ///
    /// The `out_existing_objects` `glib.SList` should be freed with
    /// g_slist_free_full (objects, e_cal_meta_backend_info_free);
    /// when no longer needed.
    extern fn e_cal_meta_backend_list_existing_sync(p_meta_backend: *CalMetaBackend, p_out_new_sync_tag: *[*:0]u8, p_out_existing_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const listExistingSync = e_cal_meta_backend_list_existing_sync;

    /// Loads a component from the remote side. Any detached instances should be
    /// returned together with the master object. The `out_component` can be either
    /// a VCALENDAR component, which would contain the master object and all of
    /// its detached instances, eventually also used time zones, or the requested
    /// component of type VEVENT, VJOURNAL or VTODO.
    ///
    /// It is mandatory to implement this virtual method by the descendant.
    ///
    /// The returned `out_component` should be freed with `gobject.Object.unref`,
    /// when no longer needed.
    ///
    /// The returned `out_extra` should be freed with `glib.free`, when no longer
    /// needed.
    extern fn e_cal_meta_backend_load_component_sync(p_meta_backend: *CalMetaBackend, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_out_component: **icalglib.Component, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const loadComponentSync = e_cal_meta_backend_load_component_sync;

    /// Merges all the instances provided in `instances` list into one VCALENDAR
    /// object, which would eventually contain also all the used timezones.
    /// The `instances` list should contain the master object and eventually all
    /// the detached instances for one component (they all have the same UID).
    ///
    /// Any TZID property parameters can be replaced with corresponding timezone
    /// location, which will not influence the timezone itself.
    extern fn e_cal_meta_backend_merge_instances(p_meta_backend: *CalMetaBackend, p_instances: *const glib.SList, p_replace_tzid_with_location: c_int) *icalglib.Component;
    pub const mergeInstances = e_cal_meta_backend_merge_instances;

    /// Processes given changes by updating local cache content accordingly.
    /// The `meta_backend` processes the changes like being online and particularly
    /// requires to be online to load created and modified objects when needed.
    extern fn e_cal_meta_backend_process_changes_sync(p_meta_backend: *CalMetaBackend, p_created_objects: ?*const glib.SList, p_modified_objects: ?*const glib.SList, p_removed_objects: ?*const glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const processChangesSync = e_cal_meta_backend_process_changes_sync;

    extern fn e_cal_meta_backend_ref_cache(p_meta_backend: *CalMetaBackend) *edatacal.CalCache;
    pub const refCache = e_cal_meta_backend_ref_cache;

    /// Refreshes the `meta_backend` immediately. To just schedule refresh
    /// operation call `edatacal.CalMetaBackend.scheduleRefresh`.
    extern fn e_cal_meta_backend_refresh_sync(p_meta_backend: *CalMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshSync = e_cal_meta_backend_refresh_sync;

    /// Removes a component from the remote side, with all its detached instances.
    /// The `object` is not `NULL` when it's removing locally deleted object
    /// in offline mode. Being it `NULL`, the descendant can obtain the object
    /// from the `edatacal.CalCache`.
    ///
    /// It is mandatory to implement this virtual method by the writable descendant.
    extern fn e_cal_meta_backend_remove_component_sync(p_meta_backend: *CalMetaBackend, p_conflict_resolution: edataserver.ConflictResolution, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_object: ?[*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeComponentSync = e_cal_meta_backend_remove_component_sync;

    /// Determines, whether current source content requires reconnect of the backend.
    ///
    /// It is optional to implement this virtual method by the descendant. The default
    /// implementation compares `E_SOURCE_EXTENSION_AUTHENTICATION` and
    /// `E_SOURCE_EXTENSION_WEBDAV_BACKEND`, if existing in the source,
    /// with the values after the last successful connect and returns
    /// `TRUE` when they changed. It always return `TRUE` when there was
    /// no successful connect done yet.
    extern fn e_cal_meta_backend_requires_reconnect(p_meta_backend: *CalMetaBackend) c_int;
    pub const requiresReconnect = e_cal_meta_backend_requires_reconnect;

    /// Saves one component into the remote side. The `instances` contain the master
    /// object and all the detached instances of the same component (all have the same UID).
    /// When the `overwrite_existing` is `TRUE`, then the descendant can overwrite an object
    /// with the same UID on the remote side (usually used for modify). The `conflict_resolution`
    /// defines what to do when the remote side had made any changes to the object since
    /// the last update.
    ///
    /// The descendant can use `edatacal.CalMetaBackend.mergeInstances` to merge
    /// the instances into one VCALENDAR component, which will contain also
    /// used time zones.
    ///
    /// The components in `instances` have already converted locally stored attachments
    /// into inline attachments, thus it's not needed to call
    /// `edatacal.CalMetaBackend.inlineLocalAttachmentsSync` by the descendant.
    ///
    /// The `out_new_uid` can be populated with a UID of the saved component as the server
    /// assigned it to it. This UID, if set, is loaded from the remote side afterwards,
    /// also to see whether any changes had been made to the component by the remote side.
    ///
    /// The `out_new_extra` can be populated with a new extra data to save with the component.
    /// Left it `NULL`, to keep the same value as the `extra`.
    ///
    /// The descendant can use an `E_CLIENT_ERROR_OUT_OF_SYNC` error to indicate that
    /// the save failed due to made changes on the remote side, and let the `meta_backend`
    /// to resolve this conflict based on the `conflict_resolution` on its own.
    /// The `E_CLIENT_ERROR_OUT_OF_SYNC` error should not be used when the descendant
    /// is able to resolve the conflicts itself.
    ///
    /// It is mandatory to implement this virtual method by the writable descendant.
    extern fn e_cal_meta_backend_save_component_sync(p_meta_backend: *CalMetaBackend, p_overwrite_existing: c_int, p_conflict_resolution: edataserver.ConflictResolution, p_instances: *const glib.SList, p_extra: ?[*:0]const u8, p_opflags: ecal.OperationFlags, p_out_new_uid: *[*:0]u8, p_out_new_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const saveComponentSync = e_cal_meta_backend_save_component_sync;

    /// Schedules refresh of the content of the `meta_backend`. If there's any
    /// already scheduled, then the function does nothing.
    ///
    /// Use `edatacal.CalMetaBackend.refreshSync` to refresh the `meta_backend`
    /// immediately.
    extern fn e_cal_meta_backend_schedule_refresh(p_meta_backend: *CalMetaBackend) void;
    pub const scheduleRefresh = e_cal_meta_backend_schedule_refresh;

    /// Searches `meta_backend` with given expression `expr` and returns
    /// found components as a `glib.SList` of `ecal.Component` `out_components`.
    /// Free the returned `out_components` with g_slist_free_full (components, g_object_unref);
    /// when no longer needed.
    /// When the `expr` is `NULL`, all objects are returned. To get iCal
    /// strings instead, call `edatacal.CalMetaBackend.searchSync`.
    ///
    /// It is optional to implement this virtual method by the descendant.
    /// The default implementation searches `meta_backend`'s cache. It's also
    /// not required to be online for searching, thus `meta_backend` doesn't
    /// ensure it.
    extern fn e_cal_meta_backend_search_components_sync(p_meta_backend: *CalMetaBackend, p_expr: ?[*:0]const u8, p_out_components: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchComponentsSync = e_cal_meta_backend_search_components_sync;

    /// Searches `meta_backend` with given expression `expr` and returns
    /// found components as a `glib.SList` of iCal strings `out_icalstrings`.
    /// Free the returned `out_icalstrings` with g_slist_free_full (icalstrings, g_free);
    /// when no longer needed.
    /// When the `expr` is `NULL`, all objects are returned. To get
    /// `ecal.Component`-s instead, call `edatacal.CalMetaBackend.searchComponentsSync`.
    ///
    /// It is optional to implement this virtual method by the descendant.
    /// The default implementation searches `meta_backend`'s cache. It's also
    /// not required to be online for searching, thus `meta_backend` doesn't
    /// ensure it.
    extern fn e_cal_meta_backend_search_sync(p_meta_backend: *CalMetaBackend, p_expr: ?[*:0]const u8, p_out_icalstrings: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const searchSync = e_cal_meta_backend_search_sync;

    /// Sets the `cache` as the cache to be used by the `meta_backend`.
    /// By default, a cache.db in ECalBackend::cache-dir is created
    /// in the constructed method. This function can be used to override
    /// the default.
    ///
    /// Note the `meta_backend` adds its own reference to the `cache`.
    extern fn e_cal_meta_backend_set_cache(p_meta_backend: *CalMetaBackend, p_cache: *edatacal.CalCache) void;
    pub const setCache = e_cal_meta_backend_set_cache;

    /// Sets whether the `meta_backend` connected to a writable destination.
    /// This value has meaning only if `edatacal.CalMetaBackend.getEverConnected`
    /// is `TRUE`.
    ///
    /// This is used by the `meta_backend` itself, during the opening phase,
    /// to set the backend writable or not also in the offline mode.
    extern fn e_cal_meta_backend_set_connected_writable(p_meta_backend: *CalMetaBackend, p_value: c_int) void;
    pub const setConnectedWritable = e_cal_meta_backend_set_connected_writable;

    /// Sets whether the `meta_backend` ever made a successful connection
    /// to its destination.
    ///
    /// This is used by the `meta_backend` itself, during the opening phase,
    /// when it had not been connected yet, then it does so immediately, to
    /// eventually report settings error easily.
    extern fn e_cal_meta_backend_set_ever_connected(p_meta_backend: *CalMetaBackend, p_value: c_int) void;
    pub const setEverConnected = e_cal_meta_backend_set_ever_connected;

    /// Sets the `sync_tag` for the `meta_backend`.
    extern fn e_cal_meta_backend_set_sync_tag(p_meta_backend: *CalMetaBackend, p_sync_tag: ?[*:0]const u8) void;
    pub const setSyncTag = e_cal_meta_backend_set_sync_tag;

    /// Splits `objects` into created/modified/removed lists according to current local
    /// cache content. Only the `out_removed_objects` can be `NULL`, others cannot.
    /// The function modifies `objects` by moving its 'data' to corresponding out
    /// lists and sets the `objects` 'data' to `NULL`.
    ///
    /// Each output `glib.SList` should be freed with
    /// g_slist_free_full (objects, e_cal_meta_backend_info_free);
    /// when no longer needed.
    ///
    /// The caller is still responsible to free `objects` as well.
    extern fn e_cal_meta_backend_split_changes_sync(p_meta_backend: *CalMetaBackend, p_objects: *glib.SList, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const splitChangesSync = e_cal_meta_backend_split_changes_sync;

    /// Changes all inline attachments to URL attachments in `component`, which
    /// will point to a local file instead. The function expects FILENAME parameter
    /// to be set on the attachment as the file name of it.
    /// This is called automatically after `edatacal.CalMetaBackend.loadComponentSync`.
    ///
    /// The reverse operation is `edatacal.CalMetaBackend.inlineLocalAttachmentsSync`.
    extern fn e_cal_meta_backend_store_inline_attachments_sync(p_meta_backend: *CalMetaBackend, p_component: *icalglib.Component, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const storeInlineAttachmentsSync = e_cal_meta_backend_store_inline_attachments_sync;

    extern fn e_cal_meta_backend_get_type() usize;
    pub const getGObjectType = e_cal_meta_backend_get_type;

    extern fn g_object_ref(p_self: *edatacal.CalMetaBackend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.CalMetaBackend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CalMetaBackend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCal = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = edatacal.DataCalClass;
    f_parent: gobject.Object,
    f_priv: ?*edatacal.DataCalPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const backend = struct {
            pub const name = "backend";

            pub const Type = ?*edatacal.CalBackend;
        };

        pub const connection = struct {
            pub const name = "connection";

            pub const Type = ?*gio.DBusConnection;
        };

        pub const object_path = struct {
            pub const name = "object-path";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `edatacal.DataCal` and exports the Calendar D-Bus interface
    /// on `connection` at `object_path`.  The `edatacal.DataCal` handles incoming remote
    /// method invocations and forwards them to the `backend`.  If the Calendar
    /// interface fails to export, the function sets `error` and returns `NULL`.
    extern fn e_data_cal_new(p_backend: *edatacal.CalBackend, p_connection: *gio.DBusConnection, p_object_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*edatacal.DataCal;
    pub const new = e_data_cal_new;

    /// Returns the `gio.DBusConnection` on which the Calendar D-Bus interface
    /// is exported.
    extern fn e_data_cal_get_connection(p_cal: *DataCal) *gio.DBusConnection;
    pub const getConnection = e_data_cal_get_connection;

    /// Returns the object path at which the Calendar D-Bus interface is
    /// exported.
    extern fn e_data_cal_get_object_path(p_cal: *DataCal) [*:0]const u8;
    pub const getObjectPath = e_data_cal_get_object_path;

    /// Returns the `edatacal.CalBackend` to which incoming remote method invocations
    /// are being forwarded.
    ///
    /// The returned `edatacal.CalBackend` is referenced for thread-safety and should
    /// be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_data_cal_ref_backend(p_cal: *DataCal) ?*edatacal.CalBackend;
    pub const refBackend = e_data_cal_ref_backend;

    /// Notifies client about certain property value change
    extern fn e_data_cal_report_backend_property_changed(p_cal: *DataCal, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8) void;
    pub const reportBackendPropertyChanged = e_data_cal_report_backend_property_changed;

    /// Emits an error message, thus the clients can be notified about it.
    extern fn e_data_cal_report_error(p_cal: *DataCal, p_message: [*:0]const u8) void;
    pub const reportError = e_data_cal_report_error;

    /// Reports result of a free/busy query on the `cal`.
    extern fn e_data_cal_report_free_busy_data(p_cal: *DataCal, p_freebusy: *const glib.SList) void;
    pub const reportFreeBusyData = e_data_cal_report_free_busy_data;

    /// Notifies listeners of the completion of the add_timezone method call.
    extern fn e_data_cal_respond_add_timezone(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error) void;
    pub const respondAddTimezone = e_data_cal_respond_add_timezone;

    /// Notifies listeners of the completion of the create_objects method call.
    extern fn e_data_cal_respond_create_objects(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_uids: *const glib.SList, p_new_components: *glib.SList) void;
    pub const respondCreateObjects = e_data_cal_respond_create_objects;

    /// Notifies listeners of the completion of the discard_alarm method call.
    extern fn e_data_cal_respond_discard_alarm(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error) void;
    pub const respondDiscardAlarm = e_data_cal_respond_discard_alarm;

    /// Notifies listeners of the completion of the get_attachment_uris method call.
    extern fn e_data_cal_respond_get_attachment_uris(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_attachment_uris: *const glib.SList) void;
    pub const respondGetAttachmentUris = e_data_cal_respond_get_attachment_uris;

    /// Notifies listeners of the completion of the get_free_busy method call.
    /// To pass actual free/busy objects to the client asynchronously
    /// use `edatacal.DataCal.reportFreeBusyData`, but the `freebusy` should contain
    /// all the objects being used in `edatacal.DataCal.reportFreeBusyData`.
    extern fn e_data_cal_respond_get_free_busy(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_freebusy: *const glib.SList) void;
    pub const respondGetFreeBusy = e_data_cal_respond_get_free_busy;

    /// Notifies listeners of the completion of the get_object method call.
    extern fn e_data_cal_respond_get_object(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_object: [*:0]const u8) void;
    pub const respondGetObject = e_data_cal_respond_get_object;

    /// Notifies listeners of the completion of the get_object_list method call.
    extern fn e_data_cal_respond_get_object_list(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_objects: *const glib.SList) void;
    pub const respondGetObjectList = e_data_cal_respond_get_object_list;

    /// Notifies listeners of the completion of the get_timezone method call.
    extern fn e_data_cal_respond_get_timezone(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_tzobject: [*:0]const u8) void;
    pub const respondGetTimezone = e_data_cal_respond_get_timezone;

    /// Notifies listeners of the completion of the modify_objects method call.
    extern fn e_data_cal_respond_modify_objects(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_old_components: *glib.SList, p_new_components: *glib.SList) void;
    pub const respondModifyObjects = e_data_cal_respond_modify_objects;

    /// Notifies listeners of the completion of the open method call.
    extern fn e_data_cal_respond_open(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error) void;
    pub const respondOpen = e_data_cal_respond_open;

    /// Notifies listeners of the completion of the receive_objects method call.
    extern fn e_data_cal_respond_receive_objects(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error) void;
    pub const respondReceiveObjects = e_data_cal_respond_receive_objects;

    /// Notifies listeners of the completion of the refresh method call.
    extern fn e_data_cal_respond_refresh(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error) void;
    pub const respondRefresh = e_data_cal_respond_refresh;

    /// Notifies listeners of the completion of the remove_objects method call.
    extern fn e_data_cal_respond_remove_objects(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_ids: *const glib.SList, p_old_components: *glib.SList, p_new_components: *glib.SList) void;
    pub const respondRemoveObjects = e_data_cal_respond_remove_objects;

    /// Notifies listeners of the completion of the send_objects method call.
    extern fn e_data_cal_respond_send_objects(p_cal: *DataCal, p_opid: u32, p_error: ?*glib.Error, p_users: *const glib.SList, p_calobj: [*:0]const u8) void;
    pub const respondSendObjects = e_data_cal_respond_send_objects;

    extern fn e_data_cal_get_type() usize;
    pub const getGObjectType = e_data_cal_get_type;

    extern fn g_object_ref(p_self: *edatacal.DataCal) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.DataCal) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataCal, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCalFactory = extern struct {
    pub const Parent = ebackend.DataFactory;
    pub const Implements = [_]type{ edataserver.Extensible, gio.Initable };
    pub const Class = edatacal.DataCalFactoryClass;
    f_parent: ebackend.DataFactory,
    f_priv: ?*edatacal.DataCalFactoryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_data_cal_factory_new(p_backend_per_process: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatacal.DataCalFactory;
    pub const new = e_data_cal_factory_new;

    extern fn e_data_cal_factory_get_type() usize;
    pub const getGObjectType = e_data_cal_factory_get_type;

    extern fn g_object_ref(p_self: *edatacal.DataCalFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.DataCalFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataCalFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCalView = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = edatacal.DataCalViewClass;
    f_parent: gobject.Object,
    f_priv: ?*edatacal.DataCalViewPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const backend = struct {
            pub const name = "backend";

            pub const Type = ?*edatacal.CalBackend;
        };

        pub const connection = struct {
            pub const name = "connection";

            pub const Type = ?*gio.DBusConnection;
        };

        pub const object_path = struct {
            pub const name = "object-path";

            pub const Type = ?[*:0]u8;
        };

        pub const sexp = struct {
            pub const name = "sexp";

            pub const Type = ?*edatacal.CalBackendSExp;
        };
    };

    pub const signals = struct {};

    /// Creates a new `edatacal.DataCalView` and exports its D-Bus interface on
    /// `connection` at `object_path`.  If an error occurs while exporting,
    /// the function sets `error` and returns `NULL`.
    extern fn e_data_cal_view_new(p_backend: ?*anyopaque, p_sexp: ?*anyopaque, p_connection: *gio.DBusConnection, p_object_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*edatacal.DataCalView;
    pub const new = e_data_cal_view_new;

    /// Compares the given `component` to the regular expression used for the
    /// given view.
    extern fn e_data_cal_view_component_matches(p_view: *DataCalView, p_component: *ecal.Component) c_int;
    pub const componentMatches = e_data_cal_view_component_matches;

    /// This function is similar to `ecal.Component.getAsString` except
    /// that it takes into account the fields-of-interest that `view` is
    /// configured with and filters out any unneeded fields.
    extern fn e_data_cal_view_get_component_string(p_view: *DataCalView, p_component: *ecal.Component) [*:0]u8;
    pub const getComponentString = e_data_cal_view_get_component_string;

    /// Returns the `gio.DBusConnection` on which the CalendarView D-Bus
    /// interface is exported.
    extern fn e_data_cal_view_get_connection(p_view: *DataCalView) *gio.DBusConnection;
    pub const getConnection = e_data_cal_view_get_connection;

    extern fn e_data_cal_view_get_fields_of_interest(p_view: *DataCalView) ?*glib.HashTable;
    pub const getFieldsOfInterest = e_data_cal_view_get_fields_of_interest;

    /// Gets the `ecal.ClientViewFlags` that control the behaviour of `view`.
    extern fn e_data_cal_view_get_flags(p_view: *DataCalView) ecal.ClientViewFlags;
    pub const getFlags = e_data_cal_view_get_flags;

    /// Return the object path at which the CalendarView D-Bus inteface is
    /// exported.
    extern fn e_data_cal_view_get_object_path(p_view: *DataCalView) [*:0]const u8;
    pub const getObjectPath = e_data_cal_view_get_object_path;

    /// Get the `edatacal.CalBackendSExp` object used for the given view.
    extern fn e_data_cal_view_get_sexp(p_view: *DataCalView) ?*anyopaque;
    pub const getSexp = e_data_cal_view_get_sexp;

    /// Checks whether the given view is already completed. Being completed means the initial
    /// matching of objects have been finished, not that no more notifications about
    /// changes will be sent. In fact, even after completed, notifications will still be sent
    /// if there are changes in the objects matching the view search expression.
    extern fn e_data_cal_view_is_completed(p_view: *DataCalView) c_int;
    pub const isCompleted = e_data_cal_view_is_completed;

    /// Checks whether the given view has already been started.
    extern fn e_data_cal_view_is_started(p_view: *DataCalView) c_int;
    pub const isStarted = e_data_cal_view_is_started;

    /// Checks whether the given view has been stopped.
    extern fn e_data_cal_view_is_stopped(p_view: *DataCalView) c_int;
    pub const isStopped = e_data_cal_view_is_stopped;

    /// Notifies all view listeners of the completion of the view, including a
    /// status code.
    extern fn e_data_cal_view_notify_complete(p_view: *DataCalView, p_error: *const glib.Error) void;
    pub const notifyComplete = e_data_cal_view_notify_complete;

    /// Notifies all view listeners of the addition of a list of components.
    ///
    /// Uses the `edatacal.DataCalView`'s fields-of-interest to filter out unwanted
    /// information from iCalendar strings sent over the bus.
    extern fn e_data_cal_view_notify_components_added(p_view: *DataCalView, p_ecalcomponents: *const glib.SList) void;
    pub const notifyComponentsAdded = e_data_cal_view_notify_components_added;

    /// Notifies all the view listeners of the addition of a single object.
    ///
    /// Uses the `edatacal.DataCalView`'s fields-of-interest to filter out unwanted
    /// information from iCalendar strings sent over the bus.
    extern fn e_data_cal_view_notify_components_added_1(p_view: *DataCalView, p_component: *ecal.Component) void;
    pub const notifyComponentsAdded1 = e_data_cal_view_notify_components_added_1;

    /// Notifies all view listeners of the modification of a list of components.
    ///
    /// Uses the `edatacal.DataCalView`'s fields-of-interest to filter out unwanted
    /// information from iCalendar strings sent over the bus.
    extern fn e_data_cal_view_notify_components_modified(p_view: *DataCalView, p_ecalcomponents: *const glib.SList) void;
    pub const notifyComponentsModified = e_data_cal_view_notify_components_modified;

    /// Notifies all view listeners of the modification of `component`.
    ///
    /// Uses the `edatacal.DataCalView`'s fields-of-interest to filter out unwanted
    /// information from iCalendar strings sent over the bus.
    extern fn e_data_cal_view_notify_components_modified_1(p_view: *DataCalView, p_component: *ecal.Component) void;
    pub const notifyComponentsModified1 = e_data_cal_view_notify_components_modified_1;

    /// Notifies all view listener of the removal of a list of objects.
    extern fn e_data_cal_view_notify_objects_removed(p_view: *DataCalView, p_ids: *const glib.SList) void;
    pub const notifyObjectsRemoved = e_data_cal_view_notify_objects_removed;

    /// Notifies all view listener of the removal of a single object.
    extern fn e_data_cal_view_notify_objects_removed_1(p_view: *DataCalView, p_id: *const ecal.ComponentId) void;
    pub const notifyObjectsRemoved1 = e_data_cal_view_notify_objects_removed_1;

    /// Notifies all view listeners of progress messages.
    extern fn e_data_cal_view_notify_progress(p_view: *DataCalView, p_percent: c_int, p_message: [*:0]const u8) void;
    pub const notifyProgress = e_data_cal_view_notify_progress;

    /// Compares the given `object` to the regular expression used for the
    /// given view.
    extern fn e_data_cal_view_object_matches(p_view: *DataCalView, p_object: [*:0]const u8) c_int;
    pub const objectMatches = e_data_cal_view_object_matches;

    /// Refs the backend that `view` is querying. Unref the returned backend,
    /// if not `NULL`, with `gobject.Object.unref`, when no longer needed.
    extern fn e_data_cal_view_ref_backend(p_view: *DataCalView) ?*edatacal.CalBackend;
    pub const refBackend = e_data_cal_view_ref_backend;

    extern fn e_data_cal_view_get_type() usize;
    pub const getGObjectType = e_data_cal_view_get_type;

    extern fn g_object_ref(p_self: *edatacal.DataCalView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.DataCalView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataCalView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const IntervalTree = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edatacal.IntervalTreeClass;
    f_parent: gobject.Object,
    f_priv: ?*edatacal.IntervalTreePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `edatacal.IntervalTree`.
    extern fn e_intervaltree_new() *edatacal.IntervalTree;
    pub const new = e_intervaltree_new;

    extern fn e_intervaltree_destroy(p_tree: *IntervalTree) void;
    pub const destroy = e_intervaltree_destroy;

    extern fn e_intervaltree_dump(p_tree: *IntervalTree) void;
    pub const dump = e_intervaltree_dump;

    extern fn e_intervaltree_insert(p_tree: *IntervalTree, p_start: std.posix.time_t, p_end: std.posix.time_t, p_comp: *ecal.Component) c_int;
    pub const insert = e_intervaltree_insert;

    extern fn e_intervaltree_remove(p_tree: *IntervalTree, p_uid: [*:0]const u8, p_rid: [*:0]const u8) c_int;
    pub const remove = e_intervaltree_remove;

    extern fn e_intervaltree_search(p_tree: *IntervalTree, p_start: std.posix.time_t, p_end: std.posix.time_t) ?*glib.List;
    pub const search = e_intervaltree_search;

    extern fn e_intervaltree_get_type() usize;
    pub const getGObjectType = e_intervaltree_get_type;

    extern fn g_object_ref(p_self: *edatacal.IntervalTree) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.IntervalTree) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *IntervalTree, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubprocessCalFactory = extern struct {
    pub const Parent = ebackend.SubprocessFactory;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = edatacal.SubprocessCalFactoryClass;
    f_parent: ebackend.SubprocessFactory,
    f_priv: ?*edatacal.SubprocessCalFactoryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_subprocess_cal_factory_new(p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edatacal.SubprocessCalFactory;
    pub const new = e_subprocess_cal_factory_new;

    extern fn e_subprocess_cal_factory_get_type() usize;
    pub const getGObjectType = e_subprocess_cal_factory_get_type;

    extern fn g_object_ref(p_self: *edatacal.SubprocessCalFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edatacal.SubprocessCalFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SubprocessCalFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatacal.CalBackend` class.
///
/// These virtual methods must be implemented when writing
/// a calendar backend.
pub const CalBackendClass = extern struct {
    pub const Instance = edatacal.CalBackend;

    f_parent_class: ebackend.BackendClass,
    /// Whether a serial dispatch queue should
    ///                             be used for this backend or not. The default is `TRUE`.
    f_use_serial_dispatch_queue: c_int,
    /// Fetch a property value by name from the backend
    f_impl_get_backend_property: ?*const fn (p_backend: *edatacal.CalBackend, p_prop_name: [*:0]const u8) callconv(.c) [*:0]u8,
    /// Open the backend
    f_impl_open: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable) callconv(.c) void,
    /// Refresh the backend
    f_impl_refresh: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable) callconv(.c) void,
    /// Fetch a calendar object
    f_impl_get_object: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8) callconv(.c) void,
    /// FIXME: Document me
    f_impl_get_object_list: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_sexp: [*:0]const u8) callconv(.c) void,
    /// FIXME: Document me
    f_impl_get_free_busy: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_users: *const glib.SList, p_start: std.posix.time_t, p_end: std.posix.time_t) callconv(.c) void,
    /// FIXME: Document me
    f_impl_create_objects: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_opflags: ecal.OperationFlags) callconv(.c) void,
    /// FIXME: Document me
    f_impl_modify_objects: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags) callconv(.c) void,
    /// FIXME: Document me
    f_impl_remove_objects: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags) callconv(.c) void,
    /// FIXME: Document me
    f_impl_receive_objects: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags) callconv(.c) void,
    /// FIXME: Document me
    f_impl_send_objects: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags) callconv(.c) void,
    /// FIXME: Document me
    f_impl_get_attachment_uris: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8) callconv(.c) void,
    /// FIXME: Document me
    f_impl_discard_alarm: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags) callconv(.c) void,
    /// FIXME: Document me
    f_impl_get_timezone: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_tzid: [*:0]const u8) callconv(.c) void,
    /// FIXME: Document me
    f_impl_add_timezone: ?*const fn (p_backend: *edatacal.CalBackend, p_cal: *edatacal.DataCal, p_opid: u32, p_cancellable: ?*gio.Cancellable, p_tzobject: [*:0]const u8) callconv(.c) void,
    /// Start up the specified view
    f_impl_start_view: ?*const fn (p_backend: *edatacal.CalBackend, p_view: *edatacal.DataCalView) callconv(.c) void,
    /// Stop the specified view
    f_impl_stop_view: ?*const fn (p_backend: *edatacal.CalBackend, p_view: *edatacal.DataCalView) callconv(.c) void,
    /// A signal notifying that the backend was closed
    f_closed: ?*const fn (p_backend: *edatacal.CalBackend, p_sender: [*:0]const u8) callconv(.c) void,
    /// A signal notifying that the backend is being shut down
    f_shutdown: ?*const fn (p_backend: *edatacal.CalBackend) callconv(.c) void,
    f_reserved_padding: [20]*anyopaque,

    pub fn as(p_instance: *CalBackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatacal.CalBackendFactory` class.
///
/// Subclasses need to set the factory name and backend type
/// at initialization, the base class will take care of creating
/// backends of the specified type on demand.
pub const CalBackendFactoryClass = extern struct {
    pub const Instance = edatacal.CalBackendFactory;

    f_parent_class: ebackend.BackendFactoryClass,
    /// The string identifier for this book backend type
    f_factory_name: ?[*:0]const u8,
    /// The type if component this calendar backend should be created for
    f_component_kind: icalglib.ComponentKind,
    /// The `gobject.Type` to use to build `EBookBackends` for this factory
    f_backend_type: usize,

    pub fn as(p_instance: *CalBackendFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalBackendFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalBackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalBackendSExpClass = extern struct {
    pub const Instance = edatacal.CalBackendSExp;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *CalBackendSExpClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalBackendSExpPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Base class structure for the `edatacal.CalBackendSync` class
pub const CalBackendSyncClass = extern struct {
    pub const Instance = edatacal.CalBackendSync;

    f_parent_class: edatacal.CalBackendClass,
    /// Open the calendar
    f_open_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Refresh the calendar
    f_refresh_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Get single object
    f_get_object_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_calobj: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Get multiple objects at once
    f_get_object_list_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_sexp: [*:0]const u8, p_calobjs: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Get Free/Busy objects
    f_get_free_busy_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_users: *const glib.SList, p_start: std.posix.time_t, p_end: std.posix.time_t, p_freebusyobjs: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Create objects
    f_create_objects_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_opflags: ecal.OperationFlags, p_uids: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Modify objects
    f_modify_objects_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobjs: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_old_components: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Remove objects
    f_remove_objects_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_old_components: **glib.SList, p_new_components: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Receive objects
    f_receive_objects_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Send objects
    f_send_objects_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_calobj: [*:0]const u8, p_opflags: ecal.OperationFlags, p_users: **glib.SList, p_modified_calobj: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Get attachments uris for given object
    f_get_attachment_uris_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_attachments: **glib.SList, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Discard alarm
    f_discard_alarm_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_uid: [*:0]const u8, p_rid: [*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Get specified timezone
    f_get_timezone_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_tzid: [*:0]const u8, p_tzobject: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) void,
    /// Add specified timezone
    f_add_timezone_sync: ?*const fn (p_backend: *edatacal.CalBackendSync, p_cal: *edatacal.DataCal, p_cancellable: ?*gio.Cancellable, p_tzobject: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) void,
    f_reserved_padding: [20]*anyopaque,

    pub fn as(p_instance: *CalBackendSyncClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalBackendSyncPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatacal.CalCache` class.
pub const CalCacheClass = extern struct {
    pub const Instance = edatacal.CalCache;

    f_parent_class: ebackend.CacheClass,
    f_dup_component_revision: ?*const fn (p_cal_cache: *edatacal.CalCache, p_icomp: *icalglib.Component) callconv(.c) [*:0]u8,
    f_get_timezone: ?*const fn (p_cal_cache: *edatacal.CalCache, p_tzid: [*:0]const u8) callconv(.c) *icalglib.Timezone,
    f_reserved: [9]*anyopaque,

    pub fn as(p_instance: *CalCacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Holds the information about offline change for one component.
pub const CalCacheOfflineChange = extern struct {
    /// UID of the component
    f_uid: ?[*:0]u8,
    /// Recurrence-ID of the component
    f_rid: ?[*:0]u8,
    /// stored revision of the component
    f_revision: ?[*:0]u8,
    /// the component itself, as an iCalendar string
    f_object: ?[*:0]u8,
    /// an `ebackend.OfflineState` of the component
    f_state: ebackend.OfflineState,

    /// Frees the `change` structure, previously allocated with `edatacal.CalCacheOfflineChange.new`
    /// or `edatacal.CalCacheOfflineChange.copy`.
    extern fn e_cal_cache_offline_change_free(p_change: ?*anyopaque) void;
    pub const free = e_cal_cache_offline_change_free;

    /// Creates a new `edatacal.CalCacheOfflineChange` with the offline `state`
    /// information for the given `uid`.
    extern fn e_cal_cache_offline_change_new(p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_revision: ?[*:0]const u8, p_object: ?[*:0]const u8, p_state: ebackend.OfflineState) *edatacal.CalCacheOfflineChange;
    pub const new = e_cal_cache_offline_change_new;

    extern fn e_cal_cache_offline_change_copy(p_change: ?*const CalCacheOfflineChange) ?*edatacal.CalCacheOfflineChange;
    pub const copy = e_cal_cache_offline_change_copy;

    extern fn e_cal_cache_offline_change_get_type() usize;
    pub const getGObjectType = e_cal_cache_offline_change_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalCachePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This structure is used to represent components returned
/// by the `edatacal.CalCache` from various functions
/// such as `edatacal.CalCache.search`.
///
/// The `extra` parameter will contain any data which was
/// previously passed for this component in `edatacal.CalCache.putComponent`
/// or set with `edatacal.CalCache.setComponentExtra`.
///
/// These should be freed with `edatacal.calCacheSearchDataFree`.
pub const CalCacheSearchData = extern struct {
    /// the UID of this component
    f_uid: ?[*:0]u8,
    /// the Recurrence-ID of this component
    f_rid: ?[*:0]u8,
    /// the component string
    f_object: ?[*:0]u8,
    /// any extra data associated with the component
    f_extra: ?[*:0]u8,

    /// Frees the `ptr` structure, previously allocated with `edatacal.CalCacheSearchData.new`
    /// or `edatacal.CalCacheSearchData.copy`.
    extern fn e_cal_cache_search_data_free(p_ptr: ?*anyopaque) void;
    pub const free = e_cal_cache_search_data_free;

    /// Creates a new `edatacal.CalCacheSearchData` prefilled with the given values.
    extern fn e_cal_cache_search_data_new(p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_object: [*:0]const u8, p_extra: ?[*:0]const u8) *edatacal.CalCacheSearchData;
    pub const new = e_cal_cache_search_data_new;

    extern fn e_cal_cache_search_data_copy(p_data: ?*const CalCacheSearchData) ?*edatacal.CalCacheSearchData;
    pub const copy = e_cal_cache_search_data_copy;

    extern fn e_cal_cache_search_data_get_type() usize;
    pub const getGObjectType = e_cal_cache_search_data_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatacal.CalMetaBackend` class.
pub const CalMetaBackendClass = extern struct {
    pub const Instance = edatacal.CalMetaBackend;

    f_parent_class: edatacal.CalBackendSyncClass,
    f_connect_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_credentials: ?*const edataserver.NamedParameters, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_disconnect_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_changes_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_last_sync_tag: ?[*:0]const u8, p_is_repeat: c_int, p_out_new_sync_tag: *[*:0]u8, p_out_repeat: *c_int, p_out_created_objects: **glib.SList, p_out_modified_objects: **glib.SList, p_out_removed_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_list_existing_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_out_new_sync_tag: *[*:0]u8, p_out_existing_objects: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_load_component_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_out_component: **icalglib.Component, p_out_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_save_component_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_overwrite_existing: c_int, p_conflict_resolution: edataserver.ConflictResolution, p_instances: *const glib.SList, p_extra: ?[*:0]const u8, p_opflags: ecal.OperationFlags, p_out_new_uid: *[*:0]u8, p_out_new_extra: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remove_component_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_conflict_resolution: edataserver.ConflictResolution, p_uid: [*:0]const u8, p_extra: ?[*:0]const u8, p_object: ?[*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_search_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_expr: ?[*:0]const u8, p_out_icalstrings: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_search_components_sync: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_expr: ?[*:0]const u8, p_out_components: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_requires_reconnect: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend) callconv(.c) c_int,
    f_source_changed: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend) callconv(.c) void,
    f_get_ssl_error_details: ?*const fn (p_meta_backend: *edatacal.CalMetaBackend, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags) callconv(.c) c_int,
    f_reserved: [9]*anyopaque,

    pub fn as(p_instance: *CalMetaBackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalMetaBackendInfo = extern struct {
    f_uid: ?[*:0]u8,
    f_revision: ?[*:0]u8,
    f_object: ?[*:0]u8,
    f_extra: ?[*:0]u8,

    /// Frees the `ptr` structure, previously allocated with `edatacal.CalMetaBackendInfo.new`
    /// or `edatacal.CalMetaBackendInfo.copy`.
    extern fn e_cal_meta_backend_info_free(p_ptr: ?*anyopaque) void;
    pub const free = e_cal_meta_backend_info_free;

    /// Creates a new `edatacal.CalMetaBackendInfo` prefilled with the given values.
    extern fn e_cal_meta_backend_info_new(p_uid: [*:0]const u8, p_revision: ?[*:0]const u8, p_object: ?[*:0]const u8, p_extra: ?[*:0]const u8) *edatacal.CalMetaBackendInfo;
    pub const new = e_cal_meta_backend_info_new;

    extern fn e_cal_meta_backend_info_copy(p_src: ?*const CalMetaBackendInfo) *edatacal.CalMetaBackendInfo;
    pub const copy = e_cal_meta_backend_info_copy;

    extern fn e_cal_meta_backend_info_get_type() usize;
    pub const getGObjectType = e_cal_meta_backend_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalMetaBackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CalQueueTuple = extern struct {
    f_first: glib.Queue,
    f_second: glib.Queue,
    f_third: glib.Queue,
    f_first_free_func: ?glib.DestroyNotify,
    f_second_free_func: ?glib.DestroyNotify,
    f_third_free_func: ?glib.DestroyNotify,

    extern fn e_cal_queue_tuple_new(p_first_free_func: glib.DestroyNotify, p_second_free_func: glib.DestroyNotify, p_third_free_func: glib.DestroyNotify) *edatacal.CalQueueTuple;
    pub const new = e_cal_queue_tuple_new;

    extern fn e_cal_queue_tuple_free(p_queue_tuple: *CalQueueTuple) void;
    pub const free = e_cal_queue_tuple_free;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCalClass = extern struct {
    pub const Instance = edatacal.DataCal;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *DataCalClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCalFactoryClass = extern struct {
    pub const Instance = edatacal.DataCalFactory;

    f_parent_class: ebackend.DataFactoryClass,

    pub fn as(p_instance: *DataCalFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCalFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCalPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCalViewClass = extern struct {
    pub const Instance = edatacal.DataCalView;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *DataCalViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataCalViewPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edatacal.IntervalTree` class.
pub const IntervalTreeClass = extern struct {
    pub const Instance = edatacal.IntervalTree;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *IntervalTreeClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IntervalTreePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubprocessCalFactoryClass = extern struct {
    pub const Instance = edatacal.SubprocessCalFactory;

    f_parent_class: ebackend.SubprocessFactoryClass,

    pub fn as(p_instance: *SubprocessCalFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubprocessCalFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn e_cal_queue_free_strings(p_queue: *glib.Queue) void;
pub const calQueueFreeStrings = e_cal_queue_free_strings;

/// A callback prototype being called in a dedicated thread, scheduled
/// by `edatacal.CalBackend.scheduleCustomOperation`.
pub const CalBackendCustomOpFunc = *const fn (p_cal_backend: *edatacal.CalBackend, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) void;

/// Callback function used by `edatacal.CalBackend.foreachView`.
pub const CalBackendForeachViewFunc = *const fn (p_backend: *edatacal.CalBackend, p_view: *edatacal.DataCalView, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// A callback called for each object row when using
/// `edatacal.CalCache.searchWithCallback` function.
pub const CalCacheSearchFunc = *const fn (p_cal_cache: *edatacal.CalCache, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_extra: [*:0]const u8, p_custom_flags: u32, p_offline_state: ebackend.OfflineState, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// This environment variable configures where the calendar
/// factory loads its backend modules from.
pub const EDS_CALENDAR_MODULES = "EDS_CALENDAR_MODULES";
/// This environment variable configures where the calendar
/// factory subprocess is located in.
pub const EDS_SUBPROCESS_CAL_PATH = "EDS_SUBPROCESS_CAL_PATH";
pub const INTERVALTREE_DEBUG = 1;
pub const LIBICAL_GLIB_UNSTABLE_API = 1;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
