pub const ext = @import("ext.zig");
const edataserver = @This();

const std = @import("std");
const compat = @import("compat");
const libxml2 = @import("libxml22");
const soup = @import("soup3");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const json = @import("json1");
const camel = @import("camel1");
/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const Client = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edataserver.ClientClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.ClientPrivate,

    pub const virtual_methods = struct {
        pub const backend_died = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Client.Class, p_class).f_backend_died.?(gobject.ext.as(Client, p_client));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_backend_died = @ptrCast(p_implementation);
            }
        };

        pub const backend_error = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error_msg: [*:0]const u8) void {
                return gobject.ext.as(Client.Class, p_class).f_backend_error.?(gobject.ext.as(Client, p_client), p_error_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error_msg: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_backend_error = @ptrCast(p_implementation);
            }
        };

        pub const backend_property_changed = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8) void {
                return gobject.ext.as(Client.Class, p_class).f_backend_property_changed.?(gobject.ext.as(Client, p_client), p_prop_name, p_prop_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_backend_property_changed = @ptrCast(p_implementation);
            }
        };

        /// Queries `client`'s backend for a property of name `prop_name`.
        /// The call is finished by `edataserver.Client.getBackendPropertyFinish`
        /// from the `callback`.
        pub const get_backend_property = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Client.Class, p_class).f_get_backend_property.?(gobject.ext.as(Client, p_client), p_prop_name, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_get_backend_property = @ptrCast(p_implementation);
            }
        };

        /// Finishes previous call of `edataserver.Client.getBackendProperty`.
        pub const get_backend_property_finish = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_prop_value: *[*:0]u8, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_get_backend_property_finish.?(gobject.ext.as(Client, p_client), p_result, p_prop_value, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_prop_value: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_get_backend_property_finish = @ptrCast(p_implementation);
            }
        };

        /// Queries `client`'s backend for a property of name `prop_name`.
        pub const get_backend_property_sync = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_prop_value: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_get_backend_property_sync.?(gobject.ext.as(Client, p_client), p_prop_name, p_prop_value, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_prop_value: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_get_backend_property_sync = @ptrCast(p_implementation);
            }
        };

        pub const get_dbus_proxy = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gio.DBusProxy {
                return gobject.ext.as(Client.Class, p_class).f_get_dbus_proxy.?(gobject.ext.as(Client, p_client));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gio.DBusProxy) void {
                gobject.ext.as(Client.Class, p_class).f_get_dbus_proxy = @ptrCast(p_implementation);
            }
        };

        /// Opens the `client`, making it ready for queries and other operations.
        /// The call is finished by `edataserver.Client.openFinish` from the `callback`.
        pub const open = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_only_if_exists: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Client.Class, p_class).f_open.?(gobject.ext.as(Client, p_client), p_only_if_exists, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_only_if_exists: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_open = @ptrCast(p_implementation);
            }
        };

        /// Finishes previous call of `edataserver.Client.open`.
        pub const open_finish = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_open_finish.?(gobject.ext.as(Client, p_client), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_open_finish = @ptrCast(p_implementation);
            }
        };

        /// Opens the `client`, making it ready for queries and other operations.
        pub const open_sync = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_only_if_exists: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_open_sync.?(gobject.ext.as(Client, p_client), p_only_if_exists, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_only_if_exists: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_open_sync = @ptrCast(p_implementation);
            }
        };

        pub const opened = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: *const glib.Error) void {
                return gobject.ext.as(Client.Class, p_class).f_opened.?(gobject.ext.as(Client, p_client), p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: *const glib.Error) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_opened = @ptrCast(p_implementation);
            }
        };

        /// Initiates refresh on the `client`. Finishing the method doesn't mean
        /// that the refresh is done, backend only notifies whether it started
        /// refreshing or not. Use `edataserver.Client.checkRefreshSupported` to check
        /// whether the backend supports this method.
        /// The call is finished by `edataserver.Client.refreshFinish` from the `callback`.
        pub const refresh = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Client.Class, p_class).f_refresh.?(gobject.ext.as(Client, p_client), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_refresh = @ptrCast(p_implementation);
            }
        };

        /// Finishes previous call of `edataserver.Client.refresh`.
        pub const refresh_finish = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_refresh_finish.?(gobject.ext.as(Client, p_client), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_refresh_finish = @ptrCast(p_implementation);
            }
        };

        /// Initiates refresh on the `client`. Finishing the method doesn't mean
        /// that the refresh is done, backend only notifies whether it started
        /// refreshing or not. Use `edataserver.Client.checkRefreshSupported` to check
        /// whether the backend supports this method.
        pub const refresh_sync = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_refresh_sync.?(gobject.ext.as(Client, p_client), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_refresh_sync = @ptrCast(p_implementation);
            }
        };

        /// Removes the backing data for this `edataserver.Client`. For example, with the file
        /// backend this deletes the database file. You cannot get it back!
        /// The call is finished by `edataserver.Client.removeFinish` from the `callback`.
        pub const remove = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Client.Class, p_class).f_remove.?(gobject.ext.as(Client, p_client), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_remove = @ptrCast(p_implementation);
            }
        };

        /// Finishes previous call of `edataserver.Client.remove`.
        pub const remove_finish = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_remove_finish.?(gobject.ext.as(Client, p_client), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_remove_finish = @ptrCast(p_implementation);
            }
        };

        /// Removes the backing data for this `edataserver.Client`. For example, with the file
        /// backend this deletes the database file. You cannot get it back!
        pub const remove_sync = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_remove_sync.?(gobject.ext.as(Client, p_client), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_remove_sync = @ptrCast(p_implementation);
            }
        };

        /// Initiates retrieval of capabilities on the `client`. This is usually
        /// required only once, after the `client` is opened. The returned value
        /// is cached and any subsequent call of `edataserver.Client.getCapabilities` and
        /// `edataserver.Client.checkCapability` is using the cached value.
        /// The call is finished by `edataserver.Client.retrieveCapabilitiesFinish`
        /// from the `callback`.
        pub const retrieve_capabilities = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Client.Class, p_class).f_retrieve_capabilities.?(gobject.ext.as(Client, p_client), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_retrieve_capabilities = @ptrCast(p_implementation);
            }
        };

        /// Finishes previous call of `edataserver.Client.retrieveCapabilities`.
        /// Returned value of `capabilities` should be freed with `glib.free`,
        /// when no longer needed.
        pub const retrieve_capabilities_finish = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_capabilities: *[*:0]u8, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_retrieve_capabilities_finish.?(gobject.ext.as(Client, p_client), p_result, p_capabilities, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_capabilities: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_retrieve_capabilities_finish = @ptrCast(p_implementation);
            }
        };

        /// Initiates retrieval of capabilities on the `client`. This is usually
        /// required only once, after the `client` is opened. The returned value
        /// is cached and any subsequent call of `edataserver.Client.getCapabilities` and
        /// `edataserver.Client.checkCapability` is using the cached value. Returned value
        /// of `capabilities` should be freed with `glib.free`, when no longer needed.
        pub const retrieve_capabilities_sync = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_capabilities: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_retrieve_capabilities_sync.?(gobject.ext.as(Client, p_client), p_capabilities, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_capabilities: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_retrieve_capabilities_sync = @ptrCast(p_implementation);
            }
        };

        /// Retrieves `client` properties to match server-side values, without waiting
        /// for the D-Bus property change notifications delivery.
        ///
        /// If an error occurs, the function sets `error` and returns `FALSE`.
        pub const retrieve_properties_sync = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_retrieve_properties_sync.?(gobject.ext.as(Client, p_client), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_retrieve_properties_sync = @ptrCast(p_implementation);
            }
        };

        /// Sets `client`'s backend property of name `prop_name`
        /// to value `prop_value`. The call is finished
        /// by `edataserver.Client.setBackendPropertyFinish` from the `callback`.
        pub const set_backend_property = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Client.Class, p_class).f_set_backend_property.?(gobject.ext.as(Client, p_client), p_prop_name, p_prop_value, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_set_backend_property = @ptrCast(p_implementation);
            }
        };

        /// Finishes previous call of `edataserver.Client.setBackendProperty`.
        pub const set_backend_property_finish = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_set_backend_property_finish.?(gobject.ext.as(Client, p_client), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_set_backend_property_finish = @ptrCast(p_implementation);
            }
        };

        /// Sets `client`'s backend property of name `prop_name`
        /// to value `prop_value`.
        pub const set_backend_property_sync = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Client.Class, p_class).f_set_backend_property_sync.?(gobject.ext.as(Client, p_client), p_prop_name, p_prop_value, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Client.Class, p_class).f_set_backend_property_sync = @ptrCast(p_implementation);
            }
        };

        /// Unwraps D-Bus error to local error. `dbus_error` is automatically freed.
        /// `dbus_erorr` and `out_error` can point to the same variable.
        pub const unwrap_dbus_error = struct {
            pub fn call(p_class: anytype, p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_dbus_error: *glib.Error, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(Client.Class, p_class).f_unwrap_dbus_error.?(gobject.ext.as(Client, p_client), p_dbus_error, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_client: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_dbus_error: *glib.Error, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(Client.Class, p_class).f_unwrap_dbus_error = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The capabilities of this client
        pub const capabilities = struct {
            pub const name = "capabilities";

            pub const Type = ?*anyopaque;
        };

        /// The main loop context in which notifications for
        /// this client will be delivered.
        pub const main_context = struct {
            pub const name = "main-context";

            pub const Type = ?*glib.MainContext;
        };

        /// Whether this client's backing data is online.
        pub const online = struct {
            pub const name = "online";

            pub const Type = c_int;
        };

        /// Whether this client is open and ready to use.
        pub const opened = struct {
            pub const name = "opened";

            pub const Type = c_int;
        };

        /// Whether this client's backing data is readonly.
        pub const readonly = struct {
            pub const name = "readonly";

            pub const Type = c_int;
        };

        /// The `edataserver.Source` for which this client was created.
        pub const source = struct {
            pub const name = "source";

            pub const Type = ?*edataserver.Source;
        };
    };

    pub const signals = struct {
        pub const backend_died = struct {
            pub const name = "backend-died";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Client, p_instance))),
                    gobject.signalLookup("backend-died", Client.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const backend_error = struct {
            pub const name = "backend-error";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Client, p_instance))),
                    gobject.signalLookup("backend-error", Client.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const backend_property_changed = struct {
            pub const name = "backend-property-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, p_p0: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Client, p_instance))),
                    gobject.signalLookup("backend-property-changed", Client.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const opened = struct {
            pub const name = "opened";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *glib.Error, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Client, p_instance))),
                    gobject.signalLookup("opened", Client.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn e_client_error_create(p_code: edataserver.ClientError, p_custom_msg: ?[*:0]const u8) *glib.Error;
    pub const errorCreate = e_client_error_create;

    /// Similar as `edataserver.Client.errorCreate`, only here, instead of custom_msg,
    /// is used a `printf` format to create a custom message for the error.
    extern fn e_client_error_create_fmt(p_code: edataserver.ClientError, p_format: ?[*:0]const u8, ...) *glib.Error;
    pub const errorCreateFmt = e_client_error_create_fmt;

    extern fn e_client_error_quark() glib.Quark;
    pub const errorQuark = e_client_error_quark;

    /// Get localized human readable description of the given error code.
    extern fn e_client_error_to_string(p_code: edataserver.ClientError) [*:0]const u8;
    pub const errorToString = e_client_error_to_string;

    /// Copies a `glib.SList` of `gobject.Object`<!-- -->s to the end of `copy_to`.
    extern fn e_client_util_copy_object_slist(p_copy_to: ?*glib.SList, p_objects: *const glib.SList) *glib.SList;
    pub const utilCopyObjectSlist = e_client_util_copy_object_slist;

    /// Copies the `glib.SList` of strings to the end of `copy_to`.
    extern fn e_client_util_copy_string_slist(p_copy_to: ?*glib.SList, p_strings: *const glib.SList) *glib.SList;
    pub const utilCopyStringSlist = e_client_util_copy_string_slist;

    /// Calls `gobject.Object.unref` on each member of `objects` and then frees `objects`
    /// itself.
    extern fn e_client_util_free_object_slist(p_objects: *glib.SList) void;
    pub const utilFreeObjectSlist = e_client_util_free_object_slist;

    /// Frees memory previously allocated by `edataserver.Client.utilStrvToSlist`.
    extern fn e_client_util_free_string_slist(p_strings: *glib.SList) void;
    pub const utilFreeStringSlist = e_client_util_free_string_slist;

    /// Parses comma-separated list of values into `glib.SList`.
    extern fn e_client_util_parse_comma_strings(p_strings: [*:0]const u8) *glib.SList;
    pub const utilParseCommaStrings = e_client_util_parse_comma_strings;

    /// Convert a list of strings into a `NULL`-terminated array of strings.
    extern fn e_client_util_slist_to_strv(p_strings: *const glib.SList) [*][*:0]u8;
    pub const utilSlistToStrv = e_client_util_slist_to_strv;

    /// Convert a `NULL`-terminated array of strings to a list of strings.
    extern fn e_client_util_strv_to_slist(p_strv: *const [*:0]const u8) *glib.SList;
    pub const utilStrvToSlist = e_client_util_strv_to_slist;

    /// The function takes a `dbus_error` and tries to find a match in `known_errors`
    /// for it, if it is a G_IO_ERROR, G_IO_ERROR_DBUS_ERROR. If it is anything else
    /// then the `dbus_error` is moved to `client_error`.
    ///
    /// The `fail_when_none_matched` influences behaviour. If it's `TRUE`, and none of
    /// `known_errors` matches, or this is not a G_IO_ERROR_DBUS_ERROR, then `FALSE`
    /// is returned and the `client_error` is left without change. Otherwise, the
    /// `fail_when_none_matched` is `FALSE`, the error is always processed and will
    /// result in E_CLIENT_ERROR, E_CLIENT_ERROR_OTHER_ERROR if none of `known_error`
    /// matches.
    extern fn e_client_util_unwrap_dbus_error(p_dbus_error: *glib.Error, p_client_error: **glib.Error, p_known_errors: *const edataserver.ClientErrorsList, p_known_errors_count: c_uint, p_known_errors_domain: glib.Quark, p_fail_when_none_matched: c_int) c_int;
    pub const utilUnwrapDbusError = e_client_util_unwrap_dbus_error;

    /// Cancels all pending operations started on `client`.
    extern fn e_client_cancel_all(p_client: *Client) void;
    pub const cancelAll = e_client_cancel_all;

    /// Check if backend supports particular capability.
    /// To get all capabilities use `edataserver.Client.getCapabilities`.
    extern fn e_client_check_capability(p_client: *Client, p_capability: [*:0]const u8) c_int;
    pub const checkCapability = e_client_check_capability;

    /// Checks whether a client supports explicit refreshing
    /// (see `edataserver.Client.refresh`).
    extern fn e_client_check_refresh_supported(p_client: *Client) c_int;
    pub const checkRefreshSupported = e_client_check_refresh_supported;

    /// Returns a D-Bus bus name that will be used to connect the
    /// client to the backend subprocess.
    extern fn e_client_dup_bus_name(p_client: *Client) [*:0]u8;
    pub const dupBusName = e_client_dup_bus_name;

    /// Queries `client`'s backend for a property of name `prop_name`.
    /// The call is finished by `edataserver.Client.getBackendPropertyFinish`
    /// from the `callback`.
    extern fn e_client_get_backend_property(p_client: *Client, p_prop_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getBackendProperty = e_client_get_backend_property;

    /// Finishes previous call of `edataserver.Client.getBackendProperty`.
    extern fn e_client_get_backend_property_finish(p_client: *Client, p_result: *gio.AsyncResult, p_prop_value: *[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const getBackendPropertyFinish = e_client_get_backend_property_finish;

    /// Queries `client`'s backend for a property of name `prop_name`.
    extern fn e_client_get_backend_property_sync(p_client: *Client, p_prop_name: [*:0]const u8, p_prop_value: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getBackendPropertySync = e_client_get_backend_property_sync;

    /// Get list of strings with capabilities advertised by a backend.
    /// This list, together with inner strings, is owned by the `client`.
    /// To check for individual capabilities use `edataserver.Client.checkCapability`.
    extern fn e_client_get_capabilities(p_client: *Client) *const glib.SList;
    pub const getCapabilities = e_client_get_capabilities;

    /// Get the `edataserver.Source` that this client has assigned.
    extern fn e_client_get_source(p_client: *Client) *edataserver.Source;
    pub const getSource = e_client_get_source;

    /// Check if this `client` is connected.
    extern fn e_client_is_online(p_client: *Client) c_int;
    pub const isOnline = e_client_is_online;

    /// Check if this `client` is fully opened. This includes
    /// everything from `edataserver.Client.open` call up to the authentication,
    /// if required by a backend. Client cannot do any other operation
    /// during the opening phase except of authenticate or cancel it.
    /// Every other operation results in an `E_CLIENT_ERROR_BUSY` error.
    extern fn e_client_is_opened(p_client: *Client) c_int;
    pub const isOpened = e_client_is_opened;

    /// Check if this `client` is read-only.
    extern fn e_client_is_readonly(p_client: *Client) c_int;
    pub const isReadonly = e_client_is_readonly;

    /// Opens the `client`, making it ready for queries and other operations.
    /// The call is finished by `edataserver.Client.openFinish` from the `callback`.
    extern fn e_client_open(p_client: *Client, p_only_if_exists: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const open = e_client_open;

    /// Finishes previous call of `edataserver.Client.open`.
    extern fn e_client_open_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const openFinish = e_client_open_finish;

    /// Opens the `client`, making it ready for queries and other operations.
    extern fn e_client_open_sync(p_client: *Client, p_only_if_exists: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const openSync = e_client_open_sync;

    /// Returns the `glib.MainContext` on which event sources for `client` are to
    /// be attached.
    ///
    /// The returned `glib.MainContext` is referenced for thread-safety and must be
    /// unreferenced with `glib.MainContext.unref` when finished with it.
    extern fn e_client_ref_main_context(p_client: *Client) *glib.MainContext;
    pub const refMainContext = e_client_ref_main_context;

    /// Initiates refresh on the `client`. Finishing the method doesn't mean
    /// that the refresh is done, backend only notifies whether it started
    /// refreshing or not. Use `edataserver.Client.checkRefreshSupported` to check
    /// whether the backend supports this method.
    /// The call is finished by `edataserver.Client.refreshFinish` from the `callback`.
    extern fn e_client_refresh(p_client: *Client, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const refresh = e_client_refresh;

    /// Finishes previous call of `edataserver.Client.refresh`.
    extern fn e_client_refresh_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const refreshFinish = e_client_refresh_finish;

    /// Initiates refresh on the `client`. Finishing the method doesn't mean
    /// that the refresh is done, backend only notifies whether it started
    /// refreshing or not. Use `edataserver.Client.checkRefreshSupported` to check
    /// whether the backend supports this method.
    extern fn e_client_refresh_sync(p_client: *Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshSync = e_client_refresh_sync;

    /// Removes the backing data for this `edataserver.Client`. For example, with the file
    /// backend this deletes the database file. You cannot get it back!
    /// The call is finished by `edataserver.Client.removeFinish` from the `callback`.
    extern fn e_client_remove(p_client: *Client, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const remove = e_client_remove;

    /// Finishes previous call of `edataserver.Client.remove`.
    extern fn e_client_remove_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeFinish = e_client_remove_finish;

    /// Removes the backing data for this `edataserver.Client`. For example, with the file
    /// backend this deletes the database file. You cannot get it back!
    extern fn e_client_remove_sync(p_client: *Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeSync = e_client_remove_sync;

    /// Initiates retrieval of capabilities on the `client`. This is usually
    /// required only once, after the `client` is opened. The returned value
    /// is cached and any subsequent call of `edataserver.Client.getCapabilities` and
    /// `edataserver.Client.checkCapability` is using the cached value.
    /// The call is finished by `edataserver.Client.retrieveCapabilitiesFinish`
    /// from the `callback`.
    extern fn e_client_retrieve_capabilities(p_client: *Client, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const retrieveCapabilities = e_client_retrieve_capabilities;

    /// Finishes previous call of `edataserver.Client.retrieveCapabilities`.
    /// Returned value of `capabilities` should be freed with `glib.free`,
    /// when no longer needed.
    extern fn e_client_retrieve_capabilities_finish(p_client: *Client, p_result: *gio.AsyncResult, p_capabilities: *[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const retrieveCapabilitiesFinish = e_client_retrieve_capabilities_finish;

    /// Initiates retrieval of capabilities on the `client`. This is usually
    /// required only once, after the `client` is opened. The returned value
    /// is cached and any subsequent call of `edataserver.Client.getCapabilities` and
    /// `edataserver.Client.checkCapability` is using the cached value. Returned value
    /// of `capabilities` should be freed with `glib.free`, when no longer needed.
    extern fn e_client_retrieve_capabilities_sync(p_client: *Client, p_capabilities: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const retrieveCapabilitiesSync = e_client_retrieve_capabilities_sync;

    /// Asynchronously retrieves `client` properties to match server-side values,
    /// without waiting for the D-Bus property change notifications delivery.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.Client.retrievePropertiesFinish` to get the result of the operation.
    extern fn e_client_retrieve_properties(p_client: *Client, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const retrieveProperties = e_client_retrieve_properties;

    /// Finishes the operation started with `edataserver.Client.retrieveProperties`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_client_retrieve_properties_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const retrievePropertiesFinish = e_client_retrieve_properties_finish;

    /// Retrieves `client` properties to match server-side values, without waiting
    /// for the D-Bus property change notifications delivery.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_client_retrieve_properties_sync(p_client: *Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const retrievePropertiesSync = e_client_retrieve_properties_sync;

    /// Sets `client`'s backend property of name `prop_name`
    /// to value `prop_value`. The call is finished
    /// by `edataserver.Client.setBackendPropertyFinish` from the `callback`.
    extern fn e_client_set_backend_property(p_client: *Client, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const setBackendProperty = e_client_set_backend_property;

    /// Finishes previous call of `edataserver.Client.setBackendProperty`.
    extern fn e_client_set_backend_property_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const setBackendPropertyFinish = e_client_set_backend_property_finish;

    /// Sets `client`'s backend property of name `prop_name`
    /// to value `prop_value`.
    extern fn e_client_set_backend_property_sync(p_client: *Client, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setBackendPropertySync = e_client_set_backend_property_sync;

    /// Sets a D-Bus bus name that will be used to connect the client
    /// to the backend subprocess.
    extern fn e_client_set_bus_name(p_client: *Client, p_bus_name: [*:0]const u8) void;
    pub const setBusName = e_client_set_bus_name;

    /// Unwraps D-Bus error to local error. `dbus_error` is automatically freed.
    /// `dbus_erorr` and `out_error` can point to the same variable.
    extern fn e_client_unwrap_dbus_error(p_client: *Client, p_dbus_error: *glib.Error, p_error: ?*?*glib.Error) void;
    pub const unwrapDbusError = e_client_unwrap_dbus_error;

    /// Asynchronously waits until the `client` is connected (according
    /// to `ESource`::connection-status property), but not longer than `timeout_seconds`.
    ///
    /// The call is finished by `edataserver.Client.waitForConnectedFinish` from
    /// the `callback`.
    extern fn e_client_wait_for_connected(p_client: *Client, p_timeout_seconds: u32, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const waitForConnected = e_client_wait_for_connected;

    /// Finishes previous call of `edataserver.Client.waitForConnected`.
    extern fn e_client_wait_for_connected_finish(p_client: *Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const waitForConnectedFinish = e_client_wait_for_connected_finish;

    /// Synchronously waits until the `client` is connected (according
    /// to `ESource`::connection-status property), but not longer than `timeout_seconds`.
    ///
    /// Note: This also calls `edataserver.Client.retrievePropertiesSync` on success, to have
    ///   up-to-date property values on the client side, without a delay due
    ///   to property change notifcations delivery through D-Bus.
    extern fn e_client_wait_for_connected_sync(p_client: *Client, p_timeout_seconds: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const waitForConnectedSync = e_client_wait_for_connected_sync;

    extern fn e_client_get_type() usize;
    pub const getGObjectType = e_client_get_type;

    extern fn g_object_ref(p_self: *edataserver.Client) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.Client) void;
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
pub const Extension = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edataserver.ExtensionClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.ExtensionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const extensible = struct {
            pub const name = "extensible";

            pub const Type = ?*edataserver.Extensible;
        };
    };

    pub const signals = struct {};

    /// Returns the object that `extension` extends.
    extern fn e_extension_get_extensible(p_extension: *Extension) *edataserver.Extensible;
    pub const getExtensible = e_extension_get_extensible;

    extern fn e_extension_get_type() usize;
    pub const getGObjectType = e_extension_get_type;

    extern fn g_object_ref(p_self: *edataserver.Extension) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.Extension) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Extension, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const GDataSession = extern struct {
    pub const Parent = edataserver.SoupSession;
    pub const Implements = [_]type{};
    pub const Class = edataserver.GDataSessionClass;
    f_parent: edataserver.SoupSession,
    f_priv: ?*edataserver.GDataSessionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `edataserver.GDataSession` associated with the given `source`.
    extern fn e_gdata_session_new(p_source: *edataserver.Source) *edataserver.GDataSession;
    pub const new = e_gdata_session_new;

    /// Deletes a task list `tasklist_id`.
    extern fn e_gdata_session_tasklists_delete_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasklistsDeleteSync = e_gdata_session_tasklists_delete_sync;

    /// Gets a task list `tasklist_id` and returns it as a `json.Object`,
    /// which should be freed with `json.Object.unref`, when no longer needed.
    ///
    /// There can be used `edataserver.gdataTasklistGetId`, `edataserver.gdataTasklistGetEtag`,
    /// `edataserver.gdataTasklistGetTitle`, `edataserver.gdataTasklistGetSelfLink`,
    /// `edataserver.gdataTasklistGetUpdated` to read the properties of the task list.
    extern fn e_gdata_session_tasklists_get_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_out_tasklist: **json.Object, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasklistsGetSync = e_gdata_session_tasklists_get_sync;

    /// Creates a new task list, titled `title`. The `out_inserted_tasklist` should
    /// be freed with `json.Object.unref`, when no longer needed.
    extern fn e_gdata_session_tasklists_insert_sync(p_self: *GDataSession, p_title: [*:0]const u8, p_out_inserted_tasklist: **json.Object, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasklistsInsertSync = e_gdata_session_tasklists_insert_sync;

    /// Lists all configured task lists for the user, calling the `cb` for each of them.
    extern fn e_gdata_session_tasklists_list_sync(p_self: *GDataSession, p_query: ?*edataserver.GDataQuery, p_cb: edataserver.GDataObjectCallback, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasklistsListSync = e_gdata_session_tasklists_list_sync;

    /// Changes properties of a task list `tasklist_id`.
    ///
    /// If not `NULL`, free the `out_patched_tasklist` with `json.Object.unref`,
    /// when no longer needed.
    extern fn e_gdata_session_tasklists_patch_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_tasklist_properties: *json.Builder, p_out_patched_tasklist: ?**json.Object, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasklistsPatchSync = e_gdata_session_tasklists_patch_sync;

    /// Updates a task list `tasklist_id` with values from the `tasklist`.
    extern fn e_gdata_session_tasklists_update_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_tasklist: *json.Builder, p_out_updated_tasklist: ?**json.Object, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasklistsUpdateSync = e_gdata_session_tasklists_update_sync;

    /// Clears all completed tasks from the task list `tasklist_id`. The affected tasks
    /// will be marked as 'hidden' and no longer be returned by default when retrieving
    /// all tasks for a task list.
    extern fn e_gdata_session_tasks_clear_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasksClearSync = e_gdata_session_tasks_clear_sync;

    /// Deletes a task `task_id` from a task list `tasklist_id`.
    extern fn e_gdata_session_tasks_delete_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_task_id: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasksDeleteSync = e_gdata_session_tasks_delete_sync;

    /// Gets a task `task_id` from a task list `tasklist_id` and returns it as a `json.Object`,
    /// which should be freed with `json.Object.unref`, when no longer needed.
    ///
    /// There can be used `edataserver.gdataTaskGetId`, `edataserver.gdataTaskGetEtag`,
    /// `edataserver.gdataTaskGetTitle` and other e_gdata_task_... functions
    /// to read the properties of the task.
    extern fn e_gdata_session_tasks_get_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_task_id: [*:0]const u8, p_out_task: **json.Object, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasksGetSync = e_gdata_session_tasks_get_sync;

    /// Creates a new task `task` in the task list `tasklist_id`. The `out_inserted_task` should
    /// be freed with `json.Object.unref`, when no longer needed.
    extern fn e_gdata_session_tasks_insert_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_task: *json.Builder, p_parent_task_id: ?[*:0]const u8, p_previous_task_id: ?[*:0]const u8, p_out_inserted_task: **json.Object, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasksInsertSync = e_gdata_session_tasks_insert_sync;

    /// Lists all tasks in the task list `tasklist_id`, calling the `cb` for each of them.
    extern fn e_gdata_session_tasks_list_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_query: ?*edataserver.GDataQuery, p_cb: edataserver.GDataObjectCallback, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasksListSync = e_gdata_session_tasks_list_sync;

    /// Moves the specified task `task_id` to another position in the task
    /// list `tasklist_id`. This can include putting it as a child task under
    /// a new parent and/or move it to a different position among its sibling tasks.
    extern fn e_gdata_session_tasks_move_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_task_id: [*:0]const u8, p_parent_task_id: ?[*:0]const u8, p_previous_task_id: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasksMoveSync = e_gdata_session_tasks_move_sync;

    /// Changes properties `task_properties` of a task `task_id` in the task list `tasklist_id`.
    ///
    /// If not `NULL`, free the `out_patched_task` with `json.Object.unref`,
    /// when no longer needed.
    extern fn e_gdata_session_tasks_patch_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_task_id: [*:0]const u8, p_task_properties: *json.Builder, p_out_patched_task: ?**json.Object, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasksPatchSync = e_gdata_session_tasks_patch_sync;

    /// Updates a task `task_id` in a task list `tasklist_id` to the values from the `task`.
    extern fn e_gdata_session_tasks_update_sync(p_self: *GDataSession, p_tasklist_id: [*:0]const u8, p_task_id: [*:0]const u8, p_task: *json.Builder, p_out_updated_task: ?**json.Object, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const tasksUpdateSync = e_gdata_session_tasks_update_sync;

    extern fn e_gdata_session_get_type() usize;
    pub const getGObjectType = e_gdata_session_get_type;

    extern fn g_object_ref(p_self: *edataserver.GDataSession) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.GDataSession) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GDataSession, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const Module = extern struct {
    pub const Parent = gobject.TypeModule;
    pub const Implements = [_]type{gobject.TypePlugin};
    pub const Class = edataserver.ModuleClass;
    f_parent: gobject.TypeModule,
    f_priv: ?*edataserver.ModulePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The filename of the module.
        pub const filename = struct {
            pub const name = "filename";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Loads all the modules in the specified directory into memory.  If
    /// you want to unload them (enabling on-demand loading) you must call
    /// `gobject.TypeModule.unuse` on all the modules.  Free the returned list
    /// with `glib.List.free`.
    extern fn e_module_load_all_in_directory(p_dirname: [*:0]const u8) *glib.List;
    pub const loadAllInDirectory = e_module_load_all_in_directory;

    /// Loads all the modules in the specified directory into memory and the other
    /// custom prefixes returned by `edataserver.utilGetDirectoryVariants`.  If
    /// you want to unload them (enabling on-demand loading) you must call
    /// `gobject.TypeModule.unuse` on all the modules.  Free the returned list
    /// with `glib.List.free`.
    ///
    /// When `dirprefix` is `NULL`, or not a prefix of `dirname`, behaves
    /// the same as `edataserver.Module.loadAllInDirectory`.
    extern fn e_module_load_all_in_directory_and_prefixes(p_dirname: [*:0]const u8, p_dirprefix: ?[*:0]const u8) *glib.List;
    pub const loadAllInDirectoryAndPrefixes = e_module_load_all_in_directory_and_prefixes;

    /// Load the module from the specified filename into memory. If
    /// you want to unload it (enabling on-demand loading) you must call
    /// `gobject.TypeModule.unuse` on the module.
    extern fn e_module_load_file(p_filename: [*:0]const u8) *edataserver.Module;
    pub const loadFile = e_module_load_file;

    /// Creates a new `edataserver.Module` that will load the specific shared library
    /// when in use.
    extern fn e_module_new(p_filename: [*:0]const u8) *edataserver.Module;
    pub const new = e_module_new;

    /// Returns the filename of the shared library for `module`.  The
    /// string is owned by `module` and should not be modified or freed.
    extern fn e_module_get_filename(p_module: *Module) [*:0]const u8;
    pub const getFilename = e_module_get_filename;

    extern fn e_module_get_type() usize;
    pub const getGObjectType = e_module_get_type;

    extern fn g_object_ref(p_self: *edataserver.Module) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.Module) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Module, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MsOapxbc = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edataserver.MsOapxbcClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Synchronously create a new `edataserver.MsOapxbc`.
    /// This initiates the communication with a locally running Microsoft Identity broker service
    /// via D-Bus. In case the broker is not running, it is started. If no broker is registered,
    /// this function will fail (return `NULL`).
    extern fn e_ms_oapxbc_new_sync(p_client_id: [*:0]const u8, p_authority: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edataserver.MsOapxbc;
    pub const newSync = e_ms_oapxbc_new_sync;

    /// Synchronously calls `acquirePrtSsoCookie` D-Bus method on the Microsoft
    /// OAuth2 broker service and converts the result into a new `soup.Cookie`.
    /// The account object needs to be taken from the accounts list that is returned by
    /// `edataserver.MsOapxbc.getAccountsSync`. The SSO URL is the OAuth2 authentication endpoint.
    /// The scopes are the requested scopes for the OAuth2 service (usually only
    /// https://graph.microsoft.com/.default). The redirect URI is the OAuth2 service
    /// redirect URI.
    extern fn e_ms_oapxbc_acquire_prt_sso_cookie_sync(p_self: *MsOapxbc, p_account: *json.Object, p_sso_url: [*:0]const u8, p_scopes: *json.Array, p_redirect_uri: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*soup.Cookie;
    pub const acquirePrtSsoCookieSync = e_ms_oapxbc_acquire_prt_sso_cookie_sync;

    /// Synchronously calls `getAccounts` D-Bus method on the Microsoft
    /// OAuth2 broker service and returns the result as a `json.Object`.
    ///
    /// The `json.Object` contains the accounts that are currently registered at the broker,
    /// whereby the "accounts" node provides a `json.Array` of account entries. Note, that
    /// the availability of the types and entries needs to be checked by the caller before
    /// accessing them. The accounts entries can be inspected e.g. for the "username" and
    /// "homeAccountId" fields. Then, one entry needs to be selected and passed as-is to
    /// `edataserver.MsOapxbc.acquirePrtSsoCookieSync`.
    extern fn e_ms_oapxbc_get_accounts_sync(p_self: *MsOapxbc, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*json.Object;
    pub const getAccountsSync = e_ms_oapxbc_get_accounts_sync;

    extern fn e_ms_oapxbc_get_type() usize;
    pub const getGObjectType = e_ms_oapxbc_get_type;

    extern fn g_object_ref(p_self: *edataserver.MsOapxbc) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.MsOapxbc) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MsOapxbc, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using
/// the functions below. Implements `gio.NetworkMonitorInterface`.
pub const NetworkMonitor = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{ gio.Initable, gio.NetworkMonitor };
    pub const Class = edataserver.NetworkMonitorClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.NetworkMonitorPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The GIO name of the underlying `gio.NetworkMonitor` to use.
        pub const gio_name = struct {
            pub const name = "gio-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Gets the default `edataserver.NetworkMonitor`. The caller should not unref the returned instance.
    /// The `edataserver.NetworkMonitor` implements the `gio.NetworkMonitor` iterface.
    extern fn e_network_monitor_get_default() *gio.NetworkMonitor;
    pub const getDefault = e_network_monitor_get_default;

    /// Get currently set GIO name for the network availability checks.
    /// See `edataserver.NetworkMonitor.setGioName` for more details.
    extern fn e_network_monitor_dup_gio_name(p_network_monitor: *NetworkMonitor) [*:0]u8;
    pub const dupGioName = e_network_monitor_dup_gio_name;

    /// Get a list of available GIO names for the `gio.NetworkMonitor` implementations.
    /// The strings can be used in `edataserver.NetworkMonitor.setGioName`.
    extern fn e_network_monitor_list_gio_names(p_network_monitor: *NetworkMonitor) *glib.SList;
    pub const listGioNames = e_network_monitor_list_gio_names;

    /// Set a `gio_name` of the `gio.NetworkMonitor` implementation to use, can be `NULL`.
    /// Use `edataserver.NetworkMonitor.listGioNames` for a list of available
    /// implementations. A special value, `E_NETWORK_MONITOR_ALWAYS_ONLINE_NAME`, can
    /// be used to report the network as always reachable. When an unknown GIO
    /// name is used the default `gio.NetworkMonitor` implementation, as returned
    /// by the `gio.networkMonitorGetDefault`, will be used.
    extern fn e_network_monitor_set_gio_name(p_network_monitor: *NetworkMonitor, p_gio_name: ?[*:0]const u8) void;
    pub const setGioName = e_network_monitor_set_gio_name;

    extern fn e_network_monitor_get_type() usize;
    pub const getGObjectType = e_network_monitor_get_type;

    extern fn g_object_ref(p_self: *edataserver.NetworkMonitor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.NetworkMonitor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NetworkMonitor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceBase = extern struct {
    pub const Parent = edataserver.Extension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.OAuth2ServiceBaseClass;
    f_parent: edataserver.Extension,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_oauth2_service_base_get_type() usize;
    pub const getGObjectType = e_oauth2_service_base_get_type;

    extern fn g_object_ref(p_self: *edataserver.OAuth2ServiceBase) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.OAuth2ServiceBase) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OAuth2ServiceBase, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceGoogle = extern struct {
    pub const Parent = edataserver.OAuth2ServiceBase;
    pub const Implements = [_]type{edataserver.OAuth2Service};
    pub const Class = edataserver.OAuth2ServiceGoogleClass;
    f_parent: edataserver.OAuth2ServiceBase,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_oauth2_service_google_get_type() usize;
    pub const getGObjectType = e_oauth2_service_google_get_type;

    extern fn g_object_ref(p_self: *edataserver.OAuth2ServiceGoogle) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.OAuth2ServiceGoogle) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OAuth2ServiceGoogle, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceOutlook = extern struct {
    pub const Parent = edataserver.OAuth2ServiceBase;
    pub const Implements = [_]type{edataserver.OAuth2Service};
    pub const Class = edataserver.OAuth2ServiceOutlookClass;
    f_parent: edataserver.OAuth2ServiceBase,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_oauth2_service_outlook_get_type() usize;
    pub const getGObjectType = e_oauth2_service_outlook_get_type;

    extern fn g_object_ref(p_self: *edataserver.OAuth2ServiceOutlook) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.OAuth2ServiceOutlook) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OAuth2ServiceOutlook, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceYahoo = extern struct {
    pub const Parent = edataserver.OAuth2ServiceBase;
    pub const Implements = [_]type{edataserver.OAuth2Service};
    pub const Class = edataserver.OAuth2ServiceYahooClass;
    f_parent: edataserver.OAuth2ServiceBase,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_oauth2_service_yahoo_get_type() usize;
    pub const getGObjectType = e_oauth2_service_yahoo_get_type;

    extern fn g_object_ref(p_self: *edataserver.OAuth2ServiceYahoo) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.OAuth2ServiceYahoo) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OAuth2ServiceYahoo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const OAuth2Services = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = edataserver.OAuth2ServicesClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.OAuth2ServicesPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// This is the same as `edataserver.OAuth2Services.isOauth2Alias`, except
    /// it creates its own `edataserver.OAuth2Services` instance and frees it at the end.
    /// The `edataserver.OAuth2Services` is implemented as a singleton, thus it won't be
    /// much trouble, as long as there is something else having created one
    /// instance.
    extern fn e_oauth2_services_is_oauth2_alias_static(p_auth_method: ?[*:0]const u8) c_int;
    pub const isOauth2AliasStatic = e_oauth2_services_is_oauth2_alias_static;

    extern fn e_oauth2_services_is_supported() c_int;
    pub const isSupported = e_oauth2_services_is_supported;

    /// Creates a new `edataserver.OAuth2Services` instance.
    extern fn e_oauth2_services_new() *edataserver.OAuth2Services;
    pub const new = e_oauth2_services_new;

    /// Adds the `service` to the list of known OAuth2 services into `services`.
    /// It also adds a reference to `service`.
    extern fn e_oauth2_services_add(p_services: *OAuth2Services, p_service: *edataserver.OAuth2Service) void;
    pub const add = e_oauth2_services_add;

    /// Searches the list of currently known OAuth2 services for the one which
    /// can be used with the given `source`.
    ///
    /// The returned `edataserver.OAuth2Service` is referenced for thread safety, if found.
    extern fn e_oauth2_services_find(p_services: *OAuth2Services, p_source: *edataserver.Source) ?*edataserver.OAuth2Service;
    pub const find = e_oauth2_services_find;

    /// Searches the list of currently known OAuth2 services for the one which
    /// can be used with the given `protocol` and/or `hostname`.
    /// Any of `protocol` and `hostname` can be `NULL`, but not both.
    /// It's up to each `edataserver.OAuth2Service` to decide, which of the arguments
    /// are important and whether all or only any of them can be required.
    ///
    /// The returned `edataserver.OAuth2Service` is referenced for thread safety, if found.
    extern fn e_oauth2_services_guess(p_services: *OAuth2Services, p_protocol: ?[*:0]const u8, p_hostname: ?[*:0]const u8) ?*edataserver.OAuth2Service;
    pub const guess = e_oauth2_services_guess;

    extern fn e_oauth2_services_is_oauth2_alias(p_services: *OAuth2Services, p_auth_method: ?[*:0]const u8) c_int;
    pub const isOauth2Alias = e_oauth2_services_is_oauth2_alias;

    /// Lists all currently known services, which had been added
    /// with `edataserver.OAuth2Services.add`. Free the returned `glib.SList` with
    /// g_slist_remove_full (known_services, g_object_unref);
    /// when no longer needed.
    extern fn e_oauth2_services_list(p_services: *OAuth2Services) *glib.SList;
    pub const list = e_oauth2_services_list;

    /// Removes the `service` from the list of known services in `services`.
    /// The function does nothing, if the `service` had not been added.
    extern fn e_oauth2_services_remove(p_services: *OAuth2Services, p_service: *edataserver.OAuth2Service) void;
    pub const remove = e_oauth2_services_remove;

    extern fn e_oauth2_services_get_type() usize;
    pub const getGObjectType = e_oauth2_services_get_type;

    extern fn g_object_ref(p_self: *edataserver.OAuth2Services) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.OAuth2Services) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OAuth2Services, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SoupAuthBearer = extern struct {
    pub const Parent = soup.Auth;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SoupAuthBearerClass;
    f_parent: soup.Auth,
    f_priv: ?*edataserver.SoupAuthBearerPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_soup_auth_bearer_is_expired(p_bearer: *SoupAuthBearer) c_int;
    pub const isExpired = e_soup_auth_bearer_is_expired;

    /// This function is analogous to `soup.Auth.authenticate` for "Basic" HTTP
    /// authentication, except it takes an OAuth 2.0 access token instead of a
    /// username and password.
    ///
    /// If `expires_in_seconds` is greater than zero, `soup.Auth.isAuthenticated`
    /// will return `FALSE` after the given number of seconds have elapsed.
    extern fn e_soup_auth_bearer_set_access_token(p_bearer: *SoupAuthBearer, p_access_token: [*:0]const u8, p_expires_in_seconds: c_int) void;
    pub const setAccessToken = e_soup_auth_bearer_set_access_token;

    extern fn e_soup_auth_bearer_get_type() usize;
    pub const getGObjectType = e_soup_auth_bearer_get_type;

    extern fn g_object_ref(p_self: *edataserver.SoupAuthBearer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SoupAuthBearer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SoupAuthBearer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SoupSession = extern struct {
    pub const Parent = soup.Session;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SoupSessionClass;
    f_parent: soup.Session,
    f_priv: ?*edataserver.SoupSessionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `edataserver.NamedParameters` containing login credentials.
        pub const credentials = struct {
            pub const name = "credentials";

            pub const Type = ?*edataserver.NamedParameters;
        };

        /// Whether the messages created by the session should force use
        /// of HTTP/1 instead of trying HTTP/2 first and fallback to the HTTP/1
        /// when the newer version failed to connect.
        ///
        /// See `edataserver.SoupSession.setForceHttp1` for more information about the limitations.
        pub const force_http1 = struct {
            pub const name = "force-http1";

            pub const Type = c_int;
        };

        /// Set to `TRUE`, which is the default, to automatically handle backoff responses
        /// from the server, that is, when the server requests the client to retry later.
        ///
        /// Note: This handles only the synchronous functions to send the messages. Clients
        /// using the asynchronous API need to handle the backoff responses on their own.
        pub const handle_backoff_responses = struct {
            pub const name = "handle-backoff-responses";

            pub const Type = c_int;
        };

        /// The `edataserver.Source` being used for this soup session.
        pub const source = struct {
            pub const name = "source";

            pub const Type = ?*edataserver.Source;
        };
    };

    pub const signals = struct {};

    extern fn e_soup_session_error_quark() glib.Quark;
    pub const errorQuark = e_soup_session_error_quark;

    /// Checks whether `edataserver.SoupSession.setForceHttp1` can be used
    /// to force HTTP/1 usage. This depends on the libsoup version
    /// the data server had been compiled with.
    extern fn e_soup_session_util_get_force_http1_supported() c_int;
    pub const utilGetForceHttp1Supported = e_soup_session_util_get_force_http1_supported;

    /// Returns bytes read from the message response, when the message send failed.
    /// This can be used to examine detailed error returned by the server in
    /// the response body.
    extern fn e_soup_session_util_get_message_bytes(p_message: *soup.Message) ?*glib.ByteArray;
    pub const utilGetMessageBytes = e_soup_session_util_get_message_bytes;

    /// Normalizes the path of the `uri`, aka encodes characters, which should
    /// be encoded, if needed. Returns, modified URI when any change had been made to the path.
    /// It doesn't touch other parts of the `uri`.
    extern fn e_soup_session_util_normalize_uri_path(p_uri: *glib.Uri) ?*glib.Uri;
    pub const utilNormalizeUriPath = e_soup_session_util_normalize_uri_path;

    /// Returns referenced request data for the `message`, as being previously
    /// set by the `edataserver.SoupSession.utilSetMessageRequestBody` or
    /// `edataserver.SoupSession.utilSetMessageRequestBodyFromData`.
    ///
    /// Do not call this function while the `message` is queued in
    /// a `soup.Session`, nor modify the input stream position until
    /// the `message` lefts the `soup.Session`.
    extern fn e_soup_session_util_ref_message_request_body(p_message: *soup.Message, p_out_length: ?*isize) ?*gio.InputStream;
    pub const utilRefMessageRequestBody = e_soup_session_util_ref_message_request_body;

    /// Sets the request body of the `message` from the `input_stream` of the `length`, with optional
    /// `content_type`. The function makes sure the `message` request body is set again
    /// when the message is restarted.
    ///
    /// The `input_stream` should implement the `gio.Seekable` interface.
    extern fn e_soup_session_util_set_message_request_body(p_message: *soup.Message, p_content_type: ?[*:0]const u8, p_input_stream: *gio.InputStream, p_length: isize) void;
    pub const utilSetMessageRequestBody = e_soup_session_util_set_message_request_body;

    /// Sets the request body of the `message` from the `data` of the `length`, with optional
    /// `content_type`. The function makes sure the `message` request body is set again
    /// when the message is restarted.
    ///
    /// When the `create_copy` is `TRUE`, the `free_func` should be `NULL`.
    extern fn e_soup_session_util_set_message_request_body_from_data(p_message: *soup.Message, p_create_copy: c_int, p_content_type: ?[*:0]const u8, p_data: ?*const anyopaque, p_length: isize, p_free_func: ?glib.DestroyNotify) void;
    pub const utilSetMessageRequestBodyFromData = e_soup_session_util_set_message_request_body_from_data;

    /// Returns the `reason_phrase`, if it's non-`NULL` and non-empty, a static string
    /// corresponding to `status_code`. In case neither that can be found a localized
    /// "Unknown error" message is returned.
    extern fn e_soup_session_util_status_to_string(p_status_code: c_uint, p_reason_phrase: ?[*:0]const u8) [*:0]const u8;
    pub const utilStatusToString = e_soup_session_util_status_to_string;

    /// Creates a new `edataserver.SoupSession` associated with given `source`.
    /// The `source` can be used to store and read SSL trust settings, but only if
    /// it already contains an `edataserver.SourceWebdav` extension. Otherwise the SSL trust
    /// settings are ignored.
    extern fn e_soup_session_new(p_source: *edataserver.Source) *edataserver.SoupSession;
    pub const new = e_soup_session_new;

    /// Checks result of the `message` and sets the `error` if it failed.
    /// When it failed and the `read_bytes` is provided, then these are
    /// set to `message`'s response body, thus it can be used later.
    extern fn e_soup_session_check_result(p_session: *SoupSession, p_message: *soup.Message, p_read_bytes: ?*const anyopaque, p_bytes_length: usize, p_error: ?*?*glib.Error) c_int;
    pub const checkResult = e_soup_session_check_result;

    extern fn e_soup_session_dup_credentials(p_session: *SoupSession) ?*edataserver.NamedParameters;
    pub const dupCredentials = e_soup_session_dup_credentials;

    extern fn e_soup_session_get_authentication_requires_credentials(p_session: *SoupSession) c_int;
    pub const getAuthenticationRequiresCredentials = e_soup_session_get_authentication_requires_credentials;

    /// Returns whether it's forced to use HTTP/1 for the messages
    /// created by the `session`. See `edataserver.SoupSession.setForceHttp1`
    /// for more information about the limitations.
    extern fn e_soup_session_get_force_http1(p_session: *SoupSession) c_int;
    pub const getForceHttp1 = e_soup_session_get_force_http1;

    /// Returns whether the `session` can handle backoff responses from the server.
    /// See `edataserver.SoupSession.setHandleBackoffResponses` for more information about
    /// the limitations.
    extern fn e_soup_session_get_handle_backoff_responses(p_session: *SoupSession) c_int;
    pub const getHandleBackoffResponses = e_soup_session_get_handle_backoff_responses;

    extern fn e_soup_session_get_log_level(p_session: *SoupSession) soup.LoggerLogLevel;
    pub const getLogLevel = e_soup_session_get_log_level;

    /// Returns an `edataserver.Source` associated with the `session`, if such was set in the creation time.
    extern fn e_soup_session_get_source(p_session: *SoupSession) ?*edataserver.Source;
    pub const getSource = e_soup_session_get_source;

    /// Populates `out_certificate_pem` and `out_certificate_errors` with the last values
    /// returned on `G_TLS_ERROR_BAD_CERTIFICATE` error.
    extern fn e_soup_session_get_ssl_error_details(p_session: *SoupSession, p_out_certificate_pem: ?*[*:0]u8, p_out_certificate_errors: ?*gio.TlsCertificateFlags) c_int;
    pub const getSslErrorDetails = e_soup_session_get_ssl_error_details;

    /// Handles authentication failure and sets appropriate value to the `out_auth_result`
    /// for the provided `op_error` and used `credentials`. Converts the `op_error`
    /// into an appropriate error returned in the `error`.
    ///
    /// Also updates connection status on the associated `edataserver.Source` with the `session`.
    extern fn e_soup_session_handle_authentication_failure(p_session: *SoupSession, p_credentials: ?*const edataserver.NamedParameters, p_op_error: *const glib.Error, p_out_auth_result: *edataserver.SourceAuthenticationResult, p_out_certificate_pem: ?*[*:0]u8, p_out_certificate_errors: ?*gio.TlsCertificateFlags, p_error: ?*?*glib.Error) void;
    pub const handleAuthenticationFailure = e_soup_session_handle_authentication_failure;

    /// Creates a new `soup.Message`, similar to `soup.Message.new`,
    /// but also presets request headers with "User-Agent" to be "Evolution/version"
    /// and with "Connection" to be "close".
    ///
    /// See also `edataserver.SoupSession.newMessageFromUri`.
    extern fn e_soup_session_new_message(p_session: *SoupSession, p_method: [*:0]const u8, p_uri_string: [*:0]const u8, p_error: ?*?*glib.Error) ?*soup.Message;
    pub const newMessage = e_soup_session_new_message;

    /// Creates a new `soup.Message`, similar to `soup.Message.newFromUri`,
    /// but also presets request headers with "User-Agent" to be "Evolution/version"
    /// and with "Connection" to be "close".
    ///
    /// See also `edataserver.SoupSession.newMessage`.
    extern fn e_soup_session_new_message_from_uri(p_session: *SoupSession, p_method: [*:0]const u8, p_uri: *glib.Uri, p_error: ?*?*glib.Error) ?*soup.Message;
    pub const newMessageFromUri = e_soup_session_new_message_from_uri;

    /// Prepares the `message` to be a sent asynchronously with
    /// `edataserver.SoupSession.sendMessage`. The returned pointer is passed
    /// to the `edataserver.SoupSession.sendMessage` as the prepare_data
    /// parameter.
    extern fn e_soup_session_prepare_message_send_sync(p_session: *SoupSession, p_message: *soup.Message, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*anyopaque;
    pub const prepareMessageSendSync = e_soup_session_prepare_message_send_sync;

    /// Asynchronously sends the `message`. Finish the call with
    /// `edataserver.SoupSession.sendMessageFinish`.
    ///
    /// The `prepare_data` is a result of the `edataserver.SoupSession.prepareMessageSendSync`
    /// and this function assumes ownership of it. The `prepare_data` cannot be used
    /// again after this call.
    extern fn e_soup_session_send_message(p_session: *SoupSession, p_message: *soup.Message, p_io_priority: c_int, p_prepare_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const sendMessage = e_soup_session_send_message;

    /// Finishes the call of `edataserver.SoupSession.sendMessage`. This is supposed to
    /// be called from the callback passed to the `edataserver.SoupSession.sendMessage`.
    ///
    /// The optional `out_certificate_pem` and `out_certificate_errors` are set,
    /// when provided, only if the operation failed with a TLS/SSL error.
    ///
    /// Make sure the `gio.InputStream` is read and freed from the same thread,
    /// and with the same thread default main context, which this function
    /// was called from, otherwise it can break libsoup3.
    extern fn e_soup_session_send_message_finish(p_session: *SoupSession, p_result: *gio.AsyncResult, p_out_certificate_pem: ?*[*:0]u8, p_out_certificate_errors: ?*gio.TlsCertificateFlags, p_error: ?*?*glib.Error) ?*gio.InputStream;
    pub const sendMessageFinish = e_soup_session_send_message_finish;

    /// Similar to `edataserver.SoupSession.sendMessageSync`, except it reads
    /// whole response content into memory and returns it as a `glib.ByteArray`.
    /// Use `edataserver.SoupSession.sendMessageSync` when you want to have
    /// more control on the content read.
    extern fn e_soup_session_send_message_simple_sync(p_session: *SoupSession, p_message: *soup.Message, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.ByteArray;
    pub const sendMessageSimpleSync = e_soup_session_send_message_simple_sync;

    /// Synchronously sends prepared message and returns `gio.InputStream`
    /// that can be used to read its contents.
    ///
    /// This calls `soup.Session.send` internally, but it also setups
    /// the `message` according to `edataserver.SoupSession.properties.source` authentication
    /// settings. It also extracts information about used certificate,
    /// in case of G_TLS_ERROR_BAD_CERTIFICATE error and keeps it
    /// for later use by `edataserver.SoupSession.getSslErrorDetails`.
    ///
    /// Use `edataserver.SoupSession.sendMessageSimpleSync` to read whole
    /// content into a `glib.ByteArray`.
    ///
    /// Note that SoupSession doesn't log content read from GInputStream,
    /// thus the caller may print the read content on its own when needed.
    ///
    /// Note the `message` is fully filled only after there is anything
    /// read from the resulting `gio.InputStream`, thus use
    /// `edataserver.SoupSession.checkResult` to verify that the receive had
    /// been finished properly.
    ///
    /// Make sure the `gio.InputStream` is read and freed from the same thread,
    /// and with the same thread default main context, which this function
    /// was called from, otherwise it can break libsoup3.
    extern fn e_soup_session_send_message_sync(p_session: *SoupSession, p_message: *soup.Message, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*gio.InputStream;
    pub const sendMessageSync = e_soup_session_send_message_sync;

    /// Sets credentials to use for connection. Using `NULL` for `credentials`
    /// unsets previous value.
    extern fn e_soup_session_set_credentials(p_session: *SoupSession, p_credentials: ?*const edataserver.NamedParameters) void;
    pub const setCredentials = e_soup_session_set_credentials;

    /// Sets whether the messages created through the `session` using
    /// `edataserver.SoupSession.newMessage` or `edataserver.SoupSession.newMessageFromUri`
    /// should force use of the HTTP/1, instead of trying HTTP/2 and fallback to HTTP/1,
    /// when the newer version cannot be used.
    ///
    /// The property has no effect when `edataserver.SoupSession.utilGetForceHttp1Supported`
    /// returns `FALSE`.
    extern fn e_soup_session_set_force_http1(p_session: *SoupSession, p_force_http1: c_int) void;
    pub const setForceHttp1 = e_soup_session_set_force_http1;

    /// Sets whether to automatically handle backoff responses from the server,
    /// that is, when the server requests the client to retry later.
    ///
    /// Note: This handles only the synchronous functions to send the messages. Clients
    /// using the asynchronous API need to handle the backoff responses on their own.
    extern fn e_soup_session_set_handle_backoff_responses(p_session: *SoupSession, p_handle_backoff_responses: c_int) void;
    pub const setHandleBackoffResponses = e_soup_session_set_handle_backoff_responses;

    /// Setups logging for the `session`. The `logging_level` can be one of:
    /// "all" - log whole raw communication;
    /// "body" - the same as "all";
    /// "headers" - log the headers only;
    /// "min" - minimal logging;
    /// "1" - the same as "all".
    /// Any other value, including `NULL`, disables logging.
    ///
    /// Use `edataserver.SoupSession.getLogLevel` to get current log level.
    extern fn e_soup_session_setup_logging(p_session: *SoupSession, p_logging_level: ?[*:0]const u8) void;
    pub const setupLogging = e_soup_session_setup_logging;

    extern fn e_soup_session_get_type() usize;
    pub const getGObjectType = e_soup_session_get_type;

    extern fn g_object_ref(p_self: *edataserver.SoupSession) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SoupSession) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SoupSession, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const Source = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{ gio.Initable, gio.ProxyResolver };
    pub const Class = edataserver.SourceClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.SourcePrivate,

    pub const virtual_methods = struct {
        pub const authenticate = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_credentials: *const edataserver.NamedParameters) void {
                return gobject.ext.as(Source.Class, p_class).f_authenticate.?(gobject.ext.as(Source, p_source), p_credentials);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_credentials: *const edataserver.NamedParameters) callconv(.c) void) void {
                gobject.ext.as(Source.Class, p_class).f_authenticate = @ptrCast(p_implementation);
            }
        };

        /// Emits the `edataserver.Source.signals.changed` signal from an idle callback in
        /// `source`'s `edataserver.Source.properties.main`-context.
        ///
        /// This function is primarily intended for use by `edataserver.SourceExtension`
        /// when emitting a `gobject.Object.signals.notify` signal on one of its properties.
        pub const changed = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Source.Class, p_class).f_changed.?(gobject.ext.as(Source, p_source));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Source.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };

        pub const credentials_required = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: *const glib.Error) void {
                return gobject.ext.as(Source.Class, p_class).f_credentials_required.?(gobject.ext.as(Source, p_source), p_reason, p_certificate_pem, p_certificate_errors, p_op_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: *const glib.Error) callconv(.c) void) void {
                gobject.ext.as(Source.Class, p_class).f_credentials_required = @ptrCast(p_implementation);
            }
        };

        /// Asynchronously obtains the OAuth 2.0 access token for `source` along
        /// with its expiry in seconds from the current time (or 0 if unknown).
        ///
        /// When the operation is finished, `callback` will be called.  You can then
        /// call `edataserver.Source.getOauth2AccessTokenFinish` to get the result of the
        /// operation.
        pub const get_oauth2_access_token = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Source.Class, p_class).f_get_oauth2_access_token.?(gobject.ext.as(Source, p_source), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Source.Class, p_class).f_get_oauth2_access_token = @ptrCast(p_implementation);
            }
        };

        /// Finishes the operation started with `edataserver.Source.getOauth2AccessToken`.
        ///
        /// Free the returned access token with `glib.free` when finished with it.
        /// If an error occurred, the function will set `error` and return `FALSE`.
        pub const get_oauth2_access_token_finish = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_get_oauth2_access_token_finish.?(gobject.ext.as(Source, p_source), p_result, p_out_access_token, p_out_expires_in, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_get_oauth2_access_token_finish = @ptrCast(p_implementation);
            }
        };

        /// Obtains the OAuth 2.0 access token for `source` along with its expiry
        /// in seconds from the current time (or 0 if unknown).
        ///
        /// Free the returned access token with `glib.free` when finished with it.
        /// If an error occurs, the function will set `error` and return `FALSE`.
        pub const get_oauth2_access_token_sync = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_get_oauth2_access_token_sync.?(gobject.ext.as(Source, p_source), p_cancellable, p_out_access_token, p_out_expires_in, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_get_oauth2_access_token_sync = @ptrCast(p_implementation);
            }
        };

        pub const invoke_authenticate_impl = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_dbus_source: ?*anyopaque, p_arg_credentials: *const [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_invoke_authenticate_impl.?(gobject.ext.as(Source, p_source), p_dbus_source, p_arg_credentials, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_dbus_source: ?*anyopaque, p_arg_credentials: *const [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_invoke_authenticate_impl = @ptrCast(p_implementation);
            }
        };

        pub const invoke_credentials_required_impl = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_dbus_source: ?*anyopaque, p_arg_reason: [*:0]const u8, p_arg_certificate_pem: [*:0]const u8, p_arg_certificate_errors: [*:0]const u8, p_arg_dbus_error_name: [*:0]const u8, p_arg_dbus_error_message: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_invoke_credentials_required_impl.?(gobject.ext.as(Source, p_source), p_dbus_source, p_arg_reason, p_arg_certificate_pem, p_arg_certificate_errors, p_arg_dbus_error_name, p_arg_dbus_error_message, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_dbus_source: ?*anyopaque, p_arg_reason: [*:0]const u8, p_arg_certificate_pem: [*:0]const u8, p_arg_certificate_errors: [*:0]const u8, p_arg_dbus_error_name: [*:0]const u8, p_arg_dbus_error_message: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_invoke_credentials_required_impl = @ptrCast(p_implementation);
            }
        };

        /// Asynchronously creates a new remote resource by picking out relevant
        /// details from `scratch_source`.  The `scratch_source` must be an `edataserver.Source`
        /// with no `gio.DBusObject`.  The `source` must be `edataserver.Source.properties.remote`-creatable.
        ///
        /// The details required to create the resource vary by `ECollectionBackend`,
        /// but in most cases the `scratch_source` need only define the resource type
        /// (address book, calendar, etc.), a display name for the resource, and
        /// possibly a server-side path or ID for the resource.
        ///
        /// When the operation is finished, `callback` will be called.  You can then
        /// call `edataserver.Source.remoteCreateFinish` to get the result of the operation.
        pub const remote_create = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_scratch_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Source.Class, p_class).f_remote_create.?(gobject.ext.as(Source, p_source), p_scratch_source, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_scratch_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Source.Class, p_class).f_remote_create = @ptrCast(p_implementation);
            }
        };

        /// Finishes the operation started with `edataserver.Source.remoteCreate`.  If
        /// an error occurred, the function will set `error` and return `FALSE`.
        pub const remote_create_finish = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_remote_create_finish.?(gobject.ext.as(Source, p_source), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_remote_create_finish = @ptrCast(p_implementation);
            }
        };

        /// Creates a new remote resource by picking out relevant details from
        /// `scratch_source`.  The `scratch_source` must be an `edataserver.Source` with no
        /// `gio.DBusObject`.  The `source` must be `edataserver.Source.properties.remote`-creatable.
        ///
        /// The details required to create the resource vary by `ECollectionBackend`,
        /// but in most cases the `scratch_source` need only define the resource type
        /// (address book, calendar, etc.), a display name for the resource, and
        /// possibly a server-side path or ID for the resource.
        ///
        /// If an error occurs, the function will set `error` and return `FALSE`.
        pub const remote_create_sync = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_scratch_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_remote_create_sync.?(gobject.ext.as(Source, p_source), p_scratch_source, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_scratch_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_remote_create_sync = @ptrCast(p_implementation);
            }
        };

        /// Asynchronously deletes the resource represented by `source` from a remote
        /// server.  The `source` must be `edataserver.Source.properties.remote`-deletable.  This will also
        /// delete the key file for `source` and broadcast its removal to all clients,
        /// similar to `edataserver.Source.remove`.
        ///
        /// When the operation is finished, `callback` will be called.  You can then
        /// call `edataserver.Source.remoteDeleteFinish` to get the result of the operation.
        pub const remote_delete = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Source.Class, p_class).f_remote_delete.?(gobject.ext.as(Source, p_source), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Source.Class, p_class).f_remote_delete = @ptrCast(p_implementation);
            }
        };

        /// Finishes the operation started with `edataserver.Source.remoteDelete`.  If
        /// an error occurred, the function will set `error` and return `FALSE`.
        pub const remote_delete_finish = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_remote_delete_finish.?(gobject.ext.as(Source, p_source), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_remote_delete_finish = @ptrCast(p_implementation);
            }
        };

        /// Deletes the resource represented by `source` from a remote server.
        /// The `source` must be `edataserver.Source.properties.remote`-deletable.  This will also delete
        /// the key file for `source` and broadcast its removal to all clients,
        /// similar to `edataserver.Source.removeSync`.
        ///
        /// If an error occurs, the function will set `error` and return `FALSE`.
        pub const remote_delete_sync = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_remote_delete_sync.?(gobject.ext.as(Source, p_source), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_remote_delete_sync = @ptrCast(p_implementation);
            }
        };

        /// Asynchronously requests the D-Bus service to delete the key files for
        /// `source` and all of its descendants and broadcast their removal to all
        /// clients.  The `source` must be `edataserver.Source.properties.removable`.
        ///
        /// When the operation is finished, `callback` will be called.  You can then
        /// call `edataserver.Source.removeFinish` to get the result of the operation.
        pub const remove = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Source.Class, p_class).f_remove.?(gobject.ext.as(Source, p_source), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Source.Class, p_class).f_remove = @ptrCast(p_implementation);
            }
        };

        /// Finishes the operation started with `edataserver.Source.remove`.  If an
        /// error occurred, the function will set `error` and return `FALSE`.
        pub const remove_finish = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_remove_finish.?(gobject.ext.as(Source, p_source), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_remove_finish = @ptrCast(p_implementation);
            }
        };

        /// Requests the D-Bus service to delete the key files for `source` and all of
        /// its descendants and broadcast their removal to all clients.  The `source`
        /// must be `edataserver.Source.properties.removable`.
        ///
        /// If an error occurs, the functon will set `error` and return `FALSE`.
        pub const remove_sync = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_remove_sync.?(gobject.ext.as(Source, p_source), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_remove_sync = @ptrCast(p_implementation);
            }
        };

        pub const unset_last_credentials_required_arguments_impl = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_unset_last_credentials_required_arguments_impl.?(gobject.ext.as(Source, p_source), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_unset_last_credentials_required_arguments_impl = @ptrCast(p_implementation);
            }
        };

        /// Asynchronously submits the current contents of `source` to the D-Bus
        /// service to be written to disk and broadcast to other clients.  The
        /// `source` must be `edataserver.Source.properties.writable`.
        ///
        /// When the operation is finished, `callback` will be called.  You can then
        /// call `edataserver.Source.writeFinish` to get the result of the operation.
        pub const write = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(Source.Class, p_class).f_write.?(gobject.ext.as(Source, p_source), p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Source.Class, p_class).f_write = @ptrCast(p_implementation);
            }
        };

        /// Finishes the operation started with `edataserver.Source.write`.  If an
        /// error occurred, the function will set `error` and return `FALSE`.
        pub const write_finish = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_write_finish.?(gobject.ext.as(Source, p_source), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_write_finish = @ptrCast(p_implementation);
            }
        };

        /// Submits the current contents of `source` to the D-Bus service to be
        /// written to disk and broadcast to other clients.  The `source` must
        /// be `edataserver.Source.properties.writable`.
        ///
        /// If an error occurs, the functon will set `error` and return `FALSE`.
        pub const write_sync = struct {
            pub fn call(p_class: anytype, p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Source.Class, p_class).f_write_sync.?(gobject.ext.as(Source, p_source), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_source: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Source.Class, p_class).f_write_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const connection_status = struct {
            pub const name = "connection-status";

            pub const Type = edataserver.SourceConnectionStatus;
        };

        pub const dbus_object = struct {
            pub const name = "dbus-object";

            pub const Type = @compileError("no type information available");
        };

        pub const display_name = struct {
            pub const name = "display-name";

            pub const Type = ?[*:0]u8;
        };

        pub const enabled = struct {
            pub const name = "enabled";

            pub const Type = c_int;
        };

        pub const main_context = struct {
            pub const name = "main-context";

            pub const Type = ?*glib.MainContext;
        };

        pub const parent = struct {
            pub const name = "parent";

            pub const Type = ?[*:0]u8;
        };

        pub const remote_creatable = struct {
            pub const name = "remote-creatable";

            pub const Type = c_int;
        };

        pub const remote_deletable = struct {
            pub const name = "remote-deletable";

            pub const Type = c_int;
        };

        pub const removable = struct {
            pub const name = "removable";

            pub const Type = c_int;
        };

        pub const uid = struct {
            pub const name = "uid";

            pub const Type = ?[*:0]u8;
        };

        pub const writable = struct {
            pub const name = "writable";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Let's the backend know provided credentials to use to login
        /// to (possibly remote) data store.
        pub const authenticate = struct {
            pub const name = "authenticate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_credentials: *edataserver.NamedParameters, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Source, p_instance))),
                    gobject.signalLookup("authenticate", Source.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::changed signal is emitted when a property in `source` or
        /// one of its extension objects changes.  A common use for this
        /// signal is to notify a `GtkTreeModel` containing data collected
        /// from `edataserver.Source`<!-- -->s that it needs to update a row.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Source, p_instance))),
                    gobject.signalLookup("changed", Source.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::credentials-required signal is emitted when the `source`
        /// requires credentials to connect to (possibly remote)
        /// data store. The credentials can be passed to the backend using
        /// `edataserver.Source.invokeAuthenticate` function.
        pub const credentials_required = struct {
            pub const name = "credentials-required";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]u8, p_certificate_errors: gio.TlsCertificateFlags, p_error: *glib.Error, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Source, p_instance))),
                    gobject.signalLookup("credentials-required", Source.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Converts a `gobject.ParamSpec` name (e.g. "foo-bar" or "foo_bar")
    /// to "CamelCase" for use as a `glib.KeyFile` key (e.g. "FooBar").
    ///
    /// This function is made public only to aid in account migration.
    /// Applications should not need to use this.
    extern fn e_source_parameter_to_key(p_param_name: [*:0]const u8) [*:0]u8;
    pub const parameterToKey = e_source_parameter_to_key;

    /// Creates a new `edataserver.Source` instance.
    ///
    /// The `edataserver.Source.signals.changed` signal will be emitted from `main_context` if given,
    /// or else from the thread-default `glib.MainContext` at the time this function is
    /// called.
    ///
    /// The only time the function should be called outside of `edataserver.SourceRegistry`
    /// is to create a so-called "scratch" `edataserver.Source` for editing in a Properties
    /// window or an account setup assistant.
    ///
    /// FIXME: Elaborate on scratch sources.
    extern fn e_source_new(p_dbus_object: ?*gio.DBusObject, p_main_context: ?*glib.MainContext, p_error: ?*?*glib.Error) ?*edataserver.Source;
    pub const new = e_source_new;

    /// Creates a new "scratch" `edataserver.Source` with a predetermined unique identifier.
    ///
    /// The `edataserver.Source.signals.changed` signal will be emitted from `main_context` if given,
    /// or else from the thread-default `glib.MainContext` at the time this function is
    /// called.
    extern fn e_source_new_with_uid(p_uid: [*:0]const u8, p_main_context: ?*glib.MainContext, p_error: ?*?*glib.Error) ?*edataserver.Source;
    pub const newWithUid = e_source_new_with_uid;

    /// This function essentially glues together `source` and `serivce` so their
    /// configuration settings stay synchronized.  The glue itself is a shared
    /// `camel.Settings` instance.
    ///
    /// Call this function immediately after creating a new `camel.Service` with
    /// `camel.Session.addService`.
    extern fn e_source_camel_configure_service(p_source: *Source, p_service: *camel.Service) void;
    pub const camelConfigureService = e_source_camel_configure_service;

    /// Emits the `edataserver.Source.signals.changed` signal from an idle callback in
    /// `source`'s `edataserver.Source.properties.main`-context.
    ///
    /// This function is primarily intended for use by `edataserver.SourceExtension`
    /// when emitting a `gobject.Object.signals.notify` signal on one of its properties.
    extern fn e_source_changed(p_source: *Source) void;
    pub const changed = e_source_changed;

    /// Compares two `edataserver.Source` instances by their display names.  Useful for
    /// ordering sources in a user interface.
    extern fn e_source_compare_by_display_name(p_source1: *Source, p_source2: *edataserver.Source) c_int;
    pub const compareByDisplayName = e_source_compare_by_display_name;

    /// Asynchronously deletes the password for `source` from either the default
    /// keyring or session keyring.  This operation does not rely on the registry
    /// service and therefore works for any `edataserver.Source` -- registered or "scratch".
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.deletePasswordFinish` to get the result of the operation.
    extern fn e_source_delete_password(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const deletePassword = e_source_delete_password;

    /// Finishes the operation started with `edataserver.Source.deletePassword`.
    ///
    /// Note the boolean return value indicates whether the delete operation
    /// itself completed successfully, not whether a password was found and
    /// deleted.  If no password was found, the function will still return
    /// `TRUE`.  If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_delete_password_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const deletePasswordFinish = e_source_delete_password_finish;

    /// Deletes the password for `source` from either the default keyring or
    /// session keyring.  This operation does not rely on the registry service
    /// and therefore works for any `edataserver.Source` -- registered or "scratch".
    ///
    /// Note the boolean return value indicates whether the delete operation
    /// itself completed successfully, not whether a password was found and
    /// deleted.  If no password was found, the function will still return
    /// `TRUE`.  If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_delete_password_sync(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deletePasswordSync = e_source_delete_password_sync;

    /// Thread-safe variation of `edataserver.Source.getDisplayName`.
    /// Use this function when accessing `source` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_dup_display_name(p_source: *Source) [*:0]u8;
    pub const dupDisplayName = e_source_dup_display_name;

    /// Thread-safe variation of `edataserver.Source.getParent`.
    /// Use this function when accessing `source` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_dup_parent(p_source: *Source) ?[*:0]u8;
    pub const dupParent = e_source_dup_parent;

    /// Creates a label string based on `source`'s `edataserver.Source.properties.display`-name for use
    /// with `SecretItem`.
    extern fn e_source_dup_secret_label(p_source: *Source) [*:0]u8;
    pub const dupSecretLabel = e_source_dup_secret_label;

    /// Thread-safe variation of `edataserver.Source.getUid`.
    /// Use this function when accessing `source` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_dup_uid(p_source: *Source) [*:0]u8;
    pub const dupUid = e_source_dup_uid;

    /// Emits locally (in this process only) the ESource::credentials-required
    /// signal with given parameters. That's the difference with `edataserver.Source.invokeCredentialsRequired`,
    /// which calls the signal globally, within each client.
    extern fn e_source_emit_credentials_required(p_source: *Source, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: ?*const glib.Error) void;
    pub const emitCredentialsRequired = e_source_emit_credentials_required;

    /// Checks two `edataserver.Source` instances for equality.  `edataserver.Source` instances are
    /// equal if their unique identifier strings are equal.
    extern fn e_source_equal(p_source1: *Source, p_source2: *edataserver.Source) c_int;
    pub const equal = e_source_equal;

    /// Obtain current connection status of the `source`.
    extern fn e_source_get_connection_status(p_source: *Source) edataserver.SourceConnectionStatus;
    pub const getConnectionStatus = e_source_get_connection_status;

    /// Returns the display name for `source`.  Use the display name to
    /// represent the `edataserver.Source` in a user interface.
    extern fn e_source_get_display_name(p_source: *Source) [*:0]const u8;
    pub const getDisplayName = e_source_get_display_name;

    /// Returns `TRUE` if `source` is enabled.
    ///
    /// An application should try to honor this setting if at all possible,
    /// even if it does not provide a way to change the setting through its
    /// user interface.  Disabled data sources should generally be hidden.
    ///
    /// <note><para>
    ///   This function does not take into account `source`'s ancestors in the
    ///   `edataserver.Source` hierarchy, each of which have their own enabled state.  If
    ///   any of `source`'s ancestors are disabled, then `source` itself should
    ///   be treated as disabled.  Use `edataserver.SourceRegistry.checkEnabled` to
    ///   easily check for this.
    /// </para></note>
    extern fn e_source_get_enabled(p_source: *Source) c_int;
    pub const getEnabled = e_source_get_enabled;

    /// Returns an instance of some `edataserver.SourceExtension` subclass which registered
    /// itself under `extension_name`.  If no such instance exists within `source`,
    /// one will be created.  It is the caller's responsibility to know which
    /// subclass is being returned.
    ///
    /// If you just want to test for the existence of an extension within `source`
    /// without creating it, use `edataserver.Source.hasExtension`.
    ///
    /// Extension instances are owned by their `edataserver.Source` and should not be
    /// referenced directly.  Instead, reference the `edataserver.Source` instance and
    /// use this function to fetch the extension instance as needed.
    extern fn e_source_get_extension(p_source: *Source, p_extension_name: [*:0]const u8) *edataserver.SourceExtension;
    pub const getExtension = e_source_get_extension;

    /// Asynchronously calls the GetLastCredentialsRequiredArguments method
    /// on the server side, to get the last values used for the 'credentials-required'
    /// signal. See `edataserver.Source.getLastCredentialsRequiredArgumentsSync` for
    /// more information.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.Source.getLastCredentialsRequiredArgumentsFinish` to get
    /// the result of the operation.
    extern fn e_source_get_last_credentials_required_arguments(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getLastCredentialsRequiredArguments = e_source_get_last_credentials_required_arguments;

    /// Finishes the operation started with `edataserver.Source.getLastCredentialsRequiredArguments`.
    /// See `edataserver.Source.getLastCredentialsRequiredArgumentsSync` for more information
    /// about the output arguments.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_get_last_credentials_required_arguments_finish(p_source: *Source, p_result: *gio.AsyncResult, p_out_reason: *edataserver.SourceCredentialsReason, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_out_op_error: **glib.Error, p_error: ?*?*glib.Error) c_int;
    pub const getLastCredentialsRequiredArgumentsFinish = e_source_get_last_credentials_required_arguments_finish;

    /// Retrieves the last used arguments of the 'credentials-required' signal emission.
    /// If there was none emitted yet, or a corresponding 'authenitcate' had been emitted
    /// already, then the `out_reason` is set to `E_SOURCE_CREDENTIALS_REASON_UNKNOWN`
    /// and the value of other 'out' arguments is set to no values.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`. The result gchar
    /// values should be freed with `glib.free` when no longer needed.
    extern fn e_source_get_last_credentials_required_arguments_sync(p_source: *Source, p_out_reason: *edataserver.SourceCredentialsReason, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_out_op_error: **glib.Error, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getLastCredentialsRequiredArgumentsSync = e_source_get_last_credentials_required_arguments_sync;

    /// Asynchronously obtains the OAuth 2.0 access token for `source` along
    /// with its expiry in seconds from the current time (or 0 if unknown).
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.getOauth2AccessTokenFinish` to get the result of the
    /// operation.
    extern fn e_source_get_oauth2_access_token(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getOauth2AccessToken = e_source_get_oauth2_access_token;

    /// Finishes the operation started with `edataserver.Source.getOauth2AccessToken`.
    ///
    /// Free the returned access token with `glib.free` when finished with it.
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_source_get_oauth2_access_token_finish(p_source: *Source, p_result: *gio.AsyncResult, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) c_int;
    pub const getOauth2AccessTokenFinish = e_source_get_oauth2_access_token_finish;

    /// Obtains the OAuth 2.0 access token for `source` along with its expiry
    /// in seconds from the current time (or 0 if unknown).
    ///
    /// Free the returned access token with `glib.free` when finished with it.
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_source_get_oauth2_access_token_sync(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) c_int;
    pub const getOauth2AccessTokenSync = e_source_get_oauth2_access_token_sync;

    /// Returns the unique identifier string of the parent `edataserver.Source`.
    extern fn e_source_get_parent(p_source: *Source) ?[*:0]const u8;
    pub const getParent = e_source_get_parent;

    /// Returns whether new resources can be created on a remote server by
    /// calling `edataserver.Source.remoteCreate` on `source`.
    ///
    /// Generally this is only `TRUE` if `source` has an `edataserver.SourceCollection`
    /// extension, which means there is an `ECollectionBackend` in the D-Bus
    /// service that can handle create requests.  If `source` does not have
    /// this capability, calls to `edataserver.Source.remoteCreate` will fail.
    extern fn e_source_get_remote_creatable(p_source: *Source) c_int;
    pub const getRemoteCreatable = e_source_get_remote_creatable;

    /// Returns whether the resource represented by `source` can be deleted
    /// from a remote server by calling `edataserver.Source.remoteDelete`.
    ///
    /// Generally this is only `TRUE` if `source` is a child of an `edataserver.Source`
    /// which has an `edataserver.SourceCollection` extension, which means there is an
    /// `ECollectionBackend` in the D-Bus service that can handle delete
    /// requests.  If `source` does not have this capability, calls to
    /// `edataserver.Source.remoteDelete` will fail.
    extern fn e_source_get_remote_deletable(p_source: *Source) c_int;
    pub const getRemoteDeletable = e_source_get_remote_deletable;

    /// Returns whether the D-Bus service will allow `source` to be removed.
    /// If `source` is not writable, calls to `edataserver.Source.remove` will fail.
    extern fn e_source_get_removable(p_source: *Source) c_int;
    pub const getRemovable = e_source_get_removable;

    /// Returns the unique identifier string for `source`.
    extern fn e_source_get_uid(p_source: *Source) [*:0]const u8;
    pub const getUid = e_source_get_uid;

    /// Returns whether the D-Bus service will accept changes to `source`.
    /// If `source` is not writable, calls to `edataserver.Source.write` will fail.
    extern fn e_source_get_writable(p_source: *Source) c_int;
    pub const getWritable = e_source_get_writable;

    /// Checks whether `source` has an `edataserver.SourceExtension` with the given name.
    extern fn e_source_has_extension(p_source: *Source, p_extension_name: [*:0]const u8) c_int;
    pub const hasExtension = e_source_has_extension;

    /// Generates a hash value for `source`.  This function is intended for
    /// easily hashing an `edataserver.Source` to add to a `glib.HashTable` or similar data
    /// structure.
    extern fn e_source_hash(p_source: *Source) c_uint;
    pub const hash = e_source_hash;

    /// Asynchronously calls the InvokeAuthenticate method on the server side,
    /// thus the backend knows what credentials to use to connect to its (possibly
    /// remote) data store.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.Source.invokeAuthenticateFinish` to get the result of the operation.
    extern fn e_source_invoke_authenticate(p_source: *Source, p_credentials: ?*const edataserver.NamedParameters, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const invokeAuthenticate = e_source_invoke_authenticate;

    /// Finishes the operation started with `edataserver.Source.invokeAuthenticate`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_invoke_authenticate_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const invokeAuthenticateFinish = e_source_invoke_authenticate_finish;

    /// Calls the InvokeAuthenticate method on the server side, thus the backend
    /// knows what credentials to use to connect to its (possibly remote) data store.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_invoke_authenticate_sync(p_source: *Source, p_credentials: ?*const edataserver.NamedParameters, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const invokeAuthenticateSync = e_source_invoke_authenticate_sync;

    /// Asynchronously calls the InvokeCredentialsRequired method on the server side,
    /// to inform clients that credentials are required.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.Source.invokeCredentialsRequiredFinish` to get the result of the operation.
    extern fn e_source_invoke_credentials_required(p_source: *Source, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: ?*const glib.Error, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const invokeCredentialsRequired = e_source_invoke_credentials_required;

    /// Finishes the operation started with `edataserver.Source.invokeCredentialsRequired`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_invoke_credentials_required_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const invokeCredentialsRequiredFinish = e_source_invoke_credentials_required_finish;

    /// Let's the client-side know that credentials are required. The `reason` defines which
    /// parameters are used. The client passed the credentials with an `edataserver.Source.invokeAuthenticate`
    /// call.
    ///
    /// The `E_SOURCE_CREDENTIALS_REASON_REQUIRED` is used for the first credentials prompt,
    /// when the client can return credentials as stored from the previous success login.
    ///
    /// The `E_SOURCE_CREDENTIALS_REASON_REJECTED` is used when the previously used credentials
    /// had been rejected by the server. That usually means that the user should be asked
    /// to provide/correct the credentials.
    ///
    /// The `E_SOURCE_CREDENTIALS_REASON_SSL_FAILED` is used when a secured connection failed
    /// due to some server-side certificate issues.
    ///
    /// The `E_SOURCE_CREDENTIALS_REASON_ERROR` is used when the server returned an error.
    /// It is not possible to connect to it at the moment usually.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_invoke_credentials_required_sync(p_source: *Source, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: ?*const glib.Error, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const invokeCredentialsRequiredSync = e_source_invoke_credentials_required_sync;

    /// Asynchronously looks up a password for `source`.  Both the default and
    /// session keyrings are queried.  This operation does not rely on the
    /// registry service and therefore works for any `edataserver.Source` -- registered
    /// or "scratch".
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.lookupPasswordFinish` to get the result of the operation.
    extern fn e_source_lookup_password(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const lookupPassword = e_source_lookup_password;

    /// Finishes the operation started with `edataserver.Source.lookupPassword`.
    ///
    /// Note the boolean return value indicates whether the lookup operation
    /// itself completed successfully, not whether a password was found.  If
    /// no password was found, the function will set `out_password` to `NULL`
    /// but still return `TRUE`.  If an error occurs, the function sets `error`
    /// and returns `FALSE`.
    extern fn e_source_lookup_password_finish(p_source: *Source, p_result: *gio.AsyncResult, p_out_password: ?*[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const lookupPasswordFinish = e_source_lookup_password_finish;

    /// Looks up a password for `source`.  Both the default and session keyrings
    /// are queried.  This operation does not rely on the registry service and
    /// therefore works for any `edataserver.Source` -- registered or "scratch".
    ///
    /// Note the boolean return value indicates whether the lookup operation
    /// itself completed successfully, not whether a password was found.  If
    /// no password was found, the function will set `out_password` to `NULL`
    /// but still return `TRUE`.  If an error occurs, the function sets `error`
    /// and returns `FALSE`.
    extern fn e_source_lookup_password_sync(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_out_password: ?*[*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const lookupPasswordSync = e_source_lookup_password_sync;

    /// Asynchronously loads a signature from the signature file for `source`,
    /// which is given by `edataserver.SourceMailSignature.getFile`.
    ///
    /// If the signature file is executable, it will be executed and its output
    /// captured as the email signature content.  If the signature file is not
    /// executable, the email signature content is read directly from the file.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `edataserver.Source.mailSignatureLoadFinish` to get the result of
    /// the operation.
    extern fn e_source_mail_signature_load(p_source: *Source, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const mailSignatureLoad = e_source_mail_signature_load;

    /// Finishes an operation started with `edataserver.Source.mailSignatureLoad`.  The
    /// signature file contents are placed in `contents`, and `length` is set to
    /// the size of the `contents` string.  The `contents` string should be freed
    /// with `glib.free` when no longer needed.
    extern fn e_source_mail_signature_load_finish(p_source: *Source, p_result: *gio.AsyncResult, p_contents: *[*:0]u8, p_length: ?*usize, p_error: ?*?*glib.Error) c_int;
    pub const mailSignatureLoadFinish = e_source_mail_signature_load_finish;

    /// Loads a signature from the signature file for `source`, which is
    /// given by `edataserver.SourceMailSignature.getFile`.  The signature contents
    /// are placed in `contents`, and `length` is set to the size of the `contents`
    /// string.  The `contents` string should be freed with `glib.free` when no
    /// longer needed.
    ///
    /// If the signature file is executable, it will be executed and its output
    /// captured as the email signature content.  If the signature file is not
    /// executable, the email signature content is read directly from the file.
    extern fn e_source_mail_signature_load_sync(p_source: *Source, p_contents: *[*:0]u8, p_length: ?*usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const mailSignatureLoadSync = e_source_mail_signature_load_sync;

    /// Asynchrously replaces the signature file for `source` with the given
    /// `contents` of `length` bytes.  The signature file for `source` is given
    /// by `edataserver.SourceMailSignature.getFile`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `edataserver.Source.mailSignatureReplaceFinish` to get the result
    /// of the operation.
    extern fn e_source_mail_signature_replace(p_source: *Source, p_contents: [*:0]const u8, p_length: usize, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const mailSignatureReplace = e_source_mail_signature_replace;

    /// Finishes an operation started with `edataserver.Source.mailSignatureReplace`.
    extern fn e_source_mail_signature_replace_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const mailSignatureReplaceFinish = e_source_mail_signature_replace_finish;

    /// Replaces the signature file for `source` with the given `contents`
    /// of `length` bytes.  The signature file for `source` is given by
    /// `edataserver.SourceMailSignature.getFile`.
    extern fn e_source_mail_signature_replace_sync(p_source: *Source, p_contents: [*:0]const u8, p_length: usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const mailSignatureReplaceSync = e_source_mail_signature_replace_sync;

    /// Asynchronously replaces the signature file for `source` with a symbolic
    /// link to `symlink_target`, which should be an executable file that prints
    /// a mail signature to standard output.  The signature file for `source`
    /// is given by `edataserver.SourceMailSignature.getFile`.
    ///
    /// When the operation is finished, `callback` will be called.  You can
    /// then call `edataserver.Source.mailSignatureSymlinkFinish` to get the result
    /// of the operation.
    extern fn e_source_mail_signature_symlink(p_source: *Source, p_symlink_target: [*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const mailSignatureSymlink = e_source_mail_signature_symlink;

    /// Finishes an operation started with `edataserver.Source.mailSignatureSymlink`.
    extern fn e_source_mail_signature_symlink_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const mailSignatureSymlinkFinish = e_source_mail_signature_symlink_finish;

    /// Replaces the signature file for `source` with a symbolic link to
    /// `symlink_target`, which should be an executable file that prints
    /// a mail signature to standard output.  The signature file for
    /// `source` is given by `edataserver.SourceMailSignature.getFile`.
    extern fn e_source_mail_signature_symlink_sync(p_source: *Source, p_symlink_target: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const mailSignatureSymlinkSync = e_source_mail_signature_symlink_sync;

    /// Asynchronously determines what proxy, if any, to use to connect to `uri`.
    /// See `edataserver.Source.proxyLookupSync` for more details.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.proxyLookupFinish` to get the result of the operation.
    extern fn e_source_proxy_lookup(p_source: *Source, p_uri: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const proxyLookup = e_source_proxy_lookup;

    /// Finishes the operation started with `edataserver.Source.proxyLookup`.
    ///
    /// Free the returned proxy URIs with `glib.strfreev` when finished with them.
    extern fn e_source_proxy_lookup_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*][*:0]u8;
    pub const proxyLookupFinish = e_source_proxy_lookup_finish;

    /// Looks into `source`'s `edataserver.SourceProxy` extension to determine what proxy,
    /// if any, to use to connect to `uri`.  The returned proxy URIs are of the
    /// same form described by `gio.ProxyResolver.lookup`.
    ///
    /// The proxy extension's `edataserver.SourceProxy.properties.method` controls how proxy URIs are
    /// determined:
    ///
    /// When using `E_PROXY_METHOD_DEFAULT`, the function will defer to the
    /// `gio.ProxyResolver` returned by `gio.proxyResolverGetDefault`.
    ///
    /// When using `E_PROXY_METHOD_MANUAL`, the function will configure a
    /// `gio.SimpleProxyResolver` from the HTTP, HTTPS, FTP and SOCKS properties,
    /// as well as `edataserver.SourceProxy.properties.ignore`-hosts.
    ///
    /// When using `E_PROXY_METHOD_AUTO`, the function will execute a proxy
    /// auto-config (PAC) file at `edataserver.SourceProxy.properties.autoconfig`-url.
    ///
    /// When using `E_PROXY_METHOD_NONE`, the function will only return
    /// <literal>direct://</literal>.
    ///
    /// If `source` does not have an `edataserver.SourceProxy` extension, the function sets
    /// `error` to `G_IO_ERROR_NOT_SUPPORTED` and returns `NULL`.
    ///
    /// Free the returned proxy URIs with `glib.strfreev` when finished with them.
    extern fn e_source_proxy_lookup_sync(p_source: *Source, p_uri: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*][*:0]u8;
    pub const proxyLookupSync = e_source_proxy_lookup_sync;

    /// Returns the `gio.DBusObject` that was passed to `edataserver.Source.new`.
    ///
    /// The returned `gio.DBusObject` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_ref_dbus_object(p_source: *Source) ?*gio.DBusObject;
    pub const refDbusObject = e_source_ref_dbus_object;

    /// Returns the `glib.MainContext` on which event sources for `source` are to
    /// be attached.
    ///
    /// The returned `glib.MainContext` is referenced for thread-safety and must be
    /// unreferenced with `glib.MainContext.unref` when finished with it.
    extern fn e_source_ref_main_context(p_source: *Source) *glib.MainContext;
    pub const refMainContext = e_source_ref_main_context;

    /// This is a simple way to schedule a periodic data source refresh.
    ///
    /// Adds a timeout `glib.Source` to `context` and handles all the bookkeeping
    /// if `source`'s refresh `edataserver.SourceRefresh.properties.enabled` state or its refresh
    /// `edataserver.SourceRefresh.properties.interval`-minutes value changes.  The `callback` is
    /// expected to dispatch an asynchronous job to connect to and fetch
    /// updates from a remote server.
    ///
    /// The returned ID can be passed to `edataserver.Source.refreshRemoveTimeout` to
    /// remove the timeout from `context`.  Note the ID is a private handle and
    /// cannot be passed to `glib.sourceRemove`.
    extern fn e_source_refresh_add_timeout(p_source: *Source, p_context: ?*glib.MainContext, p_callback: edataserver.SourceRefreshFunc, p_user_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
    pub const refreshAddTimeout = e_source_refresh_add_timeout;

    /// For all timeouts added with `edataserver.Source.refreshAddTimeout`, invokes
    /// the `edataserver.SourceRefreshFunc` callback immediately and then, if the refresh
    /// `edataserver.SourceRefresh.properties.enabled` state is TRUE, reschedules the timeout.
    ///
    /// This function is called automatically when the `edataserver.Source` switches from
    /// disabled to enabled, but can also be useful when a network connection
    /// becomes available or when waking up from hibernation or suspend.
    extern fn e_source_refresh_force_timeout(p_source: *Source) void;
    pub const refreshForceTimeout = e_source_refresh_force_timeout;

    /// Removes a timeout `glib.Source` added by `edataserver.Source.refreshAddTimeout`.
    extern fn e_source_refresh_remove_timeout(p_source: *Source, p_refresh_timeout_id: c_uint) c_int;
    pub const refreshRemoveTimeout = e_source_refresh_remove_timeout;

    /// Removes all timeout `glib.Source`'s added by `edataserver.Source.refreshAddTimeout`
    /// whose callback data pointer matches `user_data`.
    extern fn e_source_refresh_remove_timeouts_by_data(p_source: *Source, p_user_data: ?*anyopaque) c_uint;
    pub const refreshRemoveTimeoutsByData = e_source_refresh_remove_timeouts_by_data;

    /// Asynchronously creates a new remote resource by picking out relevant
    /// details from `scratch_source`.  The `scratch_source` must be an `edataserver.Source`
    /// with no `gio.DBusObject`.  The `source` must be `edataserver.Source.properties.remote`-creatable.
    ///
    /// The details required to create the resource vary by `ECollectionBackend`,
    /// but in most cases the `scratch_source` need only define the resource type
    /// (address book, calendar, etc.), a display name for the resource, and
    /// possibly a server-side path or ID for the resource.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.remoteCreateFinish` to get the result of the operation.
    extern fn e_source_remote_create(p_source: *Source, p_scratch_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const remoteCreate = e_source_remote_create;

    /// Finishes the operation started with `edataserver.Source.remoteCreate`.  If
    /// an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_source_remote_create_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const remoteCreateFinish = e_source_remote_create_finish;

    /// Creates a new remote resource by picking out relevant details from
    /// `scratch_source`.  The `scratch_source` must be an `edataserver.Source` with no
    /// `gio.DBusObject`.  The `source` must be `edataserver.Source.properties.remote`-creatable.
    ///
    /// The details required to create the resource vary by `ECollectionBackend`,
    /// but in most cases the `scratch_source` need only define the resource type
    /// (address book, calendar, etc.), a display name for the resource, and
    /// possibly a server-side path or ID for the resource.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_source_remote_create_sync(p_source: *Source, p_scratch_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const remoteCreateSync = e_source_remote_create_sync;

    /// Asynchronously deletes the resource represented by `source` from a remote
    /// server.  The `source` must be `edataserver.Source.properties.remote`-deletable.  This will also
    /// delete the key file for `source` and broadcast its removal to all clients,
    /// similar to `edataserver.Source.remove`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.remoteDeleteFinish` to get the result of the operation.
    extern fn e_source_remote_delete(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const remoteDelete = e_source_remote_delete;

    /// Finishes the operation started with `edataserver.Source.remoteDelete`.  If
    /// an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_source_remote_delete_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const remoteDeleteFinish = e_source_remote_delete_finish;

    /// Deletes the resource represented by `source` from a remote server.
    /// The `source` must be `edataserver.Source.properties.remote`-deletable.  This will also delete
    /// the key file for `source` and broadcast its removal to all clients,
    /// similar to `edataserver.Source.removeSync`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_source_remote_delete_sync(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const remoteDeleteSync = e_source_remote_delete_sync;

    /// Asynchronously requests the D-Bus service to delete the key files for
    /// `source` and all of its descendants and broadcast their removal to all
    /// clients.  The `source` must be `edataserver.Source.properties.removable`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.removeFinish` to get the result of the operation.
    extern fn e_source_remove(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const remove = e_source_remove;

    /// Finishes the operation started with `edataserver.Source.remove`.  If an
    /// error occurred, the function will set `error` and return `FALSE`.
    extern fn e_source_remove_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const removeFinish = e_source_remove_finish;

    /// Requests the D-Bus service to delete the key files for `source` and all of
    /// its descendants and broadcast their removal to all clients.  The `source`
    /// must be `edataserver.Source.properties.removable`.
    ///
    /// If an error occurs, the functon will set `error` and return `FALSE`.
    extern fn e_source_remove_sync(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeSync = e_source_remove_sync;

    /// Set's current connection status of the `source`.
    extern fn e_source_set_connection_status(p_source: *Source, p_connection_status: edataserver.SourceConnectionStatus) void;
    pub const setConnectionStatus = e_source_set_connection_status;

    /// Sets the display name for `source`.  The `display_name` argument must be a
    /// valid UTF-8 string.  Use the display name to represent the `edataserver.Source` in a
    /// user interface.
    ///
    /// The internal copy of `display_name` is automatically stripped of leading
    /// and trailing whitespace.
    extern fn e_source_set_display_name(p_source: *Source, p_display_name: [*:0]const u8) void;
    pub const setDisplayName = e_source_set_display_name;

    /// Enables or disables `source`.
    ///
    /// An application should try to honor this setting if at all possible,
    /// even if it does not provide a way to change the setting through its
    /// user interface.  Disabled data sources should generally be hidden.
    extern fn e_source_set_enabled(p_source: *Source, p_enabled: c_int) void;
    pub const setEnabled = e_source_set_enabled;

    /// Identifies the parent of `source` by its unique identifier string.
    /// This can only be set prior to adding `source` to an `edataserver.SourceRegistry`.
    ///
    /// The internal copy of `edataserver.Source.properties.parent` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_set_parent(p_source: *Source, p_parent: ?[*:0]const u8) void;
    pub const setParent = e_source_set_parent;

    /// Asynchronously stores a password for `source`.  This operation does
    /// not rely on the registry service and therefore works for any `edataserver.Source`
    /// -- registered or "scratch".
    ///
    /// If `permanently` is `TRUE`, the password is stored in the default keyring.
    /// Otherwise the password is stored in the memory-only session keyring.  If
    /// an error occurs, the function sets `error` and returns `FALSE`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.storePasswordFinish` to get the result of the operation.
    extern fn e_source_store_password(p_source: *Source, p_password: [*:0]const u8, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const storePassword = e_source_store_password;

    /// Finishes the operation started with `edataserver.Source.storePassword`.
    extern fn e_source_store_password_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const storePasswordFinish = e_source_store_password_finish;

    /// Stores a password for `source`.  This operation does not rely on the
    /// registry service and therefore works for any `edataserver.Source` -- registered
    /// or "scratch".
    ///
    /// If `permanently` is `TRUE`, the password is stored in the default keyring.
    /// Otherwise the password is stored in the memory-only session keyring.  If
    /// an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_store_password_sync(p_source: *Source, p_password: [*:0]const u8, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const storePasswordSync = e_source_store_password_sync;

    /// Outputs the current contents of `source` as a key file string.
    /// Free the returned string with `glib.free`.
    extern fn e_source_to_string(p_source: *Source, p_length: ?*usize) [*:0]u8;
    pub const toString = e_source_to_string;

    /// Asynchronously calls the UnsetLastCredentialsRequiredArguments method
    /// on the server side, to unset the last values used for the 'credentials-required'
    /// signal.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.Source.unsetLastCredentialsRequiredArgumentsFinish` to get
    /// the result of the operation.
    extern fn e_source_unset_last_credentials_required_arguments(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const unsetLastCredentialsRequiredArguments = e_source_unset_last_credentials_required_arguments;

    /// Finishes the operation started with `edataserver.Source.unsetLastCredentialsRequiredArguments`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_unset_last_credentials_required_arguments_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const unsetLastCredentialsRequiredArgumentsFinish = e_source_unset_last_credentials_required_arguments_finish;

    /// Unsets the last used arguments of the 'credentials-required' signal emission.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_unset_last_credentials_required_arguments_sync(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const unsetLastCredentialsRequiredArgumentsSync = e_source_unset_last_credentials_required_arguments_sync;

    /// Asynchronously submits the current contents of `source` to the D-Bus
    /// service to be written to disk and broadcast to other clients.  The
    /// `source` must be `edataserver.Source.properties.writable`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.Source.writeFinish` to get the result of the operation.
    extern fn e_source_write(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const write = e_source_write;

    /// Finishes the operation started with `edataserver.Source.write`.  If an
    /// error occurred, the function will set `error` and return `FALSE`.
    extern fn e_source_write_finish(p_source: *Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const writeFinish = e_source_write_finish;

    /// Submits the current contents of `source` to the D-Bus service to be
    /// written to disk and broadcast to other clients.  The `source` must
    /// be `edataserver.Source.properties.writable`.
    ///
    /// If an error occurs, the functon will set `error` and return `FALSE`.
    extern fn e_source_write_sync(p_source: *Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const writeSync = e_source_write_sync;

    extern fn e_source_get_type() usize;
    pub const getGObjectType = e_source_get_type;

    extern fn g_object_ref(p_self: *edataserver.Source) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.Source) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Source, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceAddressBook = extern struct {
    pub const Parent = edataserver.SourceBackend;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceAddressBookClass;
    f_parent: edataserver.SourceBackend,
    f_priv: ?*edataserver.SourceAddressBookPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const order = struct {
            pub const name = "order";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    extern fn e_source_address_book_get_order(p_extension: *SourceAddressBook) c_uint;
    pub const getOrder = e_source_address_book_get_order;

    /// Set the sorting order of the source.
    extern fn e_source_address_book_set_order(p_extension: *SourceAddressBook, p_order: c_uint) void;
    pub const setOrder = e_source_address_book_set_order;

    extern fn e_source_address_book_get_type() usize;
    pub const getGObjectType = e_source_address_book_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceAddressBook) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceAddressBook) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceAddressBook, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceAlarms = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceAlarmsClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceAlarmsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const for_every_event = struct {
            pub const name = "for-every-event";

            pub const Type = c_int;
        };

        pub const include_me = struct {
            pub const name = "include-me";

            pub const Type = c_int;
        };

        pub const last_notified = struct {
            pub const name = "last-notified";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceAlarms.getLastNotified`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_alarms_dup_last_notified(p_extension: *SourceAlarms) ?[*:0]u8;
    pub const dupLastNotified = e_source_alarms_dup_last_notified;

    /// Returns whether the user should be alerted about all upcoming appointments
    /// in the calendar described by the `edataserver.Source` to which `extension` belongs.
    ///
    /// This is used in addition to the GSettings key defall-reminder-enabled
    /// in org.gnome.evolution-data-server.calendar.
    extern fn e_source_alarms_get_for_every_event(p_extension: *SourceAlarms) c_int;
    pub const getForEveryEvent = e_source_alarms_get_for_every_event;

    /// Returns whether the user should be alerted about upcoming appointments
    /// in the calendar described by the `edataserver.Source` to which `extension` belongs.
    ///
    /// Alarm daemons such as evolution-alarm-notify can use this property to
    /// decide which calendars to query for upcoming appointments.
    extern fn e_source_alarms_get_include_me(p_extension: *SourceAlarms) c_int;
    pub const getIncludeMe = e_source_alarms_get_include_me;

    /// Returns an ISO 8601 formatted timestamp of when the user was last
    /// alerted about an upcoming appointment in the calendar described by
    /// the `edataserver.Source` to which `extension` belongs.  If no valid timestamp
    /// has been set, the function will return `NULL`.
    extern fn e_source_alarms_get_last_notified(p_extension: *SourceAlarms) ?[*:0]const u8;
    pub const getLastNotified = e_source_alarms_get_last_notified;

    /// Sets whether the user should be alerted about every event in
    /// the calendar described by the `edataserver.Source` to which `extension` belongs.
    ///
    /// This is used in addition to the GSettings key defall-reminder-enabled
    /// in org.gnome.evolution-data-server.calendar.
    extern fn e_source_alarms_set_for_every_event(p_extension: *SourceAlarms, p_for_every_event: c_int) void;
    pub const setForEveryEvent = e_source_alarms_set_for_every_event;

    /// Sets whether the user should be alerted about upcoming appointments in
    /// the calendar described by the `edataserver.Source` to which `extension` belongs.
    ///
    /// Alarm daemons such as evolution-alarm-notify can use this property to
    /// decide which calendars to query for upcoming appointments.
    extern fn e_source_alarms_set_include_me(p_extension: *SourceAlarms, p_include_me: c_int) void;
    pub const setIncludeMe = e_source_alarms_set_include_me;

    /// Sets an ISO 8601 formatted timestamp of when the user was last
    /// alerted about an upcoming appointment in the calendar described
    /// by the `edataserver.Source` to which `extension` belongs.
    ///
    /// If `last_notified` is non-`NULL`, the function will validate the
    /// timestamp before setting the `edataserver.SourceAlarms.properties.last`-notified property.
    /// Invalid timestamps are discarded with a runtime warning.
    ///
    /// Generally, this function should only be called by an alarm daemon
    /// such as evolution-alarm-notify.
    extern fn e_source_alarms_set_last_notified(p_extension: *SourceAlarms, p_last_notified: ?[*:0]const u8) void;
    pub const setLastNotified = e_source_alarms_set_last_notified;

    extern fn e_source_alarms_get_type() usize;
    pub const getGObjectType = e_source_alarms_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceAlarms) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceAlarms) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceAlarms, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceAuthentication = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceAuthenticationClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceAuthenticationPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const connectable = struct {
            pub const name = "connectable";

            pub const Type = ?*gio.SocketConnectable;
        };

        pub const credential_name = struct {
            pub const name = "credential-name";

            pub const Type = ?[*:0]u8;
        };

        pub const host = struct {
            pub const name = "host";

            pub const Type = ?[*:0]u8;
        };

        pub const is_external = struct {
            pub const name = "is-external";

            pub const Type = c_int;
        };

        pub const method = struct {
            pub const name = "method";

            pub const Type = ?[*:0]u8;
        };

        pub const port = struct {
            pub const name = "port";

            pub const Type = c_uint;
        };

        pub const proxy_uid = struct {
            pub const name = "proxy-uid";

            pub const Type = ?[*:0]u8;
        };

        pub const remember_password = struct {
            pub const name = "remember-password";

            pub const Type = c_int;
        };

        pub const user = struct {
            pub const name = "user";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceAuthentication.getCredentialName`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_authentication_dup_credential_name(p_extension: *SourceAuthentication) ?[*:0]u8;
    pub const dupCredentialName = e_source_authentication_dup_credential_name;

    /// Thread-safe variation of `edataserver.SourceAuthentication.getHost`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_authentication_dup_host(p_extension: *SourceAuthentication) ?[*:0]u8;
    pub const dupHost = e_source_authentication_dup_host;

    /// Thread-safe variation of `edataserver.SourceAuthentication.getMethod`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_authentication_dup_method(p_extension: *SourceAuthentication) ?[*:0]u8;
    pub const dupMethod = e_source_authentication_dup_method;

    /// Thread-safe variation of `edataserver.SourceAuthentication.getProxyUid`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_authentication_dup_proxy_uid(p_extension: *SourceAuthentication) [*:0]u8;
    pub const dupProxyUid = e_source_authentication_dup_proxy_uid;

    /// Thread-safe variation of `edataserver.SourceAuthentication.getUser`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_authentication_dup_user(p_extension: *SourceAuthentication) ?[*:0]u8;
    pub const dupUser = e_source_authentication_dup_user;

    /// Returns the credential name used to pass the stored or gathered credential
    /// (like password) into the `edataserver.Source.invokeAuthenticate`. This is
    /// a counterpart of the authentication method. The `NULL` means to use
    /// the default name, which is `E_SOURCE_CREDENTIAL_PASSWORD`.
    extern fn e_source_authentication_get_credential_name(p_extension: *SourceAuthentication) ?[*:0]const u8;
    pub const getCredentialName = e_source_authentication_get_credential_name;

    /// Returns the host name used to authenticate to a remote account.
    extern fn e_source_authentication_get_host(p_extension: *SourceAuthentication) ?[*:0]const u8;
    pub const getHost = e_source_authentication_get_host;

    /// Get if the authentication is done by an external application such as a
    /// Single Sign On application (e.g. GNOME Online Accounts)
    extern fn e_source_authentication_get_is_external(p_extension: *SourceAuthentication) c_int;
    pub const getIsExternal = e_source_authentication_get_is_external;

    /// Returns the authentication method for a remote account.  There are
    /// no pre-defined method names; backends are free to set this however
    /// they wish.  If authentication is not required for a remote account,
    /// the convention is to set `edataserver.SourceAuthentication.properties.method` to "none".
    extern fn e_source_authentication_get_method(p_extension: *SourceAuthentication) ?[*:0]const u8;
    pub const getMethod = e_source_authentication_get_method;

    /// Returns the port number used to authenticate to a remote account.
    extern fn e_source_authentication_get_port(p_extension: *SourceAuthentication) u16;
    pub const getPort = e_source_authentication_get_port;

    /// Returns the `edataserver.Source.properties.uid` of the `edataserver.Source` that holds network proxy
    /// settings for use when connecting to a remote account.
    extern fn e_source_authentication_get_proxy_uid(p_extension: *SourceAuthentication) [*:0]const u8;
    pub const getProxyUid = e_source_authentication_get_proxy_uid;

    /// Returns whether to offer to remember the provided password by default
    /// in password prompts.  This way, if the user unchecks the option it will
    /// be unchecked by default in future password prompts.
    extern fn e_source_authentication_get_remember_password(p_extension: *SourceAuthentication) c_int;
    pub const getRememberPassword = e_source_authentication_get_remember_password;

    /// Returns the user name used to authenticate to a remote account.
    extern fn e_source_authentication_get_user(p_extension: *SourceAuthentication) ?[*:0]const u8;
    pub const getUser = e_source_authentication_get_user;

    /// Returns a `gio.SocketConnectable` instance constructed from `extension`'s
    /// `edataserver.SourceAuthentication.properties.host` and `edataserver.SourceAuthentication.properties.port` properties,
    /// or `NULL` if the `edataserver.SourceAuthentication.properties.host` is not set.
    ///
    /// The returned `gio.SocketConnectable` is referenced for thread-safety and must
    /// be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_authentication_ref_connectable(p_extension: *SourceAuthentication) ?*gio.SocketConnectable;
    pub const refConnectable = e_source_authentication_ref_connectable;

    /// This is a convenience function which returns whether authentication
    /// is required at all, regardless of the method used.  This relies on
    /// the convention of setting `edataserver.SourceAuthentication.properties.method` to "none"
    /// when authentication is <emphasis>not</emphasis> required.
    extern fn e_source_authentication_required(p_extension: *SourceAuthentication) c_int;
    pub const required = e_source_authentication_required;

    /// Sets the credential name used to pass the stored or gathered credential
    /// (like password) into the `edataserver.Source.invokeAuthenticate`. This is
    /// a counterpart of the authentication method. The `NULL` means to use
    /// the default name, which is `E_SOURCE_CREDENTIAL_PASSWORD`.
    ///
    /// The internal copy of `credential_name` is automatically stripped
    /// of leading and trailing whitespace. If the resulting string is
    /// empty, `NULL` is set instead.
    extern fn e_source_authentication_set_credential_name(p_extension: *SourceAuthentication, p_credential_name: ?[*:0]const u8) void;
    pub const setCredentialName = e_source_authentication_set_credential_name;

    /// Sets the host name used to authenticate to a remote account.
    ///
    /// The internal copy of `host` is automatically stripped of leading and
    /// trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_authentication_set_host(p_extension: *SourceAuthentication, p_host: ?[*:0]const u8) void;
    pub const setHost = e_source_authentication_set_host;

    /// Set if the authentication is done by an external application such as a
    /// Single Sign On application (e.g. GNOME Online Accounts)
    extern fn e_source_authentication_set_is_external(p_extension: *SourceAuthentication, p_is_external: c_int) void;
    pub const setIsExternal = e_source_authentication_set_is_external;

    /// Sets the authentication method for a remote account.  There are no
    /// pre-defined method names; backends are free to set this however they
    /// wish.  If authentication is not required for a remote account, the
    /// convention is to set the method to "none".  In keeping with that
    /// convention, `edataserver.SourceAuthentication.properties.method` will be set to "none" if
    /// `method` is `NULL` or an empty string.
    extern fn e_source_authentication_set_method(p_extension: *SourceAuthentication, p_method: ?[*:0]const u8) void;
    pub const setMethod = e_source_authentication_set_method;

    /// Sets the port number used to authenticate to a remote account.
    extern fn e_source_authentication_set_port(p_extension: *SourceAuthentication, p_port: u16) void;
    pub const setPort = e_source_authentication_set_port;

    /// Sets the `edataserver.Source.properties.uid` of the `edataserver.Source` that holds network proxy settings
    /// for use when connecting to a remote account.
    extern fn e_source_authentication_set_proxy_uid(p_extension: *SourceAuthentication, p_proxy_uid: [*:0]const u8) void;
    pub const setProxyUid = e_source_authentication_set_proxy_uid;

    /// Sets whether to offer to remember the provided password by default in
    /// password prompts.  This way, if the user unchecks the option it will be
    /// unchecked by default in future password prompts.
    extern fn e_source_authentication_set_remember_password(p_extension: *SourceAuthentication, p_remember_password: c_int) void;
    pub const setRememberPassword = e_source_authentication_set_remember_password;

    /// Sets the user name used to authenticate to a remote account.
    ///
    /// The internal copy of `user` is automatically stripped of leading and
    /// trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_authentication_set_user(p_extension: *SourceAuthentication, p_user: ?[*:0]const u8) void;
    pub const setUser = e_source_authentication_set_user;

    extern fn e_source_authentication_get_type() usize;
    pub const getGObjectType = e_source_authentication_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceAuthentication) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceAuthentication) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceAuthentication, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceAutocomplete = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceAutocompleteClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceAutocompletePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const include_me = struct {
            pub const name = "include-me";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns whether the address book described by the `edataserver.Source` to which
    /// `extension` belongs should be queried when the user inputs a partial
    /// contact name or email address.
    extern fn e_source_autocomplete_get_include_me(p_extension: *SourceAutocomplete) c_int;
    pub const getIncludeMe = e_source_autocomplete_get_include_me;

    /// Sets whether the address book described by the `edataserver.Source` to which
    /// `extension` belongs should be queried when the user inputs a partial
    /// contact name or email address.
    extern fn e_source_autocomplete_set_include_me(p_extension: *SourceAutocomplete, p_include_me: c_int) void;
    pub const setIncludeMe = e_source_autocomplete_set_include_me;

    extern fn e_source_autocomplete_get_type() usize;
    pub const getGObjectType = e_source_autocomplete_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceAutocomplete) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceAutocomplete) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceAutocomplete, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceAutoconfig = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceAutoconfigClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceAutoconfigPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const revision = struct {
            pub const name = "revision";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceAutoconfig.getRevision`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_autoconfig_dup_revision(p_extension: *SourceAutoconfig) [*:0]u8;
    pub const dupRevision = e_source_autoconfig_dup_revision;

    /// Returns the revision of a data source. This maps a particular version of a
    /// system-wide source to a user-specific source.
    ///
    /// If doesn't match, the system-wide source will be copied to the user-specific
    /// evolution config directory, preserving the already present fields that are
    /// not defined by the system-wide source.
    ///
    /// If it matches, no copying is done.
    extern fn e_source_autoconfig_get_revision(p_extension: *SourceAutoconfig) [*:0]const u8;
    pub const getRevision = e_source_autoconfig_get_revision;

    /// Sets the revision used to map a particular version of a system-wide source
    /// to a user-specific source.
    ///
    /// If doesn't match, the system-wide source will be copied to the user-specific
    /// evolution config directory, preserving the already present fields that are
    /// not defined by the system-wide source.
    ///
    /// If it matches, no copying is done.
    ///
    /// The internal copy of `revision` is automatically stripped of leading and
    /// trailing whitespace.
    extern fn e_source_autoconfig_set_revision(p_extension: *SourceAutoconfig, p_revision: [*:0]const u8) void;
    pub const setRevision = e_source_autoconfig_set_revision;

    extern fn e_source_autoconfig_get_type() usize;
    pub const getGObjectType = e_source_autoconfig_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceAutoconfig) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceAutoconfig) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceAutoconfig, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceBackend = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceBackendClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceBackendPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const backend_name = struct {
            pub const name = "backend-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceBackend.getBackendName`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_backend_dup_backend_name(p_extension: *SourceBackend) ?[*:0]u8;
    pub const dupBackendName = e_source_backend_dup_backend_name;

    /// Returns the backend name for `extension`.
    extern fn e_source_backend_get_backend_name(p_extension: *SourceBackend) ?[*:0]const u8;
    pub const getBackendName = e_source_backend_get_backend_name;

    /// Sets the backend name for `extension`.
    ///
    /// The internal copy of `backend_name` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_backend_set_backend_name(p_extension: *SourceBackend, p_backend_name: ?[*:0]const u8) void;
    pub const setBackendName = e_source_backend_set_backend_name;

    extern fn e_source_backend_get_type() usize;
    pub const getGObjectType = e_source_backend_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceBackend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceBackend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceBackend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceCalendar = extern struct {
    pub const Parent = edataserver.SourceSelectable;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceCalendarClass;
    f_parent: edataserver.SourceSelectable,
    f_priv: ?*edataserver.SourceCalendarPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_source_calendar_get_type() usize;
    pub const getGObjectType = e_source_calendar_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceCalendar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceCalendar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceCalendar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceCamel = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceCamelClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceCamelPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const settings = struct {
            pub const name = "settings";

            pub const Type = ?*camel.Settings;
        };
    };

    pub const signals = struct {};

    /// Generates a custom `edataserver.SourceCamel` subtype for `protocol`.  Instances of the
    /// new subtype will contain a `camel.Settings` instance of type `settings_type`.
    ///
    /// This function is called as part of `edataserver.SourceCamel.registerTypes` and
    /// should not be called explicitly, except by some groupware packages that
    /// need to share package-specific settings across their mail, calendar and
    /// address book components.  In that case the groupware package may choose
    /// to subclass `camel.Settings` rather than `edataserver.SourceExtension` since libcamel
    /// is the lowest common denominator across all components.  This function
    /// provides a way for the calendar and address book components of such a
    /// package to generate an `edataserver.SourceCamel` subtype for its `camel.Settings`
    /// subtype without having to load all available `camel.Provider` modules.
    extern fn e_source_camel_generate_subtype(p_protocol: [*:0]const u8, p_settings_type: usize) usize;
    pub const generateSubtype = e_source_camel_generate_subtype;

    /// Returns the extension name for the `edataserver.SourceCamel` subtype for `protocol`.
    /// The extension name can then be passed to `edataserver.Source.getExtension` to
    /// obtain an instance of the `edataserver.SourceCamel` subtype.
    ///
    /// For example, given a protocol named "imap" the function would return
    /// "Imap Backend".
    extern fn e_source_camel_get_extension_name(p_protocol: [*:0]const u8) [*:0]const u8;
    pub const getExtensionName = e_source_camel_get_extension_name;

    /// Returns the `gobject.Type` name of the registered `edataserver.SourceCamel` subtype for
    /// `protocol`.
    ///
    /// For example, given a protocol named "imap" the function would return
    /// "ESourceCamelImap".
    extern fn e_source_camel_get_type_name(p_protocol: [*:0]const u8) [*:0]const u8;
    pub const getTypeName = e_source_camel_get_type_name;

    /// Creates and registers subclasses of `edataserver.SourceCamel` for each available
    /// `camel.Provider`.  This function should be called once during application
    /// or library initialization.
    extern fn e_source_camel_register_types() void;
    pub const registerTypes = e_source_camel_register_types;

    /// Returns `extension`'s `edataserver.SourceCamel.properties.settings` instance, pre-configured
    /// from the `edataserver.Source` to which `extension` belongs.  Changes to the `edataserver.Source`
    /// will automatically propagate to the `edataserver.SourceCamel.properties.settings` instance and
    /// vice versa.
    ///
    /// This is essentially the glue that binds `edataserver.Source` to `camel.Service`.
    /// See `edataserver.Source.camelConfigureService`.
    extern fn e_source_camel_get_settings(p_extension: *SourceCamel) *camel.Settings;
    pub const getSettings = e_source_camel_get_settings;

    extern fn e_source_camel_get_type() usize;
    pub const getGObjectType = e_source_camel_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceCamel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceCamel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceCamel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceCollection = extern struct {
    pub const Parent = edataserver.SourceBackend;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceCollectionClass;
    f_parent: edataserver.SourceBackend,
    f_priv: ?*edataserver.SourceCollectionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const allow_sources_rename = struct {
            pub const name = "allow-sources-rename";

            pub const Type = c_int;
        };

        pub const calendar_enabled = struct {
            pub const name = "calendar-enabled";

            pub const Type = c_int;
        };

        pub const calendar_url = struct {
            pub const name = "calendar-url";

            pub const Type = ?[*:0]u8;
        };

        pub const contacts_enabled = struct {
            pub const name = "contacts-enabled";

            pub const Type = c_int;
        };

        pub const contacts_url = struct {
            pub const name = "contacts-url";

            pub const Type = ?[*:0]u8;
        };

        pub const identity = struct {
            pub const name = "identity";

            pub const Type = ?[*:0]u8;
        };

        pub const mail_enabled = struct {
            pub const name = "mail-enabled";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceCollection.getCalendarUrl`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_collection_dup_calendar_url(p_extension: *SourceCollection) ?[*:0]u8;
    pub const dupCalendarUrl = e_source_collection_dup_calendar_url;

    /// Thread-safe variation of `edataserver.SourceCollection.getContactsUrl`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_collection_dup_contacts_url(p_extension: *SourceCollection) ?[*:0]u8;
    pub const dupContactsUrl = e_source_collection_dup_contacts_url;

    /// Thread-safe variation of `edataserver.SourceCollection.getIdentity`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_collection_dup_identity(p_extension: *SourceCollection) ?[*:0]u8;
    pub const dupIdentity = e_source_collection_dup_identity;

    /// Returns whether the collection backend allows a user to rename child
    /// sources. It is meant mainly for GUI. The default is `FALSE`.
    extern fn e_source_collection_get_allow_sources_rename(p_extension: *SourceCollection) c_int;
    pub const getAllowSourcesRename = e_source_collection_get_allow_sources_rename;

    /// Returns whether calendar sources within the collection should be
    /// enabled.
    ///
    /// An `ECollectionBackend` running within the registry D-Bus service will
    /// automatically synchronize any calendar sources it maintains with the
    /// `edataserver.SourceCollection.properties.calendar`-enabled property.
    extern fn e_source_collection_get_calendar_enabled(p_extension: *SourceCollection) c_int;
    pub const getCalendarEnabled = e_source_collection_get_calendar_enabled;

    /// Returns the calendar top URL string, that is, where to search for calendar sources.
    extern fn e_source_collection_get_calendar_url(p_extension: *SourceCollection) ?[*:0]const u8;
    pub const getCalendarUrl = e_source_collection_get_calendar_url;

    /// Returns whether address book sources within the collection should be
    /// enabled.
    ///
    /// An `ECollectionBackend` running within the registry D-Bus service will
    /// automatically synchronize any address book sources it maintains with
    /// the `edataserver.SourceCollection.properties.contacts`-enabled property.
    extern fn e_source_collection_get_contacts_enabled(p_extension: *SourceCollection) c_int;
    pub const getContactsEnabled = e_source_collection_get_contacts_enabled;

    /// Returns the contacts top URL string, that is, where to search for contact sources.
    extern fn e_source_collection_get_contacts_url(p_extension: *SourceCollection) ?[*:0]const u8;
    pub const getContactsUrl = e_source_collection_get_contacts_url;

    /// Returns the string used to uniquely identify the user account at
    /// the service provider.  Often this is an email address or user name.
    extern fn e_source_collection_get_identity(p_extension: *SourceCollection) ?[*:0]const u8;
    pub const getIdentity = e_source_collection_get_identity;

    /// Returns whether mail sources within the collection should be enabled.
    ///
    /// An `ECollectionBackend` running within the registry D-Bus service will
    /// automatically synchronize any mail sources it maintains with the
    /// `edataserver.SourceCollection.properties.mail`-enabled property.
    extern fn e_source_collection_get_mail_enabled(p_extension: *SourceCollection) c_int;
    pub const getMailEnabled = e_source_collection_get_mail_enabled;

    /// Sets whether the collection backend allows a user to rename child
    /// sources. It is meant mainly for GUI. The default is `FALSE`.
    extern fn e_source_collection_set_allow_sources_rename(p_extension: *SourceCollection, p_allow_sources_rename: c_int) void;
    pub const setAllowSourcesRename = e_source_collection_set_allow_sources_rename;

    /// Sets whether calendar sources within the collection should be enabled.
    ///
    /// An `ECollectionBackend` running within the registry D-Bus service will
    /// automatically synchronize any calendar sources it maintains with the
    /// `edataserver.SourceCollection.properties.calendar`-enabled property.
    ///
    /// Calling this function from a registry service client has no effect until
    /// the change is submitted to the registry service through `edataserver.Source.write`,
    /// but there should rarely be any need for clients to call this.
    extern fn e_source_collection_set_calendar_enabled(p_extension: *SourceCollection, p_calendar_enabled: c_int) void;
    pub const setCalendarEnabled = e_source_collection_set_calendar_enabled;

    /// Sets the calendar top URL, that is, where to search for calendar sources.
    ///
    /// The internal copy of `calendar_url` is automatically stripped of leading
    /// and trailing whitespace. If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_collection_set_calendar_url(p_extension: *SourceCollection, p_calendar_url: ?[*:0]const u8) void;
    pub const setCalendarUrl = e_source_collection_set_calendar_url;

    /// Sets whether address book sources within the collection should be enabled.
    ///
    /// An `ECollectionBackend` running within the registry D-Bus service will
    /// automatically synchronize any address book sources it maintains with
    /// the `edataserver.SourceCollection.properties.contacts`-enabled property.
    ///
    /// Calling this function from a registry service client has no effect until
    /// the change is submitted to the registry service through `edataserver.Source.write`,
    /// but there should rarely be any need for clients to call this.
    extern fn e_source_collection_set_contacts_enabled(p_extension: *SourceCollection, p_contacts_enabled: c_int) void;
    pub const setContactsEnabled = e_source_collection_set_contacts_enabled;

    /// Sets the contacts top URL, that is, where to search for contact sources.
    ///
    /// The internal copy of `contacts_url` is automatically stripped of leading
    /// and trailing whitespace. If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_collection_set_contacts_url(p_extension: *SourceCollection, p_contacts_url: ?[*:0]const u8) void;
    pub const setContactsUrl = e_source_collection_set_contacts_url;

    /// Sets the string used to uniquely identify the user account at the
    /// service provider.  Often this is an email address or user name.
    ///
    /// The internal copy of `identity` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is
    /// set instead.
    extern fn e_source_collection_set_identity(p_extension: *SourceCollection, p_identity: ?[*:0]const u8) void;
    pub const setIdentity = e_source_collection_set_identity;

    /// Sets whether mail sources within the collection should be enabled.
    ///
    /// An `ECollectionBackend` running within the registry D-Bus service will
    /// automatically synchronize any mail sources it maintains with the
    /// `edataserver.SourceCollection.properties.mail`-enabled property.
    ///
    /// Calling this function from a registry service client has no effect until
    /// the changes is submitted to the registry service through `edataserver.Source.write`,
    /// but there should rarely be any need for clients to call this.
    extern fn e_source_collection_set_mail_enabled(p_extension: *SourceCollection, p_mail_enabled: c_int) void;
    pub const setMailEnabled = e_source_collection_set_mail_enabled;

    extern fn e_source_collection_get_type() usize;
    pub const getGObjectType = e_source_collection_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceCollection) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceCollection) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceCollection, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceContacts = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceContactsClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceContactsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const include_me = struct {
            pub const name = "include-me";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn e_source_contacts_get_include_me(p_extension: *SourceContacts) c_int;
    pub const getIncludeMe = e_source_contacts_get_include_me;

    extern fn e_source_contacts_set_include_me(p_extension: *SourceContacts, p_include_me: c_int) void;
    pub const setIncludeMe = e_source_contacts_set_include_me;

    extern fn e_source_contacts_get_type() usize;
    pub const getGObjectType = e_source_contacts_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceContacts) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceContacts) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceContacts, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceCredentialsProvider = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = edataserver.SourceCredentialsProviderClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.SourceCredentialsProviderPrivate,

    pub const virtual_methods = struct {
        /// Returns referenced `edataserver.Source` with the given `uid`, or `NULL`, when it could not be found.
        pub const ref_source = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8) ?*edataserver.Source {
                return gobject.ext.as(SourceCredentialsProvider.Class, p_class).f_ref_source.?(gobject.ext.as(SourceCredentialsProvider, p_provider), p_uid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8) callconv(.c) ?*edataserver.Source) void {
                gobject.ext.as(SourceCredentialsProvider.Class, p_class).f_ref_source = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The Source Registry object, which can be either `ESourceregistry` or `ESourceRegistryServer`.
        pub const registry = struct {
            pub const name = "registry";

            pub const Type = ?*gobject.Object;
        };
    };

    pub const signals = struct {};

    /// Creates a new `edataserver.SourceCredentialsProvider`, which is meant to abstract
    /// credential management for `edataserver.Source`<!-- -->-s.
    extern fn e_source_credentials_provider_new(p_registry: *edataserver.SourceRegistry) *edataserver.SourceCredentialsProvider;
    pub const new = e_source_credentials_provider_new;

    /// Returns whether a credentials prompt can be shown for the `source`.
    extern fn e_source_credentials_provider_can_prompt(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source) c_int;
    pub const canPrompt = e_source_credentials_provider_can_prompt;

    /// Returns whether the `source` can store its credentials. When `FALSE` is returned,
    /// an attempt to call `edataserver.SourceCredentialsProvider.store` or
    /// `edataserver.SourceCredentialsProvider.storeSync` will fail for this `source`.
    extern fn e_source_credentials_provider_can_store(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source) c_int;
    pub const canStore = e_source_credentials_provider_can_store;

    /// Asynchronously deletes any previously stored credentials for `source`.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.SourceCredentialsProvider.deleteFinish` to get the result
    /// of the operation.
    extern fn e_source_credentials_provider_delete(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const delete = e_source_credentials_provider_delete;

    /// Finishes the operation started with `edataserver.SourceCredentialsProvider.delete`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_delete_finish(p_provider: *SourceCredentialsProvider, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const deleteFinish = e_source_credentials_provider_delete_finish;

    /// Deletes any previously stored credentials for `source`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_delete_sync(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deleteSync = e_source_credentials_provider_delete_sync;

    /// Asynchronously looks up for credentials for `source`.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.SourceCredentialsProvider.lookupFinish` to get the result
    /// of the operation.
    extern fn e_source_credentials_provider_lookup(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const lookup = e_source_credentials_provider_lookup;

    /// Finishes the operation started with `edataserver.SourceCredentialsProvider.lookup`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_lookup_finish(p_provider: *SourceCredentialsProvider, p_result: *gio.AsyncResult, p_out_credentials: **edataserver.NamedParameters, p_error: ?*?*glib.Error) c_int;
    pub const lookupFinish = e_source_credentials_provider_lookup_finish;

    /// Looks up the credentials for `source`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_lookup_sync(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_credentials: **edataserver.NamedParameters, p_error: ?*?*glib.Error) c_int;
    pub const lookupSync = e_source_credentials_provider_lookup_sync;

    /// Returns a referenced parent `edataserver.Source`, which holds the credentials for
    /// the given `source`. This is useful for collections, where the credentials
    /// are usually stored on the collection source, thus shared between child
    /// sources. When ther eis no such parent source, a `NULL` is returned, which
    /// means the `source` holds credentials for itself.
    extern fn e_source_credentials_provider_ref_credentials_source(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source) ?*edataserver.Source;
    pub const refCredentialsSource = e_source_credentials_provider_ref_credentials_source;

    /// Returns refenrenced registry associated with this `provider`.
    extern fn e_source_credentials_provider_ref_registry(p_provider: *SourceCredentialsProvider) *gobject.Object;
    pub const refRegistry = e_source_credentials_provider_ref_registry;

    /// Returns referenced `edataserver.Source` with the given `uid`, or `NULL`, when it could not be found.
    extern fn e_source_credentials_provider_ref_source(p_provider: *SourceCredentialsProvider, p_uid: [*:0]const u8) ?*edataserver.Source;
    pub const refSource = e_source_credentials_provider_ref_source;

    /// Registers a credentials provider implementation and adds its own reference on
    /// the `provider_impl`.
    extern fn e_source_credentials_provider_register_impl(p_provider: *SourceCredentialsProvider, p_provider_impl: *edataserver.SourceCredentialsProviderImpl) c_int;
    pub const registerImpl = e_source_credentials_provider_register_impl;

    /// Asynchronously stores the `credentials` for `source`. Note the actual stored
    /// values can differ for each storage. In other words, not all named parameters
    /// are stored for each `source`.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.SourceCredentialsProvider.storeFinish` to get the result
    /// of the operation.
    extern fn e_source_credentials_provider_store(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source, p_credentials: *const edataserver.NamedParameters, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const store = e_source_credentials_provider_store;

    /// Finishes the operation started with `edataserver.SourceCredentialsProvider.store`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_store_finish(p_provider: *SourceCredentialsProvider, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const storeFinish = e_source_credentials_provider_store_finish;

    /// Stores the `credentials` for `source`. Note the actual stored values
    /// can differ for each storage. In other words, not all named parameters
    /// are stored for each `source`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_store_sync(p_provider: *SourceCredentialsProvider, p_source: *edataserver.Source, p_credentials: *const edataserver.NamedParameters, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const storeSync = e_source_credentials_provider_store_sync;

    /// Unregisters previously registered `provider_impl` with
    /// `edataserver.SourceCredentialsProvider.registerImpl`. Function does nothing,
    /// when the `provider_impl` is not registered.
    extern fn e_source_credentials_provider_unregister_impl(p_provider: *SourceCredentialsProvider, p_provider_impl: *edataserver.SourceCredentialsProviderImpl) void;
    pub const unregisterImpl = e_source_credentials_provider_unregister_impl;

    extern fn e_source_credentials_provider_get_type() usize;
    pub const getGObjectType = e_source_credentials_provider_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceCredentialsProvider) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceCredentialsProvider) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceCredentialsProvider, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Credentials provider implementation base structure. The descendants
/// implement the virtual methods. The descendants are automatically
/// registered into an `edataserver.SourceCredentialsProvider`.
pub const SourceCredentialsProviderImpl = extern struct {
    pub const Parent = edataserver.Extension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceCredentialsProviderImplClass;
    f_parent: edataserver.Extension,
    f_priv: ?*edataserver.SourceCredentialsProviderImplPrivate,

    pub const virtual_methods = struct {
        /// Returns whether the `provider_impl` can process credentials for the `source`.
        pub const can_process = struct {
            pub fn call(p_class: anytype, p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) c_int {
                return gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_can_process.?(gobject.ext.as(SourceCredentialsProviderImpl, p_provider_impl), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) c_int) void {
                gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_can_process = @ptrCast(p_implementation);
            }
        };

        /// Returns whether credential prompt can be done for the `provider_impl`.
        pub const can_prompt = struct {
            pub fn call(p_class: anytype, p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_can_prompt.?(gobject.ext.as(SourceCredentialsProviderImpl, p_provider_impl));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_can_prompt = @ptrCast(p_implementation);
            }
        };

        /// Returns whether the `provider_impl` can store credentials.
        pub const can_store = struct {
            pub fn call(p_class: anytype, p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_can_store.?(gobject.ext.as(SourceCredentialsProviderImpl, p_provider_impl));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_can_store = @ptrCast(p_implementation);
            }
        };

        /// Asks `provider_impl` to delete any stored credentials for `source`.
        ///
        /// Default implementation returns `FALSE` and sets `G_IO_ERROR_NOT_SUPPORTED` error.
        ///
        /// If an error occurs, the function sets `error` and returns `FALSE`.
        pub const delete_sync = struct {
            pub fn call(p_class: anytype, p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_delete_sync.?(gobject.ext.as(SourceCredentialsProviderImpl, p_provider_impl), p_source, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_delete_sync = @ptrCast(p_implementation);
            }
        };

        /// Asks `provider_impl` to lookup for stored credentials for `source`.
        /// The `out_credentials` is populated with them. If the result is not
        /// `NULL`, then it should be freed with `edataserver.NamedParameters.free` when
        /// no longer needed.
        ///
        /// Default implementation returns `FALSE` and sets `G_IO_ERROR_NOT_SUPPORTED` error.
        ///
        /// If an error occurs, the function sets `error` and returns `FALSE`.
        pub const lookup_sync = struct {
            pub fn call(p_class: anytype, p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_credentials: **edataserver.NamedParameters, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_lookup_sync.?(gobject.ext.as(SourceCredentialsProviderImpl, p_provider_impl), p_source, p_cancellable, p_out_credentials, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_credentials: **edataserver.NamedParameters, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_lookup_sync = @ptrCast(p_implementation);
            }
        };

        /// Asks `provider_impl` to store `credentials` for `source`.
        ///
        /// Default implementation returns `FALSE` and sets `G_IO_ERROR_NOT_SUPPORTED` error.
        ///
        /// If an error occurs, the function sets `error` and returns `FALSE`.
        pub const store_sync = struct {
            pub fn call(p_class: anytype, p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_credentials: *const edataserver.NamedParameters, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_store_sync.?(gobject.ext.as(SourceCredentialsProviderImpl, p_provider_impl), p_source, p_credentials, p_permanently, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_credentials: *const edataserver.NamedParameters, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(SourceCredentialsProviderImpl.Class, p_class).f_store_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns whether the `provider_impl` can process credentials for the `source`.
    extern fn e_source_credentials_provider_impl_can_process(p_provider_impl: *SourceCredentialsProviderImpl, p_source: *edataserver.Source) c_int;
    pub const canProcess = e_source_credentials_provider_impl_can_process;

    /// Returns whether credential prompt can be done for the `provider_impl`.
    extern fn e_source_credentials_provider_impl_can_prompt(p_provider_impl: *SourceCredentialsProviderImpl) c_int;
    pub const canPrompt = e_source_credentials_provider_impl_can_prompt;

    /// Returns whether the `provider_impl` can store credentials.
    extern fn e_source_credentials_provider_impl_can_store(p_provider_impl: *SourceCredentialsProviderImpl) c_int;
    pub const canStore = e_source_credentials_provider_impl_can_store;

    /// Asks `provider_impl` to delete any stored credentials for `source`.
    ///
    /// Default implementation returns `FALSE` and sets `G_IO_ERROR_NOT_SUPPORTED` error.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_impl_delete_sync(p_provider_impl: *SourceCredentialsProviderImpl, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deleteSync = e_source_credentials_provider_impl_delete_sync;

    /// Returns an `edataserver.SourceCredentialsProvider` with which the `provider_impl` is associated.
    extern fn e_source_credentials_provider_impl_get_provider(p_provider_impl: *SourceCredentialsProviderImpl) ?*anyopaque;
    pub const getProvider = e_source_credentials_provider_impl_get_provider;

    /// Asks `provider_impl` to lookup for stored credentials for `source`.
    /// The `out_credentials` is populated with them. If the result is not
    /// `NULL`, then it should be freed with `edataserver.NamedParameters.free` when
    /// no longer needed.
    ///
    /// Default implementation returns `FALSE` and sets `G_IO_ERROR_NOT_SUPPORTED` error.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_impl_lookup_sync(p_provider_impl: *SourceCredentialsProviderImpl, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_credentials: **edataserver.NamedParameters, p_error: ?*?*glib.Error) c_int;
    pub const lookupSync = e_source_credentials_provider_impl_lookup_sync;

    /// Asks `provider_impl` to store `credentials` for `source`.
    ///
    /// Default implementation returns `FALSE` and sets `G_IO_ERROR_NOT_SUPPORTED` error.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_source_credentials_provider_impl_store_sync(p_provider_impl: *SourceCredentialsProviderImpl, p_source: *edataserver.Source, p_credentials: *const edataserver.NamedParameters, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const storeSync = e_source_credentials_provider_impl_store_sync;

    extern fn e_source_credentials_provider_impl_get_type() usize;
    pub const getGObjectType = e_source_credentials_provider_impl_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceCredentialsProviderImpl) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceCredentialsProviderImpl) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceCredentialsProviderImpl, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// OAuth2 based credentials provider implementation.
pub const SourceCredentialsProviderImplOAuth2 = extern struct {
    pub const Parent = edataserver.SourceCredentialsProviderImpl;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceCredentialsProviderImplOAuth2Class;
    f_parent: edataserver.SourceCredentialsProviderImpl,
    f_priv: ?*edataserver.SourceCredentialsProviderImplOAuth2Private,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_source_credentials_provider_impl_oauth2_get_type() usize;
    pub const getGObjectType = e_source_credentials_provider_impl_oauth2_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceCredentialsProviderImplOAuth2) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceCredentialsProviderImplOAuth2) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceCredentialsProviderImplOAuth2, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Password based credentials provider implementation.
pub const SourceCredentialsProviderImplPassword = extern struct {
    pub const Parent = edataserver.SourceCredentialsProviderImpl;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceCredentialsProviderImplPasswordClass;
    f_parent: edataserver.SourceCredentialsProviderImpl,
    f_priv: ?*edataserver.SourceCredentialsProviderImplPasswordPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_source_credentials_provider_impl_password_get_type() usize;
    pub const getGObjectType = e_source_credentials_provider_impl_password_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceCredentialsProviderImplPassword) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceCredentialsProviderImplPassword) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceCredentialsProviderImplPassword, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceExtension = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceExtensionClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.SourceExtensionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const source = struct {
            pub const name = "source";

            pub const Type = ?*edataserver.Source;
        };
    };

    pub const signals = struct {};

    /// Returns the `edataserver.Source` instance to which `extension` belongs.
    ///
    /// Note this function is not thread-safe.  The returned `edataserver.Source` could
    /// be finalized by another thread while the caller is still using it.
    extern fn e_source_extension_get_source(p_extension: *SourceExtension) *edataserver.Source;
    pub const getSource = e_source_extension_get_source;

    /// Acquires a property lock, thus no other thread can change properties
    /// of the `extension` until the lock is released.
    extern fn e_source_extension_property_lock(p_extension: *SourceExtension) void;
    pub const propertyLock = e_source_extension_property_lock;

    /// Releases a property lock, previously acquired with `edataserver.SourceExtension.propertyLock`,
    /// thus other threads can change properties of the `extension`.
    extern fn e_source_extension_property_unlock(p_extension: *SourceExtension) void;
    pub const propertyUnlock = e_source_extension_property_unlock;

    /// Returns the `edataserver.Source` instance to which the `extension` belongs.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety.  Unreference
    /// the `edataserver.Source` with `gobject.Object.unref` when finished with it.
    extern fn e_source_extension_ref_source(p_extension: *SourceExtension) *edataserver.Source;
    pub const refSource = e_source_extension_ref_source;

    extern fn e_source_extension_get_type() usize;
    pub const getGObjectType = e_source_extension_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceExtension) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceExtension) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceExtension, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceGoa = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceGoaClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceGoaPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const account_id = struct {
            pub const name = "account-id";

            pub const Type = ?[*:0]u8;
        };

        pub const address = struct {
            pub const name = "address";

            pub const Type = ?[*:0]u8;
        };

        pub const calendar_url = struct {
            pub const name = "calendar-url";

            pub const Type = ?[*:0]u8;
        };

        pub const contacts_url = struct {
            pub const name = "contacts-url";

            pub const Type = ?[*:0]u8;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceGoa.getAccountId`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_goa_dup_account_id(p_extension: *SourceGoa) ?[*:0]u8;
    pub const dupAccountId = e_source_goa_dup_account_id;

    /// Thread-safe variation of `edataserver.SourceGoa.getAddress`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_goa_dup_address(p_extension: *SourceGoa) ?[*:0]u8;
    pub const dupAddress = e_source_goa_dup_address;

    /// Thread-safe variation of `edataserver.SourceGoa.getCalendarUrl`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_goa_dup_calendar_url(p_extension: *SourceGoa) ?[*:0]u8;
    pub const dupCalendarUrl = e_source_goa_dup_calendar_url;

    /// Thread-safe variation of `edataserver.SourceGoa.getContactsUrl`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_goa_dup_contacts_url(p_extension: *SourceGoa) ?[*:0]u8;
    pub const dupContactsUrl = e_source_goa_dup_contacts_url;

    /// Thread-safe variation of `edataserver.SourceGoa.getName`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_goa_dup_name(p_extension: *SourceGoa) ?[*:0]u8;
    pub const dupName = e_source_goa_dup_name;

    /// Returns the identifier string of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs.
    extern fn e_source_goa_get_account_id(p_extension: *SourceGoa) ?[*:0]const u8;
    pub const getAccountId = e_source_goa_get_account_id;

    /// Returns the original Address of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs. Can be `NULL` or an empty
    /// string when not filled.
    extern fn e_source_goa_get_address(p_extension: *SourceGoa) ?[*:0]const u8;
    pub const getAddress = e_source_goa_get_address;

    /// Returns the calendar URL string of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs. Can be `NULL` or an empty
    /// string for accounts not supporting this property.
    extern fn e_source_goa_get_calendar_url(p_extension: *SourceGoa) ?[*:0]const u8;
    pub const getCalendarUrl = e_source_goa_get_calendar_url;

    /// Returns the contacts URL string of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs. Can be `NULL` or an empty
    /// string for accounts not supporting this property.
    extern fn e_source_goa_get_contacts_url(p_extension: *SourceGoa) ?[*:0]const u8;
    pub const getContactsUrl = e_source_goa_get_contacts_url;

    /// Returns the original Name of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs. Can be `NULL` or an empty
    /// string when not filled.
    extern fn e_source_goa_get_name(p_extension: *SourceGoa) ?[*:0]const u8;
    pub const getName = e_source_goa_get_name;

    /// Sets the identifier string of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs.
    ///
    /// The internal copy of `account_id` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_goa_set_account_id(p_extension: *SourceGoa, p_account_id: ?[*:0]const u8) void;
    pub const setAccountId = e_source_goa_set_account_id;

    /// Sets the Address of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs.
    ///
    /// The internal copy of `address` is automatically stripped of leading
    /// and trailing whitespace. If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_goa_set_address(p_extension: *SourceGoa, p_address: ?[*:0]const u8) void;
    pub const setAddress = e_source_goa_set_address;

    /// Sets the calendar URL of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs.
    ///
    /// The internal copy of `calendar_url` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_goa_set_calendar_url(p_extension: *SourceGoa, p_calendar_url: ?[*:0]const u8) void;
    pub const setCalendarUrl = e_source_goa_set_calendar_url;

    /// Sets the contacts URL of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs.
    ///
    /// The internal copy of `contacts_url` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_goa_set_contacts_url(p_extension: *SourceGoa, p_contacts_url: ?[*:0]const u8) void;
    pub const setContactsUrl = e_source_goa_set_contacts_url;

    /// Sets the Name of the GNOME Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs.
    ///
    /// The internal copy of `name` is automatically stripped of leading
    /// and trailing whitespace. If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_goa_set_name(p_extension: *SourceGoa, p_name: ?[*:0]const u8) void;
    pub const setName = e_source_goa_set_name;

    extern fn e_source_goa_get_type() usize;
    pub const getGObjectType = e_source_goa_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceGoa) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceGoa) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceGoa, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceLDAP = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceLDAPClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceLDAPPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const authentication = struct {
            pub const name = "authentication";

            pub const Type = edataserver.SourceLDAPAuthentication;
        };

        pub const can_browse = struct {
            pub const name = "can-browse";

            pub const Type = c_int;
        };

        pub const filter = struct {
            pub const name = "filter";

            pub const Type = ?[*:0]u8;
        };

        pub const limit = struct {
            pub const name = "limit";

            pub const Type = c_uint;
        };

        pub const root_dn = struct {
            pub const name = "root-dn";

            pub const Type = ?[*:0]u8;
        };

        pub const scope = struct {
            pub const name = "scope";

            pub const Type = edataserver.SourceLDAPScope;
        };

        pub const security = struct {
            pub const name = "security";

            pub const Type = edataserver.SourceLDAPSecurity;
        };
    };

    pub const signals = struct {};

    extern fn e_source_ldap_dup_filter(p_extension: *SourceLDAP) [*:0]u8;
    pub const dupFilter = e_source_ldap_dup_filter;

    extern fn e_source_ldap_dup_root_dn(p_extension: *SourceLDAP) [*:0]u8;
    pub const dupRootDn = e_source_ldap_dup_root_dn;

    extern fn e_source_ldap_get_authentication(p_extension: *SourceLDAP) edataserver.SourceLDAPAuthentication;
    pub const getAuthentication = e_source_ldap_get_authentication;

    extern fn e_source_ldap_get_can_browse(p_extension: *SourceLDAP) c_int;
    pub const getCanBrowse = e_source_ldap_get_can_browse;

    extern fn e_source_ldap_get_filter(p_extension: *SourceLDAP) [*:0]const u8;
    pub const getFilter = e_source_ldap_get_filter;

    extern fn e_source_ldap_get_limit(p_extension: *SourceLDAP) c_uint;
    pub const getLimit = e_source_ldap_get_limit;

    extern fn e_source_ldap_get_root_dn(p_extension: *SourceLDAP) [*:0]const u8;
    pub const getRootDn = e_source_ldap_get_root_dn;

    extern fn e_source_ldap_get_scope(p_extension: *SourceLDAP) edataserver.SourceLDAPScope;
    pub const getScope = e_source_ldap_get_scope;

    extern fn e_source_ldap_get_security(p_extension: *SourceLDAP) edataserver.SourceLDAPSecurity;
    pub const getSecurity = e_source_ldap_get_security;

    extern fn e_source_ldap_set_authentication(p_extension: *SourceLDAP, p_authentication: edataserver.SourceLDAPAuthentication) void;
    pub const setAuthentication = e_source_ldap_set_authentication;

    extern fn e_source_ldap_set_can_browse(p_extension: *SourceLDAP, p_can_browse: c_int) void;
    pub const setCanBrowse = e_source_ldap_set_can_browse;

    extern fn e_source_ldap_set_filter(p_extension: *SourceLDAP, p_filter: [*:0]const u8) void;
    pub const setFilter = e_source_ldap_set_filter;

    extern fn e_source_ldap_set_limit(p_extension: *SourceLDAP, p_limit: c_uint) void;
    pub const setLimit = e_source_ldap_set_limit;

    extern fn e_source_ldap_set_root_dn(p_extension: *SourceLDAP, p_root_dn: [*:0]const u8) void;
    pub const setRootDn = e_source_ldap_set_root_dn;

    extern fn e_source_ldap_set_scope(p_extension: *SourceLDAP, p_scope: edataserver.SourceLDAPScope) void;
    pub const setScope = e_source_ldap_set_scope;

    extern fn e_source_ldap_set_security(p_extension: *SourceLDAP, p_security: edataserver.SourceLDAPSecurity) void;
    pub const setSecurity = e_source_ldap_set_security;

    extern fn e_source_ldap_get_type() usize;
    pub const getGObjectType = e_source_ldap_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceLDAP) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceLDAP) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceLDAP, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceLocal = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceLocalClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceLocalPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const custom_file = struct {
            pub const name = "custom-file";

            pub const Type = ?*gio.File;
        };

        pub const email_address = struct {
            pub const name = "email-address";

            pub const Type = ?[*:0]u8;
        };

        pub const writable = struct {
            pub const name = "writable";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// A thread safe variant to get a custom file being set on the `extension`.
    /// Free the returned `gio.File`, if not `NULL`, with `gobject.Object.unref`,
    /// when no longer needed.
    extern fn e_source_local_dup_custom_file(p_extension: *SourceLocal) ?*gio.File;
    pub const dupCustomFile = e_source_local_dup_custom_file;

    /// Thread-safe variation of `e_source_lcoal_get_email_address`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_local_dup_email_address(p_extension: *SourceLocal) [*:0]u8;
    pub const dupEmailAddress = e_source_local_dup_email_address;

    /// Get the custom file being set on the `extension`.
    /// The returned `gio.File` is owned by the `extension`.
    ///
    /// For thread safety use `edataserver.SourceLocal.dupCustomFile`.
    extern fn e_source_local_get_custom_file(p_extension: *SourceLocal) ?*gio.File;
    pub const getCustomFile = e_source_local_get_custom_file;

    extern fn e_source_local_get_email_address(p_extension: *SourceLocal) ?[*:0]const u8;
    pub const getEmailAddress = e_source_local_get_email_address;

    /// Returns whether the backend should prefer to open the file
    /// in writable mode. The default is `TRUE`. The file can be still
    /// opened for read-only, for example when the access to the file
    /// is read-only.
    extern fn e_source_local_get_writable(p_extension: *SourceLocal) c_int;
    pub const getWritable = e_source_local_get_writable;

    /// Set, or unset, when using `NULL`, the custom file for the `extension`.
    extern fn e_source_local_set_custom_file(p_extension: *SourceLocal, p_custom_file: ?*gio.File) void;
    pub const setCustomFile = e_source_local_set_custom_file;

    /// Sets the email address for `extension`.
    ///
    /// The internal copy of `email_address` is automatically stripped of leading
    /// and trailing whitespace. If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_local_set_email_address(p_extension: *SourceLocal, p_email_address: ?[*:0]const u8) void;
    pub const setEmailAddress = e_source_local_set_email_address;

    /// Set whether the custom file should be opened in writable mode.
    /// The default is `TRUE`. The file can be still opened for read-only,
    /// for example when the access to the file is read-only.
    extern fn e_source_local_set_writable(p_extension: *SourceLocal, p_writable: c_int) void;
    pub const setWritable = e_source_local_set_writable;

    extern fn e_source_local_get_type() usize;
    pub const getGObjectType = e_source_local_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceLocal) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceLocal) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceLocal, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceMDN = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceMDNClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceMDNPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const response_policy = struct {
            pub const name = "response-policy";

            pub const Type = edataserver.MdnResponsePolicy;
        };
    };

    pub const signals = struct {};

    /// Returns the policy for this mail account on responding to Message
    /// Disposition Notification requests when receiving mail messages.
    extern fn e_source_mdn_get_response_policy(p_extension: *SourceMDN) edataserver.MdnResponsePolicy;
    pub const getResponsePolicy = e_source_mdn_get_response_policy;

    /// Sets the policy for this mail account on responding to Message
    /// Disposition Notification requests when receiving mail messages.
    extern fn e_source_mdn_set_response_policy(p_extension: *SourceMDN, p_response_policy: edataserver.MdnResponsePolicy) void;
    pub const setResponsePolicy = e_source_mdn_set_response_policy;

    extern fn e_source_mdn_get_type() usize;
    pub const getGObjectType = e_source_mdn_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceMDN) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceMDN) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceMDN, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceMailAccount = extern struct {
    pub const Parent = edataserver.SourceBackend;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceMailAccountClass;
    f_parent: edataserver.SourceBackend,
    f_priv: ?*edataserver.SourceMailAccountPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const archive_folder = struct {
            pub const name = "archive-folder";

            pub const Type = ?[*:0]u8;
        };

        pub const builtin = struct {
            pub const name = "builtin";

            pub const Type = c_int;
        };

        pub const identity_uid = struct {
            pub const name = "identity-uid";

            pub const Type = ?[*:0]u8;
        };

        pub const mark_seen = struct {
            pub const name = "mark-seen";

            pub const Type = edataserver.ThreeState;
        };

        pub const mark_seen_timeout = struct {
            pub const name = "mark-seen-timeout";

            pub const Type = c_int;
        };

        pub const needs_initial_setup = struct {
            pub const name = "needs-initial-setup";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceMailAccount.getArchiveFolder`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_account_dup_archive_folder(p_extension: *SourceMailAccount) ?[*:0]u8;
    pub const dupArchiveFolder = e_source_mail_account_dup_archive_folder;

    /// Thread-safe variation of `edataserver.SourceMailAccount.getIdentityUid`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_account_dup_identity_uid(p_extension: *SourceMailAccount) ?[*:0]u8;
    pub const dupIdentityUid = e_source_mail_account_dup_identity_uid;

    /// Returns a string identifying the archive folder.
    /// The format of the identifier string is defined by the client application.
    extern fn e_source_mail_account_get_archive_folder(p_extension: *SourceMailAccount) ?[*:0]const u8;
    pub const getArchiveFolder = e_source_mail_account_get_archive_folder;

    /// Returns whether the mail account is a builtin account. The builtin
    /// account cannot be created by a user. The default value is `FALSE`.
    extern fn e_source_mail_account_get_builtin(p_extension: *SourceMailAccount) c_int;
    pub const getBuiltin = e_source_mail_account_get_builtin;

    /// Returns the `edataserver.Source.properties.uid` of the `edataserver.Source` that describes the mail
    /// identity to be used for this account.
    extern fn e_source_mail_account_get_identity_uid(p_extension: *SourceMailAccount) ?[*:0]const u8;
    pub const getIdentityUid = e_source_mail_account_get_identity_uid;

    extern fn e_source_mail_account_get_mark_seen(p_extension: *SourceMailAccount) edataserver.ThreeState;
    pub const getMarkSeen = e_source_mail_account_get_mark_seen;

    extern fn e_source_mail_account_get_mark_seen_timeout(p_extension: *SourceMailAccount) c_int;
    pub const getMarkSeenTimeout = e_source_mail_account_get_mark_seen_timeout;

    /// Check whether the mail account needs to do its initial setup.
    extern fn e_source_mail_account_get_needs_initial_setup(p_extension: *SourceMailAccount) c_int;
    pub const getNeedsInitialSetup = e_source_mail_account_get_needs_initial_setup;

    /// Sets the folder for sent messages by an identifier string.
    /// The format of the identifier string is defined by the client application.
    ///
    /// The internal copy of `archive_folder` is automatically stripped of leading
    /// and trailing whitespace. If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_mail_account_set_archive_folder(p_extension: *SourceMailAccount, p_archive_folder: ?[*:0]const u8) void;
    pub const setArchiveFolder = e_source_mail_account_set_archive_folder;

    /// Sets whether the account is a builtin account. See `edataserver.SourceMailAccount.getBuiltin`
    /// for more information about what it means.
    extern fn e_source_mail_account_set_builtin(p_extension: *SourceMailAccount, p_builtin: c_int) void;
    pub const setBuiltin = e_source_mail_account_set_builtin;

    /// Sets the `edataserver.Source.properties.uid` of the `edataserver.Source` that describes the mail
    /// identity to be used for this account.
    extern fn e_source_mail_account_set_identity_uid(p_extension: *SourceMailAccount, p_identity_uid: ?[*:0]const u8) void;
    pub const setIdentityUid = e_source_mail_account_set_identity_uid;

    /// Sets whether the messages in this account should be marked
    /// as seen automatically. An inconsistent state means to use
    /// global option.
    extern fn e_source_mail_account_set_mark_seen(p_extension: *SourceMailAccount, p_mark_seen: edataserver.ThreeState) void;
    pub const setMarkSeen = e_source_mail_account_set_mark_seen;

    /// Sets the `timeout` in milliseconds for marking messages
    /// as seen in this account. Whether the timeout is used
    /// depends on `edataserver.SourceMailAccount.getMarkSeen`.
    extern fn e_source_mail_account_set_mark_seen_timeout(p_extension: *SourceMailAccount, p_timeout: c_int) void;
    pub const setMarkSeenTimeout = e_source_mail_account_set_mark_seen_timeout;

    /// Sets whether the account needs to run its initial setup.
    extern fn e_source_mail_account_set_needs_initial_setup(p_extension: *SourceMailAccount, p_needs_initial_setup: c_int) void;
    pub const setNeedsInitialSetup = e_source_mail_account_set_needs_initial_setup;

    extern fn e_source_mail_account_get_type() usize;
    pub const getGObjectType = e_source_mail_account_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceMailAccount) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceMailAccount) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceMailAccount, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceMailComposition = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceMailCompositionClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceMailCompositionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const bcc = struct {
            pub const name = "bcc";

            pub const Type = ?[*][*:0]u8;
        };

        pub const cc = struct {
            pub const name = "cc";

            pub const Type = ?[*][*:0]u8;
        };

        pub const drafts_folder = struct {
            pub const name = "drafts-folder";

            pub const Type = ?[*:0]u8;
        };

        pub const language = struct {
            pub const name = "language";

            pub const Type = ?[*:0]u8;
        };

        pub const reply_style = struct {
            pub const name = "reply-style";

            pub const Type = edataserver.SourceMailCompositionReplyStyle;
        };

        pub const sign_imip = struct {
            pub const name = "sign-imip";

            pub const Type = c_int;
        };

        pub const start_bottom = struct {
            pub const name = "start-bottom";

            pub const Type = edataserver.ThreeState;
        };

        pub const templates_folder = struct {
            pub const name = "templates-folder";

            pub const Type = ?[*:0]u8;
        };

        pub const top_signature = struct {
            pub const name = "top-signature";

            pub const Type = edataserver.ThreeState;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceMailComposition.getBcc`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string array should be freed with `glib.strfreev` when no
    /// longer needed.
    extern fn e_source_mail_composition_dup_bcc(p_extension: *SourceMailComposition) [*][*:0]u8;
    pub const dupBcc = e_source_mail_composition_dup_bcc;

    /// Thread-safe variation of `edataserver.SourceMailComposition.getCc`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string array should be freed with `glib.strfreev` when no
    /// longer needed.
    extern fn e_source_mail_composition_dup_cc(p_extension: *SourceMailComposition) [*][*:0]u8;
    pub const dupCc = e_source_mail_composition_dup_cc;

    /// Thread-safe variation of `edataserver.SourceMailComposition.getDraftsFolder`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_composition_dup_drafts_folder(p_extension: *SourceMailComposition) ?[*:0]u8;
    pub const dupDraftsFolder = e_source_mail_composition_dup_drafts_folder;

    /// Thread-safe variation of `edataserver.SourceMailComposition.getLanguage`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_composition_dup_language(p_extension: *SourceMailComposition) ?[*:0]u8;
    pub const dupLanguage = e_source_mail_composition_dup_language;

    /// Thread-safe variation of `edataserver.SourceMailComposition.getTemplatesFolder`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_composition_dup_templates_folder(p_extension: *SourceMailComposition) ?[*:0]u8;
    pub const dupTemplatesFolder = e_source_mail_composition_dup_templates_folder;

    /// Returns a `NULL`-terminated string array of recipients which should
    /// automatically be added to the blind carbon-copy (Bcc) list when
    /// composing a new mail message.  The recipient strings should be of
    /// the form "Full Name &lt;email-address&gt;".  The returned array is
    /// owned by `extension` and should not be modified or freed.
    extern fn e_source_mail_composition_get_bcc(p_extension: *SourceMailComposition) [*]const [*:0]const u8;
    pub const getBcc = e_source_mail_composition_get_bcc;

    /// Returns a `NULL`-terminated string array of recipients which should
    /// automatically be added to the carbon-copy (Cc) list when composing a
    /// new mail message.  The recipient strings should be of the form "Full
    /// Name <email-address>".  The returned array is owned by `extension` and
    /// should not be modified or freed.
    extern fn e_source_mail_composition_get_cc(p_extension: *SourceMailComposition) [*]const [*:0]const u8;
    pub const getCc = e_source_mail_composition_get_cc;

    /// Returns a string identifying the preferred folder for draft messages.
    /// The format of the identifier string is defined by the client application.
    extern fn e_source_mail_composition_get_drafts_folder(p_extension: *SourceMailComposition) ?[*:0]const u8;
    pub const getDraftsFolder = e_source_mail_composition_get_drafts_folder;

    /// Returns a string identifying the preferred language, like "en_US".
    extern fn e_source_mail_composition_get_language(p_extension: *SourceMailComposition) ?[*:0]const u8;
    pub const getLanguage = e_source_mail_composition_get_language;

    /// Returns preferred reply style to be used when replying
    /// using the associated account. If no preference is set,
    /// the `E_SOURCE_MAIL_COMPOSITION_REPLY_STYLE_DEFAULT` is returned.
    extern fn e_source_mail_composition_get_reply_style(p_extension: *SourceMailComposition) edataserver.SourceMailCompositionReplyStyle;
    pub const getReplyStyle = e_source_mail_composition_get_reply_style;

    /// Returns whether outgoing iMIP messages such as meeting requests should
    /// also be signed.  This is primarily intended as a workaround for certain
    /// versions of Microsoft Outlook which can't handle signed iMIP messages.
    extern fn e_source_mail_composition_get_sign_imip(p_extension: *SourceMailComposition) c_int;
    pub const getSignImip = e_source_mail_composition_get_sign_imip;

    /// Returns whether start at bottom when replying or forwarding
    /// using the associated account. If no preference is set,
    /// the `E_THREE_STATE_INCONSISTENT` is returned.
    extern fn e_source_mail_composition_get_start_bottom(p_extension: *SourceMailComposition) edataserver.ThreeState;
    pub const getStartBottom = e_source_mail_composition_get_start_bottom;

    /// Returns a string identifying the preferred folder for message templates.
    /// The format of the identifier string is defined by the client application.
    extern fn e_source_mail_composition_get_templates_folder(p_extension: *SourceMailComposition) ?[*:0]const u8;
    pub const getTemplatesFolder = e_source_mail_composition_get_templates_folder;

    /// Returns whether place signature at top when replying or forwarding
    /// using the associated account. If no preference is set,
    /// the `E_THREE_STATE_INCONSISTENT` is returned.
    extern fn e_source_mail_composition_get_top_signature(p_extension: *SourceMailComposition) edataserver.ThreeState;
    pub const getTopSignature = e_source_mail_composition_get_top_signature;

    /// Sets the recipients which should automatically be added to the blind
    /// carbon-copy (Bcc) list when composing a new mail message.  The recipient
    /// strings should be of the form "Full Name &lt;email-address&gt;".
    extern fn e_source_mail_composition_set_bcc(p_extension: *SourceMailComposition, p_bcc: [*]const [*:0]const u8) void;
    pub const setBcc = e_source_mail_composition_set_bcc;

    /// Sets the recipients which should automatically be added to the carbon
    /// copy (Cc) list when composing a new mail message.  The recipient strings
    /// should be of the form "Full Name &lt;email-address&gt;".
    extern fn e_source_mail_composition_set_cc(p_extension: *SourceMailComposition, p_cc: [*]const [*:0]const u8) void;
    pub const setCc = e_source_mail_composition_set_cc;

    /// Sets the preferred folder for draft messages by an identifier string.
    /// The format of the identifier string is defined by the client application.
    ///
    /// The internal copy of `drafts_folder` is automatically stripped of
    /// leading and trailing whitespace.  If the resulting string is empty,
    /// `NULL` is set instead.
    extern fn e_source_mail_composition_set_drafts_folder(p_extension: *SourceMailComposition, p_drafts_folder: ?[*:0]const u8) void;
    pub const setDraftsFolder = e_source_mail_composition_set_drafts_folder;

    /// Sets the preferred language by an identifier string, like "en_US".
    /// Use `NULL` to unset any previous value.
    ///
    /// The internal copy of `language` is automatically stripped of
    /// leading and trailing whitespace.  If the resulting string is empty,
    /// `NULL` is set instead.
    extern fn e_source_mail_composition_set_language(p_extension: *SourceMailComposition, p_language: ?[*:0]const u8) void;
    pub const setLanguage = e_source_mail_composition_set_language;

    /// Sets preferred reply style to be used when replying
    /// using the associated account. To unset the preference,
    /// use the `E_SOURCE_MAIL_COMPOSITION_REPLY_STYLE_DEFAULT`.
    extern fn e_source_mail_composition_set_reply_style(p_extension: *SourceMailComposition, p_reply_style: edataserver.SourceMailCompositionReplyStyle) void;
    pub const setReplyStyle = e_source_mail_composition_set_reply_style;

    /// Sets whether outgoing iMIP messages such as meeting requests should
    /// also be signed.  This is primarily intended as a workaround for certain
    /// versions of Microsoft Outlook which can't handle signed iMIP messages.
    extern fn e_source_mail_composition_set_sign_imip(p_extension: *SourceMailComposition, p_sign_imip: c_int) void;
    pub const setSignImip = e_source_mail_composition_set_sign_imip;

    /// Sets whether start bottom when replying or forwarding using the associated account.
    /// To unset the preference, use the `E_THREE_STATE_INCONSISTENT`.
    extern fn e_source_mail_composition_set_start_bottom(p_extension: *SourceMailComposition, p_start_bottom: edataserver.ThreeState) void;
    pub const setStartBottom = e_source_mail_composition_set_start_bottom;

    /// Sets the preferred folder for message templates by an identifier string.
    /// The format of the identifier string is defined by the client application.
    ///
    /// The internal copy of `templates_folder` is automatically stripped of
    /// leading and trailing whitespace.  If the resulting string is empty,
    /// `NULL` is set instead.
    extern fn e_source_mail_composition_set_templates_folder(p_extension: *SourceMailComposition, p_templates_folder: ?[*:0]const u8) void;
    pub const setTemplatesFolder = e_source_mail_composition_set_templates_folder;

    /// Sets whether place signature at top when replying or forwarding using the associated account.
    /// To unset the preference, use the `E_THREE_STATE_INCONSISTENT`.
    extern fn e_source_mail_composition_set_top_signature(p_extension: *SourceMailComposition, p_top_signature: edataserver.ThreeState) void;
    pub const setTopSignature = e_source_mail_composition_set_top_signature;

    extern fn e_source_mail_composition_get_type() usize;
    pub const getGObjectType = e_source_mail_composition_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceMailComposition) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceMailComposition) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceMailComposition, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceMailIdentity = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceMailIdentityClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceMailIdentityPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const address = struct {
            pub const name = "address";

            pub const Type = ?[*:0]u8;
        };

        pub const aliases = struct {
            pub const name = "aliases";

            pub const Type = ?[*:0]u8;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const organization = struct {
            pub const name = "organization";

            pub const Type = ?[*:0]u8;
        };

        pub const reply_to = struct {
            pub const name = "reply-to";

            pub const Type = ?[*:0]u8;
        };

        pub const signature_uid = struct {
            pub const name = "signature-uid";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceMailIdentity.getAddress`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_identity_dup_address(p_extension: *SourceMailIdentity) ?[*:0]u8;
    pub const dupAddress = e_source_mail_identity_dup_address;

    /// Thread-safe variation of `edataserver.SourceMailIdentity.getAliases`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_identity_dup_aliases(p_extension: *SourceMailIdentity) ?[*:0]u8;
    pub const dupAliases = e_source_mail_identity_dup_aliases;

    /// Thread-safe variation of `edataserver.SourceMailIdentity.getName`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_identity_dup_name(p_extension: *SourceMailIdentity) ?[*:0]u8;
    pub const dupName = e_source_mail_identity_dup_name;

    /// Thread-safe variation of `edataserver.SourceMailIdentity.dupOrganization`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_identity_dup_organization(p_extension: *SourceMailIdentity) ?[*:0]u8;
    pub const dupOrganization = e_source_mail_identity_dup_organization;

    /// Thread-safe variation of `edataserver.SourceMailIdentity.getReplyTo`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_identity_dup_reply_to(p_extension: *SourceMailIdentity) ?[*:0]u8;
    pub const dupReplyTo = e_source_mail_identity_dup_reply_to;

    /// Thread-safe variation of `edataserver.SourceMailIdentity.getSignatureUid`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_identity_dup_signature_uid(p_extension: *SourceMailIdentity) ?[*:0]u8;
    pub const dupSignatureUid = e_source_mail_identity_dup_signature_uid;

    /// Returns the email address for this identity from which to send messages.
    /// This may be an empty string but will never be `NULL`.
    extern fn e_source_mail_identity_get_address(p_extension: *SourceMailIdentity) ?[*:0]const u8;
    pub const getAddress = e_source_mail_identity_get_address;

    /// Returns the email address aliases for this identity. These are comma-separated
    /// email addresses which may or may not contain also different name.
    /// This may be an empty string, but will never be `NULL`.
    /// There can be used `camel.Address.decode` on a `camel.InternetAddress`
    /// to decode the list of aliases.
    extern fn e_source_mail_identity_get_aliases(p_extension: *SourceMailIdentity) ?[*:0]const u8;
    pub const getAliases = e_source_mail_identity_get_aliases;

    /// Returns a set aliases as a hash table with address as key and
    /// name as value of the hash table. The name can be sometimes
    /// empty or NULL, thus rather use `glib.hashTableContains` when
    /// checking for particular address. The addresses are
    /// compared case insensitively. The same addresses with a different
    /// name are included only once, the last variant of it. Use
    /// `edataserver.SourceMailIdentity.getAliases` if you need more fine-grained
    /// control on the list of aliases.
    extern fn e_source_mail_identity_get_aliases_as_hash_table(p_extension: *SourceMailIdentity) ?*glib.HashTable;
    pub const getAliasesAsHashTable = e_source_mail_identity_get_aliases_as_hash_table;

    /// Returns the sender's name for this identity.
    extern fn e_source_mail_identity_get_name(p_extension: *SourceMailIdentity) ?[*:0]const u8;
    pub const getName = e_source_mail_identity_get_name;

    /// Returns the sender's organization for this identity.
    extern fn e_source_mail_identity_get_organization(p_extension: *SourceMailIdentity) ?[*:0]const u8;
    pub const getOrganization = e_source_mail_identity_get_organization;

    /// Returns the email address for this identity to which recipients should
    /// send replies.
    extern fn e_source_mail_identity_get_reply_to(p_extension: *SourceMailIdentity) ?[*:0]const u8;
    pub const getReplyTo = e_source_mail_identity_get_reply_to;

    /// Returns the `edataserver.Source.properties.uid` of an `edataserver.Source` describing a mail signature.
    ///
    /// If the user does not want to use a signature for this identity, the
    /// convention is to set the `edataserver.SourceMailIdentity.properties.signature`-uid property
    /// to "none".
    extern fn e_source_mail_identity_get_signature_uid(p_extension: *SourceMailIdentity) ?[*:0]const u8;
    pub const getSignatureUid = e_source_mail_identity_get_signature_uid;

    /// Sets the email address for this identity from which to send messages.
    ///
    /// The internal copy of `address` is automatically stripped of leading and
    /// trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_mail_identity_set_address(p_extension: *SourceMailIdentity, p_address: ?[*:0]const u8) void;
    pub const setAddress = e_source_mail_identity_set_address;

    /// Sets the email address aliases for this identity. These are comma-separated
    /// email addresses which may or may not contain also different name.
    ///
    /// The internal copy of `aliases` is automatically stripped of leading and
    /// trailing whitespace. If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_mail_identity_set_aliases(p_extension: *SourceMailIdentity, p_aliases: ?[*:0]const u8) void;
    pub const setAliases = e_source_mail_identity_set_aliases;

    /// Sets the sender's name for this identity.
    ///
    /// The internal copy of `name` is automatically stripped of leading and
    /// trailing whitespace.
    extern fn e_source_mail_identity_set_name(p_extension: *SourceMailIdentity, p_name: ?[*:0]const u8) void;
    pub const setName = e_source_mail_identity_set_name;

    /// Sets the sender's organization for this identity.
    ///
    /// The internal copy of `organization` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_mail_identity_set_organization(p_extension: *SourceMailIdentity, p_organization: ?[*:0]const u8) void;
    pub const setOrganization = e_source_mail_identity_set_organization;

    /// Sets the email address for this identity to which recipients should
    /// send replies.
    ///
    /// The internal copy of `reply_to` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is
    /// set instead.
    extern fn e_source_mail_identity_set_reply_to(p_extension: *SourceMailIdentity, p_reply_to: ?[*:0]const u8) void;
    pub const setReplyTo = e_source_mail_identity_set_reply_to;

    /// Sets the `edataserver.Source.properties.uid` of an `edataserver.Source` describing a mail signature.
    ///
    /// If the user does not want to use a signature for this identity, the
    /// convention is to set the `edataserver.SourceMailIdentity.properties.signature`-uid property
    /// to "none".  In keeping with that convention, the property will be set
    /// to "none" if `signature_uid` is `NULL` or an empty string.
    extern fn e_source_mail_identity_set_signature_uid(p_extension: *SourceMailIdentity, p_signature_uid: ?[*:0]const u8) void;
    pub const setSignatureUid = e_source_mail_identity_set_signature_uid;

    extern fn e_source_mail_identity_get_type() usize;
    pub const getGObjectType = e_source_mail_identity_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceMailIdentity) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceMailIdentity) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceMailIdentity, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// function below.
pub const SourceMailSignature = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceMailSignatureClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceMailSignaturePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const file = struct {
            pub const name = "file";

            pub const Type = ?*gio.File;
        };

        pub const mime_type = struct {
            pub const name = "mime-type";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceMailSignature.getMimeType`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_signature_dup_mime_type(p_extension: *SourceMailSignature) ?[*:0]u8;
    pub const dupMimeType = e_source_mail_signature_dup_mime_type;

    /// Returns a `gio.File` instance pointing to the signature file for `extension`.
    /// The signature file may be a regular file containing the static signature
    /// content, or it may be a symbolic link to an executable file that produces
    /// the signature content.
    ///
    /// `edataserver.Source.mailSignatureLoad` uses this to load the signature content.
    extern fn e_source_mail_signature_get_file(p_extension: *SourceMailSignature) *gio.File;
    pub const getFile = e_source_mail_signature_get_file;

    /// Returns the MIME type of the signature content for `extension`, or `NULL`
    /// if it has not yet been determined.
    ///
    /// `edataserver.Source.mailSignatureLoad` sets this automatically if the MIME type
    /// has not yet been determined.
    extern fn e_source_mail_signature_get_mime_type(p_extension: *SourceMailSignature) ?[*:0]const u8;
    pub const getMimeType = e_source_mail_signature_get_mime_type;

    /// Sets the MIME type of the signature content for `extension`.
    ///
    /// `edataserver.Source.mailSignatureLoad` sets this automatically if the MIME type
    /// has not yet been determined.
    ///
    /// The internal copy of `mime_type` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is
    /// set instead.
    extern fn e_source_mail_signature_set_mime_type(p_extension: *SourceMailSignature, p_mime_type: ?[*:0]const u8) void;
    pub const setMimeType = e_source_mail_signature_set_mime_type;

    extern fn e_source_mail_signature_get_type() usize;
    pub const getGObjectType = e_source_mail_signature_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceMailSignature) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceMailSignature) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceMailSignature, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// function below.
pub const SourceMailSubmission = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceMailSubmissionClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceMailSubmissionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const replies_to_origin_folder = struct {
            pub const name = "replies-to-origin-folder";

            pub const Type = c_int;
        };

        pub const sent_folder = struct {
            pub const name = "sent-folder";

            pub const Type = ?[*:0]u8;
        };

        pub const transport_uid = struct {
            pub const name = "transport-uid";

            pub const Type = ?[*:0]u8;
        };

        pub const use_sent_folder = struct {
            pub const name = "use-sent-folder";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceMailSubmission.getSentFolder`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_submission_dup_sent_folder(p_extension: *SourceMailSubmission) ?[*:0]u8;
    pub const dupSentFolder = e_source_mail_submission_dup_sent_folder;

    /// Thread-safe variation of `edataserver.SourceMailSubmission.getTransportUid`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_mail_submission_dup_transport_uid(p_extension: *SourceMailSubmission) ?[*:0]u8;
    pub const dupTransportUid = e_source_mail_submission_dup_transport_uid;

    /// Returns whether save replies in the folder of the message
    /// being replied to, instead of the Sent folder.
    extern fn e_source_mail_submission_get_replies_to_origin_folder(p_extension: *SourceMailSubmission) c_int;
    pub const getRepliesToOriginFolder = e_source_mail_submission_get_replies_to_origin_folder;

    /// Returns a string identifying the preferred folder for sent messages.
    /// The format of the identifier string is defined by the client application.
    extern fn e_source_mail_submission_get_sent_folder(p_extension: *SourceMailSubmission) ?[*:0]const u8;
    pub const getSentFolder = e_source_mail_submission_get_sent_folder;

    /// Returns the `edataserver.Source.properties.uid` of the `edataserver.Source` that describes the mail
    /// transport to be used for outgoing messages.
    extern fn e_source_mail_submission_get_transport_uid(p_extension: *SourceMailSubmission) ?[*:0]const u8;
    pub const getTransportUid = e_source_mail_submission_get_transport_uid;

    extern fn e_source_mail_submission_get_use_sent_folder(p_extension: *SourceMailSubmission) c_int;
    pub const getUseSentFolder = e_source_mail_submission_get_use_sent_folder;

    /// Sets whether save replies in the folder of the message
    /// being replied to, instead of the Sent folder.
    extern fn e_source_mail_submission_set_replies_to_origin_folder(p_extension: *SourceMailSubmission, p_replies_to_origin_folder: c_int) void;
    pub const setRepliesToOriginFolder = e_source_mail_submission_set_replies_to_origin_folder;

    /// Sets the preferred folder for sent messages by an identifier string.
    /// The format of the identifier string is defined by the client application.
    ///
    /// The internal copy of `sent_folder` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_mail_submission_set_sent_folder(p_extension: *SourceMailSubmission, p_sent_folder: ?[*:0]const u8) void;
    pub const setSentFolder = e_source_mail_submission_set_sent_folder;

    /// Sets the `edataserver.Source.properties.uid` of the `edataserver.Source` that describes the mail
    /// transport to be used for outgoing messages.
    extern fn e_source_mail_submission_set_transport_uid(p_extension: *SourceMailSubmission, p_transport_uid: ?[*:0]const u8) void;
    pub const setTransportUid = e_source_mail_submission_set_transport_uid;

    /// Sets whether save messages to the sent folder at all.
    extern fn e_source_mail_submission_set_use_sent_folder(p_extension: *SourceMailSubmission, p_use_sent_folder: c_int) void;
    pub const setUseSentFolder = e_source_mail_submission_set_use_sent_folder;

    extern fn e_source_mail_submission_get_type() usize;
    pub const getGObjectType = e_source_mail_submission_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceMailSubmission) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceMailSubmission) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceMailSubmission, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceMailTransport = extern struct {
    pub const Parent = edataserver.SourceBackend;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceMailTransportClass;
    f_parent: edataserver.SourceBackend,
    f_priv: ?*edataserver.SourceMailTransportPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_source_mail_transport_get_type() usize;
    pub const getGObjectType = e_source_mail_transport_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceMailTransport) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceMailTransport) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceMailTransport, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceMemoList = extern struct {
    pub const Parent = edataserver.SourceSelectable;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceMemoListClass;
    f_parent: edataserver.SourceSelectable,
    f_priv: ?*edataserver.SourceMemoListPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_source_memo_list_get_type() usize;
    pub const getGObjectType = e_source_memo_list_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceMemoList) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceMemoList) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceMemoList, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceOffline = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceOfflineClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceOfflinePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const stay_synchronized = struct {
            pub const name = "stay-synchronized";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns whether data from a remote server should be cached locally
    /// for viewing while offline.  Backends are responsible for implementing
    /// such caching.
    extern fn e_source_offline_get_stay_synchronized(p_extension: *SourceOffline) c_int;
    pub const getStaySynchronized = e_source_offline_get_stay_synchronized;

    /// Sets whether data from a remote server should be cached locally for
    /// viewing while offline.  Backends are responsible for implementing
    /// such caching.
    extern fn e_source_offline_set_stay_synchronized(p_extension: *SourceOffline, p_stay_synchronized: c_int) void;
    pub const setStaySynchronized = e_source_offline_set_stay_synchronized;

    extern fn e_source_offline_get_type() usize;
    pub const getGObjectType = e_source_offline_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceOffline) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceOffline) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceOffline, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceOpenPGP = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceOpenPGPClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceOpenPGPPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const always_trust = struct {
            pub const name = "always-trust";

            pub const Type = c_int;
        };

        pub const ask_send_public_key = struct {
            pub const name = "ask-send-public-key";

            pub const Type = c_int;
        };

        pub const encrypt_by_default = struct {
            pub const name = "encrypt-by-default";

            pub const Type = c_int;
        };

        pub const encrypt_to_self = struct {
            pub const name = "encrypt-to-self";

            pub const Type = c_int;
        };

        pub const key_id = struct {
            pub const name = "key-id";

            pub const Type = ?[*:0]u8;
        };

        pub const locate_keys = struct {
            pub const name = "locate-keys";

            pub const Type = c_int;
        };

        pub const prefer_inline = struct {
            pub const name = "prefer-inline";

            pub const Type = c_int;
        };

        pub const send_prefer_encrypt = struct {
            pub const name = "send-prefer-encrypt";

            pub const Type = c_int;
        };

        pub const send_public_key = struct {
            pub const name = "send-public-key";

            pub const Type = c_int;
        };

        pub const sign_by_default = struct {
            pub const name = "sign-by-default";

            pub const Type = c_int;
        };

        pub const signing_algorithm = struct {
            pub const name = "signing-algorithm";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceOpenPGP.getKeyId`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_openpgp_dup_key_id(p_extension: *SourceOpenPGP) [*:0]u8;
    pub const dupKeyId = e_source_openpgp_dup_key_id;

    /// Thread-safe variation of `edataserver.SourceOpenPGP.getSigningAlgorithm`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_openpgp_dup_signing_algorithm(p_extension: *SourceOpenPGP) [*:0]u8;
    pub const dupSigningAlgorithm = e_source_openpgp_dup_signing_algorithm;

    /// Returns whether to skip key validation and assume that used keys are
    /// always fully trusted.
    extern fn e_source_openpgp_get_always_trust(p_extension: *SourceOpenPGP) c_int;
    pub const getAlwaysTrust = e_source_openpgp_get_always_trust;

    /// Returns, whether should ask before sending PGP public key in messages. The default is `TRUE`.
    extern fn e_source_openpgp_get_ask_send_public_key(p_extension: *SourceOpenPGP) c_int;
    pub const getAskSendPublicKey = e_source_openpgp_get_ask_send_public_key;

    /// Returns whether to digitally encrypt outgoing messages by default using
    /// OpenPGP-compliant software such as GNU Privacy Guard (GnuPG).
    extern fn e_source_openpgp_get_encrypt_by_default(p_extension: *SourceOpenPGP) c_int;
    pub const getEncryptByDefault = e_source_openpgp_get_encrypt_by_default;

    /// Returns whether to "encrypt-to-self" when sending encrypted messages.
    extern fn e_source_openpgp_get_encrypt_to_self(p_extension: *SourceOpenPGP) c_int;
    pub const getEncryptToSelf = e_source_openpgp_get_encrypt_to_self;

    /// Returns the OpenPGP key ID used to sign and encrypt messages.
    extern fn e_source_openpgp_get_key_id(p_extension: *SourceOpenPGP) [*:0]const u8;
    pub const getKeyId = e_source_openpgp_get_key_id;

    /// Returns, whether gpg can locate keys using Web Key Directory (WKD) lookup
    /// when encrypting messages. The default is `TRUE`.
    extern fn e_source_openpgp_get_locate_keys(p_extension: *SourceOpenPGP) c_int;
    pub const getLocateKeys = e_source_openpgp_get_locate_keys;

    /// Returns whether to prefer inline sign/encrypt of the text/plain messages.
    extern fn e_source_openpgp_get_prefer_inline(p_extension: *SourceOpenPGP) c_int;
    pub const getPreferInline = e_source_openpgp_get_prefer_inline;

    /// Returns, whether should claim the encryption is preferred when sending
    /// public key in messages. The default is `TRUE`.
    extern fn e_source_openpgp_get_send_prefer_encrypt(p_extension: *SourceOpenPGP) c_int;
    pub const getSendPreferEncrypt = e_source_openpgp_get_send_prefer_encrypt;

    /// Returns, whether should send PGP public key in messages. The default is `TRUE`.
    extern fn e_source_openpgp_get_send_public_key(p_extension: *SourceOpenPGP) c_int;
    pub const getSendPublicKey = e_source_openpgp_get_send_public_key;

    /// Returns whether to digitally sign outgoing messages by default using
    /// OpenPGP-compliant software such as GNU Privacy Guard (GnuPG).
    extern fn e_source_openpgp_get_sign_by_default(p_extension: *SourceOpenPGP) c_int;
    pub const getSignByDefault = e_source_openpgp_get_sign_by_default;

    /// Returns the name of the hash algorithm used to digitally sign outgoing
    /// messages.
    extern fn e_source_openpgp_get_signing_algorithm(p_extension: *SourceOpenPGP) [*:0]const u8;
    pub const getSigningAlgorithm = e_source_openpgp_get_signing_algorithm;

    /// Sets whether to skip key validation and assume that used keys are
    /// always fully trusted.
    extern fn e_source_openpgp_set_always_trust(p_extension: *SourceOpenPGP, p_always_trust: c_int) void;
    pub const setAlwaysTrust = e_source_openpgp_set_always_trust;

    /// Sets the `ask_send_public_key` on the `extension`, which tells the client to
    /// ask before user sends public key in the messages in an Autocrypt header.
    extern fn e_source_openpgp_set_ask_send_public_key(p_extension: *SourceOpenPGP, p_ask_send_public_key: c_int) void;
    pub const setAskSendPublicKey = e_source_openpgp_set_ask_send_public_key;

    /// Sets whether to digitally encrypt outgoing messages by default using
    /// OpenPGP-compliant software such as GNU Privacy Guard (GnuPG).
    extern fn e_source_openpgp_set_encrypt_by_default(p_extension: *SourceOpenPGP, p_encrypt_by_default: c_int) void;
    pub const setEncryptByDefault = e_source_openpgp_set_encrypt_by_default;

    /// Sets whether to "encrypt-to-self" when sending encrypted messages.
    extern fn e_source_openpgp_set_encrypt_to_self(p_extension: *SourceOpenPGP, p_encrypt_to_self: c_int) void;
    pub const setEncryptToSelf = e_source_openpgp_set_encrypt_to_self;

    /// Sets the OpenPGP key ID used to sign and encrypt messages.
    ///
    /// The internal copy of `key_id` is automatically stripped of leading and
    /// trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_openpgp_set_key_id(p_extension: *SourceOpenPGP, p_key_id: [*:0]const u8) void;
    pub const setKeyId = e_source_openpgp_set_key_id;

    /// Sets the `locate_keys` on the `extension`, which is used to instruct
    /// gpg to locate keys using Web Key Directory (WKD) lookup when encrypting
    /// messages.
    extern fn e_source_openpgp_set_locate_keys(p_extension: *SourceOpenPGP, p_locate_keys: c_int) void;
    pub const setLocateKeys = e_source_openpgp_set_locate_keys;

    /// Sets whether to prefer inline sign/encrypt of the text/plain messages.
    extern fn e_source_openpgp_set_prefer_inline(p_extension: *SourceOpenPGP, p_prefer_inline: c_int) void;
    pub const setPreferInline = e_source_openpgp_set_prefer_inline;

    /// Sets the `send_prefer_encrypt` on the `extension`, which tells the client to
    /// claim the user prefer encryption when also sending its public key in
    /// the messages (`edataserver.SourceOpenPGP.setSendPublicKey`).
    extern fn e_source_openpgp_set_send_prefer_encrypt(p_extension: *SourceOpenPGP, p_send_prefer_encrypt: c_int) void;
    pub const setSendPreferEncrypt = e_source_openpgp_set_send_prefer_encrypt;

    /// Sets the `send_public_key` on the `extension`, which tells the client to
    /// include user's public key in the messages in an Autocrypt header.
    extern fn e_source_openpgp_set_send_public_key(p_extension: *SourceOpenPGP, p_send_public_key: c_int) void;
    pub const setSendPublicKey = e_source_openpgp_set_send_public_key;

    /// Sets whether to digitally sign outgoing messages by default using
    /// OpenPGP-compliant software such as GNU Privacy Guard (GnuPG).
    extern fn e_source_openpgp_set_sign_by_default(p_extension: *SourceOpenPGP, p_sign_by_default: c_int) void;
    pub const setSignByDefault = e_source_openpgp_set_sign_by_default;

    /// Sets the name of the hash algorithm used to digitally sign outgoing
    /// messages.
    ///
    /// The internal copy of `signing_algorithm` is automatically stripped of
    /// leading and trailing whitespace.  If the resulting string is empty,
    /// `NULL` is set instead.
    extern fn e_source_openpgp_set_signing_algorithm(p_extension: *SourceOpenPGP, p_signing_algorithm: [*:0]const u8) void;
    pub const setSigningAlgorithm = e_source_openpgp_set_signing_algorithm;

    extern fn e_source_openpgp_get_type() usize;
    pub const getGObjectType = e_source_openpgp_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceOpenPGP) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceOpenPGP) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceOpenPGP, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceProxy = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceProxyClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceProxyPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const autoconfig_url = struct {
            pub const name = "autoconfig-url";

            pub const Type = ?[*:0]u8;
        };

        pub const ftp_host = struct {
            pub const name = "ftp-host";

            pub const Type = ?[*:0]u8;
        };

        pub const ftp_port = struct {
            pub const name = "ftp-port";

            pub const Type = c_uint;
        };

        pub const http_auth_password = struct {
            pub const name = "http-auth-password";

            pub const Type = ?[*:0]u8;
        };

        pub const http_auth_user = struct {
            pub const name = "http-auth-user";

            pub const Type = ?[*:0]u8;
        };

        pub const http_host = struct {
            pub const name = "http-host";

            pub const Type = ?[*:0]u8;
        };

        pub const http_port = struct {
            pub const name = "http-port";

            pub const Type = c_uint;
        };

        pub const http_use_auth = struct {
            pub const name = "http-use-auth";

            pub const Type = c_int;
        };

        pub const https_host = struct {
            pub const name = "https-host";

            pub const Type = ?[*:0]u8;
        };

        pub const https_port = struct {
            pub const name = "https-port";

            pub const Type = c_uint;
        };

        pub const ignore_hosts = struct {
            pub const name = "ignore-hosts";

            pub const Type = ?[*][*:0]u8;
        };

        pub const method = struct {
            pub const name = "method";

            pub const Type = edataserver.ProxyMethod;
        };

        pub const socks_host = struct {
            pub const name = "socks-host";

            pub const Type = ?[*:0]u8;
        };

        pub const socks_port = struct {
            pub const name = "socks-port";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceProxy.getAutoconfigUrl`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_proxy_dup_autoconfig_url(p_extension: *SourceProxy) [*:0]u8;
    pub const dupAutoconfigUrl = e_source_proxy_dup_autoconfig_url;

    /// Thread-safe variation of `edataserver.SourceProxy.getFtpHost`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_proxy_dup_ftp_host(p_extension: *SourceProxy) [*:0]u8;
    pub const dupFtpHost = e_source_proxy_dup_ftp_host;

    /// Thread-safe variation of `edataserver.SourceProxy.getHttpAuthPassword`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_proxy_dup_http_auth_password(p_extension: *SourceProxy) [*:0]u8;
    pub const dupHttpAuthPassword = e_source_proxy_dup_http_auth_password;

    /// Thread-safe variation of `edataserver.SourceProxy.getHttpAuthUser`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_proxy_dup_http_auth_user(p_extension: *SourceProxy) [*:0]u8;
    pub const dupHttpAuthUser = e_source_proxy_dup_http_auth_user;

    /// Thread-safe variation of `edataserver.SourceProxy.getHttpHost`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_proxy_dup_http_host(p_extension: *SourceProxy) [*:0]u8;
    pub const dupHttpHost = e_source_proxy_dup_http_host;

    /// Threads-safe variation of `edataserver.SourceProxy.getHttpsHost`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_proxy_dup_https_host(p_extension: *SourceProxy) [*:0]u8;
    pub const dupHttpsHost = e_source_proxy_dup_https_host;

    /// Thread-safe variation of `edataserver.SourceProxy.getIgnoreHosts`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string array should be freed with `glib.strfreev` when no
    /// longer needed.
    extern fn e_source_proxy_dup_ignore_hosts(p_extension: *SourceProxy) [*][*:0]u8;
    pub const dupIgnoreHosts = e_source_proxy_dup_ignore_hosts;

    /// Thread-safe variation of `edataserver.SourceProxy.getSocksHost`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_proxy_dup_socks_host(p_extension: *SourceProxy) [*:0]u8;
    pub const dupSocksHost = e_source_proxy_dup_socks_host;

    /// Returns the URL that provides proxy configuration values.  When the
    /// `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_AUTO`, this URL
    /// is used to look up proxy information for all protocols.
    extern fn e_source_proxy_get_autoconfig_url(p_extension: *SourceProxy) [*:0]const u8;
    pub const getAutoconfigUrl = e_source_proxy_get_autoconfig_url;

    /// Returns the machine name to proxy FTP through when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_ftp_host(p_extension: *SourceProxy) [*:0]const u8;
    pub const getFtpHost = e_source_proxy_get_ftp_host;

    /// Returns the port on the machine defined by `edataserver.SourceProxy.properties.ftp`-host to proxy
    /// through when `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_ftp_port(p_extension: *SourceProxy) u16;
    pub const getFtpPort = e_source_proxy_get_ftp_port;

    /// Returns the password to pass as authentication when doing HTTP proxying
    /// and `edataserver.SourceProxy.properties.http`-use-auth is `TRUE`.
    extern fn e_source_proxy_get_http_auth_password(p_extension: *SourceProxy) [*:0]const u8;
    pub const getHttpAuthPassword = e_source_proxy_get_http_auth_password;

    /// Returns the user name to pass as authentication when doing HTTP proxying
    /// and `edataserver.SourceProxy.properties.http`-use-auth is `TRUE`.
    extern fn e_source_proxy_get_http_auth_user(p_extension: *SourceProxy) [*:0]const u8;
    pub const getHttpAuthUser = e_source_proxy_get_http_auth_user;

    /// Returns the machine name to proxy HTTP through when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_http_host(p_extension: *SourceProxy) [*:0]const u8;
    pub const getHttpHost = e_source_proxy_get_http_host;

    /// Returns the port on the machine defined by `edataserver.SourceProxy.properties.http`-host to proxy
    /// through when `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_http_port(p_extension: *SourceProxy) u16;
    pub const getHttpPort = e_source_proxy_get_http_port;

    /// Returns whether the HTTP proxy server at `edataserver.SourceProxy.properties.http`-host and
    /// `edataserver.SourceProxy.properties.http`-port requires authentication.
    ///
    /// The username/password combo is defined by `edataserver.SourceProxy.properties.http`-auth-user
    /// and `edataserver.SourceProxy.properties.http`-auth-password, but only applies when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_http_use_auth(p_extension: *SourceProxy) c_int;
    pub const getHttpUseAuth = e_source_proxy_get_http_use_auth;

    /// Returns the machine name to proxy secure HTTP through when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_https_host(p_extension: *SourceProxy) [*:0]const u8;
    pub const getHttpsHost = e_source_proxy_get_https_host;

    /// Returns the port on the machine defined by `edataserver.SourceProxy.properties.https`-host to proxy
    /// through when `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_https_port(p_extension: *SourceProxy) u16;
    pub const getHttpsPort = e_source_proxy_get_https_port;

    /// Returns a `NULL`-terminated string array of hosts which are connected to
    /// directly, rather than via the proxy (if it is active).  The array elements
    /// can be hostnames, domains (using an initial wildcard like *.foo.com), IP
    /// host addresses (both IPv4 and IPv6) and network addresses with a netmask
    /// (something like 192.168.0.0/24).
    ///
    /// The returned array is owned by `extension` and should not be modified or
    /// freed.
    extern fn e_source_proxy_get_ignore_hosts(p_extension: *SourceProxy) [*]const [*:0]const u8;
    pub const getIgnoreHosts = e_source_proxy_get_ignore_hosts;

    /// Returns the proxy configuration method for `extension`.
    ///
    /// The proxy configuration method determines the behavior of
    /// `edataserver.Source.proxyLookup`.
    extern fn e_source_proxy_get_method(p_extension: *SourceProxy) edataserver.ProxyMethod;
    pub const getMethod = e_source_proxy_get_method;

    /// Returns the machine name to use as a SOCKS proxy when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_socks_host(p_extension: *SourceProxy) [*:0]const u8;
    pub const getSocksHost = e_source_proxy_get_socks_host;

    /// Returns the port on the machine defined by `edataserver.SourceProxy.properties.socks`-host to proxy
    /// through when `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_get_socks_port(p_extension: *SourceProxy) u16;
    pub const getSocksPort = e_source_proxy_get_socks_port;

    /// Sets the URL that provides proxy configuration values.  When the
    /// `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_AUTO`, this URL
    /// is used to look up proxy information for all protocols.
    extern fn e_source_proxy_set_autoconfig_url(p_extension: *SourceProxy, p_autoconfig_url: [*:0]const u8) void;
    pub const setAutoconfigUrl = e_source_proxy_set_autoconfig_url;

    /// Sets the machine name to proxy FTP through when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_ftp_host(p_extension: *SourceProxy, p_ftp_host: [*:0]const u8) void;
    pub const setFtpHost = e_source_proxy_set_ftp_host;

    /// Sets the port on the machine defined by `edataserver.SourceProxy.properties.ftp`-host to proxy
    /// through when `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_ftp_port(p_extension: *SourceProxy, p_ftp_port: u16) void;
    pub const setFtpPort = e_source_proxy_set_ftp_port;

    /// Sets the password to pass as authentication when doing HTTP proxying
    /// and `edataserver.SourceProxy.properties.http`-use-auth is `TRUE`.
    extern fn e_source_proxy_set_http_auth_password(p_extension: *SourceProxy, p_http_auth_password: [*:0]const u8) void;
    pub const setHttpAuthPassword = e_source_proxy_set_http_auth_password;

    /// Sets the user name to pass as authentication when doing HTTP proxying
    /// and `edataserver.SourceProxy.properties.http`-use-auth is `TRUE`.
    extern fn e_source_proxy_set_http_auth_user(p_extension: *SourceProxy, p_http_auth_user: [*:0]const u8) void;
    pub const setHttpAuthUser = e_source_proxy_set_http_auth_user;

    /// Sets the machine name to proxy HTTP through when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_http_host(p_extension: *SourceProxy, p_http_host: [*:0]const u8) void;
    pub const setHttpHost = e_source_proxy_set_http_host;

    /// Sets the port on the machine defined by `edataserver.SourceProxy.properties.http`-host to proxy
    /// through when `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_http_port(p_extension: *SourceProxy, p_http_port: u16) void;
    pub const setHttpPort = e_source_proxy_set_http_port;

    /// Sets whether the HTTP proxy server at `edataserver.SourceProxy.properties.http`-host and
    /// `edataserver.SourceProxy.properties.http`-port requires authentication.
    ///
    /// The username/password combo is defined by `edataserver.SourceProxy.properties.http`-auth-user
    /// and `edataserver.SourceProxy.properties.http`-auth-password, but only applies when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_http_use_auth(p_extension: *SourceProxy, p_http_use_auth: c_int) void;
    pub const setHttpUseAuth = e_source_proxy_set_http_use_auth;

    /// Sets the machine name to proxy secure HTTP through when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_https_host(p_extension: *SourceProxy, p_https_host: [*:0]const u8) void;
    pub const setHttpsHost = e_source_proxy_set_https_host;

    /// Sets the port on the machine defined by `edataserver.SourceProxy.properties.https`-host to proxy
    /// through when `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_https_port(p_extension: *SourceProxy, p_https_port: u16) void;
    pub const setHttpsPort = e_source_proxy_set_https_port;

    /// Sets the hosts which are connected to directly, rather than via the proxy
    /// (if it is active).  The array elements can be hostnames, domains (using an
    /// initial wildcard like *.foo.com), IP host addresses (both IPv4 and IPv6)
    /// and network addresses with a netmask (something like 192.168.0.0/24).
    extern fn e_source_proxy_set_ignore_hosts(p_extension: *SourceProxy, p_ignore_hosts: *const [*:0]const u8) void;
    pub const setIgnoreHosts = e_source_proxy_set_ignore_hosts;

    /// Sets the proxy configuration method for `extension`.
    ///
    /// The proxy configuration method determines the behavior of
    /// `edataserver.Source.proxyLookup`.
    extern fn e_source_proxy_set_method(p_extension: *SourceProxy, p_method: edataserver.ProxyMethod) void;
    pub const setMethod = e_source_proxy_set_method;

    /// Sets the machine name to use as a SOCKS proxy when `extension`'s
    /// `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_socks_host(p_extension: *SourceProxy, p_socks_host: [*:0]const u8) void;
    pub const setSocksHost = e_source_proxy_set_socks_host;

    /// Sets the port on the machine defined by `edataserver.SourceProxy.properties.socks`-host to proxy
    /// through when `extension`'s `edataserver.SourceProxy.properties.method` is `E_PROXY_METHOD_MANUAL`.
    extern fn e_source_proxy_set_socks_port(p_extension: *SourceProxy, p_socks_port: u16) void;
    pub const setSocksPort = e_source_proxy_set_socks_port;

    extern fn e_source_proxy_get_type() usize;
    pub const getGObjectType = e_source_proxy_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceProxy) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceProxy) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceProxy, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceRefresh = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceRefreshClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceRefreshPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const enabled = struct {
            pub const name = "enabled";

            pub const Type = c_int;
        };

        pub const enabled_on_metered_network = struct {
            pub const name = "enabled-on-metered-network";

            pub const Type = c_int;
        };

        pub const interval_minutes = struct {
            pub const name = "interval-minutes";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    /// Returns whether to periodically fetch updates from a remote server.
    ///
    /// The refresh interval is determined by the `edataserver.SourceRefresh.properties.interval`-minutes
    /// property.
    extern fn e_source_refresh_get_enabled(p_extension: *SourceRefresh) c_int;
    pub const getEnabled = e_source_refresh_get_enabled;

    /// Returns whether can refresh content on metered network.
    ///
    /// The `extension` itself doesn't use this option, it's up to
    /// the `extension` user to determine what kind of connection is used
    /// and then decide whether refresh, or other expensive network
    /// operations, can be done.
    extern fn e_source_refresh_get_enabled_on_metered_network(p_extension: *SourceRefresh) c_int;
    pub const getEnabledOnMeteredNetwork = e_source_refresh_get_enabled_on_metered_network;

    /// Returns the interval for fetching updates from a remote server.
    ///
    /// Note this value is only effective when the `edataserver.SourceRefresh.properties.enabled`
    /// property is `TRUE`.
    extern fn e_source_refresh_get_interval_minutes(p_extension: *SourceRefresh) c_uint;
    pub const getIntervalMinutes = e_source_refresh_get_interval_minutes;

    /// Sets whether to periodically fetch updates from a remote server.
    ///
    /// The refresh interval is determined by the `edataserver.SourceRefresh.properties.interval`-minutes
    /// property.
    extern fn e_source_refresh_set_enabled(p_extension: *SourceRefresh, p_enabled: c_int) void;
    pub const setEnabled = e_source_refresh_set_enabled;

    /// Sets whether can refresh content on metered network.
    ///
    /// See `edataserver.SourceRefresh.getEnabledOnMeteredNetwork` for more information
    /// about what it means.
    extern fn e_source_refresh_set_enabled_on_metered_network(p_extension: *SourceRefresh, p_enabled: c_int) void;
    pub const setEnabledOnMeteredNetwork = e_source_refresh_set_enabled_on_metered_network;

    /// Sets the interval for fetching updates from a remote server.
    ///
    /// Note this value is only effective when the `edataserver.SourceRefresh.properties.enabled`
    /// property is `TRUE`.
    extern fn e_source_refresh_set_interval_minutes(p_extension: *SourceRefresh, p_interval_minutes: c_uint) void;
    pub const setIntervalMinutes = e_source_refresh_set_interval_minutes;

    extern fn e_source_refresh_get_type() usize;
    pub const getGObjectType = e_source_refresh_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceRefresh) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceRefresh) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceRefresh, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceRegistry = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{ gio.AsyncInitable, gio.Initable };
    pub const Class = edataserver.SourceRegistryClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.SourceRegistryPrivate,

    pub const virtual_methods = struct {
        pub const credentials_required = struct {
            pub fn call(p_class: anytype, p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: *const glib.Error) void {
                return gobject.ext.as(SourceRegistry.Class, p_class).f_credentials_required.?(gobject.ext.as(SourceRegistry, p_registry), p_source, p_reason, p_certificate_pem, p_certificate_errors, p_op_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: *const glib.Error) callconv(.c) void) void {
                gobject.ext.as(SourceRegistry.Class, p_class).f_credentials_required = @ptrCast(p_implementation);
            }
        };

        pub const source_added = struct {
            pub fn call(p_class: anytype, p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistry.Class, p_class).f_source_added.?(gobject.ext.as(SourceRegistry, p_registry), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistry.Class, p_class).f_source_added = @ptrCast(p_implementation);
            }
        };

        pub const source_changed = struct {
            pub fn call(p_class: anytype, p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistry.Class, p_class).f_source_changed.?(gobject.ext.as(SourceRegistry, p_registry), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistry.Class, p_class).f_source_changed = @ptrCast(p_implementation);
            }
        };

        pub const source_disabled = struct {
            pub fn call(p_class: anytype, p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistry.Class, p_class).f_source_disabled.?(gobject.ext.as(SourceRegistry, p_registry), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistry.Class, p_class).f_source_disabled = @ptrCast(p_implementation);
            }
        };

        pub const source_enabled = struct {
            pub fn call(p_class: anytype, p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistry.Class, p_class).f_source_enabled.?(gobject.ext.as(SourceRegistry, p_registry), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistry.Class, p_class).f_source_enabled = @ptrCast(p_implementation);
            }
        };

        pub const source_removed = struct {
            pub fn call(p_class: anytype, p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistry.Class, p_class).f_source_removed.?(gobject.ext.as(SourceRegistry, p_registry), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_registry: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistry.Class, p_class).f_source_removed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The default address book `edataserver.Source`.
        pub const default_address_book = struct {
            pub const name = "default-address-book";

            pub const Type = ?*edataserver.Source;
        };

        /// The default calendar `edataserver.Source`.
        pub const default_calendar = struct {
            pub const name = "default-calendar";

            pub const Type = ?*edataserver.Source;
        };

        /// The default mail account `edataserver.Source`.
        pub const default_mail_account = struct {
            pub const name = "default-mail-account";

            pub const Type = ?*edataserver.Source;
        };

        /// The default mail identity `edataserver.Source`.
        pub const default_mail_identity = struct {
            pub const name = "default-mail-identity";

            pub const Type = ?*edataserver.Source;
        };

        /// The default memo list `edataserver.Source`.
        pub const default_memo_list = struct {
            pub const name = "default-memo-list";

            pub const Type = ?*edataserver.Source;
        };

        /// The default task list `edataserver.Source`.
        pub const default_task_list = struct {
            pub const name = "default-task-list";

            pub const Type = ?*edataserver.Source;
        };
    };

    pub const signals = struct {
        /// The ::credentials-required signal is emitted when the `source`
        /// requires credentials to connect to (possibly remote)
        /// data store. The credentials can be passed to the source using
        /// `edataserver.Source.invokeAuthenticate` function. The signal is emitted in
        /// the thread-default main context from the time the `registry` was created.
        ///
        /// Note: This is just a proxy signal for the ESource::credentials-required signal.
        pub const credentials_required = struct {
            pub const name = "credentials-required";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: *glib.Error, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistry, p_instance))),
                    gobject.signalLookup("credentials-required", SourceRegistry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `edataserver.Source` is added to `registry`.
        pub const source_added = struct {
            pub const name = "source-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistry, p_instance))),
                    gobject.signalLookup("source-added", SourceRegistry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `edataserver.Source` registered with `registry` emits
        /// its `edataserver.Source.signals.changed` signal.
        pub const source_changed = struct {
            pub const name = "source-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistry, p_instance))),
                    gobject.signalLookup("source-changed", SourceRegistry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `edataserver.Source` `edataserver.Source.properties.enabled` property becomes `FALSE`.
        pub const source_disabled = struct {
            pub const name = "source-disabled";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistry, p_instance))),
                    gobject.signalLookup("source-disabled", SourceRegistry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `edataserver.Source` `edataserver.Source.properties.enabled` property becomes `TRUE`.
        pub const source_enabled = struct {
            pub const name = "source-enabled";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistry, p_instance))),
                    gobject.signalLookup("source-enabled", SourceRegistry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `edataserver.Source` is removed from `registry`.
        pub const source_removed = struct {
            pub const name = "source-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistry, p_instance))),
                    gobject.signalLookup("source-removed", SourceRegistry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn e_source_registry_debug_enabled() c_int;
    pub const debugEnabled = e_source_registry_debug_enabled;

    /// Prints the text only if a debugging is enabled with an environment
    /// variable ESR_DEBUG=1.
    extern fn e_source_registry_debug_print(p_format: [*:0]const u8, ...) void;
    pub const debugPrint = e_source_registry_debug_print;

    /// Convenience function to free a `glib.Node` tree of registered
    /// sources created by `edataserver.SourceRegistry.buildDisplayTree`.
    extern fn e_source_registry_free_display_tree(p_display_tree: *glib.Node) void;
    pub const freeDisplayTree = e_source_registry_free_display_tree;

    /// Asynchronously creates a new `edataserver.SourceRegistry` front-end for the registry
    /// D-Bus service.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.SourceRegistry.newFinish` to get the result of the operation.
    ///
    /// Since 3.12 a singleton will be returned.  No strong reference is kept
    /// internally, so it is the caller's responsibility to keep one.
    extern fn e_source_registry_new(p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const new = e_source_registry_new;

    /// Finishes the operation started with `edataserver.SourceRegistry.newFinish`.
    /// If an error occurs in connecting to the D-Bus service, the function
    /// sets `error` and returns `NULL`.
    extern fn e_source_registry_new_finish(p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*edataserver.SourceRegistry;
    pub const newFinish = e_source_registry_new_finish;

    /// Creates a new `edataserver.SourceRegistry` front-end for the registry D-Bus service.
    /// If an error occurs in connecting to the D-Bus service, the function sets
    /// `error` and returns `NULL`.
    ///
    /// Since 3.12 a singleton will be returned.  No strong reference is kept
    /// internally, so it is the caller's responsibility to keep one.
    extern fn e_source_registry_new_sync(p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*edataserver.SourceRegistry;
    pub const newSync = e_source_registry_new_sync;

    /// Returns a single `glib.Node` tree of registered sources that can be used to
    /// populate a `GtkTreeModel`.  (The root `glib.Node` is just an empty placeholder.)
    ///
    /// Similar to `edataserver.SourceRegistry.listSources`, an `extension_name` can be
    /// given to restrict the tree to sources having that extension name.  Parents
    /// of matched sources are included in the tree regardless of whether they have
    /// an extension named `extension_name`.
    ///
    /// Disabled leaf nodes are automatically excluded from the `glib.Node` tree.
    ///
    /// The sources returned in the tree are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned tree itself with `glib.Node.destroy`.
    /// For convenience, `edataserver.SourceRegistry.freeDisplayTree` does all
    /// that in one step.
    extern fn e_source_registry_build_display_tree(p_registry: *SourceRegistry, p_extension_name: ?[*:0]const u8) *glib.Node;
    pub const buildDisplayTree = e_source_registry_build_display_tree;

    /// Determines whether `source` is "effectively" enabled by examining its
    /// own `edataserver.Source.properties.enabled` property as well as those of its ancestors in the
    /// `edataserver.Source` hierarchy.  If all examined `edataserver.Source.properties.enabled` properties are
    /// `TRUE`, then the function returns `TRUE`.  If any are `FALSE`, then the
    /// function returns `FALSE`.
    ///
    /// Use this function instead of `edataserver.Source.getEnabled` to determine
    /// things like whether to display an `edataserver.Source` in a user interface or
    /// whether to act on the data set described by the `edataserver.Source`.
    extern fn e_source_registry_check_enabled(p_registry: *SourceRegistry, p_source: *edataserver.Source) c_int;
    pub const checkEnabled = e_source_registry_check_enabled;

    /// See `edataserver.SourceRegistry.commitSourceSync` for details.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.SourceRegistry.commitSourceFinish` to get the result of the
    /// operation.
    extern fn e_source_registry_commit_source(p_registry: *SourceRegistry, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const commitSource = e_source_registry_commit_source;

    /// Finishes the operation started with `edataserver.SourceRegistry.commitSource`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_source_registry_commit_source_finish(p_registry: *SourceRegistry, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const commitSourceFinish = e_source_registry_commit_source_finish;

    /// This is a convenience function intended for use with graphical
    /// `edataserver.Source` editors.  Call this function when the user is finished
    /// making changes to `source`.
    ///
    /// If `source` has a `gio.DBusObject`, its contents are submitted to the D-Bus
    /// service through `edataserver.Source.writeSync`.
    ///
    /// If `source` does NOT have a `gio.DBusObject` (implying it's a scratch
    /// `edataserver.Source`), its contents are submitted to the D-Bus service through
    /// either `edataserver.Source.remoteCreateSync` if `source` is to be a collection
    /// member, or `edataserver.SourceRegistry.createSourcesSync` if `source` to be an
    /// independent data source.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_source_registry_commit_source_sync(p_registry: *SourceRegistry, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const commitSourceSync = e_source_registry_commit_source_sync;

    /// Asynchronously requests the D-Bus service create new key files for each
    /// `edataserver.Source` in `list_of_sources`.  Each list element must be a scratch
    /// `edataserver.Source` with no `gio.DBusObject`.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `edataserver.SourceRegistry.createSourcesFinish` to get the result of the
    /// operation.
    extern fn e_source_registry_create_sources(p_registry: *SourceRegistry, p_list_of_sources: *glib.List, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const createSources = e_source_registry_create_sources;

    /// Finishes the operation started with `edataserver.SourceRegistry.createSources`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_source_registry_create_sources_finish(p_registry: *SourceRegistry, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const createSourcesFinish = e_source_registry_create_sources_finish;

    /// Requests the D-Bus service create new key files for each `edataserver.Source` in
    /// `list_of_sources`.  Each list element must be a scratch `edataserver.Source` with
    /// no `gio.DBusObject`.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_source_registry_create_sources_sync(p_registry: *SourceRegistry, p_list_of_sources: *glib.List, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const createSourcesSync = e_source_registry_create_sources_sync;

    /// Handy debugging function that uses `edataserver.SourceRegistry.buildDisplayTree`
    /// to print a tree of registered sources to standard output.
    extern fn e_source_registry_debug_dump(p_registry: *SourceRegistry, p_extension_name: ?[*:0]const u8) void;
    pub const debugDump = e_source_registry_debug_dump;

    /// Compares `source`'s `edataserver.Source.properties.display`-name against other sources having
    /// an `edataserver.SourceExtension` named `extension_name`, if given, or else against
    /// all other sources in the `registry`.
    ///
    /// If `sources`'s `edataserver.Source.properties.display`-name is unique among these other sources,
    /// the function will return the `edataserver.Source.properties.display`-name verbatim.  Otherwise
    /// the function will construct a string that includes the `sources`'s own
    /// `edataserver.Source.properties.display`-name as well as those of its ancestors.
    ///
    /// The function's return value is intended to be used in messages shown to
    /// the user to help clarify which source is being referred to.  It assumes
    /// `source`'s `edataserver.Source.properties.display`-name is at least unique among its siblings.
    ///
    /// Free the returned string with `glib.free` when finished with it.
    extern fn e_source_registry_dup_unique_display_name(p_registry: *SourceRegistry, p_source: *edataserver.Source, p_extension_name: ?[*:0]const u8) [*:0]u8;
    pub const dupUniqueDisplayName = e_source_registry_dup_unique_display_name;

    /// Examines `source` and its ancestors and returns the "deepest" `edataserver.Source`
    /// having an `edataserver.SourceExtension` with the given `extension_name`.  If neither
    /// `source` nor any of its ancestors have such an extension, the function
    /// returns `NULL`.
    ///
    /// This function is useful in cases when an `edataserver.SourceExtension` is meant to
    /// apply to both the `edataserver.Source` it belongs to and the `edataserver.Source`'s descendants.
    ///
    /// A common example is the `edataserver.SourceCollection` extension, where descendants
    /// of an `edataserver.Source` having an `edataserver.SourceCollection` extension are implied to be
    /// members of that collection.  In that example, this function can be used
    /// to test whether `source` is a member of a collection.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    ///
    /// Note the function returns the `edataserver.Source` containing the `edataserver.SourceExtension`
    /// instead of the `edataserver.SourceExtension` itself because extension instances are
    /// not to be referenced directly (see `edataserver.Source.getExtension`).
    extern fn e_source_registry_find_extension(p_registry: *SourceRegistry, p_source: *edataserver.Source, p_extension_name: [*:0]const u8) ?*edataserver.Source;
    pub const findExtension = e_source_registry_find_extension;

    extern fn e_source_registry_get_oauth2_services(p_registry: *SourceRegistry) *edataserver.OAuth2Services;
    pub const getOauth2Services = e_source_registry_get_oauth2_services;

    /// Similar to `edataserver.SourceRegistry.listSources`, but returns only enabled
    /// sources according to `edataserver.SourceRegistry.checkEnabled`.
    ///
    /// The sources returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned list itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_source_registry_list_enabled(p_registry: *SourceRegistry, p_extension_name: ?[*:0]const u8) *glib.List;
    pub const listEnabled = e_source_registry_list_enabled;

    /// Returns a list of registered sources, sorted by display name.  If
    /// `extension_name` is given, restrict the list to sources having that
    /// extension name.
    ///
    /// The sources returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned list itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_source_registry_list_sources(p_registry: *SourceRegistry, p_extension_name: ?[*:0]const u8) *glib.List;
    pub const listSources = e_source_registry_list_sources;

    /// Returns the built-in address book `edataserver.Source`.
    ///
    /// This `edataserver.Source` is always present and makes for a safe fallback.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_builtin_address_book(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refBuiltinAddressBook = e_source_registry_ref_builtin_address_book;

    /// Returns the built-in calendar `edataserver.Source`.
    ///
    /// This `edataserver.Source` is always present and makes for a safe fallback.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_builtin_calendar(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refBuiltinCalendar = e_source_registry_ref_builtin_calendar;

    /// Returns the built-in mail account `edataserver.Source`.
    ///
    /// This `edataserver.Source` is always present and makes for a safe fallback.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_builtin_mail_account(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refBuiltinMailAccount = e_source_registry_ref_builtin_mail_account;

    /// Returns the built-in memo list `edataserver.Source`.
    ///
    /// This `edataserver.Source` is always present and makes for a safe fallback.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_builtin_memo_list(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refBuiltinMemoList = e_source_registry_ref_builtin_memo_list;

    /// Returns the built-in proxy profile `edataserver.Source`.
    ///
    /// This `edataserver.Source` is always present and makes for a safe fallback.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_builtin_proxy(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refBuiltinProxy = e_source_registry_ref_builtin_proxy;

    /// Returns the built-in task list `edataserver.Source`.
    ///
    /// This `edataserver.Source` is always present and makes for a safe fallback.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_builtin_task_list(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refBuiltinTaskList = e_source_registry_ref_builtin_task_list;

    /// Returns the `edataserver.Source` most recently passed to
    /// `edataserver.SourceRegistry.setDefaultAddressBook` either in this session
    /// or a previous session, or else falls back to the built-in address book.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_default_address_book(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refDefaultAddressBook = e_source_registry_ref_default_address_book;

    /// Returns the `edataserver.Source` most recently passed to
    /// `edataserver.SourceRegistry.setDefaultCalendar` either in this session
    /// or a previous session, or else falls back to the built-in calendar.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_default_calendar(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refDefaultCalendar = e_source_registry_ref_default_calendar;

    /// This is a convenience function to return a default `edataserver.Source` based on
    /// `extension_name`.  This only works with a subset of extension names.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_ADDRESS_BOOK`, the function
    /// returns the current default address book, or else falls back to the
    /// built-in address book.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_CALENDAR`, the function returns
    /// the current default calendar, or else falls back to the built-in calendar.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_MAIL_ACCOUNT`, the function
    /// returns the current default mail account, or else falls back to the
    /// built-in mail account.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_MAIL_IDENTITY`, the function
    /// returns the current default mail identity, or else falls back to the
    /// mail identity named by the current default mail account.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_MEMO_LIST`, the function returns
    /// the current default memo list, or else falls back to the built-in memo list.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_TASK_LIST`, the function returns
    /// the current default task list, or else falls back to the built-in task list.
    ///
    /// For all other values of `extension_name`, the function returns `NULL`.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_default_for_extension_name(p_registry: *SourceRegistry, p_extension_name: [*:0]const u8) ?*edataserver.Source;
    pub const refDefaultForExtensionName = e_source_registry_ref_default_for_extension_name;

    /// Returns the `edataserver.Source` most recently passed to
    /// `edataserver.SourceRegistry.setDefaultMailAccount` either in this session
    /// or a previous session, or else falls back to the built-in mail account.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_default_mail_account(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refDefaultMailAccount = e_source_registry_ref_default_mail_account;

    /// Returns the `edataserver.Source` most recently passed to
    /// `edataserver.SourceRegistry.setDefaultMailIdentity` either in this session
    /// or a previous session, or else falls back to the mail identity named
    /// by the default mail account.  If even that fails it returns any mail
    /// identity from `registry`, or `NULL` if there are none.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_default_mail_identity(p_registry: *SourceRegistry) ?*edataserver.Source;
    pub const refDefaultMailIdentity = e_source_registry_ref_default_mail_identity;

    /// Returns the `edataserver.Source` most recently passed to
    /// `edataserver.SourceRegistry.setDefaultMemoList` either in this session
    /// or a previous session, or else falls back to the built-in memo list.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_default_memo_list(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refDefaultMemoList = e_source_registry_ref_default_memo_list;

    /// Returns the `edataserver.Source` most recently passed to
    /// `edataserver.SourceRegistry.setDefaultTaskList` either in this session
    /// or a previous session, or else falls back to the built-in task list.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_default_task_list(p_registry: *SourceRegistry) *edataserver.Source;
    pub const refDefaultTaskList = e_source_registry_ref_default_task_list;

    /// Looks up an `edataserver.Source` in `registry` by its unique identifier string.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_ref_source(p_registry: *SourceRegistry, p_uid: [*:0]const u8) ?*edataserver.Source;
    pub const refSource = e_source_registry_ref_source;

    /// Asynchronously requests the D-Bus service to refresh collection backend
    /// for an `edataserver.Source` with UID `source_uid`. The result means that the refresh
    /// had been scheduled not whether the refresh itself succeeded. The refresh
    /// is not initiated when the collection backend is offline.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserver.SourceRegistry.refreshBackendFinish` to get the result of
    /// the operation.
    extern fn e_source_registry_refresh_backend(p_registry: *SourceRegistry, p_source_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const refreshBackend = e_source_registry_refresh_backend;

    /// Finishes the operation started with `edataserver.SourceRegistry.refreshBackend`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_source_registry_refresh_backend_finish(p_registry: *SourceRegistry, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const refreshBackendFinish = e_source_registry_refresh_backend_finish;

    /// Requests the D-Bus service to refresh collection backend for an `edataserver.Source`
    /// with UID `source_uid`. The result means that the refresh had been scheduled
    /// not whether the refresh itself succeeded. The refresh is not initiated
    /// when the collection backend is offline.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_source_registry_refresh_backend_sync(p_registry: *SourceRegistry, p_source_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshBackendSync = e_source_registry_refresh_backend_sync;

    /// Sets `default_source` as the default address book.  If `default_source`
    /// is `NULL`, the default address book is reset to the built-in address book.
    /// This setting will persist across sessions until changed.
    extern fn e_source_registry_set_default_address_book(p_registry: *SourceRegistry, p_default_source: ?*edataserver.Source) void;
    pub const setDefaultAddressBook = e_source_registry_set_default_address_book;

    /// Sets `default_source` as the default calendar.  If `default_source`
    /// is `NULL`, the default calendar is reset to the built-in calendar.
    /// This setting will persist across sessions until changed.
    extern fn e_source_registry_set_default_calendar(p_registry: *SourceRegistry, p_default_source: ?*edataserver.Source) void;
    pub const setDefaultCalendar = e_source_registry_set_default_calendar;

    /// This is a convenience function to set a default `edataserver.Source` based on
    /// `extension_name`.  This only works with a subset of extension names.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_ADDRESS_BOOK`, the function
    /// sets `default_source` as the default address book.  If `default_source`
    /// is `NULL`, the default address book is reset to the built-in address book.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_CALENDAR`, the function sets
    /// `default_source` as the default calendar.  If `default_source` is `NULL`,
    /// the default calendar is reset to the built-in calendar.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_MAIL_ACCOUNT`, the function
    /// sets `default_source` as the default mail account.  If `default_source`
    /// is `NULL`, the default mail account is reset to the built-in mail account.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_MAIL_IDENTITY`, the function
    /// sets `default_source` as the default mail identity.  If `default_source`
    /// is `NULL`, the next request for the default mail identity will return
    /// the mail identity named by the default mail account.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_MEMO_LIST`, the function sets
    /// `default_source` as the default memo list.  If `default_source` is `NULL`,
    /// the default memo list is reset to the built-in memo list.
    ///
    /// If `extension_name` is `E_SOURCE_EXTENSION_TASK_LIST`, the function sets
    /// `default_source` as the default task list.  If `default_source` is `NULL`,
    /// the default task list is reset to the built-in task list.
    ///
    /// For all other values of `extension_name`, the function does nothing.
    extern fn e_source_registry_set_default_for_extension_name(p_registry: *SourceRegistry, p_extension_name: [*:0]const u8, p_default_source: ?*edataserver.Source) void;
    pub const setDefaultForExtensionName = e_source_registry_set_default_for_extension_name;

    /// Sets `default_source` as the default mail account.  If `default_source`
    /// is `NULL`, the default mail account is reset to the built-in mail account.
    /// This setting will persist across sessions until changed.
    extern fn e_source_registry_set_default_mail_account(p_registry: *SourceRegistry, p_default_source: ?*edataserver.Source) void;
    pub const setDefaultMailAccount = e_source_registry_set_default_mail_account;

    /// Sets `default_source` as the default mail identity.  If `default_source`
    /// is `NULL`, the next request for the default mail identity will use the
    /// fallbacks described in `edataserver.SourceRegistry.refDefaultMailIdentity`.
    extern fn e_source_registry_set_default_mail_identity(p_registry: *SourceRegistry, p_default_source: ?*edataserver.Source) void;
    pub const setDefaultMailIdentity = e_source_registry_set_default_mail_identity;

    /// Sets `default_source` as the default memo list.  If `default_source`
    /// is `NULL`, the default memo list is reset to the built-in memo list.
    /// This setting will persist across sessions until changed.
    extern fn e_source_registry_set_default_memo_list(p_registry: *SourceRegistry, p_default_source: ?*edataserver.Source) void;
    pub const setDefaultMemoList = e_source_registry_set_default_memo_list;

    /// Sets `default_source` as the default task list.  If `default_source`
    /// is `NULL`, the default task list is reset to the built-in task list.
    /// This setting will persist across sessions until changed.
    extern fn e_source_registry_set_default_task_list(p_registry: *SourceRegistry, p_default_source: ?*edataserver.Source) void;
    pub const setDefaultTaskList = e_source_registry_set_default_task_list;

    extern fn e_source_registry_get_type() usize;
    pub const getGObjectType = e_source_registry_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceRegistry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceRegistry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceRegistry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceRegistryWatcher = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceRegistryWatcherClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.SourceRegistryWatcherPrivate,

    pub const virtual_methods = struct {
        pub const appeared = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistryWatcher.Class, p_class).f_appeared.?(gobject.ext.as(SourceRegistryWatcher, p_watcher), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistryWatcher.Class, p_class).f_appeared = @ptrCast(p_implementation);
            }
        };

        pub const disappeared = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistryWatcher.Class, p_class).f_disappeared.?(gobject.ext.as(SourceRegistryWatcher, p_watcher), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistryWatcher.Class, p_class).f_disappeared = @ptrCast(p_implementation);
            }
        };

        pub const filter = struct {
            pub fn call(p_class: anytype, p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) c_int {
                return gobject.ext.as(SourceRegistryWatcher.Class, p_class).f_filter.?(gobject.ext.as(SourceRegistryWatcher, p_watcher), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_watcher: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) c_int) void {
                gobject.ext.as(SourceRegistryWatcher.Class, p_class).f_filter = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Optional extension name, to consider sources with only.
        /// It can be `NULL`, to check for all sources. This is
        /// a complementary filter to `edataserver.SourceRegistryWatcher.signals.filter`
        /// signal.
        pub const extension_name = struct {
            pub const name = "extension-name";

            pub const Type = ?[*:0]u8;
        };

        /// The `edataserver.SourceRegistry` manages `edataserver.Source` instances.
        pub const registry = struct {
            pub const name = "registry";

            pub const Type = ?*edataserver.SourceRegistry;
        };
    };

    pub const signals = struct {
        /// A signal emitted when the `source` is enabled or added and it had been
        /// considered for inclusion with the `ESourceRegistryWatcher`::filter signal.
        pub const appeared = struct {
            pub const name = "appeared";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistryWatcher, p_instance))),
                    gobject.signalLookup("appeared", SourceRegistryWatcher.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// A signal emitted when the `source` is disabled or removed and it had been
        /// considered for inclusion with the `ESourceRegistryWatcher`::filter signal
        /// earlier.
        pub const disappeared = struct {
            pub const name = "disappeared";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistryWatcher, p_instance))),
                    gobject.signalLookup("disappeared", SourceRegistryWatcher.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// A filter signal which verifies whether the `source` can be considered
        /// for inclusion in the watcher or not. If none is set then all the sources
        /// are included.
        pub const filter = struct {
            pub const name = "filter";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *edataserver.Source, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistryWatcher, p_instance))),
                    gobject.signalLookup("filter", SourceRegistryWatcher.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `edataserver.SourceRegistryWatcher` instance.
    ///
    /// The `extension_name` can be used as a complementary filter
    /// to `edataserver.SourceRegistryWatcher.signals.filter` signal.
    extern fn e_source_registry_watcher_new(p_registry: *edataserver.SourceRegistry, p_extension_name: ?[*:0]const u8) *edataserver.SourceRegistryWatcher;
    pub const new = e_source_registry_watcher_new;

    extern fn e_source_registry_watcher_get_extension_name(p_watcher: *SourceRegistryWatcher) ?[*:0]const u8;
    pub const getExtensionName = e_source_registry_watcher_get_extension_name;

    /// Returns the `edataserver.SourceRegistry` passed to `edataserver.SourceRegistryWatcher.new`.
    extern fn e_source_registry_watcher_get_registry(p_watcher: *SourceRegistryWatcher) *edataserver.SourceRegistry;
    pub const getRegistry = e_source_registry_watcher_get_registry;

    /// Reclaims all available sources satisfying the `edataserver.SourceRegistryWatcher.signals.filter`
    /// signal. It doesn't notify about disappeared sources, it notifies only
    /// on those appeared.
    extern fn e_source_registry_watcher_reclaim(p_watcher: *SourceRegistryWatcher) void;
    pub const reclaim = e_source_registry_watcher_reclaim;

    extern fn e_source_registry_watcher_get_type() usize;
    pub const getGObjectType = e_source_registry_watcher_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceRegistryWatcher) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceRegistryWatcher) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceRegistryWatcher, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceResource = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceResourceClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceResourcePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const identity = struct {
            pub const name = "identity";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceResource.getIdentity`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_resource_dup_identity(p_extension: *SourceResource) ?[*:0]u8;
    pub const dupIdentity = e_source_resource_dup_identity;

    /// Returns the server-assigned identity of the remote resource associated
    /// with the `edataserver.Source` to which `extension` belongs.
    extern fn e_source_resource_get_identity(p_extension: *SourceResource) ?[*:0]const u8;
    pub const getIdentity = e_source_resource_get_identity;

    /// Sets the server-assigned identity of the remote resource associated with
    /// the `edataserver.Source` to which `extension` belongs.
    ///
    /// The internal copy of `identity` is automatically stripped of leading and
    /// trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_resource_set_identity(p_extension: *SourceResource, p_identity: ?[*:0]const u8) void;
    pub const setIdentity = e_source_resource_set_identity;

    extern fn e_source_resource_get_type() usize;
    pub const getGObjectType = e_source_resource_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceResource) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceResource) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceResource, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceRevisionGuards = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceRevisionGuardsClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceRevisionGuardsPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const enabled = struct {
            pub const name = "enabled";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Checks whether revision guards for the given `edataserver.Source` are enabled.
    extern fn e_source_revision_guards_get_enabled(p_extension: *SourceRevisionGuards) c_int;
    pub const getEnabled = e_source_revision_guards_get_enabled;

    /// Enables or disables the revision guards for a given `edataserver.Source`.
    ///
    /// Revision guards are disabled by default.
    extern fn e_source_revision_guards_set_enabled(p_extension: *SourceRevisionGuards, p_enabled: c_int) void;
    pub const setEnabled = e_source_revision_guards_set_enabled;

    extern fn e_source_revision_guards_get_type() usize;
    pub const getGObjectType = e_source_revision_guards_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceRevisionGuards) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceRevisionGuards) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceRevisionGuards, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceSMIME = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceSMIMEClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceSMIMEPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const encrypt_by_default = struct {
            pub const name = "encrypt-by-default";

            pub const Type = c_int;
        };

        pub const encrypt_to_self = struct {
            pub const name = "encrypt-to-self";

            pub const Type = c_int;
        };

        pub const encryption_certificate = struct {
            pub const name = "encryption-certificate";

            pub const Type = ?[*:0]u8;
        };

        pub const sign_by_default = struct {
            pub const name = "sign-by-default";

            pub const Type = c_int;
        };

        pub const signing_algorithm = struct {
            pub const name = "signing-algorithm";

            pub const Type = ?[*:0]u8;
        };

        pub const signing_certificate = struct {
            pub const name = "signing-certificate";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceSMIME.getEncryptionCertificate`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_smime_dup_encryption_certificate(p_extension: *SourceSMIME) ?[*:0]u8;
    pub const dupEncryptionCertificate = e_source_smime_dup_encryption_certificate;

    /// Thread-safe variation of `edataserver.SourceSMIME.getSigningAlgorithm`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_smime_dup_signing_algorithm(p_extension: *SourceSMIME) ?[*:0]u8;
    pub const dupSigningAlgorithm = e_source_smime_dup_signing_algorithm;

    /// Thread-safe variation of `edataserver.SourceSMIME.getSigningCertificate`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_smime_dup_signing_certificate(p_extension: *SourceSMIME) ?[*:0]u8;
    pub const dupSigningCertificate = e_source_smime_dup_signing_certificate;

    /// Returns whether to encrypt outgoing messages by default using S/MIME
    /// software such as Mozilla Network Security Services (NSS).
    extern fn e_source_smime_get_encrypt_by_default(p_extension: *SourceSMIME) c_int;
    pub const getEncryptByDefault = e_source_smime_get_encrypt_by_default;

    /// Returns whether to "encrypt-to-self" when sending encrypted messages.
    extern fn e_source_smime_get_encrypt_to_self(p_extension: *SourceSMIME) c_int;
    pub const getEncryptToSelf = e_source_smime_get_encrypt_to_self;

    /// Returns the S/MIME certificate name used to encrypt messages.
    extern fn e_source_smime_get_encryption_certificate(p_extension: *SourceSMIME) ?[*:0]const u8;
    pub const getEncryptionCertificate = e_source_smime_get_encryption_certificate;

    /// Returns whether to digitally sign outgoing messages by default using
    /// S/MIME software such as Mozilla Network Security Services (NSS).
    extern fn e_source_smime_get_sign_by_default(p_extension: *SourceSMIME) c_int;
    pub const getSignByDefault = e_source_smime_get_sign_by_default;

    /// Returns the name of the hash algorithm used to digitally sign outgoing
    /// messages.
    extern fn e_source_smime_get_signing_algorithm(p_extension: *SourceSMIME) ?[*:0]const u8;
    pub const getSigningAlgorithm = e_source_smime_get_signing_algorithm;

    /// Returns the S/MIME certificate name used to sign messages.
    extern fn e_source_smime_get_signing_certificate(p_extension: *SourceSMIME) ?[*:0]const u8;
    pub const getSigningCertificate = e_source_smime_get_signing_certificate;

    /// Sets whether to encrypt outgoing messages by default using S/MIME
    /// software such as Mozilla Network Security Services (NSS).
    extern fn e_source_smime_set_encrypt_by_default(p_extension: *SourceSMIME, p_encrypt_by_default: c_int) void;
    pub const setEncryptByDefault = e_source_smime_set_encrypt_by_default;

    /// Sets whether to "encrypt-to-self" when sending encrypted messages.
    extern fn e_source_smime_set_encrypt_to_self(p_extension: *SourceSMIME, p_encrypt_to_self: c_int) void;
    pub const setEncryptToSelf = e_source_smime_set_encrypt_to_self;

    /// Sets the certificate name used to encrypt messages.
    ///
    /// If the `encryption_certificate` string is empty, `NULL` is set instead.
    extern fn e_source_smime_set_encryption_certificate(p_extension: *SourceSMIME, p_encryption_certificate: ?[*:0]const u8) void;
    pub const setEncryptionCertificate = e_source_smime_set_encryption_certificate;

    /// Sets whether to digitally sign outgoing messages by default using
    /// S/MIME software such as Mozilla Network Security Services (NSS).
    extern fn e_source_smime_set_sign_by_default(p_extension: *SourceSMIME, p_sign_by_default: c_int) void;
    pub const setSignByDefault = e_source_smime_set_sign_by_default;

    /// Sets the name of the hash algorithm used to digitally sign outgoing
    /// messages.
    ///
    /// The internal copy of `signing_algorithm` is automatically stripped of
    /// leading and trailing whitespace.  If the resulting string is empty,
    /// `NULL` is set instead.
    extern fn e_source_smime_set_signing_algorithm(p_extension: *SourceSMIME, p_signing_algorithm: ?[*:0]const u8) void;
    pub const setSigningAlgorithm = e_source_smime_set_signing_algorithm;

    /// Sets the S/MIME certificate name used to sign messages.
    ///
    /// If the `signing_certificate` string is empty, `NULL` is set instead.
    extern fn e_source_smime_set_signing_certificate(p_extension: *SourceSMIME, p_signing_certificate: ?[*:0]const u8) void;
    pub const setSigningCertificate = e_source_smime_set_signing_certificate;

    extern fn e_source_smime_get_type() usize;
    pub const getGObjectType = e_source_smime_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceSMIME) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceSMIME) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceSMIME, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceSecurity = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceSecurityClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceSecurityPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const method = struct {
            pub const name = "method";

            pub const Type = ?[*:0]u8;
        };

        pub const secure = struct {
            pub const name = "secure";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceSecurity.getMethod`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_security_dup_method(p_extension: *SourceSecurity) [*:0]u8;
    pub const dupMethod = e_source_security_dup_method;

    /// Returns the method used to establish a secure network connection to a
    /// remote account.  There are no pre-defined method names; backends are
    /// free to set this however they wish.  If a secure connection is not
    /// desired, the convention is to set `edataserver.SourceSecurity.properties.method` to "none".
    extern fn e_source_security_get_method(p_extension: *SourceSecurity) [*:0]const u8;
    pub const getMethod = e_source_security_get_method;

    /// This is a convenience function which returns whether a secure network
    /// connection is desired, regardless of the method used.  This relies on
    /// the convention of setting `edataserver.SourceSecurity.properties.method` to "none" when a
    /// secure network connection is <emphasis>not</emphasis> desired.
    extern fn e_source_security_get_secure(p_extension: *SourceSecurity) c_int;
    pub const getSecure = e_source_security_get_secure;

    /// Sets the method used to establish a secure network connection to a
    /// remote account.  There are no pre-defined method names; backends are
    /// free to set this however they wish.  If a secure connection is not
    /// desired, the convention is to set `edataserver.SourceSecurity.properties.method` to "none".
    /// In keeping with that convention, `edataserver.SourceSecurity.properties.method` will be set
    /// to "none" if `method` is `NULL` or an empty string.
    extern fn e_source_security_set_method(p_extension: *SourceSecurity, p_method: ?[*:0]const u8) void;
    pub const setMethod = e_source_security_set_method;

    /// This function provides a simpler way to set `edataserver.SourceSecurity.properties.method`
    /// when using a secure network connection is a yes or no option and the
    /// exact method name is unimportant.  If `secure` is `FALSE`, the
    /// `edataserver.SourceSecurity.properties.method` property is set to "none".  If `secure` is
    /// `TRUE`, the function assumes the backend will use Transport Layer
    /// Security and sets the `edataserver.SourceSecurity.properties.method` property to "tls".
    extern fn e_source_security_set_secure(p_extension: *SourceSecurity, p_secure: c_int) void;
    pub const setSecure = e_source_security_set_secure;

    extern fn e_source_security_get_type() usize;
    pub const getGObjectType = e_source_security_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceSecurity) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceSecurity) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceSecurity, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceSelectable = extern struct {
    pub const Parent = edataserver.SourceBackend;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceSelectableClass;
    f_parent: edataserver.SourceBackend,
    f_priv: ?*edataserver.SourceSelectablePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const color = struct {
            pub const name = "color";

            pub const Type = ?[*:0]u8;
        };

        pub const order = struct {
            pub const name = "order";

            pub const Type = c_uint;
        };

        pub const selected = struct {
            pub const name = "selected";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceSelectable.getColor`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_selectable_dup_color(p_extension: *SourceSelectable) ?[*:0]u8;
    pub const dupColor = e_source_selectable_dup_color;

    /// Returns the color specification for the `edataserver.Source` to which `extension`
    /// belongs.  A colored block is often displayed next to the data source's
    /// display name in user interfaces.
    extern fn e_source_selectable_get_color(p_extension: *SourceSelectable) ?[*:0]const u8;
    pub const getColor = e_source_selectable_get_color;

    /// Returns the preferred sorting order for the `edataserver.Source`
    /// to which `extension` belongs. Default is 0.
    extern fn e_source_selectable_get_order(p_extension: *SourceSelectable) c_uint;
    pub const getOrder = e_source_selectable_get_order;

    /// Returns the selected state of the `edataserver.Source` to which `extension` belongs.
    /// The selected state is often represented as a checkbox next to the data
    /// source's display name in user interfaces.
    extern fn e_source_selectable_get_selected(p_extension: *SourceSelectable) c_int;
    pub const getSelected = e_source_selectable_get_selected;

    /// Sets the color specification for the `edataserver.Source` to which `extension`
    /// belongs.  A colored block is often displayed next to the data source's
    /// display name in user interfaces.
    ///
    /// The internal copy of `color` is automatically stripped of leading and
    /// trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_selectable_set_color(p_extension: *SourceSelectable, p_color: ?[*:0]const u8) void;
    pub const setColor = e_source_selectable_set_color;

    /// Sets the sorting order for the `edataserver.Source` to which `extension` belongs.
    extern fn e_source_selectable_set_order(p_extension: *SourceSelectable, p_order: c_uint) void;
    pub const setOrder = e_source_selectable_set_order;

    /// Sets the selected state for the `edataserver.Source` to which `extension` belongs.
    /// The selected state is often represented as a checkbox next to the data
    /// source's display name in user interfaces.
    extern fn e_source_selectable_set_selected(p_extension: *SourceSelectable, p_selected: c_int) void;
    pub const setSelected = e_source_selectable_set_selected;

    extern fn e_source_selectable_get_type() usize;
    pub const getGObjectType = e_source_selectable_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceSelectable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceSelectable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceSelectable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceTaskList = extern struct {
    pub const Parent = edataserver.SourceSelectable;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceTaskListClass;
    f_parent: edataserver.SourceSelectable,
    f_priv: ?*edataserver.SourceTaskListPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_source_task_list_get_type() usize;
    pub const getGObjectType = e_source_task_list_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceTaskList) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceTaskList) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceTaskList, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceUoa = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceUoaClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceUoaPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const account_id = struct {
            pub const name = "account-id";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    /// Returns the numeric identifier of the Ubuntu Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs.
    extern fn e_source_uoa_get_account_id(p_extension: *SourceUoa) c_uint;
    pub const getAccountId = e_source_uoa_get_account_id;

    /// Sets the numeric identifier of the Ubuntu Online Account associated
    /// with the `edataserver.Source` to which `extension` belongs.
    extern fn e_source_uoa_set_account_id(p_extension: *SourceUoa, p_account_id: c_uint) void;
    pub const setAccountId = e_source_uoa_set_account_id;

    extern fn e_source_uoa_get_type() usize;
    pub const getGObjectType = e_source_uoa_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceUoa) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceUoa) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceUoa, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceWeather = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceWeatherClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceWeatherPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const location = struct {
            pub const name = "location";

            pub const Type = ?[*:0]u8;
        };

        pub const units = struct {
            pub const name = "units";

            pub const Type = edataserver.SourceWeatherUnits;
        };
    };

    pub const signals = struct {};

    extern fn e_source_weather_dup_location(p_extension: *SourceWeather) [*:0]u8;
    pub const dupLocation = e_source_weather_dup_location;

    extern fn e_source_weather_get_location(p_extension: *SourceWeather) [*:0]const u8;
    pub const getLocation = e_source_weather_get_location;

    extern fn e_source_weather_get_units(p_extension: *SourceWeather) edataserver.SourceWeatherUnits;
    pub const getUnits = e_source_weather_get_units;

    extern fn e_source_weather_set_location(p_extension: *SourceWeather, p_location: [*:0]const u8) void;
    pub const setLocation = e_source_weather_set_location;

    extern fn e_source_weather_set_units(p_extension: *SourceWeather, p_units: edataserver.SourceWeatherUnits) void;
    pub const setUnits = e_source_weather_set_units;

    extern fn e_source_weather_get_type() usize;
    pub const getGObjectType = e_source_weather_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceWeather) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceWeather) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceWeather, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceWebDAVNotes = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceWebDAVNotesClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceWebDAVNotesPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const default_ext = struct {
            pub const name = "default-ext";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceWebDAVNotes.getDefaultExt`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_webdav_notes_dup_default_ext(p_extension: *SourceWebDAVNotes) ?[*:0]u8;
    pub const dupDefaultExt = e_source_webdav_notes_dup_default_ext;

    /// Returns the default file extension for new notes.
    extern fn e_source_webdav_notes_get_default_ext(p_extension: *SourceWebDAVNotes) ?[*:0]const u8;
    pub const getDefaultExt = e_source_webdav_notes_get_default_ext;

    /// Sets the default file extension for new notes.
    ///
    /// The internal copy of `default_ext` is automatically stripped of leading and
    /// trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_webdav_notes_set_default_ext(p_extension: *SourceWebDAVNotes, p_default_ext: ?[*:0]const u8) void;
    pub const setDefaultExt = e_source_webdav_notes_set_default_ext;

    extern fn e_source_webdav_notes_get_type() usize;
    pub const getGObjectType = e_source_webdav_notes_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceWebDAVNotes) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceWebDAVNotes) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceWebDAVNotes, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceWebdav = extern struct {
    pub const Parent = edataserver.SourceExtension;
    pub const Implements = [_]type{};
    pub const Class = edataserver.SourceWebdavClass;
    f_parent: edataserver.SourceExtension,
    f_priv: ?*edataserver.SourceWebdavPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const avoid_ifmatch = struct {
            pub const name = "avoid-ifmatch";

            pub const Type = c_int;
        };

        pub const calendar_auto_schedule = struct {
            pub const name = "calendar-auto-schedule";

            pub const Type = c_int;
        };

        pub const color = struct {
            pub const name = "color";

            pub const Type = ?[*:0]u8;
        };

        pub const display_name = struct {
            pub const name = "display-name";

            pub const Type = ?[*:0]u8;
        };

        pub const email_address = struct {
            pub const name = "email-address";

            pub const Type = ?[*:0]u8;
        };

        pub const order = struct {
            pub const name = "order";

            pub const Type = c_uint;
        };

        pub const resource_path = struct {
            pub const name = "resource-path";

            pub const Type = ?[*:0]u8;
        };

        pub const resource_query = struct {
            pub const name = "resource-query";

            pub const Type = ?[*:0]u8;
        };

        pub const ssl_trust = struct {
            pub const name = "ssl-trust";

            pub const Type = ?[*:0]u8;
        };

        pub const timeout = struct {
            pub const name = "timeout";

            pub const Type = c_uint;
        };

        pub const uri = struct {
            pub const name = "uri";

            pub const Type = ?*glib.Uri;
        };
    };

    pub const signals = struct {};

    /// Thread-safe variation of `edataserver.SourceWebdav.getColor`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_webdav_dup_color(p_extension: *SourceWebdav) ?[*:0]u8;
    pub const dupColor = e_source_webdav_dup_color;

    /// Thread-safe variation of `edataserver.SourceWebdav.getDisplayName`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_webdav_dup_display_name(p_extension: *SourceWebdav) ?[*:0]u8;
    pub const dupDisplayName = e_source_webdav_dup_display_name;

    /// Thread-safe variation of `edataserver.SourceWebdav.getEmailAddress`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_webdav_dup_email_address(p_extension: *SourceWebdav) ?[*:0]u8;
    pub const dupEmailAddress = e_source_webdav_dup_email_address;

    /// Thread-safe variation of `edataserver.SourceWebdav.getResourcePath`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_webdav_dup_resource_path(p_extension: *SourceWebdav) ?[*:0]u8;
    pub const dupResourcePath = e_source_webdav_dup_resource_path;

    /// Thread-safe variation of `edataserver.SourceWebdav.getResourceQuery`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_webdav_dup_resource_query(p_extension: *SourceWebdav) ?[*:0]u8;
    pub const dupResourceQuery = e_source_webdav_dup_resource_query;

    /// Thread-safe variation of `edataserver.SourceWebdav.getSslTrust`.
    /// Use this function when accessing `extension` from multiple threads.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_source_webdav_dup_ssl_trust(p_extension: *SourceWebdav) ?[*:0]u8;
    pub const dupSslTrust = e_source_webdav_dup_ssl_trust;

    /// This is a convenience function which returns a newly-allocated
    /// `glib.Uri`, its contents assembled from the `edataserver.SourceAuthentication`
    /// extension, the `edataserver.SourceSecurity` extension, and `extension` itself.
    /// Free the returned `glib.Uri` with `glib.Uri.unref`.
    extern fn e_source_webdav_dup_uri(p_extension: *SourceWebdav) *glib.Uri;
    pub const dupUri = e_source_webdav_dup_uri;

    /// This setting works around a
    /// <ulink url="https://issues.apache.org/bugzilla/show_bug.cgi?id=38034">
    /// bug</ulink> in older Apache mod_dav versions.
    ///
    /// <note>
    ///   <para>
    ///     We may deprecate this once Apache 2.2.8 or newer becomes
    ///     sufficiently ubiquitous, or we figure out a way to detect
    ///     and work around the bug automatically.
    ///   </para>
    /// </note>
    extern fn e_source_webdav_get_avoid_ifmatch(p_extension: *SourceWebdav) c_int;
    pub const getAvoidIfmatch = e_source_webdav_get_avoid_ifmatch;

    /// FIXME Document me!
    extern fn e_source_webdav_get_calendar_auto_schedule(p_extension: *SourceWebdav) c_int;
    pub const getCalendarAutoSchedule = e_source_webdav_get_calendar_auto_schedule;

    /// Returns the last known color of a WebDAV resource as provided by the server.
    extern fn e_source_webdav_get_color(p_extension: *SourceWebdav) ?[*:0]const u8;
    pub const getColor = e_source_webdav_get_color;

    /// Returns the last known display name of a WebDAV resource, which may
    /// differ from the `edataserver.Source.properties.display`-name property of the `edataserver.Source` to which
    /// `extension` belongs.
    extern fn e_source_webdav_get_display_name(p_extension: *SourceWebdav) ?[*:0]const u8;
    pub const getDisplayName = e_source_webdav_get_display_name;

    /// Returns the user's email address which can be passed to a CalDAV server
    /// if the user wishes to receive scheduling messages.
    extern fn e_source_webdav_get_email_address(p_extension: *SourceWebdav) ?[*:0]const u8;
    pub const getEmailAddress = e_source_webdav_get_email_address;

    extern fn e_source_webdav_get_order(p_extension: *SourceWebdav) c_uint;
    pub const getOrder = e_source_webdav_get_order;

    /// Returns the absolute path to a resource on a WebDAV server.
    extern fn e_source_webdav_get_resource_path(p_extension: *SourceWebdav) ?[*:0]const u8;
    pub const getResourcePath = e_source_webdav_get_resource_path;

    /// Returns the URI query required to access a resource on a WebDAV server.
    ///
    /// This is typically used when the `edataserver.SourceWebdav.properties.resource`-path points not
    /// to the resource itself but to a web program that generates the resource
    /// content on-the-fly.  The `edataserver.SourceWebdav.properties.resource`-query holds the input
    /// values for the program.
    extern fn e_source_webdav_get_resource_query(p_extension: *SourceWebdav) ?[*:0]const u8;
    pub const getResourceQuery = e_source_webdav_get_resource_query;

    /// Returns an SSL/TLS certificate trust for the `extension`.
    /// The value encodes three parameters, divided by a pipe '|',
    /// the first is users preference, can be one of "reject", "accept",
    /// "temporary-reject" and "temporary-accept". The second is a host
    /// name for which the trust was set. Finally the last is a SHA256
    /// hash of the certificate. This is not meant to be changed by a caller,
    /// it is supposed to be manipulated with `edataserver.SourceWebdav.updateSslTrust`
    /// and `edataserver.SourceWebdav.verifySslTrust`.
    extern fn e_source_webdav_get_ssl_trust(p_extension: *SourceWebdav) ?[*:0]const u8;
    pub const getSslTrust = e_source_webdav_get_ssl_trust;

    extern fn e_source_webdav_get_ssl_trust_response(p_extension: *SourceWebdav) edataserver.TrustPromptResponse;
    pub const getSslTrustResponse = e_source_webdav_get_ssl_trust_response;

    extern fn e_source_webdav_get_timeout(p_extension: *SourceWebdav) c_uint;
    pub const getTimeout = e_source_webdav_get_timeout;

    /// This setting works around a
    /// <ulink url="https://issues.apache.org/bugzilla/show_bug.cgi?id=38034">
    /// bug</ulink> in older Apache mod_dav versions.
    ///
    /// <note>
    ///   <para>
    ///     We may deprecate this once Apache 2.2.8 or newer becomes
    ///     sufficiently ubiquitous, or we figure out a way to detect
    ///     and work around the bug automatically.
    ///   </para>
    /// </note>
    extern fn e_source_webdav_set_avoid_ifmatch(p_extension: *SourceWebdav, p_avoid_ifmatch: c_int) void;
    pub const setAvoidIfmatch = e_source_webdav_set_avoid_ifmatch;

    /// FIXME Document me!
    extern fn e_source_webdav_set_calendar_auto_schedule(p_extension: *SourceWebdav, p_calendar_auto_schedule: c_int) void;
    pub const setCalendarAutoSchedule = e_source_webdav_set_calendar_auto_schedule;

    /// Updates the last known color of a WebDAV resource, as provided by the server.
    ///
    /// The internal copy of `color` is automatically stripped of leading
    /// and trailing whitespace. If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_webdav_set_color(p_extension: *SourceWebdav, p_color: ?[*:0]const u8) void;
    pub const setColor = e_source_webdav_set_color;

    /// Updates the last known display name of a WebDAV resource, which may
    /// differ from the `edataserver.Source.properties.display`-name property of the `edataserver.Source` to which
    /// `extension` belongs.
    ///
    /// The internal copy of `display_name` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_webdav_set_display_name(p_extension: *SourceWebdav, p_display_name: ?[*:0]const u8) void;
    pub const setDisplayName = e_source_webdav_set_display_name;

    /// Sets the user's email address which can be passed to a CalDAV server if
    /// the user wishes to receive scheduling messages.
    ///
    /// The internal copy of `email_address` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_webdav_set_email_address(p_extension: *SourceWebdav, p_email_address: ?[*:0]const u8) void;
    pub const setEmailAddress = e_source_webdav_set_email_address;

    /// Set the sorting order of the resource.
    extern fn e_source_webdav_set_order(p_extension: *SourceWebdav, p_order: c_uint) void;
    pub const setOrder = e_source_webdav_set_order;

    /// Sets the absolute path to a resource on a WebDAV server.
    ///
    /// The internal copy of `resource_path` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_webdav_set_resource_path(p_extension: *SourceWebdav, p_resource_path: ?[*:0]const u8) void;
    pub const setResourcePath = e_source_webdav_set_resource_path;

    /// Sets the URI query required to access a resource on a WebDAV server.
    ///
    /// This is typically used when the `edataserver.SourceWebdav.properties.resource`-path points not
    /// to the resource itself but to a web program that generates the resource
    /// content on-the-fly.  The `edataserver.SourceWebdav.properties.resource`-query holds the input
    /// values for the program.
    ///
    /// The internal copy of `resource_query` is automatically stripped of leading
    /// and trailing whitespace.  If the resulting string is empty, `NULL` is set
    /// instead.
    extern fn e_source_webdav_set_resource_query(p_extension: *SourceWebdav, p_resource_query: ?[*:0]const u8) void;
    pub const setResourceQuery = e_source_webdav_set_resource_query;

    /// Sets the SSL/TLS certificate trust. See `edataserver.SourceWebdav.getSslTrust`
    /// for more infomation about its content and how to use it.
    extern fn e_source_webdav_set_ssl_trust(p_extension: *SourceWebdav, p_ssl_trust: ?[*:0]const u8) void;
    pub const setSslTrust = e_source_webdav_set_ssl_trust;

    /// Set the SSL trust response, as `edataserver.TrustPromptResponse`, while keeping
    /// the certificate and host information as before. The function does
    /// nothing, when none SSL trust is set or when `E_TRUST_PROMPT_RESPONSE_UNKNOWN`
    /// is used as the `response`.
    extern fn e_source_webdav_set_ssl_trust_response(p_extension: *SourceWebdav, p_response: edataserver.TrustPromptResponse) void;
    pub const setSslTrustResponse = e_source_webdav_set_ssl_trust_response;

    /// Set the connection timeout, in seconds.
    extern fn e_source_webdav_set_timeout(p_extension: *SourceWebdav, p_timeout: c_uint) void;
    pub const setTimeout = e_source_webdav_set_timeout;

    /// This is a convenience function which propagates the components of
    /// `uri` to the `edataserver.SourceAuthentication` extension, the `edataserver.SourceSecurity`
    /// extension, and `extension` itself.  (The "fragment" component of
    /// `uri` is ignored.)
    extern fn e_source_webdav_set_uri(p_extension: *SourceWebdav, p_uri: *glib.Uri) void;
    pub const setUri = e_source_webdav_set_uri;

    /// Unsets temporary trust set on this `extension`, but keeps
    /// it as is for other values.
    extern fn e_source_webdav_unset_temporary_ssl_trust(p_extension: *SourceWebdav) void;
    pub const unsetTemporarySslTrust = e_source_webdav_unset_temporary_ssl_trust;

    /// Updates user's response from a trust prompt, thus it is re-used the next
    /// time it'll be needed. An `E_TRUST_PROMPT_RESPONSE_UNKNOWN` is treated as
    /// a temporary reject, which means the user will be asked again.
    extern fn e_source_webdav_update_ssl_trust(p_extension: *SourceWebdav, p_host: [*:0]const u8, p_cert: *gio.TlsCertificate, p_response: edataserver.TrustPromptResponse) void;
    pub const updateSslTrust = e_source_webdav_update_ssl_trust;

    /// Verifies SSL/TLS trust for the given `host` and `cert`, as previously stored in the `extension`
    /// with `edataserver.SourceWebdav.updateSslTrust`.
    extern fn e_source_webdav_verify_ssl_trust(p_extension: *SourceWebdav, p_host: [*:0]const u8, p_cert: *gio.TlsCertificate, p_cert_errors: gio.TlsCertificateFlags) edataserver.TrustPromptResponse;
    pub const verifySslTrust = e_source_webdav_verify_ssl_trust;

    extern fn e_source_webdav_get_type() usize;
    pub const getGObjectType = e_source_webdav_get_type;

    extern fn g_object_ref(p_self: *edataserver.SourceWebdav) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.SourceWebdav) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceWebdav, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const WebDAVSession = extern struct {
    pub const Parent = edataserver.SoupSession;
    pub const Implements = [_]type{};
    pub const Class = edataserver.WebDAVSessionClass;
    f_parent: edataserver.SoupSession,
    f_priv: ?*edataserver.WebDAVSessionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Frees `privileges` returned by `edataserver.WebDAVSession.getSupportedPrivilegeSetSync`.
    /// The function does nothing, if `privileges` is `NULL`.
    extern fn e_webdav_session_util_free_privileges(p_privileges: ?*glib.Node) void;
    pub const utilFreePrivileges = e_webdav_session_util_free_privileges;

    /// Compares two hrefs and return whether they reference
    /// the same item on the server. The comparison is done in
    /// a relaxed way, not considering scheme part and comparing
    /// the host name case insensitively, while the path
    /// case sensitively. It also ignores the username/password
    /// information in the hostname part, if it's included.
    /// The function doesn't decode any URI-encoded characters.
    extern fn e_webdav_session_util_item_href_equal(p_href1: [*:0]const u8, p_href2: [*:0]const u8) c_int;
    pub const utilItemHrefEqual = e_webdav_session_util_item_href_equal;

    /// Dequotes `text`, if it's enclosed in double-quotes. The function
    /// changes `text`, it doesn't allocate new string. The function does
    /// nothing when the `text` is not enclosed in double-quotes.
    extern fn e_webdav_session_util_maybe_dequote(p_text: ?[*:0]u8) [*:0]u8;
    pub const utilMaybeDequote = e_webdav_session_util_maybe_dequote;

    /// Creates a new `edataserver.WebDAVSession` associated with given `source`.
    /// The `edataserver.WebDAVSession` uses an `edataserver.SourceWebdav` extension on certain
    /// places when it's defined for the `source`.
    extern fn e_webdav_session_new(p_source: *edataserver.Source) *edataserver.WebDAVSession;
    pub const new = e_webdav_session_new;

    /// Issues ACL request on the provided `uri`, or, in case it's `NULL`, on the URI
    /// defined in associated `edataserver.Source`.
    extern fn e_webdav_session_acl_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_xml: *const edataserver.XmlDocument, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const aclSync = e_webdav_session_acl_sync;

    /// Copies a resource identified by `source_uri` to `destination_uri` on the server.
    /// The `source_uri` can reference also collections, in which case the `depth` influences
    /// whether only the collection itself is copied (`E_WEBDAV_DEPTH_THIS`) or whether
    /// the collection with all its children is copied (`E_WEBDAV_DEPTH_INFINITY`).
    extern fn e_webdav_session_copy_sync(p_webdav: *WebDAVSession, p_source_uri: [*:0]const u8, p_destination_uri: [*:0]const u8, p_depth: [*:0]const u8, p_can_overwrite: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const copySync = e_webdav_session_copy_sync;

    /// Deletes a resource identified by `uri` on the server. The URI can
    /// reference a collection, in which case `depth` should be `E_WEBDAV_DEPTH_INFINITY`.
    /// Use `depth` `E_WEBDAV_DEPTH_THIS` when deleting a regular resource, or `NULL`,
    /// to let the server use default Depth.
    ///
    /// The `etag` argument is used to avoid clashes when overwriting existing resources.
    /// Use `NULL` `etag` when deleting collection resources or to force the deletion,
    /// otherwise provide a valid ETag of a non-collection resource to verify that
    /// the version requested to delete is the same as on the server.
    ///
    /// Note that the actual usage of `etag` is also influenced by `edataserver.SourceWebdav.properties.avoid`-ifmatch
    /// property of the associated `edataserver.Source`.
    extern fn e_webdav_session_delete_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_depth: ?[*:0]const u8, p_etag: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deleteSync = e_webdav_session_delete_sync;

    /// Deletes a resource identified by `uri` on the server. The URI can
    /// reference a collection, in which case `depth` should be `E_WEBDAV_DEPTH_INFINITY`.
    /// Use `depth` `E_WEBDAV_DEPTH_THIS` when deleting a regular resource, or `NULL`,
    /// to let the server use default Depth.
    ///
    /// The `etag` argument is used to avoid clashes when overwriting existing resources.
    /// Use `NULL` `etag` when deleting collection resources or to force the deletion,
    /// otherwise provide a valid ETag of a non-collection resource to verify that
    /// the version requested to delete is the same as on the server.
    ///
    /// The optional `in_headers` can contain additional headers to be added to the request.
    /// These headers replace any existing in the request headers, without support for the list-values headers.
    ///
    /// Note that the actual usage of `etag` is also influenced by `edataserver.SourceWebdav.properties.avoid`-ifmatch
    /// property of the associated `edataserver.Source`.
    extern fn e_webdav_session_delete_with_headers_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_depth: ?[*:0]const u8, p_etag: ?[*:0]const u8, p_in_headers: ?*soup.MessageHeaders, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deleteWithHeadersSync = e_webdav_session_delete_with_headers_sync;

    /// Converts possibly path-only `href` into a full URI under the `request_uri`.
    /// When the `request_uri` is `NULL`, the URI defined in associated `edataserver.Source` is
    /// used instead, taken from the `edataserver.SourceWebdav` extension, if defined.
    ///
    /// Free the returned pointer with `glib.free`, when no longer needed.
    extern fn e_webdav_session_ensure_full_uri(p_webdav: *WebDAVSession, p_request_uri: ?*const glib.Uri, p_href: [*:0]const u8) [*:0]u8;
    pub const ensureFullUri = e_webdav_session_ensure_full_uri;

    /// Gets Access Control List (ACL) restrictions for the `uri`, or, in case it's `NULL`,
    /// for the URI defined in associated `edataserver.Source`. The `out_principal_kind` is valid only
    /// if the `out_restrictions` contains `E_WEBDAV_ACL_RESTRICTION_REQUIRED_PRINCIPAL`.
    /// The `out_principal_hrefs` is valid only if the `out_principal_kind` is valid and when
    /// it is `E_WEBDAV_ACE_PRINCIPAL_HREF`.
    ///
    /// Free the returned `out_principal_hrefs` with
    /// g_slist_free_full (entries, g_free);
    /// when no longer needed.
    extern fn e_webdav_session_get_acl_restrictions_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_out_restrictions: *u32, p_out_principal_kind: *edataserver.WebDAVACEPrincipalKind, p_out_principal_hrefs: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getAclRestrictionsSync = e_webdav_session_get_acl_restrictions_sync;

    /// Gets Access Control List (ACL) for the `uri`, or, in case it's `NULL`, for the URI
    /// defined in associated `edataserver.Source`.
    ///
    /// This function doesn't read general `E_WEBDAV_ACE_PRINCIPAL_PROPERTY`.
    ///
    /// Free the returned `out_entries` with
    /// g_slist_free_full (entries, e_webdav_access_control_entry_free);
    /// when no longer needed.
    extern fn e_webdav_session_get_acl_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_out_entries: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getAclSync = e_webdav_session_get_acl_sync;

    /// Gets current user privileges for the `uri`, or, in case it's `NULL`, for the URI
    /// defined in associated `edataserver.Source`, with optional read of the capabilities
    /// and what the user is allowed. See `edataserver.WebDAVSession.optionsSync` for
    /// more information about the `out_capabilities` and `out_allows` values.
    ///
    /// Free the returned `out_privileges` with
    /// g_slist_free_full (privileges, e_webdav_privilege_free);
    /// when no longer needed.
    extern fn e_webdav_session_get_current_user_privilege_set_full_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_out_privileges: **glib.SList, p_out_capabilities: ?**glib.HashTable, p_out_allows: ?**glib.HashTable, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getCurrentUserPrivilegeSetFullSync = e_webdav_session_get_current_user_privilege_set_full_sync;

    /// Gets current user privileges for the `uri`, or, in case it's `NULL`, for the URI
    /// defined in associated `edataserver.Source`.
    ///
    /// Free the returned `out_privileges` with
    /// g_slist_free_full (privileges, e_webdav_privilege_free);
    /// when no longer needed.
    extern fn e_webdav_session_get_current_user_privilege_set_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_out_privileges: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getCurrentUserPrivilegeSetSync = e_webdav_session_get_current_user_privilege_set_sync;

    /// Reads a resource identified by `uri` from the server. The URI cannot
    /// reference a collection.
    ///
    /// The `out_bytes` is filled by actual data being read. If not `NULL`, `out_length`
    /// is populated with how many bytes had been read. The `out_bytes` is always
    /// NUL-terminated, while this termination byte is not part of `out_length`.
    /// Free the `out_bytes` with `glib.free`, when no longer needed.
    ///
    /// Free returned pointer of `out_href` and `out_etag`, if not `NULL`, with `glib.free`,
    /// when no longer needed.
    ///
    /// The optional `out_headers` contains response headers. Free it with `soup_message_headers_free`,
    /// when no longer needed.
    ///
    /// To read large data use `edataserver.WebDAVSession.getSync` instead.
    extern fn e_webdav_session_get_data_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_out_href: ?*[*:0]u8, p_out_etag: ?*[*:0]u8, p_out_headers: ?**soup.MessageHeaders, p_out_bytes: *[*:0]u8, p_out_length: ?*usize, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getDataSync = e_webdav_session_get_data_sync;

    /// Returns last DAV error code as returned by the server. Each recognized code
    /// is enclosed in "[]" in the returned string, to be able to distinguish between
    /// them, in case the server returned multiple codes.
    ///
    /// The string is valid until the next request is executed.
    extern fn e_webdav_session_get_last_dav_error_code(p_webdav: *WebDAVSession) ?[*:0]const u8;
    pub const getLastDavErrorCode = e_webdav_session_get_last_dav_error_code;

    extern fn e_webdav_session_get_last_dav_error_is_permission(p_webdav: *WebDAVSession) c_int;
    pub const getLastDavErrorIsPermission = e_webdav_session_get_last_dav_error_is_permission;

    /// Gets list of principal collection href for the `uri`, or, in case it's `NULL`,
    /// for the URI defined in associated `edataserver.Source`. The `out_principal_hrefs` are root
    /// collections that contain the principals that are available on the server that
    /// implements this resource.
    ///
    /// Free the returned `out_principal_hrefs` with
    /// g_slist_free_full (entries, g_free);
    /// when no longer needed.
    extern fn e_webdav_session_get_principal_collection_set_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_out_principal_hrefs: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getPrincipalCollectionSetSync = e_webdav_session_get_principal_collection_set_sync;

    /// Gets supported privileges for the `uri`, or, in case it's `NULL`, for the URI
    /// defined in associated `edataserver.Source`.
    ///
    /// The root node of `out_privileges` has always `NULL` data.
    ///
    /// Free the returned `out_privileges` with `edataserver.WebDAVSession.utilFreePrivileges`
    /// when no longer needed.
    extern fn e_webdav_session_get_supported_privilege_set_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_out_privileges: **glib.Node, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getSupportedPrivilegeSetSync = e_webdav_session_get_supported_privilege_set_sync;

    /// Reads a resource identified by `uri` from the server and writes it
    /// to the `stream`. The URI cannot reference a collection.
    ///
    /// Free returned pointer of `out_href` and `out_etag`, if not `NULL`, with `glib.free`,
    /// when no longer needed.
    ///
    /// The optional `out_headers` contains response headers. Free it with `soup_message_headers_free`,
    /// when no longer needed.
    ///
    /// The `edataserver.WebDAVSession.getDataSync` can be used to read the resource data
    /// directly to memory.
    extern fn e_webdav_session_get_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_out_href: ?*[*:0]u8, p_out_etag: ?*[*:0]u8, p_out_headers: ?**soup.MessageHeaders, p_out_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getSync = e_webdav_session_get_sync;

    /// Issues a getctag property request for a collection identified by `uri`, or,
    /// in case it's `NULL`, on the URI defined in associated `edataserver.Source`. The ctag is
    /// a collection tag, which changes whenever the collection changes (similar
    /// to etag). The getctag is an extension, thus the function can fail when
    /// the server doesn't support it.
    ///
    /// Free the returned `out_ctag` with `glib.free`, when no longer needed.
    extern fn e_webdav_session_getctag_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_out_ctag: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getctagSync = e_webdav_session_getctag_sync;

    /// Lists content of the `uri`, or, in case it's `NULL`, of the URI defined
    /// in associated `edataserver.Source`, which should point to a collection. The `flags`
    /// influences which properties are read for the resources.
    ///
    /// The `out_resources` is in no particular order.
    ///
    /// Free the returned `out_resources` with
    /// g_slist_free_full (resources, e_webdav_resource_free);
    /// when no longer needed.
    extern fn e_webdav_session_list_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_depth: [*:0]const u8, p_flags: u32, p_out_resources: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const listSync = e_webdav_session_list_sync;

    /// Locks a resource identified by `uri`, or, in case it's `NULL`, by the URI defined
    /// in associated `edataserver.Source`. It obtains a write lock with the given `lock_scope`.
    ///
    /// The `owner` is used to identify the lock owner. When it's an http:// or https://,
    /// then it's referenced as DAV:href, otherwise the value is treated as plain text.
    /// If it's `NULL`, then the user name from the associated `edataserver.Source` is used.
    ///
    /// The `out_lock_token` can be refreshed with `edataserver.WebDAVSession.refreshLockSync`.
    /// Release the lock with `edataserver.WebDAVSession.unlockSync`.
    /// Free the returned `out_lock_token` with `glib.free`, when no longer needed.
    extern fn e_webdav_session_lock_resource_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_lock_scope: edataserver.WebDAVLockScope, p_lock_timeout: i32, p_owner: ?[*:0]const u8, p_out_lock_token: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const lockResourceSync = e_webdav_session_lock_resource_sync;

    /// Locks a resource identified by `uri`, or, in case it's `NULL`, on the URI
    /// defined in associated `edataserver.Source`.
    ///
    /// The `out_lock_token` can be refreshed with `edataserver.WebDAVSession.refreshLockSync`.
    /// Release the lock with `edataserver.WebDAVSession.unlockSync`.
    /// Free the returned `out_lock_token` with `glib.free`, when no longer needed.
    ///
    /// If provided, free the returned `out_xml_response` with `xmlFreeDoc`,
    /// when no longer needed.
    extern fn e_webdav_session_lock_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_depth: [*:0]const u8, p_lock_timeout: i32, p_xml: *const edataserver.XmlDocument, p_out_lock_token: *[*:0]u8, p_out_xml_response: ?**libxml2.Doc, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const lockSync = e_webdav_session_lock_sync;

    /// Creates a new calendar collection identified by `uri` on the server.
    /// The `supports` defines what component types can be stored into
    /// the created calendar collection. Only `E_WEBDAV_RESOURCE_SUPPORTS_NONE`
    /// and values related to iCalendar content can be used here.
    /// Using `E_WEBDAV_RESOURCE_SUPPORTS_NONE` means that everything is supported.
    ///
    /// Note that CalDAV RFC 4791 Section 4.2 forbids to create calendar
    /// resources under other calendar resources (no nested calendars
    /// are allowed).
    extern fn e_webdav_session_mkcalendar_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_display_name: ?[*:0]const u8, p_description: ?[*:0]const u8, p_color: ?[*:0]const u8, p_supports: u32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const mkcalendarSync = e_webdav_session_mkcalendar_sync;

    /// Creates a new address book collection identified by `uri` on the server.
    ///
    /// Note that CardDAV RFC 6352 Section 5.2 forbids to create address book
    /// resources under other address book resources (no nested address books
    /// are allowed).
    extern fn e_webdav_session_mkcol_addressbook_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_display_name: ?[*:0]const u8, p_description: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const mkcolAddressbookSync = e_webdav_session_mkcol_addressbook_sync;

    /// Creates a new generic collection identified by `uri` on the server.
    /// To create specific collections use `edataserver.WebDAVSession.mkcalendarSync`
    /// or `edataserver.WebDAVSession.mkcolAddressbookSync`.
    extern fn e_webdav_session_mkcol_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const mkcolSync = e_webdav_session_mkcol_sync;

    /// Moves a resource identified by `source_uri` to `destination_uri` on the server.
    /// The `source_uri` can reference also collections.
    extern fn e_webdav_session_move_sync(p_webdav: *WebDAVSession, p_source_uri: [*:0]const u8, p_destination_uri: [*:0]const u8, p_can_overwrite: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const moveSync = e_webdav_session_move_sync;

    extern fn e_webdav_session_new_message(p_webdav: *WebDAVSession, p_method: [*:0]const u8, p_uri: ?[*:0]const u8, p_error: ?*?*glib.Error) ?*soup.Message;
    pub const newMessage = e_webdav_session_new_message;

    /// Issues OPTIONS request on the provided `uri`, or, in case it's `NULL`, on the URI
    /// defined in associated `edataserver.Source`.
    ///
    /// The `out_capabilities` contains a set of returned capabilities. Some known are
    /// defined as E_WEBDAV_CAPABILITY_CLASS_1, and so on. The 'value' of the `glib.HashTable`
    /// doesn't have any particular meaning and the strings are compared case insensitively.
    /// Free the hash table with `glib.hashTableDestroy`, when no longer needed. The returned
    /// value can be `NULL` on success, it's when the server doesn't provide the information.
    ///
    /// The `out_allows` contains a set of allowed methods returned by the server. Some known
    /// are defined as `SOUP_METHOD_OPTIONS`, and so on. The 'value' of the `glib.HashTable`
    /// doesn't have any particular meaning and the strings are compared case insensitively.
    /// Free the hash table with `glib.hashTableDestroy`, when no longer needed. The returned
    /// value can be `NULL` on success, it's when the server doesn't provide the information.
    extern fn e_webdav_session_options_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_out_capabilities: **glib.HashTable, p_out_allows: **glib.HashTable, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const optionsSync = e_webdav_session_options_sync;

    /// Issues POST request on the provided `uri`, or, in case it's `NULL`, on the URI
    /// defined in associated `edataserver.Source`.
    ///
    /// The optional `in_headers` can contain additional headers to be added to the request.
    /// These headers replace any existing in the request headers, without support for the list-values headers.
    ///
    /// The optional `out_content_type` can be used to get content type of the response.
    /// Free it with `glib.free`, when no longer needed.
    ///
    /// The optional `out_headers` contains response headers. Free it with `soup_message_headers_free`,
    /// when no longer needed.
    ///
    /// The optional `out_content` can be used to get actual result content. Free it
    /// with `glib.byteArrayFree`, when no longer needed.
    extern fn e_webdav_session_post_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_data: [*:0]const u8, p_data_length: usize, p_in_content_type: ?[*:0]const u8, p_in_headers: ?*soup.MessageHeaders, p_out_content_type: ?*[*:0]u8, p_out_headers: ?**soup.MessageHeaders, p_out_content: ?**glib.ByteArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const postSync = e_webdav_session_post_sync;

    /// Issues a DAV:principal-property-search for the `uri`, or, in case it's `NULL`,
    /// for the URI defined in associated `edataserver.Source`. The DAV:principal-property-search
    /// performs a search for all principals whose properties contain character data
    /// that matches the search criteria `match_value` in `match_property` property
    /// of namespace `match_ns_uri`.
    ///
    /// By default, the function searches all members (at any depth) of the collection
    /// identified by the `uri`. If `apply_to_principal_collection_set` is set to `TRUE`,
    /// the search is applied instead to each collection returned by
    /// `edataserver.WebDAVSession.getPrincipalCollectionSetSync` for the `uri`.
    ///
    /// The `out_principals` is a `glib.SList` of `edataserver.WebDAVResource`, where the kind
    /// is set to `E_WEBDAV_RESOURCE_KIND_PRINCIPAL` and only href with displayname
    /// are filled. All other members of `edataserver.WebDAVResource` are not set.
    ///
    /// Free the returned `out_principals` with
    /// g_slist_free_full (principals, e_webdav_resource_free);
    /// when no longer needed.
    extern fn e_webdav_session_principal_property_search_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_apply_to_principal_collection_set: c_int, p_match_ns_uri: ?[*:0]const u8, p_match_property: [*:0]const u8, p_match_value: [*:0]const u8, p_out_principals: **glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const principalPropertySearchSync = e_webdav_session_principal_property_search_sync;

    /// Issues PROPFIND request on the provided `uri`, or, in case it's `NULL`, on the URI
    /// defined in associated `edataserver.Source`. On success, calls `func` for each returned
    /// DAV:propstat.
    ///
    /// The `xml` can be `NULL`, in which case the server should behave like DAV:allprop request.
    extern fn e_webdav_session_propfind_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_depth: [*:0]const u8, p_xml: ?*const edataserver.XmlDocument, p_func: edataserver.WebDAVPropstatTraverseFunc, p_func_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const propfindSync = e_webdav_session_propfind_sync;

    /// Issues PROPPATCH request on the provided `uri`, or, in case it's `NULL`, on the URI
    /// defined in associated `edataserver.Source`, with the `changes`. The order of requested changes
    /// inside `xml` is significant, unlike on other places.
    extern fn e_webdav_session_proppatch_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_xml: *const edataserver.XmlDocument, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const proppatchSync = e_webdav_session_proppatch_sync;

    /// Writes data to a resource identified by `uri` to the server. The URI cannot
    /// reference a collection.
    ///
    /// The `etag` argument is used to avoid clashes when overwriting existing
    /// resources. It can contain three values:
    ///  - `NULL` - to write completely new resource
    ///  - empty string - write new resource or overwrite any existing, regardless changes on the server
    ///  - valid ETag - overwrite existing resource only if it wasn't changed on the server.
    ///
    /// Note that the actual usage of `etag` is also influenced by `edataserver.SourceWebdav.properties.avoid`-ifmatch
    /// property of the associated `edataserver.Source`.
    ///
    /// The optional `in_headers` can contain additional headers to be added to the request.
    /// These headers replace any existing in the request headers, without support for the list-values headers.
    ///
    /// The `out_href`, if provided, is filled with the resulting URI
    /// of the written resource. It can be different from the `uri` when the server
    /// redirected to a different location.
    ///
    /// The `out_etag` contains ETag of the resource after it had been saved.
    ///
    /// The optional `out_headers` contains response headers. Free it with `soup_message_headers_free`,
    /// when no longer needed.
    ///
    /// To write large data use `edataserver.WebDAVSession.putSync` instead.
    extern fn e_webdav_session_put_data_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_etag: ?[*:0]const u8, p_content_type: [*:0]const u8, p_in_headers: ?*soup.MessageHeaders, p_bytes: [*:0]const u8, p_length: usize, p_out_href: ?*[*:0]u8, p_out_etag: ?*[*:0]u8, p_out_headers: ?**soup.MessageHeaders, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const putDataSync = e_webdav_session_put_data_sync;

    /// Writes data from `stream` to a resource identified by `uri` to the server.
    /// The URI cannot reference a collection.
    ///
    /// The `etag` argument is used to avoid clashes when overwriting existing
    /// resources. It can contain three values:
    ///  - `NULL` - to write completely new resource
    ///  - empty string - write new resource or overwrite any existing, regardless changes on the server
    ///  - valid ETag - overwrite existing resource only if it wasn't changed on the server.
    ///
    /// Note that the actual behaviour is also influenced by `edataserver.SourceWebdav.properties.avoid`-ifmatch
    /// property of the associated `edataserver.Source`.
    ///
    /// The optional `in_headers` can contain additional headers to be added to the request.
    /// These headers replace any existing in the request headers, without support for the list-values headers.
    ///
    /// The `out_href`, if provided, is filled with the resulting URI
    /// of the written resource. It can be different from the `uri` when the server
    /// redirected to a different location.
    ///
    /// The `out_etag` contains ETag of the resource after it had been saved.
    ///
    /// The optional `out_headers` contains response headers. Free it with `soup_message_headers_free`,
    /// when no longer needed.
    ///
    /// The `stream` should support also `gio.Seekable` interface, because the data
    /// send can require restart of the send due to redirect or other reasons.
    ///
    /// This method uses Transfer-Encoding:chunked, in contrast to the
    /// `edataserver.WebDAVSession.putDataSync`, which writes data stored in memory
    /// like any other request.
    extern fn e_webdav_session_put_sync(p_webdav: *WebDAVSession, p_uri: [*:0]const u8, p_etag: ?[*:0]const u8, p_content_type: [*:0]const u8, p_in_headers: ?*soup.MessageHeaders, p_stream: *gio.InputStream, p_stream_length: isize, p_out_href: ?*[*:0]u8, p_out_etag: ?*[*:0]u8, p_out_headers: ?**soup.MessageHeaders, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const putSync = e_webdav_session_put_sync;

    /// Refreshes existing lock `lock_token` for a resource identified by `uri`,
    /// or, in case it's `NULL`, on the URI defined in associated `edataserver.Source`.
    /// The `lock_token` is returned from `edataserver.WebDAVSession.lockSync` and
    /// the `uri` should be the same as that used with `edataserver.WebDAVSession.lockSync`.
    extern fn e_webdav_session_refresh_lock_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_lock_token: [*:0]const u8, p_lock_timeout: i32, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshLockSync = e_webdav_session_refresh_lock_sync;

    /// Tries to read detailed error information from `response_data`,
    /// if not provided, then from `message`'s response_body. If the detailed
    /// error cannot be found, then does nothing, otherwise frees the content
    /// of `inout_error`, if any, and then populates it with an error message
    /// prefixed with `prefix`.
    ///
    /// The `prefix` might be of form "Failed to something", because the resulting
    /// error message will be:
    /// "Failed to something: HTTP error code XXX (reason_phrase): detailed_error".
    /// When `prefix` is `NULL`, the error message will be:
    /// "Failed with HTTP error code XXX (reason phrase): detailed_error".
    ///
    /// As the caller might not be interested in errors, also the `inout_error`
    /// can be `NULL`, in which case the function does nothing.
    extern fn e_webdav_session_replace_with_detailed_error(p_webdav: *WebDAVSession, p_message: *soup.Message, p_response_data: ?*const glib.ByteArray, p_ignore_multistatus: c_int, p_prefix: ?[*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const replaceWithDetailedError = e_webdav_session_replace_with_detailed_error;

    /// Issues REPORT request on the provided `uri`, or, in case it's `NULL`, on the URI
    /// defined in associated `edataserver.Source`. On success, calls `func` for each returned
    /// DAV:propstat.
    ///
    /// The report can result in a multistatus response, but also to raw data. In case
    /// the `func` is provided and the result is a multistatus response, then it is traversed
    /// using this `func`.
    ///
    /// The optional `out_content_type` can be used to get content type of the response.
    /// Free it with `glib.free`, when no longer needed.
    ///
    /// The optional `out_content` can be used to get actual result content. Free it
    /// with `glib.byteArrayFree`, when no longer needed.
    extern fn e_webdav_session_report_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_depth: ?[*:0]const u8, p_xml: *const edataserver.XmlDocument, p_func: ?edataserver.WebDAVPropstatTraverseFunc, p_func_user_data: ?*anyopaque, p_out_content_type: ?*[*:0]u8, p_out_content: ?**glib.ByteArray, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const reportSync = e_webdav_session_report_sync;

    /// Changes Access Control List (ACL) for the `uri`, or, in case it's `NULL`,
    /// for the URI defined in associated `edataserver.Source`.
    ///
    /// Make sure that the `entries` satisfy ACL restrictions, as returned
    /// by `edataserver.WebDAVSession.getAclRestrictionsSync`. The order in the `entries`
    /// is preserved. It cannot contain any `E_WEBDAV_ACE_FLAG_PROTECTED`,
    /// nor `E_WEBDAV_ACE_FLAG_INHERITED`, items.
    ///
    /// Use `edataserver.WebDAVSession.getAclSync` to read currently known ACL entries,
    /// remove from the list those protected and inherited, and then modify
    /// the rest with the required changed.
    ///
    /// Note this function doesn't support general `E_WEBDAV_ACE_PRINCIPAL_PROPERTY` and
    /// returns `G_IO_ERROR_NOT_SUPPORTED` error when any such is tried to be written.
    ///
    /// In case the returned entries contain any `E_WEBDAV_ACE_PRINCIPAL_PROPERTY`,
    /// or there's a need to write such Access Control Entry, then do not use
    /// `edataserver.WebDAVSession.getAclSync`, neither `edataserver.WebDAVSession.setAclSync`,
    /// and write more generic implementation.
    extern fn e_webdav_session_set_acl_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_entries: *const glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setAclSync = e_webdav_session_set_acl_sync;

    /// Traverses a CALDAV:mkcalendar-response response and calls `func` for each returned DAV:propstat.
    ///
    /// The `message`, if provided, is used to verify that the response is an XML Content-Type.
    /// It's used to get the request URI as well.
    extern fn e_webdav_session_traverse_mkcalendar_response(p_webdav: *WebDAVSession, p_message: ?*soup.Message, p_xml_data: *const glib.ByteArray, p_func: edataserver.WebDAVPropstatTraverseFunc, p_func_user_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const traverseMkcalendarResponse = e_webdav_session_traverse_mkcalendar_response;

    /// Traverses a DAV:mkcol-response response and calls `func` for each returned DAV:propstat.
    ///
    /// The `message`, if provided, is used to verify that the response is an XML Content-Type.
    /// It's used to get the request URI as well.
    extern fn e_webdav_session_traverse_mkcol_response(p_webdav: *WebDAVSession, p_message: ?*soup.Message, p_xml_data: *const glib.ByteArray, p_func: edataserver.WebDAVPropstatTraverseFunc, p_func_user_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const traverseMkcolResponse = e_webdav_session_traverse_mkcol_response;

    /// Traverses a DAV:multistatus response and calls `func` for each returned DAV:propstat.
    ///
    /// The `message`, if provided, is used to verify that the response is a multi-status
    /// and that the Content-Type is properly set. It's used to get a request URI as well.
    extern fn e_webdav_session_traverse_multistatus_response(p_webdav: *WebDAVSession, p_message: ?*soup.Message, p_xml_data: *const glib.ByteArray, p_func: edataserver.WebDAVPropstatTraverseFunc, p_func_user_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const traverseMultistatusResponse = e_webdav_session_traverse_multistatus_response;

    /// Releases (unlocks) existing lock `lock_token` for a resource identified by `uri`,
    /// or, in case it's `NULL`, on the URI defined in associated `edataserver.Source`.
    /// The `lock_token` is returned from `edataserver.WebDAVSession.lockSync` and
    /// the `uri` should be the same as that used with `edataserver.WebDAVSession.lockSync`.
    extern fn e_webdav_session_unlock_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_lock_token: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const unlockSync = e_webdav_session_unlock_sync;

    /// Updates properties (set/remove) on the provided `uri`, or, in case it's `NULL`,
    /// on the URI defined in associated `edataserver.Source`, with the `changes`. The order
    /// of `changes` is significant, unlike on other places.
    ///
    /// This function supports only flat properties, those not under other element.
    /// To support more complex property tries use `edataserver.WebDAVSession.proppatchSync`
    /// directly.
    extern fn e_webdav_session_update_properties_sync(p_webdav: *WebDAVSession, p_uri: ?[*:0]const u8, p_changes: *const glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const updatePropertiesSync = e_webdav_session_update_properties_sync;

    extern fn e_webdav_session_get_type() usize;
    pub const getGObjectType = e_webdav_session_get_type;

    extern fn g_object_ref(p_self: *edataserver.WebDAVSession) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.WebDAVSession) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WebDAVSession, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const XmlDocument = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = edataserver.XmlDocumentClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserver.XmlDocumentPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `edataserver.XmlDocument` with root element `root_element` and optionally
    /// also with set default namespace `ns_href`.
    extern fn e_xml_document_new(p_ns_href: ?[*:0]const u8, p_root_element: [*:0]const u8) *edataserver.XmlDocument;
    pub const new = e_xml_document_new;

    /// Adds a new attribute to the current element.
    /// Use `NULL` `ns_href`, to use the default namespace, otherwise either previously
    /// added namespace with the same href from `edataserver.XmlDocument.addNamespaces` is picked,
    /// or a new namespace with generated prefix is added.
    extern fn e_xml_document_add_attribute(p_xml: *XmlDocument, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const addAttribute = e_xml_document_add_attribute;

    /// Adds a new attribute with a double value to the current element.
    /// Use `NULL` `ns_href`, to use the default namespace, otherwise either previously
    /// added namespace with the same href from `edataserver.XmlDocument.addNamespaces` is picked,
    /// or a new namespace with generated prefix is added.
    extern fn e_xml_document_add_attribute_double(p_xml: *XmlDocument, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8, p_value: f64) void;
    pub const addAttributeDouble = e_xml_document_add_attribute_double;

    /// Adds a new attribute with an integer value to the current element.
    /// Use `NULL` `ns_href`, to use the default namespace, otherwise either previously
    /// added namespace with the same href from `edataserver.XmlDocument.addNamespaces` is picked,
    /// or a new namespace with generated prefix is added.
    extern fn e_xml_document_add_attribute_int(p_xml: *XmlDocument, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8, p_value: i64) void;
    pub const addAttributeInt = e_xml_document_add_attribute_int;

    /// Adds a new attribute with a time_t value in ISO 8601 format to the current element.
    /// The format is "YYYY-MM-DDTHH:MM:SSZ".
    /// Use `NULL` `ns_href`, to use the default namespace, otherwise either previously
    /// added namespace with the same href from `edataserver.XmlDocument.addNamespaces` is picked,
    /// or a new namespace with generated prefix is added.
    extern fn e_xml_document_add_attribute_time(p_xml: *XmlDocument, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8, p_value: std.posix.time_t) void;
    pub const addAttributeTime = e_xml_document_add_attribute_time;

    /// Adds a new attribute with a time_t value in iCalendar format to the current element.
    /// The format is "YYYYMMDDTHHMMSSZ".
    /// Use `NULL` `ns_href`, to use the default namespace, otherwise either previously
    /// added namespace with the same href from `edataserver.XmlDocument.addNamespaces` is picked,
    /// or a new namespace with generated prefix is added.
    extern fn e_xml_document_add_attribute_time_ical(p_xml: *XmlDocument, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8, p_value: std.posix.time_t) void;
    pub const addAttributeTimeIcal = e_xml_document_add_attribute_time_ical;

    /// Adds an empty element, which is an element with no attribute and no value.
    ///
    /// It's the same as calling `edataserver.XmlDocument.startElement` immediately
    /// followed by `edataserver.XmlDocument.endElement`.
    extern fn e_xml_document_add_empty_element(p_xml: *XmlDocument, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) void;
    pub const addEmptyElement = e_xml_document_add_empty_element;

    /// Adds one or more namespaces to `xml`, which can be referenced
    /// later by `ns_href`. The caller should take care that neither
    /// used `ns_prefix`, nor `ns_href`, is already used by `xml`.
    extern fn e_xml_document_add_namespaces(p_xml: *XmlDocument, p_ns_prefix: [*:0]const u8, p_ns_href: [*:0]const u8, ...) void;
    pub const addNamespaces = e_xml_document_add_namespaces;

    /// This is a pair function for `edataserver.XmlDocument.startElement` and
    /// `edataserver.XmlDocument.startTextElement`, which changes current
    /// element to the parent of that element.
    extern fn e_xml_document_end_element(p_xml: *XmlDocument) void;
    pub const endElement = e_xml_document_end_element;

    /// Gets content of the `xml` as string. The string is nul-terminated, but
    /// if `out_length` is also provided, then it doesn't contain this additional
    /// nul character.
    extern fn e_xml_document_get_content(p_xml: *const XmlDocument, p_out_length: ?*usize) [*:0]u8;
    pub const getContent = e_xml_document_get_content;

    extern fn e_xml_document_get_xmldoc(p_xml: *XmlDocument) *libxml2.Doc;
    pub const getXmldoc = e_xml_document_get_xmldoc;

    /// Starts a new non-text element as a child of the current element.
    /// Each such call should be ended with corresponding `edataserver.XmlDocument.endElement`.
    /// Use `NULL` `ns_href`, to use the default namespace, otherwise either previously
    /// added namespace with the same href from `edataserver.XmlDocument.addNamespaces` is picked,
    /// or a new namespace with generated prefix is added.
    ///
    /// To start a text node use `edataserver.XmlDocument.startTextElement`.
    extern fn e_xml_document_start_element(p_xml: *XmlDocument, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) void;
    pub const startElement = e_xml_document_start_element;

    /// Starts a new text element as a child of the current element.
    /// Each such call should be ended with corresponding `edataserver.XmlDocument.endElement`.
    /// Use `NULL` `ns_href`, to use the default namespace, otherwise either previously
    /// added namespace with the same href from `edataserver.XmlDocument.addNamespaces` is picked,
    /// or a new namespace with generated prefix is added.
    ///
    /// To start a non-text node use `edataserver.XmlDocument.startElement`.
    extern fn e_xml_document_start_text_element(p_xml: *XmlDocument, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) void;
    pub const startTextElement = e_xml_document_start_text_element;

    /// Writes `value` of length `len`, encoded to base64, as content of the current element.
    extern fn e_xml_document_write_base64(p_xml: *XmlDocument, p_value: [*:0]const u8, p_len: c_int) void;
    pub const writeBase64 = e_xml_document_write_base64;

    /// Writes `value` of length `len` as content of the current element.
    extern fn e_xml_document_write_buffer(p_xml: *XmlDocument, p_value: [*:0]const u8, p_len: c_int) void;
    pub const writeBuffer = e_xml_document_write_buffer;

    /// Writes `value` as content of the current element.
    extern fn e_xml_document_write_double(p_xml: *XmlDocument, p_value: f64) void;
    pub const writeDouble = e_xml_document_write_double;

    /// Writes `value` as content of the current element.
    extern fn e_xml_document_write_int(p_xml: *XmlDocument, p_value: i64) void;
    pub const writeInt = e_xml_document_write_int;

    /// Writes `value` as content of the current element.
    extern fn e_xml_document_write_string(p_xml: *XmlDocument, p_value: [*:0]const u8) void;
    pub const writeString = e_xml_document_write_string;

    /// Writes `value` in ISO 8601 format as content of the current element.
    /// The format is "YYYY-MM-DDTHH:MM:SSZ".
    extern fn e_xml_document_write_time(p_xml: *XmlDocument, p_value: std.posix.time_t) void;
    pub const writeTime = e_xml_document_write_time;

    extern fn e_xml_document_get_type() usize;
    pub const getGObjectType = e_xml_document_get_type;

    extern fn g_object_ref(p_self: *edataserver.XmlDocument) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.XmlDocument) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *XmlDocument, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Extensible = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = edataserver.ExtensibleInterface;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a list of `edataserver.Extension` objects bound to `extensible` whose
    /// types are ancestors of `extension_type`.  For a complete list of
    /// extension objects bound to `extensible`, pass `E_TYPE_EXTENSION`.
    ///
    /// The list itself should be freed with `glib.List.free`.  The extension
    /// objects are owned by `extensible` and should not be unreferenced.
    extern fn e_extensible_list_extensions(p_extensible: *Extensible, p_extension_type: usize) *glib.List;
    pub const listExtensions = e_extensible_list_extensions;

    /// Creates an instance of all instantiable subtypes of `edataserver.Extension` which
    /// target the class of `extensible`.  The lifetimes of these newly created
    /// `edataserver.Extension` objects are bound to `extensible` such that they are finalized
    /// when `extensible` is finalized.
    extern fn e_extensible_load_extensions(p_extensible: *Extensible) void;
    pub const loadExtensions = e_extensible_load_extensions;

    /// Similar to `edataserver.Extensible.loadExtensions`, only loads newly discovered
    /// extensions again. This can help in case a new module had been loaded
    /// to the process, which provides the extensions for the `extensible`.
    extern fn e_extensible_reload_extensions(p_extensible: *Extensible) void;
    pub const reloadExtensions = e_extensible_reload_extensions;

    extern fn e_extensible_get_type() usize;
    pub const getGObjectType = e_extensible_get_type;

    extern fn g_object_ref(p_self: *edataserver.Extensible) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.Extensible) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Extensible, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const OAuth2Service = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = edataserver.OAuth2ServiceInterface;
    pub const virtual_methods = struct {
        /// Checks whether the `service` can be used with the given `source`.
        ///
        /// The default implementation checks whether the `source` has an `edataserver.SourceAuthentication`
        /// extension and when its method matches `edataserver.OAuth2Service.getName`, then it automatically
        /// returns `TRUE`. Contrary, when the `source` contains GNOME Online Accounts or Ubuntu
        /// Online Accounts extension, then it returns `FALSE`.
        ///
        /// The default implementation is tried always as the first and when it fails, then
        /// the descendant's implementation is called.
        pub const can_process = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) c_int {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_can_process.?(gobject.ext.as(OAuth2Service, p_service), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) c_int) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_can_process = @ptrCast(p_implementation);
            }
        };

        /// Additional cookies to be used in the prompt dialog when asking for the user
        /// credentials. The default implementation does not provide any cookies.
        pub const dup_credentials_prompter_cookies_sync = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable) ?*glib.SList {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_dup_credentials_prompter_cookies_sync.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_cancellable);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable) callconv(.c) ?*glib.SList) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_dup_credentials_prompter_cookies_sync = @ptrCast(p_implementation);
            }
        };

        /// Tries to extract an authorization code from a web page provided by the server.
        /// The function can be called multiple times, whenever the page load is finished.
        /// The default implementation uses `edataserver.oauth2ServiceUtilExtractFromUri` to get
        /// the code from the given `page_uri`.
        ///
        /// There can happen three states: 1) either the `service` cannot determine
        /// the authentication code from the page information, then the `FALSE` is
        /// returned and the `out_authorization_code` is left untouched; or 2) the server
        /// reported a failure, in which case the function returns `TRUE` and lefts
        /// the `out_authorization_code` untouched; or 3) the `service` could extract
        /// the authentication code from the given arguments, then the function
        /// returns `TRUE` and sets the received authorization code to `out_authorization_code`.
        ///
        /// The `page_content` is `NULL`, unless flags returned by `edataserver.OAuth2Service.getFlags`
        /// contain also `E_OAUTH2_SERVICE_FLAG_EXTRACT_REQUIRES_PAGE_CONTENT`.
        ///
        /// This method is always called after `edataserver.OAuth2Service.getAuthenticationPolicy`.
        pub const extract_authorization_code = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_page_title: [*:0]const u8, p_page_uri: [*:0]const u8, p_page_content: ?[*:0]const u8, p_out_authorization_code: *[*:0]u8) c_int {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_extract_authorization_code.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_page_title, p_page_uri, p_page_content, p_out_authorization_code);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_page_title: [*:0]const u8, p_page_uri: [*:0]const u8, p_page_content: ?[*:0]const u8, p_out_authorization_code: *[*:0]u8) callconv(.c) c_int) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_extract_authorization_code = @ptrCast(p_implementation);
            }
        };

        /// Tries to extract error message from the server response, return `TRUE`,
        /// when an error message could be found, in which case also sets
        /// the `out_error_message` with it. The default implementation uses
        /// `edataserver.oauth2ServiceUtilExtractFromUri`, returning either the error
        /// description or the error code, when the description is not found.
        ///
        /// The `out_error_message` is expected to be plain text.
        pub const extract_error_message = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_page_title: [*:0]const u8, p_page_uri: [*:0]const u8, p_page_content: ?[*:0]const u8, p_out_error_message: *[*:0]u8) c_int {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_extract_error_message.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_page_title, p_page_uri, p_page_content, p_out_error_message);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_page_title: [*:0]const u8, p_page_uri: [*:0]const u8, p_page_content: ?[*:0]const u8, p_out_error_message: *[*:0]u8) callconv(.c) c_int) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_extract_error_message = @ptrCast(p_implementation);
            }
        };

        /// Used to decide what to do when the server redirects to the next page.
        /// The default implementation always returns `E_OAUTH2_SERVICE_NAVIGATION_POLICY_ALLOW`.
        ///
        /// This method is called before `edataserver.OAuth2Service.extractAuthorizationCode` and
        /// can be used to block certain resources or to abort the authentication when
        /// the server redirects to an unexpected page (like when user denies authorization
        /// in the page).
        pub const get_authentication_policy = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_uri: [*:0]const u8) edataserver.OAuth2ServiceNavigationPolicy {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_authentication_policy.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_uri);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_uri: [*:0]const u8) callconv(.c) edataserver.OAuth2ServiceNavigationPolicy) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_authentication_policy = @ptrCast(p_implementation);
            }
        };

        pub const get_authentication_uri = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) [*:0]const u8 {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_authentication_uri.?(gobject.ext.as(OAuth2Service, p_service), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_authentication_uri = @ptrCast(p_implementation);
            }
        };

        pub const get_client_id = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) [*:0]const u8 {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_client_id.?(gobject.ext.as(OAuth2Service, p_service), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_client_id = @ptrCast(p_implementation);
            }
        };

        pub const get_client_secret = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) ?[*:0]const u8 {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_client_secret.?(gobject.ext.as(OAuth2Service, p_service), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_client_secret = @ptrCast(p_implementation);
            }
        };

        /// Returns a human readable name of the service. This is similar to
        /// `edataserver.OAuth2Service.getName`, except this string should be localized,
        /// because it will be used in user-visible strings.
        pub const get_display_name = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_display_name.?(gobject.ext.as(OAuth2Service, p_service));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_display_name = @ptrCast(p_implementation);
            }
        };

        pub const get_flags = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) u32 {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_flags.?(gobject.ext.as(OAuth2Service, p_service));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) u32) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_flags = @ptrCast(p_implementation);
            }
        };

        /// Returns a unique name of the service. It can be named for example
        /// by the server or the company from which it receives the OAuth2
        /// token and where it refreshes it, like "Company" for login.company.com.
        pub const get_name = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_name.?(gobject.ext.as(OAuth2Service, p_service));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_name = @ptrCast(p_implementation);
            }
        };

        /// Returns a value for the "redirect_uri" keys in the authenticate and get_token
        /// operations. The default implementation returns "urn:ietf:wg:oauth:2.0:oob".
        pub const get_redirect_uri = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) ?[*:0]const u8 {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_redirect_uri.?(gobject.ext.as(OAuth2Service, p_service), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_redirect_uri = @ptrCast(p_implementation);
            }
        };

        pub const get_refresh_uri = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) [*:0]const u8 {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_get_refresh_uri.?(gobject.ext.as(OAuth2Service, p_service), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_get_refresh_uri = @ptrCast(p_implementation);
            }
        };

        /// Checks whether the `service` can be used with the given `protocol` and/or `hostname`.
        /// Any of `protocol` and `hostname` can be `NULL`, but not both. It's up to each implementer
        /// to decide, which of the arguments are important and whether all or only any of them
        /// can be required.
        ///
        /// The function is meant to check whether the `service` can be offered
        /// for example when configuring a new account. The real usage is
        /// determined by `edataserver.OAuth2Service.canProcess`.
        ///
        /// The default implementation consults org.gnome.evolution-data-server.oauth2-services-hint
        /// GSettings key against given hostname. See its description for more information.
        ///
        /// The default implementation is tried always as the first and when it fails, then
        /// the descendant's implementation is called.
        pub const guess_can_process = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_protocol: ?[*:0]const u8, p_hostname: ?[*:0]const u8) c_int {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_guess_can_process.?(gobject.ext.as(OAuth2Service, p_service), p_protocol, p_hostname);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_protocol: ?[*:0]const u8, p_hostname: ?[*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_guess_can_process = @ptrCast(p_implementation);
            }
        };

        /// The `service` can change what arguments are passed in the authentication URI
        /// in this method. The default implementation sets some values too, namely
        /// "response_type", "client_id", "redirect_uri" and "login_hint", if available
        /// in the `source`. These parameters are always provided, even when the interface
        /// implementer overrides this method.
        ///
        /// The `uri_query` hash table expects both key and value to be newly allocated
        /// strings, which will be freed together with the hash table or when the key
        /// is replaced.
        pub const prepare_authentication_uri_query = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_uri_query: *glib.HashTable) void {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_authentication_uri_query.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_uri_query);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_uri_query: *glib.HashTable) callconv(.c) void) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_authentication_uri_query = @ptrCast(p_implementation);
            }
        };

        /// Sets additional form parameters to be used in the POST request when requesting
        /// access token after successfully obtained authorization code.
        /// The default implementation sets some values too, namely
        /// "code", "client_id", "client_secret", "redirect_uri" and "grant_type".
        /// These parameters are always provided, even when the interface implementer overrides this method.
        ///
        /// The `form` hash table expects both key and value to be newly allocated
        /// strings, which will be freed together with the hash table or when the key
        /// is replaced.
        pub const prepare_get_token_form = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_authorization_code: [*:0]const u8, p_form: *glib.HashTable) void {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_get_token_form.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_authorization_code, p_form);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_authorization_code: [*:0]const u8, p_form: *glib.HashTable) callconv(.c) void) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_get_token_form = @ptrCast(p_implementation);
            }
        };

        /// The `service` can change the `message` before it's sent to
        /// the `edataserver.OAuth2Service.getAuthenticationUri`, with POST data
        /// being provided by `edataserver.OAuth2Service.prepareGetTokenForm`.
        /// The default implementation does nothing with the `message`.
        pub const prepare_get_token_message = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_message: *soup.Message) void {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_get_token_message.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_message);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_message: *soup.Message) callconv(.c) void) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_get_token_message = @ptrCast(p_implementation);
            }
        };

        /// Sets additional form parameters to be used in the POST request when requesting
        /// to refresh an access token.
        /// The default implementation sets some values too, namely
        /// "refresh_token", "client_id", "client_secret" and "grant_type".
        /// These parameters are always provided, even when the interface implementer overrides this method.
        ///
        /// The `form` hash table expects both key and value to be newly allocated
        /// strings, which will be freed together with the hash table or when the key
        /// is replaced.
        pub const prepare_refresh_token_form = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_refresh_token: [*:0]const u8, p_form: *glib.HashTable) void {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_refresh_token_form.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_refresh_token, p_form);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_refresh_token: [*:0]const u8, p_form: *glib.HashTable) callconv(.c) void) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_refresh_token_form = @ptrCast(p_implementation);
            }
        };

        /// The `service` can change the `message` before it's sent to
        /// the `edataserver.OAuth2Service.getRefreshUri`, with POST data
        /// being provided by `edataserver.OAuth2Service.prepareRefreshTokenForm`.
        /// The default implementation does nothing with the `message`.
        pub const prepare_refresh_token_message = struct {
            pub fn call(p_class: anytype, p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_message: *soup.Message) void {
                return gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_refresh_token_message.?(gobject.ext.as(OAuth2Service, p_service), p_source, p_message);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_service: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_message: *soup.Message) callconv(.c) void) void {
                gobject.ext.as(OAuth2Service.Iface, p_class).f_prepare_refresh_token_message = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Processes the `compile_value` and returns the result, which is stored
    /// into the `out_glob_buff`. The `out_glob_buff` should be large enough to hold
    /// the processed value and it should be a global memory buffer (usually
    /// statically allocated) initialized to 0, which is used to short-circuit
    /// the call, because the processing is done only if the first element
    /// of the `out_glob_buff` is 0, in all other cases the function
    /// immediately returns the `out_glob_buff`.
    extern fn e_oauth2_service_util_compile_value(p_compile_value: [*:0]const u8, p_out_glob_buff: [*:0]u8, p_out_glob_buff_size: usize) [*:0]const u8;
    pub const utilCompileValue = e_oauth2_service_util_compile_value;

    /// Extracts either an authorization code from a 'code' argument of the `in_uri`,
    /// or an error code from an 'error' argument of the `in_uri` and an error description
    /// from the 'error_description' argument of the `in_uri`.
    extern fn e_oauth2_service_util_extract_from_uri(p_in_uri: [*:0]const u8, p_out_authorization_code: ?*[*:0]u8, p_out_error_code: ?*[*:0]u8, p_out_error_description: ?*[*:0]u8) c_int;
    pub const utilExtractFromUri = e_oauth2_service_util_extract_from_uri;

    /// Sets `value` for `name` to `form`. The `form` should be
    /// the one used in `edataserver.OAuth2Service.prepareAuthenticationUriQuery`,
    /// `edataserver.OAuth2Service.prepareGetTokenForm` or
    /// `edataserver.OAuth2Service.prepareRefreshTokenForm`.
    ///
    /// If the `value` is `NULL`, then the property named `name` is removed
    /// from the `form` instead.
    extern fn e_oauth2_service_util_set_to_form(p_form: *glib.HashTable, p_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
    pub const utilSetToForm = e_oauth2_service_util_set_to_form;

    /// Takes ownership of `value` and sets it for `name` to `form`. The `value`
    /// will be freed with `glib.free`, when no longer needed. The `form` should be
    /// the one used in `edataserver.OAuth2Service.prepareAuthenticationUriQuery`,
    /// `edataserver.OAuth2Service.prepareGetTokenForm` or
    /// `edataserver.OAuth2Service.prepareRefreshTokenForm`.
    ///
    /// If the `value` is `NULL`, then the property named `name` is removed
    /// from the `form` instead.
    extern fn e_oauth2_service_util_take_to_form(p_form: *glib.HashTable, p_name: [*:0]const u8, p_value: ?[*:0]u8) void;
    pub const utilTakeToForm = e_oauth2_service_util_take_to_form;

    /// Checks whether the `service` can be used with the given `source`.
    ///
    /// The default implementation checks whether the `source` has an `edataserver.SourceAuthentication`
    /// extension and when its method matches `edataserver.OAuth2Service.getName`, then it automatically
    /// returns `TRUE`. Contrary, when the `source` contains GNOME Online Accounts or Ubuntu
    /// Online Accounts extension, then it returns `FALSE`.
    ///
    /// The default implementation is tried always as the first and when it fails, then
    /// the descendant's implementation is called.
    extern fn e_oauth2_service_can_process(p_service: *OAuth2Service, p_source: *edataserver.Source) c_int;
    pub const canProcess = e_oauth2_service_can_process;

    /// Deletes token information for the `service` and `source` from the secret store.
    extern fn e_oauth2_service_delete_token_sync(p_service: *OAuth2Service, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deleteTokenSync = e_oauth2_service_delete_token_sync;

    /// Additional cookies to be used in the prompt dialog when asking for the user
    /// credentials. The default implementation does not provide any cookies.
    extern fn e_oauth2_service_dup_credentials_prompter_cookies_sync(p_service: *OAuth2Service, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable) ?*glib.SList;
    pub const dupCredentialsPrompterCookiesSync = e_oauth2_service_dup_credentials_prompter_cookies_sync;

    /// Tries to extract an authorization code from a web page provided by the server.
    /// The function can be called multiple times, whenever the page load is finished.
    /// The default implementation uses `edataserver.oauth2ServiceUtilExtractFromUri` to get
    /// the code from the given `page_uri`.
    ///
    /// There can happen three states: 1) either the `service` cannot determine
    /// the authentication code from the page information, then the `FALSE` is
    /// returned and the `out_authorization_code` is left untouched; or 2) the server
    /// reported a failure, in which case the function returns `TRUE` and lefts
    /// the `out_authorization_code` untouched; or 3) the `service` could extract
    /// the authentication code from the given arguments, then the function
    /// returns `TRUE` and sets the received authorization code to `out_authorization_code`.
    ///
    /// The `page_content` is `NULL`, unless flags returned by `edataserver.OAuth2Service.getFlags`
    /// contain also `E_OAUTH2_SERVICE_FLAG_EXTRACT_REQUIRES_PAGE_CONTENT`.
    ///
    /// This method is always called after `edataserver.OAuth2Service.getAuthenticationPolicy`.
    extern fn e_oauth2_service_extract_authorization_code(p_service: *OAuth2Service, p_source: *edataserver.Source, p_page_title: [*:0]const u8, p_page_uri: [*:0]const u8, p_page_content: ?[*:0]const u8, p_out_authorization_code: *[*:0]u8) c_int;
    pub const extractAuthorizationCode = e_oauth2_service_extract_authorization_code;

    /// Tries to extract error message from the server response, return `TRUE`,
    /// when an error message could be found, in which case also sets
    /// the `out_error_message` with it. The default implementation uses
    /// `edataserver.oauth2ServiceUtilExtractFromUri`, returning either the error
    /// description or the error code, when the description is not found.
    ///
    /// The `out_error_message` is expected to be plain text.
    extern fn e_oauth2_service_extract_error_message(p_service: *OAuth2Service, p_source: *edataserver.Source, p_page_title: [*:0]const u8, p_page_uri: [*:0]const u8, p_page_content: ?[*:0]const u8, p_out_error_message: *[*:0]u8) c_int;
    pub const extractErrorMessage = e_oauth2_service_extract_error_message;

    /// Reads access token information from the secret store for the `source` and
    /// in case it's expired it refreshes the token, if possible.
    ///
    /// Free the returned `out_access_token` with `glib.free`, when no longer needed.
    extern fn e_oauth2_service_get_access_token_sync(p_service: *OAuth2Service, p_source: *edataserver.Source, p_ref_source: edataserver.OAuth2ServiceRefSourceFunc, p_ref_source_user_data: ?*anyopaque, p_out_access_token: *[*:0]u8, p_out_expires_in: *c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getAccessTokenSync = e_oauth2_service_get_access_token_sync;

    /// Used to decide what to do when the server redirects to the next page.
    /// The default implementation always returns `E_OAUTH2_SERVICE_NAVIGATION_POLICY_ALLOW`.
    ///
    /// This method is called before `edataserver.OAuth2Service.extractAuthorizationCode` and
    /// can be used to block certain resources or to abort the authentication when
    /// the server redirects to an unexpected page (like when user denies authorization
    /// in the page).
    extern fn e_oauth2_service_get_authentication_policy(p_service: *OAuth2Service, p_source: *edataserver.Source, p_uri: [*:0]const u8) edataserver.OAuth2ServiceNavigationPolicy;
    pub const getAuthenticationPolicy = e_oauth2_service_get_authentication_policy;

    extern fn e_oauth2_service_get_authentication_uri(p_service: *OAuth2Service, p_source: *edataserver.Source) [*:0]const u8;
    pub const getAuthenticationUri = e_oauth2_service_get_authentication_uri;

    extern fn e_oauth2_service_get_client_id(p_service: *OAuth2Service, p_source: *edataserver.Source) [*:0]const u8;
    pub const getClientId = e_oauth2_service_get_client_id;

    extern fn e_oauth2_service_get_client_secret(p_service: *OAuth2Service, p_source: *edataserver.Source) ?[*:0]const u8;
    pub const getClientSecret = e_oauth2_service_get_client_secret;

    /// Returns a human readable name of the service. This is similar to
    /// `edataserver.OAuth2Service.getName`, except this string should be localized,
    /// because it will be used in user-visible strings.
    extern fn e_oauth2_service_get_display_name(p_service: *OAuth2Service) [*:0]const u8;
    pub const getDisplayName = e_oauth2_service_get_display_name;

    extern fn e_oauth2_service_get_flags(p_service: *OAuth2Service) u32;
    pub const getFlags = e_oauth2_service_get_flags;

    /// Returns a unique name of the service. It can be named for example
    /// by the server or the company from which it receives the OAuth2
    /// token and where it refreshes it, like "Company" for login.company.com.
    extern fn e_oauth2_service_get_name(p_service: *OAuth2Service) [*:0]const u8;
    pub const getName = e_oauth2_service_get_name;

    /// Returns a value for the "redirect_uri" keys in the authenticate and get_token
    /// operations. The default implementation returns "urn:ietf:wg:oauth:2.0:oob".
    extern fn e_oauth2_service_get_redirect_uri(p_service: *OAuth2Service, p_source: *edataserver.Source) ?[*:0]const u8;
    pub const getRedirectUri = e_oauth2_service_get_redirect_uri;

    extern fn e_oauth2_service_get_refresh_uri(p_service: *OAuth2Service, p_source: *edataserver.Source) [*:0]const u8;
    pub const getRefreshUri = e_oauth2_service_get_refresh_uri;

    /// Checks whether the `service` can be used with the given `protocol` and/or `hostname`.
    /// Any of `protocol` and `hostname` can be `NULL`, but not both. It's up to each implementer
    /// to decide, which of the arguments are important and whether all or only any of them
    /// can be required.
    ///
    /// The function is meant to check whether the `service` can be offered
    /// for example when configuring a new account. The real usage is
    /// determined by `edataserver.OAuth2Service.canProcess`.
    ///
    /// The default implementation consults org.gnome.evolution-data-server.oauth2-services-hint
    /// GSettings key against given hostname. See its description for more information.
    ///
    /// The default implementation is tried always as the first and when it fails, then
    /// the descendant's implementation is called.
    extern fn e_oauth2_service_guess_can_process(p_service: *OAuth2Service, p_protocol: ?[*:0]const u8, p_hostname: ?[*:0]const u8) c_int;
    pub const guessCanProcess = e_oauth2_service_guess_can_process;

    /// The `service` can change what arguments are passed in the authentication URI
    /// in this method. The default implementation sets some values too, namely
    /// "response_type", "client_id", "redirect_uri" and "login_hint", if available
    /// in the `source`. These parameters are always provided, even when the interface
    /// implementer overrides this method.
    ///
    /// The `uri_query` hash table expects both key and value to be newly allocated
    /// strings, which will be freed together with the hash table or when the key
    /// is replaced.
    extern fn e_oauth2_service_prepare_authentication_uri_query(p_service: *OAuth2Service, p_source: *edataserver.Source, p_uri_query: *glib.HashTable) void;
    pub const prepareAuthenticationUriQuery = e_oauth2_service_prepare_authentication_uri_query;

    /// Sets additional form parameters to be used in the POST request when requesting
    /// access token after successfully obtained authorization code.
    /// The default implementation sets some values too, namely
    /// "code", "client_id", "client_secret", "redirect_uri" and "grant_type".
    /// These parameters are always provided, even when the interface implementer overrides this method.
    ///
    /// The `form` hash table expects both key and value to be newly allocated
    /// strings, which will be freed together with the hash table or when the key
    /// is replaced.
    extern fn e_oauth2_service_prepare_get_token_form(p_service: *OAuth2Service, p_source: *edataserver.Source, p_authorization_code: [*:0]const u8, p_form: *glib.HashTable) void;
    pub const prepareGetTokenForm = e_oauth2_service_prepare_get_token_form;

    /// The `service` can change the `message` before it's sent to
    /// the `edataserver.OAuth2Service.getAuthenticationUri`, with POST data
    /// being provided by `edataserver.OAuth2Service.prepareGetTokenForm`.
    /// The default implementation does nothing with the `message`.
    extern fn e_oauth2_service_prepare_get_token_message(p_service: *OAuth2Service, p_source: *edataserver.Source, p_message: *soup.Message) void;
    pub const prepareGetTokenMessage = e_oauth2_service_prepare_get_token_message;

    /// Sets additional form parameters to be used in the POST request when requesting
    /// to refresh an access token.
    /// The default implementation sets some values too, namely
    /// "refresh_token", "client_id", "client_secret" and "grant_type".
    /// These parameters are always provided, even when the interface implementer overrides this method.
    ///
    /// The `form` hash table expects both key and value to be newly allocated
    /// strings, which will be freed together with the hash table or when the key
    /// is replaced.
    extern fn e_oauth2_service_prepare_refresh_token_form(p_service: *OAuth2Service, p_source: *edataserver.Source, p_refresh_token: [*:0]const u8, p_form: *glib.HashTable) void;
    pub const prepareRefreshTokenForm = e_oauth2_service_prepare_refresh_token_form;

    /// The `service` can change the `message` before it's sent to
    /// the `edataserver.OAuth2Service.getRefreshUri`, with POST data
    /// being provided by `edataserver.OAuth2Service.prepareRefreshTokenForm`.
    /// The default implementation does nothing with the `message`.
    extern fn e_oauth2_service_prepare_refresh_token_message(p_service: *OAuth2Service, p_source: *edataserver.Source, p_message: *soup.Message) void;
    pub const prepareRefreshTokenMessage = e_oauth2_service_prepare_refresh_token_message;

    /// Queries `service` at `edataserver.OAuth2Service.getRefreshUri` with a request to obtain
    /// a new access token, associated with the given `authorization_code` and stores
    /// it into the secret store on success.
    extern fn e_oauth2_service_receive_and_store_token_sync(p_service: *OAuth2Service, p_source: *edataserver.Source, p_authorization_code: [*:0]const u8, p_ref_source: edataserver.OAuth2ServiceRefSourceFunc, p_ref_source_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const receiveAndStoreTokenSync = e_oauth2_service_receive_and_store_token_sync;

    /// Queries `service` at `edataserver.OAuth2Service.getRefreshUri` with a request to refresh
    /// existing access token with provided `refresh_token` and stores it into the secret
    /// store on success.
    extern fn e_oauth2_service_refresh_and_store_token_sync(p_service: *OAuth2Service, p_source: *edataserver.Source, p_refresh_token: [*:0]const u8, p_ref_source: edataserver.OAuth2ServiceRefSourceFunc, p_ref_source_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const refreshAndStoreTokenSync = e_oauth2_service_refresh_and_store_token_sync;

    extern fn e_oauth2_service_get_type() usize;
    pub const getGObjectType = e_oauth2_service_get_type;

    extern fn g_object_ref(p_self: *edataserver.OAuth2Service) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserver.OAuth2Service) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OAuth2Service, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `edataserver.AsyncClosure` provides a simple way to run an asynchronous function
/// synchronously without blocking a running `glib.MainLoop` or using threads.
///
/// 1) Create an `edataserver.AsyncClosure` with `edataserver.asyncClosureNew`.
///
/// 2) Call the asynchronous function passing `edataserver.asyncClosureCallback` as
///    the `gio.AsyncReadyCallback` argument and the `edataserver.AsyncClosure` as the data
///    argument.
///
/// 3) Call `edataserver.AsyncClosure.wait` and collect the `gio.AsyncResult`.
///
/// 4) Call the corresponding asynchronous "finish" function, passing the
///    `gio.AsyncResult` returned by `edataserver.AsyncClosure.wait`.
///
/// 5) If needed, repeat steps 2-4 for additional asynchronous functions
///    using the same `edataserver.AsyncClosure`.
///
/// 6) Finally, free the `edataserver.AsyncClosure` with `edataserver.AsyncClosure.free`.
pub const AsyncClosure = opaque {
    /// Pass this function as the `gio.AsyncReadyCallback` argument of an asynchronous
    /// function, and the `edataserver.AsyncClosure` as the data argument.
    ///
    /// This causes `edataserver.AsyncClosure.wait` to terminate and return `result`.
    extern fn e_async_closure_callback(p_object: ?*gobject.Object, p_result: *gio.AsyncResult, p_closure: ?*anyopaque) void;
    pub const callback = e_async_closure_callback;

    /// Creates a new `edataserver.AsyncClosure` for use with asynchronous functions.
    extern fn e_async_closure_new() *edataserver.AsyncClosure;
    pub const new = e_async_closure_new;

    /// Creates a new `edataserver.AsyncClosure` for use with asynchronous functions
    /// using the `context` as the main context.
    extern fn e_async_closure_new_with_context(p_context: ?*glib.MainContext) *edataserver.AsyncClosure;
    pub const newWithContext = e_async_closure_new_with_context;

    /// Frees the `closure` and the resources it holds.
    extern fn e_async_closure_free(p_closure: *AsyncClosure) void;
    pub const free = e_async_closure_free;

    /// Call this function immediately after starting an asynchronous operation.
    /// The function waits for the asynchronous operation to complete and returns
    /// its `gio.AsyncResult` to be passed to the operation's "finish" function.
    ///
    /// This function can be called repeatedly on the same `edataserver.AsyncClosure` to
    /// easily string together multiple asynchronous operations.
    extern fn e_async_closure_wait(p_closure: *AsyncClosure) *gio.AsyncResult;
    pub const wait = e_async_closure_wait;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClientClass = extern struct {
    pub const Instance = edataserver.Client;

    f_parent: gobject.ObjectClass,
    f_get_dbus_proxy: ?*const fn (p_client: *edataserver.Client) callconv(.c) *gio.DBusProxy,
    f_unwrap_dbus_error: ?*const fn (p_client: *edataserver.Client, p_dbus_error: *glib.Error, p_error: ?*?*glib.Error) callconv(.c) void,
    f_retrieve_capabilities: ?*const fn (p_client: *edataserver.Client, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_retrieve_capabilities_finish: ?*const fn (p_client: *edataserver.Client, p_result: *gio.AsyncResult, p_capabilities: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_retrieve_capabilities_sync: ?*const fn (p_client: *edataserver.Client, p_capabilities: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_backend_property: ?*const fn (p_client: *edataserver.Client, p_prop_name: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_get_backend_property_finish: ?*const fn (p_client: *edataserver.Client, p_result: *gio.AsyncResult, p_prop_value: *[*:0]u8, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_backend_property_sync: ?*const fn (p_client: *edataserver.Client, p_prop_name: [*:0]const u8, p_prop_value: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_set_backend_property: ?*const fn (p_client: *edataserver.Client, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_set_backend_property_finish: ?*const fn (p_client: *edataserver.Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_set_backend_property_sync: ?*const fn (p_client: *edataserver.Client, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_open: ?*const fn (p_client: *edataserver.Client, p_only_if_exists: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_open_finish: ?*const fn (p_client: *edataserver.Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_open_sync: ?*const fn (p_client: *edataserver.Client, p_only_if_exists: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remove: ?*const fn (p_client: *edataserver.Client, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_remove_finish: ?*const fn (p_client: *edataserver.Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remove_sync: ?*const fn (p_client: *edataserver.Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_refresh: ?*const fn (p_client: *edataserver.Client, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_refresh_finish: ?*const fn (p_client: *edataserver.Client, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_refresh_sync: ?*const fn (p_client: *edataserver.Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_retrieve_properties_sync: ?*const fn (p_client: *edataserver.Client, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_opened: ?*const fn (p_client: *edataserver.Client, p_error: *const glib.Error) callconv(.c) void,
    f_backend_error: ?*const fn (p_client: *edataserver.Client, p_error_msg: [*:0]const u8) callconv(.c) void,
    f_backend_died: ?*const fn (p_client: *edataserver.Client) callconv(.c) void,
    f_backend_property_changed: ?*const fn (p_client: *edataserver.Client, p_prop_name: [*:0]const u8, p_prop_value: [*:0]const u8) callconv(.c) void,

    pub fn as(p_instance: *ClientClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ClientErrorsList = extern struct {
    f_name: ?[*:0]const u8,
    f_err_code: c_int,

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

/// An opaque object used for locale specific string comparisons
/// and sort ordering.
pub const Collator = opaque {
    extern fn e_collator_error_quark() glib.Quark;
    pub const errorQuark = e_collator_error_quark;

    /// Creates a new `edataserver.Collator` for the given `locale`,
    /// the returned collator should be freed with `edataserver.Collator.unref`.
    extern fn e_collator_new(p_locale: [*:0]const u8, p_error: ?*?*glib.Error) ?*edataserver.Collator;
    pub const new = e_collator_new;

    /// Creates a new `edataserver.Collator` for the given `locale`,
    /// the returned collator should be freed with `edataserver.Collator.unref`.
    ///
    /// In addition, this also reliably interprets the country
    /// code from the `locale` string and stores it to `country_code`.
    extern fn e_collator_new_interpret_country(p_locale: [*:0]const u8, p_country_code: ?*[*:0]u8, p_error: ?*?*glib.Error) ?*edataserver.Collator;
    pub const newInterpretCountry = e_collator_new_interpret_country;

    /// Compares `str_a` with `str_b`, the order of strings is determined by the parameters of `collator`.
    ///
    /// The `result` will be set to integer less than, equal to, or greater than zero if `str_a` is found,
    /// respectively, to be less than, to match, or be greater than `str_b`.
    ///
    /// Either `str_a` or `str_b` can be `NULL`, `NULL` strings are considered to sort below other strings.
    ///
    /// This function will first ensure that both strings are valid UTF-8.
    extern fn e_collator_collate(p_collator: *Collator, p_str_a: ?[*:0]const u8, p_str_b: ?[*:0]const u8, p_result: *c_int, p_error: ?*?*glib.Error) c_int;
    pub const collate = e_collator_collate;

    /// Generates a collation key for `str`, the result of comparing
    /// two collation keys with `strcmp` will be the same result
    /// of calling `edataserver.Collator.collate` on the same original strings.
    ///
    /// This function will first ensure that `str` is valid UTF-8 encoded.
    extern fn e_collator_generate_key(p_collator: *Collator, p_str: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const generateKey = e_collator_generate_key;

    /// Generates a sort key for the given alphabetic `index`.
    ///
    /// The generated sort key is guaranteed to sort below
    /// any sort keys for words beginning with any variant of
    /// the given letter.
    ///
    /// For instance, a sort key generated for the index 5 of
    /// a latin alphabet, where the fifth index is 'E' will sort
    /// below any sort keys generated for words starting with
    /// the characters 'e', 'E', 'é', 'É', 'è' or 'È'. It will also
    /// sort above any sort keys generated for words starting with
    /// the characters 'd' or 'D'.
    extern fn e_collator_generate_key_for_index(p_collator: *Collator, p_index: c_int) [*:0]u8;
    pub const generateKeyForIndex = e_collator_generate_key_for_index;

    /// Checks which index, as determined by `edataserver.Collator.getIndexLabels`,
    /// that `str` should sort under.
    extern fn e_collator_get_index(p_collator: *Collator, p_str: [*:0]const u8) c_int;
    pub const getIndex = e_collator_get_index;

    /// Fetches the displayable labels and index positions for the active alphabet.
    extern fn e_collator_get_index_labels(p_collator: *Collator, p_n_labels: *c_int, p_underflow: ?*c_int, p_inflow: ?*c_int, p_overflow: ?*c_int) [*]const [*:0]const u8;
    pub const getIndexLabels = e_collator_get_index_labels;

    /// Increases the reference count of `collator`.
    extern fn e_collator_ref(p_collator: *Collator) *edataserver.Collator;
    pub const ref = e_collator_ref;

    /// Decreases the reference count of `collator`.
    /// If the reference count reaches 0 then the collator is freed
    extern fn e_collator_unref(p_collator: *Collator) void;
    pub const unref = e_collator_unref;

    extern fn e_collator_get_type() usize;
    pub const getGObjectType = e_collator_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ExtensibleInterface = extern struct {
    pub const Instance = edataserver.Extensible;

    f_parent_interface: gobject.TypeInterface,

    pub fn as(p_instance: *ExtensibleInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ExtensionClass = extern struct {
    pub const Instance = edataserver.Extension;

    f_parent_class: gobject.ObjectClass,
    f_extensible_type: usize,

    pub fn as(p_instance: *ExtensionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ExtensionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const Flag = opaque {
    /// Creates a new `edataserver.Flag` object.  It is initially unset.
    extern fn e_flag_new() *edataserver.Flag;
    pub const new = e_flag_new;

    /// Unsets `flag`.  Subsequent calls to `edataserver.Flag.wait` or `edataserver.Flag.waitUntil`
    /// will block until `flag` is set.
    extern fn e_flag_clear(p_flag: *Flag) void;
    pub const clear = e_flag_clear;

    /// Destroys `flag`.
    extern fn e_flag_free(p_flag: *Flag) void;
    pub const free = e_flag_free;

    /// Returns the state of `flag`.
    extern fn e_flag_is_set(p_flag: *Flag) c_int;
    pub const isSet = e_flag_is_set;

    /// Sets `flag`.  All threads waiting on `flag` are woken up.  Threads that
    /// call `edataserver.Flag.wait` or `edataserver.Flag.waitUntil` once `flag` is set will not
    /// block at all.
    extern fn e_flag_set(p_flag: *Flag) void;
    pub const set = e_flag_set;

    /// Blocks until `flag` is set, or until the time specified by `abs_time`.
    /// If `flag` is already set, the function returns immediately.  The return
    /// value indicates the state of `flag` after waiting.
    ///
    /// If `abs_time` is `NULL`, `edataserver.Flag.timedWait` acts like `edataserver.Flag.wait`.
    ///
    /// To easily calculate `abs_time`, a combination of `glib.getCurrentTime` and
    /// `glib.TimeVal.add` can be used.
    extern fn e_flag_timed_wait(p_flag: *Flag, p_abs_time: ?*glib.TimeVal) c_int;
    pub const timedWait = e_flag_timed_wait;

    /// Blocks until `flag` is set.  If `flag` is already set, the function returns
    /// immediately.
    extern fn e_flag_wait(p_flag: *Flag) void;
    pub const wait = e_flag_wait;

    /// Blocks until `flag` is set, or until the time specified by `end_time`.
    /// If `flag` is already set, the function returns immediately.  The return
    /// value indicates the state of `flag` after waiting.
    ///
    /// To easily calculate `end_time`, a combination of `glib.getMonotonicTime` and
    /// G_TIME_SPAN_SECOND macro.
    extern fn e_flag_wait_until(p_flag: *Flag, p_end_time: i64) c_int;
    pub const waitUntil = e_flag_wait_until;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FreeFormExpSymbol = extern struct {
    f_names: ?[*:0]const u8,
    f_hint: ?[*:0]const u8,
    f_build_sexp: ?edataserver.FreeFormExpBuildSexpFunc,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GDataQuery = opaque {
    /// Creates a new `edataserver.GDataQuery`. Free it with `edataserver.GDataQuery.unref`,
    /// when no longer needed.
    extern fn e_gdata_query_new() *edataserver.GDataQuery;
    pub const new = e_gdata_query_new;

    /// Gets current value of the completed max property, as a Unix
    /// date/time. When not set, returns -1. The optional `out_exists`
    /// can be used to see whether the property is set.
    extern fn e_gdata_query_get_completed_max(p_self: *GDataQuery, p_out_exists: ?*c_int) i64;
    pub const getCompletedMax = e_gdata_query_get_completed_max;

    /// Gets current value of the completed min property, as a Unix
    /// date/time. When not set, returns -1. The optional `out_exists`
    /// can be used to see whether the property is set.
    extern fn e_gdata_query_get_completed_min(p_self: *GDataQuery, p_out_exists: ?*c_int) i64;
    pub const getCompletedMin = e_gdata_query_get_completed_min;

    /// Gets current value of the due max property, as a Unix
    /// date/time. When not set, returns -1. The optional `out_exists`
    /// can be used to see whether the property is set.
    extern fn e_gdata_query_get_due_max(p_self: *GDataQuery, p_out_exists: ?*c_int) i64;
    pub const getDueMax = e_gdata_query_get_due_max;

    /// Gets current value of the due min property, as a Unix
    /// date/time. When not set, returns -1. The optional `out_exists`
    /// can be used to see whether the property is set.
    extern fn e_gdata_query_get_due_min(p_self: *GDataQuery, p_out_exists: ?*c_int) i64;
    pub const getDueMin = e_gdata_query_get_due_min;

    /// Gets current value of the max results property.
    /// When not set, returns 0. The optional `out_exists`
    /// can be used to see whether the property is set.
    extern fn e_gdata_query_get_max_results(p_self: *GDataQuery, p_out_exists: ?*c_int) c_int;
    pub const getMaxResults = e_gdata_query_get_max_results;

    /// Gets current value of the show completed property. When not set,
    /// returns `FALSE`. The optional `out_exists` can be used to see whether
    /// the property is set.
    extern fn e_gdata_query_get_show_completed(p_self: *GDataQuery, p_out_exists: ?*c_int) c_int;
    pub const getShowCompleted = e_gdata_query_get_show_completed;

    /// Gets current value of the show deleted property. When not set,
    /// returns `FALSE`. The optional `out_exists` can be used to see whether
    /// the property is set.
    extern fn e_gdata_query_get_show_deleted(p_self: *GDataQuery, p_out_exists: ?*c_int) c_int;
    pub const getShowDeleted = e_gdata_query_get_show_deleted;

    /// Gets current value of the show hidden property. When not set,
    /// returns `FALSE`. The optional `out_exists` can be used to see whether
    /// the property is set.
    extern fn e_gdata_query_get_show_hidden(p_self: *GDataQuery, p_out_exists: ?*c_int) c_int;
    pub const getShowHidden = e_gdata_query_get_show_hidden;

    /// Gets current value of the updated min property, as a Unix
    /// date/time. When not set, returns -1. The optional `out_exists`
    /// can be used to see whether the property is set.
    extern fn e_gdata_query_get_updated_min(p_self: *GDataQuery, p_out_exists: ?*c_int) i64;
    pub const getUpdatedMin = e_gdata_query_get_updated_min;

    /// Increases the reference count of the `self`.
    /// The added reference shuld be removed with `edataserver.GDataQuery.unref`.
    extern fn e_gdata_query_ref(p_self: *GDataQuery) *edataserver.GDataQuery;
    pub const ref = e_gdata_query_ref;

    /// Sets upper bound for a task's completion date, as a Unix date/time, to filter by.
    /// The default is not to filter by completion date.
    ///
    /// This can be used for Task object query only.
    extern fn e_gdata_query_set_completed_max(p_self: *GDataQuery, p_value: i64) void;
    pub const setCompletedMax = e_gdata_query_set_completed_max;

    /// Sets lower bound for a task's completion date, as a Unix date/time, to filter by.
    /// The default is not to filter by completion date.
    ///
    /// This can be used for Task object query only.
    extern fn e_gdata_query_set_completed_min(p_self: *GDataQuery, p_value: i64) void;
    pub const setCompletedMin = e_gdata_query_set_completed_min;

    /// Sets upper bound for a task's due date, as a Unix date/time, to filter by.
    /// The default is not to filter by due date.
    ///
    /// This can be used for Task object query only.
    extern fn e_gdata_query_set_due_max(p_self: *GDataQuery, p_value: i64) void;
    pub const setDueMax = e_gdata_query_set_due_max;

    /// Sets lower bound for a task's due date, as a Unix date/time, to filter by.
    /// The default is not to filter by due date.
    ///
    /// This can be used for Task object query only.
    extern fn e_gdata_query_set_due_min(p_self: *GDataQuery, p_value: i64) void;
    pub const setDueMin = e_gdata_query_set_due_min;

    /// Sets max results to be returned in one call.
    ///
    /// This can be used for any object query.
    extern fn e_gdata_query_set_max_results(p_self: *GDataQuery, p_value: c_int) void;
    pub const setMaxResults = e_gdata_query_set_max_results;

    /// Sets a flag indicating whether completed tasks are returned in the result.
    /// The default is True. Note that show hidden should also be True to show
    /// tasks completed in first party clients, such as the web UI and Google's
    /// mobile apps.
    ///
    /// This can be used for Task object query only.
    extern fn e_gdata_query_set_show_completed(p_self: *GDataQuery, p_value: c_int) void;
    pub const setShowCompleted = e_gdata_query_set_show_completed;

    /// Sets a flag indicating whether deleted tasks are returned in the result.
    /// The default is False.
    ///
    /// This can be used for Task object query only.
    extern fn e_gdata_query_set_show_deleted(p_self: *GDataQuery, p_value: c_int) void;
    pub const setShowDeleted = e_gdata_query_set_show_deleted;

    /// Sets a flag indicating whether hidden tasks are returned in the result.
    /// The default is False.
    ///
    /// This can be used for Task object query only.
    extern fn e_gdata_query_set_show_hidden(p_self: *GDataQuery, p_value: c_int) void;
    pub const setShowHidden = e_gdata_query_set_show_hidden;

    /// Sets lower bound for a task's last modification time, as a Unix date/time,
    /// to filter by. The default is not to filter by the last modification time.
    ///
    /// This can be used for Task object query only.
    extern fn e_gdata_query_set_updated_min(p_self: *GDataQuery, p_value: i64) void;
    pub const setUpdatedMin = e_gdata_query_set_updated_min;

    /// Converts the `self` into a string, which can be used as a URI query. The returned
    /// string should be freed with `glib.free`, when no longer needed.
    extern fn e_gdata_query_to_string(p_self: *GDataQuery) ?[*:0]u8;
    pub const toString = e_gdata_query_to_string;

    /// Decreases the reference count of the `self`. When the reference count
    /// reaches 0, the `self` is freed.
    extern fn e_gdata_query_unref(p_self: *GDataQuery) void;
    pub const unref = e_gdata_query_unref;

    extern fn e_gdata_query_get_type() usize;
    pub const getGObjectType = e_gdata_query_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GDataSessionClass = extern struct {
    pub const Instance = edataserver.GDataSession;

    f_parent_class: edataserver.SoupSessionClass,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *GDataSessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GDataSessionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MemChunk = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ModuleClass = extern struct {
    pub const Instance = edataserver.Module;

    f_parent_class: gobject.TypeModuleClass,

    pub fn as(p_instance: *ModuleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ModulePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MsOapxbcClass = extern struct {
    pub const Instance = edataserver.MsOapxbc;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *MsOapxbcClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NamedParameters = opaque {
    /// Creates a new instance of an `edataserver.NamedParameters`. This should be freed
    /// with `edataserver.NamedParameters.free`, when no longer needed. Names are
    /// compared case insensitively.
    ///
    /// The structure is not thread safe, if the caller requires thread safety,
    /// then it should provide it on its own.
    extern fn e_named_parameters_new() *edataserver.NamedParameters;
    pub const new = e_named_parameters_new;

    /// Creates a new instance of an `edataserver.NamedParameters`, with initial content being
    /// taken from `str`. This should be freed with `edataserver.NamedParameters.free`,
    /// when no longer needed. Names are compared case insensitively.
    ///
    /// The `str` should be created with `edataserver.NamedParameters.toString`, to be
    /// properly encoded.
    ///
    /// The structure is not thread safe, if the caller requires thread safety,
    /// then it should provide it on its own.
    extern fn e_named_parameters_new_string(p_str: [*:0]const u8) *edataserver.NamedParameters;
    pub const newString = e_named_parameters_new_string;

    /// Creates a new instance of an `edataserver.NamedParameters`, with initial content
    /// being taken from `strv`. This should be freed with `edataserver.NamedParameters.free`,
    /// when no longer needed. Names are compared case insensitively.
    ///
    /// The structure is not thread safe, if the caller requires thread safety,
    /// then it should provide it on its own.
    extern fn e_named_parameters_new_strv(p_strv: *const [*:0]const u8) *edataserver.NamedParameters;
    pub const newStrv = e_named_parameters_new_strv;

    /// Makes content of the `parameters` the same as `from`.
    /// Functions clears content of `parameters` if `from` is `NULL`.
    extern fn e_named_parameters_assign(p_parameters: *NamedParameters, p_from: ?*const edataserver.NamedParameters) void;
    pub const assign = e_named_parameters_assign;

    /// Removes all stored parameters from `parameters`.
    extern fn e_named_parameters_clear(p_parameters: *NamedParameters) void;
    pub const clear = e_named_parameters_clear;

    extern fn e_named_parameters_count(p_parameters: *const NamedParameters) c_uint;
    pub const count = e_named_parameters_count;

    /// Compares the two parameters objects and returns whether they equal.
    /// Note a `NULL` and empty parameters are also considered equal.
    extern fn e_named_parameters_equal(p_parameters1: *const NamedParameters, p_parameters2: *const edataserver.NamedParameters) c_int;
    pub const equal = e_named_parameters_equal;

    extern fn e_named_parameters_exists(p_parameters: *const NamedParameters, p_name: [*:0]const u8) c_int;
    pub const exists = e_named_parameters_exists;

    /// Frees an instance of `edataserver.NamedParameters`, previously allocated
    /// with `edataserver.NamedParameters.new`. Function does nothing, if
    /// `parameters` is `NULL`.
    extern fn e_named_parameters_free(p_parameters: ?*NamedParameters) void;
    pub const free = e_named_parameters_free;

    /// Returns current value of a parameter with name `name`. If not such
    /// exists, then returns `NULL`.
    extern fn e_named_parameters_get(p_parameters: *const NamedParameters, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const get = e_named_parameters_get;

    extern fn e_named_parameters_get_name(p_parameters: *const NamedParameters, p_index: c_int) ?[*:0]u8;
    pub const getName = e_named_parameters_get_name;

    /// Creates a new instance of an `edataserver.NamedParameters`, with initial content
    /// being taken from `parameters`. This should be freed with `edataserver.NamedParameters.free`,
    /// when no longer needed. Names are compared case insensitively.
    ///
    /// The structure is not thread safe, if the caller requires thread safety,
    /// then it should provide it on its own.
    extern fn e_named_parameters_new_clone(p_parameters: *const NamedParameters) *edataserver.NamedParameters;
    pub const newClone = e_named_parameters_new_clone;

    /// Sets parameter named `name` to value `value`. If `value` is NULL,
    /// then the parameter is removed. `value` can be an empty string.
    ///
    /// Note: There is a restriction on parameter names, it cannot be empty or
    /// contain a colon character (':'), otherwise it can be pretty much anything.
    extern fn e_named_parameters_set(p_parameters: *NamedParameters, p_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
    pub const set = e_named_parameters_set;

    /// Compares current value of parameter named `name` with given `value`
    /// and returns whether they are equal, either case sensitively or
    /// insensitively, based on `case_sensitively` argument. Function
    /// returns `FALSE`, if no such parameter exists.
    extern fn e_named_parameters_test(p_parameters: *const NamedParameters, p_name: [*:0]const u8, p_value: [*:0]const u8, p_case_sensitively: c_int) c_int;
    pub const @"test" = e_named_parameters_test;

    extern fn e_named_parameters_to_string(p_parameters: *const NamedParameters) ?[*:0]u8;
    pub const toString = e_named_parameters_to_string;

    extern fn e_named_parameters_to_strv(p_parameters: *const NamedParameters) [*][*:0]u8;
    pub const toStrv = e_named_parameters_to_strv;

    extern fn e_named_parameters_get_type() usize;
    pub const getGObjectType = e_named_parameters_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NetworkMonitorClass = extern struct {
    pub const Instance = edataserver.NetworkMonitor;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *NetworkMonitorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NetworkMonitorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceBaseClass = extern struct {
    pub const Instance = edataserver.OAuth2ServiceBase;

    f_parent_class: edataserver.ExtensionClass,

    pub fn as(p_instance: *OAuth2ServiceBaseClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceGoogleClass = extern struct {
    pub const Instance = edataserver.OAuth2ServiceGoogle;

    f_parent_class: edataserver.OAuth2ServiceBaseClass,

    pub fn as(p_instance: *OAuth2ServiceGoogleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceInterface = extern struct {
    pub const Instance = edataserver.OAuth2Service;

    f_parent_interface: gobject.TypeInterface,
    f_can_process: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source) callconv(.c) c_int,
    f_guess_can_process: ?*const fn (p_service: *edataserver.OAuth2Service, p_protocol: ?[*:0]const u8, p_hostname: ?[*:0]const u8) callconv(.c) c_int,
    f_get_flags: ?*const fn (p_service: *edataserver.OAuth2Service) callconv(.c) u32,
    f_get_name: ?*const fn (p_service: *edataserver.OAuth2Service) callconv(.c) [*:0]const u8,
    f_get_display_name: ?*const fn (p_service: *edataserver.OAuth2Service) callconv(.c) [*:0]const u8,
    f_get_client_id: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source) callconv(.c) [*:0]const u8,
    f_get_client_secret: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source) callconv(.c) ?[*:0]const u8,
    f_get_authentication_uri: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source) callconv(.c) [*:0]const u8,
    f_get_refresh_uri: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source) callconv(.c) [*:0]const u8,
    f_get_redirect_uri: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source) callconv(.c) ?[*:0]const u8,
    f_prepare_authentication_uri_query: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_uri_query: *glib.HashTable) callconv(.c) void,
    f_get_authentication_policy: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_uri: [*:0]const u8) callconv(.c) edataserver.OAuth2ServiceNavigationPolicy,
    f_extract_authorization_code: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_page_title: [*:0]const u8, p_page_uri: [*:0]const u8, p_page_content: ?[*:0]const u8, p_out_authorization_code: *[*:0]u8) callconv(.c) c_int,
    f_prepare_get_token_form: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_authorization_code: [*:0]const u8, p_form: *glib.HashTable) callconv(.c) void,
    f_prepare_get_token_message: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_message: *soup.Message) callconv(.c) void,
    f_prepare_refresh_token_form: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_refresh_token: [*:0]const u8, p_form: *glib.HashTable) callconv(.c) void,
    f_prepare_refresh_token_message: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_message: *soup.Message) callconv(.c) void,
    f_extract_error_message: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_page_title: [*:0]const u8, p_page_uri: [*:0]const u8, p_page_content: ?[*:0]const u8, p_out_error_message: *[*:0]u8) callconv(.c) c_int,
    f_dup_credentials_prompter_cookies_sync: ?*const fn (p_service: *edataserver.OAuth2Service, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable) callconv(.c) ?*glib.SList,
    f_reserved: [8]*anyopaque,

    pub fn as(p_instance: *OAuth2ServiceInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceOutlookClass = extern struct {
    pub const Instance = edataserver.OAuth2ServiceOutlook;

    f_parent_class: edataserver.OAuth2ServiceBaseClass,

    pub fn as(p_instance: *OAuth2ServiceOutlookClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServiceYahooClass = extern struct {
    pub const Instance = edataserver.OAuth2ServiceYahoo;

    f_parent_class: edataserver.OAuth2ServiceBaseClass,

    pub fn as(p_instance: *OAuth2ServiceYahooClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServicesClass = extern struct {
    pub const Instance = edataserver.OAuth2Services;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *OAuth2ServicesClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2ServicesPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const OperationPool = opaque {
    extern fn e_operation_pool_new(p_max_threads: c_uint, p_thread_func: glib.Func, p_user_data: ?*anyopaque) *edataserver.OperationPool;
    pub const new = e_operation_pool_new;

    /// Frees previously created `pool`.
    extern fn e_operation_pool_free(p_pool: *OperationPool) void;
    pub const free = e_operation_pool_free;

    /// Pushes an operation to be processed.  `opdata` is passed to the function
    /// provided in `edataserver.operationPoolNew`.
    extern fn e_operation_pool_push(p_pool: *OperationPool, p_opdata: ?*anyopaque) void;
    pub const push = e_operation_pool_push;

    /// Releases `opid` previously reserved by `edataserver.OperationPool.reserveOpid`.
    extern fn e_operation_pool_release_opid(p_pool: *OperationPool, p_opid: u32) void;
    pub const releaseOpid = e_operation_pool_release_opid;

    /// Reserves new operation ID, which is returned. This operation ID may
    /// be released by `edataserver.OperationPool.releaseOpid` when the operation
    /// is finished.
    extern fn e_operation_pool_reserve_opid(p_pool: *OperationPool) u32;
    pub const reserveOpid = e_operation_pool_reserve_opid;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SoupAuthBearerClass = extern struct {
    pub const Instance = edataserver.SoupAuthBearer;

    f_parent_class: soup.AuthClass,

    pub fn as(p_instance: *SoupAuthBearerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SoupAuthBearerPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SoupSessionClass = extern struct {
    pub const Instance = edataserver.SoupSession;

    f_parent_class: soup.SessionClass,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *SoupSessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SoupSessionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAddressBookClass = extern struct {
    pub const Instance = edataserver.SourceAddressBook;

    f_parent_class: edataserver.SourceBackendClass,

    pub fn as(p_instance: *SourceAddressBookClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAddressBookPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAlarmsClass = extern struct {
    pub const Instance = edataserver.SourceAlarms;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceAlarmsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAlarmsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAuthenticationClass = extern struct {
    pub const Instance = edataserver.SourceAuthentication;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceAuthenticationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAuthenticationPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAutocompleteClass = extern struct {
    pub const Instance = edataserver.SourceAutocomplete;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceAutocompleteClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAutocompletePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAutoconfigClass = extern struct {
    pub const Instance = edataserver.SourceAutoconfig;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceAutoconfigClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceAutoconfigPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceBackendClass = extern struct {
    pub const Instance = edataserver.SourceBackend;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceBackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceBackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCalendarClass = extern struct {
    pub const Instance = edataserver.SourceCalendar;

    f_parent_class: edataserver.SourceSelectableClass,

    pub fn as(p_instance: *SourceCalendarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCalendarPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCamelClass = extern struct {
    pub const Instance = edataserver.SourceCamel;

    f_parent_class: edataserver.SourceExtensionClass,
    f_settings_type: usize,

    pub fn as(p_instance: *SourceCamelClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCamelPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceClass = extern struct {
    pub const Instance = edataserver.Source;

    f_parent_class: gobject.ObjectClass,
    f_changed: ?*const fn (p_source: *edataserver.Source) callconv(.c) void,
    f_credentials_required: ?*const fn (p_source: *edataserver.Source, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: *const glib.Error) callconv(.c) void,
    f_authenticate: ?*const fn (p_source: *edataserver.Source, p_credentials: *const edataserver.NamedParameters) callconv(.c) void,
    f_remove_sync: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remove: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_remove_finish: ?*const fn (p_source: *edataserver.Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_write_sync: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_write: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_write_finish: ?*const fn (p_source: *edataserver.Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remote_create_sync: ?*const fn (p_source: *edataserver.Source, p_scratch_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remote_create: ?*const fn (p_source: *edataserver.Source, p_scratch_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_remote_create_finish: ?*const fn (p_source: *edataserver.Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remote_delete_sync: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remote_delete: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_remote_delete_finish: ?*const fn (p_source: *edataserver.Source, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_oauth2_access_token_sync: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_oauth2_access_token: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_get_oauth2_access_token_finish: ?*const fn (p_source: *edataserver.Source, p_result: *gio.AsyncResult, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_invoke_credentials_required_impl: ?*const fn (p_source: *edataserver.Source, p_dbus_source: ?*anyopaque, p_arg_reason: [*:0]const u8, p_arg_certificate_pem: [*:0]const u8, p_arg_certificate_errors: [*:0]const u8, p_arg_dbus_error_name: [*:0]const u8, p_arg_dbus_error_message: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_invoke_authenticate_impl: ?*const fn (p_source: *edataserver.Source, p_dbus_source: ?*anyopaque, p_arg_credentials: *const [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_unset_last_credentials_required_arguments_impl: ?*const fn (p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved: [6]*anyopaque,

    pub fn as(p_instance: *SourceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCollectionClass = extern struct {
    pub const Instance = edataserver.SourceCollection;

    f_parent_class: edataserver.SourceBackendClass,

    pub fn as(p_instance: *SourceCollectionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCollectionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceContactsClass = extern struct {
    pub const Instance = edataserver.SourceContacts;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceContactsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceContactsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCredentialsProviderClass = extern struct {
    pub const Instance = edataserver.SourceCredentialsProvider;

    f_parent_class: gobject.ObjectClass,
    f_ref_source: ?*const fn (p_provider: *edataserver.SourceCredentialsProvider, p_uid: [*:0]const u8) callconv(.c) ?*edataserver.Source,

    pub fn as(p_instance: *SourceCredentialsProviderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCredentialsProviderImplClass = extern struct {
    pub const Instance = edataserver.SourceCredentialsProviderImpl;

    f_parent_class: edataserver.ExtensionClass,
    f_can_process: ?*const fn (p_provider_impl: *edataserver.SourceCredentialsProviderImpl, p_source: *edataserver.Source) callconv(.c) c_int,
    f_can_store: ?*const fn (p_provider_impl: *edataserver.SourceCredentialsProviderImpl) callconv(.c) c_int,
    f_can_prompt: ?*const fn (p_provider_impl: *edataserver.SourceCredentialsProviderImpl) callconv(.c) c_int,
    f_lookup_sync: ?*const fn (p_provider_impl: *edataserver.SourceCredentialsProviderImpl, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_credentials: **edataserver.NamedParameters, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_store_sync: ?*const fn (p_provider_impl: *edataserver.SourceCredentialsProviderImpl, p_source: *edataserver.Source, p_credentials: *const edataserver.NamedParameters, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_delete_sync: ?*const fn (p_provider_impl: *edataserver.SourceCredentialsProviderImpl, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,

    pub fn as(p_instance: *SourceCredentialsProviderImplClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCredentialsProviderImplOAuth2Class = extern struct {
    pub const Instance = edataserver.SourceCredentialsProviderImplOAuth2;

    f_parent_class: edataserver.SourceCredentialsProviderImplClass,

    pub fn as(p_instance: *SourceCredentialsProviderImplOAuth2Class, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCredentialsProviderImplOAuth2Private = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCredentialsProviderImplPasswordClass = extern struct {
    pub const Instance = edataserver.SourceCredentialsProviderImplPassword;

    f_parent_class: edataserver.SourceCredentialsProviderImplClass,

    pub fn as(p_instance: *SourceCredentialsProviderImplPasswordClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCredentialsProviderImplPasswordPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCredentialsProviderImplPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceCredentialsProviderPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceExtensionClass = extern struct {
    pub const Instance = edataserver.SourceExtension;

    f_parent_class: gobject.ObjectClass,
    f_name: ?[*:0]const u8,

    pub fn as(p_instance: *SourceExtensionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceExtensionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceGoaClass = extern struct {
    pub const Instance = edataserver.SourceGoa;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceGoaClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceGoaPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceLDAPClass = extern struct {
    pub const Instance = edataserver.SourceLDAP;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceLDAPClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceLDAPPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceLocalClass = extern struct {
    pub const Instance = edataserver.SourceLocal;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceLocalClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceLocalPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMDNClass = extern struct {
    pub const Instance = edataserver.SourceMDN;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceMDNClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMDNPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailAccountClass = extern struct {
    pub const Instance = edataserver.SourceMailAccount;

    f_parent_class: edataserver.SourceBackendClass,

    pub fn as(p_instance: *SourceMailAccountClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailAccountPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailCompositionClass = extern struct {
    pub const Instance = edataserver.SourceMailComposition;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceMailCompositionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailCompositionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailIdentityClass = extern struct {
    pub const Instance = edataserver.SourceMailIdentity;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceMailIdentityClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailIdentityPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailSignatureClass = extern struct {
    pub const Instance = edataserver.SourceMailSignature;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceMailSignatureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailSignaturePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailSubmissionClass = extern struct {
    pub const Instance = edataserver.SourceMailSubmission;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceMailSubmissionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailSubmissionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailTransportClass = extern struct {
    pub const Instance = edataserver.SourceMailTransport;

    f_parent_class: edataserver.SourceBackendClass,

    pub fn as(p_instance: *SourceMailTransportClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMailTransportPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMemoListClass = extern struct {
    pub const Instance = edataserver.SourceMemoList;

    f_parent_class: edataserver.SourceSelectableClass,

    pub fn as(p_instance: *SourceMemoListClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceMemoListPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceOfflineClass = extern struct {
    pub const Instance = edataserver.SourceOffline;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceOfflineClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceOfflinePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceOpenPGPClass = extern struct {
    pub const Instance = edataserver.SourceOpenPGP;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceOpenPGPClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceOpenPGPPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourcePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceProxyClass = extern struct {
    pub const Instance = edataserver.SourceProxy;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceProxyClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceProxyPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRefreshClass = extern struct {
    pub const Instance = edataserver.SourceRefresh;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceRefreshClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRefreshPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRegistryClass = extern struct {
    pub const Instance = edataserver.SourceRegistry;

    f_parent_class: gobject.ObjectClass,
    f_source_added: ?*const fn (p_registry: *edataserver.SourceRegistry, p_source: *edataserver.Source) callconv(.c) void,
    f_source_changed: ?*const fn (p_registry: *edataserver.SourceRegistry, p_source: *edataserver.Source) callconv(.c) void,
    f_source_removed: ?*const fn (p_registry: *edataserver.SourceRegistry, p_source: *edataserver.Source) callconv(.c) void,
    f_source_enabled: ?*const fn (p_registry: *edataserver.SourceRegistry, p_source: *edataserver.Source) callconv(.c) void,
    f_source_disabled: ?*const fn (p_registry: *edataserver.SourceRegistry, p_source: *edataserver.Source) callconv(.c) void,
    f_credentials_required: ?*const fn (p_registry: *edataserver.SourceRegistry, p_source: *edataserver.Source, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: *const glib.Error) callconv(.c) void,

    pub fn as(p_instance: *SourceRegistryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRegistryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRegistryWatcherClass = extern struct {
    pub const Instance = edataserver.SourceRegistryWatcher;

    f_parent_class: gobject.ObjectClass,
    f_filter: ?*const fn (p_watcher: *edataserver.SourceRegistryWatcher, p_source: *edataserver.Source) callconv(.c) c_int,
    f_appeared: ?*const fn (p_watcher: *edataserver.SourceRegistryWatcher, p_source: *edataserver.Source) callconv(.c) void,
    f_disappeared: ?*const fn (p_watcher: *edataserver.SourceRegistryWatcher, p_source: *edataserver.Source) callconv(.c) void,

    pub fn as(p_instance: *SourceRegistryWatcherClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRegistryWatcherPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceResourceClass = extern struct {
    pub const Instance = edataserver.SourceResource;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceResourceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceResourcePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRevisionGuardsClass = extern struct {
    pub const Instance = edataserver.SourceRevisionGuards;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceRevisionGuardsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRevisionGuardsPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceSMIMEClass = extern struct {
    pub const Instance = edataserver.SourceSMIME;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceSMIMEClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceSMIMEPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceSecurityClass = extern struct {
    pub const Instance = edataserver.SourceSecurity;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceSecurityClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceSecurityPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceSelectableClass = extern struct {
    pub const Instance = edataserver.SourceSelectable;

    f_parent_class: edataserver.SourceBackendClass,

    pub fn as(p_instance: *SourceSelectableClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceSelectablePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceTaskListClass = extern struct {
    pub const Instance = edataserver.SourceTaskList;

    f_parent_class: edataserver.SourceSelectableClass,

    pub fn as(p_instance: *SourceTaskListClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceTaskListPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceUoaClass = extern struct {
    pub const Instance = edataserver.SourceUoa;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceUoaClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceUoaPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceWeatherClass = extern struct {
    pub const Instance = edataserver.SourceWeather;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceWeatherClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceWeatherPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceWebDAVNotesClass = extern struct {
    pub const Instance = edataserver.SourceWebDAVNotes;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceWebDAVNotesClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceWebDAVNotesPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceWebdavClass = extern struct {
    pub const Instance = edataserver.SourceWebdav;

    f_parent_class: edataserver.SourceExtensionClass,

    pub fn as(p_instance: *SourceWebdavClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceWebdavPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVAccessControlEntry = extern struct {
    f_principal_kind: edataserver.WebDAVACEPrincipalKind,
    f_principal_href: ?[*:0]u8,
    f_flags: u32,
    f_inherited_href: ?[*:0]u8,
    f_privileges: ?*glib.SList,

    /// Frees an `edataserver.WebDAVAccessControlEntry` previously created with `edataserver.WebDAVAccessControlEntry.new`
    /// or `edataserver.WebDAVAccessControlEntry.copy`. The function does nothing, if `ptr` is `NULL`.
    extern fn e_webdav_access_control_entry_free(p_ptr: ?*anyopaque) void;
    pub const free = e_webdav_access_control_entry_free;

    /// Describes one Access Control Entry (ACE).
    ///
    /// The `flags` should always contain either `E_WEBDAV_ACE_FLAG_GRANT` or
    /// `E_WEBDAV_ACE_FLAG_DENY` value.
    ///
    /// Use `edataserver.WebDAVAccessControlEntry.appendPrivilege` to add respective
    /// privileges to the entry.
    extern fn e_webdav_access_control_entry_new(p_principal_kind: edataserver.WebDAVACEPrincipalKind, p_principal_href: ?[*:0]const u8, p_flags: u32, p_inherited_href: ?[*:0]const u8) *edataserver.WebDAVAccessControlEntry;
    pub const new = e_webdav_access_control_entry_new;

    /// Appends a new `privilege` to the list of privileges for the `ace`.
    /// The function assumes ownership of the `privilege`, which is freed
    /// together with the `ace`.
    extern fn e_webdav_access_control_entry_append_privilege(p_ace: *WebDAVAccessControlEntry, p_privilege: *edataserver.WebDAVPrivilege) void;
    pub const appendPrivilege = e_webdav_access_control_entry_append_privilege;

    extern fn e_webdav_access_control_entry_copy(p_src: ?*const WebDAVAccessControlEntry) ?*edataserver.WebDAVAccessControlEntry;
    pub const copy = e_webdav_access_control_entry_copy;

    extern fn e_webdav_access_control_entry_get_privileges(p_ace: *WebDAVAccessControlEntry) *glib.SList;
    pub const getPrivileges = e_webdav_access_control_entry_get_privileges;

    extern fn e_webdav_access_control_entry_get_type() usize;
    pub const getGObjectType = e_webdav_access_control_entry_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVDiscoveredSource = extern struct {
    f_href: ?[*:0]u8,
    f_supports: u32,
    f_display_name: ?[*:0]u8,
    f_description: ?[*:0]u8,
    f_color: ?[*:0]u8,
    f_order: c_uint,

    /// Copies the given EWebDAVDiscoveredSource.
    extern fn e_webdav_discovered_source_copy(p_discovered_source: *WebDAVDiscoveredSource) *edataserver.WebDAVDiscoveredSource;
    pub const copy = e_webdav_discovered_source_copy;

    /// Frees the `discovered_source`. Function does nothing, when it's `NULL`.
    extern fn e_webdav_discovered_source_free(p_discovered_source: ?*WebDAVDiscoveredSource) void;
    pub const free = e_webdav_discovered_source_free;

    extern fn e_webdav_discovered_source_get_type() usize;
    pub const getGObjectType = e_webdav_discovered_source_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVPrivilege = extern struct {
    f_ns_uri: ?[*:0]u8,
    f_name: ?[*:0]u8,
    f_description: ?[*:0]u8,
    f_kind: edataserver.WebDAVPrivilegeKind,
    f_hint: edataserver.WebDAVPrivilegeHint,

    /// Frees an `edataserver.WebDAVPrivilege` previously created with `edataserver.WebDAVPrivilege.new`
    /// or `edataserver.WebDAVPrivilege.copy`. The function does nothing, if `ptr` is `NULL`.
    extern fn e_webdav_privilege_free(p_ptr: ?*anyopaque) void;
    pub const free = e_webdav_privilege_free;

    /// Describes one privilege entry. The `hint` can be `E_WEBDAV_PRIVILEGE_HINT_UNKNOWN`
    /// for privileges which are not known to the `edataserver.WebDAVSession`. It's possible, because
    /// the servers can define their own privileges. The hint is also tried to pair with
    /// known hints when it's `E_WEBDAV_PRIVILEGE_HINT_UNKNOWN`.
    ///
    /// The `ns_uri` and `name` can be `NULL` only if the `hint` is one of the known
    /// privileges. Otherwise it's an error to pass either of the two as `NULL`.
    extern fn e_webdav_privilege_new(p_ns_uri: ?[*:0]const u8, p_name: ?[*:0]const u8, p_description: ?[*:0]const u8, p_kind: edataserver.WebDAVPrivilegeKind, p_hint: edataserver.WebDAVPrivilegeHint) *edataserver.WebDAVPrivilege;
    pub const new = e_webdav_privilege_new;

    extern fn e_webdav_privilege_copy(p_src: ?*const WebDAVPrivilege) ?*edataserver.WebDAVPrivilege;
    pub const copy = e_webdav_privilege_copy;

    extern fn e_webdav_privilege_get_type() usize;
    pub const getGObjectType = e_webdav_privilege_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVPropertyChange = extern struct {
    f_kind: edataserver.WebDAVPropertyChangeKind,
    f_ns_uri: ?[*:0]u8,
    f_name: ?[*:0]u8,
    f_value: ?[*:0]u8,

    /// Frees an `edataserver.WebDAVPropertyChange` previously created with `edataserver.WebDAVPropertyChange.newSet`,
    /// `edataserver.WebDAVPropertyChange.newRemove` or or `edataserver.WebDAVPropertyChange.copy`.
    /// The function does nothing, if `ptr` is `NULL`.
    extern fn e_webdav_property_change_free(p_ptr: ?*anyopaque) void;
    pub const free = e_webdav_property_change_free;

    /// Creates a new `edataserver.WebDAVPropertyChange` of kind `E_WEBDAV_PROPERTY_REMOVE`,
    /// which is used to remove the given property. To change property value
    /// use `edataserver.WebDAVPropertyChange.newSet` instead.
    extern fn e_webdav_property_change_new_remove(p_ns_uri: [*:0]const u8, p_name: [*:0]const u8) *edataserver.WebDAVPropertyChange;
    pub const newRemove = e_webdav_property_change_new_remove;

    /// Creates a new `edataserver.WebDAVPropertyChange` of kind `E_WEBDAV_PROPERTY_SET`,
    /// which is used to modify or set the property value. The `value` is a string
    /// representation of the value to store. It can be `NULL`, but it means
    /// an empty value, not to remove it. To remove property use
    /// `edataserver.WebDAVPropertyChange.newRemove` instead.
    extern fn e_webdav_property_change_new_set(p_ns_uri: [*:0]const u8, p_name: [*:0]const u8, p_value: ?[*:0]const u8) *edataserver.WebDAVPropertyChange;
    pub const newSet = e_webdav_property_change_new_set;

    extern fn e_webdav_property_change_copy(p_src: ?*const WebDAVPropertyChange) ?*edataserver.WebDAVPropertyChange;
    pub const copy = e_webdav_property_change_copy;

    extern fn e_webdav_property_change_get_type() usize;
    pub const getGObjectType = e_webdav_property_change_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVResource = extern struct {
    f_kind: edataserver.WebDAVResourceKind,
    f_supports: u32,
    f_href: ?[*:0]u8,
    f_etag: ?[*:0]u8,
    f_display_name: ?[*:0]u8,
    f_content_type: ?[*:0]u8,
    f_content_length: usize,
    f_creation_date: c_long,
    f_last_modified: c_long,
    f_description: ?[*:0]u8,
    f_color: ?[*:0]u8,
    f_order: c_uint,

    /// Frees an `edataserver.WebDAVResource` previously created with `edataserver.WebDAVResource.new`
    /// or `edataserver.WebDAVResource.copy`. The function does nothing, if `ptr` is `NULL`.
    extern fn e_webdav_resource_free(p_ptr: ?*anyopaque) void;
    pub const free = e_webdav_resource_free;

    /// Some values of the resource are not always valid, depending on the `kind`,
    /// but also whether server stores such values and whether it had been asked
    /// for them to be fetched.
    ///
    /// The `etag` for `E_WEBDAV_RESOURCE_KIND_COLLECTION` can be a change tag instead.
    extern fn e_webdav_resource_new(p_kind: edataserver.WebDAVResourceKind, p_supports: u32, p_href: [*:0]const u8, p_etag: ?[*:0]const u8, p_display_name: ?[*:0]const u8, p_content_type: ?[*:0]const u8, p_content_length: usize, p_creation_date: c_long, p_last_modified: c_long, p_description: ?[*:0]const u8, p_color: ?[*:0]const u8, p_order: c_uint) *edataserver.WebDAVResource;
    pub const new = e_webdav_resource_new;

    extern fn e_webdav_resource_copy(p_src: ?*const WebDAVResource) ?*edataserver.WebDAVResource;
    pub const copy = e_webdav_resource_copy;

    extern fn e_webdav_resource_get_type() usize;
    pub const getGObjectType = e_webdav_resource_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVSessionClass = extern struct {
    pub const Instance = edataserver.WebDAVSession;

    f_parent_class: edataserver.SoupSessionClass,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *WebDAVSessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVSessionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XmlDocumentClass = extern struct {
    pub const Instance = edataserver.XmlDocument;

    f_parent_class: gobject.ObjectClass,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *XmlDocumentClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XmlDocumentPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A hash table representation of an XML file.
pub const XmlHash = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error codes for `edataserver.Client` operations.
pub const ClientError = enum(c_int) {
    invalid_arg = 0,
    busy = 1,
    source_not_loaded = 2,
    source_already_loaded = 3,
    authentication_failed = 4,
    authentication_required = 5,
    repository_offline = 6,
    offline_unavailable = 7,
    permission_denied = 8,
    cancelled = 9,
    could_not_cancel = 10,
    not_supported = 11,
    tls_not_available = 12,
    unsupported_authentication_method = 13,
    search_size_limit_exceeded = 14,
    search_time_limit_exceeded = 15,
    invalid_query = 16,
    query_refused = 17,
    dbus_error = 18,
    other_error = 19,
    not_opened = 20,
    out_of_sync = 21,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Errors from the `E_COLLATOR_ERROR` domain.
pub const CollatorError = enum(c_int) {
    open = 0,
    conversion = 1,
    invalid_locale = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines what to do when a conflict between the locally stored and
/// remotely stored object versions happen during object modify or remove.
pub const ConflictResolution = enum(c_int) {
    fail = 0,
    use_newer = 1,
    keep_server = 2,
    keep_local = 3,
    write_copy = 4,
    _,

    extern fn e_conflict_resolution_get_type() usize;
    pub const getGObjectType = e_conflict_resolution_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Holds status of a task.
pub const GDataTaskStatus = enum(c_int) {
    unknown = 0,
    needs_action = 1,
    completed = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Policy for responding to Message Disposition Notification requests
/// (i.e. a Disposition-Notification-To header) when receiving messages.
/// See RFC 2298 for more information about MDN requests.
pub const MdnResponsePolicy = enum(c_int) {
    never = 0,
    always = 1,
    ask = 2,
    _,

    extern fn e_mdn_response_policy_get_type() usize;
    pub const getGObjectType = e_mdn_response_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A value used during querying authentication URI, to decide whether certain
/// resource can be used or not. The `E_OAUTH2_SERVICE_NAVIGATION_POLICY_ABORT`
/// can be used to abort the authentication query, like when user cancelled it.
pub const OAuth2ServiceNavigationPolicy = enum(c_int) {
    deny = 0,
    allow = 1,
    abort = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Network proxy configuration methods.
pub const ProxyMethod = enum(c_int) {
    default = 0,
    manual = 1,
    auto = 2,
    none = 3,
    _,

    extern fn e_proxy_method_get_type() usize;
    pub const getGObjectType = e_proxy_method_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Status codes used by the `EBackend` authentication wrapper.
pub const SourceAuthenticationResult = enum(c_int) {
    unknown = -1,
    @"error" = 0,
    error_ssl_failed = 1,
    accepted = 2,
    rejected = 3,
    required = 4,
    _,

    extern fn e_source_authentication_result_get_type() usize;
    pub const getGObjectType = e_source_authentication_result_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Connection status codes used by the `edataserver.Source` to indicate its connection state.
/// This is used in combination with authentication of the ESource. For example,
/// if there are multiple clients asking for a password and a user enters the password
/// in one of them, then the status will change into 'connecting', which is a signal
/// do close the password prompt in the other client, because the credentials had
/// been already provided.
pub const SourceConnectionStatus = enum(c_int) {
    disconnected = 0,
    awaiting_credentials = 1,
    ssl_failed = 2,
    connecting = 3,
    connected = 4,
    _,

    extern fn e_source_connection_status_get_type() usize;
    pub const getGObjectType = e_source_connection_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An ESource's authentication reason, used by an ESource::CredentialsRequired method.
pub const SourceCredentialsReason = enum(c_int) {
    unknown = 0,
    required = 1,
    rejected = 2,
    ssl_failed = 3,
    @"error" = 4,
    _,

    extern fn e_source_credentials_reason_get_type() usize;
    pub const getGObjectType = e_source_credentials_reason_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines authentication types for LDAP sources.
pub const SourceLDAPAuthentication = enum(c_int) {
    none = 0,
    email = 1,
    binddn = 2,
    _,

    extern fn e_source_ldap_authentication_get_type() usize;
    pub const getGObjectType = e_source_ldap_authentication_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines search scope for LDAP sources.
pub const SourceLDAPScope = enum(c_int) {
    onelevel = 0,
    subtree = 1,
    _,

    extern fn e_source_ldap_scope_get_type() usize;
    pub const getGObjectType = e_source_ldap_scope_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines what connection security should be used for LDAP sources.
pub const SourceLDAPSecurity = enum(c_int) {
    none = 0,
    ldaps = 1,
    starttls = 2,
    _,

    extern fn e_source_ldap_security_get_type() usize;
    pub const getGObjectType = e_source_ldap_security_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Set of preferred reply styles for an `edataserver.SourceMailComposition` extension.
pub const SourceMailCompositionReplyStyle = enum(c_int) {
    default = 0,
    quoted = 1,
    do_not_quote = 2,
    attach = 3,
    outlook = 4,
    _,

    extern fn e_source_mail_composition_reply_style_get_type() usize;
    pub const getGObjectType = e_source_mail_composition_reply_style_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Units to be used in an `edataserver.SourceWeather` extension.
pub const SourceWeatherUnits = enum(c_int) {
    fahrenheit = 0,
    centigrade = 1,
    kelvin = 2,
    _,

    extern fn e_source_weather_units_get_type() usize;
    pub const getGObjectType = e_source_weather_units_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a three-state value, which can be either Off, On or Inconsistent.
pub const ThreeState = enum(c_int) {
    off = 0,
    on = 1,
    inconsistent = 2,
    _,

    extern fn e_three_state_get_type() usize;
    pub const getGObjectType = e_three_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TimeParseStatus = enum(c_int) {
    ok = 0,
    none = 1,
    invalid = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Response codes for the trust prompt.
pub const TrustPromptResponse = enum(c_int) {
    unknown = -1,
    reject = 0,
    accept = 1,
    accept_temporarily = 2,
    reject_temporarily = 3,
    _,

    extern fn e_trust_prompt_response_get_type() usize;
    pub const getGObjectType = e_trust_prompt_response_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVACEPrincipalKind = enum(c_int) {
    unknown = 0,
    href = 1,
    all = 2,
    authenticated = 3,
    unauthenticated = 4,
    property = 5,
    self = 6,
    owner = 7,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVLockScope = enum(c_int) {
    exclusive = 0,
    shared = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVPrivilegeHint = enum(c_int) {
    unknown = 0,
    read = 1,
    write = 2,
    write_properties = 3,
    write_content = 4,
    unlock = 5,
    read_acl = 6,
    write_acl = 7,
    read_current_user_privilege_set = 8,
    bind = 9,
    unbind = 10,
    all = 11,
    caldav_read_free_busy = 12,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVPrivilegeKind = enum(c_int) {
    unknown = 0,
    abstract = 1,
    aggregate = 2,
    common = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVPropertyChangeKind = enum(c_int) {
    set = 0,
    remove = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVResourceKind = enum(c_int) {
    unknown = 0,
    addressbook = 1,
    calendar = 2,
    principal = 3,
    collection = 4,
    resource = 5,
    subscribed_icalendar = 6,
    webdav_notes = 7,
    schedule_inbox = 8,
    schedule_outbox = 9,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XmlHashStatus = enum(c_int) {
    same = 0,
    different = 1,
    not_found = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XmlHashType = enum(c_int) {
    object_uid = 0,
    property = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags of the OAuth2 service.
pub const OAuth2ServiceFlags = packed struct(c_uint) {
    _padding0: bool = false,
    extract_requires_page_content: bool = false,
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

    pub const flags_none: OAuth2ServiceFlags = @bitCast(@as(c_uint, 0));
    pub const flags_extract_requires_page_content: OAuth2ServiceFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVACEFlag = packed struct(c_uint) {
    grant: bool = false,
    deny: bool = false,
    invert: bool = false,
    protected: bool = false,
    inherited: bool = false,
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

    pub const flags_unknown: WebDAVACEFlag = @bitCast(@as(c_uint, 0));
    pub const flags_grant: WebDAVACEFlag = @bitCast(@as(c_uint, 1));
    pub const flags_deny: WebDAVACEFlag = @bitCast(@as(c_uint, 2));
    pub const flags_invert: WebDAVACEFlag = @bitCast(@as(c_uint, 4));
    pub const flags_protected: WebDAVACEFlag = @bitCast(@as(c_uint, 8));
    pub const flags_inherited: WebDAVACEFlag = @bitCast(@as(c_uint, 16));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVACLRestrictions = packed struct(c_uint) {
    grant_only: bool = false,
    no_invert: bool = false,
    deny_before_grant: bool = false,
    required_principal: bool = false,
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

    pub const flags_none: WebDAVACLRestrictions = @bitCast(@as(c_uint, 0));
    pub const flags_grant_only: WebDAVACLRestrictions = @bitCast(@as(c_uint, 1));
    pub const flags_no_invert: WebDAVACLRestrictions = @bitCast(@as(c_uint, 2));
    pub const flags_deny_before_grant: WebDAVACLRestrictions = @bitCast(@as(c_uint, 4));
    pub const flags_required_principal: WebDAVACLRestrictions = @bitCast(@as(c_uint, 8));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVDiscoverSupports = packed struct(c_uint) {
    contacts: bool = false,
    events: bool = false,
    memos: bool = false,
    tasks: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    webdav_notes: bool = false,
    calendar_auto_schedule: bool = false,
    subscribed_icalendar: bool = false,
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

    pub const flags_none: WebDAVDiscoverSupports = @bitCast(@as(c_uint, 0));
    pub const flags_contacts: WebDAVDiscoverSupports = @bitCast(@as(c_uint, 1));
    pub const flags_events: WebDAVDiscoverSupports = @bitCast(@as(c_uint, 2));
    pub const flags_memos: WebDAVDiscoverSupports = @bitCast(@as(c_uint, 4));
    pub const flags_tasks: WebDAVDiscoverSupports = @bitCast(@as(c_uint, 8));
    pub const flags_webdav_notes: WebDAVDiscoverSupports = @bitCast(@as(c_uint, 64));
    pub const flags_calendar_auto_schedule: WebDAVDiscoverSupports = @bitCast(@as(c_uint, 128));
    pub const flags_subscribed_icalendar: WebDAVDiscoverSupports = @bitCast(@as(c_uint, 256));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVListFlags = packed struct(c_uint) {
    supports: bool = false,
    etag: bool = false,
    display_name: bool = false,
    content_type: bool = false,
    content_length: bool = false,
    creation_date: bool = false,
    last_modified: bool = false,
    description: bool = false,
    color: bool = false,
    order: bool = false,
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
    only_calendar: bool = false,
    only_addressbook: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_all: WebDAVListFlags = @bitCast(@as(c_uint, 16777215));
    pub const flags_none: WebDAVListFlags = @bitCast(@as(c_uint, 0));
    pub const flags_supports: WebDAVListFlags = @bitCast(@as(c_uint, 1));
    pub const flags_etag: WebDAVListFlags = @bitCast(@as(c_uint, 2));
    pub const flags_display_name: WebDAVListFlags = @bitCast(@as(c_uint, 4));
    pub const flags_content_type: WebDAVListFlags = @bitCast(@as(c_uint, 8));
    pub const flags_content_length: WebDAVListFlags = @bitCast(@as(c_uint, 16));
    pub const flags_creation_date: WebDAVListFlags = @bitCast(@as(c_uint, 32));
    pub const flags_last_modified: WebDAVListFlags = @bitCast(@as(c_uint, 64));
    pub const flags_description: WebDAVListFlags = @bitCast(@as(c_uint, 128));
    pub const flags_color: WebDAVListFlags = @bitCast(@as(c_uint, 256));
    pub const flags_order: WebDAVListFlags = @bitCast(@as(c_uint, 512));
    pub const flags_only_calendar: WebDAVListFlags = @bitCast(@as(c_uint, 268435456));
    pub const flags_only_addressbook: WebDAVListFlags = @bitCast(@as(c_uint, 536870912));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVResourceSupports = packed struct(c_uint) {
    contacts: bool = false,
    events: bool = false,
    memos: bool = false,
    tasks: bool = false,
    freebusy: bool = false,
    timezone: bool = false,
    webdav_notes: bool = false,
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

    pub const flags_none: WebDAVResourceSupports = @bitCast(@as(c_uint, 0));
    pub const flags_contacts: WebDAVResourceSupports = @bitCast(@as(c_uint, 1));
    pub const flags_events: WebDAVResourceSupports = @bitCast(@as(c_uint, 2));
    pub const flags_memos: WebDAVResourceSupports = @bitCast(@as(c_uint, 4));
    pub const flags_tasks: WebDAVResourceSupports = @bitCast(@as(c_uint, 8));
    pub const flags_freebusy: WebDAVResourceSupports = @bitCast(@as(c_uint, 16));
    pub const flags_timezone: WebDAVResourceSupports = @bitCast(@as(c_uint, 32));
    pub const flags_webdav_notes: WebDAVResourceSupports = @bitCast(@as(c_uint, 64));
    pub const flags_last: WebDAVResourceSupports = @bitCast(@as(c_uint, 64));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Thread safe variant of `gobject.Object.bindProperty`. See its documentation
/// for more information on arguments and return value.
extern fn e_binding_bind_property(p_source: *gobject.Object, p_source_property: [*:0]const u8, p_target: *gobject.Object, p_target_property: [*:0]const u8, p_flags: gobject.BindingFlags) *gobject.Binding;
pub const bindingBindProperty = e_binding_bind_property;

/// Thread safe variant of `gobject.Object.bindPropertyFull`. See its documentation
/// for more information on arguments and return value.
extern fn e_binding_bind_property_full(p_source: *gobject.Object, p_source_property: [*:0]const u8, p_target: *gobject.Object, p_target_property: [*:0]const u8, p_flags: gobject.BindingFlags, p_transform_to: ?gobject.BindingTransformFunc, p_transform_from: ?gobject.BindingTransformFunc, p_user_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) *gobject.Binding;
pub const bindingBindPropertyFull = e_binding_bind_property_full;

/// Thread safe variant of `gobject.Object.bindPropertyWithClosures`. See its
/// documentation for more information on arguments and return value.
extern fn e_binding_bind_property_with_closures(p_source: *gobject.Object, p_source_property: [*:0]const u8, p_target: *gobject.Object, p_target_property: [*:0]const u8, p_flags: gobject.BindingFlags, p_transform_to: ?*gobject.Closure, p_transform_from: ?*gobject.Closure) *gobject.Binding;
pub const bindingBindPropertyWithClosures = e_binding_bind_property_with_closures;

/// Transforms an enumeration nickname to its corresponding value.
extern fn e_binding_transform_enum_nick_to_value(p_binding: *gobject.Binding, p_source_value: *const gobject.Value, p_target_value: *gobject.Value, p_not_used: ?*anyopaque) c_int;
pub const bindingTransformEnumNickToValue = e_binding_transform_enum_nick_to_value;

/// Transforms an enumeration value to its corresponding nickname.
extern fn e_binding_transform_enum_value_to_nick(p_binding: *gobject.Binding, p_source_value: *const gobject.Value, p_target_value: *gobject.Value, p_not_used: ?*anyopaque) c_int;
pub const bindingTransformEnumValueToNick = e_binding_transform_enum_value_to_nick;

/// Adds a new category, with its corresponding icon, to the
/// configuration database.
///
/// This function is thread safe.
extern fn e_categories_add(p_category: [*:0]const u8, p_unused: [*:0]const u8, p_icon_file: [*:0]const u8, p_searchable: c_int) void;
pub const categoriesAdd = e_categories_add;

/// Gets the icon file associated with the given category and returns a copy of
/// it.
///
/// This function is thread safe.
extern fn e_categories_dup_icon_file_for(p_category: [*:0]const u8) [*:0]u8;
pub const categoriesDupIconFileFor = e_categories_dup_icon_file_for;

/// Returns a sorted list of all the category names currently configured.
///
/// This function is thread safe.
extern fn e_categories_dup_list() *glib.List;
pub const categoriesDupList = e_categories_dup_list;

/// Checks whether the given category is available in the configuration.
///
/// This function is thread safe.
extern fn e_categories_exist(p_category: [*:0]const u8) c_int;
pub const categoriesExist = e_categories_exist;

/// Gets the icon file associated with the given category.
///
/// This function is mostly thread safe, but as the icon file name is not
/// copied, it may be freed by another thread after being returned by this
/// function. Use `edataserver.categoriesDupIconFileFor` instead.
extern fn e_categories_get_icon_file_for(p_category: [*:0]const u8) [*:0]const u8;
pub const categoriesGetIconFileFor = e_categories_get_icon_file_for;

/// Returns a sorted list of all the category names currently configured.
///
/// This function is mostly thread safe, but as the category names are not
/// copied, they may be freed by another thread after being returned by this
/// function. Use `edataserver.categoriesDupList` instead.
extern fn e_categories_get_list() *glib.List;
pub const categoriesGetList = e_categories_get_list;

/// Gets whether the given calendar is to be used for searches in the GUI.
///
/// This function is thread safe.
///
/// Return value; `TRUE`% if the category is searchable, `FALSE`% if not.
extern fn e_categories_is_searchable(p_category: [*:0]const u8) c_int;
pub const categoriesIsSearchable = e_categories_is_searchable;

/// Registers callback to be called on change of any category.
/// Pair listener and user_data is used to distinguish between listeners.
/// Listeners can be unregistered with `e_categories_unregister_change_listener`.
///
/// This function is thread safe.
extern fn e_categories_register_change_listener(p_listener: gobject.Callback, p_user_data: ?*anyopaque) void;
pub const categoriesRegisterChangeListener = e_categories_register_change_listener;

/// Removes the given category from the configuration.
///
/// This function is thread safe.
extern fn e_categories_remove(p_category: [*:0]const u8) void;
pub const categoriesRemove = e_categories_remove;

/// Sets the icon file associated with the given category.
///
/// This function is thread safe.
extern fn e_categories_set_icon_file_for(p_category: [*:0]const u8, p_icon_file: [*:0]const u8) void;
pub const categoriesSetIconFileFor = e_categories_set_icon_file_for;

/// Removes previously registered callback from the list of listeners on changes.
/// If it was not registered, then does nothing.
///
/// This function is thread safe.
extern fn e_categories_unregister_change_listener(p_listener: gobject.Callback, p_user_data: ?*anyopaque) void;
pub const categoriesUnregisterChangeListener = e_categories_unregister_change_listener;

/// Returns the value set by `edataserver.dataServerUtilSetDbusCallTimeout`.
extern fn e_data_server_util_get_dbus_call_timeout() c_int;
pub const dataServerUtilGetDbusCallTimeout = e_data_server_util_get_dbus_call_timeout;

/// Sets default timeout, in milliseconds, for calls of `gio.DBusProxy.call`
/// family functions.
///
/// -1 means the default value as set by D-Bus itself.
/// G_MAXINT means no timeout at all.
///
/// Default value is set also by configure option --with-dbus-call-timeout=ms
/// and -1 is used when not set.
extern fn e_data_server_util_set_dbus_call_timeout(p_timeout_msec: c_int) void;
pub const dataServerUtilSetDbusCallTimeout = e_data_server_util_set_dbus_call_timeout;

/// Records debug information for the given `domain`, if enabled, or always,
/// when `is_milestone` is set to TRUE.
extern fn e_debug_log(p_is_milestone: c_int, p_domain: [*:0]const u8, p_format: [*:0]const u8, ...) void;
pub const debugLog = e_debug_log;

extern fn e_debug_log_clear() void;
pub const debugLogClear = e_debug_log_clear;

/// Disables all domains from the `domains` array.
extern fn e_debug_log_disable_domains(p_domains: [*][*:0]const u8, p_n_domains: c_int) void;
pub const debugLogDisableDomains = e_debug_log_disable_domains;

/// Saves current log information to the given `filename`.
extern fn e_debug_log_dump(p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
pub const debugLogDump = e_debug_log_dump;

/// Saves current log information to a file "e-debug-log-YYYY-MM-DD-HH-mm-ss.txt"
/// in the user's HOME directory.
extern fn e_debug_log_dump_to_dated_file(p_error: ?*?*glib.Error) c_int;
pub const debugLogDumpToDatedFile = e_debug_log_dump_to_dated_file;

/// Enables all domains from the `domains` array.
extern fn e_debug_log_enable_domains(p_domains: [*][*:0]const u8, p_n_domains: c_int) void;
pub const debugLogEnableDomains = e_debug_log_enable_domains;

extern fn e_debug_log_get_max_lines() c_int;
pub const debugLogGetMaxLines = e_debug_log_get_max_lines;

extern fn e_debug_log_is_domain_enabled(p_domain: [*:0]const u8) c_int;
pub const debugLogIsDomainEnabled = e_debug_log_is_domain_enabled;

/// Loads configuration for the logging from the given `filename`.
extern fn e_debug_log_load_configuration(p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
pub const debugLogLoadConfiguration = e_debug_log_load_configuration;

/// Limits how many lines the log can have.
extern fn e_debug_log_set_max_lines(p_num_lines: c_int) void;
pub const debugLogSetMaxLines = e_debug_log_set_max_lines;

/// Records debug information for the given `domain`, if enabled, or always,
/// when `is_milestone` is set to TRUE.
extern fn e_debug_logv(p_is_milestone: c_int, p_domain: [*:0]const u8, p_format: [*:0]const u8, p_args: std.builtin.VaList) void;
pub const debugLogv = e_debug_logv;

/// Checks that the Evolution-Data-Server library in use is compatible with
/// the given version.  Generally you would pass in the constants
/// `EDS_MAJOR_VERSION`, `EDS_MINOR_VERSION`, `EDS_MICRO_VERSION` as the three
/// arguments to this function.  That produces a check that the library in
/// use is compatible with the version of Evolution-Data-Server the
/// application or module was compiled against.
extern fn eds_check_version(p_required_major: c_uint, p_required_minor: c_uint, p_required_micro: c_uint) ?[*:0]const u8;
pub const edsCheckVersion = eds_check_version;

/// Fetches the appropriate enumeration value for `string` in the given
/// enum type `type` and stores the result in `enum_value`
extern fn e_enum_from_string(p_enum_type: usize, p_string: [*:0]const u8, p_enum_value: *c_int) c_int;
pub const enumFromString = e_enum_from_string;

/// Converts an enum value to a string using strings from the GType system.
extern fn e_enum_to_string(p_enum_type: usize, p_enum_value: c_int) [*:0]const u8;
pub const enumToString = e_enum_to_string;

/// Asynchronously deletes `file`.  If `file` is a directory, its contents
/// are deleted recursively before `file` itself is deleted.  The recursive
/// delete operation will stop on the first error.
///
/// If `cancellable` is not `NULL`, then the operation can be cancelled
/// by triggering the cancellable object before the operation finishes.
///
/// When the operation is finished, `callback` will be called.  You can then
/// call `edataserver.fileRecursiveDeleteFinish` to get the result of the operation.
extern fn e_file_recursive_delete(p_file: *gio.File, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
pub const fileRecursiveDelete = e_file_recursive_delete;

/// Finishes the operation started with `edataserver.fileRecursiveDelete`.
///
/// If the operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
/// returned.
extern fn e_file_recursive_delete_finish(p_file: *gio.File, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
pub const fileRecursiveDeleteFinish = e_file_recursive_delete_finish;

/// Deletes `file`.  If `file` is a directory, its contents are deleted
/// recursively before `file` itself is deleted.  The recursive delete
/// operation will stop on the first error.
///
/// If `cancellable` is not `NULL`, then the operation can be cancelled
/// by triggering the cancellable object from another thread.  If the
/// operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
/// returned.
extern fn e_file_recursive_delete_sync(p_file: *gio.File, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const fileRecursiveDeleteSync = e_file_recursive_delete_sync;

extern fn e_filename_make_safe(p_string: [*:0]u8) void;
pub const filenameMakeSafe = e_filename_make_safe;

/// Creates a local path constructed from `basepath` / `fileprefix` + "-" + `filename`,
/// and makes sure the path `basepath` exists. If creation of
/// the path fails, then NULL is returned.
extern fn e_filename_mkdir_encoded(p_basepath: [*:0]const u8, p_fileprefix: [*:0]const u8, p_filename: ?[*:0]const u8, p_fileindex: c_int) ?[*:0]u8;
pub const filenameMkdirEncoded = e_filename_mkdir_encoded;

/// Converts the `free_form_exp` to an S-Expression using the S-Expression
/// builders defined in the `symbols`. The `symbols` should have one symbol
/// with an empty string as its name, which is used for words which do not
/// have a symbol name prefix.
///
/// The `symbols` is a NULL-terminated array of known symbols. The NULL should
/// be set for the symbol's name.
extern fn e_free_form_exp_to_sexp(p_free_form_exp: [*:0]const u8, p_symbols: *const edataserver.FreeFormExpSymbol) ?[*:0]u8;
pub const freeFormExpToSexp = e_free_form_exp_to_sexp;

/// Adds a Task:completed property `value` into the `builder`, which
/// should have started an object member.
///
/// When the `value` is 0, then adds a NULL-object, to indicate
/// removal of the property.
extern fn e_gdata_task_add_completed(p_builder: *json.Builder, p_value: i64) void;
pub const gdataTaskAddCompleted = e_gdata_task_add_completed;

/// Adds a Task::due property `value` into the `builder`, which
/// should have started an object member.
///
/// When the `value` is 0, then adds a NULL-object, to indicate
/// removal of the property.
extern fn e_gdata_task_add_due(p_builder: *json.Builder, p_value: i64) void;
pub const gdataTaskAddDue = e_gdata_task_add_due;

/// Adds a Task::id property `value` into the `builder`, which
/// should have started an object member.
extern fn e_gdata_task_add_id(p_builder: *json.Builder, p_value: [*:0]const u8) void;
pub const gdataTaskAddId = e_gdata_task_add_id;

/// Adds a Task::notes property `value` into the `builder`, which
/// should have started an object member.
///
/// When the `value` is `NULL`, then adds a NULL-object, to indicate removal
/// of the property.
extern fn e_gdata_task_add_notes(p_builder: *json.Builder, p_value: ?[*:0]const u8) void;
pub const gdataTaskAddNotes = e_gdata_task_add_notes;

/// Adds a Task::status property `value` into the `builder`, which
/// should have started an object member.
///
/// When the `value` is `E_GDATA_TASK_STATUS_UNKNOWN`, then adds a NULL-object,
/// to indicate removal of the property.
extern fn e_gdata_task_add_status(p_builder: *json.Builder, p_value: edataserver.GDataTaskStatus) void;
pub const gdataTaskAddStatus = e_gdata_task_add_status;

/// Adds a Task::title property `value` into the `builder`, which
/// should have started an object member.
extern fn e_gdata_task_add_title(p_builder: *json.Builder, p_value: [*:0]const u8) void;
pub const gdataTaskAddTitle = e_gdata_task_add_title;

/// Returns Task::completed property, as Unix time.
extern fn e_gdata_task_get_completed(p_task: *json.Object) i64;
pub const gdataTaskGetCompleted = e_gdata_task_get_completed;

/// Returns Task::deleted property, as Unix time.
extern fn e_gdata_task_get_deleted(p_task: *json.Object) c_int;
pub const gdataTaskGetDeleted = e_gdata_task_get_deleted;

/// Returns Task::due property, as Unix time.
extern fn e_gdata_task_get_due(p_task: *json.Object) i64;
pub const gdataTaskGetDue = e_gdata_task_get_due;

/// Returns Task::etag property.
extern fn e_gdata_task_get_etag(p_task: *json.Object) ?[*:0]const u8;
pub const gdataTaskGetEtag = e_gdata_task_get_etag;

/// Returns Task::hidden property, as Unix time.
extern fn e_gdata_task_get_hidden(p_task: *json.Object) c_int;
pub const gdataTaskGetHidden = e_gdata_task_get_hidden;

/// Returns Task::id property.
extern fn e_gdata_task_get_id(p_task: *json.Object) ?[*:0]const u8;
pub const gdataTaskGetId = e_gdata_task_get_id;

/// Returns Task::notes property.
extern fn e_gdata_task_get_notes(p_task: *json.Object) ?[*:0]const u8;
pub const gdataTaskGetNotes = e_gdata_task_get_notes;

/// Returns Task::parent property.
extern fn e_gdata_task_get_parent(p_task: *json.Object) ?[*:0]const u8;
pub const gdataTaskGetParent = e_gdata_task_get_parent;

/// Returns Task::position property.
extern fn e_gdata_task_get_position(p_task: *json.Object) ?[*:0]const u8;
pub const gdataTaskGetPosition = e_gdata_task_get_position;

/// Returns Task::selfLink property.
extern fn e_gdata_task_get_self_link(p_task: *json.Object) ?[*:0]const u8;
pub const gdataTaskGetSelfLink = e_gdata_task_get_self_link;

/// Returns Task::status property.
extern fn e_gdata_task_get_status(p_task: *json.Object) edataserver.GDataTaskStatus;
pub const gdataTaskGetStatus = e_gdata_task_get_status;

/// Returns Task::title property.
extern fn e_gdata_task_get_title(p_task: *json.Object) ?[*:0]const u8;
pub const gdataTaskGetTitle = e_gdata_task_get_title;

/// Returns Task::updated property, as Unix time.
extern fn e_gdata_task_get_updated(p_task: *json.Object) i64;
pub const gdataTaskGetUpdated = e_gdata_task_get_updated;

/// Adds a TaskList::id property `value` into the `builder`, which
/// should have started an object member.
extern fn e_gdata_tasklist_add_id(p_builder: *json.Builder, p_value: [*:0]const u8) void;
pub const gdataTasklistAddId = e_gdata_tasklist_add_id;

/// Adds a TaskList::title property `value` into the `builder`, which
/// should have started an object member.
extern fn e_gdata_tasklist_add_title(p_builder: *json.Builder, p_value: [*:0]const u8) void;
pub const gdataTasklistAddTitle = e_gdata_tasklist_add_title;

/// Returns TaskList::etag property.
extern fn e_gdata_tasklist_get_etag(p_tasklist: *json.Object) ?[*:0]const u8;
pub const gdataTasklistGetEtag = e_gdata_tasklist_get_etag;

/// Returns TaskList::id property.
extern fn e_gdata_tasklist_get_id(p_tasklist: *json.Object) ?[*:0]const u8;
pub const gdataTasklistGetId = e_gdata_tasklist_get_id;

/// Returns TaskList::selfLink property.
extern fn e_gdata_tasklist_get_self_link(p_tasklist: *json.Object) ?[*:0]const u8;
pub const gdataTasklistGetSelfLink = e_gdata_tasklist_get_self_link;

/// Returns TaskList::title property.
extern fn e_gdata_tasklist_get_title(p_tasklist: *json.Object) ?[*:0]const u8;
pub const gdataTasklistGetTitle = e_gdata_tasklist_get_title;

/// Returns TaskList::updated property, as Unix time.
extern fn e_gdata_tasklist_get_updated(p_tasklist: *json.Object) i64;
pub const gdataTasklistGetUpdated = e_gdata_tasklist_get_updated;

/// Returns a base directory in which to store user-specific,
/// non-essential cached data for Evolution or Evolution-Data-Server.
///
/// The returned string is owned by libedataserver and must not be
/// modified or freed.
extern fn e_get_user_cache_dir() [*:0]const u8;
pub const getUserCacheDir = e_get_user_cache_dir;

/// Returns a base directory in which to store user-specific configuration
/// information for Evolution or Evolution-Data-Server.
///
/// The returned string is owned by libedataserver and must not be
/// modified or freed.
extern fn e_get_user_config_dir() [*:0]const u8;
pub const getUserConfigDir = e_get_user_config_dir;

/// Returns a base directory in which to store user-specific data for
/// Evolution or Evolution-Data-Server.
///
/// The returned string is owned by libedataserver and must not be
/// modified or freed.
extern fn e_get_user_data_dir() [*:0]const u8;
pub const getUserDataDir = e_get_user_data_dir;

/// Converts the calendar time time representation `tt` to a broken-down
/// time representation, store in `tm`, and provides the offset in
/// seconds from UTC time, stored in `offset`.
extern fn e_localtime_with_offset(p_tt: std.posix.time_t, p_tm: ?*anyopaque, p_offset: *c_int) void;
pub const localtimeWithOffset = e_localtime_with_offset;

/// Allocate a new atom size block of memory from an `edataserver.MemChunk`.
/// Free the returned atom with `edataserver.memchunkFree`.
extern fn e_memchunk_alloc(p_memchunk: *edataserver.MemChunk) ?*anyopaque;
pub const memchunkAlloc = e_memchunk_alloc;

/// Allocate a new atom size block of memory from an `edataserver.MemChunk`,
/// and fill the memory with zeros.  Free the returned atom with
/// `edataserver.memchunkFree`.
extern fn e_memchunk_alloc0(p_memchunk: *edataserver.MemChunk) ?*anyopaque;
pub const memchunkAlloc0 = e_memchunk_alloc0;

/// Scan all empty blocks and check for blocks which can be free'd
/// back to the system.
///
/// This routine may take a while to run if there are many allocated
/// memory blocks (if the total number of allocations is many times
/// greater than atomcount).
extern fn e_memchunk_clean(p_memchunk: *edataserver.MemChunk) void;
pub const memchunkClean = e_memchunk_clean;

/// Free the memchunk header, and all associated memory.
extern fn e_memchunk_destroy(p_memchunk: *edataserver.MemChunk) void;
pub const memchunkDestroy = e_memchunk_destroy;

/// Clean out the memchunk buffers.  Marks all allocated memory as free blocks,
/// but does not give it back to the system.  Can be used if the memchunk
/// is to be used repeatedly.
extern fn e_memchunk_empty(p_memchunk: *edataserver.MemChunk) void;
pub const memchunkEmpty = e_memchunk_empty;

/// Free a single atom back to the free pool of atoms in the given
/// memchunk.
extern fn e_memchunk_free(p_memchunk: *edataserver.MemChunk, p_mem: ?*anyopaque) void;
pub const memchunkFree = e_memchunk_free;

/// Create a new `edataserver.MemChunk` header.  Memchunks are an efficient way to
/// allocate and deallocate identical sized blocks of memory quickly, and
/// space efficiently.
///
/// e_memchunks are effectively the same as gmemchunks, only faster (much),
/// and they use less memory overhead for housekeeping.
extern fn e_memchunk_new(p_atomcount: c_int, p_atomsize: c_int) *edataserver.MemChunk;
pub const memchunkNew = e_memchunk_new;

/// Like mktime(3), but assumes UTC instead of local timezone.
extern fn e_mktime_utc(p_tm: ?*anyopaque) std.posix.time_t;
pub const mktimeUtc = e_mktime_utc;

/// Transfers the contents of `src_queue` to the tail of `dst_queue`.
/// When the operation is complete, `src_queue` will be empty.
extern fn e_queue_transfer(p_src_queue: *glib.Queue, p_dst_queue: *glib.Queue) void;
pub const queueTransfer = e_queue_transfer;

/// Deletes the secret for `uid` from either the default keyring or
/// session keyring.
///
/// Note the boolean return value indicates whether the delete operation
/// itself completed successfully, not whether the secret was found and
/// deleted. If no such secret was found, the function will still return
/// `TRUE`. If an error occurs, the function sets `error` and returns `FALSE`.
extern fn e_secret_store_delete_sync(p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const secretStoreDeleteSync = e_secret_store_delete_sync;

/// Looks up a secret for the `uid`. Both the default and session keyrings
/// are queried.
///
/// Note the boolean return value indicates whether the lookup operation
/// itself completed successfully, not whether the secret was found. If
/// no secret was found, the function will set `out_secret` to `NULL`,
/// but still return `TRUE`. If an error occurs, the function sets `error`
/// and returns `FALSE`.
extern fn e_secret_store_lookup_sync(p_uid: [*:0]const u8, p_out_secret: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const secretStoreLookupSync = e_secret_store_lookup_sync;

/// Stores the `secret` for the `uid`.
///
/// If `permanently` is `TRUE`, the secret is stored in the default keyring.
/// Otherwise the secret is stored in the memory-only session keyring. If
/// an error occurs, the function sets `error` and returns `FALSE`.
extern fn e_secret_store_store_sync(p_uid: [*:0]const u8, p_secret: [*:0]const u8, p_label: [*:0]const u8, p_permanently: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const secretStoreStoreSync = e_secret_store_store_sync;

/// Sets up automatic SSL certificate trust handling for `soup_message` using the trust
/// data stored in `source`'s WebDAV extension. If `soup_message` is about to be sent on
/// an SSL connection with an invalid certificate, the code checks if the WebDAV
/// extension already has a trust response for that certificate and verifies it
/// with `edataserver.SourceWebdav.verifySslTrust`. If the verification fails, then
/// the `soup_message` send also fails.
///
/// This works by connecting to the "network-event" signal on `soup_message` and
/// connecting to the "accept-certificate" signal on each `gio.TlsConnection` for
/// which `soup_message` reports a `G_SOCKET_CLIENT_TLS_HANDSHAKING` event. These
/// handlers are torn down automatically when `soup_message` is disposed. This process
/// is not thread-safe; it is sufficient for safety if all use of `soup_message`'s
/// session and the disposal of `soup_message` occur in the same thread.
extern fn e_soup_ssl_trust_connect(p_soup_message: *soup.Message, p_source: *edataserver.Source) void;
pub const soupSslTrustConnect = e_soup_ssl_trust_connect;

/// This function is a wrapper around the strftime (3) function, which
/// converts the &percnt;l and &percnt;k (12h and 24h) format variables
/// if necessary.
extern fn e_strftime(p_string: [*:0]u8, p_max: usize, p_fmt: [*:0]const u8, p_tm: ?*anyopaque) usize;
pub const strftime = e_strftime;

/// Creates a string representation of the time value `date_tm` and
/// stores it in `buffer`.  `buffer_size` should be at least 64 to be
/// safe. If `show_midnight` is `FALSE`, and the time is midnight, then
/// only the date is stored in `buffer`. If `show_zero_seconds` is
/// `FALSE`, then if the time has zero seconds only the hour and minute
/// of the time are stored in `buffer`.
extern fn e_time_format_date_and_time(p_date_tm: ?*anyopaque, p_use_24_hour_format: c_int, p_show_midnight: c_int, p_show_zero_seconds: c_int, p_buffer: [*:0]u8, p_buffer_size: c_int) void;
pub const timeFormatDateAndTime = e_time_format_date_and_time;

/// Creates a string representation of a time value in `date_tm` and
/// stores it in `buffer`. `buffer_size` should be at least 64.
extern fn e_time_format_time(p_date_tm: ?*anyopaque, p_use_24_hour_format: c_int, p_show_zero_seconds: c_int, p_buffer: [*:0]u8, p_buffer_size: c_int) void;
pub const timeFormatTime = e_time_format_time;

/// Retrieves a date format string with a 4-digit year (D_FMT on systems with
/// `nl_langinfo` available). In case the current locale doesn't support 4-digit
/// year, the function returns format as specified by the locale.
///
/// Free the returned string with `glib.free`.
extern fn e_time_get_d_fmt_with_4digit_year() [*:0]u8;
pub const timeGetDFmtWith4digitYear = e_time_get_d_fmt_with_4digit_year;

/// Takes in a date string entered by the user and tries to convert it to
/// a struct `tm`.
extern fn e_time_parse_date(p_value: [*:0]const u8, p_result: ?*anyopaque) edataserver.TimeParseStatus;
pub const timeParseDate = e_time_parse_date;

/// Parses a string `value` containing a date and a time and stores the
/// result in `result`. The date in `value` is expected to be in a format
/// like "Wed 3/13/00 14:20:00", though `gettext` is used to support the
/// appropriate local formats. There is also some leniency on the
/// format of the string, e.g. the weekday can be skipped or 12-hour
/// formats with am/pm can be used.
extern fn e_time_parse_date_and_time(p_value: [*:0]const u8, p_result: ?*anyopaque) edataserver.TimeParseStatus;
pub const timeParseDateAndTime = e_time_parse_date_and_time;

/// Parses a string `value` containing a date and a time and stores the
/// result in `result`. The date in `value` is expected to be in a format
/// like "Wed 3/13/00 14:20:00", though `gettext` is used to support the
/// appropriate local formats. There is also some leniency on the
/// format of the string, e.g. the weekday can be skipped or 12-hour
/// formats with am/pm can be used.
extern fn e_time_parse_date_and_time_ex(p_value: [*:0]const u8, p_result: ?*anyopaque, p_two_digit_year: *c_int) edataserver.TimeParseStatus;
pub const timeParseDateAndTimeEx = e_time_parse_date_and_time_ex;

/// Takes in a date string entered by the user and tries to convert it to
/// a struct `tm`.
extern fn e_time_parse_date_ex(p_value: [*:0]const u8, p_result: ?*anyopaque, p_two_digit_year: *c_int) edataserver.TimeParseStatus;
pub const timeParseDateEx = e_time_parse_date_ex;

/// Parses `value` using the `format` saving the parsed date into `out_result`.
/// Optionally sets whether there had been used two-digit year.
extern fn e_time_parse_date_format(p_value: [*:0]const u8, p_format: [*:0]const u8, p_out_result: ?*anyopaque, p_out_two_digit_year: ?*c_int) edataserver.TimeParseStatus;
pub const timeParseDateFormat = e_time_parse_date_format;

/// Parses `value`, a string containing a time. `value` is expected to be
/// in a format like "14:20:00". `gettext` is used to
/// support the appropriate local formats and slightly
/// different formats, such as 12-hour formats with am/pm,
/// are accepted as well.
extern fn e_time_parse_time(p_value: [*:0]const u8, p_result: ?*anyopaque) edataserver.TimeParseStatus;
pub const timeParseTime = e_time_parse_time;

/// Similar to `glib.timeoutAddSecondsFull`, but also names the `glib.Source` as
/// `name`.
///
/// You might find `e_named_timeout_add_seconds` or
/// `e_named_timeout_add_seconds_full` more convenient.  Those macros name
/// the `glib.Source` implicitly.
extern fn e_timeout_add_seconds_with_name(p_priority: c_int, p_interval: c_uint, p_name: ?[*:0]const u8, p_function: glib.SourceFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
pub const timeoutAddSecondsWithName = e_timeout_add_seconds_with_name;

/// Similar to `glib.timeoutAddFull`, but also names the `glib.Source` as `name`.
///
/// You might find `e_named_timeout_add` or `e_named_timeout_add_full` more
/// convenient.  Those macros name the `glib.Source` implicitly.
extern fn e_timeout_add_with_name(p_priority: c_int, p_interval: c_uint, p_name: ?[*:0]const u8, p_function: glib.SourceFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
pub const timeoutAddWithName = e_timeout_add_with_name;

/// Calls `func` for all instantiable subtypes of `parent_type`.
///
/// This is often useful for extending functionality by way of `edataserver.Module`.
/// A module may register a subtype of `parent_type` in its `e_module_load`
/// function.  Then later on the application will call `edataserver.typeTraverse`
/// to instantiate all registered subtypes of `parent_type`.
extern fn e_type_traverse(p_parent_type: usize, p_func: edataserver.TypeFunc, p_user_data: ?*anyopaque) void;
pub const typeTraverse = e_type_traverse;

/// Generate a new unique string for use e.g. in account lists.
extern fn e_uid_new() [*:0]u8;
pub const uidNew = e_uid_new;

/// The UTF-8 equivalent of e_strftime ().
extern fn e_utf8_strftime(p_string: [*:0]u8, p_max: usize, p_fmt: [*:0]const u8, p_tm: ?*anyopaque) usize;
pub const utf8Strftime = e_utf8_strftime;

/// Calls `malloc_trim` to free unused heap memory. The function
/// does nothing, when the `malloc_trim` is not available.
///
/// This might be called after some operations which may use a lot
/// of memory temporarily.
extern fn e_util_call_malloc_trim() void;
pub const utilCallMallocTrim = e_util_call_malloc_trim;

/// Checks whether the `collection_source` can be used as a credential source
/// for the `child_source`. The relationship is not tested in the function.
/// When the `collection_source` is `NULL`, then it simply returns `FALSE`.
extern fn e_util_can_use_collection_as_credential_source(p_collection_source: ?*anyopaque, p_child_source: ?*anyopaque) c_int;
pub const utilCanUseCollectionAsCredentialSource = e_util_can_use_collection_as_credential_source;

/// Changes component `component` in the `inout_uri` to value `value`.
/// As the `glib.Uri` cannot be modified the `inout_uri` points to a new `glib.Uri`
/// at the end of the call and the previous structure is unreffed.
///
/// See: `edataserver.utilChangeUriPort`
extern fn e_util_change_uri_component(p_inout_uri: **glib.Uri, p_component: soup.URIComponent, p_value: ?[*:0]const u8) void;
pub const utilChangeUriComponent = e_util_change_uri_component;

/// Changes the port in the `inout_uri` to value `port`.
/// As the `glib.Uri` cannot be modified the `inout_uri` points to a new `glib.Uri`
/// at the end of the call and the previous structure is unreffed.
///
/// See: `edataserver.utilChangeUriComponent`
extern fn e_util_change_uri_port(p_inout_uri: **glib.Uri, p_port: c_int) void;
pub const utilChangeUriPort = e_util_change_uri_port;

/// Copies `glib.SList` of `gobject.Object`<!-- -->s at the end of `copy_to`.
extern fn e_util_copy_object_slist(p_copy_to: ?*glib.SList, p_objects: *const glib.SList) *glib.SList;
pub const utilCopyObjectSlist = e_util_copy_object_slist;

/// Copies `glib.SList` of strings at the end of `copy_to`.
extern fn e_util_copy_string_slist(p_copy_to: ?*glib.SList, p_strings: *const glib.SList) *glib.SList;
pub const utilCopyStringSlist = e_util_copy_string_slist;

/// Prints a text according to `format` and its arguments to stdout
/// prefixed with `domain` in brackets [] and the current date and time.
/// This function doesn't check whether the logging is enabled, it's up
/// to the caller to determine it, the function only prints the information
/// in a consistent format:
/// [domain] YYYY-MM-DD hh:mm:ss.ms - format
///
/// See: `edataserver.utilDebugPrintv`
extern fn e_util_debug_print(p_domain: [*:0]const u8, p_format: [*:0]const u8, ...) void;
pub const utilDebugPrint = e_util_debug_print;

/// Prints a text according to `format` and its `args` to stdout
/// prefixed with `domain` in brackets [] and the current date and time.
/// This function doesn't check whether the logging is enabled, it's up
/// to the caller to determine it, the function only prints the information
/// in a consistent form:
/// [`domain`] YYYY-MM-DD hh:mm:ss.ms - `format`
///
/// See: `edataserver.utilDebugPrint`
extern fn e_util_debug_printv(p_domain: [*:0]const u8, p_format: [*:0]const u8, p_args: std.builtin.VaList) void;
pub const utilDebugPrintv = e_util_debug_printv;

/// If `str` is a valid UTF-8 string, the function returns `str` and does
/// not set `gdbus_str`.
///
/// If `str` is an invalid UTF-8 string, the function calls
/// `edataserver.utilUtf8MakeValid` and points `gdbus_str` to the newly-allocated,
/// valid UTF-8 string, and also returns it.  The caller should free the
/// string pointed to by `gdbus_str` with `glib.free`.
///
/// If `str` is `NULL`, the function returns an empty string and does not
/// set `gdbus_str`.
///
/// Admittedly, the function semantics are a little awkward.  The example
/// below illustrates the easiest way to cope with the `gdbus_str` argument:
///
/// ```
///     const gchar *trusted_utf8;
///     gchar *allocated = NULL;
///
///     trusted_utf8 = e_util_ensure_gdbus_string (untrusted_utf8, &allocated);
///
///     Do stuff with trusted_utf8, then clear it.
///
///     trusted_utf8 = NULL;
///
///     g_free (allocated);
///     allocated = NULL;
/// ```
extern fn e_util_ensure_gdbus_string(p_str: ?[*:0]const u8, p_gdbus_str: *[*:0]u8) [*:0]const u8;
pub const utilEnsureGdbusString = e_util_ensure_gdbus_string;

/// Calls `gobject.Object.unref` on each member of `objects` if non-`NULL` and then frees
/// also `objects` itself.
extern fn e_util_free_nullable_object_slist(p_objects: *glib.SList) void;
pub const utilFreeNullableObjectSlist = e_util_free_nullable_object_slist;

/// Calls `gobject.Object.unref` on each member of `objects` and then frees
/// also `objects` itself.
extern fn e_util_free_object_slist(p_objects: *glib.SList) void;
pub const utilFreeObjectSlist = e_util_free_object_slist;

/// Frees memory previously allocated by `edataserver.utilStrvToSlist`.
extern fn e_util_free_string_slist(p_strings: *glib.SList) void;
pub const utilFreeStringSlist = e_util_free_string_slist;

/// Generates a unique identificator, which can be used as part of
/// the Message-ID header, or iCalendar component UID, or vCard UID.
/// The resulting string doesn't contain any host name, it's
/// a hexa-decimal string with no particular meaning.
///
/// Free the returned string with `glib.free`, when no longer needed.
extern fn e_util_generate_uid() [*:0]u8;
pub const utilGenerateUid = e_util_generate_uid;

/// The `main_path` is a directory, which will be always used. It
/// should have as its prefix the `replace_prefix`, otherwise
/// the function returns only the `main_path` in the paths array.
///
/// When there's exported an environment variable EDS_EXTRA_PREFIXES,
/// it is used as a list of alternative prefixes where to look for
/// the `main_path` (rest after the `replace_prefix`).
///
/// When the `with_modules_dir` is `TRUE`, there's also added
/// `glib.getUserDataDir` + "evolution/modules/", aka
/// ~/.local/share/evolution/modules/, into the resulting array.
extern fn e_util_get_directory_variants(p_main_path: [*:0]const u8, p_replace_prefix: [*:0]const u8, p_with_modules_dir: c_int) *glib.PtrArray;
pub const utilGetDirectoryVariants = e_util_get_directory_variants;

/// Constructs a full name of the `source` with all of its parents
/// of the form: "&lt;account-name&gt; : &lt;parent&gt;/&lt;source&gt;" where
/// the "&lt;parent&gt;/" part can be repeated zero or more times, depending
/// on the deep level of the `source`.
extern fn e_util_get_source_full_name(p_registry: ?*anyopaque, p_source: ?*anyopaque) [*:0]u8;
pub const utilGetSourceFullName = e_util_get_source_full_name;

/// Returns a 64-bit integer hopefully uniquely identifying the
/// thread. To be used in debugging output and logging only.
/// The returned value is just a cast of a pointer to the 64-bit integer.
///
/// There is no guarantee that calling e_util_gthread_id () on one
/// thread first and later after that thread has dies on another won't
/// return the same integer.
///
/// On Linux and Win32, known to really return a unique id for each
/// thread existing at a certain time. No guarantee that ids won't be
/// reused after a thread has terminated, though.
extern fn e_util_gthread_id(p_thread: *glib.Thread) u64;
pub const utilGthreadId = e_util_gthread_id;

/// Guesses whether the `source` is read only. This is done on some heuristic
/// like the source backend, where some are known to be read only. That this
/// function returns `FALSE` does not necessarily mean the source is writable,
/// it only means the source is not well-known read-only source. To know
/// for sure open the corresponding `edataserver.Client`, if the `source` references such,
/// and use `edataserver.Client.isReadonly`.
extern fn e_util_guess_source_is_readonly(p_source: ?*anyopaque) c_int;
pub const utilGuessSourceIsReadonly = e_util_guess_source_is_readonly;

/// Check whether the hostname `host` is equal to or a subdomain of `domain`.
/// Both `host` and `domain` are UTF-8 strings and can be IDNs (which will be
/// punycode-encoded for comparison).
extern fn e_util_host_is_in_domain(p_host: ?[*:0]const u8, p_domain: ?[*:0]const u8) c_int;
pub const utilHostIsInDomain = e_util_host_is_in_domain;

/// Checks whether the `identity_source` can be used for sending, which means
/// whether it has configures send mail source.
extern fn e_util_identity_can_send(p_registry: ?*anyopaque, p_identity_source: ?*anyopaque) c_int;
pub const utilIdentityCanSend = e_util_identity_can_send;

/// Calls `glib.free` on `string`, but before it rewrites its content with zeros.
/// This is suitable to free strings with passwords.
extern fn e_util_safe_free_string(p_str: [*:0]u8) void;
pub const utilSafeFreeString = e_util_safe_free_string;

/// Convert list of strings into NULL-terminates array of strings.
extern fn e_util_slist_to_strv(p_strings: *const glib.SList) [*][*:0]u8;
pub const utilSlistToStrv = e_util_slist_to_strv;

/// Compares two `edataserver.Source`-s in a way suitable for user interface.
/// It can be used as a `glib.CompareFunc`.
///
/// This is also used by `edataserver.SourceRegistry.buildDisplayTree`.
extern fn e_util_source_compare_for_sort(p_source_a: ?*anyopaque, p_source_b: ?*anyopaque) c_int;
pub const utilSourceCompareForSort = e_util_source_compare_for_sort;

/// Compares `str1` and `str2` like `glib.strcmp0`, except it handles `NULL` and
/// empty strings as equal.
extern fn e_util_strcmp0(p_str1: ?[*:0]const u8, p_str2: ?[*:0]const u8) c_int;
pub const utilStrcmp0 = e_util_strcmp0;

/// Duplicates `string` and strips off any leading or trailing whitespace.
/// The resulting string is returned unless it is empty or `NULL`, in which
/// case the function returns `NULL`.
///
/// Free the returned string with `glib.free`.
extern fn e_util_strdup_strip(p_string: ?[*:0]const u8) ?[*:0]u8;
pub const utilStrdupStrip = e_util_strdup_strip;

/// Find the first instance of `needle` in `haystack`, ignoring case for
/// bytes that are ASCII characters.
extern fn e_util_strstrcase(p_haystack: [*:0]const u8, p_needle: [*:0]const u8) ?[*:0]u8;
pub const utilStrstrcase = e_util_strstrcase;

/// Compares `v1` and `v2` for equality, handling `NULL` gracefully.
///
/// The arguments types are generic for compatibility with `glib.EqualFunc`.
extern fn e_util_strv_equal(p_v1: [*]const [*:0]u8, p_v2: [*]const [*:0]u8) c_int;
pub const utilStrvEqual = e_util_strv_equal;

/// Convert NULL-terminated array of strings to a list of strings.
extern fn e_util_strv_to_slist(p_strv: *const [*:0]const u8) *glib.SList;
pub const utilStrvToSlist = e_util_strv_to_slist;

/// Get a UTF-8 character from the beginning of `text`.
extern fn e_util_unicode_get_utf8(p_text: [*:0]const u8, p_out: *u32) ?[*:0]u8;
pub const utilUnicodeGetUtf8 = e_util_unicode_get_utf8;

/// Unrefs the given `object` in a dedicated thread. This is useful when unreffing
/// object deep in call stack when the caller might still use the object and
/// this being the last reference to it.
extern fn e_util_unref_in_thread(p_object: ?*anyopaque) void;
pub const utilUnrefInThread = e_util_unref_in_thread;

/// Returns a newly-allocated NULL-terminated string with invalid characters
/// replaced by Unicode replacement characters (U+FFFD).
/// For `NULL` `data` returns newly allocated empty string ("").
extern fn e_util_utf8_data_make_valid(p_data: ?[*:0]const u8, p_data_bytes: usize) [*:0]u8;
pub const utilUtf8DataMakeValid = e_util_utf8_data_make_valid;

/// Converts the `text` into a decomposed variant and strips it, which
/// allows also cheap case insensitive comparision afterwards. This
/// produces an output as being used in `edataserver.utilUtf8Strstrcasedecomp`.
extern fn e_util_utf8_decompose(p_text: [*:0]const u8) [*:0]u8;
pub const utilUtf8Decompose = e_util_utf8_decompose;

/// Returns a newly-allocated copy of `str`, with invalid characters
/// replaced by Unicode replacement characters (U+FFFD).
/// For `NULL` `str` returns newly allocated empty string ("").
extern fn e_util_utf8_make_valid(p_str: ?[*:0]const u8) [*:0]u8;
pub const utilUtf8MakeValid = e_util_utf8_make_valid;

/// Normalizes `str` by making it all lower case and removing any accents from it.
extern fn e_util_utf8_normalize(p_str: ?[*:0]const u8) ?[*:0]u8;
pub const utilUtf8Normalize = e_util_utf8_normalize;

/// Returns a newly-allocated copy of `str` with accents removed.
extern fn e_util_utf8_remove_accents(p_str: ?[*:0]const u8) ?[*:0]u8;
pub const utilUtf8RemoveAccents = e_util_utf8_remove_accents;

/// Compares two UTF-8 strings using approximate case-insensitive ordering.
extern fn e_util_utf8_strcasecmp(p_s1: [*:0]const u8, p_s2: [*:0]const u8) c_int;
pub const utilUtf8Strcasecmp = e_util_utf8_strcasecmp;

/// Find the first instance of `needle` in `haystack`, ignoring case. (No
/// proper case folding or decomposing is done.) Both `needle` and
/// `haystack` are UTF-8 strings.
extern fn e_util_utf8_strstrcase(p_haystack: ?[*:0]const u8, p_needle: ?[*:0]const u8) ?[*:0]const u8;
pub const utilUtf8Strstrcase = e_util_utf8_strstrcase;

/// Find the first instance of `needle` in `haystack`, where both `needle`
/// and `haystack` are UTF-8 strings. Both strings are stripped and
/// decomposed for comparison, and case is ignored.
extern fn e_util_utf8_strstrcasedecomp(p_haystack: [*:0]const u8, p_needle: [*:0]const u8) ?[*:0]const u8;
pub const utilUtf8Strstrcasedecomp = e_util_utf8_strstrcasedecomp;

/// Frees a `gobject.WeakRef` created by `edataserver.weakRefNew`.
extern fn e_weak_ref_free(p_weak_ref: *gobject.WeakRef) void;
pub const weakRefFree = e_weak_ref_free;

/// Allocates a new `gobject.WeakRef` and calls `gobject.WeakRef.set` with `object`.
///
/// Free the returned `gobject.WeakRef` with `edataserver.weakRefFree`.
extern fn e_weak_ref_new(p_object: ?*anyopaque) *gobject.WeakRef;
pub const weakRefNew = e_weak_ref_new;

/// Frees a `GSList` of discovered sources returned from
/// `edataserver.webdavDiscoverSourcesFinish` or `edataserver.webdavDiscoverSourcesSync`.
extern fn e_webdav_discover_free_discovered_sources(p_discovered_sources: *glib.SList) void;
pub const webdavDiscoverFreeDiscoveredSources = e_webdav_discover_free_discovered_sources;

/// Asynchronously runs discovery of the WebDAV sources (CalDAV and CardDAV), eventually
/// limited by the `only_supports` filter, which can be `E_WEBDAV_DISCOVER_SUPPORTS_NONE`
/// to search all types. Note that the list of returned calendars can be more general,
/// thus check for its actual support type for further filtering of the results.
/// The `url_use_path` can be used to override actual server path, or even complete URL,
/// for the given `source`.
///
/// When the operation is finished, `callback` will be called. You can then
/// call `edataserver.webdavDiscoverSourcesFinish` to get the result of the operation.
extern fn e_webdav_discover_sources(p_source: *edataserver.Source, p_url_use_path: ?[*:0]const u8, p_only_supports: u32, p_credentials: ?*const edataserver.NamedParameters, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
pub const webdavDiscoverSources = e_webdav_discover_sources;

/// Finishes the operation started with `edataserver.webdavDiscoverSources`. If an
/// error occurred, the function will set `error` and return `FALSE`. The function
/// can return success and no discovered sources, the same as it can return failure,
/// but still set some output arguments, like the certificate related output
/// arguments with G_TLS_ERROR_BAD_CERTIFICATE error.
///
/// The return value of `out_certificate_pem` should be freed with `glib.free`
/// when no longer needed.
///
/// The return value of `out_discovered_sources` should be freed
/// with `edataserver.webdavDiscoverFreeDiscoveredSources` when no longer needed.
///
/// The return value of `out_calendar_user_addresses` should be freed
/// with g_slist_free_full (calendar_user_addresses, g_free); when
/// no longer needed.
extern fn e_webdav_discover_sources_finish(p_source: *edataserver.Source, p_result: *gio.AsyncResult, p_out_certificate_pem: ?*[*:0]u8, p_out_certificate_errors: ?*gio.TlsCertificateFlags, p_out_discovered_sources: ?**glib.SList, p_out_calendar_user_addresses: ?**glib.SList, p_error: ?*?*glib.Error) c_int;
pub const webdavDiscoverSourcesFinish = e_webdav_discover_sources_finish;

/// This is the same as `edataserver.webdavDiscoverSources`, it only allows to
/// provide a callback function (with its user_data), to reference an additional
/// `edataserver.Source`. It's good to avoid creating its own `edataserver.SourceRegistry` instance to
/// get it.
///
/// When the operation is finished, `callback` will be called. You can then
/// call `edataserver.webdavDiscoverSourcesFinish` to get the result of the operation.
extern fn e_webdav_discover_sources_full(p_source: *edataserver.Source, p_url_use_path: ?[*:0]const u8, p_only_supports: u32, p_credentials: ?*const edataserver.NamedParameters, p_ref_source_func: ?edataserver.WebDAVDiscoverRefSourceFunc, p_ref_source_func_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
pub const webdavDiscoverSourcesFull = e_webdav_discover_sources_full;

/// This is the same as `edataserver.webdavDiscoverSourcesSync`, it only allows to
/// provide a callback function (with its user_data), to reference an additional
/// `edataserver.Source`. It's good to avoid creating its own `edataserver.SourceRegistry` instance to
/// get it.
extern fn e_webdav_discover_sources_full_sync(p_source: *edataserver.Source, p_url_use_path: ?[*:0]const u8, p_only_supports: u32, p_credentials: ?*const edataserver.NamedParameters, p_ref_source_func: ?edataserver.WebDAVDiscoverRefSourceFunc, p_ref_source_func_user_data: ?*anyopaque, p_out_certificate_pem: ?*[*:0]u8, p_out_certificate_errors: ?*gio.TlsCertificateFlags, p_out_discovered_sources: ?**glib.SList, p_out_calendar_user_addresses: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const webdavDiscoverSourcesFullSync = e_webdav_discover_sources_full_sync;

/// Synchronously runs discovery of the WebDAV sources (CalDAV and CardDAV), eventually
/// limited by the `only_supports` filter, which can be `E_WEBDAV_DISCOVER_SUPPORTS_NONE`
/// to search all types. Note that the list of returned calendars can be more general,
/// thus check for its actual support type for further filtering of the results.
/// The `url_use_path` can be used to override actual server path, or even complete URL,
/// for the given `source`.
///
/// If an error occurred, the function will set `error` and return `FALSE`. The function
/// can return success and no discovered sources, the same as it can return failure,
/// but still set some output arguments, like the certificate related output
/// arguments with G_TLS_ERROR_BAD_CERTIFICATE error.
///
/// The return value of `out_certificate_pem` should be freed with `glib.free`
/// when no longer needed.
///
/// The return value of `out_discovered_sources` should be freed
/// with `edataserver.webdavDiscoverFreeDiscoveredSources` when no longer needed.
///
/// The return value of `out_calendar_user_addresses` should be freed
/// with g_slist_free_full (calendar_user_addresses, g_free); when
/// no longer needed.
extern fn e_webdav_discover_sources_sync(p_source: *edataserver.Source, p_url_use_path: ?[*:0]const u8, p_only_supports: u32, p_credentials: ?*const edataserver.NamedParameters, p_out_certificate_pem: ?*[*:0]u8, p_out_certificate_errors: ?*gio.TlsCertificateFlags, p_out_discovered_sources: ?**glib.SList, p_out_calendar_user_addresses: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
pub const webdavDiscoverSourcesSync = e_webdav_discover_sources_sync;

/// Frees the memory used by `hash` and its contents.
extern fn e_xml_destroy_hash(p_hash: *glib.HashTable) void;
pub const xmlDestroyHash = e_xml_destroy_hash;

/// Duplicates content of the `node`. If the `node` is `NULL`, then the
/// function does nothing and returns also `NULL`.
///
/// Unlike `edataserver.xmlGetNodeText`, this includes also any element sub-structure
/// of the `node`, if any such exists.
extern fn e_xml_dup_node_content(p_node: ?*const libxml2.Node) ?*libxml2.Char;
pub const xmlDupNodeContent = e_xml_dup_node_content;

/// Searches the children nodes of the `parent` for an element named `name` in namespace `ns_href`.
extern fn e_xml_find_child(p_parent: ?*libxml2.Node, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) ?*libxml2.Node;
pub const xmlFindChild = e_xml_find_child;

/// Searches the children nodes of the `parent` for an element named `name` in namespace `ns_href`
/// and returns its content. This combines `edataserver.xmlFindChild` and `edataserver.xmlDupNodeContent` calls.
extern fn e_xml_find_child_and_dup_content(p_parent: ?*libxml2.Node, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) ?*libxml2.Char;
pub const xmlFindChildAndDupContent = e_xml_find_child_and_dup_content;

/// Searches the children nodes of the `parent` for an element named `name` in namespace `ns_href`
/// and returns its text content.
///
/// It combines `edataserver.xmlFindChild` and `edataserver.xmlGetNodeText` calls.
extern fn e_xml_find_child_and_get_text(p_parent: ?*libxml2.Node, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) ?*const libxml2.Char;
pub const xmlFindChildAndGetText = e_xml_find_child_and_get_text;

/// Retrieve multiple nodes in one go, in an efficient way. It can be
/// quicker than traversing the children of the `parent` `count` times
/// in certain circumstances.
///
/// The variable parameters expect triple of:
///   const gchar *ns_href;
///   const gchar *name;
///   xmlNode **out_node;
/// where the ns_href is a namespace href the node should have set,
/// or `NULL` for none namespace; the name is an element name to search for.
/// The names should not be included more than once.
extern fn e_xml_find_children_nodes(p_parent: *libxml2.Node, p_count: c_uint, ...) void;
pub const xmlFindChildrenNodes = e_xml_find_children_nodes;

/// Checks whether the `parent` has a hierarchy of children described by pair
/// of 'ns_href' and 'name'.
///
/// Note: It requires two `NULL`-s at the end of the arguments, because the `ns_href' can
///    be `NULL`, thus it could not distinguish between no namespace href and the end of
///    the hierarchy children, thus it stops only on the 'name' being `NULL`.
extern fn e_xml_find_in_hierarchy(p_parent: ?*libxml2.Node, p_child_ns_href: ?[*:0]const u8, p_child_name: [*:0]const u8, ...) ?*libxml2.Node;
pub const xmlFindInHierarchy = e_xml_find_in_hierarchy;

/// Searches for the next sibling node of the `sibling` for an element named `name` in namespace `ns_href`.
/// Unlike `edataserver.xmlFindSibling`, it skips the `sibling` itself.
extern fn e_xml_find_next_sibling(p_sibling: ?*libxml2.Node, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) ?*libxml2.Node;
pub const xmlFindNextSibling = e_xml_find_next_sibling;

/// Searches the sibling nodes of the `sibling` for an element named `name` in namespace `ns_href`.
/// It checks the `sibling` itself too, but it doesn't check the previous siblings of the `sibling`.
extern fn e_xml_find_sibling(p_sibling: ?*libxml2.Node, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) ?*libxml2.Node;
pub const xmlFindSibling = e_xml_find_sibling;

/// Uses the key/value pair representation of an XML structure in `hash`
/// to build an equivalent `libxml2.Doc`. This is the reverse of `edataserver.xmlToHash`.
extern fn e_xml_from_hash(p_hash: *glib.HashTable, p_type: edataserver.XmlHashType, p_root_name: [*:0]const u8) *libxml2.Doc;
pub const xmlFromHash = e_xml_from_hash;

/// Attempts to find a child element of `parent` named `child_name`.
/// If no such child exists, the function returns `NULL`.
extern fn e_xml_get_child_by_name(p_parent: *const libxml2.Node, p_child_name: *const libxml2.Char) ?*libxml2.Node;
pub const xmlGetChildByName = e_xml_get_child_by_name;

/// Retrieves content of the `node`. If the `node` is `NULL`, then the
/// function does nothing and returns also `NULL`.
///
/// This is similar to `edataserver.xmlDupNodeContent`, except it does not
/// allocate new memory for the string. It also doesn't traverse
/// the element structure, is returns the first text node's value
/// only. It can be used to avoid unnecessary allocations, when
/// reading element values with a single text node as a child.
extern fn e_xml_get_node_text(p_node: ?*const libxml2.Node) ?*const libxml2.Char;
pub const xmlGetNodeText = e_xml_get_node_text;

/// Initializes libxml library global memory. This should be called
/// in the main thread. The function does nothing, when it had been
/// called already.
extern fn e_xml_initialize_in_main() void;
pub const xmlInitializeInMain = e_xml_initialize_in_main;

extern fn e_xml_is_element_name(p_node: ?*libxml2.Node, p_ns_href: ?[*:0]const u8, p_name: [*:0]const u8) c_int;
pub const xmlIsElementName = e_xml_is_element_name;

/// Creates a new `xmlXPathContextPtr` on `doc` with preregistered
/// namespaces. The namepsaces are pair of (prefix, href), terminated
/// by `NULL`.
extern fn e_xml_new_xpath_context_with_namespaces(p_doc: *libxml2.Doc, ...) *anyopaque;
pub const xmlNewXpathContextWithNamespaces = e_xml_new_xpath_context_with_namespaces;

/// Parses XML data into an `libxml2.DocPtr`. Free returned pointer
/// with `xmlFreeDoc`, when no longer needed.
extern fn e_xml_parse_data(p_data: [*]const u8, p_length: usize) ?*libxml2.Doc;
pub const xmlParseData = e_xml_parse_data;

/// Reads a local XML file and parses the contents into an XML document
/// structure.  If the XML file cannot be read or its contents are malformed,
/// the function returns `NULL`.
extern fn e_xml_parse_file(p_filename: [*:0]const u8) ?*libxml2.Doc;
pub const xmlParseFile = e_xml_parse_file;

/// Writes the given XML document structure to the file given by `filename`.
/// If an error occurs while saving, the function returns -1 and sets errno.
extern fn e_xml_save_file(p_filename: [*:0]const u8, p_doc: *libxml2.Doc) c_int;
pub const xmlSaveFile = e_xml_save_file;

/// Creates a `glib.HashTable` representation of the `libxml2.Doc` `doc`.
/// If `type` is * `E_XML_HASH_TYPE_PROPERTY`, all XML nodes will be
/// indexed in the `glib.HashTable` by name. If `type` is
/// `E_XML_HASH_TYPE_OBJECT_UID`, then XML objects will be indexed in
/// the hash by their UID (other nodes will still be indexed by name).
extern fn e_xml_to_hash(p_doc: *libxml2.Doc, p_type: edataserver.XmlHashType) *glib.HashTable;
pub const xmlToHash = e_xml_to_hash;

/// Registers one or more additional namespaces. It's a caller's error
/// to try to register a namespace with the same prefix again, unless
/// the prefix uses the same namespace href.
extern fn e_xml_xpath_context_register_namespaces(p_xpath_ctx: *anyopaque, p_prefix: [*:0]const u8, p_href: [*:0]const u8, ...) void;
pub const xmlXpathContextRegisterNamespaces = e_xml_xpath_context_register_namespaces;

/// Evaluates path specified by `format` and returns its `xmlXPathObjectPtr`,
/// in case the path evaluates to a non-empty node set. See also
/// `edataserver.xmlXpathEvalAsString` which evaluates the path to string.
extern fn e_xml_xpath_eval(p_xpath_ctx: *anyopaque, p_format: [*:0]const u8, ...) ?*anyopaque;
pub const xmlXpathEval = e_xml_xpath_eval;

/// Evaluates path specified by `format` and returns its result as string,
/// in case the path evaluates to a non-empty node set. See also
/// `edataserver.xmlXpathEval` which evaluates the path to an `xmlXPathObjectPtr`.
extern fn e_xml_xpath_eval_as_string(p_xpath_ctx: *anyopaque, p_format: [*:0]const u8, ...) ?[*:0]u8;
pub const xmlXpathEvalAsString = e_xml_xpath_eval_as_string;

/// Evaluates path specified by `format` and returns whether it exists.
extern fn e_xml_xpath_eval_exists(p_xpath_ctx: *anyopaque, p_format: [*:0]const u8, ...) c_int;
pub const xmlXpathEvalExists = e_xml_xpath_eval_exists;

/// Adds a new key/value pair to the `edataserver.XmlHash` `hash`.
extern fn e_xmlhash_add(p_hash: *edataserver.XmlHash, p_key: [*:0]const u8, p_data: [*:0]const u8) void;
pub const xmlhashAdd = e_xmlhash_add;

/// Compares the value with key equal to `key` in `hash` against
/// `compare_data`.
extern fn e_xmlhash_compare(p_hash: *edataserver.XmlHash, p_key: [*:0]const u8, p_compare_data: [*:0]const u8) edataserver.XmlHashStatus;
pub const xmlhashCompare = e_xmlhash_compare;

/// Frees the memory associated with `hash`.
extern fn e_xmlhash_destroy(p_hash: *edataserver.XmlHash) void;
pub const xmlhashDestroy = e_xmlhash_destroy;

/// Executes `func` against each key/value pair in `hash`.
extern fn e_xmlhash_foreach_key(p_hash: *edataserver.XmlHash, p_func: edataserver.XmlHashFunc, p_user_data: ?*anyopaque) void;
pub const xmlhashForeachKey = e_xmlhash_foreach_key;

/// Calls `glib.hashTableForeachRemove` on `hash`<!-- -->'s internal hash
/// table.  See `glib.hashTableForeachRemove` for details.
extern fn e_xmlhash_foreach_key_remove(p_hash: *edataserver.XmlHash, p_func: edataserver.XmlHashRemoveFunc, p_user_data: ?*anyopaque) void;
pub const xmlhashForeachKeyRemove = e_xmlhash_foreach_key_remove;

/// Creates a new `edataserver.XmlHash` from the file `filename`. If `filename` does
/// not already exist, an empty `edataserver.XmlHash` will be created.
extern fn e_xmlhash_new(p_filename: [*:0]const u8) ?*edataserver.XmlHash;
pub const xmlhashNew = e_xmlhash_new;

/// Remove the entry in `hash` with key equal to `key`, if it exists.
extern fn e_xmlhash_remove(p_hash: *edataserver.XmlHash, p_key: [*:0]const u8) void;
pub const xmlhashRemove = e_xmlhash_remove;

/// Writes the XML represented by `hash` to the file originally passed
/// to `edataserver.xmlhashNew`.
extern fn e_xmlhash_write(p_hash: *edataserver.XmlHash) void;
pub const xmlhashWrite = e_xmlhash_write;

pub const FreeFormExpBuildSexpFunc = *const fn (p_word: [*:0]const u8, p_options: [*:0]const u8, p_hint: [*:0]const u8) callconv(.c) [*:0]u8;

/// Callback used to traverse response from the server, which is
/// an array.
pub const GDataObjectCallback = *const fn (p_gdata: *edataserver.GDataSession, p_object: *json.Object, p_user_data: ?*anyopaque) callconv(.c) c_int;

pub const OAuth2ServiceRefSourceFunc = *const fn (p_user_data: ?*anyopaque, p_uid: [*:0]const u8) callconv(.c) ?*edataserver.Source;

pub const SourceRefreshFunc = *const fn (p_source: *edataserver.Source, p_user_data: ?*anyopaque) callconv(.c) void;

/// Specifies the type of functions passed to `edataserver.typeTraverse`.
pub const TypeFunc = *const fn (p_type: usize, p_user_data: ?*anyopaque) callconv(.c) void;

pub const WebDAVDiscoverRefSourceFunc = *const fn (p_user_data: ?*anyopaque, p_uid: [*:0]const u8) callconv(.c) ?*edataserver.Source;

/// A callback function for `edataserver.WebDAVSession.propfindSync`,
/// `edataserver.WebDAVSession.reportSync` and other XML response with DAV:propstat
/// elements traversal functions.
///
/// The `prop_node` points to the actual property (prop) node and it can be examined
/// with `edataserver.xmlFindChild`, `edataserver.xmlFindChildrenNodes` and other provided XML helper functions.
pub const WebDAVPropstatTraverseFunc = *const fn (p_webdav: *edataserver.WebDAVSession, p_prop_node: *libxml2.Node, p_request_uri: *const glib.Uri, p_href: ?[*:0]const u8, p_status_code: c_uint, p_user_data: ?*anyopaque) callconv(.c) c_int;

pub const XmlHashFunc = *const fn (p_key: [*:0]const u8, p_value: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

pub const XmlHashRemoveFunc = *const fn (p_key: [*:0]const u8, p_value: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// The "cache-dir" property indicates the backend's local directory for
/// cached data.
pub const CLIENT_BACKEND_PROPERTY_CACHE_DIR = "cache-dir";
/// The "capabilities" property is a comma-separated list of capabilities
/// supported by the backend.  The preferred method of retrieving and working
/// with capabilities is `edataserver.Client.getCapabilities` and
/// `edataserver.Client.checkCapability`.
pub const CLIENT_BACKEND_PROPERTY_CAPABILITIES = "capabilities";
/// The "online" property is "TRUE" when the client is fully opened and
/// online, "FALSE" at all other times.  See also `edataserver.Client.isOnline`.
pub const CLIENT_BACKEND_PROPERTY_ONLINE = "online";
/// The "opened" property is "TRUE" when the client is fully opened,
/// "FALSE" at all other times.
pub const CLIENT_BACKEND_PROPERTY_OPENED = "opened";
/// The "opening" property is "TRUE" when the client is in the process of
/// opening, "FALSE" at all other times.
pub const CLIENT_BACKEND_PROPERTY_OPENING = "opening";
/// The "online" property is "TRUE" if the backend has only read access
/// to its data, "FALSE" if the backend can modify its data.  See also
/// `edataserver.Client.isReadonly`.
pub const CLIENT_BACKEND_PROPERTY_READONLY = "readonly";
/// The current overall revision string, this can be used as
/// a quick check to see if data has changed at all since the
/// last time the revision was observed.
pub const CLIENT_BACKEND_PROPERTY_REVISION = "revision";
pub const DEBUG_LOG_DOMAIN_CAL_QUERIES = "CalQueries";
pub const DEBUG_LOG_DOMAIN_GLOG = "GLog";
pub const DEBUG_LOG_DOMAIN_USER = "USER";
/// The major version number of the Evolution-Data-Server library.  Like
/// `eds_major_version`, but from the headers used at application compile
/// time, rather than from the library linked against at application run
/// time.
pub const EDS_MAJOR_VERSION = 3;
/// The micro version number of the Evolution-Data-Server library.  Like
/// `eds_micro_version`, but from the headers used at application compile
/// time, rather than from the library linked against at application run
/// time.
pub const EDS_MICRO_VERSION = 2;
/// The minor version number of the Evolution-Data-Server library.  Like
/// `eds_minor_version`, but from the headers used at application compile
/// time, rather than from the library linked against at application run
/// time.
pub const EDS_MINOR_VERSION = 56;
/// A special name, which can be used as a GIO name in the call
/// to `edataserver.NetworkMonitor.setGioName`, which is used to report
/// the network as always reachable.
pub const NETWORK_MONITOR_ALWAYS_ONLINE_NAME = "\"always-online\"";
pub const OAUTH2_SECRET_ACCESS_TOKEN = "access_token";
pub const OAUTH2_SECRET_EXPIRES_AFTER = "expires_after";
pub const OAUTH2_SECRET_REFRESH_TOKEN = "refresh_token";
/// A name of the named parameter used for passwords in credentials,
/// used to authenticate users with `edataserver.Source.invokeAuthenticateSync`
/// and `edataserver.Source.invokeAuthenticate`. The named parameter is optional,
/// different authentication methods can use different names.
pub const SOURCE_CREDENTIAL_PASSWORD = "password";
/// A name of the named parameter used for SSL/TLS trust in credentials,
/// used to authenticate users with `edataserver.Source.invokeAuthenticateSync`
/// and `edataserver.Source.invokeAuthenticate`. The named parameter is optional.
/// Its value corresponds to current ESourceWebdav::ssl-trust property,
/// in case the ESource has that extension available. This is required
/// to have up-to-date data on the server side, when the client side
/// just saved the SSL trust change, which might not be propagated
/// into the server (factory) side quickly enough. The key is added into
/// the credentials in `edataserver.Source.invokeAuthenticate` automatically, if the
/// corresponding ESource contain a WebDAV extension and the key
/// is not part of the credentials already.
pub const SOURCE_CREDENTIAL_SSL_TRUST = "ssl-trust";
/// A name of the named parameter used for usernames in credentials,
/// used to authenticate users with `edataserver.Source.invokeAuthenticateSync`
/// and `edataserver.Source.invokeAuthenticate`. The named parameter is optional,
/// different authentication methods can use different names.
pub const SOURCE_CREDENTIAL_USERNAME = "username";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceAddressBook`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_ADDRESS_BOOK = "Address Book";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceAlarms`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_ALARMS = "Alarms";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceAuthentication`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_AUTHENTICATION = "Authentication";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceAutocomplete`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_AUTOCOMPLETE = "Autocomplete";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceAutoconfig`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_AUTOCONFIG = "Autoconfig";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceCalendar`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_CALENDAR = "Calendar";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceCollection`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_COLLECTION = "Collection";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceContacts`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_CONTACTS_BACKEND = "Contacts Backend";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceGoa`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_GOA = "GNOME Online Accounts";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceLDAP`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_LDAP_BACKEND = "LDAP Backend";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceLocal`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_LOCAL_BACKEND = "Local Backend";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceMailAccount`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_MAIL_ACCOUNT = "Mail Account";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceMailComposition`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_MAIL_COMPOSITION = "Mail Composition";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceMailIdentity`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_MAIL_IDENTITY = "Mail Identity";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceMailSignature`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_MAIL_SIGNATURE = "Mail Signature";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceMailSubmission`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_MAIL_SUBMISSION = "Mail Submission";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceMailTransport`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_MAIL_TRANSPORT = "Mail Transport";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceMDN`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_MDN = "Message Disposition Notifications";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceMemoList`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_MEMO_LIST = "Memo List";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceOffline`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_OFFLINE = "Offline";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceOpenPGP`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_OPENPGP = "Pretty Good Privacy (OpenPGP)";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceProxy`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_PROXY = "Proxy";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceRefresh`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_REFRESH = "Refresh";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceResource`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_RESOURCE = "Resource";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceRevisionGuards`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_REVISION_GUARDS = "Revision Guards";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceSecurity`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_SECURITY = "Security";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceSMIME`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_SMIME = "Secure MIME (S/MIME)";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceTaskList`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_TASK_LIST = "Task List";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceUoa`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_UOA = "Ubuntu Online Accounts";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceWeather`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_WEATHER_BACKEND = "Weather Backend";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceWebdav`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_WEBDAV_BACKEND = "WebDAV Backend";
/// Pass this extension name to `edataserver.Source.getExtension` to access
/// `edataserver.SourceWebDAVNotes`.  This is also used as a group name in key files.
pub const SOURCE_EXTENSION_WEBDAV_NOTES = "WebDAV Notes";
/// Extends `gobject.ParamFlags` to indicate the `gobject.Object` property is associated
/// with a key file value.  Use this flag when installing `gobject.Object` properties
/// in `edataserver.SourceExtension` subclasses.
pub const SOURCE_PARAM_SETTING = 1;
pub const WEBDAV_CAPABILITY_ACCESS_CONTROL = "access-control";
pub const WEBDAV_CAPABILITY_ADDRESSBOOK = "addressbook";
pub const WEBDAV_CAPABILITY_BIND = "bind";
pub const WEBDAV_CAPABILITY_CALENDAR_ACCESS = "calendar-access";
pub const WEBDAV_CAPABILITY_CALENDAR_AUTO_SCHEDULE = "calendar-auto-schedule";
pub const WEBDAV_CAPABILITY_CALENDAR_PROXY = "calendar-proxy";
pub const WEBDAV_CAPABILITY_CALENDAR_SCHEDULE = "calendar-schedule";
pub const WEBDAV_CAPABILITY_CLASS_1 = "1";
pub const WEBDAV_CAPABILITY_CLASS_2 = "2";
pub const WEBDAV_CAPABILITY_CLASS_3 = "3";
pub const WEBDAV_CAPABILITY_EXTENDED_MKCOL = "extended-mkcol";
pub const WEBDAV_COLLATION_ASCII_CASEMAP = "i;";
pub const WEBDAV_COLLATION_ASCII_CASEMAP_SUFFIX = "ascii-casemap";
pub const WEBDAV_COLLATION_ASCII_NUMERIC = "i;";
pub const WEBDAV_COLLATION_ASCII_NUMERIC_SUFFIX = "ascii-numeric";
pub const WEBDAV_COLLATION_OCTET = "i;";
pub const WEBDAV_COLLATION_OCTET_SUFFIX = "octet";
pub const WEBDAV_COLLATION_UNICODE_CASEMAP = "i;";
pub const WEBDAV_COLLATION_UNICODE_CASEMAP_SUFFIX = "unicode-casemap";
pub const WEBDAV_CONTENT_TYPE_CALENDAR = "text/calendar; charset=\"utf-8\"";
pub const WEBDAV_CONTENT_TYPE_VCARD = "text/vcard; charset=\"utf-8\"";
pub const WEBDAV_CONTENT_TYPE_XML = "application/xml; charset=\"utf-8\"";
pub const WEBDAV_DEPTH_INFINITY = "infinity";
pub const WEBDAV_DEPTH_THIS = "0";
pub const WEBDAV_DEPTH_THIS_AND_CHILDREN = "1";
pub const WEBDAV_NS_CALDAV = "urn:ietf:params:xml:ns:caldav";
pub const WEBDAV_NS_CALENDARSERVER = "http://calendarserver.org/ns/";
pub const WEBDAV_NS_CARDDAV = "urn:ietf:params:xml:ns:carddav";
pub const WEBDAV_NS_DAV = "DAV:";
pub const WEBDAV_NS_ICAL = "http://apple.com/ns/ical/";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
