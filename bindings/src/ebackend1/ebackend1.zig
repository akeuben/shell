pub const ext = @import("ext.zig");
const ebackend = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const edataserver = @import("edataserver1");
const libxml2 = @import("libxml22");
const soup = @import("soup3");
const json = @import("json1");
const camel = @import("camel1");
/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const Backend = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ebackend.BackendClass;
    f_parent: gobject.Object,
    f_priv: ?*ebackend.BackendPrivate,

    pub const virtual_methods = struct {
        /// Authenticate synchronously
        pub const authenticate_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_credentials: *const edataserver.NamedParameters, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) edataserver.SourceAuthenticationResult {
                return gobject.ext.as(Backend.Class, p_class).f_authenticate_sync.?(gobject.ext.as(Backend, p_backend), p_credentials, p_out_certificate_pem, p_out_certificate_errors, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_credentials: *const edataserver.NamedParameters, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) edataserver.SourceAuthenticationResult) void {
                gobject.ext.as(Backend.Class, p_class).f_authenticate_sync = @ptrCast(p_implementation);
            }
        };

        /// Provides destination server host name and port to which
        /// the backend connects. This is used to determine required
        /// connection point for `ebackend.Backend.isDestinationReachable`.
        /// The `host` is a newly allocated string, which will be freed
        /// with `glib.free`. When `backend` sets both `host` and `port`, then
        /// it should return `TRUE`, indicating it's a remote backend.
        /// Default implementation returns `FALSE`, which is treated
        /// like the backend is local, no checking for server reachability
        /// is possible.
        pub const get_destination_address = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_host: *[*:0]u8, p_port: *u16) c_int {
                return gobject.ext.as(Backend.Class, p_class).f_get_destination_address.?(gobject.ext.as(Backend, p_backend), p_host, p_port);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_host: *[*:0]u8, p_port: *u16) callconv(.c) c_int) void {
                gobject.ext.as(Backend.Class, p_class).f_get_destination_address = @ptrCast(p_implementation);
            }
        };

        /// Let's the `backend` know that it'll be shut down shortly, no client connects
        /// to it anymore. The `backend` can free any resources which reference it, for
        /// example the opened views.
        pub const prepare_shutdown = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Backend.Class, p_class).f_prepare_shutdown.?(gobject.ext.as(Backend, p_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Backend.Class, p_class).f_prepare_shutdown = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const connectable = struct {
            pub const name = "connectable";

            pub const Type = ?*gio.SocketConnectable;
        };

        pub const main_context = struct {
            pub const name = "main-context";

            pub const Type = ?*glib.MainContext;
        };

        pub const online = struct {
            pub const name = "online";

            pub const Type = c_int;
        };

        pub const source = struct {
            pub const name = "source";

            pub const Type = ?*edataserver.Source;
        };

        pub const user_prompter = struct {
            pub const name = "user-prompter";

            pub const Type = ?*ebackend.UserPrompter;
        };
    };

    pub const signals = struct {};

    /// Asynchronously calls the `ebackend.Backend.credentialsRequiredSync` on the `backend`,
    /// to inform clients that credentials are required.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `ebackend.Backend.credentialsRequiredFinish` to get the result of the operation.
    extern fn e_backend_credentials_required(p_backend: *Backend, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: ?*const glib.Error, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const credentialsRequired = e_backend_credentials_required;

    /// Finishes the operation started with `ebackend.Backend.credentialsRequired`.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_backend_credentials_required_finish(p_backend: *Backend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const credentialsRequiredFinish = e_backend_credentials_required_finish;

    /// Synchronously lets the clients know that the backned requires credentials to be
    /// properly opened. It's a proxy function for `edataserver.Source.invokeCredentialsRequiredSync`,
    /// where can be found more information about actual parameters meaning.
    ///
    /// The provided credentials are received through `ebackend.BackendClass.virtual_methods.authenticate_sync`
    /// method asynchronously.
    ///
    /// If an error occurs, the function sets `error` and returns `FALSE`.
    extern fn e_backend_credentials_required_sync(p_backend: *Backend, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: ?*const glib.Error, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const credentialsRequiredSync = e_backend_credentials_required_sync;

    /// Makes sure that the "online" property is updated, that is, if there
    /// is any destination reachability test pending, it'll be done immediately
    /// and the only state will be updated as well.
    extern fn e_backend_ensure_online_state_updated(p_backend: *Backend, p_cancellable: ?*gio.Cancellable) void;
    pub const ensureOnlineStateUpdated = e_backend_ensure_online_state_updated;

    /// Makes sure that the associated ESource::connection-status is connected. This is
    /// useful in cases when the backend can connect to the destination without invoking
    /// `ebackend.BackendClass.virtual_methods.authenticate_sync`, possibly through `ebackend.Backend.scheduleAuthenticate`.
    extern fn e_backend_ensure_source_status_connected(p_backend: *Backend) void;
    pub const ensureSourceStatusConnected = e_backend_ensure_source_status_connected;

    /// Provides destination server host name and port to which
    /// the backend connects. This is used to determine required
    /// connection point for `ebackend.Backend.isDestinationReachable`.
    /// The `host` is a newly allocated string, which will be freed
    /// with `glib.free`. When `backend` sets both `host` and `port`, then
    /// it should return `TRUE`, indicating it's a remote backend.
    /// Default implementation returns `FALSE`, which is treated
    /// like the backend is local, no checking for server reachability
    /// is possible.
    extern fn e_backend_get_destination_address(p_backend: *Backend, p_host: *[*:0]u8, p_port: *u16) c_int;
    pub const getDestinationAddress = e_backend_get_destination_address;

    /// Returns a `gio.NetworkMonitor` used to check whether the backend can
    /// access the remote server. The instance is owned by the `backend`.
    extern fn e_backend_get_network_monitor(p_backend: *Backend) *gio.NetworkMonitor;
    pub const getNetworkMonitor = e_backend_get_network_monitor;

    /// Returns the online state of `backend`: `TRUE` if `backend` is online,
    /// `FALSE` if offline.
    ///
    /// If the `ebackend.Backend.properties.connectable` property is non-`NULL`, the `backend` will
    /// automatically determine whether the network service should be reachable,
    /// and hence whether the `backend` is `ebackend.Backend.properties.online`.  But subclasses may
    /// override the online state if, for example, a connection attempt fails.
    extern fn e_backend_get_online(p_backend: *Backend) c_int;
    pub const getOnline = e_backend_get_online;

    /// Returns the `edataserver.Source` to which `backend` is paired.
    extern fn e_backend_get_source(p_backend: *Backend) *edataserver.Source;
    pub const getSource = e_backend_get_source;

    /// Gets an instance of `ebackend.UserPrompter`, associated with this `backend`.
    ///
    /// The returned instance is owned by the `backend`.
    extern fn e_backend_get_user_prompter(p_backend: *Backend) ?*anyopaque;
    pub const getUserPrompter = e_backend_get_user_prompter;

    /// Checks whether the `backend`<!-- -->'s destination server, as returned
    /// by `ebackend.Backend.getDestinationAddress`, is reachable.
    /// If the `ebackend.Backend.getDestinationAddress` returns `FALSE`, this function
    /// returns `TRUE`, meaning the destination is always reachable.
    /// This uses `gio.NetworkMonitor`<!-- -->'s `gio.NetworkMonitor.canReach`
    /// for reachability tests.
    extern fn e_backend_is_destination_reachable(p_backend: *Backend, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const isDestinationReachable = e_backend_is_destination_reachable;

    /// Let's the `backend` know that it'll be shut down shortly, no client connects
    /// to it anymore. The `backend` can free any resources which reference it, for
    /// example the opened views.
    extern fn e_backend_prepare_shutdown(p_backend: *Backend) void;
    pub const prepareShutdown = e_backend_prepare_shutdown;

    /// Returns the socket endpoint for the network service to which `backend`
    /// is a client, or `NULL` if `backend` does not use network sockets.
    ///
    /// The initial value of the `ebackend.Backend.properties.connectable` property is derived from
    /// the `edataserver.SourceAuthentication` extension of the `backend`'s `ebackend.Backend.properties.source`
    /// property, if the extension is present.
    ///
    /// The returned `gio.SocketConnectable` is referenced for thread-safety and
    /// must be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_backend_ref_connectable(p_backend: *Backend) ?*gio.SocketConnectable;
    pub const refConnectable = e_backend_ref_connectable;

    /// Returns the `glib.MainContext` on which event sources for `backend` are to
    /// be attached.
    ///
    /// The returned `glib.MainContext` is referenced for thread-safety and must be
    /// unreferenced with `glib.MainContext.unref` when finished with it.
    extern fn e_backend_ref_main_context(p_backend: *Backend) *glib.MainContext;
    pub const refMainContext = e_backend_ref_main_context;

    /// Schedules a new authenticate session, cancelling any previously run.
    /// This is usually done automatically, when an 'authenticate' signal is
    /// received for the associated `edataserver.Source`. With `NULL` `credentials` an attempt
    /// without it is run.
    extern fn e_backend_schedule_authenticate(p_backend: *Backend, p_credentials: ?*const edataserver.NamedParameters) void;
    pub const scheduleAuthenticate = e_backend_schedule_authenticate;

    /// Asynchronously invokes `ebackend.Backend.credentialsRequired`, but installs its
    /// own callback which only prints a runtime warning on the console when
    /// the call fails. The `who_calls` is a prefix of the console message.
    /// This is useful when the caller just wants to start the operation
    /// without having actual place where to show the operation result.
    extern fn e_backend_schedule_credentials_required(p_backend: *Backend, p_reason: edataserver.SourceCredentialsReason, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_op_error: ?*const glib.Error, p_cancellable: ?*gio.Cancellable, p_who_calls: ?[*:0]const u8) void;
    pub const scheduleCredentialsRequired = e_backend_schedule_credentials_required;

    /// Sets the socket endpoint for the network service to which `backend` is
    /// a client.  This can be `NULL` if `backend` does not use network sockets.
    ///
    /// The initial value of the `ebackend.Backend.properties.connectable` property is derived from
    /// the `edataserver.SourceAuthentication` extension of the `backend`'s `ebackend.Backend.properties.source`
    /// property, if the extension is present.
    extern fn e_backend_set_connectable(p_backend: *Backend, p_connectable: *gio.SocketConnectable) void;
    pub const setConnectable = e_backend_set_connectable;

    /// Sets the online state of `backend`: `TRUE` if `backend` is online,
    /// `FALSE` if offline.
    ///
    /// If the `ebackend.Backend.properties.connectable` property is non-`NULL`, the `backend` will
    /// automatically determine whether the network service should be reachable,
    /// and hence whether the `backend` is `ebackend.Backend.properties.online`.  But subclasses may
    /// override the online state if, for example, a connection attempt fails.
    extern fn e_backend_set_online(p_backend: *Backend, p_online: c_int) void;
    pub const setOnline = e_backend_set_online;

    /// Initiates a user trust prompt with given `parameters`.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `ebackend.Backend.trustPromptFinish` to get the result of the operation.
    extern fn e_backend_trust_prompt(p_backend: *Backend, p_parameters: *const edataserver.NamedParameters, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const trustPrompt = e_backend_trust_prompt;

    /// Finishes the operation started with `ebackend.Backend.trustPrompt`.
    /// If an error occurred, the function will set `error` and return
    /// `E_TRUST_PROMPT_RESPONSE_UNKNOWN`.
    extern fn e_backend_trust_prompt_finish(p_backend: *Backend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) edataserver.TrustPromptResponse;
    pub const trustPromptFinish = e_backend_trust_prompt_finish;

    /// Asks a user a trust prompt with given `parameters`, and returns what
    /// user responded. This blocks until the response is delivered.
    extern fn e_backend_trust_prompt_sync(p_backend: *Backend, p_parameters: *const edataserver.NamedParameters, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) edataserver.TrustPromptResponse;
    pub const trustPromptSync = e_backend_trust_prompt_sync;

    extern fn e_backend_get_type() usize;
    pub const getGObjectType = e_backend_get_type;

    extern fn g_object_ref(p_self: *ebackend.Backend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.Backend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Backend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const BackendFactory = extern struct {
    pub const Parent = edataserver.Extension;
    pub const Implements = [_]type{};
    pub const Class = ebackend.BackendFactoryClass;
    f_parent: edataserver.Extension,
    f_priv: ?*ebackend.BackendFactoryPrivate,

    pub const virtual_methods = struct {
        /// Returns a hash key which uniquely identifies `factory`.
        ///
        /// Since only one instance of each `ebackend.BackendFactory` subclass is ever created,
        /// the hash key need only be unique among subclasses, not among instances of
        /// each subclass.
        pub const get_hash_key = struct {
            pub fn call(p_class: anytype, p_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(BackendFactory.Class, p_class).f_get_hash_key.?(gobject.ext.as(BackendFactory, p_factory));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(BackendFactory.Class, p_class).f_get_hash_key = @ptrCast(p_implementation);
            }
        };

        /// Returns a new `ebackend.Backend` instance for `source`.
        pub const new_backend = struct {
            pub fn call(p_class: anytype, p_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) *ebackend.Backend {
                return gobject.ext.as(BackendFactory.Class, p_class).f_new_backend.?(gobject.ext.as(BackendFactory, p_factory), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) *ebackend.Backend) void {
                gobject.ext.as(BackendFactory.Class, p_class).f_new_backend = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a hash key which uniquely identifies `factory`.
    ///
    /// Since only one instance of each `ebackend.BackendFactory` subclass is ever created,
    /// the hash key need only be unique among subclasses, not among instances of
    /// each subclass.
    extern fn e_backend_factory_get_hash_key(p_factory: *BackendFactory) [*:0]const u8;
    pub const getHashKey = e_backend_factory_get_hash_key;

    /// Returns the filename of the shared library for the module used
    /// to load the backends provided by `factory`.
    extern fn e_backend_factory_get_module_filename(p_factory: *BackendFactory) [*:0]const u8;
    pub const getModuleFilename = e_backend_factory_get_module_filename;

    /// Returns a new `ebackend.Backend` instance for `source`.
    extern fn e_backend_factory_new_backend(p_factory: *BackendFactory, p_source: *edataserver.Source) *ebackend.Backend;
    pub const newBackend = e_backend_factory_new_backend;

    /// Returns TRUE if the `factory` wants to share the subprocess
    /// for all backends provided by itself. Otherwise, returns FALSE.
    extern fn e_backend_factory_share_subprocess(p_factory: *BackendFactory) c_int;
    pub const shareSubprocess = e_backend_factory_share_subprocess;

    extern fn e_backend_factory_get_type() usize;
    pub const getGObjectType = e_backend_factory_get_type;

    extern fn g_object_ref(p_self: *ebackend.BackendFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.BackendFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BackendFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const Cache = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ebackend.CacheClass;
    f_parent: gobject.Object,
    f_priv: ?*ebackend.CachePrivate,

    pub const virtual_methods = struct {
        pub const before_put = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_other_columns: *ebackend.CacheColumnValues, p_is_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Cache.Class, p_class).f_before_put.?(gobject.ext.as(Cache, p_cache), p_uid, p_revision, p_object, p_other_columns, p_is_replace, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_other_columns: *ebackend.CacheColumnValues, p_is_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Cache.Class, p_class).f_before_put = @ptrCast(p_implementation);
            }
        };

        pub const before_remove = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Cache.Class, p_class).f_before_remove.?(gobject.ext.as(Cache, p_cache), p_uid, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Cache.Class, p_class).f_before_remove = @ptrCast(p_implementation);
            }
        };

        pub const clear_offline_changes_locked = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Cache.Class, p_class).f_clear_offline_changes_locked.?(gobject.ext.as(Cache, p_cache), p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Cache.Class, p_class).f_clear_offline_changes_locked = @ptrCast(p_implementation);
            }
        };

        /// Erases the cache and all of its content from the disk.
        /// The only valid operation after this is to free the `cache`.
        pub const erase = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Cache.Class, p_class).f_erase.?(gobject.ext.as(Cache, p_cache));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Cache.Class, p_class).f_erase = @ptrCast(p_implementation);
            }
        };

        pub const put_locked = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_other_columns: *ebackend.CacheColumnValues, p_offline_state: ebackend.OfflineState, p_is_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Cache.Class, p_class).f_put_locked.?(gobject.ext.as(Cache, p_cache), p_uid, p_revision, p_object, p_other_columns, p_offline_state, p_is_replace, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_other_columns: *ebackend.CacheColumnValues, p_offline_state: ebackend.OfflineState, p_is_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Cache.Class, p_class).f_put_locked = @ptrCast(p_implementation);
            }
        };

        pub const remove_all_locked = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *const glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Cache.Class, p_class).f_remove_all_locked.?(gobject.ext.as(Cache, p_cache), p_uids, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uids: *const glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Cache.Class, p_class).f_remove_all_locked = @ptrCast(p_implementation);
            }
        };

        pub const remove_locked = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(Cache.Class, p_class).f_remove_locked.?(gobject.ext.as(Cache, p_cache), p_uid, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(Cache.Class, p_class).f_remove_locked = @ptrCast(p_implementation);
            }
        };

        pub const revision_changed = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Cache.Class, p_class).f_revision_changed.?(gobject.ext.as(Cache, p_cache));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Cache.Class, p_class).f_revision_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const before_put = struct {
            pub const name = "before-put";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, p_p0: [*:0]u8, p_p1: [*:0]u8, p_p2: *ebackend.CacheColumnValues, p_p3: c_int, p_p4: ?*gio.Cancellable, p_p5: ?*anyopaque, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Cache, p_instance))),
                    gobject.signalLookup("before-put", Cache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const before_remove = struct {
            pub const name = "before-remove";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, p_p0: ?*gio.Cancellable, p_p1: ?*anyopaque, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Cache, p_instance))),
                    gobject.signalLookup("before-remove", Cache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const revision_changed = struct {
            pub const name = "revision-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Cache, p_instance))),
                    gobject.signalLookup("revision-changed", Cache.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn e_cache_error_quark() glib.Quark;
    pub const errorQuark = e_cache_error_quark;

    /// Appends an SQLite statement fragment based on the `format` and
    /// its arguments to the `stmt`.
    /// The `format` can contain any values recognized by `sqlite3_mprintf`.
    extern fn e_cache_sqlite_stmt_append_printf(p_stmt: *glib.String, p_format: [*:0]const u8, ...) void;
    pub const sqliteStmtAppendPrintf = e_cache_sqlite_stmt_append_printf;

    /// Frees a statement previously constructed with `ebackend.Cache.sqliteStmtPrintf`.
    extern fn e_cache_sqlite_stmt_free(p_stmt: [*:0]u8) void;
    pub const sqliteStmtFree = e_cache_sqlite_stmt_free;

    /// Creates an SQLite statement based on the `format` and its arguments.
    /// The `format` can contain any values recognized by `sqlite3_mprintf`.
    extern fn e_cache_sqlite_stmt_printf(p_format: [*:0]const u8, ...) [*:0]u8;
    pub const sqliteStmtPrintf = e_cache_sqlite_stmt_printf;

    /// Instructs the `cache` to change its revision. In case the revision
    /// change is frozen with `ebackend.Cache.freezeRevisionChange` it notes to
    /// change the revision once the revision change is fully thaw.
    extern fn e_cache_change_revision(p_cache: *Cache) void;
    pub const changeRevision = e_cache_change_revision;

    /// Marks all objects as being fully synchronized with the server and
    /// removes those which are marked as locally deleted.
    extern fn e_cache_clear_offline_changes(p_cache: *Cache, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const clearOfflineChanges = e_cache_clear_offline_changes;

    /// Checkes whether the `cache` contains an object with
    /// the given `uid`.
    extern fn e_cache_contains(p_cache: *Cache, p_uid: [*:0]const u8, p_deleted_flag: ebackend.CacheDeletedFlag) c_int;
    pub const contains = e_cache_contains;

    /// Adds every column value which is not part of the `other_columns` to it,
    /// except of E_CACHE_COLUMN_UID, E_CACHE_COLUMN_REVISION, E_CACHE_COLUMN_OBJECT
    /// and E_CACHE_COLUMN_STATE columns.
    ///
    /// This can be used within the callback of `ebackend.Cache.foreachUpdate`.
    extern fn e_cache_copy_missing_to_column_values(p_cache: *Cache, p_ncols: c_int, p_column_names: [*][*:0]const u8, p_column_values: [*][*:0]const u8, p_other_columns: *ebackend.CacheColumnValues) void;
    pub const copyMissingToColumnValues = e_cache_copy_missing_to_column_values;

    extern fn e_cache_dup_key(p_cache: *Cache, p_key: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const dupKey = e_cache_dup_key;

    extern fn e_cache_dup_revision(p_cache: *Cache) [*:0]u8;
    pub const dupRevision = e_cache_dup_revision;

    /// Erases the cache and all of its content from the disk.
    /// The only valid operation after this is to free the `cache`.
    extern fn e_cache_erase(p_cache: *Cache) void;
    pub const erase = e_cache_erase;

    /// Calls `func` for each found object, which satisfies the criteria
    /// for both `deleted_flag` and `where_clause`.
    ///
    /// Note the `func` should not call any SQLite commands, because it's invoked
    /// within a SELECT statement execution.
    extern fn e_cache_foreach(p_cache: *Cache, p_deleted_flag: ebackend.CacheDeletedFlag, p_where_clause: ?[*:0]const u8, p_func: ebackend.CacheForeachFunc, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const foreach = e_cache_foreach;

    /// Calls `func` for each found object, which satisfies the criteria for both
    /// `deleted_flag` and `where_clause`, letting the caller update values where
    /// necessary. The return value of `func` is used to determine whether the call
    /// was successful, not whether there are any changes to be saved. If anything
    /// fails during the call then the all changes are reverted.
    ///
    /// When there are requested any changes by the `func`, this function also
    /// calls `ebackend.Cache.copyMissingToColumnValues` to ensure no descendant
    /// column data is lost.
    extern fn e_cache_foreach_update(p_cache: *Cache, p_deleted_flag: ebackend.CacheDeletedFlag, p_where_clause: ?[*:0]const u8, p_func: ebackend.CacheUpdateFunc, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const foreachUpdate = e_cache_foreach_update;

    /// Freezes automatic revision change for the `cache`. The function
    /// can be called multiple times, but each such call requires its
    /// pair function `ebackend.Cache.thawRevisionChange` call. See also
    /// `ebackend.Cache.changeRevision`.
    extern fn e_cache_freeze_revision_change(p_cache: *Cache) void;
    pub const freezeRevisionChange = e_cache_freeze_revision_change;

    /// Returns an object with the given `uid`. This function does not consider locally
    /// deleted objects. The `out_revision` is set to the object revision, if not `NULL`.
    /// Free it with `glib.free` when no longer needed. Similarly the `out_other_columns`
    /// contains a column name to column value strings for additional columns which had
    /// been requested when calling `ebackend.Cache.initializeSync`, if not `NULL`.
    /// Free the returned `ebackend.CacheColumnValues` with `ebackend.CacheColumnValues.free`, when
    /// no longer needed.
    extern fn e_cache_get(p_cache: *Cache, p_uid: [*:0]const u8, p_out_revision: ?*[*:0]u8, p_out_other_columns: ?**ebackend.CacheColumnValues, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const get = e_cache_get;

    extern fn e_cache_get_count(p_cache: *Cache, p_deleted_flag: ebackend.CacheDeletedFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_uint;
    pub const getCount = e_cache_get_count;

    extern fn e_cache_get_filename(p_cache: *Cache) [*:0]const u8;
    pub const getFilename = e_cache_get_filename;

    /// Reads the user `key` value as an integer.
    extern fn e_cache_get_key_int(p_cache: *Cache, p_key: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const getKeyInt = e_cache_get_key_int;

    /// The same as `ebackend.Cache.get`, only considers also locally deleted objects.
    extern fn e_cache_get_object_include_deleted(p_cache: *Cache, p_uid: [*:0]const u8, p_out_revision: ?*[*:0]u8, p_out_other_columns: ?**ebackend.CacheColumnValues, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getObjectIncludeDeleted = e_cache_get_object_include_deleted;

    /// Gets a list of objects stored in the `cache`, optionally together with
    /// their revisions. The uids are not returned in any particular order,
    /// but the position between `out_objects` and `out_revisions` matches
    /// the same object.
    ///
    /// Both `out_objects` and `out_revisions` contain newly allocated `glib.SList`, which
    /// should be freed with g_slist_free_full (slist, g_free); when no longer needed.
    extern fn e_cache_get_objects(p_cache: *Cache, p_deleted_flag: ebackend.CacheDeletedFlag, p_out_objects: **glib.SList, p_out_revisions: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getObjects = e_cache_get_objects;

    /// Gathers the list of all offline changes being done so far.
    /// The returned `glib.SList` contains `ebackend.CacheOfflineChange` structure.
    /// Use `ebackend.Cache.clearOfflineChanges` to clear all offline
    /// changes at once.
    extern fn e_cache_get_offline_changes(p_cache: *Cache, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.SList;
    pub const getOfflineChanges = e_cache_get_offline_changes;

    extern fn e_cache_get_offline_state(p_cache: *Cache, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ebackend.OfflineState;
    pub const getOfflineState = e_cache_get_offline_state;

    extern fn e_cache_get_sqlitedb(p_cache: *Cache) ?*anyopaque;
    pub const getSqlitedb = e_cache_get_sqlitedb;

    /// Gets a list of unique object identifiers stored in the `cache`, optionally
    /// together with their revisions. The uids are not returned in any particular
    /// order, but the position between `out_uids` and `out_revisions` matches
    /// the same object.
    ///
    /// Both `out_uids` and `out_revisions` contain newly allocated `glib.SList`, which
    /// should be freed with g_slist_free_full (slist, g_free); when no longer needed.
    extern fn e_cache_get_uids(p_cache: *Cache, p_deleted_flag: ebackend.CacheDeletedFlag, p_out_uids: **glib.SList, p_out_revisions: ?**glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getUids = e_cache_get_uids;

    extern fn e_cache_get_version(p_cache: *Cache) c_int;
    pub const getVersion = e_cache_get_version;

    /// Initializes the `cache` and opens the `filename` database.
    /// This should be called by the descendant.
    ///
    /// The `other_columns` are added to the objects table (`E_CACHE_TABLE_OBJECTS`).
    /// Values for these columns are returned by `ebackend.Cache.get`
    /// and can be stored with `ebackend.Cache.put`.
    extern fn e_cache_initialize_sync(p_cache: *Cache, p_filename: [*:0]const u8, p_other_columns: ?*const glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const initializeSync = e_cache_initialize_sync;

    extern fn e_cache_is_revision_change_frozen(p_cache: *Cache) c_int;
    pub const isRevisionChangeFrozen = e_cache_is_revision_change_frozen;

    /// Locks the `cache` thus other threads cannot use it.
    /// This can be called recursively within one thread.
    /// Each call should have its pair `ebackend.Cache.unlock`.
    extern fn e_cache_lock(p_cache: *Cache, p_lock_type: ebackend.CacheLockType) void;
    pub const lock = e_cache_lock;

    /// Stores an object into the cache. Depending on `offline_flag`, this update
    /// the object's offline state accordingly. When the `offline_flag` is set
    /// to `E_CACHE_IS_ONLINE`, then it's set to `E_OFFLINE_STATE_SYNCED`, like
    /// to be fully synchronized with the server, regardless of its previous
    /// offline state. Overwriting locally deleted object behaves like an addition
    /// of a completely new object.
    extern fn e_cache_put(p_cache: *Cache, p_uid: [*:0]const u8, p_revision: ?[*:0]const u8, p_object: [*:0]const u8, p_other_columns: ?*ebackend.CacheColumnValues, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const put = e_cache_put;

    /// Removes the object with the given `uid` from the `cache`. Based on the `offline_flag`,
    /// it can remove also any information about locally made offline changes. Removing
    /// the object with `E_CACHE_IS_OFFLINE` will still remember it for later use
    /// with `ebackend.Cache.getOfflineChanges`.
    extern fn e_cache_remove(p_cache: *Cache, p_uid: [*:0]const u8, p_offline_flag: ebackend.CacheOfflineFlag, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const remove = e_cache_remove;

    /// Removes all objects from the `cache` in one call.
    extern fn e_cache_remove_all(p_cache: *Cache, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeAll = e_cache_remove_all;

    /// Sets a `value` of the user `key`, or deletes it, if the `value` is `NULL`.
    extern fn e_cache_set_key(p_cache: *Cache, p_key: [*:0]const u8, p_value: ?[*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const setKey = e_cache_set_key;

    /// Sets an integer `value` for the user `key`.
    extern fn e_cache_set_key_int(p_cache: *Cache, p_key: [*:0]const u8, p_value: c_int, p_error: ?*?*glib.Error) c_int;
    pub const setKeyInt = e_cache_set_key_int;

    /// Sets an offline `state` for the object identified by `uid`.
    extern fn e_cache_set_offline_state(p_cache: *Cache, p_uid: [*:0]const u8, p_state: ebackend.OfflineState, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const setOfflineState = e_cache_set_offline_state;

    /// Sets the `revision` of the whole `cache`. This is not meant to be
    /// used by the descendants, because the revision is updated automatically
    /// when needed. The descendants can listen to "revision-changed" signal.
    extern fn e_cache_set_revision(p_cache: *Cache, p_revision: ?[*:0]const u8) void;
    pub const setRevision = e_cache_set_revision;

    /// Sets a cache data version. This is meant to be used by the descendants.
    /// The `version` should be greater than zero.
    extern fn e_cache_set_version(p_cache: *Cache, p_version: c_int) void;
    pub const setVersion = e_cache_set_version;

    /// Executes an SQLite statement. Use `ebackend.Cache.sqliteSelect` for
    /// SELECT statements.
    extern fn e_cache_sqlite_exec(p_cache: *Cache, p_sql_stmt: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const sqliteExec = e_cache_sqlite_exec;

    /// Runs vacuum (compacts the database file), if needed.
    extern fn e_cache_sqlite_maybe_vacuum(p_cache: *Cache, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const sqliteMaybeVacuum = e_cache_sqlite_maybe_vacuum;

    /// Executes a SELECT statement `sql_stmt` and calls `func` for each row of the result.
    /// Use `ebackend.Cache.sqliteExec` for statements which do not return row sets.
    extern fn e_cache_sqlite_select(p_cache: *Cache, p_sql_stmt: [*:0]const u8, p_func: ebackend.CacheSelectFunc, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const sqliteSelect = e_cache_sqlite_select;

    /// Thaws automatic revision change for the `cache`. It's the pair
    /// function of `ebackend.Cache.freezeRevisionChange`.
    extern fn e_cache_thaw_revision_change(p_cache: *Cache) void;
    pub const thawRevisionChange = e_cache_thaw_revision_change;

    /// Unlocks the cache which was previouly locked with `ebackend.Cache.lock`.
    /// The cache locked with `E_CACHE_LOCK_WRITE` should use either
    /// `action` `E_CACHE_UNLOCK_COMMIT` or `E_CACHE_UNLOCK_ROLLBACK`,
    /// while the `E_CACHE_LOCK_READ` should use `E_CACHE_UNLOCK_NONE` `action`.
    extern fn e_cache_unlock(p_cache: *Cache, p_action: ebackend.CacheUnlockAction) void;
    pub const unlock = e_cache_unlock;

    extern fn e_cache_get_type() usize;
    pub const getGObjectType = e_cache_get_type;

    extern fn g_object_ref(p_self: *ebackend.Cache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.Cache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Cache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CacheKeys = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ebackend.CacheKeysClass;
    f_parent: gobject.Object,
    f_priv: ?*ebackend.CacheKeysPrivate,

    pub const virtual_methods = struct {
        pub const changed = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(CacheKeys.Class, p_class).f_changed.?(gobject.ext.as(CacheKeys, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(CacheKeys.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The `ebackend.Cache` being used for this keys table.
        pub const cache = struct {
            pub const name = "cache";

            pub const Type = ?*ebackend.Cache;
        };

        /// The column name for the keys.
        pub const key_column_name = struct {
            pub const name = "key-column-name";

            pub const Type = ?[*:0]u8;
        };

        /// The table name of this keys table.
        pub const table_name = struct {
            pub const name = "table-name";

            pub const Type = ?[*:0]u8;
        };

        /// The column name for the values.
        pub const value_column_name = struct {
            pub const name = "value-column-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// A signal emitted when the stored keys changed, aka when a new
        /// key is added or when an existing key is removed. It's not emitted
        /// when only a reference count changes for a key.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CacheKeys, p_instance))),
                    gobject.signalLookup("changed", CacheKeys.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `ebackend.CacheKeys`, which will operate with `table_name`,
    /// using column `key_column_name` to store keys and `value_column_name`
    /// to store values.
    ///
    /// The created `ebackend.CacheKeys` doesn't hold a reference to the `cache`,
    /// the caller is supposed to make sure the `cache` won't be freed before
    /// the `ebackend.CacheKeys` is freed. This is to avoid circular dependency between
    /// the `cache` and the `ebackend.CacheKeys`, when the `ECacheKey` is created
    /// by the `cache` itself (which is the expected use case).
    extern fn e_cache_keys_new(p_cache: *ebackend.Cache, p_table_name: [*:0]const u8, p_key_column_name: [*:0]const u8, p_value_column_name: [*:0]const u8) *ebackend.CacheKeys;
    pub const new = e_cache_keys_new;

    /// Counts how many keys the `self` stores and set it to the `out_n_stored`.
    extern fn e_cache_keys_count_keys_sync(p_self: *CacheKeys, p_out_n_stored: *i64, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const countKeysSync = e_cache_keys_count_keys_sync;

    /// Calls `func` for each stored key in the `self`, providing
    /// information about its value and reference count.
    extern fn e_cache_keys_foreach_sync(p_self: *CacheKeys, p_func: ebackend.CacheKeysForeachFunc, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const foreachSync = e_cache_keys_foreach_sync;

    /// Gets an `ebackend.Cache`, with which the `self` had been created.
    extern fn e_cache_keys_get_cache(p_self: *CacheKeys) *ebackend.Cache;
    pub const getCache = e_cache_keys_get_cache;

    /// Gets a key column name, with which the `self` had been created.
    extern fn e_cache_keys_get_key_column_name(p_self: *CacheKeys) [*:0]const u8;
    pub const getKeyColumnName = e_cache_keys_get_key_column_name;

    /// Gets currently stored reference count for the `key`.
    /// Note the reference count can be 0, which means the `key`
    /// is stored forever.
    extern fn e_cache_keys_get_ref_count_sync(p_self: *CacheKeys, p_key: [*:0]const u8, p_out_ref_count: *c_uint, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getRefCountSync = e_cache_keys_get_ref_count_sync;

    /// Gets a stored value with given `key`, which had been previously put
    /// into the `self` with `ebackend.CacheKeys.putSync`.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_cache_keys_get_sync(p_self: *CacheKeys, p_key: [*:0]const u8, p_out_value: *[*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const getSync = e_cache_keys_get_sync;

    /// Gets a table name, with which the `self` had been created.
    extern fn e_cache_keys_get_table_name(p_self: *CacheKeys) [*:0]const u8;
    pub const getTableName = e_cache_keys_get_table_name;

    /// Get a value column name, with which the `self` had been created.
    extern fn e_cache_keys_get_value_column_name(p_self: *CacheKeys) [*:0]const u8;
    pub const getValueColumnName = e_cache_keys_get_value_column_name;

    /// Initializes table in the corresponding `ebackend.Cache`.
    extern fn e_cache_keys_init_table_sync(p_self: *CacheKeys, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const initTableSync = e_cache_keys_init_table_sync;

    /// Puts the `key` and `value` into the `self`. The function adds a new or
    /// replaces an existing `key`, if any such already exists in the `self`.
    extern fn e_cache_keys_put_sync(p_self: *CacheKeys, p_key: [*:0]const u8, p_value: [*:0]const u8, p_inc_ref_counts: c_uint, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const putSync = e_cache_keys_put_sync;

    /// Removes all stored keys from the `self`.
    extern fn e_cache_keys_remove_all_sync(p_self: *CacheKeys, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeAllSync = e_cache_keys_remove_all_sync;

    /// Dereferences use count of the `key` by `dec_ref_counts` and removes it
    /// from the cache when the reference count reaches zero. Special case is
    /// with `dec_ref_counts` is zero, in which case the key is removed regardless
    /// of the current reference count.
    ///
    /// It's not an error when the key doesn't exist in the cache.
    extern fn e_cache_keys_remove_sync(p_self: *CacheKeys, p_key: [*:0]const u8, p_dec_ref_counts: c_uint, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const removeSync = e_cache_keys_remove_sync;

    extern fn e_cache_keys_get_type() usize;
    pub const getGObjectType = e_cache_keys_get_type;

    extern fn g_object_ref(p_self: *ebackend.CacheKeys) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.CacheKeys) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CacheKeys, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CacheReaper = opaque {
    pub const Parent = edataserver.Extension;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = ebackend.CacheReaperClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn e_cache_reaper_type_register(p_type_module: *gobject.TypeModule) void;
    pub const typeRegister = e_cache_reaper_type_register;

    /// Let's the `cache_reaper` know about a private directory named `name`,
    /// thus it won't delete it from cache or data directories. The `name`
    /// is just a directory name, not a path.
    ///
    /// Since 3.18
    extern fn e_cache_reaper_add_private_directory(p_cache_reaper: *CacheReaper, p_name: [*:0]const u8) void;
    pub const addPrivateDirectory = e_cache_reaper_add_private_directory;

    /// Remove private directory named `name` from the list of private
    /// directories in the `cache_reaper`, previously added with
    /// `ebackend.CacheReaper.addPrivateDirectory`.
    ///
    /// Since 3.18
    extern fn e_cache_reaper_remove_private_directory(p_cache_reaper: *CacheReaper, p_name: [*:0]const u8) void;
    pub const removePrivateDirectory = e_cache_reaper_remove_private_directory;

    extern fn e_cache_reaper_get_type() usize;
    pub const getGObjectType = e_cache_reaper_get_type;

    extern fn g_object_ref(p_self: *ebackend.CacheReaper) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.CacheReaper) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CacheReaper, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CollectionBackend = extern struct {
    pub const Parent = ebackend.Backend;
    pub const Implements = [_]type{};
    pub const Class = ebackend.CollectionBackendClass;
    f_parent: ebackend.Backend,
    f_priv: ?*ebackend.CollectionBackendPrivate,

    pub const virtual_methods = struct {
        pub const child_added = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_child_source: *edataserver.Source) void {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_child_added.?(gobject.ext.as(CollectionBackend, p_backend), p_child_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_child_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_child_added = @ptrCast(p_implementation);
            }
        };

        pub const child_removed = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_child_source: *edataserver.Source) void {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_child_removed.?(gobject.ext.as(CollectionBackend, p_backend), p_child_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_child_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_child_removed = @ptrCast(p_implementation);
            }
        };

        /// Asynchronously creates a server-side resource described by `source`.
        /// For example, if `source` describes a new calendar, an equivalent calendar
        /// is created on the server.
        ///
        /// It is the implementor's responsibility to examine `source` and determine
        /// what the equivalent server-side resource would be.  If this cannot be
        /// determined without ambiguity, the function must return an error.
        ///
        /// After the server-side resource is successfully created, the implementor
        /// must also add an `edataserver.Source` to `backend`'s `ebackend.CollectionBackend.properties.server`.  This
        /// can either be done immediately or in response to some "resource created"
        /// notification from the server.  The added `edataserver.Source` can be `source` itself
        /// or a different `edataserver.Source` instance that describes the new resource.
        ///
        /// When the operation is finished, `callback` will be called.  You can then
        /// call `ebackend.CollectionBackend.createResourceFinish` to get the result of
        /// the operation.
        pub const create_resource = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_create_resource.?(gobject.ext.as(CollectionBackend, p_backend), p_source, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_create_resource = @ptrCast(p_implementation);
            }
        };

        /// Finishes the operation started with `ebackend.CollectionBackend.createResource`.
        ///
        /// If an error occurred, the function will set `error` and return `FALSE`.
        pub const create_resource_finish = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_create_resource_finish.?(gobject.ext.as(CollectionBackend, p_backend), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_create_resource_finish = @ptrCast(p_implementation);
            }
        };

        /// Creates a server-side resource described by `source`.  For example, if
        /// `source` describes a new calendar, an equivalent calendar is created on
        /// the server.
        ///
        /// It is the implementor's responsibility to examine `source` and determine
        /// what the equivalent server-side resource would be.  If this cannot be
        /// determined without ambiguity, the function must return an error.
        ///
        /// After the server-side resource is successfully created, the implementor
        /// must also add an `edataserver.Source` to `backend`'s `ebackend.CollectionBackend.properties.server`.  This
        /// can either be done immediately or in response to some "resource created"
        /// notification from the server.  The added `edataserver.Source` can be `source` itself
        /// or a different `edataserver.Source` instance that describes the new resource.
        ///
        /// If an error occurs, the function will set `error` and return `FALSE`.
        pub const create_resource_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_create_resource_sync.?(gobject.ext.as(CollectionBackend, p_backend), p_source, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_create_resource_sync = @ptrCast(p_implementation);
            }
        };

        /// Asynchronously deletes a server-side resource described by `source`.
        /// The `source` must be a child of `backend`'s collection `ebackend.Backend.properties.source`.
        ///
        /// After the server-side resource is successfully deleted, the implementor
        /// must also remove `source` from the `backend`'s `ebackend.CollectionBackend.properties.server`.
        /// This can either be done immediately or in response to some "resource
        /// deleted" notification from the server.
        ///
        /// When the operation is finished, `callback` will be called.  You can then
        /// call `ebackend.CollectionBackend.deleteResourceFinish` to get the result of
        /// the operation.
        pub const delete_resource = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_delete_resource.?(gobject.ext.as(CollectionBackend, p_backend), p_source, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_delete_resource = @ptrCast(p_implementation);
            }
        };

        /// Finishes the operation started with `ebackend.CollectionBackend.deleteResource`.
        ///
        /// If an error occurred, the function will set `error` and return `FALSE`.
        pub const delete_resource_finish = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_delete_resource_finish.?(gobject.ext.as(CollectionBackend, p_backend), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_delete_resource_finish = @ptrCast(p_implementation);
            }
        };

        /// Deletes a server-side resource described by `source`.  The `source` must
        /// be a child of `backend`'s collection `ebackend.Backend.properties.source`.
        ///
        /// After the server-side resource is successfully deleted, the implementor
        /// must also remove `source` from the `backend`'s `ebackend.CollectionBackend.properties.server`.
        /// This can either be done immediately or in response to some "resource
        /// deleted" notification from the server.
        ///
        /// If an error occurs, the function will set `error` and return `FALSE`.
        pub const delete_resource_sync = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_delete_resource_sync.?(gobject.ext.as(CollectionBackend, p_backend), p_source, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_delete_resource_sync = @ptrCast(p_implementation);
            }
        };

        /// Extracts the resource ID for `child_source`, which is supposed to be a
        /// stable and unique server-assigned identifier for the remote resource
        /// described by `child_source`.  If `child_source` is not actually a child
        /// of the collection `ebackend.Backend.properties.source` owned by `backend`, the function
        /// returns `NULL`.
        ///
        /// The returned string should be freed with `glib.free` when no longer needed.
        pub const dup_resource_id = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_child_source: *edataserver.Source) ?[*:0]u8 {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_dup_resource_id.?(gobject.ext.as(CollectionBackend, p_backend), p_child_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_child_source: *edataserver.Source) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_dup_resource_id = @ptrCast(p_implementation);
            }
        };

        pub const populate = struct {
            pub fn call(p_class: anytype, p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(CollectionBackend.Class, p_class).f_populate.?(gobject.ext.as(CollectionBackend, p_backend));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(CollectionBackend.Class, p_class).f_populate = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const proxy_resolver = struct {
            pub const name = "proxy-resolver";

            pub const Type = ?*gio.ProxyResolver;
        };

        pub const server = struct {
            pub const name = "server";

            pub const Type = ?*ebackend.SourceRegistryServer;
        };
    };

    pub const signals = struct {
        /// Emitted when an `ebackend.ServerSideSource` is added to `backend`'s
        /// `ebackend.CollectionBackend.properties.server` as a child of `backend`'s collection
        /// `ebackend.Backend.properties.source`.
        ///
        /// You can think of this as a filtered version of
        /// `ebackend.SourceRegistryServer`'s `ebackend.SourceRegistryServer.signals.source`-added
        /// signal which only lets through sources relevant to `backend`.
        pub const child_added = struct {
            pub const name = "child-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_child_source: *ebackend.ServerSideSource, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CollectionBackend, p_instance))),
                    gobject.signalLookup("child-added", CollectionBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `ebackend.ServerSideSource` that is a child of
        /// `backend`'s collection `ebackend.Backend.properties.source` is removed from
        /// `backend`'s `ebackend.CollectionBackend.properties.server`.
        ///
        /// You can think of this as a filtered version of
        /// `ebackend.SourceRegistryServer`'s `ebackend.SourceRegistryServer.signals.source`-removed
        /// signal which only lets through sources relevant to `backend`.
        pub const child_removed = struct {
            pub const name = "child-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_child_source: *ebackend.ServerSideSource, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CollectionBackend, p_instance))),
                    gobject.signalLookup("child-removed", CollectionBackend.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Authenticates all enabled children sources with the given `crendetials`.
    /// This is usually called when the collection source successfully used
    /// the `credentials` to connect to the (possibly) remote data store, to
    /// open the childern too. Already connected child sources are skipped.
    extern fn e_collection_backend_authenticate_children(p_backend: *CollectionBackend, p_credentials: *const edataserver.NamedParameters) void;
    pub const authenticateChildren = e_collection_backend_authenticate_children;

    /// Claims all previously used sources that have not yet been claimed by
    /// `ebackend.CollectionBackend.newChild` and returns them in a `glib.List`.  Note
    /// that previously used sources can only be claimed once, so subsequent
    /// calls to this function for `backend` will return `NULL`.
    ///
    /// The `backend` is then expected to compare the returned list with a
    /// current list of resources from a remote server, create new `edataserver.Source`
    /// instances as needed with `ebackend.CollectionBackend.newChild`, discard
    /// unneeded `edataserver.Source` instances with `edataserver.Source.remove`, and export the
    /// remaining instances with `ebackend.SourceRegistryServer.addSource`.
    ///
    /// The sources returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned `glib.List` itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_collection_backend_claim_all_resources(p_backend: *CollectionBackend) ?*glib.List;
    pub const claimAllResources = e_collection_backend_claim_all_resources;

    /// Asynchronously creates a server-side resource described by `source`.
    /// For example, if `source` describes a new calendar, an equivalent calendar
    /// is created on the server.
    ///
    /// It is the implementor's responsibility to examine `source` and determine
    /// what the equivalent server-side resource would be.  If this cannot be
    /// determined without ambiguity, the function must return an error.
    ///
    /// After the server-side resource is successfully created, the implementor
    /// must also add an `edataserver.Source` to `backend`'s `ebackend.CollectionBackend.properties.server`.  This
    /// can either be done immediately or in response to some "resource created"
    /// notification from the server.  The added `edataserver.Source` can be `source` itself
    /// or a different `edataserver.Source` instance that describes the new resource.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ebackend.CollectionBackend.createResourceFinish` to get the result of
    /// the operation.
    extern fn e_collection_backend_create_resource(p_backend: *CollectionBackend, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const createResource = e_collection_backend_create_resource;

    /// Finishes the operation started with `ebackend.CollectionBackend.createResource`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_collection_backend_create_resource_finish(p_backend: *CollectionBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const createResourceFinish = e_collection_backend_create_resource_finish;

    /// Creates a server-side resource described by `source`.  For example, if
    /// `source` describes a new calendar, an equivalent calendar is created on
    /// the server.
    ///
    /// It is the implementor's responsibility to examine `source` and determine
    /// what the equivalent server-side resource would be.  If this cannot be
    /// determined without ambiguity, the function must return an error.
    ///
    /// After the server-side resource is successfully created, the implementor
    /// must also add an `edataserver.Source` to `backend`'s `ebackend.CollectionBackend.properties.server`.  This
    /// can either be done immediately or in response to some "resource created"
    /// notification from the server.  The added `edataserver.Source` can be `source` itself
    /// or a different `edataserver.Source` instance that describes the new resource.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_collection_backend_create_resource_sync(p_backend: *CollectionBackend, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const createResourceSync = e_collection_backend_create_resource_sync;

    /// Asynchronously deletes a server-side resource described by `source`.
    /// The `source` must be a child of `backend`'s collection `ebackend.Backend.properties.source`.
    ///
    /// After the server-side resource is successfully deleted, the implementor
    /// must also remove `source` from the `backend`'s `ebackend.CollectionBackend.properties.server`.
    /// This can either be done immediately or in response to some "resource
    /// deleted" notification from the server.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ebackend.CollectionBackend.deleteResourceFinish` to get the result of
    /// the operation.
    extern fn e_collection_backend_delete_resource(p_backend: *CollectionBackend, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const deleteResource = e_collection_backend_delete_resource;

    /// Finishes the operation started with `ebackend.CollectionBackend.deleteResource`.
    ///
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_collection_backend_delete_resource_finish(p_backend: *CollectionBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const deleteResourceFinish = e_collection_backend_delete_resource_finish;

    /// Deletes a server-side resource described by `source`.  The `source` must
    /// be a child of `backend`'s collection `ebackend.Backend.properties.source`.
    ///
    /// After the server-side resource is successfully deleted, the implementor
    /// must also remove `source` from the `backend`'s `ebackend.CollectionBackend.properties.server`.
    /// This can either be done immediately or in response to some "resource
    /// deleted" notification from the server.
    ///
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_collection_backend_delete_resource_sync(p_backend: *CollectionBackend, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const deleteResourceSync = e_collection_backend_delete_resource_sync;

    /// Extracts the resource ID for `child_source`, which is supposed to be a
    /// stable and unique server-assigned identifier for the remote resource
    /// described by `child_source`.  If `child_source` is not actually a child
    /// of the collection `ebackend.Backend.properties.source` owned by `backend`, the function
    /// returns `NULL`.
    ///
    /// The returned string should be freed with `glib.free` when no longer needed.
    extern fn e_collection_backend_dup_resource_id(p_backend: *CollectionBackend, p_child_source: *edataserver.Source) ?[*:0]u8;
    pub const dupResourceId = e_collection_backend_dup_resource_id;

    /// Freezes populate of the backend's content. This is used to avoid calling
    /// populate multiple times in parallel.
    /// Every call to this function should be followed by the call
    /// of `ebackend.CollectionBackend.thawPopulate` to reverse the effect of this function,
    /// regardless of the return value of this function.
    extern fn e_collection_backend_freeze_populate(p_backend: *CollectionBackend) c_int;
    pub const freezePopulate = e_collection_backend_freeze_populate;

    /// Returns the private cache directory path for `backend`, which is named
    /// after the `edataserver.Source.properties.uid` of `backend`'s collection `ebackend.Backend.properties.source`.
    ///
    /// The cache directory is meant to store key files for backend-created
    /// data sources.  See also: `ebackend.ServerSideSource.setWriteDirectory`
    extern fn e_collection_backend_get_cache_dir(p_backend: *CollectionBackend) [*:0]const u8;
    pub const getCacheDir = e_collection_backend_get_cache_dir;

    /// Checks whether the `backend` has enabled at least of the `parts`.
    extern fn e_collection_backend_get_part_enabled(p_backend: *CollectionBackend, p_parts: ebackend.CollectionBackendParts) c_int;
    pub const getPartEnabled = e_collection_backend_get_part_enabled;

    extern fn e_collection_backend_get_populate_frozen(p_backend: *CollectionBackend) c_int;
    pub const getPopulateFrozen = e_collection_backend_get_populate_frozen;

    /// Returns whether the `source` is a newly created child or not. New sources
    /// are remembered between two populate calls only.
    extern fn e_collection_backend_is_new_source(p_backend: *CollectionBackend, p_source: *edataserver.Source) c_int;
    pub const isNewSource = e_collection_backend_is_new_source;

    /// Returns a list of calendar sources belonging to the data source
    /// collection managed by `backend`.
    ///
    /// The sources returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned `glib.List` itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_collection_backend_list_calendar_sources(p_backend: *CollectionBackend) *glib.List;
    pub const listCalendarSources = e_collection_backend_list_calendar_sources;

    /// Returns a list of address book sources belonging to the data source
    /// collection managed by `backend`.
    ///
    /// The sources returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned `glib.List` itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_collection_backend_list_contacts_sources(p_backend: *CollectionBackend) *glib.List;
    pub const listContactsSources = e_collection_backend_list_contacts_sources;

    /// Returns a list of mail sources belonging to the data source collection
    /// managed by `backend`.
    ///
    /// The sources returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned `glib.List` itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_collection_backend_list_mail_sources(p_backend: *CollectionBackend) *glib.List;
    pub const listMailSources = e_collection_backend_list_mail_sources;

    /// Creates a new `ebackend.ServerSideSource` as a child of the collection
    /// `ebackend.Backend.properties.source` owned by `backend`.  If possible, the `ebackend.ServerSideSource`
    /// is drawn from a cache of previously used sources indexed by `resource_id`
    /// so that locally cached data from previous sessions can be reused.
    ///
    /// The returned data source should be passed to
    /// `ebackend.SourceRegistryServer.addSource` to export it over D-Bus.
    extern fn e_collection_backend_new_child(p_backend: *CollectionBackend, p_resource_id: [*:0]const u8) *edataserver.Source;
    pub const newChild = e_collection_backend_new_child;

    /// Returns the `gio.ProxyResolver` for `backend` (if applicable), as indicated
    /// by the `edataserver.SourceAuthentication.properties.proxy`-uid of `backend`'s `ebackend.Backend.properties.source`
    /// or one of its ancestors.
    ///
    /// The returned `gio.ProxyResolver` is referenced for thread-safety and must
    /// be unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_collection_backend_ref_proxy_resolver(p_backend: *CollectionBackend) ?*gio.ProxyResolver;
    pub const refProxyResolver = e_collection_backend_ref_proxy_resolver;

    /// Returns the `ebackend.SourceRegistryServer` to which `backend` belongs.
    ///
    /// The returned `ebackend.SourceRegistryServer` is referenced for thread-safety.
    /// Unreference the `ebackend.SourceRegistryServer` with `gobject.Object.unref` when
    /// finished with it.
    extern fn e_collection_backend_ref_server(p_backend: *CollectionBackend) *ebackend.SourceRegistryServer;
    pub const refServer = e_collection_backend_ref_server;

    /// Schedules a call to `populate` of the `backend` on idle.
    /// The function does nothing in case the `backend` is offline.
    extern fn e_collection_backend_schedule_populate(p_backend: *CollectionBackend) void;
    pub const schedulePopulate = e_collection_backend_schedule_populate;

    /// Thaws populate of the backend's content. This is a pair function
    /// for `ebackend.CollectionBackend.freezePopulate`.
    extern fn e_collection_backend_thaw_populate(p_backend: *CollectionBackend) void;
    pub const thawPopulate = e_collection_backend_thaw_populate;

    extern fn e_collection_backend_get_type() usize;
    pub const getGObjectType = e_collection_backend_get_type;

    extern fn g_object_ref(p_self: *ebackend.CollectionBackend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.CollectionBackend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CollectionBackend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CollectionBackendFactory = extern struct {
    pub const Parent = ebackend.BackendFactory;
    pub const Implements = [_]type{};
    pub const Class = ebackend.CollectionBackendFactoryClass;
    f_parent: ebackend.BackendFactory,
    f_priv: ?*ebackend.CollectionBackendFactoryPrivate,

    pub const virtual_methods = struct {
        /// Convenience function to populate a set of `edataserver.Source` instances with mail
        /// account information to be added to an `ebackend.CollectionBackend`.  This is mainly
        /// used for vendor-specific collection backends like Google or Yahoo! where
        /// the host, port, and security details are known ahead of time and only
        /// user-specific information needs to be filled in.
        pub const prepare_mail = struct {
            pub fn call(p_class: anytype, p_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mail_account_source: *edataserver.Source, p_mail_identity_source: *edataserver.Source, p_mail_transport_source: *edataserver.Source) void {
                return gobject.ext.as(CollectionBackendFactory.Class, p_class).f_prepare_mail.?(gobject.ext.as(CollectionBackendFactory, p_factory), p_mail_account_source, p_mail_identity_source, p_mail_transport_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mail_account_source: *edataserver.Source, p_mail_identity_source: *edataserver.Source, p_mail_transport_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(CollectionBackendFactory.Class, p_class).f_prepare_mail = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Convenience function to populate a set of `edataserver.Source` instances with mail
    /// account information to be added to an `ebackend.CollectionBackend`.  This is mainly
    /// used for vendor-specific collection backends like Google or Yahoo! where
    /// the host, port, and security details are known ahead of time and only
    /// user-specific information needs to be filled in.
    extern fn e_collection_backend_factory_prepare_mail(p_factory: *CollectionBackendFactory, p_mail_account_source: *edataserver.Source, p_mail_identity_source: *edataserver.Source, p_mail_transport_source: *edataserver.Source) void;
    pub const prepareMail = e_collection_backend_factory_prepare_mail;

    extern fn e_collection_backend_factory_get_type() usize;
    pub const getGObjectType = e_collection_backend_factory_get_type;

    extern fn g_object_ref(p_self: *ebackend.CollectionBackendFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.CollectionBackendFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CollectionBackendFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const DBusServer = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = ebackend.DBusServerClass;
    f_parent: gobject.Object,
    f_priv: ?*ebackend.DBusServerPrivate,

    pub const virtual_methods = struct {
        pub const bus_acquired = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_connection: *gio.DBusConnection) void {
                return gobject.ext.as(DBusServer.Class, p_class).f_bus_acquired.?(gobject.ext.as(DBusServer, p_server), p_connection);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_connection: *gio.DBusConnection) callconv(.c) void) void {
                gobject.ext.as(DBusServer.Class, p_class).f_bus_acquired = @ptrCast(p_implementation);
            }
        };

        pub const bus_name_acquired = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_connection: *gio.DBusConnection) void {
                return gobject.ext.as(DBusServer.Class, p_class).f_bus_name_acquired.?(gobject.ext.as(DBusServer, p_server), p_connection);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_connection: *gio.DBusConnection) callconv(.c) void) void {
                gobject.ext.as(DBusServer.Class, p_class).f_bus_name_acquired = @ptrCast(p_implementation);
            }
        };

        pub const bus_name_lost = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_connection: *gio.DBusConnection) void {
                return gobject.ext.as(DBusServer.Class, p_class).f_bus_name_lost.?(gobject.ext.as(DBusServer, p_server), p_connection);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_connection: *gio.DBusConnection) callconv(.c) void) void {
                gobject.ext.as(DBusServer.Class, p_class).f_bus_name_lost = @ptrCast(p_implementation);
            }
        };

        pub const quit_server = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_code: ebackend.DBusServerExitCode) void {
                return gobject.ext.as(DBusServer.Class, p_class).f_quit_server.?(gobject.ext.as(DBusServer, p_server), p_code);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_code: ebackend.DBusServerExitCode) callconv(.c) void) void {
                gobject.ext.as(DBusServer.Class, p_class).f_quit_server = @ptrCast(p_implementation);
            }
        };

        pub const run_server = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ebackend.DBusServerExitCode {
                return gobject.ext.as(DBusServer.Class, p_class).f_run_server.?(gobject.ext.as(DBusServer, p_server));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ebackend.DBusServerExitCode) void {
                gobject.ext.as(DBusServer.Class, p_class).f_run_server = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when `server` acquires a connection to the session bus.
        pub const bus_acquired = struct {
            pub const name = "bus-acquired";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_connection: *gio.DBusConnection, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DBusServer, p_instance))),
                    gobject.signalLookup("bus-acquired", DBusServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when `server` acquires its well-known session bus name.
        pub const bus_name_acquired = struct {
            pub const name = "bus-name-acquired";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_connection: *gio.DBusConnection, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DBusServer, p_instance))),
                    gobject.signalLookup("bus-name-acquired", DBusServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when `server` loses its well-known session bus name
        /// or the session bus connection has been closed.
        pub const bus_name_lost = struct {
            pub const name = "bus-name-lost";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_connection: *gio.DBusConnection, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DBusServer, p_instance))),
                    gobject.signalLookup("bus-name-lost", DBusServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted to request that `server` quit its main loop.
        pub const quit_server = struct {
            pub const name = "quit-server";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_code: ebackend.DBusServerExitCode, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DBusServer, p_instance))),
                    gobject.signalLookup("quit-server", DBusServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted to request that `server` start its main loop and
        /// attempt to acquire its well-known session bus name.
        pub const run_server = struct {
            pub const name = "run-server";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) ebackend.DBusServerExitCode, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DBusServer, p_instance))),
                    gobject.signalLookup("run-server", DBusServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Increases the use count of `server`.
    ///
    /// Use this function to indicate that the server has a reason to continue
    /// to run.  To cancel the hold, call `ebackend.DBusServer.release`.
    extern fn e_dbus_server_hold(p_server: *DBusServer) void;
    pub const hold = e_dbus_server_hold;

    /// This function should be called once during `server` initialization to
    /// load all available library modules to extend the `server`'s functionality.
    extern fn e_dbus_server_load_modules(p_server: *DBusServer) void;
    pub const loadModules = e_dbus_server_load_modules;

    /// Emits the `ebackend.DBusServer.signals.quit` signal with the given `code`.
    ///
    /// By default the `server` will quit its main loop and cause
    /// `ebackend.DBusServer.run` to return `code`.
    extern fn e_dbus_server_quit(p_server: *DBusServer, p_code: ebackend.DBusServerExitCode) void;
    pub const quit = e_dbus_server_quit;

    /// Decreates the use count of `server`.
    ///
    /// When the use count reaches zero, the server will stop running.
    ///
    /// Never call this function except to cancel the effect of a previous call
    /// to `ebackend.DBusServer.hold`.
    extern fn e_dbus_server_release(p_server: *DBusServer) void;
    pub const release = e_dbus_server_release;

    /// Emits the `ebackend.DBusServer.signals.run` signal.
    ///
    /// By default the `server` will start its main loop and attempt to acquire
    /// its well-known session bus name.  If the `server`'s main loop is already
    /// running, the function will immediately return `E_DBUS_SERVER_EXIT_NONE`.
    /// Otherwise the function blocks until `ebackend.DBusServer.quit` is called.
    ///
    /// If `wait_for_client` is `TRUE`, the `server` will continue running until
    /// the first client connection is made instead of quitting on its own if
    /// no client connection is made within the first few seconds.
    extern fn e_dbus_server_run(p_server: *DBusServer, p_wait_for_client: c_int) ebackend.DBusServerExitCode;
    pub const run = e_dbus_server_run;

    extern fn e_dbus_server_get_type() usize;
    pub const getGObjectType = e_dbus_server_get_type;

    extern fn g_object_ref(p_self: *ebackend.DBusServer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.DBusServer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DBusServer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const DataFactory = extern struct {
    pub const Parent = ebackend.DBusServer;
    pub const Implements = [_]type{ edataserver.Extensible, gio.Initable };
    pub const Class = ebackend.DataFactoryClass;
    f_parent: ebackend.DBusServer,
    f_priv: ?*ebackend.DataFactoryPrivate,

    pub const virtual_methods = struct {
        pub const complete_open = struct {
            pub fn call(p_class: anytype, p_data_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_invocation: *gio.DBusMethodInvocation, p_object_path: [*:0]const u8, p_bus_name: [*:0]const u8, p_extension_name: [*:0]const u8) void {
                return gobject.ext.as(DataFactory.Class, p_class).f_complete_open.?(gobject.ext.as(DataFactory, p_data_factory), p_invocation, p_object_path, p_bus_name, p_extension_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_invocation: *gio.DBusMethodInvocation, p_object_path: [*:0]const u8, p_bus_name: [*:0]const u8, p_extension_name: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(DataFactory.Class, p_class).f_complete_open = @ptrCast(p_implementation);
            }
        };

        /// Used only when backend-per-process is off.
        ///
        /// Free the returned pointer with `gobject.Object.unref`, if not NULL and no longer
        /// needed.
        pub const create_backend = struct {
            pub fn call(p_class: anytype, p_data_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend_factory: *ebackend.BackendFactory, p_source: *edataserver.Source) ?*ebackend.Backend {
                return gobject.ext.as(DataFactory.Class, p_class).f_create_backend.?(gobject.ext.as(DataFactory, p_data_factory), p_backend_factory, p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend_factory: *ebackend.BackendFactory, p_source: *edataserver.Source) callconv(.c) ?*ebackend.Backend) void {
                gobject.ext.as(DataFactory.Class, p_class).f_create_backend = @ptrCast(p_implementation);
            }
        };

        pub const open_backend = struct {
            pub fn call(p_class: anytype, p_data_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend: *ebackend.Backend, p_connection: *gio.DBusConnection, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8 {
                return gobject.ext.as(DataFactory.Class, p_class).f_open_backend.?(gobject.ext.as(DataFactory, p_data_factory), p_backend, p_connection, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_data_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend: *ebackend.Backend, p_connection: *gio.DBusConnection, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(DataFactory.Class, p_class).f_open_backend = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const backend_per_process = struct {
            pub const name = "backend-per-process";

            pub const Type = c_int;
        };

        pub const registry = struct {
            pub const name = "registry";

            pub const Type = ?*edataserver.SourceRegistry;
        };

        pub const reload_supported = struct {
            pub const name = "reload-supported";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn e_data_factory_backend_closed(p_data_factory: *DataFactory, p_backend: *ebackend.Backend) void;
    pub const backendClosed = e_data_factory_backend_closed;

    extern fn e_data_factory_backend_closed_by_sender(p_data_factory: *DataFactory, p_backend: *ebackend.Backend, p_sender: [*:0]const u8) void;
    pub const backendClosedBySender = e_data_factory_backend_closed_by_sender;

    /// Returns a new and unique object path for a D-Bus interface based
    /// in the data object path prefix of the `data_factory`
    extern fn e_data_factory_construct_path(p_data_factory: *DataFactory) [*:0]u8;
    pub const constructPath = e_data_factory_construct_path;

    /// Used only when backend-per-process is off.
    ///
    /// Free the returned pointer with `gobject.Object.unref`, if not NULL and no longer
    /// needed.
    extern fn e_data_factory_create_backend(p_data_factory: *DataFactory, p_backend_factory: *ebackend.BackendFactory, p_source: *edataserver.Source) ?*ebackend.Backend;
    pub const createBackend = e_data_factory_create_backend;

    extern fn e_data_factory_get_backend_per_process(p_data_factory: *DataFactory) c_int;
    pub const getBackendPerProcess = e_data_factory_get_backend_per_process;

    /// Returns the `edataserver.SourceRegistry` owned by `data_factory`.
    extern fn e_data_factory_get_registry(p_data_factory: *DataFactory) *edataserver.SourceRegistry;
    pub const getRegistry = e_data_factory_get_registry;

    extern fn e_data_factory_get_reload_supported(p_data_factory: *DataFactory) c_int;
    pub const getReloadSupported = e_data_factory_get_reload_supported;

    /// Lists the currently opened backends.
    ///
    /// The sources returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned `glib.SList` itself with `glib.SList.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_slist_free_full (list, g_object_unref);
    /// ```
    extern fn e_data_factory_list_opened_backends(p_data_factory: *DataFactory) *glib.SList;
    pub const listOpenedBackends = e_data_factory_list_opened_backends;

    extern fn e_data_factory_open_backend(p_data_factory: *DataFactory, p_backend: *ebackend.Backend, p_connection: *gio.DBusConnection, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const openBackend = e_data_factory_open_backend;

    /// Returns the `ebackend.BackendFactory` for "`backend_name`:`extension_name`", or
    /// `NULL` if no such factory is registered.
    ///
    /// The returned `ebackend.BackendFactory` is referenced for thread-safety.
    /// Unreference the `ebackend.BackendFactory` with `gobject.Object.unref` when finished
    /// with it.
    extern fn e_data_factory_ref_backend_factory(p_data_factory: *DataFactory, p_backend_name: [*:0]const u8, p_extension_name: [*:0]const u8) ?*ebackend.BackendFactory;
    pub const refBackendFactory = e_data_factory_ref_backend_factory;

    /// Spawns a new subprocess for a backend type and returns the object path
    /// of the new subprocess to the client, in the way the client can talk
    /// directly to the running backend. If the backend already has a subprocess
    /// running, the used object path is returned to the client.
    extern fn e_data_factory_spawn_subprocess_backend(p_data_factory: *DataFactory, p_invocation: *gio.DBusMethodInvocation, p_uid: [*:0]const u8, p_extension_name: [*:0]const u8, p_subprocess_path: [*:0]const u8) void;
    pub const spawnSubprocessBackend = e_data_factory_spawn_subprocess_backend;

    extern fn e_data_factory_use_backend_per_process(p_data_factory: *DataFactory) c_int;
    pub const useBackendPerProcess = e_data_factory_use_backend_per_process;

    extern fn e_data_factory_get_type() usize;
    pub const getGObjectType = e_data_factory_get_type;

    extern fn g_object_ref(p_self: *ebackend.DataFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.DataFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DataFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const FileCache = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ebackend.FileCacheClass;
    f_parent: gobject.Object,
    f_priv: ?*ebackend.FileCachePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The filename of the cache.
        pub const filename = struct {
            pub const name = "filename";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `ebackend.FileCache` object, which implements a cache of
    /// objects.  Useful for remote backends.
    extern fn e_file_cache_new(p_filename: [*:0]const u8) *ebackend.FileCache;
    pub const new = e_file_cache_new;

    /// Adds a new `key` / `value` entry to `cache`.  If an object corresponding
    /// to `key` already exists in `cache`, the function returns `FALSE`.
    extern fn e_file_cache_add_object(p_cache: *FileCache, p_key: [*:0]const u8, p_value: [*:0]const u8) c_int;
    pub const addObject = e_file_cache_add_object;

    /// Clean up the cache's contents.
    extern fn e_file_cache_clean(p_cache: *FileCache) c_int;
    pub const clean = e_file_cache_clean;

    /// Disables temporarily all writes to disk for `cache`.
    extern fn e_file_cache_freeze_changes(p_cache: *FileCache) void;
    pub const freezeChanges = e_file_cache_freeze_changes;

    /// Gets the name of the file where the cache is being stored.
    extern fn e_file_cache_get_filename(p_cache: *FileCache) [*:0]const u8;
    pub const getFilename = e_file_cache_get_filename;

    /// Returns a list of keys in `cache`.  The keys are owned by `cache` and must
    /// not be modified or freed.  Free the returned list with `glib.SList.free`.
    extern fn e_file_cache_get_keys(p_cache: *FileCache) *glib.SList;
    pub const getKeys = e_file_cache_get_keys;

    /// Returns the object corresponding to `key`.  If no such object exists
    /// in `cache`, the function returns `NULL`.
    extern fn e_file_cache_get_object(p_cache: *FileCache, p_key: [*:0]const u8) ?[*:0]const u8;
    pub const getObject = e_file_cache_get_object;

    /// Returns a list of objects in `cache`.  The objects are owned by `cache` and
    /// must not be modified or freed.  Free the returned list with `glib.SList.free`.
    extern fn e_file_cache_get_objects(p_cache: *FileCache) *glib.SList;
    pub const getObjects = e_file_cache_get_objects;

    /// Remove the cache from disk.
    extern fn e_file_cache_remove(p_cache: *FileCache) c_int;
    pub const remove = e_file_cache_remove;

    /// Removes the object corresponding to `key` from `cache`.
    /// If no such object exists in `cache`, the function returns `FALSE`.
    extern fn e_file_cache_remove_object(p_cache: *FileCache, p_key: [*:0]const u8) c_int;
    pub const removeObject = e_file_cache_remove_object;

    /// Replaces the object corresponding to `key` with `new_value`.
    /// If no such object exists in `cache`, the function returns `FALSE`.
    extern fn e_file_cache_replace_object(p_cache: *FileCache, p_key: [*:0]const u8, p_new_value: [*:0]const u8) c_int;
    pub const replaceObject = e_file_cache_replace_object;

    /// Reverts the affects of `ebackend.FileCache.freezeChanges`.
    /// Each change to `cache` is once again written to disk.
    extern fn e_file_cache_thaw_changes(p_cache: *FileCache) void;
    pub const thawChanges = e_file_cache_thaw_changes;

    extern fn e_file_cache_get_type() usize;
    pub const getGObjectType = e_file_cache_get_type;

    extern fn g_object_ref(p_self: *ebackend.FileCache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.FileCache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FileCache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const ServerSideSource = extern struct {
    pub const Parent = edataserver.Source;
    pub const Implements = [_]type{ gio.Initable, gio.ProxyResolver };
    pub const Class = ebackend.ServerSideSourceClass;
    f_parent: edataserver.Source,
    f_priv: ?*ebackend.ServerSideSourcePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const exported = struct {
            pub const name = "exported";

            pub const Type = c_int;
        };

        pub const file = struct {
            pub const name = "file";

            pub const Type = ?*gio.File;
        };

        pub const oauth2_support = struct {
            pub const name = "oauth2-support";

            pub const Type = ?*ebackend.OAuth2Support;
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

        pub const server = struct {
            pub const name = "server";

            pub const Type = ?*ebackend.SourceRegistryServer;
        };

        pub const writable = struct {
            pub const name = "writable";

            pub const Type = c_int;
        };

        pub const write_directory = struct {
            pub const name = "write-directory";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Returns the directory where user-specific data source files are stored.
    extern fn e_server_side_source_get_user_dir() [*:0]const u8;
    pub const getUserDir = e_server_side_source_get_user_dir;

    /// Generates a unique file name for a new user-specific data source.
    /// If `uid` is non-`NULL` it will be used in the basename of the file,
    /// otherwise a unique basename will be generated using `edataserver.utilGenerateUid`.
    ///
    /// The returned `gio.File` can then be passed to `ebackend.ServerSideSource.new`.
    /// Unreference the `gio.File` with `gobject.Object.unref` when finished with it.
    ///
    /// Note the data source file itself is not created here, only its name.
    extern fn e_server_side_source_new_user_file(p_uid: ?[*:0]const u8) *gio.File;
    pub const newUserFile = e_server_side_source_new_user_file;

    /// Extracts a unique identity string from the base name of `file`.
    /// If the base name of `file` is missing a '.source' extension, the
    /// function sets `error` and returns `NULL`.
    extern fn e_server_side_source_uid_from_file(p_file: *gio.File, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const uidFromFile = e_server_side_source_uid_from_file;

    /// Creates a new `ebackend.ServerSideSource` which belongs to `server`.  If `file`
    /// is non-`NULL` and points to an existing file, the `ebackend.ServerSideSource` is
    /// initialized from the file content.  If a read error occurs or the file
    /// contains syntax errors, the function sets `error` and returns `NULL`.
    extern fn e_server_side_source_new(p_server: *ebackend.SourceRegistryServer, p_file: ?*gio.File, p_error: ?*?*glib.Error) ?*ebackend.ServerSideSource;
    pub const new = e_server_side_source_new;

    /// Creates a memory-only `ebackend.ServerSideSource` which belongs to `server`.
    /// No on-disk key file is created for this data source, so it will not
    /// be remembered across sessions.
    ///
    /// Data source collections are often populated with memory-only data
    /// sources to serve as proxies for resources discovered on a remote server.
    /// These data sources are usually neither `ebackend.ServerSideSource.properties.writable` nor
    /// `ebackend.ServerSideSource.properties.removable` by clients, at least not directly.
    ///
    /// If an error occurs while instantiating the `ebackend.ServerSideSource`, the
    /// function sets `error` and returns `NULL`.  Although at this time there
    /// are no known error conditions for memory-only data sources.
    extern fn e_server_side_source_new_memory_only(p_server: *ebackend.SourceRegistryServer, p_uid: ?[*:0]const u8, p_error: ?*?*glib.Error) ?*ebackend.ServerSideSource;
    pub const newMemoryOnly = e_server_side_source_new_memory_only;

    /// Returns whether `source` has been exported over D-Bus.
    ///
    /// The function returns `FALSE` after `source` is initially created, `TRUE`
    /// after passing `source` uid to `ebackend.SourceRegistryServer.refSource` (provided
    /// that `source`'s `edataserver.Source.properties.parent` is also exported).
    extern fn e_server_side_source_get_exported(p_source: *ServerSideSource) c_int;
    pub const getExported = e_server_side_source_get_exported;

    /// Returns the `gio.File` from which data source content is loaded and to
    /// which changes are saved.  Note the `source` may not have a `gio.File`.
    extern fn e_server_side_source_get_file(p_source: *ServerSideSource) ?*gio.File;
    pub const getFile = e_server_side_source_get_file;

    /// Returns the `glib.Node` representing the `source`'s hierarchical placement,
    /// or `NULL` if `source` has not been placed in the data source hierarchy.
    /// The data member of the `glib.Node` points back to `source`.  This is an easy
    /// way to traverse ancestor and descendant data sources.
    ///
    /// Note that accessing other data sources this way is not thread-safe,
    /// and this therefore function may be replaced at some later date.
    extern fn e_server_side_source_get_node(p_source: *ServerSideSource) ?*glib.Node;
    pub const getNode = e_server_side_source_get_node;

    /// Returns the `ebackend.SourceRegistryServer` to which `source` belongs.
    extern fn e_server_side_source_get_server(p_source: *ServerSideSource) *ebackend.SourceRegistryServer;
    pub const getServer = e_server_side_source_get_server;

    /// Returns the local directory path where changes to `source` are written.
    ///
    /// By default, changes are written to the local directory path returned by
    /// `ebackend.ServerSideSource.getUserDir`, but an `ebackend.CollectionBackend` may wish
    /// to override this to use its own private cache directory for data sources
    /// it creates automatically.
    extern fn e_server_side_source_get_write_directory(p_source: *ServerSideSource) [*:0]const u8;
    pub const getWriteDirectory = e_server_side_source_get_write_directory;

    /// Reloads data source content from the file pointed to by the
    /// `ebackend.ServerSideSource.properties.file` property.
    ///
    /// If the `ebackend.ServerSideSource.properties.file` property is `NULL` or the file it points
    /// to does not exist, the function does nothing and returns `TRUE`.
    ///
    /// If a read error occurs or the file contains syntax errors, the function
    /// sets `error` and returns `FALSE`.
    extern fn e_server_side_source_load(p_source: *ServerSideSource, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const load = e_server_side_source_load;

    /// Returns the object implementing the `ebackend.OAuth2SupportInterface`,
    /// or `NULL` if `source` does not support OAuth 2.0 authentication.
    ///
    /// The returned `ebackend.OAuth2Support` object is referenced for thread-safety.
    /// Unreference the object with `gobject.Object.unref` when finished with it.
    extern fn e_server_side_source_ref_oauth2_support(p_source: *ServerSideSource) ?*ebackend.OAuth2Support;
    pub const refOauth2Support = e_server_side_source_ref_oauth2_support;

    /// Indicates whether `source` supports OAuth 2.0 authentication.
    ///
    /// If `oauth2_support` is non-`NULL`, the OAuth2Support D-Bus interface is
    /// exported at the object path for `source`.  If `oauth2_support` is `NULL`,
    /// the OAuth2Support D-Bus interface is unexported at the object path for
    /// `source`, and any attempt by clients to call
    /// `edataserver.Source.getOauth2AccessToken` will fail.
    ///
    /// Requests for OAuth 2.0 access tokens are forwarded to `oauth2_support`,
    /// which implements the `ebackend.OAuth2SupportInterface`.
    extern fn e_server_side_source_set_oauth2_support(p_source: *ServerSideSource, p_oauth2_support: ?*ebackend.OAuth2Support) void;
    pub const setOauth2Support = e_server_side_source_set_oauth2_support;

    /// Indicates whether `source` can be used to create resources on a remote
    /// server.  Typically this is only set to `TRUE` for collection sources.
    ///
    /// If `TRUE`, the RemoteCreatable D-Bus interface is exported at the object
    /// path for `source`.  If `FALSE`, the RemoteCreatable D-Bus interface is
    /// unexported at the object path for `source`, and any attempt by clients
    /// to call `edataserver.Source.remoteCreate` will fail.
    ///
    /// Unlike the `edataserver.Source.properties.removable` and `edataserver.Source.properties.writable` properties, this
    /// is enforced for both clients of the registry D-Bus service and within
    /// the registry D-Bus service itself.
    extern fn e_server_side_source_set_remote_creatable(p_source: *ServerSideSource, p_remote_creatable: c_int) void;
    pub const setRemoteCreatable = e_server_side_source_set_remote_creatable;

    /// Indicates whether `source` can be used to delete resources on a remote
    /// server.  Typically this is only set to `TRUE` for sources created by an
    /// `ebackend.CollectionBackend` to represent a remote resource.
    ///
    /// If `TRUE`, the RemoteDeletable D-Bus interface is exported at the object
    /// path for `source`.  If `FALSE`, the RemoteDeletable D-Bus interface is
    /// unexported at the object path for `source`, and any attempt by clients
    /// to call `edataserver.Source.remoteDelete` will fail.
    ///
    /// Unlike the `edataserver.Source.properties.removable` and `edataserver.Source.properties.writable` properties, this
    /// is enforced for both clients of the registry D-Bus server and within
    /// the registry D-Bus service itself.
    extern fn e_server_side_source_set_remote_deletable(p_source: *ServerSideSource, p_remote_deletable: c_int) void;
    pub const setRemoteDeletable = e_server_side_source_set_remote_deletable;

    /// Sets whether to allow registry clients to remove `source` and its
    /// descendants.  If `TRUE`, the Removable D-Bus interface is exported at
    /// the object path for `source`.  If `FALSE`, the Removable D-Bus interface
    /// is unexported at the object path for `source`, and any attempt by clients
    /// to call `edataserver.Source.remove` will fail.
    ///
    /// Note this is only enforced for clients of the registry D-Bus service.
    /// The service itself may remove any data source at any time.
    extern fn e_server_side_source_set_removable(p_source: *ServerSideSource, p_removable: c_int) void;
    pub const setRemovable = e_server_side_source_set_removable;

    /// Sets whether to allow registry clients to alter the content of `source`.
    /// If `TRUE`, the Writable D-Bus interface is exported at the object path
    /// for `source`.  If `FALSE`, the Writable D-Bus interface is unexported at
    /// the object path for `source`, and any attempt by clients to call
    /// `edataserver.Source.write` will fail.
    ///
    /// Note this is only enforced for clients of the registry D-Bus service.
    /// The service itself can write to any data source at any time.
    extern fn e_server_side_source_set_writable(p_source: *ServerSideSource, p_writable: c_int) void;
    pub const setWritable = e_server_side_source_set_writable;

    /// Sets the local directory path where changes to `source` are to be written.
    ///
    /// By default, changes are written to the local directory path returned by
    /// `ebackend.ServerSideSource.getUserDir`, but an `ebackend.CollectionBackend` may wish
    /// to override this to use its own private cache directory for data sources
    /// it creates automatically.
    extern fn e_server_side_source_set_write_directory(p_source: *ServerSideSource, p_write_directory: [*:0]const u8) void;
    pub const setWriteDirectory = e_server_side_source_set_write_directory;

    extern fn e_server_side_source_get_type() usize;
    pub const getGObjectType = e_server_side_source_get_type;

    extern fn g_object_ref(p_self: *ebackend.ServerSideSource) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.ServerSideSource) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ServerSideSource, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const ServerSideSourceCredentialsProvider = extern struct {
    pub const Parent = edataserver.SourceCredentialsProvider;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = ebackend.ServerSideSourceCredentialsProviderClass;
    f_parent: edataserver.SourceCredentialsProvider,
    f_priv: ?*ebackend.ServerSideSourceCredentialsProviderPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `ebackend.ServerSideSourceCredentialsProvider`, which is meant to abstract
    /// credential management for `edataserver.Source`<!-- -->-s.
    extern fn e_server_side_source_credentials_provider_new(p_registry: *ebackend.SourceRegistryServer) *ebackend.ServerSideSourceCredentialsProvider;
    pub const new = e_server_side_source_credentials_provider_new;

    extern fn e_server_side_source_credentials_provider_get_type() usize;
    pub const getGObjectType = e_server_side_source_credentials_provider_get_type;

    extern fn g_object_ref(p_self: *ebackend.ServerSideSourceCredentialsProvider) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.ServerSideSourceCredentialsProvider) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ServerSideSourceCredentialsProvider, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SourceRegistryServer = extern struct {
    pub const Parent = ebackend.DataFactory;
    pub const Implements = [_]type{ ebackend.OAuth2Support, edataserver.Extensible, gio.Initable };
    pub const Class = ebackend.SourceRegistryServerClass;
    f_parent: ebackend.DataFactory,
    f_priv: ?*ebackend.SourceRegistryServerPrivate,

    pub const virtual_methods = struct {
        pub const files_loaded = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(SourceRegistryServer.Class, p_class).f_files_loaded.?(gobject.ext.as(SourceRegistryServer, p_server));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(SourceRegistryServer.Class, p_class).f_files_loaded = @ptrCast(p_implementation);
            }
        };

        /// Emits the `ebackend.SourceRegistryServer.signals.load`-error signal.
        pub const load_error = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: *gio.File, p_error: *const glib.Error) void {
                return gobject.ext.as(SourceRegistryServer.Class, p_class).f_load_error.?(gobject.ext.as(SourceRegistryServer, p_server), p_file, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file: *gio.File, p_error: *const glib.Error) callconv(.c) void) void {
                gobject.ext.as(SourceRegistryServer.Class, p_class).f_load_error = @ptrCast(p_implementation);
            }
        };

        pub const source_added = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistryServer.Class, p_class).f_source_added.?(gobject.ext.as(SourceRegistryServer, p_server), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistryServer.Class, p_class).f_source_added = @ptrCast(p_implementation);
            }
        };

        pub const source_removed = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) void {
                return gobject.ext.as(SourceRegistryServer.Class, p_class).f_source_removed.?(gobject.ext.as(SourceRegistryServer, p_server), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) void) void {
                gobject.ext.as(SourceRegistryServer.Class, p_class).f_source_removed = @ptrCast(p_implementation);
            }
        };

        pub const tweak_key_file = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_key_file: *glib.KeyFile, p_uid: [*:0]const u8) c_int {
                return gobject.ext.as(SourceRegistryServer.Class, p_class).f_tweak_key_file.?(gobject.ext.as(SourceRegistryServer, p_server), p_key_file, p_uid);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_key_file: *glib.KeyFile, p_uid: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(SourceRegistryServer.Class, p_class).f_tweak_key_file = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted after all data source key files are loaded on startup.
        /// Extensions can connect to this signal to perform any additional
        /// work prior to running the main loop.
        pub const files_loaded = struct {
            pub const name = "files-loaded";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistryServer, p_instance))),
                    gobject.signalLookup("files-loaded", SourceRegistryServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an error occurs while loading or parsing a
        /// data source key file.
        pub const load_error = struct {
            pub const name = "load-error";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_file: *gio.File, p_error: *glib.Error, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistryServer, p_instance))),
                    gobject.signalLookup("load-error", SourceRegistryServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `ebackend.ServerSideSource` is added to `server`.
        pub const source_added = struct {
            pub const name = "source-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *ebackend.ServerSideSource, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistryServer, p_instance))),
                    gobject.signalLookup("source-added", SourceRegistryServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an `ebackend.ServerSideSource` is removed from `server`.
        pub const source_removed = struct {
            pub const name = "source-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_source: *ebackend.ServerSideSource, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistryServer, p_instance))),
                    gobject.signalLookup("source-removed", SourceRegistryServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted from `ebackend.SourceRegistryServer.loadFile` just prior
        /// to instantiating an `ebackend.ServerSideSource`.  Signal handlers can
        /// tweak the `key_file` content as necessary and return `TRUE` to
        /// write the modified content back to disk.
        ///
        /// For the purposes of tweaking, it's easier to deal with a plain
        /// `glib.KeyFile` than an `edataserver.Source` instance.  An `edataserver.Source`, for example,
        /// does not allow key file groups to be removed.
        ///
        /// The return value is cumulative.  If any signal handler returns
        /// `TRUE`, the `key_file` content is written back to disk.
        pub const tweak_key_file = struct {
            pub const name = "tweak-key-file";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_key_file: *glib.KeyFile, p_uid: [*:0]u8, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SourceRegistryServer, p_instance))),
                    gobject.signalLookup("tweak-key-file", SourceRegistryServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new instance of `ebackend.SourceRegistryServer`.
    extern fn e_source_registry_server_new() *ebackend.SourceRegistryServer;
    pub const new = e_source_registry_server_new;

    /// Adds `source` to `server`.
    extern fn e_source_registry_server_add_source(p_server: *SourceRegistryServer, p_source: *edataserver.Source) void;
    pub const addSource = e_source_registry_server_add_source;

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
    extern fn e_source_registry_server_find_extension(p_server: *SourceRegistryServer, p_source: *edataserver.Source, p_extension_name: [*:0]const u8) ?*edataserver.Source;
    pub const findExtension = e_source_registry_server_find_extension;

    extern fn e_source_registry_server_get_oauth2_services(p_server: *SourceRegistryServer) *edataserver.OAuth2Services;
    pub const getOauth2Services = e_source_registry_server_get_oauth2_services;

    /// Returns a list of registered sources, sorted by display name.  If
    /// `extension_name` is given, restrict the list to sources having that
    /// extension name.
    ///
    /// The sources returned in the list are referenced for thread-safety.
    /// They must each be unreferenced with `gobject.Object.unref` when finished
    /// with them.  Free the returned `glib.List` itself with `glib.List.free`.
    ///
    /// An easy way to free the list properly in one step is as follows:
    ///
    /// ```
    ///   g_list_free_full (list, g_object_unref);
    /// ```
    extern fn e_source_registry_server_list_sources(p_server: *SourceRegistryServer, p_extension_name: ?[*:0]const u8) *glib.List;
    pub const listSources = e_source_registry_server_list_sources;

    /// Loads data source key files in `path`.  Because multiple errors can
    /// occur when loading multiple files, `error` is only set if `path` can
    /// not be opened.  If a key file fails to load, the error is broadcast
    /// through the `ebackend.SourceRegistryServer.signals.load`-error signal.
    ///
    /// If the `E_SOURCE_PERMISSION_REMOVABLE` flag is given, then the `server`
    /// will emit signals on the D-Bus interface when key files are created or
    /// deleted in `path`.
    extern fn e_source_registry_server_load_directory(p_server: *SourceRegistryServer, p_path: [*:0]const u8, p_flags: ebackend.SourcePermissionFlags, p_error: ?*?*glib.Error) c_int;
    pub const loadDirectory = e_source_registry_server_load_directory;

    /// Emits the `ebackend.SourceRegistryServer.signals.load`-error signal.
    extern fn e_source_registry_server_load_error(p_server: *SourceRegistryServer, p_file: *gio.File, p_error: *const glib.Error) void;
    pub const loadError = e_source_registry_server_load_error;

    /// Creates an `edataserver.Source` for a native key file and adds it to `server`.
    /// If an error occurs, the function returns `NULL` and sets `error`.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety.  Unreference
    /// the `edataserver.Source` with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_server_load_file(p_server: *SourceRegistryServer, p_file: *gio.File, p_flags: ebackend.SourcePermissionFlags, p_error: ?*?*glib.Error) ?*edataserver.Source;
    pub const loadFile = e_source_registry_server_load_file;

    /// Loads data source key files from `resource` by enumerating the children
    /// at `path` and calling `ebackend.SourceRegistryServer.loadFile` on each child.
    /// Because multiple errors can occur when loading multiple files, `error` is
    /// only set if `path` is invalid.  If a key file fails to load, the error is
    /// broadcast through the `ebackend.SourceRegistryServer.signals.load`-error signal.
    extern fn e_source_registry_server_load_resource(p_server: *SourceRegistryServer, p_resource: *gio.Resource, p_path: [*:0]const u8, p_flags: ebackend.SourcePermissionFlags, p_error: ?*?*glib.Error) c_int;
    pub const loadResource = e_source_registry_server_load_resource;

    /// Returns the `ebackend.CollectionBackend` associated with `source`, or `NULL` if
    /// there is no `ebackend.CollectionBackend` associated with `source`.
    ///
    /// An `edataserver.Source` is associated with an `ebackend.CollectionBackend` if the `edataserver.Source` has
    /// an `edataserver.SourceCollection` extension, or if it is a hierarchical descendant of
    /// another `edataserver.Source` which has an `edataserver.SourceCollection` extension.
    ///
    /// The returned `ebackend.CollectionBackend` is referenced for thread-safety.
    /// Unreference the `ebackend.CollectionBackend` with `gobject.Object.unref` when finished
    /// with it.
    extern fn e_source_registry_server_ref_backend(p_server: *SourceRegistryServer, p_source: *edataserver.Source) ?*ebackend.CollectionBackend;
    pub const refBackend = e_source_registry_server_ref_backend;

    /// Returns the `ebackend.CollectionBackendFactory` for `source`, if available.
    /// If `source` does not have an `edataserver.SourceCollection` extension, or if the
    /// `edataserver.SourceCollection` extension names an `edataserver.SourceBackend.properties.backend`-name for
    /// which there is no corresponding `ebackend.CollectionBackendFactory`, the function
    /// returns `NULL`.
    ///
    /// The returned `ebackend.CollectionBackendFactory` is referenced for thread-safety.
    /// Unreference the `ebackend.CollectionBackendFactory` with `gobject.Object.unref` when
    /// finished with it.
    extern fn e_source_registry_server_ref_backend_factory(p_server: *SourceRegistryServer, p_source: *edataserver.Source) ?*ebackend.CollectionBackendFactory;
    pub const refBackendFactory = e_source_registry_server_ref_backend_factory;

    /// Returns a referenced `edataserver.SourceCredentialsProvider`. Unref it with
    /// `gobject.Object.unref`, when no longer needed.
    extern fn e_source_registry_server_ref_credentials_provider(p_server: *SourceRegistryServer) *edataserver.SourceCredentialsProvider;
    pub const refCredentialsProvider = e_source_registry_server_ref_credentials_provider;

    /// Returns the default `ebackend.OAuth2Support` implementation, which can be used when
    /// the source doesn't have it overwritten.
    ///
    /// Free the returned object with `gobject.Object.unref`, when no longer needed.
    extern fn e_source_registry_server_ref_oauth2_support(p_server: *SourceRegistryServer) ?*ebackend.OAuth2Support;
    pub const refOauth2Support = e_source_registry_server_ref_oauth2_support;

    /// Looks up an `edataserver.Source` in `server` by its unique identifier string.
    ///
    /// The returned `edataserver.Source` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    extern fn e_source_registry_server_ref_source(p_server: *SourceRegistryServer, p_uid: [*:0]const u8) ?*edataserver.Source;
    pub const refSource = e_source_registry_server_ref_source;

    /// Removes `source` and all of its descendants from `server`.
    extern fn e_source_registry_server_remove_source(p_server: *SourceRegistryServer, p_source: *edataserver.Source) void;
    pub const removeSource = e_source_registry_server_remove_source;

    extern fn e_source_registry_server_get_type() usize;
    pub const getGObjectType = e_source_registry_server_get_type;

    extern fn g_object_ref(p_self: *ebackend.SourceRegistryServer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.SourceRegistryServer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SourceRegistryServer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const SubprocessFactory = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = ebackend.SubprocessFactoryClass;
    f_parent: gobject.Object,
    f_priv: ?*ebackend.SubprocessFactoryPrivate,

    pub const virtual_methods = struct {
        pub const backend_closed = struct {
            pub fn call(p_class: anytype, p_subprocess_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend: *ebackend.Backend) void {
                return gobject.ext.as(SubprocessFactory.Class, p_class).f_backend_closed.?(gobject.ext.as(SubprocessFactory, p_subprocess_factory), p_backend);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_subprocess_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend: *ebackend.Backend) callconv(.c) void) void {
                gobject.ext.as(SubprocessFactory.Class, p_class).f_backend_closed = @ptrCast(p_implementation);
            }
        };

        pub const backend_created = struct {
            pub fn call(p_class: anytype, p_subprocess_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend: *ebackend.Backend) void {
                return gobject.ext.as(SubprocessFactory.Class, p_class).f_backend_created.?(gobject.ext.as(SubprocessFactory, p_subprocess_factory), p_backend);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_subprocess_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend: *ebackend.Backend) callconv(.c) void) void {
                gobject.ext.as(SubprocessFactory.Class, p_class).f_backend_created = @ptrCast(p_implementation);
            }
        };

        pub const open_data = struct {
            pub fn call(p_class: anytype, p_subprocess_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend: *ebackend.Backend, p_connection: *gio.DBusConnection, p_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8 {
                return gobject.ext.as(SubprocessFactory.Class, p_class).f_open_data.?(gobject.ext.as(SubprocessFactory, p_subprocess_factory), p_backend, p_connection, p_data, p_cancellable, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_subprocess_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_backend: *ebackend.Backend, p_connection: *gio.DBusConnection, p_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(SubprocessFactory.Class, p_class).f_open_data = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const registry = struct {
            pub const name = "registry";

            pub const Type = ?*edataserver.SourceRegistry;
        };
    };

    pub const signals = struct {};

    /// Returns a new and unique object path for a D-Bus interface based
    /// in the data object path prefix of the `subprocess_factory`
    extern fn e_subprocess_factory_construct_path() [*:0]u8;
    pub const constructPath = e_subprocess_factory_construct_path;

    /// Calls `ebackend.Backend.prepareShutdown` for the list of used backends.
    extern fn e_subprocess_factory_call_backends_prepare_shutdown(p_subprocess_factory: *SubprocessFactory) void;
    pub const callBackendsPrepareShutdown = e_subprocess_factory_call_backends_prepare_shutdown;

    /// Returns a list of used backends.
    extern fn e_subprocess_factory_get_backends_list(p_subprocess_factory: *SubprocessFactory) *glib.List;
    pub const getBackendsList = e_subprocess_factory_get_backends_list;

    /// Returns the `edataserver.SourceRegistry` owned by `subprocess_factory`.
    extern fn e_subprocess_factory_get_registry(p_subprocess_factory: *SubprocessFactory) *edataserver.SourceRegistry;
    pub const getRegistry = e_subprocess_factory_get_registry;

    /// Returns the `ebackend.Backend` data D-Bus object path
    extern fn e_subprocess_factory_open_backend(p_subprocess_factory: *SubprocessFactory, p_connection: *gio.DBusConnection, p_uid: [*:0]const u8, p_backend_factory_type_name: [*:0]const u8, p_module_filename: [*:0]const u8, p_proxy: *gio.DBusInterfaceSkeleton, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const openBackend = e_subprocess_factory_open_backend;

    /// Returns either a newly-created or existing `ebackend.Backend` for `edataserver.Source`.
    /// The returned `ebackend.Backend` is referenced for thread-safety and must be
    /// unreferenced with `gobject.Object.unref` when finished with it.
    ///
    /// If the newly-created backend implements the `gio.Initable` interface, then
    /// `gio.Initable.init` is also called on it using `cancellable` and `error`.
    ///
    /// The `subprocess_factory` retains a strong reference to `backend`.
    ///
    /// If no suitable `ebackend.BackendFactory` exists, or if the `ebackend.Backend` fails to
    /// initialize, the function sets `error` and returns `NULL`.
    extern fn e_subprocess_factory_ref_initable_backend(p_subprocess_factory: *SubprocessFactory, p_uid: [*:0]const u8, p_backend_factory_type_name: [*:0]const u8, p_module_filename: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*ebackend.Backend;
    pub const refInitableBackend = e_subprocess_factory_ref_initable_backend;

    /// Installs a toggle reference on the backend, that can receive a signal to
    /// shutdown once all client connections are closed.
    extern fn e_subprocess_factory_set_backend_callbacks(p_subprocess_factory: *SubprocessFactory, p_backend: *ebackend.Backend, p_proxy: *gio.DBusInterfaceSkeleton) void;
    pub const setBackendCallbacks = e_subprocess_factory_set_backend_callbacks;

    extern fn e_subprocess_factory_get_type() usize;
    pub const getGObjectType = e_subprocess_factory_get_type;

    extern fn g_object_ref(p_self: *ebackend.SubprocessFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.SubprocessFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SubprocessFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const UserPrompter = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = ebackend.UserPrompterClass;
    f_parent: gobject.Object,
    f_priv: ?*ebackend.UserPrompterPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new instance of `ebackend.UserPrompter`.
    extern fn e_user_prompter_new() *ebackend.UserPrompter;
    pub const new = e_user_prompter_new;

    /// Asynchronously prompt a user for a decision on an extension-provided dialog.
    /// The caller usually provides an extension for `ebackend.UserPrompterServer`, a descendant
    /// of `ebackend.UserPrompterServerExtension`, which registers itself as a dialog provider.
    /// The extension defines `dialog_name`, same as meaning of `in_parameters`;
    /// only the extension and the caller know about meaning of these.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ebackend.UserPrompter.extensionPromptFinish` to get the result of the operation.
    /// If there is no extension providing given dialog name, the operation finishes with
    /// a G_IO_ERROR, G_IO_ERROR_NOT_FOUND `glib.Error`.
    extern fn e_user_prompter_extension_prompt(p_prompter: *UserPrompter, p_dialog_name: [*:0]const u8, p_in_parameters: ?*const edataserver.NamedParameters, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const extensionPrompt = e_user_prompter_extension_prompt;

    /// Finishes the operation started with `ebackend.UserPrompter.extensionPrompt`.
    /// Caller can provide `out_values` to get additional values provided by the extension.
    /// In case the caller is not interested in additional values, it can pass `NULL` `out_values`.
    /// The `out_values` will be cleared first, then any values will be added there.
    /// Only the caller and the extension know about meaning of the result code and
    /// additional values.
    ///
    /// If an error occurred, the function sets `error` and returns -1. If there is
    /// no extension providing given dialog name, the operation finishes with
    /// a G_IO_ERROR, G_IO_ERROR_NOT_FOUND `error`.
    extern fn e_user_prompter_extension_prompt_finish(p_prompter: *UserPrompter, p_result: *gio.AsyncResult, p_out_values: ?*edataserver.NamedParameters, p_error: ?*?*glib.Error) c_int;
    pub const extensionPromptFinish = e_user_prompter_extension_prompt_finish;

    /// Synchronously prompt a user for a decision on an extension-provided dialog.
    /// The caller usually provides an extension for `ebackend.UserPrompterServer`, a descendant
    /// of `ebackend.UserPrompterServerExtension`, which registers itself as a dialog provider.
    /// The extension defines `dialog_name`, same as meaning of `in_parameters`;
    /// only the extension and the caller know about meaning of these.
    ///
    /// Caller can provide `out_values` to get additional values provided by the extension.
    /// In case the caller is not interested in additional values, it can pass `NULL` `out_values`.
    /// The `out_values` will be cleared first, then any values will be added there.
    /// Only the caller and the extension know about meaning of the result code and
    /// additional values.
    ///
    /// If an error occurred, the function sets `error` and returns -1. If there is
    /// no extension providing given dialog name, the operation finishes with
    /// a G_IO_ERROR, G_IO_ERROR_NOT_FOUND `error`.
    extern fn e_user_prompter_extension_prompt_sync(p_prompter: *UserPrompter, p_dialog_name: [*:0]const u8, p_in_parameters: ?*const edataserver.NamedParameters, p_out_values: ?*edataserver.NamedParameters, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const extensionPromptSync = e_user_prompter_extension_prompt_sync;

    /// Asynchronously prompt a user for a decision.
    ///
    /// The `type` can be one of "info", "warning", "question" or "error", to include
    /// an icon in the message prompt; anything else results in no icon in the message.
    ///
    /// If `button_captions` is `NULL` or empty list, then only one button is shown in
    /// the prompt, a "Dismiss" button.
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ebackend.UserPrompter.promptFinish` to get the result of the operation.
    extern fn e_user_prompter_prompt(p_prompter: *UserPrompter, p_type: ?[*:0]const u8, p_title: ?[*:0]const u8, p_primary_text: ?[*:0]const u8, p_secondary_text: ?[*:0]const u8, p_use_markup: c_int, p_button_captions: ?*glib.List, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const prompt = e_user_prompter_prompt;

    /// Finishes the operation started with `ebackend.UserPrompter.prompt`.
    ///
    /// If an error occurred, the function sets `error` and returns -1.
    extern fn e_user_prompter_prompt_finish(p_prompter: *UserPrompter, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const promptFinish = e_user_prompter_prompt_finish;

    /// Prompts a user for a decision.
    ///
    /// The `type` can be one of "info", "warning", "question" or "error", to include
    /// an icon in the message prompt; anything else results in no icon in the message.
    ///
    /// If `button_captions` is `NULL` or empty list, then only one button is shown in
    /// the prompt, a "Dismiss" button.
    ///
    /// If an error occurred, the function sets `error` and returns -1.
    extern fn e_user_prompter_prompt_sync(p_prompter: *UserPrompter, p_type: ?[*:0]const u8, p_title: ?[*:0]const u8, p_primary_text: ?[*:0]const u8, p_secondary_text: ?[*:0]const u8, p_use_markup: c_int, p_button_captions: ?*glib.List, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const promptSync = e_user_prompter_prompt_sync;

    extern fn e_user_prompter_get_type() usize;
    pub const getGObjectType = e_user_prompter_get_type;

    extern fn g_object_ref(p_self: *ebackend.UserPrompter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.UserPrompter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *UserPrompter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const UserPrompterServer = extern struct {
    pub const Parent = ebackend.DBusServer;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = ebackend.UserPrompterServerClass;
    f_parent: ebackend.DBusServer,
    f_priv: ?*ebackend.UserPrompterServerPrivate,

    pub const virtual_methods = struct {
        pub const prompt = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_id: c_int, p_type: [*:0]const u8, p_title: [*:0]const u8, p_primary_text: [*:0]const u8, p_secondary_text: [*:0]const u8, p_use_markup: c_int, p_button_captions: *const glib.SList) void {
                return gobject.ext.as(UserPrompterServer.Class, p_class).f_prompt.?(gobject.ext.as(UserPrompterServer, p_server), p_id, p_type, p_title, p_primary_text, p_secondary_text, p_use_markup, p_button_captions);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_id: c_int, p_type: [*:0]const u8, p_title: [*:0]const u8, p_primary_text: [*:0]const u8, p_secondary_text: [*:0]const u8, p_use_markup: c_int, p_button_captions: *const glib.SList) callconv(.c) void) void {
                gobject.ext.as(UserPrompterServer.Class, p_class).f_prompt = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const prompt = struct {
            pub const name = "prompt";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_prompt_id: c_int, p_type: ?[*:0]u8, p_title: ?[*:0]u8, p_primary_text: ?[*:0]u8, p_secondary_text: ?[*:0]u8, p_use_markup: c_int, p_button_captions: ?[*][*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(UserPrompterServer, p_instance))),
                    gobject.signalLookup("prompt", UserPrompterServer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new instance of `ebackend.UserPrompterServer`.
    extern fn e_user_prompter_server_new() *ebackend.UserPrompterServer;
    pub const new = e_user_prompter_server_new;

    /// Registers `extension` as a provider of `dialog_name` dialog. The names
    /// are compared case sensitively and two extensions cannot provide
    /// the same dialog. If the function succeeds, then it adds its own
    /// reference on the `extension`.
    ///
    /// Extensions providing multiple dialogs call this function multiple
    /// times, for each dialog name separately.
    extern fn e_user_prompter_server_register(p_server: *UserPrompterServer, p_extension: *edataserver.Extension, p_dialog_name: [*:0]const u8) c_int;
    pub const register = e_user_prompter_server_register;

    /// Finishes prompt initiated by a "prompt" signal or an extension prompt.
    /// The `response` for non-extension prompts is a 0-based index of a button
    /// used to close the prompt.
    ///
    /// The `extension_values` is ignored for non-extension prompts.
    extern fn e_user_prompter_server_response(p_server: *UserPrompterServer, p_prompt_id: c_int, p_response: c_int, p_extension_values: ?*const edataserver.NamedParameters) void;
    pub const response = e_user_prompter_server_response;

    extern fn e_user_prompter_server_get_type() usize;
    pub const getGObjectType = e_user_prompter_server_get_type;

    extern fn g_object_ref(p_self: *ebackend.UserPrompterServer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.UserPrompterServer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *UserPrompterServer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const UserPrompterServerExtension = extern struct {
    pub const Parent = edataserver.Extension;
    pub const Implements = [_]type{};
    pub const Class = ebackend.UserPrompterServerExtensionClass;
    f_parent: edataserver.Extension,
    f_priv: ?*ebackend.UserPrompterServerExtensionPrivate,

    pub const virtual_methods = struct {
        /// Instructs extension to show dialog `dialog_name`. If it cannot be found,
        /// or any error, then return `FALSE`. The caller can pass optional `parameters`,
        /// if `extension` uses any. Meaning of `parameters` is known only to the caller
        /// and to the dialog implementor, it's not interpretted nor checked for correctness
        /// in any way in `ebackend.UserPrompterServer`. The only limitation of `parameters` is that
        /// the array elements are strings.
        ///
        /// The `prompt_id` is used as an identificator of the prompt itself,
        /// and is used in `ebackend.UserPrompterServerExtension.response` call,
        /// which finishes the prompt.
        ///
        /// Note: The function call should not block main loop, it should
        /// just show dialog and return.
        pub const prompt = struct {
            pub fn call(p_class: anytype, p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prompt_id: c_int, p_dialog_name: [*:0]const u8, p_parameters: ?*const edataserver.NamedParameters) c_int {
                return gobject.ext.as(UserPrompterServerExtension.Class, p_class).f_prompt.?(gobject.ext.as(UserPrompterServerExtension, p_extension), p_prompt_id, p_dialog_name, p_parameters);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prompt_id: c_int, p_dialog_name: [*:0]const u8, p_parameters: ?*const edataserver.NamedParameters) callconv(.c) c_int) void {
                gobject.ext.as(UserPrompterServerExtension.Class, p_class).f_prompt = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Instructs extension to show dialog `dialog_name`. If it cannot be found,
    /// or any error, then return `FALSE`. The caller can pass optional `parameters`,
    /// if `extension` uses any. Meaning of `parameters` is known only to the caller
    /// and to the dialog implementor, it's not interpretted nor checked for correctness
    /// in any way in `ebackend.UserPrompterServer`. The only limitation of `parameters` is that
    /// the array elements are strings.
    ///
    /// The `prompt_id` is used as an identificator of the prompt itself,
    /// and is used in `ebackend.UserPrompterServerExtension.response` call,
    /// which finishes the prompt.
    ///
    /// Note: The function call should not block main loop, it should
    /// just show dialog and return.
    extern fn e_user_prompter_server_extension_prompt(p_extension: *UserPrompterServerExtension, p_prompt_id: c_int, p_dialog_name: [*:0]const u8, p_parameters: ?*const edataserver.NamedParameters) c_int;
    pub const prompt = e_user_prompter_server_extension_prompt;

    /// A conveniente wrapper function around `ebackend.UserPrompterServer.response`,
    /// which ends previous call of `ebackend.UserPrompterServerExtension.prompt`.
    /// The `response` and `values` is known only to the caller and to the dialog implementor,
    /// it's not interpretted nor checked for correctness in any way in `ebackend.UserPrompterServer`.
    /// The only limitation of `values` is that the array elements are strings.
    extern fn e_user_prompter_server_extension_response(p_extension: *UserPrompterServerExtension, p_prompt_id: c_int, p_response: c_int, p_values: ?*const edataserver.NamedParameters) void;
    pub const response = e_user_prompter_server_extension_response;

    extern fn e_user_prompter_server_extension_get_type() usize;
    pub const getGObjectType = e_user_prompter_server_extension_get_type;

    extern fn g_object_ref(p_self: *ebackend.UserPrompterServerExtension) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.UserPrompterServerExtension) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *UserPrompterServerExtension, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const WebDAVCollectionBackend = extern struct {
    pub const Parent = ebackend.CollectionBackend;
    pub const Implements = [_]type{};
    pub const Class = ebackend.WebDAVCollectionBackendClass;
    f_parent: ebackend.CollectionBackend,
    f_priv: ?*ebackend.WebDAVCollectionBackendPrivate,

    pub const virtual_methods = struct {
        /// Verifies that the `source` is expected here and returns its resource ID,
        /// which is used in call to `ebackend.CollectionBackend.newChild`. It returns `NULL`,
        /// when the `source` is not part of the backend and should be removed instead.
        /// The default implementation allows all sources, which has `edataserver.SourceResource`
        /// extension defined.
        pub const get_resource_id = struct {
            pub fn call(p_class: anytype, p_webdav_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) ?[*:0]u8 {
                return gobject.ext.as(WebDAVCollectionBackend.Class, p_class).f_get_resource_id.?(gobject.ext.as(WebDAVCollectionBackend, p_webdav_backend), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_webdav_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(WebDAVCollectionBackend.Class, p_class).f_get_resource_id = @ptrCast(p_implementation);
            }
        };

        pub const is_custom_source = struct {
            pub fn call(p_class: anytype, p_webdav_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) c_int {
                return gobject.ext.as(WebDAVCollectionBackend.Class, p_class).f_is_custom_source.?(gobject.ext.as(WebDAVCollectionBackend, p_webdav_backend), p_source);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_webdav_backend: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source) callconv(.c) c_int) void {
                gobject.ext.as(WebDAVCollectionBackend.Class, p_class).f_is_custom_source = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// This function is usually called in EBackend::`authenticate_sync` implementation
    /// of the descendant, causing discovery of CalDAV and CardDAV sources on given URLs.
    /// If either of `calendar_url` and `contacts_url` is `NULL`, that that part is skipped.
    /// The `calendar_url` covers all calendars, memo lists and task lists.
    ///
    /// The function also takes care of `ebackend.CollectionBackend.authenticateChildren` on success.
    extern fn e_webdav_collection_backend_discover_sync(p_webdav_backend: *WebDAVCollectionBackend, p_calendar_url: ?[*:0]const u8, p_contacts_url: ?[*:0]const u8, p_credentials: *const edataserver.NamedParameters, p_out_certificate_pem: ?*[*:0]u8, p_out_certificate_errors: ?*gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) edataserver.SourceAuthenticationResult;
    pub const discoverSync = e_webdav_collection_backend_discover_sync;

    /// Verifies that the `source` is expected here and returns its resource ID,
    /// which is used in call to `ebackend.CollectionBackend.newChild`. It returns `NULL`,
    /// when the `source` is not part of the backend and should be removed instead.
    /// The default implementation allows all sources, which has `edataserver.SourceResource`
    /// extension defined.
    extern fn e_webdav_collection_backend_get_resource_id(p_webdav_backend: *WebDAVCollectionBackend, p_source: *edataserver.Source) ?[*:0]u8;
    pub const getResourceId = e_webdav_collection_backend_get_resource_id;

    extern fn e_webdav_collection_backend_is_custom_source(p_webdav_backend: *WebDAVCollectionBackend, p_source: *edataserver.Source) c_int;
    pub const isCustomSource = e_webdav_collection_backend_is_custom_source;

    extern fn e_webdav_collection_backend_get_type() usize;
    pub const getGObjectType = e_webdav_collection_backend_get_type;

    extern fn g_object_ref(p_self: *ebackend.WebDAVCollectionBackend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.WebDAVCollectionBackend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WebDAVCollectionBackend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2Support = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = ebackend.OAuth2SupportInterface;
    pub const virtual_methods = struct {
        /// Asynchronously obtains the OAuth 2.0 access token for `source` along
        /// with its expiry in seconds from the current time (or 0 if unknown).
        ///
        /// When the operation is finished, `callback` will be called.  You can then
        /// call `ebackend.OAuth2Support.getAccessTokenFinish` to get the result of the
        /// operation.
        pub const get_access_token = struct {
            pub fn call(p_class: anytype, p_support: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(OAuth2Support.Iface, p_class).f_get_access_token.?(gobject.ext.as(OAuth2Support, p_support), p_source, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_support: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(OAuth2Support.Iface, p_class).f_get_access_token = @ptrCast(p_implementation);
            }
        };

        /// Finishes the operation started with `ebackend.OAuth2Support.getAccessToken`.
        ///
        /// Free the returned access token with `glib.free` when finished with it.
        /// If an error occurred, the function will set `error` and return `FALSE`.
        pub const get_access_token_finish = struct {
            pub fn call(p_class: anytype, p_support: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(OAuth2Support.Iface, p_class).f_get_access_token_finish.?(gobject.ext.as(OAuth2Support, p_support), p_result, p_out_access_token, p_out_expires_in, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_support: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(OAuth2Support.Iface, p_class).f_get_access_token_finish = @ptrCast(p_implementation);
            }
        };

        /// Obtains the OAuth 2.0 access token for `source` along with its expiry
        /// in seconds from the current time (or 0 if unknown).
        ///
        /// Free the returned access token with `glib.free` when finished with it.
        /// If an error occurs, the function will set `error` and return `FALSE`.
        pub const get_access_token_sync = struct {
            pub fn call(p_class: anytype, p_support: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(OAuth2Support.Iface, p_class).f_get_access_token_sync.?(gobject.ext.as(OAuth2Support, p_support), p_source, p_cancellable, p_out_access_token, p_out_expires_in, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_support: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(OAuth2Support.Iface, p_class).f_get_access_token_sync = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Asynchronously obtains the OAuth 2.0 access token for `source` along
    /// with its expiry in seconds from the current time (or 0 if unknown).
    ///
    /// When the operation is finished, `callback` will be called.  You can then
    /// call `ebackend.OAuth2Support.getAccessTokenFinish` to get the result of the
    /// operation.
    extern fn e_oauth2_support_get_access_token(p_support: *OAuth2Support, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getAccessToken = e_oauth2_support_get_access_token;

    /// Finishes the operation started with `ebackend.OAuth2Support.getAccessToken`.
    ///
    /// Free the returned access token with `glib.free` when finished with it.
    /// If an error occurred, the function will set `error` and return `FALSE`.
    extern fn e_oauth2_support_get_access_token_finish(p_support: *OAuth2Support, p_result: *gio.AsyncResult, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) c_int;
    pub const getAccessTokenFinish = e_oauth2_support_get_access_token_finish;

    /// Obtains the OAuth 2.0 access token for `source` along with its expiry
    /// in seconds from the current time (or 0 if unknown).
    ///
    /// Free the returned access token with `glib.free` when finished with it.
    /// If an error occurs, the function will set `error` and return `FALSE`.
    extern fn e_oauth2_support_get_access_token_sync(p_support: *OAuth2Support, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) c_int;
    pub const getAccessTokenSync = e_oauth2_support_get_access_token_sync;

    extern fn e_oauth2_support_get_type() usize;
    pub const getGObjectType = e_oauth2_support_get_type;

    extern fn g_object_ref(p_self: *ebackend.OAuth2Support) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *ebackend.OAuth2Support) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OAuth2Support, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Base class structure for the `ebackend.Backend` class
pub const BackendClass = extern struct {
    pub const Instance = ebackend.Backend;

    f_parent_class: gobject.ObjectClass,
    /// Fetch the destination address
    f_get_destination_address: ?*const fn (p_backend: *ebackend.Backend, p_host: *[*:0]u8, p_port: *u16) callconv(.c) c_int,
    /// Prepare for shutdown
    f_prepare_shutdown: ?*const fn (p_backend: *ebackend.Backend) callconv(.c) void,
    /// Authenticate synchronously
    f_authenticate_sync: ?*const fn (p_backend: *ebackend.Backend, p_credentials: *const edataserver.NamedParameters, p_out_certificate_pem: *[*:0]u8, p_out_certificate_errors: *gio.TlsCertificateFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) edataserver.SourceAuthenticationResult,
    f_reserved: [11]*anyopaque,

    pub fn as(p_instance: *BackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Base class structure for the `ebackend.BackendFactory` class
pub const BackendFactoryClass = extern struct {
    pub const Instance = ebackend.BackendFactory;

    f_parent_class: edataserver.ExtensionClass,
    /// Get the hash key for this factory
    f_get_hash_key: ?*const fn (p_factory: *ebackend.BackendFactory) callconv(.c) [*:0]const u8,
    /// Create a new `ebackend.Backend` of the appropriate type for the passed `edataserver.Source`
    f_new_backend: ?*const fn (p_factory: *ebackend.BackendFactory, p_source: *edataserver.Source) callconv(.c) *ebackend.Backend,
    /// An `edataserver.Module` associated with this backend factory
    f_e_module: ?*anyopaque,
    /// Whether subporcesses for this backend factory should share one process
    f_share_subprocess: c_int,
    f_reserved: [15]*anyopaque,

    pub fn as(p_instance: *BackendFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BackendFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CacheClass = extern struct {
    pub const Instance = ebackend.Cache;

    f_parent_class: gobject.ObjectClass,
    f_put_locked: ?*const fn (p_cache: *ebackend.Cache, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_other_columns: *ebackend.CacheColumnValues, p_offline_state: ebackend.OfflineState, p_is_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remove_locked: ?*const fn (p_cache: *ebackend.Cache, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_remove_all_locked: ?*const fn (p_cache: *ebackend.Cache, p_uids: *const glib.SList, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_clear_offline_changes_locked: ?*const fn (p_cache: *ebackend.Cache, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_erase: ?*const fn (p_cache: *ebackend.Cache) callconv(.c) void,
    f_before_put: ?*const fn (p_cache: *ebackend.Cache, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_other_columns: *ebackend.CacheColumnValues, p_is_replace: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_before_remove: ?*const fn (p_cache: *ebackend.Cache, p_uid: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_revision_changed: ?*const fn (p_cache: *ebackend.Cache) callconv(.c) void,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *CacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CacheColumnInfo = extern struct {
    f_name: ?[*:0]u8,
    f_type: ?[*:0]u8,
    f_index_name: ?[*:0]u8,

    /// Frees the `info` structure, previously allocated with `ebackend.CacheColumnInfo.new`
    /// or `ebackend.CacheColumnInfo.copy`.
    extern fn e_cache_column_info_free(p_info: ?*anyopaque) void;
    pub const free = e_cache_column_info_free;

    extern fn e_cache_column_info_new(p_name: [*:0]const u8, p_type: [*:0]const u8, p_index_name: ?[*:0]const u8) *ebackend.CacheColumnInfo;
    pub const new = e_cache_column_info_new;

    extern fn e_cache_column_info_copy(p_info: ?*const CacheColumnInfo) ?*ebackend.CacheColumnInfo;
    pub const copy = e_cache_column_info_copy;

    extern fn e_cache_column_info_get_type() usize;
    pub const getGObjectType = e_cache_column_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CacheColumnValues = opaque {
    /// Creates a new `ebackend.CacheColumnValues` to store values for additional columns.
    /// The column names are compared case insensitively.
    extern fn e_cache_column_values_new() *ebackend.CacheColumnValues;
    pub const new = e_cache_column_values_new;

    extern fn e_cache_column_values_contains(p_other_columns: *CacheColumnValues, p_name: [*:0]const u8) c_int;
    pub const contains = e_cache_column_values_contains;

    extern fn e_cache_column_values_copy(p_other_columns: ?*CacheColumnValues) *ebackend.CacheColumnValues;
    pub const copy = e_cache_column_values_copy;

    /// Frees previously allocated `other_columns` with
    /// `ebackend.CacheColumnValues.new` or `ebackend.CacheColumnValues.copy`.
    extern fn e_cache_column_values_free(p_other_columns: ?*CacheColumnValues) void;
    pub const free = e_cache_column_values_free;

    extern fn e_cache_column_values_get_size(p_other_columns: *CacheColumnValues) c_uint;
    pub const getSize = e_cache_column_values_get_size;

    /// Initialized the `iter`, thus the `other_columns` can be traversed
    /// with `glib.HashTableIter.next`. The key is a column name and
    /// the value is the corresponding column value.
    extern fn e_cache_column_values_init_iter(p_other_columns: *CacheColumnValues, p_iter: *glib.HashTableIter) void;
    pub const initIter = e_cache_column_values_init_iter;

    /// Looks up currently stored value for the column named `name`.
    /// As the values can be `NULL` one cannot distinguish between
    /// a column which doesn't have stored any value and a column
    /// which has stored `NULL` value. Use `ebackend.CacheColumnValues.contains`
    /// to check whether such column exitst in the `other_columns`.
    /// The returned pointer is owned by `other_columns` and is valid until
    /// the value is overwritten of the `other_columns` freed.
    extern fn e_cache_column_values_lookup(p_other_columns: *CacheColumnValues, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const lookup = e_cache_column_values_lookup;

    /// Puts the `value` for column `name`. If contains a value for the same
    /// column, then it is replaced. This creates a copy of both `name`
    /// and `value`.
    extern fn e_cache_column_values_put(p_other_columns: *CacheColumnValues, p_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
    pub const put = e_cache_column_values_put;

    /// Removes value for the column named `name` from `other_columns`.
    extern fn e_cache_column_values_remove(p_other_columns: *CacheColumnValues, p_name: [*:0]const u8) c_int;
    pub const remove = e_cache_column_values_remove;

    /// Removes all values from the `other_columns`, leaving it empty.
    extern fn e_cache_column_values_remove_all(p_other_columns: *CacheColumnValues) void;
    pub const removeAll = e_cache_column_values_remove_all;

    /// Puts the `value` for column `name`. If contains a value for the same
    /// column, then it is replaced. This creates takes ownership of both
    /// the `name` and the `value`.
    extern fn e_cache_column_values_take(p_other_columns: *CacheColumnValues, p_name: [*:0]u8, p_value: ?[*:0]u8) void;
    pub const take = e_cache_column_values_take;

    /// Puts the `value` for column `name`. If contains a value for the same
    /// column, then it is replaced. This creates a copy of the `name`, but
    /// takes owner ship of the `value`.
    extern fn e_cache_column_values_take_value(p_other_columns: *CacheColumnValues, p_name: [*:0]const u8, p_value: ?[*:0]u8) void;
    pub const takeValue = e_cache_column_values_take_value;

    extern fn e_cache_column_values_get_type() usize;
    pub const getGObjectType = e_cache_column_values_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CacheKeysClass = extern struct {
    pub const Instance = ebackend.CacheKeys;

    f_parent_class: gobject.ObjectClass,
    f_changed: ?*const fn (p_self: *ebackend.CacheKeys) callconv(.c) void,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *CacheKeysClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CacheKeysPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Holds the information about offline change for one object.
pub const CacheOfflineChange = extern struct {
    /// UID of the object
    f_uid: ?[*:0]u8,
    /// stored revision of the object
    f_revision: ?[*:0]u8,
    /// the object itself
    f_object: ?[*:0]u8,
    /// an `ebackend.OfflineState` of the object
    f_state: ebackend.OfflineState,

    /// Frees the `change` structure, previously allocated with `ebackend.CacheOfflineChange.new`
    /// or `ebackend.CacheOfflineChange.copy`.
    extern fn e_cache_offline_change_free(p_change: ?*anyopaque) void;
    pub const free = e_cache_offline_change_free;

    /// Creates a new `ebackend.CacheOfflineChange` with the offline `state`
    /// information for the given `uid`.
    extern fn e_cache_offline_change_new(p_uid: [*:0]const u8, p_revision: ?[*:0]const u8, p_object: ?[*:0]const u8, p_state: ebackend.OfflineState) *ebackend.CacheOfflineChange;
    pub const new = e_cache_offline_change_new;

    extern fn e_cache_offline_change_copy(p_change: ?*const CacheOfflineChange) ?*ebackend.CacheOfflineChange;
    pub const copy = e_cache_offline_change_copy;

    extern fn e_cache_offline_change_get_type() usize;
    pub const getGObjectType = e_cache_offline_change_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CachePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CacheReaperClass = opaque {
    pub const Instance = ebackend.CacheReaper;

    pub fn as(p_instance: *CacheReaperClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CollectionBackendClass = extern struct {
    pub const Instance = ebackend.CollectionBackend;

    f_parent_class: ebackend.BackendClass,
    f_populate: ?*const fn (p_backend: *ebackend.CollectionBackend) callconv(.c) void,
    f_dup_resource_id: ?*const fn (p_backend: *ebackend.CollectionBackend, p_child_source: *edataserver.Source) callconv(.c) ?[*:0]u8,
    f_child_added: ?*const fn (p_backend: *ebackend.CollectionBackend, p_child_source: *edataserver.Source) callconv(.c) void,
    f_child_removed: ?*const fn (p_backend: *ebackend.CollectionBackend, p_child_source: *edataserver.Source) callconv(.c) void,
    f_create_resource_sync: ?*const fn (p_backend: *ebackend.CollectionBackend, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_create_resource: ?*const fn (p_backend: *ebackend.CollectionBackend, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_create_resource_finish: ?*const fn (p_backend: *ebackend.CollectionBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_delete_resource_sync: ?*const fn (p_backend: *ebackend.CollectionBackend, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_delete_resource: ?*const fn (p_backend: *ebackend.CollectionBackend, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_delete_resource_finish: ?*const fn (p_backend: *ebackend.CollectionBackend, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *CollectionBackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CollectionBackendFactoryClass = extern struct {
    pub const Instance = ebackend.CollectionBackendFactory;

    f_parent_class: ebackend.BackendFactoryClass,
    f_factory_name: ?[*:0]const u8,
    f_backend_type: usize,
    f_prepare_mail: ?*const fn (p_factory: *ebackend.CollectionBackendFactory, p_mail_account_source: *edataserver.Source, p_mail_identity_source: *edataserver.Source, p_mail_transport_source: *edataserver.Source) callconv(.c) void,
    f_reserved: [16]*anyopaque,

    pub fn as(p_instance: *CollectionBackendFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CollectionBackendFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CollectionBackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DBusServerClass = extern struct {
    pub const Instance = ebackend.DBusServer;

    f_parent_class: gobject.ObjectClass,
    f_bus_name: ?[*:0]const u8,
    f_module_directory: ?[*:0]const u8,
    f_bus_acquired: ?*const fn (p_server: *ebackend.DBusServer, p_connection: *gio.DBusConnection) callconv(.c) void,
    f_bus_name_acquired: ?*const fn (p_server: *ebackend.DBusServer, p_connection: *gio.DBusConnection) callconv(.c) void,
    f_bus_name_lost: ?*const fn (p_server: *ebackend.DBusServer, p_connection: *gio.DBusConnection) callconv(.c) void,
    f_run_server: ?*const fn (p_server: *ebackend.DBusServer) callconv(.c) ebackend.DBusServerExitCode,
    f_quit_server: ?*const fn (p_server: *ebackend.DBusServer, p_code: ebackend.DBusServerExitCode) callconv(.c) void,
    f_reserved: [14]*anyopaque,

    pub fn as(p_instance: *DBusServerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DBusServerPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataFactoryClass = extern struct {
    pub const Instance = ebackend.DataFactory;

    f_parent_class: ebackend.DBusServerClass,
    f_backend_factory_type: usize,
    f_factory_object_path: ?[*:0]const u8,
    f_data_object_path_prefix: ?[*:0]const u8,
    f_subprocess_object_path_prefix: ?[*:0]const u8,
    f_subprocess_bus_name_prefix: ?[*:0]const u8,
    f_get_dbus_interface_skeleton: ?*const fn (p_server: *ebackend.DBusServer) callconv(.c) *gio.DBusInterfaceSkeleton,
    f_get_factory_name: ?*const fn (p_backend_factory: *ebackend.BackendFactory) callconv(.c) [*:0]const u8,
    f_complete_open: ?*const fn (p_data_factory: *ebackend.DataFactory, p_invocation: *gio.DBusMethodInvocation, p_object_path: [*:0]const u8, p_bus_name: [*:0]const u8, p_extension_name: [*:0]const u8) callconv(.c) void,
    f_create_backend: ?*const fn (p_data_factory: *ebackend.DataFactory, p_backend_factory: *ebackend.BackendFactory, p_source: *edataserver.Source) callconv(.c) ?*ebackend.Backend,
    f_open_backend: ?*const fn (p_data_factory: *ebackend.DataFactory, p_backend: *ebackend.Backend, p_connection: *gio.DBusConnection, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?[*:0]u8,
    f_reserved: [13]*anyopaque,

    pub fn as(p_instance: *DataFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DataFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FileCacheClass = extern struct {
    pub const Instance = ebackend.FileCache;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *FileCacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FileCachePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OAuth2SupportInterface = extern struct {
    pub const Instance = ebackend.OAuth2Support;

    f_parent_interface: gobject.TypeInterface,
    /// synchronous interface method to get the access token
    f_get_access_token_sync: ?*const fn (p_support: *ebackend.OAuth2Support, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// asynchronous interface method to get the access token
    f_get_access_token: ?*const fn (p_support: *ebackend.OAuth2Support, p_source: *edataserver.Source, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    /// counterpart of the asynchronous interface method to finishd get of the access token
    f_get_access_token_finish: ?*const fn (p_support: *ebackend.OAuth2Support, p_result: *gio.AsyncResult, p_out_access_token: ?*[*:0]u8, p_out_expires_in: ?*c_int, p_error: ?*?*glib.Error) callconv(.c) c_int,

    pub fn as(p_instance: *OAuth2SupportInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServerSideSourceClass = extern struct {
    pub const Instance = ebackend.ServerSideSource;

    f_parent_class: edataserver.SourceClass,

    pub fn as(p_instance: *ServerSideSourceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServerSideSourceCredentialsProviderClass = extern struct {
    pub const Instance = ebackend.ServerSideSourceCredentialsProvider;

    f_parent_class: edataserver.SourceCredentialsProviderClass,

    pub fn as(p_instance: *ServerSideSourceCredentialsProviderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServerSideSourceCredentialsProviderPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServerSideSourcePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRegistryServerClass = extern struct {
    pub const Instance = ebackend.SourceRegistryServer;

    f_parent_class: ebackend.DataFactoryClass,
    f_load_error: ?*const fn (p_server: *ebackend.SourceRegistryServer, p_file: *gio.File, p_error: *const glib.Error) callconv(.c) void,
    f_files_loaded: ?*const fn (p_server: *ebackend.SourceRegistryServer) callconv(.c) void,
    f_source_added: ?*const fn (p_server: *ebackend.SourceRegistryServer, p_source: *edataserver.Source) callconv(.c) void,
    f_source_removed: ?*const fn (p_server: *ebackend.SourceRegistryServer, p_source: *edataserver.Source) callconv(.c) void,
    f_tweak_key_file: ?*const fn (p_server: *ebackend.SourceRegistryServer, p_key_file: *glib.KeyFile, p_uid: [*:0]const u8) callconv(.c) c_int,
    f_reserved: [16]*anyopaque,

    pub fn as(p_instance: *SourceRegistryServerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SourceRegistryServerPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubprocessFactoryClass = extern struct {
    pub const Instance = ebackend.SubprocessFactory;

    f_parent_class: gobject.ObjectClass,
    f_ref_backend: ?*const fn (p_registry: *edataserver.SourceRegistry, p_source: *edataserver.Source, p_backend_factory_type_name: [*:0]const u8) callconv(.c) *ebackend.Backend,
    f_open_data: ?*const fn (p_subprocess_factory: *ebackend.SubprocessFactory, p_backend: *ebackend.Backend, p_connection: *gio.DBusConnection, p_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) ?[*:0]u8,
    f_backend_created: ?*const fn (p_subprocess_factory: *ebackend.SubprocessFactory, p_backend: *ebackend.Backend) callconv(.c) void,
    f_backend_closed: ?*const fn (p_subprocess_factory: *ebackend.SubprocessFactory, p_backend: *ebackend.Backend) callconv(.c) void,

    pub fn as(p_instance: *SubprocessFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SubprocessFactoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UserPrompterClass = extern struct {
    pub const Instance = ebackend.UserPrompter;

    f_parent: gobject.ObjectClass,

    pub fn as(p_instance: *UserPrompterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UserPrompterPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UserPrompterServerClass = extern struct {
    pub const Instance = ebackend.UserPrompterServer;

    f_parent_class: ebackend.DBusServerClass,
    f_prompt: ?*const fn (p_server: *ebackend.UserPrompterServer, p_id: c_int, p_type: [*:0]const u8, p_title: [*:0]const u8, p_primary_text: [*:0]const u8, p_secondary_text: [*:0]const u8, p_use_markup: c_int, p_button_captions: *const glib.SList) callconv(.c) void,

    pub fn as(p_instance: *UserPrompterServerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UserPrompterServerExtensionClass = extern struct {
    pub const Instance = ebackend.UserPrompterServerExtension;

    f_parent_class: edataserver.ExtensionClass,
    f_register_dialogs: ?*const fn (p_extension: *edataserver.Extension, p_server: *anyopaque) callconv(.c) void,
    f_prompt: ?*const fn (p_extension: *ebackend.UserPrompterServerExtension, p_prompt_id: c_int, p_dialog_name: [*:0]const u8, p_parameters: ?*const edataserver.NamedParameters) callconv(.c) c_int,

    pub fn as(p_instance: *UserPrompterServerExtensionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UserPrompterServerExtensionPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UserPrompterServerPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVCollectionBackendClass = extern struct {
    pub const Instance = ebackend.WebDAVCollectionBackend;

    f_parent_class: ebackend.CollectionBackendClass,
    f_get_resource_id: ?*const fn (p_webdav_backend: *ebackend.WebDAVCollectionBackend, p_source: *edataserver.Source) callconv(.c) ?[*:0]u8,
    f_is_custom_source: ?*const fn (p_webdav_backend: *ebackend.WebDAVCollectionBackend, p_source: *edataserver.Source) callconv(.c) c_int,

    pub fn as(p_instance: *WebDAVCollectionBackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVCollectionBackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Completion codes used by `EAuthenticationSession`.
pub const AuthenticationSessionResult = enum(c_int) {
    @"error" = 0,
    success = 1,
    dismissed = 2,
    _,

    extern fn e_authentication_session_result_get_type() usize;
    pub const getGObjectType = e_authentication_session_result_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Declares whether to exclude or include locally deleted objects.
pub const CacheDeletedFlag = enum(c_int) {
    exclude_deleted = 0,
    include_deleted = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the types of possible errors reported by the `ebackend.Cache`
pub const CacheError = enum(c_int) {
    engine = 0,
    constraint = 1,
    not_found = 2,
    invalid_query = 3,
    unsupported_field = 4,
    unsupported_query = 5,
    end_of_list = 6,
    load = 7,
    corrupt = 8,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the type of lock requested in `ebackend.Cache.lock`.
pub const CacheLockType = enum(c_int) {
    read = 0,
    write = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Declares whether the operation is done in online or offline.
/// This influences the offline state of the related objects.
pub const CacheOfflineFlag = enum(c_int) {
    offline_unknown = -1,
    is_online = 0,
    is_offline = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates what type of action to take while unlocking the cache with `ebackend.Cache.unlock`.
pub const CacheUnlockAction = enum(c_int) {
    none = 0,
    commit = 1,
    rollback = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Exit codes submitted to `ebackend.DBusServer.quit` and returned by
/// `ebackend.DBusServer.run`.
pub const DBusServerExitCode = enum(c_int) {
    none = 0,
    normal = 1,
    reload = 2,
    _,

    extern fn e_dbus_server_exit_code_get_type() usize;
    pub const getGObjectType = e_dbus_server_exit_code_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines offline state of an object. Locally changed objects require
/// synchronization with their remote storage.
pub const OfflineState = enum(c_int) {
    unknown = -1,
    synced = 0,
    locally_created = 1,
    locally_modified = 2,
    locally_deleted = 3,
    _,

    extern fn e_offline_state_get_type() usize;
    pub const getGObjectType = e_offline_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags to check whether at least one of the asked for parts is enabled.
pub const CollectionBackendParts = packed struct(c_uint) {
    calendar: bool = false,
    contacts: bool = false,
    mail: bool = false,
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

    pub const flags_none: CollectionBackendParts = @bitCast(@as(c_uint, 0));
    pub const flags_calendar: CollectionBackendParts = @bitCast(@as(c_uint, 1));
    pub const flags_contacts: CollectionBackendParts = @bitCast(@as(c_uint, 2));
    pub const flags_mail: CollectionBackendParts = @bitCast(@as(c_uint, 4));
    pub const flags_any: CollectionBackendParts = @bitCast(@as(c_int, -1));
    extern fn e_collection_backend_parts_get_type() usize;
    pub const getGObjectType = e_collection_backend_parts_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Initial permissions for a newly-loaded data source key file.
pub const SourcePermissionFlags = packed struct(c_uint) {
    writable: bool = false,
    removable: bool = false,
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

    pub const flags_none: SourcePermissionFlags = @bitCast(@as(c_uint, 0));
    pub const flags_writable: SourcePermissionFlags = @bitCast(@as(c_uint, 1));
    pub const flags_removable: SourcePermissionFlags = @bitCast(@as(c_uint, 2));
    extern fn e_source_permission_flags_get_type() usize;
    pub const getGObjectType = e_source_permission_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn e_sqlite3_vfs_init() void;
pub const sqlite3VfsInit = e_sqlite3_vfs_init;

/// A callback called for each object row when using `ebackend.Cache.foreach` function.
pub const CacheForeachFunc = *const fn (p_cache: *ebackend.Cache, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_offline_state: ebackend.OfflineState, p_ncols: c_int, p_column_names: [*][*:0]const u8, p_column_values: [*][*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// A callback called for each row of the `self` table when
/// using `ebackend.CacheKeys.foreachSync` function.
pub const CacheKeysForeachFunc = *const fn (p_self: *ebackend.CacheKeys, p_key: [*:0]const u8, p_value: [*:0]const u8, p_ref_count: c_uint, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// A callback called for each row of a SELECT statement executed
/// with `ebackend.Cache.sqliteSelect` function.
pub const CacheSelectFunc = *const fn (p_cache: *ebackend.Cache, p_ncols: c_int, p_column_names: [*][*:0]const u8, p_column_values: [*][*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// A callback called for each object row when using `ebackend.Cache.foreachUpdate` function.
/// When all out parameters are left untouched, then the row is not changed.
pub const CacheUpdateFunc = *const fn (p_cache: *ebackend.Cache, p_uid: [*:0]const u8, p_revision: [*:0]const u8, p_object: [*:0]const u8, p_offline_state: ebackend.OfflineState, p_ncols: c_int, p_column_names: [*][*:0]const u8, p_column_values: [*][*:0]const u8, p_out_revision: *[*:0]u8, p_out_object: *[*:0]u8, p_out_offline_state: *ebackend.OfflineState, p_out_other_columns: **ebackend.CacheColumnValues, p_user_data: ?*anyopaque) callconv(.c) c_int;

pub const CACHE_COLUMN_OBJECT = "ECacheOBJ";
pub const CACHE_COLUMN_REVISION = "ECacheREV";
pub const CACHE_COLUMN_STATE = "ECacheState";
pub const CACHE_COLUMN_UID = "ECacheUID";
pub const CACHE_TABLE_KEYS = "ECacheKeys";
pub const CACHE_TABLE_OBJECTS = "ECacheObjects";
/// This environment variable configures where the registry
/// server loads it's backend modules from.
pub const EDS_REGISTRY_MODULES = "EDS_REGISTRY_MODULES";
/// D-Bus object path of the data source server.
pub const SOURCE_REGISTRY_SERVER_OBJECT_PATH = "/org/gnome/evolution/dataserver/SourceManager";
/// D-Bus object path of the user prompter.
pub const USER_PROMPTER_SERVER_OBJECT_PATH = "/org/gnome/evolution/dataserver/UserPrompter";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
