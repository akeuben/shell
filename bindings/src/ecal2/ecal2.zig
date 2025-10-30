pub const ext = @import("ext.zig");
const ecal = @This();

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
/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const Client = extern struct {
    pub const Parent = edataserver.Client;
    pub const Implements = [_]type{ ecal.TimezoneCache, gio.AsyncInitable, gio.Initable };
    pub const Class = ecal.ClientClass;
    f_parent: edataserver.Client,
    f_priv: ?*ecal.ClientPrivate,

    pub const virtual_methods = struct {
        /// signal used to notify about free/busy data
        pub const free_busy_data = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_free_busy_ecalcomps: *const glib.SList) void {
                return gobject.ext.as(Client.Class, p_class).f_free_busy_data.?(gobject.ext.as(Client, p_client), p_free_busy_ecalcomps);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_free_busy_ecalcomps: *const glib.SList) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_free_busy_data = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const default_timezone = struct {
            pub const name = "default-timezone";

            pub const Type = ?*icalglib.Timezone;
        };

        pub const source_type = struct {
            pub const name = "source-type";

            pub const Type = ecal.ClientSourceType;
        };
    };

    pub const signals = struct {
        pub const free_busy_data = struct {
            pub const name = "free-busy-data";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_free_busy_ecalcomps: **glib.SList, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Client, p_instance))),
                    gobject.signalLookup("free-busy-data", Client.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// This function cleans up VEVENT, VJOURNAL, VTODO and VTIMEZONE
    /// items which are to be imported into Evolution.
    ///
    /// Using VTIMEZONE definitions is problematic because they cannot be
    /// updated properly when timezone definitions change. They are also
    /// incomplete (for compatibility reason only one set of rules for
    /// summer saving changes can be included, even if different rules
    /// apply in different years). This function looks for matches of the
    /// used TZIDs against system timezones and replaces such TZIDs with
    /// the corresponding system timezone. This works for TZIDs containing
    /// a location (found via a fuzzy string search) and for Outlook TZIDs
    /// (via a hard-coded lookup table).
    ///
    /// Some programs generate broken meeting invitations with TZID, but
    /// without including the corresponding VTIMEZONE. Importing such
    /// invitations unchanged causes problems later on (meeting displayed
    /// incorrectly, `ecal.Component.getAsString` fails). The situation
    /// where this occurred in the past (found by a SyncEvolution user) is
    /// now handled via the location based mapping.
    ///
    /// If this mapping fails, this function also deals with VTIMEZONE
    /// conflicts: such conflicts occur when the calendar already contains
    /// an old VTIMEZONE definition with the same TZID, but different
    /// summer saving rules. Replacing the VTIMEZONE potentially breaks
    /// displaying of old events, whereas not replacing it breaks the new
    /// events (the behavior in Evolution <= 2.22.1).
    ///
    /// The way this problem is resolved by renaming the new VTIMEZONE
    /// definition until the TZID is unique. A running count is appended to
    /// the TZID. All items referencing the renamed TZID are adapted
    /// accordingly.
    extern fn e_cal_client_check_timezones_sync(p_vcalendar: *icalglib.Component, p_icalcomps: ?*glib.SList, p_tzlookup: ecal.RecurResolveTimezoneCb, p_tzlookup_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const checkTimezonesSync = e_cal_client_check_timezones_sync;

    /// Asynchronously creates a new `ecal.Client` for `source` and `source_type`.
    ///
    /// The `wait_for_connected_seconds` argument had been added since 3.16,
    /// to let the caller decide how long to wait for the backend to fully
    /// connect to its (possibly remote) data store. This is required due
    /// to a change in the authentication process, which is fully asynchronous
    /// and done on the client side, while not every client is supposed to
    /// response to authentication requests. In case the backend will not connect
    /// within the set interval, then it is opened in an offline mode. A special
    /// value -1 can be used to not wait for the connected state at all.
    ///
    /// Unlike with `e_cal_client_new`, there is no need to call `edataserver.Client.open`
    /// after obtaining the `ecal.Client`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ecal.Client.connectFinish` to get the result of the operation.
    extern fn e_cal_client_connect(p_source: *edataserver.Source, p_source_type: ecal.ClientSourceType, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const connect = e_cal_client_connect;

    /// Finishes the operation started with `ecal.Client.connect`.  If an
    /// error occurs in connecting to the D-Bus service, the function sets
    /// `error` and returns `NULL`.
    ///
    /// For error handling convenience, any error message returned by this
    /// function will have a descriptive prefix that includes the display
    /// name of the `edataserver.Source` passed to `ecal.Client.connect`.
    extern fn e_cal_client_connect_finish(p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*edataserver.Client;
    pub const connectFinish = e_cal_client_connect_finish;

    /// Creates a new `ecal.Client` for `source` and `source_type`.  If an error
    /// occurs, the function will set `error` and return `FALSE`.
    ///
    /// The `wait_for_connected_seconds` argument had been added since 3.16,
    /// to let the caller decide how long to wait for the backend to fully
    /// connect to its (possibly remote) data store. This is required due
    /// to a change in the authentication process, which is fully asynchronous
    /// and done on the client side, while not every client is supposed to
    /// response to authentication requests. In case the backend will not connect
    /// within the set interval, then it is opened in an offline mode. A special
    /// value -1 can be used to not wait for the connected state at all.
    ///
    /// Unlike with `e_cal_client_new`, there is no need to call
    /// `edataserver.Client.openSync` after obtaining the `ecal.Client`.
    ///
    /// For error handling convenience, any error message returned by this
    /// function will have a descriptive prefix that includes the display
    /// name of `source`.
    extern fn e_cal_client_connect_sync(p_source: *edataserver.Source, p_source_type: ecal.ClientSourceType, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edataserver.Client;
    pub const connectSync = e_cal_client_connect_sync;

    extern fn e_cal_client_error_create(p_code: ecal.ClientError, p_custom_msg: ?[*:0]const u8) *glib.Error;
    pub const errorCreate = e_cal_client_error_create;

    /// Similar as `ecal.Client.errorCreate`, only here, instead of custom_msg,
    /// is used a `printf` format to create a custom message for the error.
    extern fn e_cal_client_error_create_fmt(p_code: ecal.ClientError, p_format: ?[*:0]const u8, ...) *glib.Error;
    pub const errorCreateFmt = e_cal_client_error_create_fmt;

    extern fn e_cal_client_error_quark() glib.Quark;
    pub const errorQuark = e_cal_client_error_quark;

    /// Get localized human readable description of the given error code.
    extern fn e_cal_client_error_to_string(p_code: ecal.ClientError) [*:0]const u8;
    pub const errorToString = e_cal_client_error_to_string;

    /// An implementation of the `ecal.RecurResolveTimezoneCb` callback which clients
    /// can use. Calls `ecal.Client.getTimezoneSync`.
    ///
    /// The returned timezone object, if not `NULL`, is owned by the `ecalclient`.
    extern fn e_cal_client_tzlookup_cb(p_tzid: [*:0]const u8, p_ecalclient: *ecal.Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*icalglib.Timezone;
    pub const tzlookupCb = e_cal_client_tzlookup_cb;

    /// An implementation of the `ecal.RecurResolveTimezoneCb` callback which
    /// backends can use. Searches for the timezone in an `ICalComponent`
    /// associated with the `lookup_data` `ecal.ClientTzlookupICalCompData`.
    ///
    /// The returned timezone object is owned by the `lookup_data`.
    extern fn e_cal_client_tzlookup_icalcomp_cb(p_tzid: [*:0]const u8, p_lookup_data: *ecal.ClientTzlookupICalCompData, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*icalglib.Timezone;
    pub const tzlookupIcalcompCb = e_cal_client_tzlookup_icalcomp_cb;

    /// Add a VTIMEZONE object to the given calendar client.
    /// The call is finished by `ecal.Client.addTimezoneFinish` from
    /// the `callback`.
    extern fn e_cal_client_add_timezone(p_client: *Client, p_zone: *icalglib.Timezone, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const addTimezone = e_cal_client_add_timezone;

    /// Finishes previous call of `ecal.Client.addTimezone`.
    extern fn e_cal_client_add_timezone_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const addTimezoneFinish = e_cal_client_add_timezone_finish;

    /// Add a VTIMEZONE object to the given calendar client.
    extern fn e_cal_client_add_timezone_sync(p_client: *Client, p_zone: *icalglib.Timezone, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const addTimezoneSync = e_cal_client_add_timezone_sync;

    /// Checks if a calendar supports only one alarm per component.
    extern fn e_cal_client_check_one_alarm_only(p_client: *Client) c_int;
    pub const checkOneAlarmOnly = e_cal_client_check_one_alarm_only;

    /// Checks whether a calendar requires organizer to accept their attendance to
    /// meetings.
    extern fn e_cal_client_check_organizer_must_accept(p_client: *Client) c_int;
    pub const checkOrganizerMustAccept = e_cal_client_check_organizer_must_accept;

    /// Checks if a calendar forces organizers of meetings to be also attendees.
    extern fn e_cal_client_check_organizer_must_attend(p_client: *Client) c_int;
    pub const checkOrganizerMustAttend = e_cal_client_check_organizer_must_attend;

    /// Checks if the calendar has a master object for recurrences.
    extern fn e_cal_client_check_recurrences_no_master(p_client: *Client) c_int;
    pub const checkRecurrencesNoMaster = e_cal_client_check_recurrences_no_master;

    /// Checks whether the calendar saves schedules.
    extern fn e_cal_client_check_save_schedules(p_client: *Client) c_int;
    pub const checkSaveSchedules = e_cal_client_check_save_schedules;

    /// Requests the calendar backend to create the object specified by the `icalcomp`
    /// argument. Some backends would assign a specific UID to the newly created object,
    /// but this function does not modify the original `icalcomp` if its UID changes.
    /// The call is finished by `ecal.Client.createObjectFinish` from
    /// the `callback`.
    extern fn e_cal_client_create_object(p_client: *Client, p_icalcomp: *icalglib.Component, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const createObject = e_cal_client_create_object;

    /// Finishes previous call of `ecal.Client.createObject` and
    /// sets `out_uid` to newly assigned UID for the created object.
    /// This `out_uid` should be freed with `glib.free`.
    extern fn e_cal_client_create_object_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_uid: ?*[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const createObjectFinish = e_cal_client_create_object_finish;

    /// Requests the calendar backend to create the object specified by the
    /// `icalcomp` argument. Some backends would assign a specific UID to the newly
    /// created object, in those cases that UID would be returned in the `out_uid`
    /// argument. This function does not modify the original `icalcomp` if its UID
    /// changes.  Returned `out_uid` should be freed with `glib.free`.
    extern fn e_cal_client_create_object_sync(p_client: *Client, p_icalcomp: *icalglib.Component, p_opflags: ecal.OperationFlags, p_out_uid: ?*[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const createObjectSync = e_cal_client_create_object_sync;

    /// Requests the calendar backend to create the objects specified by the `icalcomps`
    /// argument. Some backends would assign a specific UID to the newly created object,
    /// but this function does not modify the original `icalcomps` if their UID changes.
    /// The call is finished by `ecal.Client.createObjectsFinish` from
    /// the `callback`.
    extern fn e_cal_client_create_objects(p_client: *Client, p_icalcomps: *glib.SList, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const createObjects = e_cal_client_create_objects;

    /// Finishes previous call of `ecal.Client.createObjects` and
    /// sets `out_uids` to newly assigned UIDs for the created objects.
    /// This `out_uids` should be freed with `edataserver.Client.utilFreeStringSlist`.
    extern fn e_cal_client_create_objects_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_uids: ?**glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const createObjectsFinish = e_cal_client_create_objects_finish;

    /// Requests the calendar backend to create the objects specified by the
    /// `icalcomps` argument. Some backends would assign a specific UID to the
    /// newly created objects, in those cases these UIDs would be returned in
    /// the `out_uids` argument. This function does not modify the original
    /// `icalcomps` if their UID changes.  Returned `out_uids` should be freed
    /// with `edataserver.Client.utilFreeStringSlist`.
    extern fn e_cal_client_create_objects_sync(p_client: *Client, p_icalcomps: *glib.SList, p_opflags: ecal.OperationFlags, p_out_uids: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const createObjectsSync = e_cal_client_create_objects_sync;

    /// Discards alarm `auid` from a given component identified by `uid` and `rid`.
    /// The call is finished by `ecal.Client.discardAlarmFinish` from
    /// the `callback`.
    extern fn e_cal_client_discard_alarm(p_client: *Client, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const discardAlarm = e_cal_client_discard_alarm;

    /// Finishes previous call of `ecal.Client.discardAlarm`.
    extern fn e_cal_client_discard_alarm_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const discardAlarmFinish = e_cal_client_discard_alarm_finish;

    /// Discards alarm `auid` from a given component identified by `uid` and `rid`.
    extern fn e_cal_client_discard_alarm_sync(p_client: *Client, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_auid: [*:0]const u8, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const discardAlarmSync = e_cal_client_discard_alarm_sync;

    /// Does a combination of `ecal.Client.getObjectList` and
    /// `ecal.recurGenerateInstancesSync`. Unlike
    /// `ecal.Client.generateInstancesSync`, this returns immediately and the
    /// `cb` callback is called asynchronously.
    ///
    /// The callback function should do a `gobject.Object.ref` of the calendar component
    /// it gets passed if it intends to keep it around, since it will be unref'ed
    /// as soon as the callback returns.
    extern fn e_cal_client_generate_instances(p_client: *Client, p_start: std.posix.time_t, p_end: std.posix.time_t, p_cancellable: ?*gio.Cancellable, p_cb: ecal.RecurInstanceCb, p_cb_data: ?*anyopaque, p_destroy_cb_data: ?glib.DestroyNotify) void;
    pub const generateInstances = e_cal_client_generate_instances;

    /// Does a combination of `ecal.Client.getObjectList` and
    /// `ecal.recurGenerateInstancesSync`, like
    /// `ecal.Client.generateInstances`, but for a single object. Unlike
    /// `ecal.Client.generateInstancesForObjectSync`, this returns immediately
    /// and the `cb` callback is called asynchronously.
    ///
    /// The callback function should do a `gobject.Object.ref` of the calendar component
    /// it gets passed if it intends to keep it around, since it will be unref'ed
    /// as soon as the callback returns.
    extern fn e_cal_client_generate_instances_for_object(p_client: *Client, p_icalcomp: *icalglib.Component, p_start: std.posix.time_t, p_end: std.posix.time_t, p_cancellable: ?*gio.Cancellable, p_cb: ecal.RecurInstanceCb, p_cb_data: ?*anyopaque, p_destroy_cb_data: ?glib.DestroyNotify) void;
    pub const generateInstancesForObject = e_cal_client_generate_instances_for_object;

    /// Does a combination of `ecal.Client.getObjectList` and
    /// `ecal.recurGenerateInstancesSync`, like
    /// `ecal.Client.generateInstancesSync`, but for a single object.
    ///
    /// The callback function should do a `gobject.Object.ref` of the calendar component
    /// it gets passed if it intends to keep it around, since it will be unref'ed
    /// as soon as the callback returns.
    extern fn e_cal_client_generate_instances_for_object_sync(p_client: *Client, p_icalcomp: *icalglib.Component, p_start: std.posix.time_t, p_end: std.posix.time_t, p_cancellable: ?*gio.Cancellable, p_cb: ecal.RecurInstanceCb, p_cb_data: ?*anyopaque) void;
    pub const generateInstancesForObjectSync = e_cal_client_generate_instances_for_object_sync;

    /// Does a combination of `ecal.Client.getObjectList` and
    /// `ecal.recurGenerateInstancesSync`, like
    /// `ecal.Client.generateInstancesSync`, but for a single object.
    ///
    /// The callback function should do a `gobject.Object.ref` of the calendar component
    /// it gets passed if it intends to keep it around, since it will be unref'ed
    /// as soon as the callback returns.
    extern fn e_cal_client_generate_instances_for_uid_sync(p_client: *Client, p_uid: [*:0]const u8, p_start: std.posix.time_t, p_end: std.posix.time_t, p_cancellable: ?*gio.Cancellable, p_cb: ecal.RecurInstanceCb, p_cb_data: ?*anyopaque) void;
    pub const generateInstancesForUidSync = e_cal_client_generate_instances_for_uid_sync;

    /// Does a combination of `ecal.Client.getObjectList` and
    /// `ecal.recurGenerateInstancesSync`.
    ///
    /// The callback function should do a `gobject.Object.ref` of the calendar component
    /// it gets passed if it intends to keep it around, since it will be unreffed
    /// as soon as the callback returns.
    extern fn e_cal_client_generate_instances_sync(p_client: *Client, p_start: std.posix.time_t, p_end: std.posix.time_t, p_cancellable: ?*gio.Cancellable, p_cb: ecal.RecurInstanceCb, p_cb_data: ?*anyopaque) void;
    pub const generateInstancesSync = e_cal_client_generate_instances_sync;

    /// Queries a calendar for a specified component's object attachment uris.
    /// The call is finished by `ecal.Client.getAttachmentUrisFinish` from
    /// the `callback`.
    extern fn e_cal_client_get_attachment_uris(p_client: *Client, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getAttachmentUris = e_cal_client_get_attachment_uris;

    /// Finishes previous call of `ecal.Client.getAttachmentUris` and
    /// sets `out_attachment_uris` to uris for component's attachments.
    /// The list should be freed with `edataserver.Client.utilFreeStringSlist`.
    extern fn e_cal_client_get_attachment_uris_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_attachment_uris: **glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const getAttachmentUrisFinish = e_cal_client_get_attachment_uris_finish;

    /// Queries a calendar for a specified component's object attachment URIs.
    /// The list should be freed with `edataserver.Client.utilFreeStringSlist`.
    extern fn e_cal_client_get_attachment_uris_sync(p_client: *Client, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_out_attachment_uris: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getAttachmentUrisSync = e_cal_client_get_attachment_uris_sync;

    /// Gets a calendar component as an iCalendar string, with a toplevel
    /// VCALENDAR component and all VTIMEZONEs needed for the component.
    extern fn e_cal_client_get_component_as_string(p_client: *Client, p_icalcomp: *icalglib.Component) ?[*:0]u8;
    pub const getComponentAsString = e_cal_client_get_component_as_string;

    /// Retrives an `ICalComponent` from the backend that contains the default
    /// values for properties needed. The call is finished
    /// by `ecal.Client.getDefaultObjectFinish` from the `callback`.
    extern fn e_cal_client_get_default_object(p_client: *Client, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getDefaultObject = e_cal_client_get_default_object;

    /// Finishes previous call of `ecal.Client.getDefaultObject` and
    /// sets `out_icalcomp` to an `ICalComponent` from the backend that contains
    /// the default values for properties needed. This `out_icalcomp` should be
    /// freed with `gobject.Object.unref`, when no longer needed.
    extern fn e_cal_client_get_default_object_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_icalcomp: **icalglib.Component, p_error: ?*?*glib.Error) c_int;
    pub const getDefaultObjectFinish = e_cal_client_get_default_object_finish;

    /// Retrives an `ICalComponent` from the backend that contains the default
    /// values for properties needed. This `out_icalcomp` should be freed with
    /// `gobject.Object.unref`, when no longer needed.
    extern fn e_cal_client_get_default_object_sync(p_client: *Client, p_out_icalcomp: **icalglib.Component, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getDefaultObjectSync = e_cal_client_get_default_object_sync;

    /// Returns the default timezone previously set with
    /// `ecal.Client.setDefaultTimezone`.  The returned pointer is owned by
    /// the `client` and should not be freed.
    extern fn e_cal_client_get_default_timezone(p_client: *Client) *icalglib.Timezone;
    pub const getDefaultTimezone = e_cal_client_get_default_timezone;

    /// Begins retrieval of free/busy information from the calendar server
    /// as a list of `ecal.Component`-s. Connect to "free-busy-data" signal
    /// to receive chunks of free/busy components.
    /// The call is finished by `ecal.Client.getFreeBusyFinish` from
    /// the `callback`.
    extern fn e_cal_client_get_free_busy(p_client: *Client, p_start: std.posix.time_t, p_end: std.posix.time_t, p_users: *const glib.SList, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getFreeBusy = e_cal_client_get_free_busy;

    /// Finishes previous call of `ecal.Client.getFreeBusy`.
    /// The `out_freebusy` contains all VFREEBUSY `ecal.Component`-s, which could be also
    /// received by "free-busy-data" signal. The client is responsible to do a merge of
    /// the components between this complete list and those received through the signal.
    extern fn e_cal_client_get_free_busy_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_freebusy: **glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const getFreeBusyFinish = e_cal_client_get_free_busy_finish;

    /// Gets free/busy information from the calendar server.
    /// The `out_freebusy` contains all VFREEBUSY `ecal.Component`-s, which could be also
    /// received by "free-busy-data" signal. The client is responsible to do a merge of
    /// the components between this complete list and those received through the signal.
    extern fn e_cal_client_get_free_busy_sync(p_client: *Client, p_start: std.posix.time_t, p_end: std.posix.time_t, p_users: *const glib.SList, p_out_freebusy: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getFreeBusySync = e_cal_client_get_free_busy_sync;

    /// Queries the URL where the calendar attachments are
    /// serialized in the local filesystem. This enable clients
    /// to operate with the reference to attachments rather than the data itself
    /// unless it specifically uses the attachments for open/sending
    /// operations.
    extern fn e_cal_client_get_local_attachment_store(p_client: *Client) [*:0]const u8;
    pub const getLocalAttachmentStore = e_cal_client_get_local_attachment_store;

    /// Queries a calendar for a calendar component object based on its unique
    /// identifier. The call is finished by `ecal.Client.getObjectFinish`
    /// from the `callback`.
    ///
    /// Use `ecal.Client.getObjectsForUid` to get list of all
    /// objects for the given uid, which includes master object and
    /// all detached instances.
    extern fn e_cal_client_get_object(p_client: *Client, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getObject = e_cal_client_get_object;

    /// Finishes previous call of `ecal.Client.getObject` and
    /// sets `out_icalcomp` to queried component. This function always returns
    /// master object for a case of `rid` being NULL or an empty string.
    /// This component should be freed with `gobject.Object.unref`, when no longer needed.
    ///
    /// Use `ecal.Client.getObjectsForUid` to get list of all
    /// objects for the given uid, which includes master object and
    /// all detached instances.
    extern fn e_cal_client_get_object_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_icalcomp: **icalglib.Component, p_error: ?*?*glib.Error) c_int;
    pub const getObjectFinish = e_cal_client_get_object_finish;

    /// Gets a list of objects from the calendar that match the query specified
    /// by the `sexp` argument, returning matching objects as a list of `ICalComponent`-s.
    /// The call is finished by `ecal.Client.getObjectListFinish` from
    /// the `callback`.
    extern fn e_cal_client_get_object_list(p_client: *Client, p_sexp: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getObjectList = e_cal_client_get_object_list;

    /// Gets a list of objects from the calendar that match the query specified
    /// by the `sexp` argument, returning matching objects as a list of `ecal.Component`-s.
    /// The call is finished by `ecal.Client.getObjectListAsCompsFinish` from
    /// the `callback`.
    extern fn e_cal_client_get_object_list_as_comps(p_client: *Client, p_sexp: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getObjectListAsComps = e_cal_client_get_object_list_as_comps;

    /// Finishes previous call of `ecal.Client.getObjectListAsComps` and
    /// sets `out_ecalcomps` to a matching list of `ecal.Component`-s.
    /// This list should be freed with `edataserver.Client.utilFreeObjectSlist`.
    extern fn e_cal_client_get_object_list_as_comps_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_ecalcomps: **glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const getObjectListAsCompsFinish = e_cal_client_get_object_list_as_comps_finish;

    /// Gets a list of objects from the calendar that match the query specified
    /// by the `sexp` argument. The objects will be returned in the `out_ecalcomps`
    /// argument, which is a list of `ecal.Component`.
    /// This list should be freed with `edataserver.Client.utilFreeObjectSlist`.
    extern fn e_cal_client_get_object_list_as_comps_sync(p_client: *Client, p_sexp: [*:0]const u8, p_out_ecalcomps: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getObjectListAsCompsSync = e_cal_client_get_object_list_as_comps_sync;

    /// Finishes previous call of `ecal.Client.getObjectList` and
    /// sets `out_icalcomps` to a matching list of `ICalComponent`-s.
    /// This list should be freed with `edataserver.Client.utilFreeObjectSlist`.
    extern fn e_cal_client_get_object_list_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_icalcomps: **glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const getObjectListFinish = e_cal_client_get_object_list_finish;

    /// Gets a list of objects from the calendar that match the query specified
    /// by the `sexp` argument. The objects will be returned in the `out_icalcomps`
    /// argument, which is a list of `ICalComponent`.
    /// This list should be freed with `edataserver.Client.utilFreeObjectSlist`.
    extern fn e_cal_client_get_object_list_sync(p_client: *Client, p_sexp: [*:0]const u8, p_out_icalcomps: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getObjectListSync = e_cal_client_get_object_list_sync;

    /// Queries a calendar for a calendar component object based
    /// on its unique identifier. This function always returns
    /// master object for a case of `rid` being NULL or an empty string.
    /// This component should be freed with `gobject.Object.unref`,
    /// when no longer needed.
    ///
    /// Use `ecal.Client.getObjectsForUidSync` to get list of all
    /// objects for the given uid, which includes master object and
    /// all detached instances.
    extern fn e_cal_client_get_object_sync(p_client: *Client, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_out_icalcomp: **icalglib.Component, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getObjectSync = e_cal_client_get_object_sync;

    /// Queries a calendar for all calendar components with the given unique
    /// ID. This will return any recurring event and all its detached recurrences.
    /// For non-recurring events, it will just return the object with that ID.
    /// The call is finished by `ecal.Client.getObjectsForUidFinish` from
    /// the `callback`.
    extern fn e_cal_client_get_objects_for_uid(p_client: *Client, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getObjectsForUid = e_cal_client_get_objects_for_uid;

    /// Finishes previous call of `ecal.Client.getObjectsForUid` and
    /// sets `out_ecalcomps` to a list of `ecal.Component`<!-- -->s corresponding to
    /// found components for a given uid of the same type as this client.
    /// This list should be freed with `edataserver.Client.utilFreeObjectSlist`.
    extern fn e_cal_client_get_objects_for_uid_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_ecalcomps: **glib.SList, p_error: ?*?*glib.Error) c_int;
    pub const getObjectsForUidFinish = e_cal_client_get_objects_for_uid_finish;

    /// Queries a calendar for all calendar components with the given unique
    /// ID. This will return any recurring event and all its detached recurrences.
    /// For non-recurring events, it will just return the object with that ID.
    /// This list should be freed with `edataserver.Client.utilFreeObjectSlist`.
    extern fn e_cal_client_get_objects_for_uid_sync(p_client: *Client, p_uid: [*:0]const u8, p_out_ecalcomps: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getObjectsForUidSync = e_cal_client_get_objects_for_uid_sync;

    /// Gets the source type of the calendar client.
    extern fn e_cal_client_get_source_type(p_client: *Client) ecal.ClientSourceType;
    pub const getSourceType = e_cal_client_get_source_type;

    /// Retrieves a timezone object from the calendar backend.
    /// The call is finished by `ecal.Client.getTimezoneFinish` from
    /// the `callback`.
    extern fn e_cal_client_get_timezone(p_client: *Client, p_tzid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getTimezone = e_cal_client_get_timezone;

    /// Finishes previous call of `ecal.Client.getTimezone` and
    /// sets `out_zone` to a retrieved timezone object from the calendar backend.
    /// This object is owned by the `client`, thus do not free it.
    extern fn e_cal_client_get_timezone_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_zone: **icalglib.Timezone, p_error: ?*?*glib.Error) c_int;
    pub const getTimezoneFinish = e_cal_client_get_timezone_finish;

    /// Retrieves a timezone object from the calendar backend.
    /// This object is owned by the `client`, thus do not free it.
    extern fn e_cal_client_get_timezone_sync(p_client: *Client, p_tzid: [*:0]const u8, p_out_zone: **icalglib.Timezone, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getTimezoneSync = e_cal_client_get_timezone_sync;

    /// Query `client` with `sexp`, creating an `ecal.ClientView`.
    /// The call is finished by `ecal.Client.getViewFinish`
    /// from the `callback`.
    extern fn e_cal_client_get_view(p_client: *Client, p_sexp: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getView = e_cal_client_get_view;

    /// Finishes previous call of `ecal.Client.getView`.
    /// If successful, then the `out_view` is set to newly allocated `ecal.ClientView`,
    /// which should be freed with `gobject.Object.unref`.
    extern fn e_cal_client_get_view_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_view: **ecal.ClientView, p_error: ?*?*glib.Error) c_int;
    pub const getViewFinish = e_cal_client_get_view_finish;

    /// Query `client` with `sexp`, creating an `ecal.ClientView`.
    /// If successful, then the `out_view` is set to newly allocated `ecal.ClientView`,
    /// which should be freed with `gobject.Object.unref`.
    extern fn e_cal_client_get_view_sync(p_client: *Client, p_sexp: [*:0]const u8, p_out_view: **ecal.ClientView, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getViewSync = e_cal_client_get_view_sync;

    /// Requests the calendar backend to modify an existing object. If the object
    /// does not exist on the calendar, an error will be returned.
    ///
    /// For recurrent appointments, the `mod` argument specifies what to modify,
    /// if all instances (`E_CAL_OBJ_MOD_ALL`), a single instance (`E_CAL_OBJ_MOD_THIS`),
    /// or a specific set of instances (`E_CAL_OBJ_MOD_THIS_AND_PRIOR` and
    /// `E_CAL_OBJ_MOD_THIS_AND_FUTURE`).
    ///
    /// The call is finished by `ecal.Client.modifyObjectFinish` from
    /// the `callback`.
    extern fn e_cal_client_modify_object(p_client: *Client, p_icalcomp: *icalglib.Component, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const modifyObject = e_cal_client_modify_object;

    /// Finishes previous call of `ecal.Client.modifyObject`.
    extern fn e_cal_client_modify_object_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const modifyObjectFinish = e_cal_client_modify_object_finish;

    /// Requests the calendar backend to modify an existing object. If the object
    /// does not exist on the calendar, an error will be returned.
    ///
    /// For recurrent appointments, the `mod` argument specifies what to modify,
    /// if all instances (`E_CAL_OBJ_MOD_ALL`), a single instance (`E_CAL_OBJ_MOD_THIS`),
    /// or a specific set of instances (`E_CAL_OBJ_MOD_THIS_AND_PRIOR` and
    /// `E_CAL_OBJ_MOD_THIS_AND_FUTURE`).
    extern fn e_cal_client_modify_object_sync(p_client: *Client, p_icalcomp: *icalglib.Component, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const modifyObjectSync = e_cal_client_modify_object_sync;

    /// Requests the calendar backend to modify existing objects. If an object
    /// does not exist on the calendar, an error will be returned.
    ///
    /// For recurrent appointments, the `mod` argument specifies what to modify,
    /// if all instances (`E_CAL_OBJ_MOD_ALL`), a single instance (`E_CAL_OBJ_MOD_THIS`),
    /// or a specific set of instances (`E_CAL_OBJ_MOD_THIS_AND_PRIOR` and
    /// `E_CAL_OBJ_MOD_THIS_AND_FUTURE`).
    ///
    /// The call is finished by `ecal.Client.modifyObjectsFinish` from
    /// the `callback`.
    extern fn e_cal_client_modify_objects(p_client: *Client, p_icalcomps: *glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const modifyObjects = e_cal_client_modify_objects;

    /// Finishes previous call of `ecal.Client.modifyObjects`.
    extern fn e_cal_client_modify_objects_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const modifyObjectsFinish = e_cal_client_modify_objects_finish;

    /// Requests the calendar backend to modify existing objects. If an object
    /// does not exist on the calendar, an error will be returned.
    ///
    /// For recurrent appointments, the `mod` argument specifies what to modify,
    /// if all instances (`E_CAL_OBJ_MOD_ALL`), a single instance (`E_CAL_OBJ_MOD_THIS`),
    /// or a specific set of instances (`E_CAL_OBJ_MOD_THIS_AND_PRIOR` and
    /// `E_CAL_OBJ_MOD_THIS_AND_FUTURE`).
    extern fn e_cal_client_modify_objects_sync(p_client: *Client, p_icalcomps: *glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const modifyObjectsSync = e_cal_client_modify_objects_sync;

    /// Makes the backend receive the set of iCalendar objects specified in the
    /// `icalcomp` argument. This is used for iTIP confirmation/cancellation
    /// messages for scheduled meetings.
    ///
    /// The call is finished by `ecal.Client.receiveObjectsFinish` from
    /// the `callback`.
    extern fn e_cal_client_receive_objects(p_client: *Client, p_icalcomp: *icalglib.Component, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const receiveObjects = e_cal_client_receive_objects;

    /// Finishes previous call of `ecal.Client.receiveObjects`.
    extern fn e_cal_client_receive_objects_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const receiveObjectsFinish = e_cal_client_receive_objects_finish;

    /// Makes the backend receive the set of iCalendar objects specified in the
    /// `icalcomp` argument. This is used for iTIP confirmation/cancellation
    /// messages for scheduled meetings.
    extern fn e_cal_client_receive_objects_sync(p_client: *Client, p_icalcomp: *icalglib.Component, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const receiveObjectsSync = e_cal_client_receive_objects_sync;

    /// This function allows the removal of instances of a recurrent
    /// appointment. By using a combination of the `uid`, `rid` and `mod`
    /// arguments, you can remove specific instances. If what you want
    /// is to remove all instances, use `NULL` `rid` and `E_CAL_OBJ_MOD_ALL`
    /// for the `mod`.
    ///
    /// The call is finished by `ecal.Client.removeObjectFinish` from
    /// the `callback`.
    extern fn e_cal_client_remove_object(p_client: *Client, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const removeObject = e_cal_client_remove_object;

    /// Finishes previous call of `ecal.Client.removeObject`.
    extern fn e_cal_client_remove_object_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeObjectFinish = e_cal_client_remove_object_finish;

    /// This function allows the removal of instances of a recurrent
    /// appointment. By using a combination of the `uid`, `rid` and `mod`
    /// arguments, you can remove specific instances. If what you want
    /// is to remove all instances, use `NULL` `rid` and `E_CAL_OBJ_MOD_ALL`
    /// for the `mod`.
    extern fn e_cal_client_remove_object_sync(p_client: *Client, p_uid: [*:0]const u8, p_rid: ?[*:0]const u8, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeObjectSync = e_cal_client_remove_object_sync;

    /// This function allows the removal of instances of recurrent appointments.
    /// `ecal.ComponentId` objects can identify specific instances (if rid is not
    /// `NULL`).  If what you want is to remove all instances, use a `NULL` rid in
    /// the `ecal.ComponentId` and `E_CAL_OBJ_MOD_ALL` for the `mod`.
    ///
    /// The call is finished by `ecal.Client.removeObjectsFinish` from
    /// the `callback`.
    extern fn e_cal_client_remove_objects(p_client: *Client, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const removeObjects = e_cal_client_remove_objects;

    /// Finishes previous call of `ecal.Client.removeObjects`.
    extern fn e_cal_client_remove_objects_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeObjectsFinish = e_cal_client_remove_objects_finish;

    /// This function allows the removal of instances of recurrent
    /// appointments. `ecal.ComponentId` objects can identify specific instances
    /// (if rid is not `NULL`).  If what you want is to remove all instances, use
    /// a `NULL` rid in the `ecal.ComponentId` and `E_CAL_OBJ_MOD_ALL` for the `mod`.
    extern fn e_cal_client_remove_objects_sync(p_client: *Client, p_ids: *const glib.SList, p_mod: ecal.ObjModType, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeObjectsSync = e_cal_client_remove_objects_sync;

    /// Requests a calendar backend to send meeting information stored in `icalcomp`.
    /// The backend can modify this component and request a send to particular users.
    /// The call is finished by `ecal.Client.sendObjectsFinish` from
    /// the `callback`.
    extern fn e_cal_client_send_objects(p_client: *Client, p_icalcomp: *icalglib.Component, p_opflags: ecal.OperationFlags, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const sendObjects = e_cal_client_send_objects;

    /// Finishes previous call of `ecal.Client.sendObjects` and
    /// populates `out_users` with a list of users to send `out_modified_icalcomp` to.
    ///
    /// The `out_users` list should be freed with `edataserver.Client.utilFreeStringSlist`
    /// and the `out_modified_icalcomp` should be freed with `gobject.Object.unref`.
    extern fn e_cal_client_send_objects_finish(p_client: *Client, p_result: *gio.AsyncResult, p_out_users: **glib.SList, p_out_modified_icalcomp: **icalglib.Component, p_error: ?*?*glib.Error) c_int;
    pub const sendObjectsFinish = e_cal_client_send_objects_finish;

    /// Requests a calendar backend to send meeting information stored in `icalcomp`.
    /// The backend can modify this component and request a send to users in the
    /// `out_users` list.
    ///
    /// The `out_users` list should be freed with `edataserver.Client.utilFreeStringSlist`
    /// and the `out_modified_icalcomp` should be freed with `gobject.Object.unref`.
    extern fn e_cal_client_send_objects_sync(p_client: *Client, p_icalcomp: *icalglib.Component, p_opflags: ecal.OperationFlags, p_out_users: **glib.SList, p_out_modified_icalcomp: **icalglib.Component, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const sendObjectsSync = e_cal_client_send_objects_sync;

    /// Sets the default timezone to use to resolve DATE and floating DATE-TIME
    /// values. This will typically be from the user's timezone setting. Call this
    /// before using any other object fetching functions.
    extern fn e_cal_client_set_default_timezone(p_client: *Client, p_zone: *icalglib.Timezone) void;
    pub const setDefaultTimezone = e_cal_client_set_default_timezone;

    extern fn e_cal_client_get_type() usize;
    pub const getGObjectType = e_cal_client_get_type;

    extern fn g_object_ref(p_self: *ecal.Client) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ecal.Client) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Client, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const ClientView = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = ecal.ClientViewClass;
    f_object: gobject.Object,
    f_priv: ?*ecal.ClientViewPrivate,

    pub const virtual_methods = struct {
        /// A signal emitted when the backend finished initial view population
        pub const complete = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: *const glib.Error) void {
                return gobject.ext.as(ClientView.Class, p_class).f_complete.?(gobject.ext.as(ClientView, p_client_view), p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: *const glib.Error) callconv(.c) void) void {
                gobject.ext.as(ClientView.Class, p_class).f_complete = @ptrCast(p_implementation);
            }
        };

        /// A signal emitted when new objects are added into the view
        pub const objects_added = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_objects: *const glib.SList) void {
                return gobject.ext.as(ClientView.Class, p_class).f_objects_added.?(gobject.ext.as(ClientView, p_client_view), p_objects);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_objects: *const glib.SList) callconv(.c) void) void {
                gobject.ext.as(ClientView.Class, p_class).f_objects_added = @ptrCast(p_implementation);
            }
        };

        /// A signal emitted when some objects are modified in the view
        pub const objects_modified = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_objects: *const glib.SList) void {
                return gobject.ext.as(ClientView.Class, p_class).f_objects_modified.?(gobject.ext.as(ClientView, p_client_view), p_objects);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_objects: *const glib.SList) callconv(.c) void) void {
                gobject.ext.as(ClientView.Class, p_class).f_objects_modified = @ptrCast(p_implementation);
            }
        };

        /// A signal emitted when some objects are removed from the view
        pub const objects_removed = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *const glib.SList) void {
                return gobject.ext.as(ClientView.Class, p_class).f_objects_removed.?(gobject.ext.as(ClientView, p_client_view), p_uids);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *const glib.SList) callconv(.c) void) void {
                gobject.ext.as(ClientView.Class, p_class).f_objects_removed = @ptrCast(p_implementation);
            }
        };

        /// A signal emitted when the backend notifies about the progress
        pub const progress = struct {
            pub fn call(p_class: anytype, p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_percent: c_uint, p_message: [*:0]const u8) void {
                return gobject.ext.as(ClientView.Class, p_class).f_progress.?(gobject.ext.as(ClientView, p_client_view), p_percent, p_message);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client_view: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_percent: c_uint, p_message: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(ClientView.Class, p_class).f_progress = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The ECalClient for the view
        pub const client = struct {
            pub const name = "client";

            pub const Type = ?*ecal.Client;
        };

        /// The GDBusConnection used to create the D-Bus proxy
        pub const connection = struct {
            pub const name = "connection";

            pub const Type = ?*gio.DBusConnection;
        };

        /// The object path used to create the D-Bus proxy
        pub const object_path = struct {
            pub const name = "object-path";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const complete = struct {
            pub const name = "complete";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *glib.Error, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ClientView, p_instance))),
                    gobject.signalLookup("complete", ClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const objects_added = struct {
            pub const name = "objects-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_objects: **glib.SList, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ClientView, p_instance))),
                    gobject.signalLookup("objects-added", ClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const objects_modified = struct {
            pub const name = "objects-modified";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_objects: **glib.SList, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ClientView, p_instance))),
                    gobject.signalLookup("objects-modified", ClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const objects_removed = struct {
            pub const name = "objects-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_uids: **glib.SList, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ClientView, p_instance))),
                    gobject.signalLookup("objects-removed", ClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const progress = struct {
            pub const name = "progress";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: c_uint, p_p0: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ClientView, p_instance))),
                    gobject.signalLookup("progress", ClientView.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns the `gio.DBusConnection` used to create the D-Bus proxy.
    extern fn e_cal_client_view_get_connection(p_client_view: *ClientView) *gio.DBusConnection;
    pub const getConnection = e_cal_client_view_get_connection;

    /// Returns the object path used to create the D-Bus proxy.
    extern fn e_cal_client_view_get_object_path(p_client_view: *ClientView) [*:0]const u8;
    pub const getObjectPath = e_cal_client_view_get_object_path;

    /// Retunrs: Whether view is running. Not running views are ignoring
    /// all events sent from the server.
    extern fn e_cal_client_view_is_running(p_client_view: *ClientView) c_int;
    pub const isRunning = e_cal_client_view_is_running;

    /// Returns the `ecal.ClientView.properties.client` associated with `client_view`.
    ///
    /// The returned `ecal.Client` is referenced for thread-safety.  Unreference
    /// the `ecal.Client` with `gobject.Object.unref` when finished with it.
    extern fn e_cal_client_view_ref_client(p_client_view: *ClientView) *ecal.Client;
    pub const refClient = e_cal_client_view_ref_client;

    /// Client can instruct server to which fields it is interested in only, thus
    /// the server can return less data over the wire. The server can still return
    /// complete objects, this is just a hint to it that the listed fields will
    /// be used only. The UID/RID fields are returned always. Initial views has no
    /// fields of interest and using `NULL` for `fields_of_interest` will unset any
    /// previous changes.
    ///
    /// Some backends can use summary information of its cache to create artifical
    /// objects, which will omit stored object parsing. If this cannot be done then
    /// it will simply return object as is stored in the cache.
    extern fn e_cal_client_view_set_fields_of_interest(p_client_view: *ClientView, p_fields_of_interest: ?*const glib.SList, p_error: ?*?*glib.Error) void;
    pub const setFieldsOfInterest = e_cal_client_view_set_fields_of_interest;

    /// Sets the `flags` which control the behaviour of `client_view`.
    extern fn e_cal_client_view_set_flags(p_client_view: *ClientView, p_flags: ecal.ClientViewFlags, p_error: ?*?*glib.Error) void;
    pub const setFlags = e_cal_client_view_set_flags;

    /// Tells `client_view` to start processing events.
    extern fn e_cal_client_view_start(p_client_view: *ClientView, p_error: ?*?*glib.Error) void;
    pub const start = e_cal_client_view_start;

    /// Tells `client_view` to stop processing events.
    extern fn e_cal_client_view_stop(p_client_view: *ClientView, p_error: ?*?*glib.Error) void;
    pub const stop = e_cal_client_view_stop;

    extern fn e_cal_client_view_get_type() usize;
    pub const getGObjectType = e_cal_client_view_get_type;

    extern fn g_object_ref(p_self: *ecal.ClientView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ecal.ClientView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ClientView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Component = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ecal.ComponentClass;
    f_parent: gobject.Object,
    f_priv: ?*ecal.ComponentPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new empty calendar component object.  Once created, you should set it from an
    /// existing `icalcomponent` structure by using `ecal.Component.setIcalcomponent` or with a
    /// new empty component type by using `ecal.Component.setNewVtype`.
    extern fn e_cal_component_new() *ecal.Component;
    pub const new = e_cal_component_new;

    /// Creates a new `ecal.Component` which will has set `icalcomp` as
    /// an inner `ICalComponent`. The newly created `ecal.Component` takes
    /// ownership of the `icalcomp`, and if the call
    /// to `ecal.Component.setIcalcomponent` fails, then `icalcomp`
    /// is freed.
    extern fn e_cal_component_new_from_icalcomponent(p_icalcomp: *icalglib.Component) ?*ecal.Component;
    pub const newFromIcalcomponent = e_cal_component_new_from_icalcomponent;

    /// Creates a new calendar component object from the given iCalendar string.
    extern fn e_cal_component_new_from_string(p_calobj: [*:0]const u8) ?*ecal.Component;
    pub const newFromString = e_cal_component_new_from_string;

    /// Creates a new `ecal.Component` of type `vtype`.
    extern fn e_cal_component_new_vtype(p_vtype: ecal.ComponentVType) *ecal.Component;
    pub const newVtype = e_cal_component_new_vtype;

    /// Aborts the sequence change needed in the given calendar component,
    /// which means it will not require a sequence commit (via
    /// `ecal.Component.commitSequence`) even if the changes done require a
    /// sequence increment.
    extern fn e_cal_component_abort_sequence(p_comp: *Component) void;
    pub const abortSequence = e_cal_component_abort_sequence;

    /// Adds an alarm subcomponent to a calendar component.  You should have created
    /// the `alarm` by using `ecal.ComponentAlarm.new`; it is invalid to use an
    /// `ecal.ComponentAlarm` structure that came from `ecal.Component.getAlarm`.  After
    /// adding the alarm, the `alarm` structure is no longer valid because the
    /// internal structures may change and you should get rid of it by using
    /// `ecal.ComponentAlarm.free`.
    extern fn e_cal_component_add_alarm(p_comp: *Component, p_alarm: *ecal.ComponentAlarm) void;
    pub const addAlarm = e_cal_component_add_alarm;

    /// Creates a new calendar component object by copying the information from
    /// another one.
    extern fn e_cal_component_clone(p_comp: *Component) *ecal.Component;
    pub const clone = e_cal_component_clone;

    /// Increments the sequence number property in a calendar component object if it
    /// needs it.  This needs to be done when any of a number of properties listed in
    /// RFC 2445 change values, such as the start and end dates of a component.
    ///
    /// This function must be called before calling `ecal.Component.getAsString` to
    /// ensure that the component is fully consistent.
    extern fn e_cal_component_commit_sequence(p_comp: *Component) void;
    pub const commitSequence = e_cal_component_commit_sequence;

    /// Returns a comment for the given `locale`. When `locale` is `NULL`,
    /// the current locale is assumed. If no such comment for the locale
    /// exists either a comment with no language parameter or the first
    /// found is returned.
    ///
    /// Free the returned non-NULL `ecal.ComponentText` with `ecal.ComponentText.free`,
    /// when no longer needed.
    extern fn e_cal_component_dup_comment_for_locale(p_comp: *Component, p_locale: ?[*:0]const u8) ?*ecal.ComponentText;
    pub const dupCommentForLocale = e_cal_component_dup_comment_for_locale;

    /// Returns a description for the given `locale`. When `locale` is `NULL`,
    /// the current locale is assumed. If no such description for the locale
    /// exists either a description with no language parameter or the first
    /// found is returned.
    ///
    /// Free the returned non-NULL `ecal.ComponentText` with `ecal.ComponentText.free`,
    /// when no longer needed.
    extern fn e_cal_component_dup_description_for_locale(p_comp: *Component, p_locale: ?[*:0]const u8) ?*ecal.ComponentText;
    pub const dupDescriptionForLocale = e_cal_component_dup_description_for_locale;

    /// Queries the summary of a calendar component object. There can be one summary
    /// property per locale. Free the returned `glib.SList` with
    /// g_slist_free_full (slist, e_cal_component_text_free);, when no longer needed.
    extern fn e_cal_component_dup_summaries(p_comp: *Component) ?*glib.SList;
    pub const dupSummaries = e_cal_component_dup_summaries;

    /// Returns a summary for the given `locale`. When `locale` is `NULL`,
    /// the current locale is assumed. If no such summary for the locale
    /// exists either a summary with no language parameter or the first
    /// found is returned.
    ///
    /// Free the returned non-NULL `ecal.ComponentText` with `ecal.ComponentText.free`,
    /// when no longer needed.
    extern fn e_cal_component_dup_summary_for_locale(p_comp: *Component, p_locale: ?[*:0]const u8) ?*ecal.ComponentText;
    pub const dupSummaryForLocale = e_cal_component_dup_summary_for_locale;

    /// Queries a particular alarm subcomponent of a calendar component.
    /// Free the returned pointer with `ecal.ComponentAlarm.free`,
    /// when no longer needed.
    extern fn e_cal_component_get_alarm(p_comp: *Component, p_auid: [*:0]const u8) ?*ecal.ComponentAlarm;
    pub const getAlarm = e_cal_component_get_alarm;

    /// Builds a list of the unique identifiers of the alarm subcomponents inside a
    /// calendar component. Free the returned `glib.SList` with
    /// g_slist_free_full (slist, g_free);, when no longer needed.
    extern fn e_cal_component_get_alarm_uids(p_comp: *Component) ?*glib.SList;
    pub const getAlarmUids = e_cal_component_get_alarm_uids;

    /// Queries all alarm subcomponents of a calendar component.
    /// Free the returned `glib.SList` with g_slist_free_full (slist, e_cal_component_alarm_free);,
    /// when no longer needed.
    extern fn e_cal_component_get_all_alarms(p_comp: *Component) ?*glib.SList;
    pub const getAllAlarms = e_cal_component_get_all_alarms;

    /// Gets the iCalendar string representation of a calendar component.  You should
    /// call `ecal.Component.commitSequence` before this function to ensure that the
    /// component's sequence number is consistent with the state of the object.
    extern fn e_cal_component_get_as_string(p_comp: *Component) [*:0]u8;
    pub const getAsString = e_cal_component_get_as_string;

    /// Queries the attachment properties as `ICalAttach` objects of the calendar
    /// component object. Changes on these objects are directly affecting the component.
    /// Free the returned `glib.SList` with g_slist_free_full (slist, g_object_unref);,
    /// when no longer needed.
    extern fn e_cal_component_get_attachments(p_comp: *Component) ?*glib.SList;
    pub const getAttachments = e_cal_component_get_attachments;

    /// Queries the attendee properties of the calendar component object.
    /// Free the returned `glib.SList` with g_slist_free_full (slist, e_cal_component_attendee_free);,
    /// when no longer needed.
    extern fn e_cal_component_get_attendees(p_comp: *Component) ?*glib.SList;
    pub const getAttendees = e_cal_component_get_attendees;

    /// Queries the categories of the given calendar component. The categories
    /// are returned in the `categories` argument, which, on success, will contain
    /// a comma-separated list of all categories set in the component.
    /// Free the returned string with `glib.free`, when no longer needed.
    extern fn e_cal_component_get_categories(p_comp: *Component) ?[*:0]u8;
    pub const getCategories = e_cal_component_get_categories;

    /// Queries the list of categories of a calendar component object. Each element
    /// in the returned categ_list is a string with the corresponding category.
    /// Free the returned `glib.SList` with g_slist_free_full (categories, g_free); , when
    /// no longer needed.
    extern fn e_cal_component_get_categories_list(p_comp: *Component) ?*glib.SList;
    pub const getCategoriesList = e_cal_component_get_categories_list;

    /// Queries the classification of a calendar component object.  If the
    /// classification property is not set on this component, this function returns
    /// `E_CAL_COMPONENT_CLASS_NONE`.
    ///
    /// Retuurns: a classification of the `comp`, as an `ecal.ComponentClassification`
    extern fn e_cal_component_get_classification(p_comp: *Component) ecal.ComponentClassification;
    pub const getClassification = e_cal_component_get_classification;

    /// Queries the comments of a calendar component object.  The comment property can
    /// appear several times inside a calendar component, and so a list of
    /// `ecal.ComponentText` is returned. Free the returned `glib.SList` with
    /// g_slist_free_full (slist, e_cal_component_text_free);, when no longer needed.
    extern fn e_cal_component_get_comments(p_comp: *Component) ?*glib.SList;
    pub const getComments = e_cal_component_get_comments;

    /// Queries the date at which a calendar compoment object was completed.
    /// Free the returned non-NULL pointer with `gobject.Object.unref`, when
    /// no longer needed.
    extern fn e_cal_component_get_completed(p_comp: *Component) ?*icalglib.Time;
    pub const getCompleted = e_cal_component_get_completed;

    /// Queries the contact of a calendar component object.  The contact property can
    /// appear several times inside a calendar component, and so a list of
    /// `ecal.ComponentText` is returned. Free the returned `glib.SList` with
    /// g_slist_free_full (slist, e_cal_component_text_free);, when no longer needed.
    extern fn e_cal_component_get_contacts(p_comp: *Component) *glib.SList;
    pub const getContacts = e_cal_component_get_contacts;

    /// Queries the date in which a calendar component object was created in the
    /// calendar store. Free the returned non-NULL pointer with `gobject.Object.unref`, when
    /// no longer needed.
    extern fn e_cal_component_get_created(p_comp: *Component) ?*icalglib.Time;
    pub const getCreated = e_cal_component_get_created;

    /// Queries the description of a calendar component object.  Journal components
    /// may have more than one description, and as such this function returns a list
    /// of `ecal.ComponentText` structures.  All other types of components can have at
    /// most one description for a single language. Free the returned `glib.SList` with
    /// g_slist_free_full (slist, e_cal_component_text_free);, when no longer needed.
    extern fn e_cal_component_get_descriptions(p_comp: *Component) ?*glib.SList;
    pub const getDescriptions = e_cal_component_get_descriptions;

    /// Queries the date/time end of a calendar component object. In case there's no DTEND,
    /// but only DTSTART and DURATION, then the end is computed from the later two.
    /// Free the returned `ecal.ComponentDateTime` with `ecal.ComponentDateTime.free`,
    /// when no longer needed.
    extern fn e_cal_component_get_dtend(p_comp: *Component) ?*ecal.ComponentDateTime;
    pub const getDtend = e_cal_component_get_dtend;

    /// Queries the date/timestamp property of a calendar component object, which is
    /// the last time at which the object was modified by a calendar user agent.
    ///
    /// Free a non-NULL returned object with `gobject.Object.unref`,
    /// when no longer needed.
    extern fn e_cal_component_get_dtstamp(p_comp: *Component) ?*icalglib.Time;
    pub const getDtstamp = e_cal_component_get_dtstamp;

    /// Queries the date/time start of a calendar component object.
    /// Free the returned `ecal.ComponentDateTime` with `ecal.ComponentDateTime.free`,
    /// when no longer needed.
    extern fn e_cal_component_get_dtstart(p_comp: *Component) ?*ecal.ComponentDateTime;
    pub const getDtstart = e_cal_component_get_dtstart;

    /// Queries the due date/time of a calendar component object. In case there's no DUE,
    /// but only DTSTART and DURATION, then the due is computed from the later two.
    /// Free the returned `ecal.ComponentDateTime` with `ecal.ComponentDateTime.free`,
    /// when no longer needed.
    extern fn e_cal_component_get_due(p_comp: *Component) ?*ecal.ComponentDateTime;
    pub const getDue = e_cal_component_get_due;

    /// Queries the list of exception date properties in a calendar component object.
    /// Free the returned `glib.SList` with g_slist_free_full (exdates, e_cal_component_datetime_free);,
    /// when no longer needed.
    extern fn e_cal_component_get_exdates(p_comp: *Component) ?*glib.SList;
    pub const getExdates = e_cal_component_get_exdates;

    /// Queries the list of exception rule properties of a calendar component object.
    /// Free the list with g_slist_free_full (slist, g_object_unref);, when
    /// no longer needed.
    extern fn e_cal_component_get_exrule_properties(p_comp: *Component) ?*glib.SList;
    pub const getExruleProperties = e_cal_component_get_exrule_properties;

    /// Queries the list of exception rule properties of a calendar component
    /// object. Free the returned list with g_slist_free_full (slist, g_object_unref);,
    /// when no longer needed.
    extern fn e_cal_component_get_exrules(p_comp: *Component) ?*glib.SList;
    pub const getExrules = e_cal_component_get_exrules;

    /// Gets the geographic position property of a calendar component object.
    /// Free the returned non-NULL object with `gobject.Object.unref`, when
    /// no longer needed.
    extern fn e_cal_component_get_geo(p_comp: *Component) ?*icalglib.Geo;
    pub const getGeo = e_cal_component_get_geo;

    /// Queries the `icalcomponent` structure that a calendar component object is
    /// wrapping.
    extern fn e_cal_component_get_icalcomponent(p_comp: *Component) ?*icalglib.Component;
    pub const getIcalcomponent = e_cal_component_get_icalcomponent;

    /// Get the ID of the component as an `ecal.ComponentId`. The return value should
    /// be freed with `ecal.ComponentId.free`, when no longer needed.
    extern fn e_cal_component_get_id(p_comp: *Component) *ecal.ComponentId;
    pub const getId = e_cal_component_get_id;

    /// Queries the time at which a calendar component object was last modified in
    /// the calendar store. Free the returned non-NULL pointer with `gobject.Object.unref`,
    /// when no longer needed.
    extern fn e_cal_component_get_last_modified(p_comp: *Component) ?*icalglib.Time;
    pub const getLastModified = e_cal_component_get_last_modified;

    /// Queries the location property of a calendar component object.
    extern fn e_cal_component_get_location(p_comp: *Component) ?[*:0]u8;
    pub const getLocation = e_cal_component_get_location;

    /// Queries the organizer property of a calendar component object.
    /// Free the returned structure with `ecal.ComponentOrganizer.free`,
    /// when no longer needed.
    extern fn e_cal_component_get_organizer(p_comp: *Component) ?*ecal.ComponentOrganizer;
    pub const getOrganizer = e_cal_component_get_organizer;

    /// Queries the percent-complete property of a calendar component object.
    extern fn e_cal_component_get_percent_complete(p_comp: *Component) c_int;
    pub const getPercentComplete = e_cal_component_get_percent_complete;

    /// Queries the priority property of a calendar component object.
    extern fn e_cal_component_get_priority(p_comp: *Component) c_int;
    pub const getPriority = e_cal_component_get_priority;

    /// Queries the list of recurrence date properties in a calendar component
    /// object. Free the returned `glib.SList` with g_slist_free_full (slist, e_cal_component_period_free);,
    /// when no longer needed.
    extern fn e_cal_component_get_rdates(p_comp: *Component) ?*glib.SList;
    pub const getRdates = e_cal_component_get_rdates;

    /// Queries the recurrence id property of a calendar component object.
    /// Free the returned `ecal.ComponentRange` with `ecal.ComponentRange.free`,
    /// whe no longer needed.
    extern fn e_cal_component_get_recurid(p_comp: *Component) ?*ecal.ComponentRange;
    pub const getRecurid = e_cal_component_get_recurid;

    /// Gets the recurrence ID property as a string.
    extern fn e_cal_component_get_recurid_as_string(p_comp: *Component) [*:0]u8;
    pub const getRecuridAsString = e_cal_component_get_recurid_as_string;

    /// Queries a list of recurrence rule properties of a calendar component object.
    /// Free the list with g_slist_free_full (slist, g_object_unref);, when
    /// no longer needed.
    extern fn e_cal_component_get_rrule_properties(p_comp: *Component) ?*glib.SList;
    pub const getRruleProperties = e_cal_component_get_rrule_properties;

    /// Queries the list of recurrence rule properties of a calendar component
    /// object. Free the returned list with g_slist_free_full (slist, g_object_unref);,
    /// when no longer needed.
    extern fn e_cal_component_get_rrules(p_comp: *Component) ?*glib.SList;
    pub const getRrules = e_cal_component_get_rrules;

    /// Queries the sequence number of a calendar component object.
    extern fn e_cal_component_get_sequence(p_comp: *Component) c_int;
    pub const getSequence = e_cal_component_get_sequence;

    /// Queries the status property of a calendar component object.
    extern fn e_cal_component_get_status(p_comp: *Component) icalglib.PropertyStatus;
    pub const getStatus = e_cal_component_get_status;

    /// Queries the summary of a calendar component object. It returns the first
    /// found summary property of the component. To get a summary suitable for a specific
    /// locale use `ecal.Component.dupSummaryForLocale`.
    ///
    /// Free the returned pointer `withe_cal_component_text_free`,
    /// when no longer needed.
    extern fn e_cal_component_get_summary(p_comp: *Component) ?*ecal.ComponentText;
    pub const getSummary = e_cal_component_get_summary;

    /// Queries the time transparency of a calendar component object.
    extern fn e_cal_component_get_transparency(p_comp: *Component) ecal.ComponentTransparency;
    pub const getTransparency = e_cal_component_get_transparency;

    /// Queries the unique identifier of a calendar component object.
    extern fn e_cal_component_get_uid(p_comp: *Component) [*:0]const u8;
    pub const getUid = e_cal_component_get_uid;

    /// Queries the uniform resource locator property of a calendar component object.
    /// Free the returned URL with `glib.free`, when no longer needed.
    extern fn e_cal_component_get_url(p_comp: *Component) ?[*:0]u8;
    pub const getUrl = e_cal_component_get_url;

    /// Queries the type of a calendar component object.
    extern fn e_cal_component_get_vtype(p_comp: *Component) ecal.ComponentVType;
    pub const getVtype = e_cal_component_get_vtype;

    /// Checks whether the component has any alarms.
    extern fn e_cal_component_has_alarms(p_comp: *Component) c_int;
    pub const hasAlarms = e_cal_component_has_alarms;

    /// Queries the component to see if it has attachments.
    extern fn e_cal_component_has_attachments(p_comp: *Component) c_int;
    pub const hasAttachments = e_cal_component_has_attachments;

    /// Queries a calendar component object for the existence of attendees.
    extern fn e_cal_component_has_attendees(p_comp: *Component) c_int;
    pub const hasAttendees = e_cal_component_has_attendees;

    /// Queries whether a calendar component object has any exception dates
    /// or exception rules.
    extern fn e_cal_component_has_exceptions(p_comp: *Component) c_int;
    pub const hasExceptions = e_cal_component_has_exceptions;

    /// Queries whether a calendar component object has any exception dates defined
    /// for it.
    extern fn e_cal_component_has_exdates(p_comp: *Component) c_int;
    pub const hasExdates = e_cal_component_has_exdates;

    /// Queries whether a calendar component object has any exception rules defined
    /// for it.
    extern fn e_cal_component_has_exrules(p_comp: *Component) c_int;
    pub const hasExrules = e_cal_component_has_exrules;

    /// Check whether a calendar component object has an organizer or not.
    extern fn e_cal_component_has_organizer(p_comp: *Component) c_int;
    pub const hasOrganizer = e_cal_component_has_organizer;

    /// Queries whether a calendar component object has any recurrence dates defined
    /// for it.
    extern fn e_cal_component_has_rdates(p_comp: *Component) c_int;
    pub const hasRdates = e_cal_component_has_rdates;

    /// Queries whether a calendar component object has any recurrence dates or
    /// recurrence rules.
    extern fn e_cal_component_has_recurrences(p_comp: *Component) c_int;
    pub const hasRecurrences = e_cal_component_has_recurrences;

    /// Queries whether a calendar component object has any recurrence rules defined
    /// for it.
    extern fn e_cal_component_has_rrules(p_comp: *Component) c_int;
    pub const hasRrules = e_cal_component_has_rrules;

    /// Checks whether the given calendar component object has simple recurrence
    /// rules or more complicated ones.
    extern fn e_cal_component_has_simple_recurrence(p_comp: *Component) c_int;
    pub const hasSimpleRecurrence = e_cal_component_has_simple_recurrence;

    /// Checks whether a calendar component object is an instance of a recurring
    /// event.
    extern fn e_cal_component_is_instance(p_comp: *Component) c_int;
    pub const isInstance = e_cal_component_is_instance;

    /// Removes an alarm subcomponent from a calendar component.  If the alarm that
    /// corresponds to the specified `auid` had been fetched with
    /// `ecal.Component.getAlarm`, then those alarm structures will be invalid; you
    /// should get rid of them with `ecal.ComponentAlarm.free` before using this
    /// function.
    extern fn e_cal_component_remove_alarm(p_comp: *Component, p_auid: [*:0]const u8) void;
    pub const removeAlarm = e_cal_component_remove_alarm;

    /// Remove all alarms from the calendar component
    extern fn e_cal_component_remove_all_alarms(p_comp: *Component) void;
    pub const removeAllAlarms = e_cal_component_remove_all_alarms;

    /// Sets the attachments of the calendar component object.
    extern fn e_cal_component_set_attachments(p_comp: *Component, p_attachments: ?*const glib.SList) void;
    pub const setAttachments = e_cal_component_set_attachments;

    /// Sets the attendees of a calendar component object
    extern fn e_cal_component_set_attendees(p_comp: *Component, p_attendee_list: ?*const glib.SList) void;
    pub const setAttendees = e_cal_component_set_attendees;

    /// Sets the list of categories for a calendar component.
    extern fn e_cal_component_set_categories(p_comp: *Component, p_categories: [*:0]const u8) void;
    pub const setCategories = e_cal_component_set_categories;

    /// Sets the list of categories of a calendar component object.
    extern fn e_cal_component_set_categories_list(p_comp: *Component, p_categ_list: *const glib.SList) void;
    pub const setCategoriesList = e_cal_component_set_categories_list;

    /// Sets the classification property of a calendar component object.  To unset
    /// the property, specify E_CAL_COMPONENT_CLASS_NONE for `classif`.
    extern fn e_cal_component_set_classification(p_comp: *Component, p_classif: ecal.ComponentClassification) void;
    pub const setClassification = e_cal_component_set_classification;

    /// Sets the comments of a calendar component object.  The comment property can
    /// appear several times inside a calendar component, and so a list of
    /// `ecal.ComponentText` structures is used.
    extern fn e_cal_component_set_comments(p_comp: *Component, p_text_list: *const glib.SList) void;
    pub const setComments = e_cal_component_set_comments;

    /// Sets the date at which a calendar component object was completed.
    extern fn e_cal_component_set_completed(p_comp: *Component, p_tt: ?*const icalglib.Time) void;
    pub const setCompleted = e_cal_component_set_completed;

    /// Sets the contact of a calendar component object.  The contact property can
    /// appear several times inside a calendar component, and so a list of
    /// `ecal.ComponentText` structures is used.
    extern fn e_cal_component_set_contacts(p_comp: *Component, p_text_list: *const glib.SList) void;
    pub const setContacts = e_cal_component_set_contacts;

    /// Sets the date in which a calendar component object is created in the calendar
    /// store.  This should only be used inside a calendar store application, i.e.
    /// not by calendar user agents.
    extern fn e_cal_component_set_created(p_comp: *Component, p_tt: ?*const icalglib.Time) void;
    pub const setCreated = e_cal_component_set_created;

    /// Sets the description of a calendar component object.  Journal components may
    /// have more than one description, and as such this function takes in a list of
    /// `ecal.ComponentText` structures.  All other types of components can have
    /// at most one description.
    extern fn e_cal_component_set_descriptions(p_comp: *Component, p_text_list: *const glib.SList) void;
    pub const setDescriptions = e_cal_component_set_descriptions;

    /// Sets the date/time end property of a calendar component object.
    extern fn e_cal_component_set_dtend(p_comp: *Component, p_dt: ?*const ecal.ComponentDateTime) void;
    pub const setDtend = e_cal_component_set_dtend;

    /// Sets the date/timestamp of a calendar component object.  This should be
    /// called whenever a calendar user agent makes a change to a component's
    /// properties.
    extern fn e_cal_component_set_dtstamp(p_comp: *Component, p_tt: *const icalglib.Time) void;
    pub const setDtstamp = e_cal_component_set_dtstamp;

    /// Sets the date/time start property of a calendar component object.
    extern fn e_cal_component_set_dtstart(p_comp: *Component, p_dt: ?*const ecal.ComponentDateTime) void;
    pub const setDtstart = e_cal_component_set_dtstart;

    /// Sets the due date/time property of a calendar component object.
    extern fn e_cal_component_set_due(p_comp: *Component, p_dt: ?*const ecal.ComponentDateTime) void;
    pub const setDue = e_cal_component_set_due;

    /// Sets the list of exception dates in a calendar component object.
    extern fn e_cal_component_set_exdates(p_comp: *Component, p_exdate_list: ?*const glib.SList) void;
    pub const setExdates = e_cal_component_set_exdates;

    /// Sets the list of exception rules in a calendar component object.
    extern fn e_cal_component_set_exrules(p_comp: *Component, p_recur_list: ?*const glib.SList) void;
    pub const setExrules = e_cal_component_set_exrules;

    /// Sets the geographic position property on a calendar component object.
    extern fn e_cal_component_set_geo(p_comp: *Component, p_geo: ?*const icalglib.Geo) void;
    pub const setGeo = e_cal_component_set_geo;

    /// Sets the contents of a calendar component object from an `ICalComponent`.
    /// If the `comp` already had an `ICalComponent` set into it, it will
    /// be freed automatically.
    ///
    /// Supported component types are VEVENT, VTODO, VJOURNAL, VFREEBUSY, and VTIMEZONE.
    extern fn e_cal_component_set_icalcomponent(p_comp: *Component, p_icalcomp: ?*icalglib.Component) c_int;
    pub const setIcalcomponent = e_cal_component_set_icalcomponent;

    /// Sets the time at which a calendar component object was last stored in the
    /// calendar store.  This should not be called by plain calendar user agents.
    extern fn e_cal_component_set_last_modified(p_comp: *Component, p_tt: ?*const icalglib.Time) void;
    pub const setLastModified = e_cal_component_set_last_modified;

    /// Sets the location property of a calendar component object.
    extern fn e_cal_component_set_location(p_comp: *Component, p_location: ?[*:0]const u8) void;
    pub const setLocation = e_cal_component_set_location;

    /// Clears any existing component data from a calendar component object and
    /// creates a new `ICalComponent` of the specified type for it.  The only property
    /// that will be set in the new component will be its unique identifier.
    extern fn e_cal_component_set_new_vtype(p_comp: *Component, p_type: ecal.ComponentVType) void;
    pub const setNewVtype = e_cal_component_set_new_vtype;

    /// Sets the organizer of a calendar component object
    extern fn e_cal_component_set_organizer(p_comp: *Component, p_organizer: ?*const ecal.ComponentOrganizer) void;
    pub const setOrganizer = e_cal_component_set_organizer;

    /// Sets percent complete. The `percent` can be between 0 and 100, inclusive.
    /// A special value -1 can be used to remove the percent complete property.
    extern fn e_cal_component_set_percent_complete(p_comp: *Component, p_percent: c_int) void;
    pub const setPercentComplete = e_cal_component_set_percent_complete;

    /// Sets the priority property of a calendar component object.
    /// The `priority` can be between 0 and 9, inclusive.
    /// A special value -1 can be used to remove the priority property.
    extern fn e_cal_component_set_priority(p_comp: *Component, p_priority: c_int) void;
    pub const setPriority = e_cal_component_set_priority;

    /// Sets the list of recurrence dates in a calendar component object.
    extern fn e_cal_component_set_rdates(p_comp: *Component, p_rdate_list: ?*const glib.SList) void;
    pub const setRdates = e_cal_component_set_rdates;

    /// Sets the recurrence id property of a calendar component object.
    extern fn e_cal_component_set_recurid(p_comp: *Component, p_recur_id: ?*const ecal.ComponentRange) void;
    pub const setRecurid = e_cal_component_set_recurid;

    /// Sets the list of recurrence rules in a calendar component object.
    extern fn e_cal_component_set_rrules(p_comp: *Component, p_recur_list: ?*const glib.SList) void;
    pub const setRrules = e_cal_component_set_rrules;

    /// Sets the sequence number of a calendar component object.
    /// A special value -1 can be used to remove the sequence number property.
    ///
    /// Normally this function should not be called, since the sequence number
    /// is incremented automatically at the proper times.
    extern fn e_cal_component_set_sequence(p_comp: *Component, p_sequence: c_int) void;
    pub const setSequence = e_cal_component_set_sequence;

    /// Sets the status property of a calendar component object.
    extern fn e_cal_component_set_status(p_comp: *Component, p_status: icalglib.PropertyStatus) void;
    pub const setStatus = e_cal_component_set_status;

    /// Sets the summary of a calendar component object. The summaries can have each
    /// different language, otherwise it's not allowed to have more than one summary property.
    ///
    /// This does not update any alarm subcomponent description.
    extern fn e_cal_component_set_summaries(p_comp: *Component, p_text_list: *const glib.SList) void;
    pub const setSummaries = e_cal_component_set_summaries;

    /// Sets the summary of a calendar component object.
    ///
    /// This also updates any alarm subcomponent descriptions, if needed.
    extern fn e_cal_component_set_summary(p_comp: *Component, p_summary: *const ecal.ComponentText) void;
    pub const setSummary = e_cal_component_set_summary;

    /// Sets the time transparency of a calendar component object.
    /// Use `E_CAL_COMPONENT_TRANSP_NONE` to unset the property.
    extern fn e_cal_component_set_transparency(p_comp: *Component, p_transp: ecal.ComponentTransparency) void;
    pub const setTransparency = e_cal_component_set_transparency;

    /// Sets the unique identifier string of a calendar component object.
    extern fn e_cal_component_set_uid(p_comp: *Component, p_uid: [*:0]const u8) void;
    pub const setUid = e_cal_component_set_uid;

    /// Sets the uniform resource locator property of a calendar component object.
    /// A `NULL` or an empty string removes the property.
    extern fn e_cal_component_set_url(p_comp: *Component, p_url: ?[*:0]const u8) void;
    pub const setUrl = e_cal_component_set_url;

    /// Strips all error messages from the calendar component. Those error messages are
    /// added to the iCalendar string representation whenever an invalid is used for
    /// one of its fields.
    extern fn e_cal_component_strip_errors(p_comp: *Component) void;
    pub const stripErrors = e_cal_component_strip_errors;

    extern fn e_cal_component_get_type() usize;
    pub const getGObjectType = e_cal_component_get_type;

    extern fn g_object_ref(p_self: *ecal.Component) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ecal.Component) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Component, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const ReminderWatcher = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ecal.ReminderWatcherClass;
    f_parent: gobject.Object,
    f_priv: ?*ecal.ReminderWatcherPrivate,

    pub const virtual_methods = struct {
        pub const cal_client_connect = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_source_type: ecal.ClientSourceType, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(ReminderWatcher.Class, p_class).f_cal_client_connect.?(gobject.ext.as(ReminderWatcher, p_watcher), p_source, p_source_type, p_wait_for_connected_seconds, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_source_type: ecal.ClientSourceType, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(ReminderWatcher.Class, p_class).f_cal_client_connect = @ptrCast(p_implementation);
            }
        };

        pub const cal_client_connect_finish = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*edataserver.Client {
                return gobject.ext.as(ReminderWatcher.Class, p_class).f_cal_client_connect_finish.?(gobject.ext.as(ReminderWatcher, p_watcher), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) ?*edataserver.Client) void {
                gobject.ext.as(ReminderWatcher.Class, p_class).f_cal_client_connect_finish = @ptrCast(p_implementation);
            }
        };

        pub const cal_client_connect_sync = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_source_type: ecal.ClientSourceType, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edataserver.Client {
                return gobject.ext.as(ReminderWatcher.Class, p_class).f_cal_client_connect_sync.?(gobject.ext.as(ReminderWatcher, p_watcher), p_source, p_source_type, p_wait_for_connected_seconds, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_source_type: ecal.ClientSourceType, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*edataserver.Client) void {
                gobject.ext.as(ReminderWatcher.Class, p_class).f_cal_client_connect_sync = @ptrCast(p_implementation);
            }
        };

        pub const changed = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ReminderWatcher.Class, p_class).f_changed.?(gobject.ext.as(ReminderWatcher, p_watcher));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ReminderWatcher.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };

        pub const format_time = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_rd: *const ecal.ReminderData, p_itt: *icalglib.Time, p_inout_buffer: *[*:0]u8, p_buffer_size: c_int) void {
                return gobject.ext.as(ReminderWatcher.Class, p_class).f_format_time.?(gobject.ext.as(ReminderWatcher, p_watcher), p_rd, p_itt, p_inout_buffer, p_buffer_size);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_rd: *const ecal.ReminderData, p_itt: *icalglib.Time, p_inout_buffer: *[*:0]u8, p_buffer_size: c_int) callconv(.c) void) void {
                gobject.ext.as(ReminderWatcher.Class, p_class).f_format_time = @ptrCast(p_implementation);
            }
        };

        pub const schedule_timer = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_at_time: i64) void {
                return gobject.ext.as(ReminderWatcher.Class, p_class).f_schedule_timer.?(gobject.ext.as(ReminderWatcher, p_watcher), p_at_time);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_at_time: i64) callconv(.c) void) void {
                gobject.ext.as(ReminderWatcher.Class, p_class).f_schedule_timer = @ptrCast(p_implementation);
            }
        };

        pub const triggered = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_reminders: *const glib.SList, p_snoozed: c_int) void {
                return gobject.ext.as(ReminderWatcher.Class, p_class).f_triggered.?(gobject.ext.as(ReminderWatcher, p_watcher), p_reminders, p_snoozed);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_reminders: *const glib.SList, p_snoozed: c_int) callconv(.c) void) void {
                gobject.ext.as(ReminderWatcher.Class, p_class).f_triggered = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// An `ICalTimezone` to be used as the default time zone.
        pub const default_zone = struct {
            pub const name = "default-zone";

            pub const Type = ?*icalglib.Timezone;
        };

        /// The `edataserver.SourceRegistry` which manages `edataserver.Source` instances.
        pub const registry = struct {
            pub const name = "registry";

            pub const Type = ?*edataserver.SourceRegistry;
        };

        /// Whether timers are enabled for the `ecal.ReminderWatcher`. See
        /// `ecal.ReminderWatcher.setTimersEnabled` for more information
        /// what it means.
        ///
        /// Default: `TRUE`
        pub const timers_enabled = struct {
            pub const name = "timers-enabled";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Signal is emitted when the list of past or snoozed reminders
        /// changes. It's called also when GSettings key for past reminders
        /// is notified as changed, because this list is not held in memory.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ReminderWatcher, p_instance))),
                    gobject.signalLookup("changed", ReminderWatcher.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Formats time `itt` to a string and writes it to `inout_buffer`, which can hold
        /// up to `buffer_size` bytes. The first character of `inout_buffer` is the nul-byte
        /// when nothing wrote to it yet.
        pub const format_time = struct {
            pub const name = "format-time";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_rd: *ecal.ReminderData, p_itt: *icalglib.Time, p_inout_buffer: ?*anyopaque, p_buffer_size: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ReminderWatcher, p_instance))),
                    gobject.signalLookup("format-time", ReminderWatcher.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Signal is emitted when any reminder is either overdue or triggered.
        pub const triggered = struct {
            pub const name = "triggered";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_reminders: **glib.SList, p_snoozed: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ReminderWatcher, p_instance))),
                    gobject.signalLookup("triggered", ReminderWatcher.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `ecal.ReminderWatcher`, which will use the `registry`. It adds
    /// its own reference to `registry`. Free the created `ecal.ReminderWatcher`
    /// with `gobject.Object.unref` when no longer needed.
    extern fn e_reminder_watcher_new(p_registry: *edataserver.SourceRegistry) *ecal.ReminderWatcher;
    pub const new = e_reminder_watcher_new;

    /// Returns a new string with a text description of the `rd`. The text format
    /// can be influenced with `flags`.
    ///
    /// Free the returned string with `glib.free`, when no longer needed.
    extern fn e_reminder_watcher_describe_data(p_watcher: *ReminderWatcher, p_rd: *const ecal.ReminderData, p_flags: u32) [*:0]u8;
    pub const describeData = e_reminder_watcher_describe_data;

    /// Asynchronously dismiss single reminder in the past or snoozed reminders.
    ///
    /// When the operation is finished, `callback` will be called. You can
    /// then call `ecal.ReminderWatcher.dismissFinish` to get the result of
    /// the operation.
    extern fn e_reminder_watcher_dismiss(p_watcher: *ReminderWatcher, p_rd: *const ecal.ReminderData, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const dismiss = e_reminder_watcher_dismiss;

    /// Asynchronously dismiss all past reminders.
    ///
    /// When the operation is finished, `callback` will be called. You can
    /// then call `ecal.ReminderWatcher.dismissAllFinish` to get the result
    /// of the operation.
    extern fn e_reminder_watcher_dismiss_all(p_watcher: *ReminderWatcher, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const dismissAll = e_reminder_watcher_dismiss_all;

    /// Finishes the operation started with `ecal.ReminderWatcher.dismissAll`.
    extern fn e_reminder_watcher_dismiss_all_finish(p_watcher: *ReminderWatcher, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const dismissAllFinish = e_reminder_watcher_dismiss_all_finish;

    /// Synchronously dismiss all past reminders. The operation stops after
    /// the first error is encountered, which can be before all the past
    /// reminders are dismissed.
    extern fn e_reminder_watcher_dismiss_all_sync(p_watcher: *ReminderWatcher, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dismissAllSync = e_reminder_watcher_dismiss_all_sync;

    /// Finishes the operation started with `ecal.ReminderWatcher.dismiss`.
    extern fn e_reminder_watcher_dismiss_finish(p_watcher: *ReminderWatcher, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const dismissFinish = e_reminder_watcher_dismiss_finish;

    /// Synchronously dismiss single reminder in the past or snoozed reminders.
    extern fn e_reminder_watcher_dismiss_sync(p_watcher: *ReminderWatcher, p_rd: *const ecal.ReminderData, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const dismissSync = e_reminder_watcher_dismiss_sync;

    extern fn e_reminder_watcher_dup_default_zone(p_watcher: *ReminderWatcher) *icalglib.Timezone;
    pub const dupDefaultZone = e_reminder_watcher_dup_default_zone;

    /// Gathers a `glib.SList` of all past reminders which had not been removed after
    /// EReminderWatcher::triggered signal. Such reminders are remembered
    /// across sessions, until they are dismissed by `ecal.ReminderWatcher.dismiss`
    /// or its synchronous variant. These reminders can be also snoozed
    /// with `ecal.ReminderWatcher.snooze`, which removes them from the past
    /// reminders into the list of snoozed reminders, see `ecal.ReminderWatcher.dupSnoozed`.
    ///
    /// Free the returned `glib.SList` with
    /// g_slist_free_full (reminders, e_reminder_data_free);
    /// when no longer needed.
    extern fn e_reminder_watcher_dup_past(p_watcher: *ReminderWatcher) ?*glib.SList;
    pub const dupPast = e_reminder_watcher_dup_past;

    /// Gathers a `glib.SList` of currently snoozed reminder with `ecal.ReminderWatcher.snooze`.
    /// The snoozed reminders are remembered across sessions and they are re-triggered
    /// when their snooze time elapses, which can move them back to the list of past reminders.
    ///
    /// Free the returned `glib.SList` with
    /// g_slist_free_full (reminders, e_reminder_data_free);
    /// when no longer needed.
    extern fn e_reminder_watcher_dup_snoozed(p_watcher: *ReminderWatcher) ?*glib.SList;
    pub const dupSnoozed = e_reminder_watcher_dup_snoozed;

    extern fn e_reminder_watcher_get_registry(p_watcher: *ReminderWatcher) *edataserver.SourceRegistry;
    pub const getRegistry = e_reminder_watcher_get_registry;

    extern fn e_reminder_watcher_get_timers_enabled(p_watcher: *ReminderWatcher) c_int;
    pub const getTimersEnabled = e_reminder_watcher_get_timers_enabled;

    extern fn e_reminder_watcher_ref_opened_client(p_watcher: *ReminderWatcher, p_source_uid: [*:0]const u8) ?*ecal.Client;
    pub const refOpenedClient = e_reminder_watcher_ref_opened_client;

    /// Sets the default zone for the `watcher`. This is used when calculating
    /// trigger times for floating component times. When the `zone` is `NULL`,
    /// then sets a UTC time zone.
    extern fn e_reminder_watcher_set_default_zone(p_watcher: *ReminderWatcher, p_zone: ?*const icalglib.Timezone) void;
    pub const setDefaultZone = e_reminder_watcher_set_default_zone;

    /// The `watcher` can be used both for scheduling the timers for the reminders
    /// and respond to them through the "triggered" signal, or only to listen for
    /// changes on the past reminders. The default is to have timers enabled, thus
    /// to response to scheduled reminders. Disabling the timers also means there
    /// will be less resources needed by the `watcher`.
    extern fn e_reminder_watcher_set_timers_enabled(p_watcher: *ReminderWatcher, p_enabled: c_int) void;
    pub const setTimersEnabled = e_reminder_watcher_set_timers_enabled;

    /// Snoozes `rd` until `until`, which is an absolute time when the `rd`
    /// should be retriggered. This moves the `rd` from the list of past
    /// reminders into the list of snoozed reminders and invokes the "changed"
    /// signal.
    ///
    /// The `until` can be a special value 0, to set the time as the event start,
    /// if it's in the future. The function does nothing when the event time
    /// is in the past.
    extern fn e_reminder_watcher_snooze(p_watcher: *ReminderWatcher, p_rd: *const ecal.ReminderData, p_until: i64) void;
    pub const snooze = e_reminder_watcher_snooze;

    /// Notifies the `watcher` that the timer previously scheduled
    /// with EReminderWatcherClass::schedule_timer elapsed. This can
    /// be used by the descendants which override the default implementation
    /// of EReminderWatcherClass::schedule_timer. There is always scheduled
    /// only one timer and once it's elapsed it should be also removed,
    /// the same when the EReminderWatcherClass::schedule_timer is called
    /// and the previously scheduled timer was not elapsed yet, the previous
    /// should be removed first, aka every call to EReminderWatcherClass::schedule_timer
    /// replaces any previously scheduled timer.
    extern fn e_reminder_watcher_timer_elapsed(p_watcher: *ReminderWatcher) void;
    pub const timerElapsed = e_reminder_watcher_timer_elapsed;

    extern fn e_reminder_watcher_get_type() usize;
    pub const getGObjectType = e_reminder_watcher_get_type;

    extern fn g_object_ref(p_self: *ecal.ReminderWatcher) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ecal.ReminderWatcher) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ReminderWatcher, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TimezoneCache = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = ecal.TimezoneCacheInterface;
    pub const virtual_methods = struct {
        pub const timezone_added = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_zone: *icalglib.Timezone) void {
                return gobject.ext.as(TimezoneCache.Iface, p_class).f_timezone_added.?(gobject.ext.as(TimezoneCache, p_cache), p_zone);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_zone: *icalglib.Timezone) callconv(.c) void) void {
                gobject.ext.as(TimezoneCache.Iface, p_class).f_timezone_added = @ptrCast(p_implementation);
            }
        };

        pub const tzcache_add_timezone = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_zone: *icalglib.Timezone) void {
                return gobject.ext.as(TimezoneCache.Iface, p_class).f_tzcache_add_timezone.?(gobject.ext.as(TimezoneCache, p_cache), p_zone);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_zone: *icalglib.Timezone) callconv(.c) void) void {
                gobject.ext.as(TimezoneCache.Iface, p_class).f_tzcache_add_timezone = @ptrCast(p_implementation);
            }
        };

        pub const tzcache_get_timezone = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_tzid: [*:0]const u8) *icalglib.Timezone {
                return gobject.ext.as(TimezoneCache.Iface, p_class).f_tzcache_get_timezone.?(gobject.ext.as(TimezoneCache, p_cache), p_tzid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_tzid: [*:0]const u8) callconv(.c) *icalglib.Timezone) void {
                gobject.ext.as(TimezoneCache.Iface, p_class).f_tzcache_get_timezone = @ptrCast(p_implementation);
            }
        };

        pub const tzcache_list_timezones = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.List {
                return gobject.ext.as(TimezoneCache.Iface, p_class).f_tzcache_list_timezones.?(gobject.ext.as(TimezoneCache, p_cache));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.List) void {
                gobject.ext.as(TimezoneCache.Iface, p_class).f_tzcache_list_timezones = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when a new `icaltimezone` is added to `cache`.
        pub const timezone_added = struct {
            pub const name = "timezone-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_zone: *icalglib.Timezone, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(TimezoneCache, p_instance))),
                    gobject.signalLookup("timezone-added", TimezoneCache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Adds a copy of `zone` to `cache` and emits an
    /// `ecal.TimezoneCache.signals.timezone`-added signal.  The `cache` will use the TZID
    /// string returned by `icalglib.Timezone.getTzid` as the lookup key, which can
    /// be passed to `ecal.TimezoneCache.getTimezone` to obtain `zone` again.
    ///
    /// If the `cache` already has an `ICalTimezone` with the same TZID string
    /// as `zone`, the `cache` will remain unchanged to avoid invalidating any
    /// `ICalTimezone` pointers which may have already been returned through
    /// `ecal.TimezoneCache.getTimezone`.
    extern fn e_timezone_cache_add_timezone(p_cache: *TimezoneCache, p_zone: *icalglib.Timezone) void;
    pub const addTimezone = e_timezone_cache_add_timezone;

    /// Obtains an `ICalTimezone` by its TZID string.  If no match is found,
    /// the function returns `NULL`.  The returned `ICalTimezone` is owned by
    /// the `cache` and should not be modified or freed.
    extern fn e_timezone_cache_get_timezone(p_cache: *TimezoneCache, p_tzid: [*:0]const u8) ?*icalglib.Timezone;
    pub const getTimezone = e_timezone_cache_get_timezone;

    /// Returns a list of `ICalTimezone` instances that were explicitly added to
    /// the `cache` through `ecal.TimezoneCache.addTimezone`.  In particular, any
    /// built-in time zone data that `ecal.TimezoneCache.getTimezone` may use to
    /// match a TZID string is excluded from the returned list.
    ///
    /// Free the returned list with `glib.List.free`.  The list elements are owned
    /// by the `cache` and should not be modified or freed.
    extern fn e_timezone_cache_list_timezones(p_cache: *TimezoneCache) *glib.List;
    pub const listTimezones = e_timezone_cache_list_timezones;

    extern fn e_timezone_cache_get_type() usize;
    pub const getGObjectType = e_timezone_cache_get_type;

    extern fn g_object_ref(p_self: *ecal.TimezoneCache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ecal.TimezoneCache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TimezoneCache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Base class structure for the `ecal.Client` class
pub const ClientClass = extern struct {
    pub const Instance = ecal.Client;

    f_parent: edataserver.ClientClass,
    /// signal used to notify about free/busy data
    f_free_busy_data: ?*const fn (p_client: *ecal.Client, p_free_busy_ecalcomps: *const glib.SList) callconv(.c) void,

    pub fn as(p_instance: *ClientClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClientPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains data used as lookup_data of `ecal.Client.tzlookupIcalcompCb`.
pub const ClientTzlookupICalCompData = opaque {
    /// Constructs a new `ecal.ClientTzlookupICalCompData`, which can
    /// be used as a lookup_data argument of `ecal.Client.tzlookupIcalcompCb`.
    /// Free it with `ecal.ClientTzlookupICalCompData.free`, when no longer needed.
    extern fn e_cal_client_tzlookup_icalcomp_data_new(p_icomp: *icalglib.Component) *ecal.ClientTzlookupICalCompData;
    pub const new = e_cal_client_tzlookup_icalcomp_data_new;

    /// Copies given `ecal.ClientTzlookupICalCompData` structure.
    /// When the `lookup_data` is `NULL`, simply returns `NULL` as well.
    extern fn e_cal_client_tzlookup_icalcomp_data_copy(p_lookup_data: ?*const ClientTzlookupICalCompData) ?*ecal.ClientTzlookupICalCompData;
    pub const copy = e_cal_client_tzlookup_icalcomp_data_copy;

    /// Frees previously allocated `ecal.ClientTzlookupICalCompData` structure
    /// with `ecal.ClientTzlookupICalCompData.new` or `ecal.ClientTzlookupICalCompData.copy`.
    /// The function does nothing when `lookup_data` is `NULL`.
    extern fn e_cal_client_tzlookup_icalcomp_data_free(p_lookup_data: ?*ClientTzlookupICalCompData) void;
    pub const free = e_cal_client_tzlookup_icalcomp_data_free;

    extern fn e_cal_client_tzlookup_icalcomp_data_get_icalcomponent(p_lookup_data: *const ClientTzlookupICalCompData) *icalglib.Component;
    pub const getIcalcomponent = e_cal_client_tzlookup_icalcomp_data_get_icalcomponent;

    extern fn e_cal_client_tzlookup_icalcomp_data_get_type() usize;
    pub const getGObjectType = e_cal_client_tzlookup_icalcomp_data_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Base class structure for the `ecal.ClientView` class
pub const ClientViewClass = extern struct {
    pub const Instance = ecal.ClientView;

    f_parent_class: gobject.ObjectClass,
    /// A signal emitted when new objects are added into the view
    f_objects_added: ?*const fn (p_client_view: *ecal.ClientView, p_objects: *const glib.SList) callconv(.c) void,
    /// A signal emitted when some objects are modified in the view
    f_objects_modified: ?*const fn (p_client_view: *ecal.ClientView, p_objects: *const glib.SList) callconv(.c) void,
    /// A signal emitted when some objects are removed from the view
    f_objects_removed: ?*const fn (p_client_view: *ecal.ClientView, p_uids: *const glib.SList) callconv(.c) void,
    /// A signal emitted when the backend notifies about the progress
    f_progress: ?*const fn (p_client_view: *ecal.ClientView, p_percent: c_uint, p_message: [*:0]const u8) callconv(.c) void,
    /// A signal emitted when the backend finished initial view population
    f_complete: ?*const fn (p_client_view: *ecal.ClientView, p_error: *const glib.Error) callconv(.c) void,

    pub fn as(p_instance: *ClientViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClientViewPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Opaque structure, which represents alarm subcomponents.
/// Use the functions below to work with it.
pub const ComponentAlarm = opaque {
    /// Creates a new empty `ecal.ComponentAlarm` structure. Free it
    /// with `ecal.ComponentAlarm.free`, when no longer needed.
    extern fn e_cal_component_alarm_new() *ecal.ComponentAlarm;
    pub const new = e_cal_component_alarm_new;

    /// Creates a new `ecal.ComponentAlarm`, filled with values from `component`,
    /// which should be of kind `I_CAL_VALARM_COMPONENT`. The function returns
    /// `NULL` when it is not of the expected kind. Free the structure
    /// with `ecal.ComponentAlarm.free`, when no longer needed.
    extern fn e_cal_component_alarm_new_from_component(p_component: *const icalglib.Component) ?*ecal.ComponentAlarm;
    pub const newFromComponent = e_cal_component_alarm_new_from_component;

    /// Returns a newly allocated copy of `alarm`, which should be freed with
    /// `ecal.ComponentAlarm.free`, when no longer needed.
    extern fn e_cal_component_alarm_copy(p_alarm: *const ComponentAlarm) *ecal.ComponentAlarm;
    pub const copy = e_cal_component_alarm_copy;

    /// Fills `component` with data from `alarm`. The `component` should
    /// be of `I_CAL_VALARM_COMPONENT` kind - the function does nothing,
    /// if it's not. In case the `alarm` doesn't have set 'uid', a new
    /// is assigned.
    extern fn e_cal_component_alarm_fill_component(p_alarm: *ComponentAlarm, p_component: *icalglib.Component) void;
    pub const fillComponent = e_cal_component_alarm_fill_component;

    /// Free `alarm`, previously created by `ecal.ComponentAlarm.new`,
    /// `ecal.ComponentAlarm.newFromComponent`
    /// or `ecal.ComponentAlarm.copy`. The function does nothing, if `alarm`
    /// is `NULL`.
    extern fn e_cal_component_alarm_free(p_alarm: ?*ComponentAlarm) void;
    pub const free = e_cal_component_alarm_free;

    /// Get the last time the alarm had been acknowledged, that is, when its
    /// reminder had been triggered.
    /// The returned `ICalTime` is owned by `alarm` and should not be modified,
    /// neither its content.
    extern fn e_cal_component_alarm_get_acknowledged(p_alarm: *const ComponentAlarm) ?*icalglib.Time;
    pub const getAcknowledged = e_cal_component_alarm_get_acknowledged;

    /// Get the `alarm` action, as an `ecal.ComponentAlarmAction`.
    extern fn e_cal_component_alarm_get_action(p_alarm: *const ComponentAlarm) ecal.ComponentAlarmAction;
    pub const getAction = e_cal_component_alarm_get_action;

    /// Creates a VALARM `ICalComponent` filled with data from the `alarm`.
    /// In case the `alarm` doesn't have set 'uid', a new is assigned.
    /// Free the returned component with `gobject.Object.unref`, when no longer
    /// needed.
    extern fn e_cal_component_alarm_get_as_component(p_alarm: *ComponentAlarm) *icalglib.Component;
    pub const getAsComponent = e_cal_component_alarm_get_as_component;

    /// Get the list of attachments, as `ICalAttach`.
    /// The returned `glib.SList` is owned by `alarm` and should not be modified,
    /// neither its content.
    extern fn e_cal_component_alarm_get_attachments(p_alarm: *const ComponentAlarm) ?*glib.SList;
    pub const getAttachments = e_cal_component_alarm_get_attachments;

    /// Get the list of attendees, as `ecal.ComponentAttendee`.
    /// The returned `glib.SList` is owned by `alarm` and should not be modified,
    /// neither its content.
    extern fn e_cal_component_alarm_get_attendees(p_alarm: *const ComponentAlarm) ?*glib.SList;
    pub const getAttendees = e_cal_component_alarm_get_attendees;

    /// Get the `alarm` description, as an `ecal.ComponentText`.
    extern fn e_cal_component_alarm_get_description(p_alarm: *const ComponentAlarm) ?*ecal.ComponentText;
    pub const getDescription = e_cal_component_alarm_get_description;

    extern fn e_cal_component_alarm_get_property_bag(p_alarm: *const ComponentAlarm) *ecal.ComponentPropertyBag;
    pub const getPropertyBag = e_cal_component_alarm_get_property_bag;

    /// Get the `alarm` repeat information, as an ECalComponentAlarmRepeat.
    extern fn e_cal_component_alarm_get_repeat(p_alarm: *const ComponentAlarm) ?*ecal.ComponentAlarmRepeat;
    pub const getRepeat = e_cal_component_alarm_get_repeat;

    /// Get the `alarm` summary, as an `ecal.ComponentText`.
    extern fn e_cal_component_alarm_get_summary(p_alarm: *const ComponentAlarm) ?*ecal.ComponentText;
    pub const getSummary = e_cal_component_alarm_get_summary;

    /// Get the `alarm` trigger, as an `ecal.ComponentAlarmTrigger`.
    extern fn e_cal_component_alarm_get_trigger(p_alarm: *const ComponentAlarm) ?*ecal.ComponentAlarmTrigger;
    pub const getTrigger = e_cal_component_alarm_get_trigger;

    /// Get the `alarm` UID.
    extern fn e_cal_component_alarm_get_uid(p_alarm: *const ComponentAlarm) ?[*:0]const u8;
    pub const getUid = e_cal_component_alarm_get_uid;

    extern fn e_cal_component_alarm_has_attachments(p_alarm: *const ComponentAlarm) c_int;
    pub const hasAttachments = e_cal_component_alarm_has_attachments;

    extern fn e_cal_component_alarm_has_attendees(p_alarm: *const ComponentAlarm) c_int;
    pub const hasAttendees = e_cal_component_alarm_has_attendees;

    /// Set the acknowledged time of the `alarm`. Use `NULL` to unset it.
    extern fn e_cal_component_alarm_set_acknowledged(p_alarm: *ComponentAlarm, p_when: ?*const icalglib.Time) void;
    pub const setAcknowledged = e_cal_component_alarm_set_acknowledged;

    /// Set the `alarm` action, as an `ecal.ComponentAlarmAction`.
    extern fn e_cal_component_alarm_set_action(p_alarm: *ComponentAlarm, p_action: ecal.ComponentAlarmAction) void;
    pub const setAction = e_cal_component_alarm_set_action;

    /// Set the list of attachments, as a `glib.SList` of an `ICalAttach`.
    extern fn e_cal_component_alarm_set_attachments(p_alarm: *ComponentAlarm, p_attachments: ?*const glib.SList) void;
    pub const setAttachments = e_cal_component_alarm_set_attachments;

    /// Set the list of attendees, as a `glib.SList` of an `ecal.ComponentAttendee`.
    extern fn e_cal_component_alarm_set_attendees(p_alarm: *ComponentAlarm, p_attendees: ?*const glib.SList) void;
    pub const setAttendees = e_cal_component_alarm_set_attendees;

    /// Set the `alarm` description, as an `ecal.ComponentText`.
    extern fn e_cal_component_alarm_set_description(p_alarm: *ComponentAlarm, p_description: ?*const ecal.ComponentText) void;
    pub const setDescription = e_cal_component_alarm_set_description;

    /// Fill the `alarm` structure with the information from
    /// the `component`, which should be of `I_CAL_VALARM_COMPONENT` kind.
    extern fn e_cal_component_alarm_set_from_component(p_alarm: *ComponentAlarm, p_component: *const icalglib.Component) void;
    pub const setFromComponent = e_cal_component_alarm_set_from_component;

    /// Set the `alarm` repeat information, as an `ecal.ComponentAlarmRepeat`.
    extern fn e_cal_component_alarm_set_repeat(p_alarm: *ComponentAlarm, p_repeat: ?*const ecal.ComponentAlarmRepeat) void;
    pub const setRepeat = e_cal_component_alarm_set_repeat;

    /// Set the `alarm` summary, as an `ecal.ComponentText`.
    extern fn e_cal_component_alarm_set_summary(p_alarm: *ComponentAlarm, p_summary: ?*const ecal.ComponentText) void;
    pub const setSummary = e_cal_component_alarm_set_summary;

    /// Set the `alarm` trigger, as an `ecal.ComponentAlarmTrigger`.
    extern fn e_cal_component_alarm_set_trigger(p_alarm: *ComponentAlarm, p_trigger: ?*const ecal.ComponentAlarmTrigger) void;
    pub const setTrigger = e_cal_component_alarm_set_trigger;

    /// Set the `alarm` UID, or generates a new UID, if `uid` is `NULL` or an empty string.
    extern fn e_cal_component_alarm_set_uid(p_alarm: *ComponentAlarm, p_uid: ?[*:0]const u8) void;
    pub const setUid = e_cal_component_alarm_set_uid;

    /// Set the acknowledged time of the `alarm`. Use `NULL` to unset it.
    /// The function assumes ownership of the `when`.
    extern fn e_cal_component_alarm_take_acknowledged(p_alarm: *ComponentAlarm, p_when: ?*icalglib.Time) void;
    pub const takeAcknowledged = e_cal_component_alarm_take_acknowledged;

    /// Sets the list of attachments, as a `glib.SList` of an `ICalAttach` and assumes
    /// ownership of the `attachments` and its content.
    extern fn e_cal_component_alarm_take_attachments(p_alarm: *ComponentAlarm, p_attachments: ?*glib.SList) void;
    pub const takeAttachments = e_cal_component_alarm_take_attachments;

    /// Sets the list of attendees, as a `glib.SList` of an `ecal.ComponentAttendee` and assumes
    /// ownership of the `attendees` and its content.
    extern fn e_cal_component_alarm_take_attendees(p_alarm: *ComponentAlarm, p_attendees: ?*glib.SList) void;
    pub const takeAttendees = e_cal_component_alarm_take_attendees;

    /// Set the `alarm` description, as an `ecal.ComponentText`, and assumes
    /// ownership of the `description`.
    extern fn e_cal_component_alarm_take_description(p_alarm: *ComponentAlarm, p_description: ?*ecal.ComponentText) void;
    pub const takeDescription = e_cal_component_alarm_take_description;

    /// Set the `alarm` repeat information, as an `ecal.ComponentAlarmRepeat` and assumes
    /// ownership of the `trigger`.
    extern fn e_cal_component_alarm_take_repeat(p_alarm: *ComponentAlarm, p_repeat: ?*ecal.ComponentAlarmRepeat) void;
    pub const takeRepeat = e_cal_component_alarm_take_repeat;

    /// Set the `alarm` summary, as an `ecal.ComponentText`, and assumes
    /// ownership of the `summary`.
    extern fn e_cal_component_alarm_take_summary(p_alarm: *ComponentAlarm, p_summary: ?*ecal.ComponentText) void;
    pub const takeSummary = e_cal_component_alarm_take_summary;

    /// Set the `alarm` trigger, as an `ecal.ComponentAlarmTrigger` and assumes
    /// ownership of the `trigger`.
    extern fn e_cal_component_alarm_take_trigger(p_alarm: *ComponentAlarm, p_trigger: ?*ecal.ComponentAlarmTrigger) void;
    pub const takeTrigger = e_cal_component_alarm_take_trigger;

    extern fn e_cal_component_alarm_get_type() usize;
    pub const getGObjectType = e_cal_component_alarm_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Opaque structure, which represents an alarm occurrence, i.e. a instance instance.
/// Use the functions below to work with it.
pub const ComponentAlarmInstance = opaque {
    /// Creates a new `ecal.ComponentAlarmInstance` structure, filled with the given values.
    /// Free the instance with `ecal.ComponentAlarmInstance.free`, when no longer needed.
    extern fn e_cal_component_alarm_instance_new(p_uid: [*:0]const u8, p_instance_time: std.posix.time_t, p_occur_start: std.posix.time_t, p_occur_end: std.posix.time_t) *ecal.ComponentAlarmInstance;
    pub const new = e_cal_component_alarm_instance_new;

    /// Returns a newly allocated copy of `instance`, which should be freed with
    /// `ecal.ComponentAlarmInstance.free`, when no longer needed.
    extern fn e_cal_component_alarm_instance_copy(p_instance: *const ComponentAlarmInstance) *ecal.ComponentAlarmInstance;
    pub const copy = e_cal_component_alarm_instance_copy;

    /// Free `instance`, previously created by `ecal.ComponentAlarmInstance.new`
    /// or `ecal.ComponentAlarmInstance.copy`. The function does nothing, if `instance`
    /// is `NULL`.
    extern fn e_cal_component_alarm_instance_free(p_instance: ?*ComponentAlarmInstance) void;
    pub const free = e_cal_component_alarm_instance_free;

    extern fn e_cal_component_alarm_instance_get_component(p_instance: *const ComponentAlarmInstance) ?*anyopaque;
    pub const getComponent = e_cal_component_alarm_instance_get_component;

    extern fn e_cal_component_alarm_instance_get_occur_end(p_instance: *const ComponentAlarmInstance) std.posix.time_t;
    pub const getOccurEnd = e_cal_component_alarm_instance_get_occur_end;

    extern fn e_cal_component_alarm_instance_get_occur_start(p_instance: *const ComponentAlarmInstance) std.posix.time_t;
    pub const getOccurStart = e_cal_component_alarm_instance_get_occur_start;

    extern fn e_cal_component_alarm_instance_get_rid(p_instance: *const ComponentAlarmInstance) ?[*:0]const u8;
    pub const getRid = e_cal_component_alarm_instance_get_rid;

    extern fn e_cal_component_alarm_instance_get_time(p_instance: *const ComponentAlarmInstance) std.posix.time_t;
    pub const getTime = e_cal_component_alarm_instance_get_time;

    extern fn e_cal_component_alarm_instance_get_uid(p_instance: *const ComponentAlarmInstance) [*:0]const u8;
    pub const getUid = e_cal_component_alarm_instance_get_uid;

    /// Sets `component` as the component associated with the `instance`.
    /// It can be `NULL` to unset it.
    extern fn e_cal_component_alarm_instance_set_component(p_instance: *ComponentAlarmInstance, p_component: ?*anyopaque) void;
    pub const setComponent = e_cal_component_alarm_instance_set_component;

    /// Set the actual event occurrence end to which this `instance` corresponds.
    extern fn e_cal_component_alarm_instance_set_occur_end(p_instance: *ComponentAlarmInstance, p_occur_end: std.posix.time_t) void;
    pub const setOccurEnd = e_cal_component_alarm_instance_set_occur_end;

    /// Set the actual event occurrence start to which this `instance` corresponds.
    extern fn e_cal_component_alarm_instance_set_occur_start(p_instance: *ComponentAlarmInstance, p_occur_start: std.posix.time_t) void;
    pub const setOccurStart = e_cal_component_alarm_instance_set_occur_start;

    /// Set the Recurrence ID of the component this `instance` was generated for.
    extern fn e_cal_component_alarm_instance_set_rid(p_instance: *ComponentAlarmInstance, p_rid: ?[*:0]const u8) void;
    pub const setRid = e_cal_component_alarm_instance_set_rid;

    /// Set the instance time, i.e. "5 minutes before the appointment".
    extern fn e_cal_component_alarm_instance_set_time(p_instance: *ComponentAlarmInstance, p_instance_time: std.posix.time_t) void;
    pub const setTime = e_cal_component_alarm_instance_set_time;

    /// Set the alarm UID.
    extern fn e_cal_component_alarm_instance_set_uid(p_instance: *ComponentAlarmInstance, p_uid: [*:0]const u8) void;
    pub const setUid = e_cal_component_alarm_instance_set_uid;

    extern fn e_cal_component_alarm_instance_get_type() usize;
    pub const getGObjectType = e_cal_component_alarm_instance_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure holding whether and how an alarm repeats.
/// Use the functions below to work with it.
pub const ComponentAlarmRepeat = opaque {
    /// Creates a new `ecal.ComponentAlarmRepeat` describing alarm repetitions.
    /// The returned structure should be freed with `ecal.ComponentAlarmRepeat.free`,
    /// when no longer needed.
    extern fn e_cal_component_alarm_repeat_new(p_repetitions: c_int, p_interval: *const icalglib.Duration) *ecal.ComponentAlarmRepeat;
    pub const new = e_cal_component_alarm_repeat_new;

    /// Creates a new `ecal.ComponentAlarmRepeat` describing alarm repetitions.
    /// The returned structure should be freed with `ecal.ComponentAlarmRepeat.free`,
    /// when no longer needed.
    extern fn e_cal_component_alarm_repeat_new_seconds(p_repetitions: c_int, p_interval_seconds: c_int) *ecal.ComponentAlarmRepeat;
    pub const newSeconds = e_cal_component_alarm_repeat_new_seconds;

    extern fn e_cal_component_alarm_repeat_copy(p_repeat: *const ComponentAlarmRepeat) *ecal.ComponentAlarmRepeat;
    pub const copy = e_cal_component_alarm_repeat_copy;

    /// Free the `repeat`, previously allocated by `ecal.ComponentAlarmRepeat.new`,
    /// `ecal.ComponentAlarmRepeat.newSeconds` or `ecal.ComponentAlarmRepeat.copy`.
    extern fn e_cal_component_alarm_repeat_free(p_repeat: ?*ComponentAlarmRepeat) void;
    pub const free = e_cal_component_alarm_repeat_free;

    /// Returns the interval between repetitions of the `repeat`, as an `ICalDuration`
    /// object. This object is owned by `repeat` and should not be freed. It's valid until
    /// the `repeat` is not freed or its interval changed with either `ecal.ComponentAlarmRepeat.setInterval`
    /// or `ecal.ComponentAlarmRepeat.setIntervalSeconds`.
    extern fn e_cal_component_alarm_repeat_get_interval(p_repeat: *const ComponentAlarmRepeat) *icalglib.Duration;
    pub const getInterval = e_cal_component_alarm_repeat_get_interval;

    /// Returns the interval between repetitions of the `repeat` in seconds.
    extern fn e_cal_component_alarm_repeat_get_interval_seconds(p_repeat: *const ComponentAlarmRepeat) c_int;
    pub const getIntervalSeconds = e_cal_component_alarm_repeat_get_interval_seconds;

    extern fn e_cal_component_alarm_repeat_get_repetitions(p_repeat: *const ComponentAlarmRepeat) c_int;
    pub const getRepetitions = e_cal_component_alarm_repeat_get_repetitions;

    /// Set the `interval` between repetitions of the `repeat`.
    extern fn e_cal_component_alarm_repeat_set_interval(p_repeat: *ComponentAlarmRepeat, p_interval: *const icalglib.Duration) void;
    pub const setInterval = e_cal_component_alarm_repeat_set_interval;

    /// Set the `interval_seconds` between repetitions of the `repeat`.
    extern fn e_cal_component_alarm_repeat_set_interval_seconds(p_repeat: *ComponentAlarmRepeat, p_interval_seconds: c_int) void;
    pub const setIntervalSeconds = e_cal_component_alarm_repeat_set_interval_seconds;

    /// Set the `repetitions` count of the `repeat`.
    extern fn e_cal_component_alarm_repeat_set_repetitions(p_repeat: *ComponentAlarmRepeat, p_repetitions: c_int) void;
    pub const setRepetitions = e_cal_component_alarm_repeat_set_repetitions;

    extern fn e_cal_component_alarm_repeat_get_type() usize;
    pub const getGObjectType = e_cal_component_alarm_repeat_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Opaque structure, which represents when an alarm is supposed to be triggered.
/// Use the functions below to work with it.
pub const ComponentAlarmTrigger = opaque {
    /// Creates a new `ecal.ComponentAlarmTrigger` structure, set with
    /// the `E_CAL_COMPONENT_ALARM_TRIGGER_ABSOLUTE` kind and the `absolute_time` as
    /// the time of the trigger. The `absolute_time` should be date/time (not date) in UTC.
    ///
    /// To create a relative trigger use `ecal.ComponentAlarmTrigger.newRelative`.
    /// Free the trigger with `ecal.ComponentAlarmTrigger.free`, when no longer needed.
    extern fn e_cal_component_alarm_trigger_new_absolute(p_absolute_time: *const icalglib.Time) *ecal.ComponentAlarmTrigger;
    pub const newAbsolute = e_cal_component_alarm_trigger_new_absolute;

    /// Creates a new `ecal.ComponentAlarmTrigger`, filled with values from `property`,
    /// which should be of kind `I_CAL_TRIGGER_PROPERTY`. The function returns
    /// `NULL` when it is not of the expected kind. Free the structure
    /// with `ecal.ComponentAlarmTrigger.free`, when no longer needed.
    extern fn e_cal_component_alarm_trigger_new_from_property(p_property: *const icalglib.Property) ?*ecal.ComponentAlarmTrigger;
    pub const newFromProperty = e_cal_component_alarm_trigger_new_from_property;

    /// Creates a new `ecal.ComponentAlarmTrigger` structure, set with the given `kind`
    /// and `duration`. The `kind` can be any but the `E_CAL_COMPONENT_ALARM_TRIGGER_ABSOLUTE`.
    /// To create an absolute trigger use `ecal.ComponentAlarmTrigger.newAbsolute`.
    /// Free the trigger with `ecal.ComponentAlarmTrigger.free`, when no longer needed.
    extern fn e_cal_component_alarm_trigger_new_relative(p_kind: ecal.ComponentAlarmTriggerKind, p_duration: *const icalglib.Duration) *ecal.ComponentAlarmTrigger;
    pub const newRelative = e_cal_component_alarm_trigger_new_relative;

    /// Returns a newly allocated copy of `trigger`, which should be freed with
    /// `ecal.ComponentAlarmTrigger.free`, when no longer needed.
    extern fn e_cal_component_alarm_trigger_copy(p_trigger: *const ComponentAlarmTrigger) *ecal.ComponentAlarmTrigger;
    pub const copy = e_cal_component_alarm_trigger_copy;

    /// Fill `property` with information from `trigger`. The `property`
    /// should be of kind `I_CAL_TRIGGER_PROPERTY`.
    extern fn e_cal_component_alarm_trigger_fill_property(p_trigger: *const ComponentAlarmTrigger, p_property: *icalglib.Property) void;
    pub const fillProperty = e_cal_component_alarm_trigger_fill_property;

    /// Free `trigger`, previously created by `ecal.ComponentAlarmTrigger.newRelative`,
    /// `ecal.ComponentAlarmTrigger.newAbsolute`, `ecal.ComponentAlarmTrigger.newFromProperty`
    /// or `ecal.ComponentAlarmTrigger.copy`. The function does nothing, if `trigger`
    /// is `NULL`.
    extern fn e_cal_component_alarm_trigger_free(p_trigger: ?*ComponentAlarmTrigger) void;
    pub const free = e_cal_component_alarm_trigger_free;

    /// Returns the `trigger` absolute time for an absolute trigger, or `NULL`, when
    /// the `trigger` is a relative trigger. The object is owned by `trigger` and it's
    /// valid until the `trigger` is freed or its absolute time changed.
    extern fn e_cal_component_alarm_trigger_get_absolute_time(p_trigger: *const ComponentAlarmTrigger) ?*icalglib.Time;
    pub const getAbsoluteTime = e_cal_component_alarm_trigger_get_absolute_time;

    /// Converts information stored in `trigger` into an `ICalProperty`
    /// of `I_CAL_TRIGGER_PROPERTY` kind. The caller is responsible to free
    /// the returned object with `gobject.Object.unref`, when no longer needed.
    extern fn e_cal_component_alarm_trigger_get_as_property(p_trigger: *const ComponentAlarmTrigger) *icalglib.Property;
    pub const getAsProperty = e_cal_component_alarm_trigger_get_as_property;

    /// Returns the `trigger` duration for a relative `trigger`, or `NULL`, when
    /// the `trigger` is an absolute trigger.
    extern fn e_cal_component_alarm_trigger_get_duration(p_trigger: *const ComponentAlarmTrigger) ?*icalglib.Duration;
    pub const getDuration = e_cal_component_alarm_trigger_get_duration;

    extern fn e_cal_component_alarm_trigger_get_kind(p_trigger: *const ComponentAlarmTrigger) ecal.ComponentAlarmTriggerKind;
    pub const getKind = e_cal_component_alarm_trigger_get_kind;

    extern fn e_cal_component_alarm_trigger_get_parameter_bag(p_trigger: *const ComponentAlarmTrigger) *ecal.ComponentParameterBag;
    pub const getParameterBag = e_cal_component_alarm_trigger_get_parameter_bag;

    /// Set the `trigegr` with the `E_CAL_COMPONENT_ALARM_TRIGGER_ABSOLUTE` kind and
    /// the `absolute_time` as the time of the trigger. The `absolute_time`
    /// should be date/time (not date) in UTC.
    ///
    /// To set a relative trigger use `ecal.ComponentAlarmTrigger.setRelative`.
    extern fn e_cal_component_alarm_trigger_set_absolute(p_trigger: *ComponentAlarmTrigger, p_absolute_time: *const icalglib.Time) void;
    pub const setAbsolute = e_cal_component_alarm_trigger_set_absolute;

    /// Sets the `trigger` absolute time for an absolute trigger. The `absolute_time`
    /// should be date/time (not date) in UTC.
    ///
    /// The function does nothing, when the `trigger` is a relative trigger.
    extern fn e_cal_component_alarm_trigger_set_absolute_time(p_trigger: *ComponentAlarmTrigger, p_absolute_time: *const icalglib.Time) void;
    pub const setAbsoluteTime = e_cal_component_alarm_trigger_set_absolute_time;

    /// Sets the `trigger` duration for a relative trigger. The function does nothing, when
    /// the `trigger` is an absolute trigger. The object is owned by `trigger` and it's
    /// valid until the `trigger` is freed or its relative duration changed.
    extern fn e_cal_component_alarm_trigger_set_duration(p_trigger: *ComponentAlarmTrigger, p_duration: *const icalglib.Duration) void;
    pub const setDuration = e_cal_component_alarm_trigger_set_duration;

    /// Fill the `trigger` structure with the information from
    /// the `property`, which should be of `I_CAL_TRIGGER_PROPERTY` kind.
    extern fn e_cal_component_alarm_trigger_set_from_property(p_trigger: *ComponentAlarmTrigger, p_property: *const icalglib.Property) void;
    pub const setFromProperty = e_cal_component_alarm_trigger_set_from_property;

    /// Set the `trigger` kind to `kind`. This works only for other than
    /// the `E_CAL_COMPONENT_ALARM_TRIGGER_ABSOLUTE`. To change the kind
    /// from absolute to relative, or vice versa, use either
    /// `ecal.ComponentAlarmTrigger.setRelative` or
    /// `ecal.ComponentAlarmTrigger.setAbsolute`.
    extern fn e_cal_component_alarm_trigger_set_kind(p_trigger: *ComponentAlarmTrigger, p_kind: ecal.ComponentAlarmTriggerKind) void;
    pub const setKind = e_cal_component_alarm_trigger_set_kind;

    /// Set the `trigegr` with the given `kind` and `duration`. The `kind` can be any but
    /// the `E_CAL_COMPONENT_ALARM_TRIGGER_ABSOLUTE`.
    /// To set an absolute trigger use `ecal.ComponentAlarmTrigger.setAbsolute`.
    extern fn e_cal_component_alarm_trigger_set_relative(p_trigger: *ComponentAlarmTrigger, p_kind: ecal.ComponentAlarmTriggerKind, p_duration: *const icalglib.Duration) void;
    pub const setRelative = e_cal_component_alarm_trigger_set_relative;

    extern fn e_cal_component_alarm_trigger_get_type() usize;
    pub const getGObjectType = e_cal_component_alarm_trigger_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Opaque structure, which represents alarm trigger instances for a particular component.
/// Use the functions below to work with it.
pub const ComponentAlarms = opaque {
    /// Creates a new `ecal.ComponentAlarms` structure, associated with `comp`.
    /// Free the alarms with `ecal.ComponentAlarms.free`, when no longer needed.
    ///
    /// The `comp` can be `NULL` since 3.48, in which case the respective instances hold
    /// the component they belong to.
    extern fn e_cal_component_alarms_new(p_comp: ?*ecal.Component) *ecal.ComponentAlarms;
    pub const new = e_cal_component_alarms_new;

    /// Add a copy of `instance` into the list of instances. It is added
    /// in no particular order.
    extern fn e_cal_component_alarms_add_instance(p_alarms: *ComponentAlarms, p_instance: *const ecal.ComponentAlarmInstance) void;
    pub const addInstance = e_cal_component_alarms_add_instance;

    /// Returns a newly allocated copy of `alarms`, which should be freed with
    /// `ecal.ComponentAlarms.free`, when no longer needed.
    extern fn e_cal_component_alarms_copy(p_alarms: *const ComponentAlarms) *ecal.ComponentAlarms;
    pub const copy = e_cal_component_alarms_copy;

    /// Free `alarms`, previously created by `ecal.ComponentAlarms.new`
    /// or `ecal.ComponentAlarms.copy`. The function does nothing, if `alarms`
    /// is `NULL`.
    extern fn e_cal_component_alarms_free(p_alarms: ?*ComponentAlarms) void;
    pub const free = e_cal_component_alarms_free;

    /// The returned component is valid until the `alarms` is freed.
    extern fn e_cal_component_alarms_get_component(p_alarms: *const ComponentAlarms) ?*ecal.Component;
    pub const getComponent = e_cal_component_alarms_get_component;

    /// The returned `glib.SList` is owned by `alarms` and should not be modified.
    /// It's valid until the `alarms` is freed or the list of instances is not
    /// modified by other functions. The items are of type `ecal.ComponentAlarmInstance`.
    extern fn e_cal_component_alarms_get_instances(p_alarms: *const ComponentAlarms) ?*glib.SList;
    pub const getInstances = e_cal_component_alarms_get_instances;

    /// Remove the `instance` from the list of instances. If found, the `instance`
    /// is also freed.
    extern fn e_cal_component_alarms_remove_instance(p_alarms: *ComponentAlarms, p_instance: *const ecal.ComponentAlarmInstance) c_int;
    pub const removeInstance = e_cal_component_alarms_remove_instance;

    /// Modifies the list of instances to copy of the given `instances`.
    extern fn e_cal_component_alarms_set_instances(p_alarms: *ComponentAlarms, p_instances: ?*const glib.SList) void;
    pub const setInstances = e_cal_component_alarms_set_instances;

    /// Add the `instance` into the list of instances and assume ownership of it.
    /// It is added in no particular order.
    extern fn e_cal_component_alarms_take_instance(p_alarms: *ComponentAlarms, p_instance: *ecal.ComponentAlarmInstance) void;
    pub const takeInstance = e_cal_component_alarms_take_instance;

    /// Replaces the list of instances with the given `instances` and
    /// assumes ownership of it. Neither the `glib.SList`, nor its items, should
    /// contain the same structures.
    extern fn e_cal_component_alarms_take_instances(p_alarms: *ComponentAlarms, p_instances: ?*glib.SList) void;
    pub const takeInstances = e_cal_component_alarms_take_instances;

    extern fn e_cal_component_alarms_get_type() usize;
    pub const getGObjectType = e_cal_component_alarms_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes an attendee. Use the functions below to work with it.
pub const ComponentAttendee = opaque {
    /// Creates a new empty `ecal.ComponentAttendee` structure. Free it
    /// with `ecal.ComponentAttendee.free`, when no longer needed.
    extern fn e_cal_component_attendee_new() *ecal.ComponentAttendee;
    pub const new = e_cal_component_attendee_new;

    /// Creates a new `ecal.ComponentAttendee`, filled with values from `property`,
    /// which should be of kind `I_CAL_ATTENDEE_PROPERTY`. The function returns
    /// `NULL` when it is not of the expected kind. Free the structure
    /// with `ecal.ComponentAttendee.free`, when no longer needed.
    extern fn e_cal_component_attendee_new_from_property(p_property: *const icalglib.Property) ?*ecal.ComponentAttendee;
    pub const newFromProperty = e_cal_component_attendee_new_from_property;

    /// Creates a new `ecal.ComponentAttendee` structure, with all members filled
    /// with given values from the parameters. The `NULL` and empty strings are
    /// treated as unset the value. Free the structure
    /// with `ecal.ComponentAttendee.free`, when no longer needed.
    extern fn e_cal_component_attendee_new_full(p_value: ?[*:0]const u8, p_member: ?[*:0]const u8, p_cutype: icalglib.ParameterCutype, p_role: icalglib.ParameterRole, p_partstat: icalglib.ParameterPartstat, p_rsvp: c_int, p_delegatedfrom: ?[*:0]const u8, p_delegatedto: ?[*:0]const u8, p_sentby: ?[*:0]const u8, p_cn: ?[*:0]const u8, p_language: ?[*:0]const u8) *ecal.ComponentAttendee;
    pub const newFull = e_cal_component_attendee_new_full;

    /// Returns a newly allocated copy of `attendee`, which should be freed with
    /// `ecal.ComponentAttendee.free`, when no longer needed.
    extern fn e_cal_component_attendee_copy(p_attendee: *const ComponentAttendee) *ecal.ComponentAttendee;
    pub const copy = e_cal_component_attendee_copy;

    /// Fill `property` with information from `attendee`. The `property`
    /// should be of kind `I_CAL_ATTENDEE_PROPERTY`.
    extern fn e_cal_component_attendee_fill_property(p_attendee: *const ComponentAttendee, p_property: *icalglib.Property) void;
    pub const fillProperty = e_cal_component_attendee_fill_property;

    /// Free `attendee`, previously created by `ecal.ComponentAttendee.new`,
    /// `ecal.ComponentAttendee.newFull`, `ecal.ComponentAttendee.newFromProperty`
    /// or `ecal.ComponentAttendee.copy`. The function does nothing, if `attendee`
    /// is `NULL`.
    extern fn e_cal_component_attendee_free(p_attendee: ?*ComponentAttendee) void;
    pub const free = e_cal_component_attendee_free;

    /// Converts information stored in `attendee` into an `ICalProperty`
    /// of `I_CAL_ATTENDEE_PROPERTY` kind. The caller is responsible to free
    /// the returned object with `gobject.Object.unref`, when no longer needed.
    extern fn e_cal_component_attendee_get_as_property(p_attendee: *const ComponentAttendee) *icalglib.Property;
    pub const getAsProperty = e_cal_component_attendee_get_as_property;

    extern fn e_cal_component_attendee_get_cn(p_attendee: *const ComponentAttendee) ?[*:0]const u8;
    pub const getCn = e_cal_component_attendee_get_cn;

    extern fn e_cal_component_attendee_get_cutype(p_attendee: *const ComponentAttendee) icalglib.ParameterCutype;
    pub const getCutype = e_cal_component_attendee_get_cutype;

    extern fn e_cal_component_attendee_get_delegatedfrom(p_attendee: *const ComponentAttendee) ?[*:0]const u8;
    pub const getDelegatedfrom = e_cal_component_attendee_get_delegatedfrom;

    extern fn e_cal_component_attendee_get_delegatedto(p_attendee: *const ComponentAttendee) ?[*:0]const u8;
    pub const getDelegatedto = e_cal_component_attendee_get_delegatedto;

    extern fn e_cal_component_attendee_get_language(p_attendee: *const ComponentAttendee) ?[*:0]const u8;
    pub const getLanguage = e_cal_component_attendee_get_language;

    extern fn e_cal_component_attendee_get_member(p_attendee: *const ComponentAttendee) ?[*:0]const u8;
    pub const getMember = e_cal_component_attendee_get_member;

    extern fn e_cal_component_attendee_get_parameter_bag(p_attendee: *const ComponentAttendee) *ecal.ComponentParameterBag;
    pub const getParameterBag = e_cal_component_attendee_get_parameter_bag;

    extern fn e_cal_component_attendee_get_partstat(p_attendee: *const ComponentAttendee) icalglib.ParameterPartstat;
    pub const getPartstat = e_cal_component_attendee_get_partstat;

    extern fn e_cal_component_attendee_get_role(p_attendee: *const ComponentAttendee) icalglib.ParameterRole;
    pub const getRole = e_cal_component_attendee_get_role;

    extern fn e_cal_component_attendee_get_rsvp(p_attendee: *const ComponentAttendee) c_int;
    pub const getRsvp = e_cal_component_attendee_get_rsvp;

    extern fn e_cal_component_attendee_get_sentby(p_attendee: *const ComponentAttendee) ?[*:0]const u8;
    pub const getSentby = e_cal_component_attendee_get_sentby;

    extern fn e_cal_component_attendee_get_value(p_attendee: *const ComponentAttendee) ?[*:0]const u8;
    pub const getValue = e_cal_component_attendee_get_value;

    /// Set the `attendee` common name (cn) parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_attendee_set_cn(p_attendee: *ComponentAttendee, p_cn: ?[*:0]const u8) void;
    pub const setCn = e_cal_component_attendee_set_cn;

    /// Set the `attendee` type, as an `icalglib.ParameterCutype`.
    extern fn e_cal_component_attendee_set_cutype(p_attendee: *ComponentAttendee, p_cutype: icalglib.ParameterCutype) void;
    pub const setCutype = e_cal_component_attendee_set_cutype;

    /// Set the `attendee` delegatedfrom parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_attendee_set_delegatedfrom(p_attendee: *ComponentAttendee, p_delegatedfrom: ?[*:0]const u8) void;
    pub const setDelegatedfrom = e_cal_component_attendee_set_delegatedfrom;

    /// Set the `attendee` delegatedto parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_attendee_set_delegatedto(p_attendee: *ComponentAttendee, p_delegatedto: ?[*:0]const u8) void;
    pub const setDelegatedto = e_cal_component_attendee_set_delegatedto;

    /// Fill the `attendee` structure with the information from
    /// the `property`, which should be of `I_CAL_ATTENDEE_PROPERTY` kind.
    extern fn e_cal_component_attendee_set_from_property(p_attendee: *ComponentAttendee, p_property: *const icalglib.Property) void;
    pub const setFromProperty = e_cal_component_attendee_set_from_property;

    /// Set the `attendee` language parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_attendee_set_language(p_attendee: *ComponentAttendee, p_language: ?[*:0]const u8) void;
    pub const setLanguage = e_cal_component_attendee_set_language;

    /// Set the `attendee` member parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_attendee_set_member(p_attendee: *ComponentAttendee, p_member: ?[*:0]const u8) void;
    pub const setMember = e_cal_component_attendee_set_member;

    /// Set the `attendee` status, as an `icalglib.ParameterPartstat`.
    extern fn e_cal_component_attendee_set_partstat(p_attendee: *ComponentAttendee, p_partstat: icalglib.ParameterPartstat) void;
    pub const setPartstat = e_cal_component_attendee_set_partstat;

    /// Set the `attendee` role, as an `icalglib.ParameterRole`.
    extern fn e_cal_component_attendee_set_role(p_attendee: *ComponentAttendee, p_role: icalglib.ParameterRole) void;
    pub const setRole = e_cal_component_attendee_set_role;

    /// Set the `attendee` RSVP.
    extern fn e_cal_component_attendee_set_rsvp(p_attendee: *ComponentAttendee, p_rsvp: c_int) void;
    pub const setRsvp = e_cal_component_attendee_set_rsvp;

    /// Set the `attendee` sentby parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_attendee_set_sentby(p_attendee: *ComponentAttendee, p_sentby: ?[*:0]const u8) void;
    pub const setSentby = e_cal_component_attendee_set_sentby;

    /// Set the `attendee` URI, usually of "mailto:email" form. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_attendee_set_value(p_attendee: *ComponentAttendee, p_value: ?[*:0]const u8) void;
    pub const setValue = e_cal_component_attendee_set_value;

    extern fn e_cal_component_attendee_get_type() usize;
    pub const getGObjectType = e_cal_component_attendee_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ComponentClass = extern struct {
    pub const Instance = ecal.Component;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ComponentClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque structure containing an `ICalTime` describing
/// the date/time value and also its TZID parameter. Use the functions
/// below to work with it.
pub const ComponentDateTime = opaque {
    /// Creates a new `ecal.ComponentDateTime` instance, which holds
    /// the `value` and `tzid`. The returned structure should be freed
    /// with `ecal.ComponentDateTime.free`, when no longer needed.
    extern fn e_cal_component_datetime_new(p_value: *const icalglib.Time, p_tzid: ?[*:0]const u8) *ecal.ComponentDateTime;
    pub const new = e_cal_component_datetime_new;

    /// Creates a new `ecal.ComponentDateTime` instance, which holds
    /// the `value` and `tzid`. It is similar to `ecal.ComponentDateTime.new`,
    /// except this function assumes ownership of the `value` and `tzid`.
    /// The returned structure should be freed with `ecal.ComponentDateTime.free`,
    /// when no longer needed.
    extern fn e_cal_component_datetime_new_take(p_value: *icalglib.Time, p_tzid: ?[*:0]u8) *ecal.ComponentDateTime;
    pub const newTake = e_cal_component_datetime_new_take;

    /// Creates a new copy of `dt`. The returned structure should be freed
    /// with `ecal.ComponentDateTime.free` when no longer needed.
    extern fn e_cal_component_datetime_copy(p_dt: *const ComponentDateTime) *ecal.ComponentDateTime;
    pub const copy = e_cal_component_datetime_copy;

    /// Free `dt`, previously created by `ecal.ComponentDateTime.new`,
    /// `ecal.ComponentDateTime.newTake` or `ecal.ComponentDateTime.copy`.
    /// The function does nothing, if `dt` is `NULL`.
    extern fn e_cal_component_datetime_free(p_dt: ?*ComponentDateTime) void;
    pub const free = e_cal_component_datetime_free;

    /// Returns the TZID stored with the `dt`. The string is owned by `dt` and
    /// it's valid until the `dt` is freed or its TZID overwritten. It never
    /// returns an empty string, it returns either set TZID parameter value
    /// or `NULL`, when none is set.
    extern fn e_cal_component_datetime_get_tzid(p_dt: *const ComponentDateTime) ?[*:0]const u8;
    pub const getTzid = e_cal_component_datetime_get_tzid;

    /// Returns the value stored with the `dt`. The object is owned by `dt` and
    /// it's valid until the `dt` is freed or its value overwritten.
    extern fn e_cal_component_datetime_get_value(p_dt: *const ComponentDateTime) *icalglib.Time;
    pub const getValue = e_cal_component_datetime_get_value;

    /// Sets both `value` and `tzid` in one call. Use `ecal.ComponentDateTime.setValue`
    /// and `ecal.ComponentDateTime.setTzid` to set them separately.
    extern fn e_cal_component_datetime_set(p_dt: *ComponentDateTime, p_value: *const icalglib.Time, p_tzid: ?[*:0]const u8) void;
    pub const set = e_cal_component_datetime_set;

    /// Sets the `tzid` of the `dt`. Any previously set TZID is freed.
    /// An empty string or a `NULL` as `tzid` is treated as none TZID.
    extern fn e_cal_component_datetime_set_tzid(p_dt: *ComponentDateTime, p_tzid: ?[*:0]const u8) void;
    pub const setTzid = e_cal_component_datetime_set_tzid;

    /// Sets the `value` of the `dt`. Any previously set value is freed.
    extern fn e_cal_component_datetime_set_value(p_dt: *ComponentDateTime, p_value: *const icalglib.Time) void;
    pub const setValue = e_cal_component_datetime_set_value;

    /// Sets the `tzid` of the `dt` and assumes ownership of `tzid`. Any previously
    /// set TZID is freed. An empty string or a `NULL` as `tzid` is treated as none TZID.
    extern fn e_cal_component_datetime_take_tzid(p_dt: *ComponentDateTime, p_tzid: ?[*:0]u8) void;
    pub const takeTzid = e_cal_component_datetime_take_tzid;

    /// Sets the `value` of the `dt` and assumes ownership of the `value`.
    /// Any previously set value is freed.
    extern fn e_cal_component_datetime_take_value(p_dt: *ComponentDateTime, p_value: *icalglib.Time) void;
    pub const takeValue = e_cal_component_datetime_take_value;

    extern fn e_cal_component_datetime_get_type() usize;
    pub const getGObjectType = e_cal_component_datetime_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque structure containing UID of a component and
/// its recurrence ID (which can be `NULL`). Use the functions
/// below to work with it.
pub const ComponentId = opaque {
    /// Creates a new `ecal.ComponentId` from `uid` and `rid`, which should be
    /// freed with `ecal.ComponentId.free`.
    extern fn e_cal_component_id_new(p_uid: [*:0]const u8, p_rid: ?[*:0]const u8) *ecal.ComponentId;
    pub const new = e_cal_component_id_new;

    /// Creates a new `ecal.ComponentId` from `uid` and `rid`, which should be
    /// freed with `ecal.ComponentId.free`. The function assumes ownership
    /// of `uid` and `rid` parameters.
    extern fn e_cal_component_id_new_take(p_uid: [*:0]u8, p_rid: ?[*:0]u8) *ecal.ComponentId;
    pub const newTake = e_cal_component_id_new_take;

    /// Returns a newly allocated copy of `id`, which should be freed with
    /// `ecal.ComponentId.free`.
    extern fn e_cal_component_id_copy(p_id: *const ComponentId) *ecal.ComponentId;
    pub const copy = e_cal_component_id_copy;

    /// Compares two `ecal.ComponentId` structs for equality.
    extern fn e_cal_component_id_equal(p_id1: *const ComponentId, p_id2: *const ecal.ComponentId) c_int;
    pub const equal = e_cal_component_id_equal;

    /// Free the `id`, previously created by `ecal.ComponentId.new`,
    /// `ecal.ComponentId.newTake` or `ecal.ComponentId.copy`.
    extern fn e_cal_component_id_free(p_id: ?*ComponentId) void;
    pub const free = e_cal_component_id_free;

    extern fn e_cal_component_id_get_rid(p_id: *const ComponentId) ?[*:0]const u8;
    pub const getRid = e_cal_component_id_get_rid;

    extern fn e_cal_component_id_get_uid(p_id: *const ComponentId) [*:0]const u8;
    pub const getUid = e_cal_component_id_get_uid;

    /// Generates a hash value for `id`.
    extern fn e_cal_component_id_hash(p_id: *const ComponentId) c_uint;
    pub const hash = e_cal_component_id_hash;

    /// Sets the RECURRENCE-ID part of the `id`. The `rid` can be `NULL`
    /// or an empty string, where both are treated as `NULL`, which
    /// means the `id` has not RECURRENCE-ID.
    extern fn e_cal_component_id_set_rid(p_id: *ComponentId, p_rid: ?[*:0]const u8) void;
    pub const setRid = e_cal_component_id_set_rid;

    /// Sets the UID part of the `id`.
    extern fn e_cal_component_id_set_uid(p_id: *ComponentId, p_uid: [*:0]const u8) void;
    pub const setUid = e_cal_component_id_set_uid;

    extern fn e_cal_component_id_get_type() usize;
    pub const getGObjectType = e_cal_component_id_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes an organizer. Use the functions below to work with it.
pub const ComponentOrganizer = opaque {
    /// Creates a new empty `ecal.ComponentOrganizer` structure. Free it
    /// with `ecal.ComponentOrganizer.free`, when no longer needed.
    extern fn e_cal_component_organizer_new() *ecal.ComponentOrganizer;
    pub const new = e_cal_component_organizer_new;

    /// Creates a new `ecal.ComponentOrganizer`, filled with values from `property`,
    /// which should be of kind `I_CAL_ORGANIZER_PROPERTY`. The function returns
    /// `NULL` when it is not of the expected kind. Free the structure
    /// with `ecal.ComponentOrganizer.free`, when no longer needed.
    extern fn e_cal_component_organizer_new_from_property(p_property: *const icalglib.Property) ?*ecal.ComponentOrganizer;
    pub const newFromProperty = e_cal_component_organizer_new_from_property;

    /// Creates a new `ecal.ComponentOrganizer` structure, with all members filled
    /// with given values from the parameters. The `NULL` and empty strings are
    /// treated as unset the value. Free the structure
    /// with `ecal.ComponentOrganizer.free`, when no longer needed.
    extern fn e_cal_component_organizer_new_full(p_value: ?[*:0]const u8, p_sentby: ?[*:0]const u8, p_cn: ?[*:0]const u8, p_language: ?[*:0]const u8) *ecal.ComponentOrganizer;
    pub const newFull = e_cal_component_organizer_new_full;

    /// Returns a newly allocated copy of `organizer`, which should be freed with
    /// `ecal.ComponentOrganizer.free`, when no longer needed.
    extern fn e_cal_component_organizer_copy(p_organizer: *const ComponentOrganizer) *ecal.ComponentOrganizer;
    pub const copy = e_cal_component_organizer_copy;

    /// Fill `property` with information from `organizer`. The `property`
    /// should be of kind `I_CAL_ORGANIZER_PROPERTY`.
    extern fn e_cal_component_organizer_fill_property(p_organizer: *const ComponentOrganizer, p_property: *icalglib.Property) void;
    pub const fillProperty = e_cal_component_organizer_fill_property;

    /// Free `organizer`, previously created by `ecal.ComponentOrganizer.new`,
    /// `ecal.ComponentOrganizer.newFull`, `ecal.ComponentOrganizer.newFromProperty`
    /// or `ecal.ComponentOrganizer.copy`. The function does nothing, if `organizer`
    /// is `NULL`.
    extern fn e_cal_component_organizer_free(p_organizer: ?*ComponentOrganizer) void;
    pub const free = e_cal_component_organizer_free;

    /// Converts information stored in `organizer` into an `ICalProperty`
    /// of `I_CAL_ORGANIZER_PROPERTY` kind. The caller is responsible to free
    /// the returned object with `gobject.Object.unref`, when no longer needed.
    extern fn e_cal_component_organizer_get_as_property(p_organizer: *const ComponentOrganizer) *icalglib.Property;
    pub const getAsProperty = e_cal_component_organizer_get_as_property;

    extern fn e_cal_component_organizer_get_cn(p_organizer: *const ComponentOrganizer) ?[*:0]const u8;
    pub const getCn = e_cal_component_organizer_get_cn;

    extern fn e_cal_component_organizer_get_language(p_organizer: *const ComponentOrganizer) ?[*:0]const u8;
    pub const getLanguage = e_cal_component_organizer_get_language;

    extern fn e_cal_component_organizer_get_parameter_bag(p_organizer: *const ComponentOrganizer) *ecal.ComponentParameterBag;
    pub const getParameterBag = e_cal_component_organizer_get_parameter_bag;

    extern fn e_cal_component_organizer_get_sentby(p_organizer: *const ComponentOrganizer) ?[*:0]const u8;
    pub const getSentby = e_cal_component_organizer_get_sentby;

    extern fn e_cal_component_organizer_get_value(p_organizer: *const ComponentOrganizer) ?[*:0]const u8;
    pub const getValue = e_cal_component_organizer_get_value;

    /// Set the `organizer` common name (cn) parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_organizer_set_cn(p_organizer: *ComponentOrganizer, p_cn: ?[*:0]const u8) void;
    pub const setCn = e_cal_component_organizer_set_cn;

    /// Fill the `organizer` structure with the information from
    /// the `property`, which should be of `I_CAL_ORGANIZER_PROPERTY` kind.
    extern fn e_cal_component_organizer_set_from_property(p_organizer: *ComponentOrganizer, p_property: *const icalglib.Property) void;
    pub const setFromProperty = e_cal_component_organizer_set_from_property;

    /// Set the `organizer` language parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_organizer_set_language(p_organizer: *ComponentOrganizer, p_language: ?[*:0]const u8) void;
    pub const setLanguage = e_cal_component_organizer_set_language;

    /// Set the `organizer` sentby parameter. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_organizer_set_sentby(p_organizer: *ComponentOrganizer, p_sentby: ?[*:0]const u8) void;
    pub const setSentby = e_cal_component_organizer_set_sentby;

    /// Set the `organizer` URI, usually of "mailto:email" form. The `NULL`
    /// and empty strings are treated as unset the value.
    extern fn e_cal_component_organizer_set_value(p_organizer: *ComponentOrganizer, p_value: ?[*:0]const u8) void;
    pub const setValue = e_cal_component_organizer_set_value;

    extern fn e_cal_component_organizer_get_type() usize;
    pub const getGObjectType = e_cal_component_organizer_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Opaque structure, which represents a bad (list) of `ICalParameter` objects.
/// Use the functions below to work with it.
pub const ComponentParameterBag = opaque {
    /// Creates a new `ecal.ComponentParameterBag`. Free the structure
    /// with `ecal.ComponentParameterBag.free`, when no longer needed.
    extern fn e_cal_component_parameter_bag_new() *ecal.ComponentParameterBag;
    pub const new = e_cal_component_parameter_bag_new;

    /// Creates a new `ecal.ComponentParameterBag`, filled with parameters
    /// from the `property`, for which the `func` returned `TRUE`. When
    /// the `func` is `NULL`, all the parameters are included.
    ///
    /// Free the structure with `ecal.ComponentParameterBag.free`, when no longer needed.
    extern fn e_cal_component_parameter_bag_new_from_property(p_property: *const icalglib.Property, p_func: ?ecal.ComponentParameterBagFilterFunc, p_user_data: ?*anyopaque) *ecal.ComponentParameterBag;
    pub const newFromProperty = e_cal_component_parameter_bag_new_from_property;

    /// Adds a copy of the `param` into the `bag`.
    extern fn e_cal_component_parameter_bag_add(p_bag: *ComponentParameterBag, p_param: *const icalglib.Parameter) void;
    pub const add = e_cal_component_parameter_bag_add;

    /// Assigns content of the `src_bag` into the `bag`.
    extern fn e_cal_component_parameter_bag_assign(p_bag: *ComponentParameterBag, p_src_bag: *const ecal.ComponentParameterBag) void;
    pub const assign = e_cal_component_parameter_bag_assign;

    /// Removes all parameters from the `bag`, thus it doesn't contain any
    /// parameter after this function returns.
    extern fn e_cal_component_parameter_bag_clear(p_bag: *ComponentParameterBag) void;
    pub const clear = e_cal_component_parameter_bag_clear;

    /// Returns a newly allocated copy of `bag`, which should be freed with
    /// `ecal.ComponentParameterBag.free`, when no longer needed.
    extern fn e_cal_component_parameter_bag_copy(p_bag: *const ComponentParameterBag) *ecal.ComponentParameterBag;
    pub const copy = e_cal_component_parameter_bag_copy;

    /// Adds all the stored parameters in the `bag` to the `property`.
    /// The function replaces any existing parameter with the new value,
    /// if any such exists. Otherwise the parameter is added.
    extern fn e_cal_component_parameter_bag_fill_property(p_bag: *const ComponentParameterBag, p_property: *icalglib.Property) void;
    pub const fillProperty = e_cal_component_parameter_bag_fill_property;

    /// Free `bag`, previously created by `ecal.ComponentParameterBag.new`,
    /// `e_cal_component_parameter_bag_new_from_component` or
    /// `ecal.ComponentParameterBag.copy`. The function does nothing, if `bag`
    /// is `NULL`.
    extern fn e_cal_component_parameter_bag_free(p_bag: ?*ComponentParameterBag) void;
    pub const free = e_cal_component_parameter_bag_free;

    /// Returns the `ICalParameter` at the given `index`. If the `index` is
    /// out of bounds (not lower than `ecal.ComponentParameterBag.getCount`),
    /// then `NULL` is returned.
    ///
    /// The returned parameter is owned by the `bag` and should not be freed
    /// by the caller.
    extern fn e_cal_component_parameter_bag_get(p_bag: *const ComponentParameterBag, p_index: c_uint) ?*icalglib.Parameter;
    pub const get = e_cal_component_parameter_bag_get;

    extern fn e_cal_component_parameter_bag_get_count(p_bag: *const ComponentParameterBag) c_uint;
    pub const getCount = e_cal_component_parameter_bag_get_count;

    extern fn e_cal_component_parameter_bag_get_first_by_kind(p_bag: *const ComponentParameterBag, p_kind: icalglib.ParameterKind) c_uint;
    pub const getFirstByKind = e_cal_component_parameter_bag_get_first_by_kind;

    /// Removes the `ICalParameter` at the given `index`. If the `index` is
    /// out of bounds (not lower than `ecal.ComponentParameterBag.getCount`),
    /// then the function does nothing.
    extern fn e_cal_component_parameter_bag_remove(p_bag: *ComponentParameterBag, p_index: c_uint) void;
    pub const remove = e_cal_component_parameter_bag_remove;

    /// Removes the first or all (depending on the `all`) parameters of the given `kind`.
    extern fn e_cal_component_parameter_bag_remove_by_kind(p_bag: *ComponentParameterBag, p_kind: icalglib.ParameterKind, p_all: c_int) c_uint;
    pub const removeByKind = e_cal_component_parameter_bag_remove_by_kind;

    /// Fills the `bag` with parameters from the `property`, for which the `func`
    /// returned `TRUE`. When the `func` is `NULL`, all the parameters are included.
    /// The `bag` content is cleared before any parameter is added.
    extern fn e_cal_component_parameter_bag_set_from_property(p_bag: *ComponentParameterBag, p_property: *const icalglib.Property, p_func: ?ecal.ComponentParameterBagFilterFunc, p_user_data: ?*anyopaque) void;
    pub const setFromProperty = e_cal_component_parameter_bag_set_from_property;

    /// Adds the `param` into the `bag` and assumes ownership of the `param`.
    extern fn e_cal_component_parameter_bag_take(p_bag: *ComponentParameterBag, p_param: *icalglib.Parameter) void;
    pub const take = e_cal_component_parameter_bag_take;

    extern fn e_cal_component_parameter_bag_get_type() usize;
    pub const getGObjectType = e_cal_component_parameter_bag_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Period of time, can have explicit start/end times or start/duration instead.
/// Use the functions below to work with it.
pub const ComponentPeriod = opaque {
    /// Creates a new `ecal.ComponentPeriod` of kind `E_CAL_COMPONENT_PERIOD_DATETIME`.
    /// The returned structure should be freed with `ecal.ComponentPeriod.free`,
    /// when no longer needed.
    extern fn e_cal_component_period_new_datetime(p_start: *const icalglib.Time, p_end: ?*const icalglib.Time) *ecal.ComponentPeriod;
    pub const newDatetime = e_cal_component_period_new_datetime;

    /// Creates a new `ecal.ComponentPeriod` of kind `E_CAL_COMPONENT_PERIOD_DURATION`.
    /// The returned structure should be freed with `ecal.ComponentPeriod.free`,
    /// when no longer needed.
    extern fn e_cal_component_period_new_duration(p_start: *const icalglib.Time, p_duration: *const icalglib.Duration) *ecal.ComponentPeriod;
    pub const newDuration = e_cal_component_period_new_duration;

    extern fn e_cal_component_period_copy(p_period: *const ComponentPeriod) *ecal.ComponentPeriod;
    pub const copy = e_cal_component_period_copy;

    /// Free the `period`, previously allocated by `ecal.ComponentPeriod.newDatetime`,
    /// `ecal.ComponentPeriod.newDuration` or `ecal.ComponentPeriod.copy`.
    extern fn e_cal_component_period_free(p_period: ?*ComponentPeriod) void;
    pub const free = e_cal_component_period_free;

    /// Returns the duration of the `period`. This can be called only on `period`
    /// objects of kind `E_CAL_COMPONENT_PERIOD_DURATION`.
    /// The returned `ICalDuration` object is owned by `period` and should not
    /// be freed. It's valid until the `period` is freed or its duration changed.
    extern fn e_cal_component_period_get_duration(p_period: *const ComponentPeriod) *icalglib.Duration;
    pub const getDuration = e_cal_component_period_get_duration;

    /// Returns the end of the `period`. This can be called only on `period`
    /// objects of kind `E_CAL_COMPONENT_PERIOD_DATETIME`. The end time can
    /// be a null-time, in which case the `period` corresponds to a single
    /// date/date-time value, not to a period.
    ///
    /// The returned `ICalTime` object is owned by `period` and should not
    /// be freed. It's valid until the `period` is freed or its end time changed.
    extern fn e_cal_component_period_get_end(p_period: *const ComponentPeriod) ?*icalglib.Time;
    pub const getEnd = e_cal_component_period_get_end;

    /// Returns kind of the `period`, one of `ecal.ComponentPeriodKind`. Depending
    /// on it either `ecal.ComponentPeriod.getEnd`/`ecal.ComponentPeriod.setEnd`
    /// or `ecal.ComponentPeriod.getDuration`/`ecal.ComponentPeriod.setDuration`
    /// can be used. The kind of an existing `period` canbe changed with
    /// `ecal.ComponentPeriod.setDatetimeFull` and `ecal.ComponentPeriod.setDurationFull`.
    extern fn e_cal_component_period_get_kind(p_period: *const ComponentPeriod) ecal.ComponentPeriodKind;
    pub const getKind = e_cal_component_period_get_kind;

    /// Returns the start of the `period`. The returned `ICalTime` object
    /// is owned by `period` and should not be freed. It's valid until the `period`
    /// is freed or its start time changed.
    extern fn e_cal_component_period_get_start(p_period: *const ComponentPeriod) *icalglib.Time;
    pub const getStart = e_cal_component_period_get_start;

    /// Set the kind of `period` to be `E_CAL_COMPONENT_PERIOD_DATETIME`
    /// and fills the content with `start` and `end`.
    extern fn e_cal_component_period_set_datetime_full(p_period: *ComponentPeriod, p_start: *const icalglib.Time, p_end: ?*const icalglib.Time) void;
    pub const setDatetimeFull = e_cal_component_period_set_datetime_full;

    /// Set the duration of the `period`. This can be called only on `period`
    /// objects of kind `E_CAL_COMPONENT_PERIOD_DURATION`.
    extern fn e_cal_component_period_set_duration(p_period: *ComponentPeriod, p_duration: *const icalglib.Duration) void;
    pub const setDuration = e_cal_component_period_set_duration;

    /// Set the kind of `period` to be `E_CAL_COMPONENT_PERIOD_DURATION`
    /// and fills the content with `start` and `duration`.
    extern fn e_cal_component_period_set_duration_full(p_period: *ComponentPeriod, p_start: *const icalglib.Time, p_duration: *const icalglib.Duration) void;
    pub const setDurationFull = e_cal_component_period_set_duration_full;

    /// Set the end of the `period`. This can be called only on `period`
    /// objects of kind `E_CAL_COMPONENT_PERIOD_DATETIME`.
    extern fn e_cal_component_period_set_end(p_period: *ComponentPeriod, p_end: ?*const icalglib.Time) void;
    pub const setEnd = e_cal_component_period_set_end;

    /// Set the `start` of the `period`. This can be called on any kind of the `period`.
    extern fn e_cal_component_period_set_start(p_period: *ComponentPeriod, p_start: *const icalglib.Time) void;
    pub const setStart = e_cal_component_period_set_start;

    extern fn e_cal_component_period_get_type() usize;
    pub const getGObjectType = e_cal_component_period_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ComponentPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Opaque structure, which represents a bad (list) of `ICalProperty` objects.
/// Use the functions below to work with it.
pub const ComponentPropertyBag = opaque {
    /// Creates a new `ecal.ComponentPropertyBag`. Free the structure
    /// with `ecal.ComponentPropertyBag.free`, when no longer needed.
    extern fn e_cal_component_property_bag_new() *ecal.ComponentPropertyBag;
    pub const new = e_cal_component_property_bag_new;

    /// Creates a new `ecal.ComponentPropertyBag`, filled with properties
    /// from the `component`, for which the `func` returned `TRUE`. When
    /// the `func` is `NULL`, all the properties are included.
    ///
    /// Free the structure with `ecal.ComponentPropertyBag.free`, when no longer needed.
    extern fn e_cal_component_property_bag_new_from_component(p_component: *const icalglib.Component, p_func: ?ecal.ComponentPropertyBagFilterFunc, p_user_data: ?*anyopaque) *ecal.ComponentPropertyBag;
    pub const newFromComponent = e_cal_component_property_bag_new_from_component;

    /// Adds a copy of the `prop` into the `bag`.
    extern fn e_cal_component_property_bag_add(p_bag: *ComponentPropertyBag, p_prop: *const icalglib.Property) void;
    pub const add = e_cal_component_property_bag_add;

    /// Assigns content of the `src_bag` into the `bag`.
    extern fn e_cal_component_property_bag_assign(p_bag: *ComponentPropertyBag, p_src_bag: *const ecal.ComponentPropertyBag) void;
    pub const assign = e_cal_component_property_bag_assign;

    /// Removes all properties from the `bag`, thus it doesn't contain any
    /// property after this function returns.
    extern fn e_cal_component_property_bag_clear(p_bag: *ComponentPropertyBag) void;
    pub const clear = e_cal_component_property_bag_clear;

    /// Returns a newly allocated copy of `bag`, which should be freed with
    /// `ecal.ComponentPropertyBag.free`, when no longer needed.
    extern fn e_cal_component_property_bag_copy(p_bag: *const ComponentPropertyBag) *ecal.ComponentPropertyBag;
    pub const copy = e_cal_component_property_bag_copy;

    /// Adds all the stored properties in the `bag` to the `component`.
    /// The function doesn't verify whether the `component` contains
    /// the same property already.
    extern fn e_cal_component_property_bag_fill_component(p_bag: *const ComponentPropertyBag, p_component: *icalglib.Component) void;
    pub const fillComponent = e_cal_component_property_bag_fill_component;

    /// Free `bag`, previously created by `ecal.ComponentPropertyBag.new`,
    /// `ecal.ComponentPropertyBag.newFromComponent` or
    /// `ecal.ComponentPropertyBag.copy`. The function does nothing, if `bag`
    /// is `NULL`.
    extern fn e_cal_component_property_bag_free(p_bag: ?*ComponentPropertyBag) void;
    pub const free = e_cal_component_property_bag_free;

    /// Returns the `ICalProperty` at the given `index`. If the `index` is
    /// out of bounds (not lower than `ecal.ComponentPropertyBag.getCount`),
    /// then `NULL` is returned.
    ///
    /// The returned property is owned by the `bag` and should not be freed
    /// by the caller.
    extern fn e_cal_component_property_bag_get(p_bag: *const ComponentPropertyBag, p_index: c_uint) ?*icalglib.Property;
    pub const get = e_cal_component_property_bag_get;

    extern fn e_cal_component_property_bag_get_count(p_bag: *const ComponentPropertyBag) c_uint;
    pub const getCount = e_cal_component_property_bag_get_count;

    extern fn e_cal_component_property_bag_get_first_by_kind(p_bag: *const ComponentPropertyBag, p_kind: icalglib.PropertyKind) c_uint;
    pub const getFirstByKind = e_cal_component_property_bag_get_first_by_kind;

    /// Removes the `ICalProperty` at the given `index`. If the `index` is
    /// out of bounds (not lower than `ecal.ComponentPropertyBag.getCount`),
    /// then the function does nothing.
    extern fn e_cal_component_property_bag_remove(p_bag: *ComponentPropertyBag, p_index: c_uint) void;
    pub const remove = e_cal_component_property_bag_remove;

    /// Removes the first or all (depending on the `all`) properties of the given `kind`.
    extern fn e_cal_component_property_bag_remove_by_kind(p_bag: *ComponentPropertyBag, p_kind: icalglib.PropertyKind, p_all: c_int) c_uint;
    pub const removeByKind = e_cal_component_property_bag_remove_by_kind;

    /// Fills the `bag` with properties from the `component`, for which the `func`
    /// returned `TRUE`. When the `func` is `NULL`, all the properties are included.
    /// The `bag` content is cleared before any property is added.
    extern fn e_cal_component_property_bag_set_from_component(p_bag: *ComponentPropertyBag, p_component: *const icalglib.Component, p_func: ?ecal.ComponentPropertyBagFilterFunc, p_user_data: ?*anyopaque) void;
    pub const setFromComponent = e_cal_component_property_bag_set_from_component;

    /// Adds the `prop` into the `bag` and assumes ownership of the `prop`.
    extern fn e_cal_component_property_bag_take(p_bag: *ComponentPropertyBag, p_prop: *icalglib.Property) void;
    pub const take = e_cal_component_property_bag_take;

    extern fn e_cal_component_property_bag_get_type() usize;
    pub const getGObjectType = e_cal_component_property_bag_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a range. Use the functions below to work with it.
pub const ComponentRange = opaque {
    /// Creates a new `ecal.ComponentRange` describing a range.
    /// The returned structure should be freed with `ecal.ComponentRange.free`,
    /// when no longer needed.
    extern fn e_cal_component_range_new(p_kind: ecal.ComponentRangeKind, p_datetime: *const ecal.ComponentDateTime) *ecal.ComponentRange;
    pub const new = e_cal_component_range_new;

    /// Creates a new `ecal.ComponentRange` describing a range, similar to
    /// `ecal.ComponentRange.new` except is assumes ownership of `datetime`.
    /// The returned structure should be freed with `ecal.ComponentRange.free`,
    /// when no longer needed.
    extern fn e_cal_component_range_new_take(p_kind: ecal.ComponentRangeKind, p_datetime: *ecal.ComponentDateTime) *ecal.ComponentRange;
    pub const newTake = e_cal_component_range_new_take;

    extern fn e_cal_component_range_copy(p_range: *const ComponentRange) *ecal.ComponentRange;
    pub const copy = e_cal_component_range_copy;

    /// Free the `range`, previously allocated by `ecal.ComponentRange.new`,
    /// `ecal.ComponentRange.newTake` or `ecal.ComponentRange.copy`.
    extern fn e_cal_component_range_free(p_range: ?*ComponentRange) void;
    pub const free = e_cal_component_range_free;

    /// Returns the date/time of the `range`. The returned `ecal.ComponentDateTime`
    /// is owned by `range` and should not be freed. It's valid until the `range`
    /// is freed or its date/time changed.
    extern fn e_cal_component_range_get_datetime(p_range: *const ComponentRange) *ecal.ComponentDateTime;
    pub const getDatetime = e_cal_component_range_get_datetime;

    extern fn e_cal_component_range_get_kind(p_range: *const ComponentRange) ecal.ComponentRangeKind;
    pub const getKind = e_cal_component_range_get_kind;

    /// Set the date/time part of the `range`.
    extern fn e_cal_component_range_set_datetime(p_range: *ComponentRange, p_datetime: *const ecal.ComponentDateTime) void;
    pub const setDatetime = e_cal_component_range_set_datetime;

    /// Set the `kind` of the `range`.
    extern fn e_cal_component_range_set_kind(p_range: *ComponentRange, p_kind: ecal.ComponentRangeKind) void;
    pub const setKind = e_cal_component_range_set_kind;

    /// Set the date/time part of the `range`, similar to `ecal.ComponentRange.setDatetime`,
    /// except it assumes ownership of the `datetime`.
    extern fn e_cal_component_range_take_datetime(p_range: *ComponentRange, p_datetime: *ecal.ComponentDateTime) void;
    pub const takeDatetime = e_cal_component_range_take_datetime;

    extern fn e_cal_component_range_get_type() usize;
    pub const getGObjectType = e_cal_component_range_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains description string and an alternate representation URI
/// for text properties. Use the functions below to work with it.
pub const ComponentText = opaque {
    /// Creates a new `ecal.ComponentText` describing text properties.
    /// The returned structure should be freed with `ecal.ComponentText.free`,
    /// when no longer needed.
    extern fn e_cal_component_text_new(p_value: ?[*:0]const u8, p_altrep: ?[*:0]const u8) *ecal.ComponentText;
    pub const new = e_cal_component_text_new;

    /// Created a new `ecal.ComponentText` filled with values from the `property`.
    /// The `property` should hold a text value.
    extern fn e_cal_component_text_new_from_property(p_property: *const icalglib.Property) *ecal.ComponentText;
    pub const newFromProperty = e_cal_component_text_new_from_property;

    extern fn e_cal_component_text_copy(p_text: *const ComponentText) *ecal.ComponentText;
    pub const copy = e_cal_component_text_copy;

    /// Fills the `property` with the content of the `text`.
    extern fn e_cal_component_text_fill_property(p_text: *const ComponentText, p_property: *icalglib.Property) void;
    pub const fillProperty = e_cal_component_text_fill_property;

    /// Free the `text`, previously allocated by `ecal.ComponentText.new` or
    /// `ecal.ComponentText.copy`.
    extern fn e_cal_component_text_free(p_text: ?*ComponentText) void;
    pub const free = e_cal_component_text_free;

    extern fn e_cal_component_text_get_altrep(p_text: *const ComponentText) [*:0]const u8;
    pub const getAltrep = e_cal_component_text_get_altrep;

    extern fn e_cal_component_text_get_language(p_text: *const ComponentText) [*:0]const u8;
    pub const getLanguage = e_cal_component_text_get_language;

    extern fn e_cal_component_text_get_value(p_text: *const ComponentText) [*:0]const u8;
    pub const getValue = e_cal_component_text_get_value;

    /// Set the `altrep` as the alternate representation URI of the `text`.
    extern fn e_cal_component_text_set_altrep(p_text: *ComponentText, p_altrep: ?[*:0]const u8) void;
    pub const setAltrep = e_cal_component_text_set_altrep;

    /// Fill the `text` structure with the information from the `property`.
    /// The `property` should hold a text value.
    extern fn e_cal_component_text_set_from_property(p_text: *ComponentText, p_property: *const icalglib.Property) void;
    pub const setFromProperty = e_cal_component_text_set_from_property;

    /// Set the `language` as the language of the `text`. The language tag
    /// is defined in RFC 5646. For example `en-US`, not `en_US`.
    extern fn e_cal_component_text_set_language(p_text: *ComponentText, p_language: ?[*:0]const u8) void;
    pub const setLanguage = e_cal_component_text_set_language;

    /// Set the `value` as the description string of the `text`.
    extern fn e_cal_component_text_set_value(p_text: *ComponentText, p_value: ?[*:0]const u8) void;
    pub const setValue = e_cal_component_text_set_value;

    extern fn e_cal_component_text_get_type() usize;
    pub const getGObjectType = e_cal_component_text_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains data related to single reminder occurrence.
pub const ReminderData = opaque {
    extern fn e_reminder_data_new(p_source_uid: [*:0]const u8, p_component: *const ecal.Component, p_instance: *const ecal.ComponentAlarmInstance) *ecal.ReminderData;
    pub const new = e_reminder_data_new;

    /// Copies given `ecal.ReminderData` structure. When the `rd` is `NULL`, simply returns `NULL` as well.
    extern fn e_reminder_data_copy(p_rd: ?*const ReminderData) ?*ecal.ReminderData;
    pub const copy = e_reminder_data_copy;

    /// Frees previously allocated `ecal.ReminderData` structure with `ecal.ReminderData.new`
    /// or `ecal.ReminderData.copy`. The function does nothing when `rd` is `NULL`.
    extern fn e_reminder_data_free(p_rd: ?*ReminderData) void;
    pub const free = e_reminder_data_free;

    extern fn e_reminder_data_get_component(p_rd: *const ReminderData) *ecal.Component;
    pub const getComponent = e_reminder_data_get_component;

    extern fn e_reminder_data_get_instance(p_rd: *const ReminderData) *ecal.ComponentAlarmInstance;
    pub const getInstance = e_reminder_data_get_instance;

    extern fn e_reminder_data_get_source_uid(p_rd: *const ReminderData) [*:0]const u8;
    pub const getSourceUid = e_reminder_data_get_source_uid;

    /// Set an `ecal.Component` `component` as associated with this `rd`.
    /// The `rd` creates a copy of the `component`.
    extern fn e_reminder_data_set_component(p_rd: *ReminderData, p_component: *const ecal.Component) void;
    pub const setComponent = e_reminder_data_set_component;

    /// Set an `ecal.ComponentAlarmInstance` `instance` as associated with this `rd`.
    /// The `rd` creates a copy of the `instance`.
    extern fn e_reminder_data_set_instance(p_rd: *ReminderData, p_instance: *const ecal.ComponentAlarmInstance) void;
    pub const setInstance = e_reminder_data_set_instance;

    /// Set an `edataserver.Source` UID for `rd`.
    extern fn e_reminder_data_set_source_uid(p_rd: *ReminderData, p_source_uid: [*:0]const u8) void;
    pub const setSourceUid = e_reminder_data_set_source_uid;

    extern fn e_reminder_data_get_type() usize;
    pub const getGObjectType = e_reminder_data_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ReminderWatcherClass = extern struct {
    pub const Instance = ecal.ReminderWatcher;

    f_parent_class: gobject.ObjectClass,
    f_schedule_timer: ?*const fn (p_watcher: *ecal.ReminderWatcher, p_at_time: i64) callconv(.c) void,
    f_format_time: ?*const fn (p_watcher: *ecal.ReminderWatcher, p_rd: *const ecal.ReminderData, p_itt: *icalglib.Time, p_inout_buffer: *[*:0]u8, p_buffer_size: c_int) callconv(.c) void,
    f_triggered: ?*const fn (p_watcher: *ecal.ReminderWatcher, p_reminders: *const glib.SList, p_snoozed: c_int) callconv(.c) void,
    f_changed: ?*const fn (p_watcher: *ecal.ReminderWatcher) callconv(.c) void,
    f_cal_client_connect_sync: ?*const fn (p_watcher: *ecal.ReminderWatcher, p_source: *edataserver.Source, p_source_type: ecal.ClientSourceType, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*edataserver.Client,
    f_cal_client_connect: ?*const fn (p_watcher: *ecal.ReminderWatcher, p_source: *edataserver.Source, p_source_type: ecal.ClientSourceType, p_wait_for_connected_seconds: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_cal_client_connect_finish: ?*const fn (p_watcher: *ecal.ReminderWatcher, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) ?*edataserver.Client,
    f_reserved: [7]*anyopaque,

    pub fn as(p_instance: *ReminderWatcherClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ReminderWatcherPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TimezoneCacheInterface = extern struct {
    pub const Instance = ecal.TimezoneCache;

    f_parent_interface: gobject.TypeInterface,
    f_tzcache_add_timezone: ?*const fn (p_cache: *ecal.TimezoneCache, p_zone: *icalglib.Timezone) callconv(.c) void,
    f_tzcache_get_timezone: ?*const fn (p_cache: *ecal.TimezoneCache, p_tzid: [*:0]const u8) callconv(.c) *icalglib.Timezone,
    f_tzcache_list_timezones: ?*const fn (p_cache: *ecal.TimezoneCache) callconv(.c) *glib.List,
    f_timezone_added: ?*const fn (p_cache: *ecal.TimezoneCache, p_zone: *icalglib.Timezone) callconv(.c) void,
    f_reserved_signals: [4]*anyopaque,

    pub fn as(p_instance: *TimezoneCacheInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClientError = enum(c_int) {
    no_such_calendar = 0,
    object_not_found = 1,
    invalid_object = 2,
    unknown_user = 3,
    object_id_already_exists = 4,
    invalid_range = 5,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the type of calendar
pub const ClientSourceType = enum(c_int) {
    events = 0,
    tasks = 1,
    memos = 2,
    _,

    extern fn e_cal_client_source_type_get_type() usize;
    pub const getGObjectType = e_cal_client_source_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Alarm types
pub const ComponentAlarmAction = enum(c_int) {
    none = 0,
    audio = 1,
    display = 2,
    email = 3,
    procedure = 4,
    unknown = 5,
    _,

    extern fn e_cal_component_alarm_action_get_type() usize;
    pub const getGObjectType = e_cal_component_alarm_action_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ComponentAlarmTriggerKind = enum(c_int) {
    none = 0,
    relative_start = 1,
    relative_end = 2,
    absolute = 3,
    _,

    extern fn e_cal_component_alarm_trigger_kind_get_type() usize;
    pub const getGObjectType = e_cal_component_alarm_trigger_kind_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// CLASSIFICATION property
pub const ComponentClassification = enum(c_int) {
    none = 0,
    public = 1,
    private = 2,
    confidential = 3,
    unknown = 4,
    _,

    extern fn e_cal_component_classification_get_type() usize;
    pub const getGObjectType = e_cal_component_classification_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Way in which a period of time is specified
pub const ComponentPeriodKind = enum(c_int) {
    datetime = 0,
    duration = 1,
    _,

    extern fn e_cal_component_period_kind_get_type() usize;
    pub const getGObjectType = e_cal_component_period_kind_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The kind of range
pub const ComponentRangeKind = enum(c_int) {
    single = 0,
    thisprior = 1,
    thisfuture = 2,
    _,

    extern fn e_cal_component_range_kind_get_type() usize;
    pub const getGObjectType = e_cal_component_range_kind_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Time transparency
pub const ComponentTransparency = enum(c_int) {
    none = 0,
    transparent = 1,
    @"opaque" = 2,
    unknown = 3,
    _,

    extern fn e_cal_component_transparency_get_type() usize;
    pub const getGObjectType = e_cal_component_transparency_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of calendar components to be stored by a ECalComponent, as per RFC 2445.
/// We don't put the alarm component type here since we store alarms as separate
/// structures inside the other "real" components.
pub const ComponentVType = enum(c_int) {
    no_type = 0,
    event = 1,
    todo = 2,
    journal = 3,
    freebusy = 4,
    timezone = 5,
    _,

    extern fn e_cal_component_vtype_get_type() usize;
    pub const getGObjectType = e_cal_component_vtype_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Declares interval units.
pub const IntervalUnits = enum(c_int) {
    none = -1,
    minutes = 0,
    hours = 1,
    days = 2,
    _,

    extern fn e_cal_interval_units_get_type() usize;
    pub const getGObjectType = e_cal_interval_units_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that control the behaviour of an `ecal.ClientView`.
pub const ClientViewFlags = packed struct(c_uint) {
    notify_initial: bool = false,
    _padding1: bool = false,
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

    pub const flags_none: ClientViewFlags = @bitCast(@as(c_uint, 0));
    pub const flags_notify_initial: ClientViewFlags = @bitCast(@as(c_uint, 1));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the type of modification made to a calendar
pub const ObjModType = packed struct(c_uint) {
    this: bool = false,
    this_and_prior: bool = false,
    this_and_future: bool = false,
    only_this: bool = false,
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

    pub const flags_this: ObjModType = @bitCast(@as(c_uint, 1));
    pub const flags_this_and_prior: ObjModType = @bitCast(@as(c_uint, 2));
    pub const flags_this_and_future: ObjModType = @bitCast(@as(c_uint, 4));
    pub const flags_all: ObjModType = @bitCast(@as(c_uint, 7));
    pub const flags_only_this: ObjModType = @bitCast(@as(c_uint, 8));
    extern fn e_cal_obj_mod_type_get_type() usize;
    pub const getGObjectType = e_cal_obj_mod_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Calendar operation flags, to specify behavior in certain situations. The conflict
/// resolution mode flags cannot be combined together, where the `E_CAL_OPERATION_FLAG_CONFLICT_KEEP_LOCAL`
/// is the default behavior (and it is used when no other conflict resolution flag is set).
/// The flags can be ignored when the operation or the backend don't support it.
pub const OperationFlags = packed struct(c_uint) {
    conflict_fail: bool = false,
    conflict_use_newer: bool = false,
    conflict_keep_server: bool = false,
    conflict_write_copy: bool = false,
    disable_itip_message: bool = false,
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

    pub const flags_none: OperationFlags = @bitCast(@as(c_uint, 0));
    pub const flags_conflict_fail: OperationFlags = @bitCast(@as(c_uint, 1));
    pub const flags_conflict_use_newer: OperationFlags = @bitCast(@as(c_uint, 2));
    pub const flags_conflict_keep_server: OperationFlags = @bitCast(@as(c_uint, 4));
    pub const flags_conflict_keep_local: OperationFlags = @bitCast(@as(c_uint, 0));
    pub const flags_conflict_write_copy: OperationFlags = @bitCast(@as(c_uint, 8));
    pub const flags_disable_itip_message: OperationFlags = @bitCast(@as(c_uint, 16));
    extern fn e_cal_operation_flags_get_type() usize;
    pub const getGObjectType = e_cal_operation_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Influences behaviour of `ecal.recurDescribeRecurrence`.
pub const RecurDescribeRecurrenceFlags = packed struct(c_uint) {
    prefixed: bool = false,
    fallback: bool = false,
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

    pub const flags_none: RecurDescribeRecurrenceFlags = @bitCast(@as(c_uint, 0));
    pub const flags_prefixed: RecurDescribeRecurrenceFlags = @bitCast(@as(c_uint, 1));
    pub const flags_fallback: RecurDescribeRecurrenceFlags = @bitCast(@as(c_uint, 2));
    extern fn e_cal_recur_describe_recurrence_flags_get_type() usize;
    pub const getGObjectType = e_cal_recur_describe_recurrence_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags modifying behaviour of `ecal.ReminderWatcher.describeData`.
pub const ReminderWatcherDescribeFlags = packed struct(c_uint) {
    _padding0: bool = false,
    markup: bool = false,
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

    pub const flags_none: ReminderWatcherDescribeFlags = @bitCast(@as(c_uint, 0));
    pub const flags_markup: ReminderWatcherDescribeFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Creates an ISO 8601 UTC representation from a time value.
extern fn isodate_from_time_t(p_t: std.posix.time_t) [*:0]u8;
pub const isodateFromTimeT = isodate_from_time_t;

/// Matches `tzid` against the system timezone definitions
/// and returns the matching TZID, or `NULL` if none found
extern fn e_cal_match_tzid(p_tzid: [*:0]const u8) ?[*:0]const u8;
pub const matchTzid = e_cal_match_tzid;

/// Describes some simple types of recurrences in a human-readable and localized way.
/// The `flags` influence the output format and what to do when the `icalcomp`
/// contains more complicated recurrence, some which the function cannot describe.
///
/// The `week_start_day` is used for weekly recurrences, to start the list of selected
/// days at that day.
///
/// Uses `edataserver.timeFormatDateAndTime` to format the date/time value in the string.
/// Call `ecal.recurDescribeRecurrenceEx` with a custom formatting function.
///
/// Free the returned string with `glib.free`, when no longer needed.
extern fn e_cal_recur_describe_recurrence(p_icalcomp: *icalglib.Component, p_week_start_day: glib.DateWeekday, p_flags: u32) ?[*:0]u8;
pub const recurDescribeRecurrence = e_cal_recur_describe_recurrence;

/// Describes some simple types of recurrences in a human-readable and localized way.
/// The `flags` influence the output format and what to do when the `icalcomp`
/// contains more complicated recurrence, some which the function cannot describe.
///
/// The `week_start_day` is used for weekly recurrences, to start the list of selected
/// days at that day.
///
/// If `datetime_fmt_func` is `NULL`, the `edataserver.timeFormatDateAndTime` is used
/// to format data/time value.
///
/// Free the returned string with `glib.free`, when no longer needed.
extern fn e_cal_recur_describe_recurrence_ex(p_icalcomp: *icalglib.Component, p_week_start_day: glib.DateWeekday, p_flags: u32, p_datetime_fmt_func: ?ecal.RecurFormatDateTimeFunc) ?[*:0]u8;
pub const recurDescribeRecurrenceEx = e_cal_recur_describe_recurrence_ex;

/// This recalculates the end dates for recurrence & exception rules which use
/// the COUNT property. If `refresh` is `TRUE` it will recalculate all enddates
/// for rules which use COUNT. If `refresh` is `FALSE`, it will only calculate
/// the enddate if it hasn't already been set. It returns `TRUE` if the component
/// was changed, i.e. if the component should be saved at some point.
/// We store the enddate in the `E_CAL_EVOLUTION_ENDDATE_PARAMETER` parameter of the RRULE
/// or EXRULE.
extern fn e_cal_recur_ensure_end_dates(p_comp: *ecal.Component, p_refresh: c_int, p_tz_cb: ecal.RecurResolveTimezoneCb, p_tz_cb_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const recurEnsureEndDates = e_cal_recur_ensure_end_dates;

/// Calls the given callback function for each occurrence of the event that
/// intersects the range between the given `start` and `end` times (the end time is
/// not included). Note that the occurrences may start before the given start
/// time.
///
/// If the callback routine returns FALSE the occurrence generation stops.
///
/// The start and end times are required valid times, start before end time.
///
/// The `get_tz_callback` is used to resolve references to timezones. It is passed
/// a TZID and should return the ICalTimezone * corresponding to that TZID. We need to
/// do this as we access timezones in different ways on the client & server.
///
/// The default_timezone argument is used for DTSTART or DTEND properties that
/// are DATE values or do not have a TZID (i.e. floating times).
extern fn e_cal_recur_generate_instances_sync(p_icalcomp: *icalglib.Component, p_interval_start: *icalglib.Time, p_interval_end: *icalglib.Time, p_callback: ecal.RecurInstanceCb, p_callback_user_data: ?*anyopaque, p_get_tz_callback: ecal.RecurResolveTimezoneCb, p_get_tz_callback_user_data: ?*anyopaque, p_default_timezone: *icalglib.Timezone, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const recurGenerateInstancesSync = e_cal_recur_generate_instances_sync;

extern fn e_cal_recur_get_localized_nth(p_nth: c_int) [*:0]const u8;
pub const recurGetLocalizedNth = e_cal_recur_get_localized_nth;

extern fn e_cal_recur_obtain_enddate(p_ir: *icalglib.Recurrence, p_prop: *icalglib.Property, p_zone: *icalglib.Timezone, p_convert_end_date: c_int) std.posix.time_t;
pub const recurObtainEnddate = e_cal_recur_obtain_enddate;

/// Fetches the system timezone location string.
///
/// Note: Since 3.4 the returned timezone location is either NULL or
/// an equivalent within known libical timezones.
///
/// The returned string should be freed with `glib.free`.
extern fn e_cal_system_timezone_get_location() ?[*:0]u8;
pub const systemTimezoneGetLocation = e_cal_system_timezone_get_location;

/// Adds a day onto the time, using local time.
/// Note that if clocks go forward due to daylight savings time, there are
/// some non-existent local times, so the hour may be changed to make it a
/// valid time. This also means that it may not be wise to keep calling
/// `ecal.timeAddDay` to step through a certain period - if the hour gets changed
/// to make it valid time, any further calls to `ecal.timeAddDay` will also return
/// this hour, which may not be what you want.
extern fn time_add_day(p_time: std.posix.time_t, p_days: c_int) std.posix.time_t;
pub const timeAddDay = time_add_day;

/// Adds or subtracts a number of days to/from the given time_t value, using
/// the given timezone.
/// NOTE: this function is only here to make the transition to the timezone
/// functions easier. New code should use ICalTime values and
/// `icalglib.Time.adjust` to add or subtract days, hours, minutes & seconds.
extern fn time_add_day_with_zone(p_time: std.posix.time_t, p_days: c_int, p_zone: *const icalglib.Timezone) std.posix.time_t;
pub const timeAddDayWithZone = time_add_day_with_zone;

/// Adds or subtracts a number of months to/from the given time_t value, using
/// the given timezone.
///
/// If the day would be off the end of the month (e.g. adding 1 month to
/// 30th January, would lead to an invalid day, 30th February), it moves it
/// down to the last day in the month, e.g. 28th Feb (or 29th in a leap year.)
///
/// NOTE: this function is only here to make the transition to the timezone
/// functions easier. New code should use ICalTime values and
/// `icalglib.Time.adjust` to add or subtract days, hours, minutes & seconds.
extern fn time_add_month_with_zone(p_time: std.posix.time_t, p_months: c_int, p_zone: *const icalglib.Timezone) std.posix.time_t;
pub const timeAddMonthWithZone = time_add_month_with_zone;

/// Adds the given number of weeks to a time value.
extern fn time_add_week(p_time: std.posix.time_t, p_weeks: c_int) std.posix.time_t;
pub const timeAddWeek = time_add_week;

/// Adds or subtracts a number of weeks to/from the given time_t value, using
/// the given timezone.
/// NOTE: this function is only here to make the transition to the timezone
/// functions easier. New code should use ICalTime values and
/// `icalglib.Time.adjust` to add or subtract days, hours, minutes & seconds.
extern fn time_add_week_with_zone(p_time: std.posix.time_t, p_weeks: c_int, p_zone: *const icalglib.Timezone) std.posix.time_t;
pub const timeAddWeekWithZone = time_add_week_with_zone;

/// Returns the start of the day, according to the local time.
extern fn time_day_begin(p_t: std.posix.time_t) std.posix.time_t;
pub const timeDayBegin = time_day_begin;

/// Returns the start of the day containing the given time_t, using the given
/// timezone.
/// NOTE: this function is only here to make the transition to the timezone
/// functions easier. New code should use ICalTime values and
/// `icalglib.Time.adjust` to add or subtract days, hours, minutes & seconds.
extern fn time_day_begin_with_zone(p_time: std.posix.time_t, p_zone: *const icalglib.Timezone) std.posix.time_t;
pub const timeDayBeginWithZone = time_day_begin_with_zone;

/// Returns the end of the day, according to the local time.
extern fn time_day_end(p_t: std.posix.time_t) std.posix.time_t;
pub const timeDayEnd = time_day_end;

/// Returns the end of the day containing the given time_t, using the given
/// timezone. (The end of the day is the start of the next day.)
/// NOTE: this function is only here to make the transition to the timezone
/// functions easier. New code should use ICalTime values and
/// `icalglib.Time.adjust` to add or subtract days, hours, minutes & seconds.
extern fn time_day_end_with_zone(p_time: std.posix.time_t, p_zone: *const icalglib.Timezone) std.posix.time_t;
pub const timeDayEndWithZone = time_day_end_with_zone;

/// Returns the day of the week for the specified date, 0 (Sun) to 6 (Sat).
/// For the days that were removed on the Gregorian reformation, it returns
/// Thursday. Year is the normal year, e.g. 2001. Month is 0 to 11.
extern fn time_day_of_week(p_day: c_int, p_month: c_int, p_year: c_int) c_int;
pub const timeDayOfWeek = time_day_of_week;

/// Returns the 1-based day number within the year of the specified date.
/// Year is the normal year, e.g. 2001. Month is 0 to 11.
extern fn time_day_of_year(p_day: c_int, p_month: c_int, p_year: c_int) c_int;
pub const timeDayOfYear = time_day_of_year;

/// Returns the number of days in the month. Year is the normal year, e.g. 2001.
/// Month is 0 (Jan) to 11 (Dec).
extern fn time_days_in_month(p_year: c_int, p_month: c_int) c_int;
pub const timeDaysInMonth = time_days_in_month;

/// Converts an ISO 8601 UTC time string into a time_t value.
extern fn time_from_isodate(p_str: [*:0]const u8) std.posix.time_t;
pub const timeFromIsodate = time_from_isodate;

/// Returns whether the specified year is a leap year. Year is the normal year,
/// e.g. 2001.
extern fn time_is_leap_year(p_year: c_int) c_int;
pub const timeIsLeapYear = time_is_leap_year;

/// Returns the number of leap years since year 1 up to (but not including) the
/// specified year. Year is the normal year, e.g. 2001.
extern fn time_leap_years_up_to(p_year: c_int) c_int;
pub const timeLeapYearsUpTo = time_leap_years_up_to;

/// Returns the start of the month containing the given time_t, using the given
/// timezone.
/// NOTE: this function is only here to make the transition to the timezone
/// functions easier. New code should use ICalTime values and
/// `icalglib.Time.adjust` to add or subtract days, hours, minutes & seconds.
extern fn time_month_begin_with_zone(p_time: std.posix.time_t, p_zone: *const icalglib.Timezone) std.posix.time_t;
pub const timeMonthBeginWithZone = time_month_begin_with_zone;

/// Converts a time_t value to a `glib.Date` structure using the specified timezone.
/// This is analogous to `glib.Date.setTime` but takes the timezone into account.
extern fn time_to_gdate_with_zone(p_date: *glib.Date, p_time: std.posix.time_t, p_zone: ?*const icalglib.Timezone) void;
pub const timeToGdateWithZone = time_to_gdate_with_zone;

/// Returns the start of the week containing the given time_t, using the given
/// timezone. week_start_day should use the same values as `mktime`,
/// i.e. 0 (Sun) to 6 (Sat).
/// NOTE: this function is only here to make the transition to the timezone
/// functions easier. New code should use ICalTime values and
/// `icalglib.Time.adjust` to add or subtract days, hours, minutes & seconds.
extern fn time_week_begin_with_zone(p_time: std.posix.time_t, p_week_start_day: c_int, p_zone: *const icalglib.Timezone) std.posix.time_t;
pub const timeWeekBeginWithZone = time_week_begin_with_zone;

/// Returns the start of the year containing the given time_t, using the given
/// timezone.
/// NOTE: this function is only here to make the transition to the timezone
/// functions easier. New code should use ICalTime values and
/// `icalglib.Time.adjust` to add or subtract days, hours, minutes & seconds.
extern fn time_year_begin_with_zone(p_time: std.posix.time_t, p_zone: *const icalglib.Timezone) std.posix.time_t;
pub const timeYearBeginWithZone = time_year_begin_with_zone;

/// Adds VTIMEZONE components to a VCALENDAR for all tzid's
/// in the given `icalcomp`.
extern fn e_cal_util_add_timezones_from_component(p_vcal_comp: *icalglib.Component, p_icalcomp: *icalglib.Component) void;
pub const utilAddTimezonesFromComponent = e_cal_util_add_timezones_from_component;

/// Modifies the `vtimezone` to include only subcomponents influencing
/// the passed-in time interval between `from` and `to`.
extern fn e_cal_util_clamp_vtimezone(p_vtimezone: *icalglib.Component, p_from: *const icalglib.Time, p_to: ?*const icalglib.Time) void;
pub const utilClampVtimezone = e_cal_util_clamp_vtimezone;

/// Similar to `ecal.utilClampVtimezone`, only reads the clamp
/// times from the `component`.
extern fn e_cal_util_clamp_vtimezone_by_component(p_vtimezone: *icalglib.Component, p_component: *icalglib.Component) void;
pub const utilClampVtimezoneByComponent = e_cal_util_clamp_vtimezone_by_component;

/// Searches for an X property named `x_name` within X properties
/// of `icalcomp` and returns its value as a newly allocated string.
/// Free it with `glib.free`, when no longer needed.
extern fn e_cal_util_component_dup_x_property(p_icalcomp: *icalglib.Component, p_x_name: [*:0]const u8) ?[*:0]u8;
pub const utilComponentDupXProperty = e_cal_util_component_dup_x_property;

/// Searches properties of kind `prop_kind` in the `icalcomp` and returns
/// one, which is usable for the `locale`. When `locale` is `NULL`,
/// the current locale is assumed. If no such property for the locale
/// exists either the one with no language parameter or the first
/// found is returned.
///
/// Free the returned non-NULL `ICalProperty` with `gobject.Object.unref`,
/// when no longer needed.
extern fn e_cal_util_component_find_property_for_locale(p_icalcomp: *icalglib.Component, p_prop_kind: icalglib.PropertyKind, p_locale: ?[*:0]const u8) ?*icalglib.Property;
pub const utilComponentFindPropertyForLocale = e_cal_util_component_find_property_for_locale;

/// Searches properties of kind `prop_kind` in the `icalcomp`, which can
/// be filtered by the `func`, and returns one, which is usable for the `locale`.
/// When `locale` is `NULL`, the current locale is assumed. If no such property
/// for the locale exists either the one with no language parameter or the first
/// found is returned.
///
/// The `func` is called before checking of the applicability for the `locale`.
/// When the `func` is `NULL`, all the properties of the `prop_kind` are considered.
///
/// Free the returned non-NULL `ICalProperty` with `gobject.Object.unref`,
/// when no longer needed.
extern fn e_cal_util_component_find_property_for_locale_filtered(p_icalcomp: *icalglib.Component, p_prop_kind: icalglib.PropertyKind, p_locale: ?[*:0]const u8, p_func: ?ecal.UtilFilterPropertyFunc, p_user_data: ?*anyopaque) ?*icalglib.Property;
pub const utilComponentFindPropertyForLocaleFiltered = e_cal_util_component_find_property_for_locale_filtered;

/// Searches for an X property named `x_name` within X properties
/// of `icalcomp` and returns it. Free the non-NULL object
/// with `gobject.Object.unref`, when no longer needed.
extern fn e_cal_util_component_find_x_property(p_icalcomp: *icalglib.Component, p_x_name: [*:0]const u8) ?*icalglib.Property;
pub const utilComponentFindXProperty = e_cal_util_component_find_x_property;

extern fn e_cal_util_component_get_recurid_as_string(p_icalcomp: *icalglib.Component) ?[*:0]u8;
pub const utilComponentGetRecuridAsString = e_cal_util_component_get_recurid_as_string;

/// Checks whether an `ICalComponent` has any alarm.
extern fn e_cal_util_component_has_alarms(p_icalcomp: *icalglib.Component) c_int;
pub const utilComponentHasAlarms = e_cal_util_component_has_alarms;

/// Checks if an `ICalComponent` has any attendees.
extern fn e_cal_util_component_has_attendee(p_icalcomp: *icalglib.Component) c_int;
pub const utilComponentHasAttendee = e_cal_util_component_has_attendee;

/// Checks whether an `ICalComponent` has an organizer.
extern fn e_cal_util_component_has_organizer(p_icalcomp: *icalglib.Component) c_int;
pub const utilComponentHasOrganizer = e_cal_util_component_has_organizer;

/// Returns, whether the `icalcomp` has a property of `prop_kind`. To check
/// for a specific X property use `ecal.utilComponentHasXProperty`.
extern fn e_cal_util_component_has_property(p_icalcomp: *icalglib.Component, p_prop_kind: icalglib.PropertyKind) c_int;
pub const utilComponentHasProperty = e_cal_util_component_has_property;

/// Checks if an `ICalComponent` has recurrence dates.
extern fn e_cal_util_component_has_rdates(p_icalcomp: *icalglib.Component) c_int;
pub const utilComponentHasRdates = e_cal_util_component_has_rdates;

/// Checks if an `ICalComponent` has recurrence dates or rules.
extern fn e_cal_util_component_has_recurrences(p_icalcomp: *icalglib.Component) c_int;
pub const utilComponentHasRecurrences = e_cal_util_component_has_recurrences;

/// Checks if an `ICalComponent` has recurrence rules.
extern fn e_cal_util_component_has_rrules(p_icalcomp: *icalglib.Component) c_int;
pub const utilComponentHasRrules = e_cal_util_component_has_rrules;

/// Returns, whether the `icalcomp` contains X property named `x_name`. To check
/// for standard property use `ecal.utilComponentHasProperty`.
extern fn e_cal_util_component_has_x_property(p_icalcomp: *icalglib.Component, p_x_name: [*:0]const u8) c_int;
pub const utilComponentHasXProperty = e_cal_util_component_has_x_property;

/// Checks whether an `ICalComponent` is an instance of a recurring appointment.
extern fn e_cal_util_component_is_instance(p_icalcomp: *icalglib.Component) c_int;
pub const utilComponentIsInstance = e_cal_util_component_is_instance;

/// Removes all or only the first property of kind `kind` in `icalcomp`.
extern fn e_cal_util_component_remove_property_by_kind(p_icalcomp: *icalglib.Component, p_kind: icalglib.PropertyKind, p_all: c_int) c_uint;
pub const utilComponentRemovePropertyByKind = e_cal_util_component_remove_property_by_kind;

/// Removes the first X property named `x_name` in `icalcomp`.
extern fn e_cal_util_component_remove_x_property(p_icalcomp: *icalglib.Component, p_x_name: [*:0]const u8) c_int;
pub const utilComponentRemoveXProperty = e_cal_util_component_remove_x_property;

/// Sets a value of the first X property named `x_name` in `icalcomp`,
/// if any such already exists, or adds a new property with this name
/// and value. As a special case, if `value` is `NULL`, then removes
/// the first X property named `x_name` from `icalcomp` instead.
extern fn e_cal_util_component_set_x_property(p_icalcomp: *icalglib.Component, p_x_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
pub const utilComponentSetXProperty = e_cal_util_component_set_x_property;

/// Encodes the `edataserver.ConflictResolution` into the bit-or of `ecal.OperationFlags`.
/// The returned value can be bit-or-ed with other `ecal.OperationFlags` values.
extern fn e_cal_util_conflict_resolution_to_operation_flags(p_conflict_resolution: edataserver.ConflictResolution) u32;
pub const utilConflictResolutionToOperationFlags = e_cal_util_conflict_resolution_to_operation_flags;

/// This checks that `rid` indicates a valid recurrence of `icalcomp`, and
/// if so, generates a copy of `icalcomp` containing a RECURRENCE-ID of `rid`.
///
/// Free the returned non-NULL component with `gobject.Object.unref`, when
/// no longer needed.
extern fn e_cal_util_construct_instance(p_icalcomp: *icalglib.Component, p_rid: *const icalglib.Time) ?*icalglib.Component;
pub const utilConstructInstance = e_cal_util_construct_instance;

/// Copies the `zone` together with its inner component and
/// returns it as a new `ICalTimezone` object. Free it with
/// `gobject.Object.unref`, when no longer needed.
extern fn e_cal_util_copy_timezone(p_zone: *const icalglib.Timezone) *icalglib.Timezone;
pub const utilCopyTimezone = e_cal_util_copy_timezone;

/// Compares list of categories on the `old_comp` with the list of categories
/// on the `new_comp` and fills `out_added` categories and `out_removed` categories
/// accordingly, as if the `old_comp` is replaced with the `new_comp`. When either
/// of the components is `NULL`, it's considered as having no categories set.
/// Rather than returning empty `glib.HashTable`, the return argument is set to `NULL`
/// when there are no added/removed categories.
///
/// The key of the hash table is the category string, the value is an integer (1).
/// There is used the hash table only for speed.
///
/// The returned `glib.HashTable`-s should be freed with `glib.hashTableUnref`,
/// when no longer needed.
extern fn e_cal_util_diff_categories(p_old_comp: ?*icalglib.Component, p_new_comp: ?*icalglib.Component, p_out_added: **glib.HashTable, p_out_removed: **glib.HashTable) void;
pub const utilDiffCategories = e_cal_util_diff_categories;

/// Compares two email addresses and returns whether they are equal.
/// Each address can contain a "mailto:" prefix. The two addresses
/// match only if they are non-NULL and non-empty. The address itself
/// is compared case insensitively.
extern fn e_cal_util_email_addresses_equal(p_email1: ?[*:0]const u8, p_email2: ?[*:0]const u8) c_int;
pub const utilEmailAddressesEqual = e_cal_util_email_addresses_equal;

/// Calls `func` for each category stored in the `comp`.
extern fn e_cal_util_foreach_category(p_comp: *icalglib.Component, p_func: ecal.UtilForeachCategoryFunc, p_user_data: ?*anyopaque) void;
pub const utilForeachCategory = e_cal_util_foreach_category;

/// Generates alarm instances for a calendar component. Returns the instances
/// structure, or `NULL` if no alarm instances occurred in the specified time
/// range. Free the returned structure with `ecal.ComponentAlarms.free`,
/// when no longer needed.
///
/// See `ecal.utilGenerateAlarmsForUidSync`
extern fn e_cal_util_generate_alarms_for_comp(p_comp: *ecal.Component, p_start: std.posix.time_t, p_end: std.posix.time_t, p_omit: *ecal.ComponentAlarmAction, p_resolve_tzid: ecal.RecurResolveTimezoneCb, p_user_data: ?*anyopaque, p_default_timezone: *icalglib.Timezone) ?*ecal.ComponentAlarms;
pub const utilGenerateAlarmsForComp = e_cal_util_generate_alarms_for_comp;

/// Iterates through all the components in the `comps` list and generates alarm
/// instances for them; putting them in the `comp_alarms` list. Free the `comp_alarms`
/// with g_slist_free_full (comp_alarms, e_cal_component_alarms_free);, when
/// no longer neeed.
///
/// See `ecal.utilGenerateAlarmsForUidSync`
extern fn e_cal_util_generate_alarms_for_list(p_comps: *glib.List, p_start: std.posix.time_t, p_end: std.posix.time_t, p_omit: *ecal.ComponentAlarmAction, p_comp_alarms: **glib.SList, p_resolve_tzid: ecal.RecurResolveTimezoneCb, p_user_data: ?*anyopaque, p_default_timezone: *icalglib.Timezone) c_int;
pub const utilGenerateAlarmsForList = e_cal_util_generate_alarms_for_list;

/// Generates alarm instances for a calendar component with UID `uid`,
/// which is stored within the `client`. In contrast to `ecal.utilGenerateAlarmsForComp`,
/// this function handles detached instances of recurring events properly.
///
/// The `def_reminder_before_start_seconds`, if not negative, causes addition of an alarm,
/// which will trigger a "display" alarm these seconds before start of the event.
///
/// Returns the instances structure, or `NULL` if no alarm instances occurred in the specified
/// time range. Free the returned structure with `ecal.ComponentAlarms.free`,
/// when no longer needed.
extern fn e_cal_util_generate_alarms_for_uid_sync(p_client: ?*anyopaque, p_uid: [*:0]const u8, p_start: std.posix.time_t, p_end: std.posix.time_t, p_omit: *ecal.ComponentAlarmAction, p_resolve_tzid: ecal.RecurResolveTimezoneCb, p_user_data: ?*anyopaque, p_default_timezone: *icalglib.Timezone, p_def_reminder_before_start_seconds: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*ecal.ComponentAlarms;
pub const utilGenerateAlarmsForUidSync = e_cal_util_generate_alarms_for_uid_sync;

/// Returns an attendee email, without the "mailto:" prefix, if
/// the `attendee` has it set. The email can be read from an "EMAIL"
/// parameter, if present.
extern fn e_cal_util_get_attendee_email(p_attendee: ?*const ecal.ComponentAttendee) ?[*:0]const u8;
pub const utilGetAttendeeEmail = e_cal_util_get_attendee_email;

/// Find out when the component starts and stops, being careful about
/// recurrences.
extern fn e_cal_util_get_component_occur_times(p_comp: *ecal.Component, p_out_start: *std.posix.time_t, p_out_end: *std.posix.time_t, p_tz_cb: ecal.RecurResolveTimezoneCb, p_tz_cb_data: ?*anyopaque, p_default_timezone: *const icalglib.Timezone, p_kind: icalglib.ComponentKind) void;
pub const utilGetComponentOccurTimes = e_cal_util_get_component_occur_times;

/// Returns the real name and email address of the default mail identity,
/// if available.  If no default mail identity is available, `out_name` and
/// `out_address` are set to `NULL` and the function returns `FALSE`.
extern fn e_cal_util_get_default_name_and_address(p_registry: *edataserver.SourceRegistry, p_out_name: ?*[*:0]u8, p_out_address: ?*[*:0]u8) c_int;
pub const utilGetDefaultNameAndAddress = e_cal_util_get_default_name_and_address;

/// Returns an organizer email, without the "mailto:" prefix, if
/// the `organizer` has it set. The email can be read from an "EMAIL"
/// parameter, if present.
extern fn e_cal_util_get_organizer_email(p_organizer: ?*const ecal.ComponentOrganizer) ?[*:0]const u8;
pub const utilGetOrganizerEmail = e_cal_util_get_organizer_email;

/// Returns an `prop` email, without the "mailto:" prefix, if
/// the `prop` has it set. The email can be read from an "EMAIL"
/// parameter, if present. Otherwise the `prop` can be only of
/// type `I_CAL_ORGANIZER_PROPERTY` or `I_CAL_ATTENDEE_PROPERTY`.
///
/// See also: `ecal.utilGetOrganizerEmail`, `ecal.utilGetAttendeeEmail`
extern fn e_cal_util_get_property_email(p_prop: *icalglib.Property) ?[*:0]const u8;
pub const utilGetPropertyEmail = e_cal_util_get_property_email;

/// Fetches system timezone ICalTimezone object.
///
/// The returned pointer is part of the built-in timezones and should not be freed.
extern fn e_cal_util_get_system_timezone() ?*icalglib.Timezone;
pub const utilGetSystemTimezone = e_cal_util_get_system_timezone;

/// Fetches system timezone localtion string.
extern fn e_cal_util_get_system_timezone_location() ?[*:0]u8;
pub const utilGetSystemTimezoneLocation = e_cal_util_get_system_timezone_location;

/// Checks whether the `comp` has any alarms in the given time interval.
extern fn e_cal_util_has_alarms_in_range(p_comp: *ecal.Component, p_start: std.posix.time_t, p_end: std.posix.time_t, p_omit: *ecal.ComponentAlarmAction, p_resolve_tzid: ecal.RecurResolveTimezoneCb, p_user_data: ?*anyopaque, p_default_timezone: *icalglib.Timezone) c_int;
pub const utilHasAlarmsInRange = e_cal_util_has_alarms_in_range;

/// Converts an `ICalTime` into a GLibc's struct tm.
extern fn e_cal_util_icaltime_to_tm(p_itt: *const icalglib.Time) ?*anyopaque;
pub const utilIcaltimeToTm = e_cal_util_icaltime_to_tm;

/// Converts a time value from one timezone to another, and returns a struct tm
/// representation of the time.
extern fn e_cal_util_icaltime_to_tm_with_zone(p_itt: *const icalglib.Time, p_from_zone: *const icalglib.Timezone, p_to_zone: *const icalglib.Timezone) ?*anyopaque;
pub const utilIcaltimeToTmWithZone = e_cal_util_icaltime_to_tm_with_zone;

/// Initializes properties of a recurring `vtodo`, like normalizing
/// the Due date and eventually the Start date. The function does
/// nothing when the `vtodo` is not recurring.
///
/// The function doesn't change LAST-MODIFIED neither the SEQUENCE
/// property, it's up to the caller to do it.
///
/// Note the `cal_client`, `cancellable` and `error` is used only
/// for timezone resolution. The function doesn't store the `vtodo`
/// to the `cal_client`, it only updates the `vtodo` component.
extern fn e_cal_util_init_recur_task_sync(p_vtodo: *icalglib.Component, p_cal_client: *ecal.Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const utilInitRecurTaskSync = e_cal_util_init_recur_task_sync;

/// Changes all URL attachments which point to a local file in `component`
/// to inline attachments, aka adds the file content into the `component`.
/// It also populates FILENAME parameter on the attachment.
extern fn e_cal_util_inline_local_attachments_sync(p_component: *icalglib.Component, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const utilInlineLocalAttachmentsSync = e_cal_util_inline_local_attachments_sync;

/// Returns whether the given `rid` is the first instance of
/// the recurrence defined in the `comp`.
extern fn e_cal_util_is_first_instance(p_comp: *ecal.Component, p_rid: *const icalglib.Time, p_tz_cb: ecal.RecurResolveTimezoneCb, p_tz_cb_data: ?*anyopaque) c_int;
pub const utilIsFirstInstance = e_cal_util_is_first_instance;

/// Marks the `vtodo` as complete with eventual update of other
/// properties. This is useful also for recurring tasks, for which
/// it moves the `vtodo` into the next occurrence according to
/// the recurrence rule.
///
/// When the `vtodo` is marked as completed, then the existing COMPLETED
/// date-time is preserved if exists, otherwise it's set either to `completed_time`,
/// or to the current time, when the `completed_time` is (time_t) -1.
///
/// The function doesn't change LAST-MODIFIED neither the SEQUENCE
/// property, it's up to the caller to do it.
///
/// Note the `cal_client`, `cancellable` and `error` is used only
/// for timezone resolution. The function doesn't store the `vtodo`
/// to the `cal_client`, it only updates the `vtodo` component.
extern fn e_cal_util_mark_task_complete_sync(p_vtodo: *icalglib.Component, p_completed_time: std.posix.time_t, p_cal_client: *ecal.Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const utilMarkTaskCompleteSync = e_cal_util_mark_task_complete_sync;

/// Creates a new `ICalComponent` of the specified kind. Free it
/// with `gobject.Object.unref`, when no longer needed.
extern fn e_cal_util_new_component(p_kind: icalglib.ComponentKind) *icalglib.Component;
pub const utilNewComponent = e_cal_util_new_component;

/// Creates a new VCALENDAR component. Free it with `gobject.Object.unref`,
/// when no longer needed.
extern fn e_cal_util_new_top_level() *icalglib.Component;
pub const utilNewTopLevel = e_cal_util_new_top_level;

/// Makes sure the `ttuntil` value matches the value type with
/// the DTSTART value, as required by RFC 5545 section 3.3.10.
/// Uses `tz_cb` with `tz_cb_data` to resolve time zones when needed.
extern fn e_cal_util_normalize_rrule_until_value(p_icalcomp: *icalglib.Component, p_ttuntil: *icalglib.Time, p_tz_cb: ecal.RecurResolveTimezoneCb, p_tz_cb_data: ?*anyopaque) void;
pub const utilNormalizeRruleUntilValue = e_cal_util_normalize_rrule_until_value;

/// Decodes the `edataserver.ConflictResolution` from the bit-or of `ecal.OperationFlags`.
extern fn e_cal_util_operation_flags_to_conflict_resolution(p_flags: u32) edataserver.ConflictResolution;
pub const utilOperationFlagsToConflictResolution = e_cal_util_operation_flags_to_conflict_resolution;

/// Parses the given file, and, if it contains a valid iCalendar object,
/// parse it and return a new `ICalComponent`.
///
/// Free the returned non-NULL component with `gobject.Object.unref`, when no longer needed.
extern fn e_cal_util_parse_ics_file(p_filename: [*:0]const u8) ?*icalglib.Component;
pub const utilParseIcsFile = e_cal_util_parse_ics_file;

/// Parses an iCalendar string and returns a new `ICalComponent` representing
/// that string. Note that this function deals with multiple VCALENDAR's in the
/// string, something that Mozilla used to do and which libical does not
/// support.
///
/// Free the returned non-NULL component with `gobject.Object.unref`, when no longer needed.
extern fn e_cal_util_parse_ics_string(p_string: [*:0]const u8) ?*icalglib.Component;
pub const utilParseIcsString = e_cal_util_parse_ics_string;

/// Converts a translated priority string to an iCalendar priority value.
extern fn e_cal_util_priority_from_string(p_string: [*:0]const u8) c_int;
pub const utilPriorityFromString = e_cal_util_priority_from_string;

/// Converts an iCalendar PRIORITY value to a translated string. Any unknown
/// priority value (i.e. not 0-9) will be returned as "" (undefined).
extern fn e_cal_util_priority_to_string(p_priority: c_int) [*:0]const u8;
pub const utilPriorityToString = e_cal_util_priority_to_string;

/// Returns, whether the `prop` has a parameter of `param_kind`.
extern fn e_cal_util_property_has_parameter(p_prop: *icalglib.Property, p_param_kind: icalglib.ParameterKind) c_int;
pub const utilPropertyHasParameter = e_cal_util_property_has_parameter;

/// Removes one or more instances from `icalcomp` according to `rid` and `mod`.
extern fn e_cal_util_remove_instances(p_icalcomp: *icalglib.Component, p_rid: *const icalglib.Time, p_mod: ecal.ObjModType) void;
pub const utilRemoveInstances = e_cal_util_remove_instances;

/// Removes one or more instances from `icalcomp` according to `rid` and `mod`.
/// Uses `tz_cb` with `tz_cb_data` to resolve time zones when needed.
extern fn e_cal_util_remove_instances_ex(p_icalcomp: *icalglib.Component, p_rid: *const icalglib.Time, p_mod: ecal.ObjModType, p_tz_cb: ecal.RecurResolveTimezoneCb, p_tz_cb_data: ?*anyopaque) void;
pub const utilRemoveInstancesEx = e_cal_util_remove_instances_ex;

/// Converts time, in seconds, into a string representation readable by humans
/// and localized into the current locale. This can be used to convert event
/// duration to string or similar use cases.
///
/// Free the returned string with `glib.free`, when no longer needed.
extern fn e_cal_util_seconds_to_string(p_seconds: i64) [*:0]u8;
pub const utilSecondsToString = e_cal_util_seconds_to_string;

/// Sets the ACKNOWLEDGED property on the `component`'s alarm with UID `auid`
/// to the time `when` (in UTC), or to the current time, when the `when` is 0.
extern fn e_cal_util_set_alarm_acknowledged(p_component: *ecal.Component, p_auid: [*:0]const u8, p_when: i64) c_int;
pub const utilSetAlarmAcknowledged = e_cal_util_set_alarm_acknowledged;

/// Splits a recurring `icalcomp` into two at time `rid`. The returned `ICalComponent`
/// is modified `icalcomp` which contains recurrences beginning at `rid`, inclusive.
/// The instance identified by `rid` should exist. The `master_dtstart` can be
/// a null time, then it is read from the `icalcomp`.
///
/// Use `ecal.utilRemoveInstancesEx` with E_CAL_OBJ_MOD_THIS_AND_FUTURE mode
/// on the `icalcomp` to remove the overlapping interval from it, if needed.
///
/// Free the returned non-NULL component with `gobject.Object.unref`, when
/// done with it.
extern fn e_cal_util_split_at_instance(p_icalcomp: *icalglib.Component, p_rid: *const icalglib.Time, p_master_dtstart: ?*const icalglib.Time) ?*icalglib.Component;
pub const utilSplitAtInstance = e_cal_util_split_at_instance;

/// Splits a recurring `icalcomp` into two at time `rid`. The returned `ICalComponent`
/// is modified `icalcomp` which contains recurrences beginning at `rid`, inclusive.
/// The instance identified by `rid` should exist. The `master_dtstart` can be
/// a null time, then it is read from the `icalcomp`.
///
/// Uses `tz_cb` with `tz_cb_data` to resolve time zones when needed.
///
/// Use `ecal.utilRemoveInstancesEx` with E_CAL_OBJ_MOD_THIS_AND_FUTURE mode
/// on the `icalcomp` to remove the overlapping interval from it, if needed.
///
/// Free the returned non-NULL component with `gobject.Object.unref`, when
/// done with it.
extern fn e_cal_util_split_at_instance_ex(p_icalcomp: *icalglib.Component, p_rid: *const icalglib.Time, p_master_dtstart: ?*const icalglib.Time, p_tz_cb: ecal.RecurResolveTimezoneCb, p_tz_cb_data: ?*anyopaque) ?*icalglib.Component;
pub const utilSplitAtInstanceEx = e_cal_util_split_at_instance_ex;

/// Strips "mailto:" prefix from the `address`, if present. The returned
/// pointer is either the `address` or a shifted position within the `address`.
extern fn e_cal_util_strip_mailto(p_address: ?[*:0]const u8) [*:0]const u8;
pub const utilStripMailto = e_cal_util_strip_mailto;

/// Converts a struct tm into an `ICalTime`. Free the returned object
/// with `gobject.Object.unref`, when no longer needed.
extern fn e_cal_util_tm_to_icaltime(p_tm: ?*anyopaque, p_is_date: c_int) *icalglib.Time;
pub const utilTmToIcaltime = e_cal_util_tm_to_icaltime;

/// A function used to filter which parameters should be added to the bag,
/// when filling it with `ecal.ComponentParameterBag.newFromProperty`
/// and `ecal.ComponentParameterBag.setFromProperty`.
pub const ComponentParameterBagFilterFunc = *const fn (p_parameter: *icalglib.Parameter, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// A function used to filter which properties should be added to the bag,
/// when filling it with `ecal.ComponentPropertyBag.newFromComponent`
/// and `ecal.ComponentPropertyBag.setFromComponent`.
pub const ComponentPropertyBagFilterFunc = *const fn (p_property: *icalglib.Property, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Format the date/time value from `itt` into `buffer`, whose size cannot
/// exceed `buffer_size` letters.
pub const RecurFormatDateTimeFunc = *const fn (p_itt: *icalglib.Time, p_buffer: [*:0]u8, p_buffer_size: c_int) callconv(.c) void;

/// Callback used by `ecal.recurGenerateInstancesSync`, called
/// for each instance of a (recurring) component within given time range.
pub const RecurInstanceCb = *const fn (p_icomp: *icalglib.Component, p_instance_start: *icalglib.Time, p_instance_end: *icalglib.Time, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Resolve timezone by its ID provided as `tzid`. The returned object,
/// if not `NULL`, is owned by the callback implementation and should
/// not be freed.
pub const RecurResolveTimezoneCb = *const fn (p_tzid: [*:0]const u8, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?*icalglib.Timezone;

/// Function used to determine whether the given property `prop`
/// should be considered.
pub const UtilFilterPropertyFunc = *const fn (p_prop: *icalglib.Property, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Function called for each non-empty category from `ecal.utilForeachCategory`.
/// The `func` can assume owenrship of the `inout_category` content, in which case
/// it should also set its content to `NULL`, to avoid free of it. The string itself,
/// if taken, should be freed with `glib.free`, when no longer needed.
pub const UtilForeachCategoryFunc = *const fn (p_comp: *icalglib.Component, p_inout_category: *[*:0]u8, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// An email address preferred for e-mail reminders by the calendar.
pub const BACKEND_PROPERTY_ALARM_EMAIL_ADDRESS = "alarm-email-address";
/// An email address associated with the calendar.
pub const BACKEND_PROPERTY_CAL_EMAIL_ADDRESS = "cal-email-address";
/// A default object for the calendar. Calendars use VEVENT, memo lists VJOURNAL
/// and task lists VTODO, which can have prefilled values by the backend.
pub const BACKEND_PROPERTY_DEFAULT_OBJECT = "default-object";
/// The current overall revision string, this can be used as
/// a quick check to see if data has changed at all since the
/// last time the calendar revision was observed.
pub const BACKEND_PROPERTY_REVISION = "revision";
/// Extension property for alarm components so that we can reference them by UID.
pub const EVOLUTION_ALARM_UID_PROPERTY = "X-EVOLUTION-ALARM-UID";
/// The X parameter name being used to store the enddate in RRULE and EXRULE properties.
pub const EVOLUTION_ENDDATE_PARAMETER = "X-EVOLUTION-ENDDATE";
pub const LIBICAL_GLIB_UNSTABLE_API = 1;
/// Flag indicating that the backend supports alarm description
pub const STATIC_CAPABILITY_ALARM_DESCRIPTION = "alarm-description";
/// Let the client know that it should store All Day event times as time
/// with a time zone, rather than as a date.
pub const STATIC_CAPABILITY_ALL_DAY_EVENT_AS_TIME = "all-day-event-as-time";
/// Flag indicating that the backend supports bulk additions.
pub const STATIC_CAPABILITY_BULK_ADDS = "bulk-adds";
/// Flag indicating that the backend supports bulk modifications.
pub const STATIC_CAPABILITY_BULK_MODIFIES = "bulk-modifies";
/// Flag indicating that the backend supports bulk removals.
pub const STATIC_CAPABILITY_BULK_REMOVES = "bulk-removes";
/// When the capability is set, the client supports storing color
/// for individual components.
pub const STATIC_CAPABILITY_COMPONENT_COLOR = "component-color";
pub const STATIC_CAPABILITY_CREATE_MESSAGES = "create-messages";
pub const STATIC_CAPABILITY_DELEGATE_SUPPORTED = "delegate-support";
pub const STATIC_CAPABILITY_DELEGATE_TO_MANY = "delegate-to-many";
pub const STATIC_CAPABILITY_HAS_UNACCEPTED_MEETING = "has-unaccepted-meeting";
/// Set, when the backend supports `E_CAL_STATIC_CAPABILITY_SAVE_SCHEDULES` and
/// it can suppress iTip message on component removal. The capability should
/// be ignored when the `E_CAL_STATIC_CAPABILITY_SAVE_SCHEDULES` is not present.
///
/// The backend checks `E_CAL_OPERATION_FLAG_DISABLE_ITIP_MESSAGE` flag when these
/// capabilities are present and sends or does not send iTip message accordingly.
pub const STATIC_CAPABILITY_ITIP_SUPPRESS_ON_REMOVE_SUPPORTED = "itip-suppress-on-remove-supported";
/// Flag indicating that the backend does not support alarm after start the event
pub const STATIC_CAPABILITY_NO_ALARM_AFTER_START = "no-alarm-after-start";
pub const STATIC_CAPABILITY_NO_ALARM_REPEAT = "no-alarm-repeat";
pub const STATIC_CAPABILITY_NO_AUDIO_ALARMS = "no-audio-alarms";
pub const STATIC_CAPABILITY_NO_CONV_TO_ASSIGN_TASK = "no-conv-to-assign-task";
pub const STATIC_CAPABILITY_NO_CONV_TO_RECUR = "no-conv-to-recur";
pub const STATIC_CAPABILITY_NO_DISPLAY_ALARMS = "no-display-alarms";
pub const STATIC_CAPABILITY_NO_EMAIL_ALARMS = "no-email-alarms";
pub const STATIC_CAPABILITY_NO_GEN_OPTIONS = "no-general-options";
pub const STATIC_CAPABILITY_NO_MEMO_START_DATE = "no-memo-start-date";
pub const STATIC_CAPABILITY_NO_ORGANIZER = "no-organizer";
pub const STATIC_CAPABILITY_NO_PROCEDURE_ALARMS = "no-procedure-alarms";
pub const STATIC_CAPABILITY_NO_TASK_ASSIGNMENT = "no-task-assignment";
pub const STATIC_CAPABILITY_NO_THISANDFUTURE = "no-thisandfuture";
pub const STATIC_CAPABILITY_NO_THISANDPRIOR = "no-thisandprior";
pub const STATIC_CAPABILITY_NO_TRANSPARENCY = "no-transparency";
pub const STATIC_CAPABILITY_ONE_ALARM_ONLY = "one-alarm-only";
pub const STATIC_CAPABILITY_ORGANIZER_MUST_ACCEPT = "organizer-must-accept";
pub const STATIC_CAPABILITY_ORGANIZER_MUST_ATTEND = "organizer-must-attend";
pub const STATIC_CAPABILITY_ORGANIZER_NOT_EMAIL_ADDRESS = "organizer-not-email-address";
pub const STATIC_CAPABILITY_RECURRENCES_NO_MASTER = "recurrences-no-master-object";
pub const STATIC_CAPABILITY_REFRESH_SUPPORTED = "refresh-supported";
pub const STATIC_CAPABILITY_REMOVE_ALARMS = "remove-alarms";
/// FIXME: Document me.
pub const STATIC_CAPABILITY_REMOVE_ONLY_THIS = "remove-only-this";
pub const STATIC_CAPABILITY_REQ_SEND_OPTIONS = "require-send-options";
/// Set, when the backend supports retract. That's a way to ask for a meeting
/// deletion with a comment, which is stored in a component as the COMMENT property.
pub const STATIC_CAPABILITY_RETRACT_SUPPORTED = "retract-supported";
pub const STATIC_CAPABILITY_SAVE_SCHEDULES = "save-schedules";
/// When the capability is set, the backend handles only simple memos,
/// which means it stores only memo description. The summary can be changed
/// by the backend, if needed.
pub const STATIC_CAPABILITY_SIMPLE_MEMO = "simple-memo";
/// Similar to the `E_CAL_STATIC_CAPABILITY_SIMPLE_MEMO`, except the backend stores
/// the description and the summary separately.
pub const STATIC_CAPABILITY_SIMPLE_MEMO_WITH_SUMMARY = "simple-memo-with-summary";
/// When the capability is set, the client can store and provide recurring
/// tasks, otherwise it cannot.
pub const STATIC_CAPABILITY_TASK_CAN_RECUR = "task-can-recur";
/// Let the client know that the Task Start date, Due date and Completed date
/// can be entered only as dates. When the capability is not set, then these
/// can be date and time.
pub const STATIC_CAPABILITY_TASK_DATE_ONLY = "task-date-only";
/// Set, when the backend supports ESTIMATED-DURATION property for tasks.
pub const STATIC_CAPABILITY_TASK_ESTIMATED_DURATION = "task-estimated-duration";
/// When the capability is set, the backend handles task recurrence
/// completion on its own. This does not imply E_CAL_STATIC_CAPABILITY_TASK_CAN_RECUR.
pub const STATIC_CAPABILITY_TASK_HANDLE_RECUR = "task-handle-recur";
/// When the capability is set, the client cannot store reminders
/// on tasks, otherwise it can.
pub const STATIC_CAPABILITY_TASK_NO_ALARM = "task-no-alarm";
/// Set, when the backend can save meetings only if the organizer is
/// the calendar user.
pub const STATIC_CAPABILITY_USER_IS_ORGANIZER_ONLY = "user-is-organizer-only";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
