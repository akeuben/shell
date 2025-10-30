pub const ext = @import("ext.zig");
const soup = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// The abstract base class for handling authentication.
///
/// Specific HTTP Authentication mechanisms are implemented by its subclasses,
/// but applications never need to be aware of the specific subclasses being
/// used.
///
/// `soup.Auth` objects store the authentication data associated with a given bit
/// of web space. They are created automatically by `Session`.
pub const Auth = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = soup.AuthClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Call this on an auth to authenticate it.
        ///
        /// Normally this will cause the auth's message to be requeued with the new
        /// authentication info.
        pub const authenticate = struct {
            pub fn call(p_class: anytype, p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_username: [*:0]const u8, p_password: [*:0]const u8) void {
                return gobject.ext.as(Auth.Class, p_class).f_authenticate.?(gobject.ext.as(Auth, p_auth), p_username, p_password);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_username: [*:0]const u8, p_password: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Auth.Class, p_class).f_authenticate = @ptrCast(p_implementation);
            }
        };

        /// Tests if `auth` is able to authenticate by providing credentials to the
        /// `Auth.authenticate`.
        pub const can_authenticate = struct {
            pub fn call(p_class: anytype, p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Auth.Class, p_class).f_can_authenticate.?(gobject.ext.as(Auth, p_auth));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Auth.Class, p_class).f_can_authenticate = @ptrCast(p_implementation);
            }
        };

        /// Generates an appropriate "Authorization" header for `msg`.
        ///
        /// (The session will only call this if `Auth.isAuthenticated` returned
        /// `TRUE`.)
        pub const get_authorization = struct {
            pub fn call(p_class: anytype, p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) [*:0]u8 {
                return gobject.ext.as(Auth.Class, p_class).f_get_authorization.?(gobject.ext.as(Auth, p_auth), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Auth.Class, p_class).f_get_authorization = @ptrCast(p_implementation);
            }
        };

        /// Returns a list of paths on the server which `auth` extends over.
        ///
        /// (All subdirectories of these paths are also assumed to be part
        /// of `auth`'s protection space, unless otherwise discovered not to
        /// be.)
        pub const get_protection_space = struct {
            pub fn call(p_class: anytype, p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source_uri: *glib.Uri) *glib.SList {
                return gobject.ext.as(Auth.Class, p_class).f_get_protection_space.?(gobject.ext.as(Auth, p_auth), p_source_uri);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_source_uri: *glib.Uri) callconv(.c) *glib.SList) void {
                gobject.ext.as(Auth.Class, p_class).f_get_protection_space = @ptrCast(p_implementation);
            }
        };

        /// Tests if `auth` has been given a username and password.
        pub const is_authenticated = struct {
            pub fn call(p_class: anytype, p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Auth.Class, p_class).f_is_authenticated.?(gobject.ext.as(Auth, p_auth));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Auth.Class, p_class).f_is_authenticated = @ptrCast(p_implementation);
            }
        };

        /// Tests if `auth` is ready to make a request for `msg` with.
        ///
        /// For most auths, this is equivalent to `Auth.isAuthenticated`, but for
        /// some auth types (eg, NTLM), the auth may be sendable (eg, as an
        /// authentication request) even before it is authenticated.
        pub const is_ready = struct {
            pub fn call(p_class: anytype, p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) c_int {
                return gobject.ext.as(Auth.Class, p_class).f_is_ready.?(gobject.ext.as(Auth, p_auth), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) callconv(.c) c_int) void {
                gobject.ext.as(Auth.Class, p_class).f_is_ready = @ptrCast(p_implementation);
            }
        };

        /// Updates `auth` with the information from `msg` and `auth_header`,
        /// possibly un-authenticating it.
        ///
        /// As with `Auth.new`, this is normally only used by `Session`.
        pub const update = struct {
            pub fn call(p_class: anytype, p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message, p_auth_header: *glib.HashTable) c_int {
                return gobject.ext.as(Auth.Class, p_class).f_update.?(gobject.ext.as(Auth, p_auth), p_msg, p_auth_header);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_auth: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message, p_auth_header: *glib.HashTable) callconv(.c) c_int) void {
                gobject.ext.as(Auth.Class, p_class).f_update = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The authority (host:port) being authenticated to.
        pub const authority = struct {
            pub const name = "authority";

            pub const Type = ?[*:0]u8;
        };

        /// Whether or not the auth has been authenticated.
        pub const is_authenticated = struct {
            pub const name = "is-authenticated";

            pub const Type = c_int;
        };

        /// Whether or not the auth has been cancelled.
        pub const is_cancelled = struct {
            pub const name = "is-cancelled";

            pub const Type = c_int;
        };

        /// Whether or not the auth is for a proxy server.
        pub const is_for_proxy = struct {
            pub const name = "is-for-proxy";

            pub const Type = c_int;
        };

        /// The authentication realm.
        pub const realm = struct {
            pub const name = "realm";

            pub const Type = ?[*:0]u8;
        };

        /// The authentication scheme name.
        pub const scheme_name = struct {
            pub const name = "scheme-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `soup.Auth` of type `type` with the information from
    /// `msg` and `auth_header`.
    ///
    /// This is called by `Session`; you will normally not create auths
    /// yourself.
    extern fn soup_auth_new(p_type: usize, p_msg: *soup.Message, p_auth_header: [*:0]const u8) ?*soup.Auth;
    pub const new = soup_auth_new;

    /// Call this on an auth to authenticate it.
    ///
    /// Normally this will cause the auth's message to be requeued with the new
    /// authentication info.
    extern fn soup_auth_authenticate(p_auth: *Auth, p_username: [*:0]const u8, p_password: [*:0]const u8) void;
    pub const authenticate = soup_auth_authenticate;

    /// Tests if `auth` is able to authenticate by providing credentials to the
    /// `Auth.authenticate`.
    extern fn soup_auth_can_authenticate(p_auth: *Auth) c_int;
    pub const canAuthenticate = soup_auth_can_authenticate;

    /// Call this on an auth to cancel it.
    ///
    /// You need to cancel an auth to complete an asynchronous authenticate operation
    /// when no credentials are provided (`Auth.authenticate` is not called).
    /// The `soup.Auth` will be cancelled on dispose if it hans't been authenticated.
    extern fn soup_auth_cancel(p_auth: *Auth) void;
    pub const cancel = soup_auth_cancel;

    /// Frees `space`.
    extern fn soup_auth_free_protection_space(p_auth: *Auth, p_space: *glib.SList) void;
    pub const freeProtectionSpace = soup_auth_free_protection_space;

    /// Returns the authority (host:port) that `auth` is associated with.
    extern fn soup_auth_get_authority(p_auth: *Auth) [*:0]const u8;
    pub const getAuthority = soup_auth_get_authority;

    /// Generates an appropriate "Authorization" header for `msg`.
    ///
    /// (The session will only call this if `Auth.isAuthenticated` returned
    /// `TRUE`.)
    extern fn soup_auth_get_authorization(p_auth: *Auth, p_msg: *soup.Message) [*:0]u8;
    pub const getAuthorization = soup_auth_get_authorization;

    /// Gets an opaque identifier for `auth`.
    ///
    /// The identifier can be used as a hash key or the like. `soup.Auth` objects from
    /// the same server with the same identifier refer to the same authentication
    /// domain (eg, the URLs associated with them take the same usernames and
    /// passwords).
    extern fn soup_auth_get_info(p_auth: *Auth) [*:0]u8;
    pub const getInfo = soup_auth_get_info;

    /// Returns a list of paths on the server which `auth` extends over.
    ///
    /// (All subdirectories of these paths are also assumed to be part
    /// of `auth`'s protection space, unless otherwise discovered not to
    /// be.)
    extern fn soup_auth_get_protection_space(p_auth: *Auth, p_source_uri: *glib.Uri) *glib.SList;
    pub const getProtectionSpace = soup_auth_get_protection_space;

    /// Returns `auth`'s realm.
    ///
    /// This is an identifier that distinguishes separate authentication spaces on a
    /// given server, and may be some string that is meaningful to the user.
    /// (Although it is probably not localized.)
    extern fn soup_auth_get_realm(p_auth: *Auth) [*:0]const u8;
    pub const getRealm = soup_auth_get_realm;

    /// soup_auth_get_scheme_name: (attributes org.gtk.Method.get_property=scheme-name)
    /// Returns `auth`'s scheme name. (Eg, "Basic", "Digest", or "NTLM")
    extern fn soup_auth_get_scheme_name(p_auth: *Auth) [*:0]const u8;
    pub const getSchemeName = soup_auth_get_scheme_name;

    /// Tests if `auth` has been given a username and password.
    extern fn soup_auth_is_authenticated(p_auth: *Auth) c_int;
    pub const isAuthenticated = soup_auth_is_authenticated;

    /// Tests if `auth` has been cancelled
    extern fn soup_auth_is_cancelled(p_auth: *Auth) c_int;
    pub const isCancelled = soup_auth_is_cancelled;

    /// Tests whether or not `auth` is associated with a proxy server rather
    /// than an "origin" server.
    extern fn soup_auth_is_for_proxy(p_auth: *Auth) c_int;
    pub const isForProxy = soup_auth_is_for_proxy;

    /// Tests if `auth` is ready to make a request for `msg` with.
    ///
    /// For most auths, this is equivalent to `Auth.isAuthenticated`, but for
    /// some auth types (eg, NTLM), the auth may be sendable (eg, as an
    /// authentication request) even before it is authenticated.
    extern fn soup_auth_is_ready(p_auth: *Auth, p_msg: *soup.Message) c_int;
    pub const isReady = soup_auth_is_ready;

    /// Updates `auth` with the information from `msg` and `auth_header`,
    /// possibly un-authenticating it.
    ///
    /// As with `Auth.new`, this is normally only used by `Session`.
    extern fn soup_auth_update(p_auth: *Auth, p_msg: *soup.Message, p_auth_header: [*:0]const u8) c_int;
    pub const update = soup_auth_update;

    extern fn soup_auth_get_type() usize;
    pub const getGObjectType = soup_auth_get_type;

    extern fn g_object_ref(p_self: *soup.Auth) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.Auth) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Auth, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// HTTP "Basic" authentication.
///
/// `Session`s support this by default; if you want to disable
/// support for it, call `Session.removeFeatureByType`,
/// passing `SOUP_TYPE_AUTH_BASIC`.
pub const AuthBasic = opaque {
    pub const Parent = soup.Auth;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = AuthBasic;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn soup_auth_basic_get_type() usize;
    pub const getGObjectType = soup_auth_basic_get_type;

    extern fn g_object_ref(p_self: *soup.AuthBasic) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.AuthBasic) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthBasic, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// HTTP "Digest" authentication.
///
/// `Session`s support this by default; if you want to disable
/// support for it, call `Session.removeFeatureByType`
/// passing `SOUP_TYPE_AUTH_DIGEST`.
pub const AuthDigest = opaque {
    pub const Parent = soup.Auth;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = AuthDigest;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn soup_auth_digest_get_type() usize;
    pub const getGObjectType = soup_auth_digest_get_type;

    extern fn g_object_ref(p_self: *soup.AuthDigest) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.AuthDigest) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthDigest, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Server-side authentication.
///
/// A `soup.AuthDomain` manages authentication for all or part of a
/// `Server`. To make a server require authentication, first create
/// an appropriate subclass of `soup.AuthDomain`, and then add it to the
/// server with `Server.addAuthDomain`.
///
/// In order for an auth domain to have any effect, you must add one or more
/// paths to it (via `AuthDomain.addPath`). To require authentication for
/// all ordinary requests, add the path `"/"`. (Note that this does not include
/// the special `"*"` URI (eg, "OPTIONS *"), which must be added as a separate
/// path if you want to cover it.)
///
/// If you need greater control over which requests should and shouldn't be
/// authenticated, add paths covering everything you *might* want authenticated,
/// and then use a filter (`AuthDomain.setFilter` to bypass
/// authentication for those requests that don't need it.
pub const AuthDomain = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = soup.AuthDomainClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const accepts = struct {
            pub fn call(p_class: anytype, p_domain: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage, p_header: [*:0]const u8) [*:0]u8 {
                return gobject.ext.as(AuthDomain.Class, p_class).f_accepts.?(gobject.ext.as(AuthDomain, p_domain), p_msg, p_header);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_domain: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage, p_header: [*:0]const u8) callconv(.c) [*:0]u8) void {
                gobject.ext.as(AuthDomain.Class, p_class).f_accepts = @ptrCast(p_implementation);
            }
        };

        /// Adds a "WWW-Authenticate" or "Proxy-Authenticate" header to `msg`.
        ///
        /// It requests that the client authenticate, and sets `msg`'s status accordingly.
        ///
        /// This is used by `Server` internally and is probably of no use to
        /// anyone else.
        pub const challenge = struct {
            pub fn call(p_class: anytype, p_domain: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) [*:0]u8 {
                return gobject.ext.as(AuthDomain.Class, p_class).f_challenge.?(gobject.ext.as(AuthDomain, p_domain), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_domain: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) callconv(.c) [*:0]u8) void {
                gobject.ext.as(AuthDomain.Class, p_class).f_challenge = @ptrCast(p_implementation);
            }
        };

        /// Checks if `msg` authenticates to `domain` via `username` and
        /// `password`.
        ///
        /// This would normally be called from a
        /// `AuthDomainGenericAuthCallback`.
        pub const check_password = struct {
            pub fn call(p_class: anytype, p_domain: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage, p_username: [*:0]const u8, p_password: [*:0]const u8) c_int {
                return gobject.ext.as(AuthDomain.Class, p_class).f_check_password.?(gobject.ext.as(AuthDomain, p_domain), p_msg, p_username, p_password);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_domain: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage, p_username: [*:0]const u8, p_password: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(AuthDomain.Class, p_class).f_check_password = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The `AuthDomainFilter` for the domain.
        pub const filter = struct {
            pub const name = "filter";

            pub const Type = ?*soup.AuthDomainFilter;
        };

        /// Data to pass to the `AuthDomainFilter`.
        pub const filter_data = struct {
            pub const name = "filter-data";

            pub const Type = ?*anyopaque;
        };

        /// The `AuthDomainGenericAuthCallback`.
        pub const generic_auth_callback = struct {
            pub const name = "generic-auth-callback";

            pub const Type = ?*soup.AuthDomainGenericAuthCallback;
        };

        /// The data to pass to the `AuthDomainGenericAuthCallback`.
        pub const generic_auth_data = struct {
            pub const name = "generic-auth-data";

            pub const Type = ?*anyopaque;
        };

        /// Whether or not this is a proxy auth domain.
        pub const proxy = struct {
            pub const name = "proxy";

            pub const Type = c_int;
        };

        /// The realm of this auth domain.
        pub const realm = struct {
            pub const name = "realm";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Checks if `msg` contains appropriate authorization for `domain` to
    /// accept it.
    ///
    /// Mirroring `AuthDomain.covers`, this does not check whether or not
    /// `domain` *cares* if `msg` is authorized.
    ///
    /// This is used by `Server` internally and is probably of no use to
    /// anyone else.
    extern fn soup_auth_domain_accepts(p_domain: *AuthDomain, p_msg: *soup.ServerMessage) ?[*:0]u8;
    pub const accepts = soup_auth_domain_accepts;

    /// Adds `path` to `domain`.
    ///
    /// Requests under `path` on `domain`'s server will require authentication (unless
    /// overridden by `AuthDomain.removePath` or
    /// `AuthDomain.setFilter`).
    extern fn soup_auth_domain_add_path(p_domain: *AuthDomain, p_path: [*:0]const u8) void;
    pub const addPath = soup_auth_domain_add_path;

    /// Adds a "WWW-Authenticate" or "Proxy-Authenticate" header to `msg`.
    ///
    /// It requests that the client authenticate, and sets `msg`'s status accordingly.
    ///
    /// This is used by `Server` internally and is probably of no use to
    /// anyone else.
    extern fn soup_auth_domain_challenge(p_domain: *AuthDomain, p_msg: *soup.ServerMessage) void;
    pub const challenge = soup_auth_domain_challenge;

    /// Checks if `msg` authenticates to `domain` via `username` and
    /// `password`.
    ///
    /// This would normally be called from a
    /// `AuthDomainGenericAuthCallback`.
    extern fn soup_auth_domain_check_password(p_domain: *AuthDomain, p_msg: *soup.ServerMessage, p_username: [*:0]const u8, p_password: [*:0]const u8) c_int;
    pub const checkPassword = soup_auth_domain_check_password;

    /// Checks if `domain` requires `msg` to be authenticated (according to
    /// its paths and filter function).
    ///
    /// This does not actually look at whether `msg` *is* authenticated, merely
    /// whether or not it needs to be.
    ///
    /// This is used by `Server` internally and is probably of no use to
    /// anyone else.
    extern fn soup_auth_domain_covers(p_domain: *AuthDomain, p_msg: *soup.ServerMessage) c_int;
    pub const covers = soup_auth_domain_covers;

    /// Gets the realm name associated with `domain`.
    extern fn soup_auth_domain_get_realm(p_domain: *AuthDomain) [*:0]const u8;
    pub const getRealm = soup_auth_domain_get_realm;

    /// Removes `path` from `domain`.
    ///
    /// Requests under `path` on `domain`'s server will NOT require
    /// authentication.
    ///
    /// This is not simply an undo-er for `AuthDomain.addPath`; it
    /// can be used to "carve out" a subtree that does not require
    /// authentication inside a hierarchy that does. Note also that unlike
    /// with `AuthDomain.addPath`, this cannot be overridden by
    /// adding a filter, as filters can only bypass authentication that
    /// would otherwise be required, not require it where it would
    /// otherwise be unnecessary.
    extern fn soup_auth_domain_remove_path(p_domain: *AuthDomain, p_path: [*:0]const u8) void;
    pub const removePath = soup_auth_domain_remove_path;

    /// Adds `filter` as an authentication filter to `domain`.
    ///
    /// The filter gets a chance to bypass authentication for certain requests that
    /// would otherwise require it. Eg, it might check the message's path in some way
    /// that is too complicated to do via the other methods, or it might check the
    /// message's method, and allow GETs but not PUTs.
    ///
    /// The filter function returns `TRUE` if the request should still
    /// require authentication, or `FALSE` if authentication is unnecessary
    /// for this request.
    ///
    /// To help prevent security holes, your filter should return `TRUE` by
    /// default, and only return `FALSE` under specifically-tested
    /// circumstances, rather than the other way around. Eg, in the example
    /// above, where you want to authenticate PUTs but not GETs, you should
    /// check if the method is GET and return `FALSE` in that case, and then
    /// return `TRUE` for all other methods (rather than returning `TRUE` for
    /// PUT and `FALSE` for all other methods). This way if it turned out
    /// (now or later) that some paths supported additional methods besides
    /// GET and PUT, those methods would default to being NOT allowed for
    /// unauthenticated users.
    ///
    /// You can also set the filter by setting the SoupAuthDomain:filter
    /// and `AuthDomain.properties.@"filter_data properties"`, which can also be
    /// used to set the filter at construct time.
    extern fn soup_auth_domain_set_filter(p_domain: *AuthDomain, p_filter: soup.AuthDomainFilter, p_filter_data: ?*anyopaque, p_dnotify: ?glib.DestroyNotify) void;
    pub const setFilter = soup_auth_domain_set_filter;

    /// Sets `auth_callback` as an authentication-handling callback for `domain`.
    ///
    /// Whenever a request comes in to `domain` which cannot be authenticated via a
    /// domain-specific auth callback (eg, `AuthDomainDigestAuthCallback`),
    /// the generic auth callback will be invoked. See
    /// `AuthDomainGenericAuthCallback` for information on what the callback
    /// should do.
    extern fn soup_auth_domain_set_generic_auth_callback(p_domain: *AuthDomain, p_auth_callback: soup.AuthDomainGenericAuthCallback, p_auth_data: ?*anyopaque, p_dnotify: ?glib.DestroyNotify) void;
    pub const setGenericAuthCallback = soup_auth_domain_set_generic_auth_callback;

    extern fn soup_auth_domain_get_type() usize;
    pub const getGObjectType = soup_auth_domain_get_type;

    extern fn g_object_ref(p_self: *soup.AuthDomain) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.AuthDomain) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthDomain, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Server-side "Basic" authentication.
///
/// `soup.AuthDomainBasic` handles the server side of HTTP "Basic" (ie,
/// cleartext password) authentication.
pub const AuthDomainBasic = opaque {
    pub const Parent = soup.AuthDomain;
    pub const Implements = [_]type{};
    pub const Class = soup.AuthDomainBasicClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `AuthDomainBasicAuthCallback`.
        pub const auth_callback = struct {
            pub const name = "auth-callback";

            pub const Type = ?*soup.AuthDomainBasicAuthCallback;
        };

        /// The data to pass to the `AuthDomainBasicAuthCallback`.
        pub const auth_data = struct {
            pub const name = "auth-data";

            pub const Type = ?*anyopaque;
        };
    };

    pub const signals = struct {};

    /// Creates a `soup.AuthDomainBasic`.
    ///
    /// You must set the `AuthDomain.properties.realm` property, to indicate the realm
    /// name to be returned with the authentication challenge to the client. Other
    /// parameters are optional.
    extern fn soup_auth_domain_basic_new(p_optname1: [*:0]const u8, ...) *soup.AuthDomainBasic;
    pub const new = soup_auth_domain_basic_new;

    /// Sets the callback that `domain` will use to authenticate incoming
    /// requests.
    ///
    /// For each request containing authorization, `domain` will invoke the callback,
    /// and then either accept or reject the request based on `callback`'s return
    /// value.
    ///
    /// You can also set the auth callback by setting the
    /// `AuthDomainBasic.properties.auth_callback` and
    /// `AuthDomainBasic.properties.auth_data` properties, which can also be used to
    /// set the callback at construct time.
    extern fn soup_auth_domain_basic_set_auth_callback(p_domain: *AuthDomainBasic, p_callback: soup.AuthDomainBasicAuthCallback, p_user_data: ?*anyopaque, p_dnotify: ?glib.DestroyNotify) void;
    pub const setAuthCallback = soup_auth_domain_basic_set_auth_callback;

    extern fn soup_auth_domain_basic_get_type() usize;
    pub const getGObjectType = soup_auth_domain_basic_get_type;

    extern fn g_object_ref(p_self: *soup.AuthDomainBasic) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.AuthDomainBasic) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthDomainBasic, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Server-side "Digest" authentication.
///
/// `soup.AuthDomainDigest` handles the server side of HTTP "Digest"
/// authentication.
pub const AuthDomainDigest = opaque {
    pub const Parent = soup.AuthDomain;
    pub const Implements = [_]type{};
    pub const Class = soup.AuthDomainDigestClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `AuthDomainDigestAuthCallback`.
        pub const auth_callback = struct {
            pub const name = "auth-callback";

            pub const Type = ?*soup.AuthDomainDigestAuthCallback;
        };

        /// The data to pass to the `AuthDomainDigestAuthCallback`.
        pub const auth_data = struct {
            pub const name = "auth-data";

            pub const Type = ?*anyopaque;
        };
    };

    pub const signals = struct {};

    /// Encodes the username/realm/password triplet for Digest
    /// authentication.
    ///
    /// That is, it returns a stringified MD5 hash of
    /// `username`, `realm`, and `password` concatenated together. This is
    /// the form that is needed as the return value of
    /// `soup.AuthDomainDigest`'s auth handler.
    ///
    /// For security reasons, you should store the encoded hash, rather
    /// than storing the cleartext password itself and calling this method
    /// only when you need to verify it. This way, if your server is
    /// compromised, the attackers will not gain access to cleartext
    /// passwords which might also be usable at other sites. (Note also
    /// that the encoded password returned by this method is identical to
    /// the encoded password stored in an Apache .htdigest file.)
    extern fn soup_auth_domain_digest_encode_password(p_username: [*:0]const u8, p_realm: [*:0]const u8, p_password: [*:0]const u8) [*:0]u8;
    pub const encodePassword = soup_auth_domain_digest_encode_password;

    /// Creates a `soup.AuthDomainDigest`.
    ///
    /// You must set the `AuthDomain.properties.realm` property, to indicate the realm name to
    /// be returned with the authentication challenge to the client. Other parameters
    /// are optional.
    extern fn soup_auth_domain_digest_new(p_optname1: [*:0]const u8, ...) *soup.AuthDomainDigest;
    pub const new = soup_auth_domain_digest_new;

    /// Sets the callback that `domain` will use to authenticate incoming
    /// requests.
    ///
    /// For each request containing authorization, `domain` will
    /// invoke the callback, and then either accept or reject the request
    /// based on `callback`'s return value.
    ///
    /// You can also set the auth callback by setting the
    /// `AuthDomainDigest.properties.auth_callback` and
    /// `AuthDomainDigest.properties.auth_data` properties, which can also be used to
    /// set the callback at construct time.
    extern fn soup_auth_domain_digest_set_auth_callback(p_domain: *AuthDomainDigest, p_callback: soup.AuthDomainDigestAuthCallback, p_user_data: ?*anyopaque, p_dnotify: ?glib.DestroyNotify) void;
    pub const setAuthCallback = soup_auth_domain_digest_set_auth_callback;

    extern fn soup_auth_domain_digest_get_type() usize;
    pub const getGObjectType = soup_auth_domain_digest_get_type;

    extern fn g_object_ref(p_self: *soup.AuthDomainDigest) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.AuthDomainDigest) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthDomainDigest, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// HTTP client-side authentication handler.
///
/// `soup.AuthManager` is the `SessionFeature` that handles HTTP
/// authentication for a `Session`.
///
/// A `soup.AuthManager` is added to the session by default, and normally
/// you don't need to worry about it at all. However, if you want to
/// disable HTTP authentication, you can remove the feature from the
/// session with `Session.removeFeatureByType` or disable it on
/// individual requests with `Message.disableFeature`.
///
/// You can use this with `Session.removeFeatureByType` or
/// `Message.disableFeature`.
///
/// (Although this type has only been publicly visible since libsoup 2.42, it has
/// always existed in the background, and you can use `g_type_from_name
/// ("SoupAuthManager")` to get its `gobject.Type` in earlier releases.)
pub const AuthManager = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.AuthManagerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Clear all credentials cached by `manager`.
    extern fn soup_auth_manager_clear_cached_credentials(p_manager: *AuthManager) void;
    pub const clearCachedCredentials = soup_auth_manager_clear_cached_credentials;

    /// Records that `auth` is to be used under `uri`, as though a
    /// WWW-Authenticate header had been received at that URI.
    ///
    /// This can be used to "preload" `manager`'s auth cache, to avoid an extra HTTP
    /// round trip in the case where you know ahead of time that a 401 response will
    /// be returned.
    ///
    /// This is only useful for authentication types where the initial
    /// Authorization header does not depend on any additional information
    /// from the server. (Eg, Basic or NTLM, but not Digest.)
    extern fn soup_auth_manager_use_auth(p_manager: *AuthManager, p_uri: *glib.Uri, p_auth: *soup.Auth) void;
    pub const useAuth = soup_auth_manager_use_auth;

    extern fn soup_auth_manager_get_type() usize;
    pub const getGObjectType = soup_auth_manager_get_type;

    extern fn g_object_ref(p_self: *soup.AuthManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.AuthManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// HTTP-based NTLM authentication.
///
/// `Session`s do not support this type by default; if you want to
/// enable support for it, call `Session.addFeatureByType`,
/// passing `SOUP_TYPE_AUTH_NTLM`.
pub const AuthNTLM = opaque {
    pub const Parent = soup.Auth;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = AuthNTLM;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn soup_auth_ntlm_get_type() usize;
    pub const getGObjectType = soup_auth_ntlm_get_type;

    extern fn g_object_ref(p_self: *soup.AuthNTLM) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.AuthNTLM) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthNTLM, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// HTTP-based GSS-Negotiate authentication, as defined by
/// [RFC 4559](https://datatracker.ietf.org/doc/html/rfc4559).
///
/// `Session`s do not support this type by default; if you want to
/// enable support for it, call `Session.addFeatureByType`,
/// passing `SOUP_TYPE_AUTH_NEGOTIATE`.
///
/// This auth type will only work if libsoup was compiled with GSSAPI
/// support; you can check `AuthNegotiate.supported` to see if it
/// was.
pub const AuthNegotiate = opaque {
    pub const Parent = soup.Auth;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = AuthNegotiate;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Indicates whether libsoup was built with GSSAPI support.
    ///
    /// If this is `FALSE`, `SOUP_TYPE_AUTH_NEGOTIATE` will still be defined and can
    /// still be added to a `Session`, but libsoup will never attempt to
    /// actually use this auth type.
    extern fn soup_auth_negotiate_supported() c_int;
    pub const supported = soup_auth_negotiate_supported;

    extern fn soup_auth_negotiate_get_type() usize;
    pub const getGObjectType = soup_auth_negotiate_get_type;

    extern fn g_object_ref(p_self: *soup.AuthNegotiate) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.AuthNegotiate) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthNegotiate, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// File-based cache for HTTP resources.
pub const Cache = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.CacheClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const get_cacheability = struct {
            pub fn call(p_class: anytype, p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) soup.Cacheability {
                return gobject.ext.as(Cache.Class, p_class).f_get_cacheability.?(gobject.ext.as(Cache, p_cache), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cache: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) callconv(.c) soup.Cacheability) void {
                gobject.ext.as(Cache.Class, p_class).f_get_cacheability = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The directory to store the cache files.
        pub const cache_dir = struct {
            pub const name = "cache-dir";

            pub const Type = ?[*:0]u8;
        };

        /// Whether the cache is private or shared.
        pub const cache_type = struct {
            pub const name = "cache-type";

            pub const Type = soup.CacheType;
        };
    };

    pub const signals = struct {};

    /// Creates a new `soup.Cache`.
    extern fn soup_cache_new(p_cache_dir: ?[*:0]const u8, p_cache_type: soup.CacheType) *soup.Cache;
    pub const new = soup_cache_new;

    /// Will remove all entries in the `cache` plus all the cache files.
    ///
    /// This is not thread safe and must be called only from the thread that created the `soup.Cache`
    extern fn soup_cache_clear(p_cache: *Cache) void;
    pub const clear = soup_cache_clear;

    /// Synchronously writes the cache index out to disk.
    ///
    /// Contrast with `Cache.flush`, which writes pending cache *entries* to
    /// disk.
    ///
    /// You must call this before exiting if you want your cache data to
    /// persist between sessions.
    ///
    /// This is not thread safe and must be called only from the thread that created the `soup.Cache`
    extern fn soup_cache_dump(p_cache: *Cache) void;
    pub const dump = soup_cache_dump;

    /// Forces all pending writes in the `cache` to be
    /// committed to disk.
    ///
    /// For doing so it will iterate the `glib.MainContext` associated with
    /// `cache`'s session as long as needed.
    ///
    /// Contrast with `Cache.dump`, which writes out the cache index file.
    extern fn soup_cache_flush(p_cache: *Cache) void;
    pub const flush = soup_cache_flush;

    /// Gets the maximum size of the cache.
    extern fn soup_cache_get_max_size(p_cache: *Cache) c_uint;
    pub const getMaxSize = soup_cache_get_max_size;

    /// Loads the contents of `cache`'s index into memory.
    ///
    /// This is not thread safe and must be called only from the thread that created the `soup.Cache`
    extern fn soup_cache_load(p_cache: *Cache) void;
    pub const load = soup_cache_load;

    /// Sets the maximum size of the cache.
    extern fn soup_cache_set_max_size(p_cache: *Cache, p_max_size: c_uint) void;
    pub const setMaxSize = soup_cache_set_max_size;

    extern fn soup_cache_get_type() usize;
    pub const getGObjectType = soup_cache_get_type;

    extern fn g_object_ref(p_self: *soup.Cache) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.Cache) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Cache, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Handles decoding of HTTP messages.
///
/// `soup.ContentDecoder` handles adding the "Accept-Encoding" header on
/// outgoing messages, and processing the "Content-Encoding" header on
/// incoming ones. Currently it supports the "gzip", "deflate", and "br"
/// content codings.
///
/// A `soup.ContentDecoder` will automatically be
/// added to the session by default. (You can use
/// `Session.removeFeatureByType` if you don't
/// want this.)
///
/// If `soup.ContentDecoder` successfully decodes the Content-Encoding,
/// the message body will contain the decoded data; however, the message headers
/// will be unchanged (and so "Content-Encoding" will still be present,
/// "Content-Length" will describe the original encoded length, etc).
///
/// If "Content-Encoding" contains any encoding types that
/// `soup.ContentDecoder` doesn't recognize, then none of the encodings
/// will be decoded.
///
/// (Note that currently there is no way to (automatically) use
/// Content-Encoding when sending a request body, or to pick specific
/// encoding types to support.)
pub const ContentDecoder = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.ContentDecoderClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn soup_content_decoder_get_type() usize;
    pub const getGObjectType = soup_content_decoder_get_type;

    extern fn g_object_ref(p_self: *soup.ContentDecoder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.ContentDecoder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ContentDecoder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Sniffs the mime type of messages.
///
/// A `soup.ContentSniffer` tries to detect the actual content type of
/// the files that are being downloaded by looking at some of the data
/// before the `Message` emits its `Message.signals.got_headers` signal.
/// `soup.ContentSniffer` implements `SessionFeature`, so you can add
/// content sniffing to a session with `Session.addFeature` or
/// `Session.addFeatureByType`.
pub const ContentSniffer = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.ContentSnifferClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `soup.ContentSniffer`.
    extern fn soup_content_sniffer_new() *soup.ContentSniffer;
    pub const new = soup_content_sniffer_new;

    /// Sniffs `buffer` to determine its Content-Type.
    ///
    /// The result may also be influenced by the Content-Type declared in `msg`'s
    /// response headers.
    extern fn soup_content_sniffer_sniff(p_sniffer: *ContentSniffer, p_msg: *soup.Message, p_buffer: *glib.Bytes, p_params: ?**glib.HashTable) [*:0]u8;
    pub const sniff = soup_content_sniffer_sniff;

    extern fn soup_content_sniffer_get_type() usize;
    pub const getGObjectType = soup_content_sniffer_get_type;

    extern fn g_object_ref(p_self: *soup.ContentSniffer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.ContentSniffer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ContentSniffer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Automatic cookie handling for SoupSession.
///
/// A `soup.CookieJar` stores `Cookie`s and arrange for them to be sent with
/// the appropriate `Message`s. `soup.CookieJar` implements
/// `SessionFeature`, so you can add a cookie jar to a session with
/// `Session.addFeature` or `Session.addFeatureByType`.
///
/// Note that the base `soup.CookieJar` class does not support any form
/// of long-term cookie persistence.
pub const CookieJar = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.CookieJarClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const changed = struct {
            pub fn call(p_class: anytype, p_jar: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_cookie: *soup.Cookie, p_new_cookie: *soup.Cookie) void {
                return gobject.ext.as(CookieJar.Class, p_class).f_changed.?(gobject.ext.as(CookieJar, p_jar), p_old_cookie, p_new_cookie);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_jar: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_cookie: *soup.Cookie, p_new_cookie: *soup.Cookie) callconv(.c) void) void {
                gobject.ext.as(CookieJar.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };

        /// Gets whether `jar` stores cookies persistenly.
        pub const is_persistent = struct {
            pub fn call(p_class: anytype, p_jar: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(CookieJar.Class, p_class).f_is_persistent.?(gobject.ext.as(CookieJar, p_jar));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_jar: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(CookieJar.Class, p_class).f_is_persistent = @ptrCast(p_implementation);
            }
        };

        pub const save = struct {
            pub fn call(p_class: anytype, p_jar: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(CookieJar.Class, p_class).f_save.?(gobject.ext.as(CookieJar, p_jar));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_jar: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(CookieJar.Class, p_class).f_save = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The policy the jar should follow to accept or reject cookies.
        pub const accept_policy = struct {
            pub const name = "accept-policy";

            pub const Type = soup.CookieJarAcceptPolicy;
        };

        /// Whether or not the cookie jar is read-only.
        pub const read_only = struct {
            pub const name = "read-only";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted when `jar` changes.
        ///
        /// If a cookie has been added,
        /// `new_cookie` will contain the newly-added cookie and
        /// `old_cookie` will be `NULL`. If a cookie has been deleted,
        /// `old_cookie` will contain the to-be-deleted cookie and
        /// `new_cookie` will be `NULL`. If a cookie has been changed,
        /// `old_cookie` will contain its old value, and `new_cookie` its
        /// new value.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_old_cookie: ?*soup.Cookie, p_new_cookie: ?*soup.Cookie, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CookieJar, p_instance))),
                    gobject.signalLookup("changed", CookieJar.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `soup.CookieJar`.
    ///
    /// The base `soup.CookieJar` class does not support persistent storage of cookies;
    /// use a subclass for that.
    extern fn soup_cookie_jar_new() *soup.CookieJar;
    pub const new = soup_cookie_jar_new;

    /// Adds `cookie` to `jar`.
    ///
    /// Emits the `CookieJar.signals.changed` signal if we are modifying
    /// an existing cookie or adding a valid new cookie ('valid' means
    /// that the cookie's expire date is not in the past).
    ///
    /// `cookie` will be 'stolen' by the jar, so don't free it afterwards.
    extern fn soup_cookie_jar_add_cookie(p_jar: *CookieJar, p_cookie: *soup.Cookie) void;
    pub const addCookie = soup_cookie_jar_add_cookie;

    /// Adds `cookie` to `jar`.
    ///
    /// Emits the `CookieJar.signals.changed` signal if we are modifying an existing
    /// cookie or adding a valid new cookie ('valid' means that the cookie's expire
    /// date is not in the past).
    ///
    /// `first_party` will be used to reject cookies coming from third party
    /// resources in case such a security policy is set in the `jar`.
    ///
    /// `uri` will be used to reject setting or overwriting secure cookies
    /// from insecure origins. `NULL` is treated as secure.
    ///
    /// `cookie` will be 'stolen' by the jar, so don't free it afterwards.
    extern fn soup_cookie_jar_add_cookie_full(p_jar: *CookieJar, p_cookie: *soup.Cookie, p_uri: ?*glib.Uri, p_first_party: ?*glib.Uri) void;
    pub const addCookieFull = soup_cookie_jar_add_cookie_full;

    /// Adds `cookie` to `jar`.
    ///
    /// Emits the `CookieJar.signals.changed` signal if we are modifying
    /// an existing cookie or adding a valid new cookie ('valid' means
    /// that the cookie's expire date is not in the past).
    ///
    /// `first_party` will be used to reject cookies coming from third party
    /// resources in case such a security policy is set in the `jar`.
    ///
    /// `cookie` will be 'stolen' by the jar, so don't free it afterwards.
    ///
    /// For secure cookies to work properly you may want to use
    /// `CookieJar.addCookieFull`.
    extern fn soup_cookie_jar_add_cookie_with_first_party(p_jar: *CookieJar, p_first_party: *glib.Uri, p_cookie: *soup.Cookie) void;
    pub const addCookieWithFirstParty = soup_cookie_jar_add_cookie_with_first_party;

    /// Constructs a `glib.List` with every cookie inside the `jar`.
    ///
    /// The cookies in the list are a copy of the original, so
    /// you have to free them when you are done with them.
    ///
    /// For historical reasons this list is in reverse order.
    extern fn soup_cookie_jar_all_cookies(p_jar: *CookieJar) *glib.SList;
    pub const allCookies = soup_cookie_jar_all_cookies;

    /// Deletes `cookie` from `jar`.
    ///
    /// Emits the `CookieJar.signals.changed` signal.
    extern fn soup_cookie_jar_delete_cookie(p_jar: *CookieJar, p_cookie: *soup.Cookie) void;
    pub const deleteCookie = soup_cookie_jar_delete_cookie;

    /// Gets `jar`'s `CookieJarAcceptPolicy`.
    extern fn soup_cookie_jar_get_accept_policy(p_jar: *CookieJar) soup.CookieJarAcceptPolicy;
    pub const getAcceptPolicy = soup_cookie_jar_get_accept_policy;

    /// Retrieves the list of cookies that would be sent with a request to `uri`
    /// as a `glib.List` of `soup.Cookie` objects.
    ///
    /// If `for_http` is `TRUE`, the return value will include cookies marked
    /// "HttpOnly" (that is, cookies that the server wishes to keep hidden
    /// from client-side scripting operations such as the JavaScript
    /// document.cookies property). Since `soup.CookieJar` sets the Cookie
    /// header itself when making the actual HTTP request, you should
    /// almost certainly be setting `for_http` to `FALSE` if you are calling
    /// this.
    extern fn soup_cookie_jar_get_cookie_list(p_jar: *CookieJar, p_uri: *glib.Uri, p_for_http: c_int) *glib.SList;
    pub const getCookieList = soup_cookie_jar_get_cookie_list;

    /// This is an extended version of `CookieJar.getCookieList` that
    /// provides more information required to use SameSite cookies.
    ///
    /// See the [SameSite cookies
    /// spec](https://tools.ietf.org/html/draft-ietf-httpbis-cookie-same-site-00) for
    /// more detailed information.
    extern fn soup_cookie_jar_get_cookie_list_with_same_site_info(p_jar: *CookieJar, p_uri: *glib.Uri, p_top_level: ?*glib.Uri, p_site_for_cookies: ?*glib.Uri, p_for_http: c_int, p_is_safe_method: c_int, p_is_top_level_navigation: c_int) *glib.SList;
    pub const getCookieListWithSameSiteInfo = soup_cookie_jar_get_cookie_list_with_same_site_info;

    /// Retrieves (in Cookie-header form) the list of cookies that would
    /// be sent with a request to `uri`.
    ///
    /// If `for_http` is `TRUE`, the return value will include cookies marked
    /// "HttpOnly" (that is, cookies that the server wishes to keep hidden
    /// from client-side scripting operations such as the JavaScript
    /// document.cookies property). Since `soup.CookieJar` sets the Cookie
    /// header itself when making the actual HTTP request, you should
    /// almost certainly be setting `for_http` to `FALSE` if you are calling
    /// this.
    extern fn soup_cookie_jar_get_cookies(p_jar: *CookieJar, p_uri: *glib.Uri, p_for_http: c_int) ?[*:0]u8;
    pub const getCookies = soup_cookie_jar_get_cookies;

    /// Gets whether `jar` stores cookies persistenly.
    extern fn soup_cookie_jar_is_persistent(p_jar: *CookieJar) c_int;
    pub const isPersistent = soup_cookie_jar_is_persistent;

    /// Sets `policy` as the cookie acceptance policy for `jar`.
    extern fn soup_cookie_jar_set_accept_policy(p_jar: *CookieJar, p_policy: soup.CookieJarAcceptPolicy) void;
    pub const setAcceptPolicy = soup_cookie_jar_set_accept_policy;

    /// Adds `cookie` to `jar`, exactly as though it had appeared in a
    /// Set-Cookie header returned from a request to `uri`.
    ///
    /// Keep in mind that if the `CookieJarAcceptPolicy` set is either
    /// `SOUP_COOKIE_JAR_ACCEPT_NO_THIRD_PARTY` or
    /// `SOUP_COOKIE_JAR_ACCEPT_GRANDFATHERED_THIRD_PARTY` you'll need to use
    /// `CookieJar.setCookieWithFirstParty`, otherwise the jar
    /// will have no way of knowing if the cookie is being set by a third
    /// party or not.
    extern fn soup_cookie_jar_set_cookie(p_jar: *CookieJar, p_uri: *glib.Uri, p_cookie: [*:0]const u8) void;
    pub const setCookie = soup_cookie_jar_set_cookie;

    /// Adds `cookie` to `jar`, exactly as though it had appeared in a
    /// Set-Cookie header returned from a request to `uri`.
    ///
    /// `first_party` will be used to reject cookies coming from third party resources
    /// in case such a security policy is set in the `jar`.
    extern fn soup_cookie_jar_set_cookie_with_first_party(p_jar: *CookieJar, p_uri: *glib.Uri, p_first_party: *glib.Uri, p_cookie: [*:0]const u8) void;
    pub const setCookieWithFirstParty = soup_cookie_jar_set_cookie_with_first_party;

    extern fn soup_cookie_jar_get_type() usize;
    pub const getGObjectType = soup_cookie_jar_get_type;

    extern fn g_object_ref(p_self: *soup.CookieJar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.CookieJar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CookieJar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Database-based Cookie Jar.
///
/// `soup.CookieJarDB` is a `CookieJar` that reads cookies from and writes
/// them to a sqlite database in the new Mozilla format.
///
/// (This is identical to `SoupCookieJarSqlite` in
/// libsoup-gnome; it has just been moved into libsoup proper, and
/// renamed to avoid conflicting.)
pub const CookieJarDB = opaque {
    pub const Parent = soup.CookieJar;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.CookieJarDBClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Cookie-storage filename.
        pub const filename = struct {
            pub const name = "filename";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a `soup.CookieJarDB`.
    ///
    /// `filename` will be read in at startup to create an initial set of cookies. If
    /// `read_only` is `FALSE`, then the non-session cookies will be written to
    /// `filename` when the `CookieJar.signals.changed` signal is emitted from the
    /// jar. (If `read_only` is `TRUE`, then the cookie jar will only be used for this
    /// session, and changes made to it will be lost when the jar is destroyed.)
    extern fn soup_cookie_jar_db_new(p_filename: [*:0]const u8, p_read_only: c_int) *soup.CookieJarDB;
    pub const new = soup_cookie_jar_db_new;

    extern fn soup_cookie_jar_db_get_type() usize;
    pub const getGObjectType = soup_cookie_jar_db_get_type;

    extern fn g_object_ref(p_self: *soup.CookieJarDB) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.CookieJarDB) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CookieJarDB, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Text-file-based ("cookies.txt") Cookie Jar
///
/// `soup.CookieJarText` is a `CookieJar` that reads cookies from and writes
/// them to a text file in format similar to Mozilla's "cookies.txt".
pub const CookieJarText = opaque {
    pub const Parent = soup.CookieJar;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.CookieJarTextClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Cookie-storage filename.
        pub const filename = struct {
            pub const name = "filename";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a `soup.CookieJarText`.
    ///
    /// `filename` will be read in at startup to create an initial set of cookies. If
    /// `read_only` is `FALSE`, then the non-session cookies will be written to
    /// `filename` when the `CookieJar.signals.changed` signal is emitted from the
    /// jar. (If `read_only` is `TRUE`, then the cookie jar will only be used for this
    /// session, and changes made to it will be lost when the jar is destroyed.)
    extern fn soup_cookie_jar_text_new(p_filename: [*:0]const u8, p_read_only: c_int) *soup.CookieJarText;
    pub const new = soup_cookie_jar_text_new;

    extern fn soup_cookie_jar_text_get_type() usize;
    pub const getGObjectType = soup_cookie_jar_text_get_type;

    extern fn g_object_ref(p_self: *soup.CookieJarText) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.CookieJarText) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CookieJarText, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Automatic HTTP Strict Transport Security enforcing for `Session`.
///
/// A `soup.HSTSEnforcer` stores HSTS policies and enforces them when
/// required. `soup.HSTSEnforcer` implements `SessionFeature`, so you
/// can add an HSTS enforcer to a session with
/// `Session.addFeature` or `Session.addFeatureByType`.
///
/// `soup.HSTSEnforcer` keeps track of all the HTTPS destinations that,
/// when connected to, return the Strict-Transport-Security header with
/// valid values. `soup.HSTSEnforcer` will forget those destinations
/// upon expiry or when the server requests it.
///
/// When the `Session` the `soup.HSTSEnforcer` is attached to queues or
/// restarts a message, the `soup.HSTSEnforcer` will rewrite the URI to HTTPS if
/// the destination is a known HSTS host and is contacted over an insecure
/// transport protocol (HTTP). Users of `soup.HSTSEnforcer` are advised to listen
/// to changes in the `Message.properties.uri` property in order to be aware of
/// changes in the message URI.
///
/// Note that `soup.HSTSEnforcer` does not support any form of long-term
/// HSTS policy persistence. See `HSTSEnforcerDB` for a persistent
/// enforcer.
pub const HSTSEnforcer = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.HSTSEnforcerClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// The class closure for the `soup.HSTSEnforcer.signals.changed` signal.
        pub const changed = struct {
            pub fn call(p_class: anytype, p_enforcer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_policy: *soup.HSTSPolicy, p_new_policy: *soup.HSTSPolicy) void {
                return gobject.ext.as(HSTSEnforcer.Class, p_class).f_changed.?(gobject.ext.as(HSTSEnforcer, p_enforcer), p_old_policy, p_new_policy);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_enforcer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_old_policy: *soup.HSTSPolicy, p_new_policy: *soup.HSTSPolicy) callconv(.c) void) void {
                gobject.ext.as(HSTSEnforcer.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };

        /// Gets whether `hsts_enforcer` has a currently valid policy for `domain`.
        pub const has_valid_policy = struct {
            pub fn call(p_class: anytype, p_hsts_enforcer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_domain: [*:0]const u8) c_int {
                return gobject.ext.as(HSTSEnforcer.Class, p_class).f_has_valid_policy.?(gobject.ext.as(HSTSEnforcer, p_hsts_enforcer), p_domain);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_hsts_enforcer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_domain: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(HSTSEnforcer.Class, p_class).f_has_valid_policy = @ptrCast(p_implementation);
            }
        };

        /// Gets whether `hsts_enforcer` stores policies persistenly.
        pub const is_persistent = struct {
            pub fn call(p_class: anytype, p_hsts_enforcer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(HSTSEnforcer.Class, p_class).f_is_persistent.?(gobject.ext.as(HSTSEnforcer, p_hsts_enforcer));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_hsts_enforcer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(HSTSEnforcer.Class, p_class).f_is_persistent = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when `hsts_enforcer` changes.
        ///
        /// If a policy has been added,
        /// `new_policy` will contain the newly-added policy and
        /// `old_policy` will be `NULL`. If a policy has been deleted,
        /// `old_policy` will contain the to-be-deleted policy and
        /// `new_policy` will be `NULL`. If a policy has been changed,
        /// `old_policy` will contain its old value, and `new_policy` its
        /// new value.
        ///
        /// Note that you shouldn't modify the policies from a callback to
        /// this signal.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_old_policy: *soup.HSTSPolicy, p_new_policy: *soup.HSTSPolicy, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(HSTSEnforcer, p_instance))),
                    gobject.signalLookup("changed", HSTSEnforcer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `soup.HSTSEnforcer`.
    ///
    /// The base `soup.HSTSEnforcer` class does not support persistent storage of HSTS
    /// policies, see `HSTSEnforcerDB` for that.
    extern fn soup_hsts_enforcer_new() *soup.HSTSEnforcer;
    pub const new = soup_hsts_enforcer_new;

    /// Gets a list of domains for which there are policies in `enforcer`.
    extern fn soup_hsts_enforcer_get_domains(p_hsts_enforcer: *HSTSEnforcer, p_session_policies: c_int) *glib.List;
    pub const getDomains = soup_hsts_enforcer_get_domains;

    /// Gets a list with the policies in `enforcer`.
    extern fn soup_hsts_enforcer_get_policies(p_hsts_enforcer: *HSTSEnforcer, p_session_policies: c_int) *glib.List;
    pub const getPolicies = soup_hsts_enforcer_get_policies;

    /// Gets whether `hsts_enforcer` has a currently valid policy for `domain`.
    extern fn soup_hsts_enforcer_has_valid_policy(p_hsts_enforcer: *HSTSEnforcer, p_domain: [*:0]const u8) c_int;
    pub const hasValidPolicy = soup_hsts_enforcer_has_valid_policy;

    /// Gets whether `hsts_enforcer` stores policies persistenly.
    extern fn soup_hsts_enforcer_is_persistent(p_hsts_enforcer: *HSTSEnforcer) c_int;
    pub const isPersistent = soup_hsts_enforcer_is_persistent;

    /// Sets `policy` to `hsts_enforcer`.
    ///
    /// If `policy` is expired, any existing HSTS policy for its host will be removed
    /// instead. If a policy existed for this host, it will be replaced. Otherwise,
    /// the new policy will be inserted. If the policy is a session policy, that is,
    /// one created with `HSTSPolicy.newSessionPolicy`, the policy will not
    /// expire and will be enforced during the lifetime of `hsts_enforcer`'s
    /// `Session`.
    extern fn soup_hsts_enforcer_set_policy(p_hsts_enforcer: *HSTSEnforcer, p_policy: *soup.HSTSPolicy) void;
    pub const setPolicy = soup_hsts_enforcer_set_policy;

    /// Sets a session policy for `domain`.
    ///
    /// A session policy is a policy that is permanent to the lifetime of
    /// `hsts_enforcer`'s `Session` and doesn't expire.
    extern fn soup_hsts_enforcer_set_session_policy(p_hsts_enforcer: *HSTSEnforcer, p_domain: [*:0]const u8, p_include_subdomains: c_int) void;
    pub const setSessionPolicy = soup_hsts_enforcer_set_session_policy;

    extern fn soup_hsts_enforcer_get_type() usize;
    pub const getGObjectType = soup_hsts_enforcer_get_type;

    extern fn g_object_ref(p_self: *soup.HSTSEnforcer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.HSTSEnforcer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *HSTSEnforcer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Persistent HTTP Strict Transport Security enforcer.
///
/// `soup.HSTSEnforcerDB` is a `HSTSEnforcer` that uses a SQLite
/// database as a backend for persistency.
pub const HSTSEnforcerDB = opaque {
    pub const Parent = soup.HSTSEnforcer;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.HSTSEnforcerDBClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The filename of the SQLite database where HSTS policies are stored.
        pub const filename = struct {
            pub const name = "filename";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a `soup.HSTSEnforcerDB`.
    ///
    /// `filename` will be read in during the initialization of a
    /// `soup.HSTSEnforcerDB`, in order to create an initial set of HSTS
    /// policies. If the file doesn't exist, a new database will be created
    /// and initialized. Changes to the policies during the lifetime of a
    /// `soup.HSTSEnforcerDB` will be written to `filename` when
    /// `HSTSEnforcer.signals.changed` is emitted.
    extern fn soup_hsts_enforcer_db_new(p_filename: [*:0]const u8) *soup.HSTSEnforcerDB;
    pub const new = soup_hsts_enforcer_db_new;

    extern fn soup_hsts_enforcer_db_get_type() usize;
    pub const getGObjectType = soup_hsts_enforcer_db_get_type;

    extern fn g_object_ref(p_self: *soup.HSTSEnforcerDB) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.HSTSEnforcerDB) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *HSTSEnforcerDB, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Debug logging support
///
/// `soup.Logger` watches a `Session` and logs the HTTP traffic that
/// it generates, for debugging purposes. Many applications use an
/// environment variable to determine whether or not to use
/// `soup.Logger`, and to determine the amount of debugging output.
///
/// To use `soup.Logger`, first create a logger with `Logger.new`, optionally
/// configure it with `Logger.setRequestFilter`,
/// `Logger.setResponseFilter`, and `Logger.setPrinter`, and
/// then attach it to a session (or multiple sessions) with
/// `Session.addFeature`.
///
/// By default, the debugging output is sent to `stdout`, and looks something
/// like:
///
/// ```
/// > POST /unauth HTTP/1.1
/// > Soup-Debug-Timestamp: 1200171744
/// > Soup-Debug: SoupSession 1 (0x612190), SoupMessage 1 (0x617000), GSocket 1 (0x612220)
/// > Host: localhost
/// > Content-Type: text/plain
/// > Connection: close
///
/// &lt; HTTP/1.1 201 Created
/// &lt; Soup-Debug-Timestamp: 1200171744
/// &lt; Soup-Debug: SoupMessage 1 (0x617000)
/// &lt; Date: Sun, 12 Jan 2008 21:02:24 GMT
/// &lt; Content-Length: 0
/// ```
///
/// The `Soup-Debug-Timestamp` line gives the time (as a `time_t`) when the
/// request was sent, or the response fully received.
///
/// The `Soup-Debug` line gives further debugging information about the
/// `Session`, `Message`, and `gio.Socket` involved; the hex
/// numbers are the addresses of the objects in question (which may be useful if
/// you are running in a debugger). The decimal IDs are simply counters that
/// uniquely identify objects across the lifetime of the `soup.Logger`. In
/// particular, this can be used to identify when multiple messages are sent
/// across the same connection.
///
/// Currently, the request half of the message is logged just before
/// the first byte of the request gets written to the network (from the
/// `Message.signals.starting` signal).
///
/// The response is logged just after the last byte of the response body is read
/// from the network (from the `Message.signals.got_body` or
/// `Message.signals.got_informational` signal), which means that the
/// `Message.signals.got_headers` signal, and anything triggered off it (such as
/// `soup.Message.signals.authenticate`) will be emitted *before* the response headers are
/// actually logged.
///
/// If the response doesn't happen to trigger the `Message.signals.got_body` nor
/// `Message.signals.got_informational` signals due to, for example, a
/// cancellation before receiving the last byte of the response body, the
/// response will still be logged on the event of the `Message.signals.finished`
/// signal.
pub const Logger = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.LoggerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The level of logging output.
        pub const level = struct {
            pub const name = "level";

            pub const Type = soup.LoggerLogLevel;
        };

        /// If `Logger.properties.level` is `SOUP_LOGGER_LOG_BODY`, this gives
        /// the maximum number of bytes of the body that will be logged.
        /// (-1 means "no limit".)
        pub const max_body_size = struct {
            pub const name = "max-body-size";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `soup.Logger` with the given debug level.
    ///
    /// If you need finer control over what message parts are and aren't
    /// logged, use `Logger.setRequestFilter` and
    /// `Logger.setResponseFilter`.
    extern fn soup_logger_new(p_level: soup.LoggerLogLevel) *soup.Logger;
    pub const new = soup_logger_new;

    /// Get the maximum body size for `logger`.
    extern fn soup_logger_get_max_body_size(p_logger: *Logger) c_int;
    pub const getMaxBodySize = soup_logger_get_max_body_size;

    /// Sets the maximum body size for `logger` (-1 means no limit).
    extern fn soup_logger_set_max_body_size(p_logger: *Logger, p_max_body_size: c_int) void;
    pub const setMaxBodySize = soup_logger_set_max_body_size;

    /// Sets up an alternate log printing routine, if you don't want
    /// the log to go to `stdout`.
    extern fn soup_logger_set_printer(p_logger: *Logger, p_printer: soup.LoggerPrinter, p_printer_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const setPrinter = soup_logger_set_printer;

    /// Sets up a filter to determine the log level for a given request.
    ///
    /// For each HTTP request `logger` will invoke `request_filter` to
    /// determine how much (if any) of that request to log. (If you do not
    /// set a request filter, `logger` will just always log requests at the
    /// level passed to `Logger.new`.)
    extern fn soup_logger_set_request_filter(p_logger: *Logger, p_request_filter: soup.LoggerFilter, p_filter_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const setRequestFilter = soup_logger_set_request_filter;

    /// Sets up a filter to determine the log level for a given response.
    ///
    /// For each HTTP response `logger` will invoke `response_filter` to
    /// determine how much (if any) of that response to log. (If you do not
    /// set a response filter, `logger` will just always log responses at
    /// the level passed to `Logger.new`.)
    extern fn soup_logger_set_response_filter(p_logger: *Logger, p_response_filter: soup.LoggerFilter, p_filter_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const setResponseFilter = soup_logger_set_response_filter;

    extern fn soup_logger_get_type() usize;
    pub const getGObjectType = soup_logger_get_type;

    extern fn g_object_ref(p_self: *soup.Logger) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.Logger) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Logger, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents an HTTP message being sent or received.
///
/// A `soup.Message` represents an HTTP message that is being sent or
/// received.
///
/// You would create a `soup.Message` with `Message.new` or
/// `Message.newFromUri`, set up its fields appropriately, and send it.
///
/// `Message.properties.status_code` will normally be a `Status` value, eg,
/// `SOUP_STATUS_OK`, though of course it might actually be an unknown status
/// code. `Message.properties.reason_phrase` is the actual text returned from the
/// server, which may or may not correspond to the "standard" description of
/// `status_code`. At any rate, it is almost certainly not localized, and not very
/// descriptive even if it is in the user's language; you should not use
/// `Message.properties.reason_phrase` in user-visible messages. Rather, you should
/// look at `Message.properties.status_code`, and determine an end-user-appropriate
/// message based on that and on what you were trying to do.
///
/// Note that libsoup's terminology here does not quite match the HTTP
/// specification: in RFC 2616, an "HTTP-message" is *either* a Request, *or* a
/// Response. In libsoup, a `soup.Message` combines both the request and the
/// response.
pub const Message = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = soup.MessageClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `glib.Uri` loaded in the application when the message was
        /// queued.
        pub const first_party = struct {
            pub const name = "first-party";

            pub const Type = ?*glib.Uri;
        };

        /// Various message options.
        pub const flags = struct {
            pub const name = "flags";

            pub const Type = soup.MessageFlags;
        };

        /// The HTTP protocol version to use.
        pub const http_version = struct {
            pub const name = "http-version";

            pub const Type = soup.HTTPVersion;
        };

        /// Whether the message is an OPTIONS ping.
        ///
        /// The `soup.Message` is intended to be used to send
        /// `OPTIONS *` to a server. When set to `TRUE`, the
        /// path of `Message.properties.uri` will be ignored and
        /// `Message.properties.method` set to `SOUP_METHOD_OPTIONS`.
        pub const is_options_ping = struct {
            pub const name = "is-options-ping";

            pub const Type = c_int;
        };

        /// Set when the message is navigating between top level domains.
        pub const is_top_level_navigation = struct {
            pub const name = "is-top-level-navigation";

            pub const Type = c_int;
        };

        /// The message's HTTP method.
        pub const method = struct {
            pub const name = "method";

            pub const Type = ?[*:0]u8;
        };

        /// Sets the priority of the `soup.Message`. See
        /// `Message.setPriority` for further details.
        pub const priority = struct {
            pub const name = "priority";

            pub const Type = soup.MessagePriority;
        };

        /// The HTTP response reason phrase.
        pub const reason_phrase = struct {
            pub const name = "reason-phrase";

            pub const Type = ?[*:0]u8;
        };

        /// The remote `gio.SocketAddress` of the connection associated
        /// with the message.
        pub const remote_address = struct {
            pub const name = "remote-address";

            pub const Type = ?*gio.SocketAddress;
        };

        /// The HTTP request headers.
        pub const request_headers = struct {
            pub const name = "request-headers";

            pub const Type = ?*soup.MessageHeaders;
        };

        /// The HTTP response headers.
        pub const response_headers = struct {
            pub const name = "response-headers";

            pub const Type = ?*soup.MessageHeaders;
        };

        /// Site used to compare cookies against. Used for SameSite cookie support.
        pub const site_for_cookies = struct {
            pub const name = "site-for-cookies";

            pub const Type = ?*glib.Uri;
        };

        /// The HTTP response status code.
        pub const status_code = struct {
            pub const name = "status-code";

            pub const Type = c_uint;
        };

        /// The Name of TLS ciphersuite negotiated for this message connection.
        pub const tls_ciphersuite_name = struct {
            pub const name = "tls-ciphersuite-name";

            pub const Type = ?[*:0]u8;
        };

        /// The peer's `gio.TlsCertificate` associated with the message.
        pub const tls_peer_certificate = struct {
            pub const name = "tls-peer-certificate";

            pub const Type = ?*gio.TlsCertificate;
        };

        /// The verification errors on `Message.properties.tls_peer_certificate`.
        pub const tls_peer_certificate_errors = struct {
            pub const name = "tls-peer-certificate-errors";

            pub const Type = gio.TlsCertificateFlags;
        };

        /// The TLS protocol version negotiated for the message connection.
        pub const tls_protocol_version = struct {
            pub const name = "tls-protocol-version";

            pub const Type = gio.TlsProtocolVersion;
        };

        /// The message's Request-URI.
        pub const uri = struct {
            pub const name = "uri";

            pub const Type = ?*glib.Uri;
        };
    };

    pub const signals = struct {
        /// Emitted during the `msg`'s connection TLS handshake
        /// after an unacceptable TLS certificate has been received.
        ///
        /// You can return `TRUE` to accept `tls_certificate` despite
        /// `tls_errors`.
        pub const accept_certificate = struct {
            pub const name = "accept-certificate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tls_peer_certificate: *gio.TlsCertificate, p_tls_peer_errors: gio.TlsCertificateFlags, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("accept-certificate", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the message requires authentication.
        ///
        /// If credentials are available call `Auth.authenticate` on
        /// `auth`. If these credentials fail, the signal will be emitted again,
        /// with `retrying` set to `TRUE`, which will continue until you return
        /// without calling `Auth.authenticate` on `auth`.
        ///
        /// Note that this may be emitted before `msg`'s body has been
        /// fully read.
        ///
        /// You can authenticate `auth` asynchronously by calling
        /// `gobject.Object.ref` on `auth` and returning `TRUE`. The operation will
        /// complete once either `Auth.authenticate` or
        /// `Auth.cancel` are called.
        pub const authenticate = struct {
            pub const name = "authenticate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_auth: *soup.Auth, p_retrying: c_int, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("authenticate", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted after `Message.signals.got_headers`.
        ///
        /// If content sniffing is disabled, or no content sniffing will be
        /// performed, due to the sniffer deciding to trust the
        /// Content-Type sent by the server, this signal is emitted
        /// immediately after `Message.signals.got_headers`, and `type` is
        /// `NULL`.
        pub const content_sniffed = struct {
            pub const name = "content-sniffed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_type: [*:0]u8, p_params: *glib.HashTable, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("content-sniffed", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when all HTTP processing is finished for a message.
        ///
        /// (After `Message.signals.got_body`).
        pub const finished = struct {
            pub const name = "finished";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("finished", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after receiving the complete message response body.
        pub const got_body = struct {
            pub const name = "got-body";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("got-body", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after reading a portion of the message
        /// body from the network.
        pub const got_body_data = struct {
            pub const name = "got-body-data";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_chunk_size: c_uint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("got-body-data", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after receiving the Status-Line and response headers.
        ///
        /// See also `Message.addHeaderHandler` and
        /// `Message.addStatusCodeHandler`, which can be used to
        /// connect to a subset of emissions of this signal.
        ///
        /// If you cancel or requeue `msg` while processing this signal,
        /// then the current HTTP I/O will be stopped after this signal
        /// emission finished, and `msg`'s connection will be closed.
        /// (If you need to requeue a message--eg, after handling
        /// authentication or redirection--it is usually better to
        /// requeue it from a `Message.signals.got_body` handler rather
        /// than a `Message.signals.got_headers` handler, so that the
        /// existing HTTP connection can be reused.)
        pub const got_headers = struct {
            pub const name = "got-headers";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("got-headers", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after receiving a 1xx (Informational) response for
        /// a (client-side) message.
        ///
        /// The response_headers will be filled in with the headers associated
        /// with the informational response; however, those header values will be
        /// erased after this signal is done.
        ///
        /// If you cancel or requeue `msg` while processing this signal,
        /// then the current HTTP I/O will be stopped after this signal
        /// emission finished, and `msg`'s connection will be closed.
        pub const got_informational = struct {
            pub const name = "got-informational";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("got-informational", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when `HSTSEnforcer` has upgraded the protocol
        /// for `msg` to HTTPS as a result of matching its domain with
        /// a HSTS policy.
        pub const hsts_enforced = struct {
            pub const name = "hsts-enforced";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("hsts-enforced", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted to indicate that some network-related event
        /// related to `msg` has occurred.
        ///
        /// This essentially proxies the `gio.SocketClient.signals.event` signal,
        /// but only for events that occur while `msg` "owns" the connection; if
        /// `msg` is sent on an existing persistent connection, then this signal
        /// will not be emitted. (If you want to force the message to be sent on
        /// a new connection, set the `SOUP_MESSAGE_NEW_CONNECTION` flag on it.)
        ///
        /// See `gio.SocketClient.signals.event` for more information on what
        /// the different values of `event` correspond to, and what
        /// `connection` will be in each case.
        pub const network_event = struct {
            pub const name = "network-event";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_event: gio.SocketClientEvent, p_connection: *gio.IOStream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("network-event", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted during the `msg`'s connection TLS handshake when
        /// `tls_connection` requests a certificate from the client.
        ///
        /// You can set the client certificate by calling
        /// `Message.setTlsClientCertificate` and returning `TRUE`. It's
        /// possible to handle the request asynchornously by returning `TRUE` and
        /// call `Message.setTlsClientCertificate` later once the
        /// certificate is available. Note that this signal is not emitted if
        /// `Session.properties.tls_interaction` was set, or if
        /// `Message.setTlsClientCertificate` was called before the
        /// connection TLS handshake started.
        pub const request_certificate = struct {
            pub const name = "request-certificate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tls_connection: *gio.TlsClientConnection, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("request-certificate", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted during the `msg`'s connection TLS handshake when
        /// `tls_connection` requests a certificate password from the client.
        ///
        /// You can set the certificate password on `password`, then call
        /// `Message.tlsClientCertificatePasswordRequestComplete` and
        /// return `TRUE` to handle the signal synchronously. It's possible to
        /// handle the request asynchornously by calling
        /// `gobject.Object.ref` on `password`, then returning `TRUE` and
        /// call
        /// `Message.tlsClientCertificatePasswordRequestComplete`
        /// later after setting the password on `password`. Note that this signal
        /// is not emitted if `Session.properties.tls_interaction` was set.
        pub const request_certificate_password = struct {
            pub const name = "request-certificate-password";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tls_password: *gio.TlsPassword, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("request-certificate-password", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a request that was already sent once is now
        /// being sent again.
        ///
        /// e.g. because the first attempt received a
        /// redirection response, or because we needed to use
        /// authentication.
        pub const restarted = struct {
            pub const name = "restarted";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("restarted", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted just before a message is sent.
        pub const starting = struct {
            pub const name = "starting";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("starting", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted immediately after writing the complete body for a
        /// message.
        pub const wrote_body = struct {
            pub const name = "wrote-body";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("wrote-body", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted immediately after writing a portion of the message
        /// body to the network.
        pub const wrote_body_data = struct {
            pub const name = "wrote-body-data";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_chunk_size: c_uint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("wrote-body-data", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted immediately after writing the request headers for a
        /// message.
        pub const wrote_headers = struct {
            pub const name = "wrote-headers";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Message, p_instance))),
                    gobject.signalLookup("wrote-headers", Message.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new empty `soup.Message`, which will connect to `uri`.
    extern fn soup_message_new(p_method: [*:0]const u8, p_uri_string: [*:0]const u8) ?*soup.Message;
    pub const new = soup_message_new;

    /// Creates a new `soup.Message` and sets it up to send the given `encoded_form`
    /// to `uri` via `method`. If `method` is "GET", it will include the form data
    /// into `uri`'s query field, and if `method` is "POST" or "PUT", it will be set as
    /// request body.
    ///
    /// This function takes the ownership of `encoded_form`, that will be released
    /// with `glib.free` when no longer in use. See also `formEncode`,
    /// `formEncodeHash` and `formEncodeDatalist`.
    extern fn soup_message_new_from_encoded_form(p_method: [*:0]const u8, p_uri_string: [*:0]const u8, p_encoded_form: [*:0]u8) ?*soup.Message;
    pub const newFromEncodedForm = soup_message_new_from_encoded_form;

    /// Creates a new `soup.Message` and sets it up to send `multipart` to
    /// `uri_string` via POST.
    extern fn soup_message_new_from_multipart(p_uri_string: [*:0]const u8, p_multipart: *soup.Multipart) ?*soup.Message;
    pub const newFromMultipart = soup_message_new_from_multipart;

    /// Creates a new empty `soup.Message`, which will connect to `uri`.
    extern fn soup_message_new_from_uri(p_method: [*:0]const u8, p_uri: *glib.Uri) *soup.Message;
    pub const newFromUri = soup_message_new_from_uri;

    /// Creates a new `soup.Message` to send `OPTIONS *` to a server. The path of
    /// `base_uri` will be ignored.
    extern fn soup_message_new_options_ping(p_base_uri: *glib.Uri) *soup.Message;
    pub const newOptionsPing = soup_message_new_options_ping;

    /// Adds `flags` to the set of `msg`'s flags.
    extern fn soup_message_add_flags(p_msg: *Message, p_flags: soup.MessageFlags) void;
    pub const addFlags = soup_message_add_flags;

    /// Adds a signal handler to `msg` for `signal`.
    ///
    /// Similar to `gobject.signalConnect`, but the `callback` will only be run
    /// if `msg`'s incoming messages headers (that is, the `request_headers`) contain
    /// a header named `header`.
    extern fn soup_message_add_header_handler(p_msg: *Message, p_signal: [*:0]const u8, p_header: [*:0]const u8, p_callback: gobject.Callback, p_user_data: ?*anyopaque) c_uint;
    pub const addHeaderHandler = soup_message_add_header_handler;

    /// Adds a signal handler to `msg` for `signal`.
    ///
    /// Similar to `gobject.signalConnect`, but the `callback` will only be run
    /// if `msg` has the status `status_code`.
    ///
    /// `signal` must be a signal that will be emitted after `msg`'s status
    /// is set (this means it can't be a "wrote" signal).
    extern fn soup_message_add_status_code_handler(p_msg: *Message, p_signal: [*:0]const u8, p_status_code: c_uint, p_callback: gobject.Callback, p_user_data: ?*anyopaque) c_uint;
    pub const addStatusCodeHandler = soup_message_add_status_code_handler;

    /// Disables the actions of `SessionFeature`s with the
    /// given `feature_type` (or a subclass of that type) on `msg`.
    ///
    /// `msg` is processed as though the feature(s) hadn't been added to the
    /// session. Eg, passing `SOUP_TYPE_CONTENT_SNIFFER` for `feature_type`
    /// will disable Content-Type sniffing on the message.
    ///
    /// You must call this before queueing `msg` on a session; calling it on
    /// a message that has already been queued is undefined. In particular,
    /// you cannot call this on a message that is being requeued after a
    /// redirect or authentication.
    extern fn soup_message_disable_feature(p_msg: *Message, p_feature_type: usize) void;
    pub const disableFeature = soup_message_disable_feature;

    /// Returns the unique idenfier for the last connection used.
    ///
    /// This may be 0 if it was a cached resource or it has not gotten
    /// a connection yet.
    extern fn soup_message_get_connection_id(p_msg: *Message) u64;
    pub const getConnectionId = soup_message_get_connection_id;

    /// Gets `msg`'s first-party `glib.Uri`.
    extern fn soup_message_get_first_party(p_msg: *Message) *glib.Uri;
    pub const getFirstParty = soup_message_get_first_party;

    /// Gets the flags on `msg`.
    extern fn soup_message_get_flags(p_msg: *Message) soup.MessageFlags;
    pub const getFlags = soup_message_get_flags;

    /// Returns whether HTTP/1 version is currently demanded for the `msg` send.
    extern fn soup_message_get_force_http1(p_msg: *Message) c_int;
    pub const getForceHttp1 = soup_message_get_force_http1;

    /// Gets the HTTP version of `msg`.
    ///
    /// This is the minimum of the version from the request and the version from the
    /// response.
    extern fn soup_message_get_http_version(p_msg: *Message) soup.HTTPVersion;
    pub const getHttpVersion = soup_message_get_http_version;

    /// Gets whether `msg` is intended to be used to send `OPTIONS *` to a server.
    extern fn soup_message_get_is_options_ping(p_msg: *Message) c_int;
    pub const getIsOptionsPing = soup_message_get_is_options_ping;

    /// Returns if this message is set as a top level navigation.
    ///
    /// Used for same-site policy checks.
    extern fn soup_message_get_is_top_level_navigation(p_msg: *Message) c_int;
    pub const getIsTopLevelNavigation = soup_message_get_is_top_level_navigation;

    /// Returns the method of this message.
    extern fn soup_message_get_method(p_msg: *Message) [*:0]const u8;
    pub const getMethod = soup_message_get_method;

    /// Get the `MessageMetrics` of `msg`.
    ///
    /// If the flag `SOUP_MESSAGE_COLLECT_METRICS` is not enabled for `msg` this will
    /// return `NULL`.
    extern fn soup_message_get_metrics(p_msg: *Message) ?*soup.MessageMetrics;
    pub const getMetrics = soup_message_get_metrics;

    /// Retrieves the `MessagePriority`.
    ///
    /// If not set this value defaults to `SOUP_MESSAGE_PRIORITY_NORMAL`.
    extern fn soup_message_get_priority(p_msg: *Message) soup.MessagePriority;
    pub const getPriority = soup_message_get_priority;

    /// Returns the reason phrase for the status of this message.
    extern fn soup_message_get_reason_phrase(p_msg: *Message) ?[*:0]const u8;
    pub const getReasonPhrase = soup_message_get_reason_phrase;

    /// Get the remote `gio.SocketAddress` of the connection associated with
    /// the message.
    ///
    /// The returned address can be `NULL` if the connection hasn't been established
    /// yet, or the resource was loaded from the disk cache. In case of proxy
    /// connections, the remote address returned is a `gio.ProxyAddress`. If
    /// `Session.properties.remote_connectable` is set the returned address id for the
    /// connection to the session's remote connectable.
    extern fn soup_message_get_remote_address(p_msg: *Message) ?*gio.SocketAddress;
    pub const getRemoteAddress = soup_message_get_remote_address;

    /// Returns the headers sent with the request.
    extern fn soup_message_get_request_headers(p_msg: *Message) *soup.MessageHeaders;
    pub const getRequestHeaders = soup_message_get_request_headers;

    /// Returns the headers recieved with the response.
    extern fn soup_message_get_response_headers(p_msg: *Message) *soup.MessageHeaders;
    pub const getResponseHeaders = soup_message_get_response_headers;

    /// Gets `msg`'s site for cookies `glib.Uri`.
    extern fn soup_message_get_site_for_cookies(p_msg: *Message) *glib.Uri;
    pub const getSiteForCookies = soup_message_get_site_for_cookies;

    /// Returns the set status of this message.
    extern fn soup_message_get_status(p_msg: *Message) soup.Status;
    pub const getStatus = soup_message_get_status;

    /// Gets the name of the TLS ciphersuite negotiated for `msg`'s connection.
    extern fn soup_message_get_tls_ciphersuite_name(p_msg: *Message) [*:0]const u8;
    pub const getTlsCiphersuiteName = soup_message_get_tls_ciphersuite_name;

    /// Gets the peer's `gio.TlsCertificate` associated with `msg`'s connection.
    ///
    /// Note that this is not set yet during the emission of
    /// `Message.signals.accept_certificate` signal.
    extern fn soup_message_get_tls_peer_certificate(p_msg: *Message) ?*gio.TlsCertificate;
    pub const getTlsPeerCertificate = soup_message_get_tls_peer_certificate;

    /// Gets the errors associated with validating `msg`'s TLS peer certificate.
    /// Note that this is not set yet during the emission of
    /// `Message.signals.accept_certificate` signal.
    extern fn soup_message_get_tls_peer_certificate_errors(p_msg: *Message) gio.TlsCertificateFlags;
    pub const getTlsPeerCertificateErrors = soup_message_get_tls_peer_certificate_errors;

    /// Gets the TLS protocol version negotiated for `msg`'s connection.
    ///
    /// If the message connection is not SSL, `G_TLS_PROTOCOL_VERSION_UNKNOWN` is returned.
    extern fn soup_message_get_tls_protocol_version(p_msg: *Message) gio.TlsProtocolVersion;
    pub const getTlsProtocolVersion = soup_message_get_tls_protocol_version;

    /// Gets `msg`'s URI.
    extern fn soup_message_get_uri(p_msg: *Message) *glib.Uri;
    pub const getUri = soup_message_get_uri;

    /// Get whether `SessionFeature`s of the given `feature_type`
    /// (or a subclass of that type) are disabled on `msg`.
    ///
    /// See `Message.disableFeature`.
    extern fn soup_message_is_feature_disabled(p_msg: *Message, p_feature_type: usize) c_int;
    pub const isFeatureDisabled = soup_message_is_feature_disabled;

    /// Determines whether or not `msg`'s connection can be kept alive for
    /// further requests after processing `msg`.
    ///
    /// The result is based on the HTTP version, Connection header, etc.
    extern fn soup_message_is_keepalive(p_msg: *Message) c_int;
    pub const isKeepalive = soup_message_is_keepalive;

    /// Queries if `flags` are present in the set of `msg`'s flags.
    extern fn soup_message_query_flags(p_msg: *Message, p_flags: soup.MessageFlags) c_int;
    pub const queryFlags = soup_message_query_flags;

    /// Removes `flags` from the set of `msg`'s flags.
    extern fn soup_message_remove_flags(p_msg: *Message, p_flags: soup.MessageFlags) void;
    pub const removeFlags = soup_message_remove_flags;

    /// Sets `first_party` as the main document `glib.Uri` for `msg`.
    ///
    /// For details of when and how this is used refer to the documentation for
    /// `CookieJarAcceptPolicy`.
    extern fn soup_message_set_first_party(p_msg: *Message, p_first_party: *glib.Uri) void;
    pub const setFirstParty = soup_message_set_first_party;

    /// Sets the specified flags on `msg`.
    extern fn soup_message_set_flags(p_msg: *Message, p_flags: soup.MessageFlags) void;
    pub const setFlags = soup_message_set_flags;

    /// Sets whether HTTP/1 version should be used when sending this message.
    /// Some connections can still override it, if needed.
    ///
    /// Note the value is unset after the message send is finished.
    extern fn soup_message_set_force_http1(p_msg: *Message, p_value: c_int) void;
    pub const setForceHttp1 = soup_message_set_force_http1;

    /// Set whether `msg` is intended to be used to send `OPTIONS *` to a server.
    ///
    /// When set to `TRUE`, the path of `Message.properties.uri` will be ignored and
    /// `Message.properties.method` set to `SOUP_METHOD_OPTIONS`.
    extern fn soup_message_set_is_options_ping(p_msg: *Message, p_is_options_ping: c_int) void;
    pub const setIsOptionsPing = soup_message_set_is_options_ping;

    /// Sets whether the current request is a top-level navitation.
    ///
    /// See the [same-site spec](https://tools.ietf.org/html/draft-ietf-httpbis-cookie-same-site-00)
    /// for more information.
    extern fn soup_message_set_is_top_level_navigation(p_msg: *Message, p_is_top_level_navigation: c_int) void;
    pub const setIsTopLevelNavigation = soup_message_set_is_top_level_navigation;

    /// Set `msg`'s HTTP method to `method`.
    extern fn soup_message_set_method(p_msg: *Message, p_method: [*:0]const u8) void;
    pub const setMethod = soup_message_set_method;

    /// Sets the priority of a message.
    ///
    /// Note that this won't have any effect unless used before the message is added
    /// to the session's message processing queue.
    ///
    /// The message will be placed just before any other previously added
    /// message with lower priority (messages with the same priority are
    /// processed on a FIFO basis).
    ///
    /// Setting priorities does not currently work with synchronous messages
    /// because in the synchronous/blocking case, priority ends up being determined
    /// semi-randomly by thread scheduling.
    extern fn soup_message_set_priority(p_msg: *Message, p_priority: soup.MessagePriority) void;
    pub const setPriority = soup_message_set_priority;

    /// Set the request body of a `soup.Message`.
    ///
    /// If `content_type` is `NULL` and `stream` is not `NULL` the Content-Type header will
    /// not be changed if present.
    /// The request body needs to be set again in case `msg` is restarted
    /// (in case of redirection or authentication).
    extern fn soup_message_set_request_body(p_msg: *Message, p_content_type: ?[*:0]const u8, p_stream: ?*gio.InputStream, p_content_length: isize) void;
    pub const setRequestBody = soup_message_set_request_body;

    /// Set the request body of a `soup.Message` from `glib.Bytes`.
    ///
    /// If `content_type` is `NULL` and `bytes` is not `NULL` the Content-Type header will
    /// not be changed if present.
    /// The request body needs to be set again in case `msg` is restarted
    /// (in case of redirection or authentication).
    extern fn soup_message_set_request_body_from_bytes(p_msg: *Message, p_content_type: ?[*:0]const u8, p_bytes: ?*glib.Bytes) void;
    pub const setRequestBodyFromBytes = soup_message_set_request_body_from_bytes;

    /// Sets `site_for_cookies` as the policy URL for same-site cookies for `msg`.
    ///
    /// It is either the URL of the top-level document or `NULL` depending on whether
    /// the registrable domain of this document's URL matches the registrable domain
    /// of its parent's/opener's URL. For the top-level document it is set to the
    /// document's URL.
    ///
    /// See the [same-site spec](https://tools.ietf.org/html/draft-ietf-httpbis-cookie-same-site-00)
    /// for more information.
    extern fn soup_message_set_site_for_cookies(p_msg: *Message, p_site_for_cookies: ?*glib.Uri) void;
    pub const setSiteForCookies = soup_message_set_site_for_cookies;

    /// Sets the `certificate` to be used by `msg`'s connection when a
    /// client certificate is requested during the TLS handshake.
    ///
    /// You can call this as a response to `Message.signals.request_certificate`
    /// signal, or before the connection is started. If `certificate` is `NULL`
    /// the handshake will continue without providing a GTlsCertificate.
    /// Note that the `gio.TlsCertificate` set by this function will be ignored if
    /// `Session.properties.tls_interaction` is not `NULL`.
    extern fn soup_message_set_tls_client_certificate(p_msg: *Message, p_certificate: ?*gio.TlsCertificate) void;
    pub const setTlsClientCertificate = soup_message_set_tls_client_certificate;

    /// Sets `msg`'s URI to `uri`.
    ///
    /// If `msg` has already been sent and you want to re-send it with the new URI,
    /// you need to send it again.
    extern fn soup_message_set_uri(p_msg: *Message, p_uri: *glib.Uri) void;
    pub const setUri = soup_message_set_uri;

    /// Completes a certificate password request.
    ///
    /// You must call this as a response to
    /// `Message.signals.request_certificate_password` signal, to notify `msg` that
    /// the `gio.TlsPassword` has already been updated.
    extern fn soup_message_tls_client_certificate_password_request_complete(p_msg: *Message) void;
    pub const tlsClientCertificatePasswordRequestComplete = soup_message_tls_client_certificate_password_request_complete;

    extern fn soup_message_get_type() usize;
    pub const getGObjectType = soup_message_get_type;

    extern fn g_object_ref(p_self: *soup.Message) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.Message) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Message, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Handles streams of multipart messages.
///
/// This adds support for the multipart responses. For handling the
/// multiple parts the user needs to wrap the `gio.InputStream` obtained by
/// sending the request with a `MultipartInputStream` and use
/// `MultipartInputStream.nextPart` before reading. Responses
/// which are not wrapped will be treated like non-multipart responses.
///
/// Note that although `soup.MultipartInputStream` is a `gio.InputStream`,
/// you should not read directly from it, and the results are undefined
/// if you do.
pub const MultipartInputStream = opaque {
    pub const Parent = gio.FilterInputStream;
    pub const Implements = [_]type{gio.PollableInputStream};
    pub const Class = soup.MultipartInputStreamClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `Message`.
        pub const message = struct {
            pub const name = "message";

            pub const Type = ?*soup.Message;
        };
    };

    pub const signals = struct {};

    /// Creates a new `soup.MultipartInputStream` that wraps the
    /// `gio.InputStream` obtained by sending the `Message`.
    ///
    /// Reads should not be done directly through this object, use the input streams
    /// returned by `MultipartInputStream.nextPart` or its async
    /// counterpart instead.
    extern fn soup_multipart_input_stream_new(p_msg: *soup.Message, p_base_stream: *gio.InputStream) *soup.MultipartInputStream;
    pub const new = soup_multipart_input_stream_new;

    /// Obtains the headers for the part currently being processed.
    ///
    /// Note that the `MessageHeaders` that are returned are owned by the
    /// `soup.MultipartInputStream` and will be replaced when a call is made to
    /// `MultipartInputStream.nextPart` or its async counterpart, so if
    /// keeping the headers is required, a copy must be made.
    ///
    /// Note that if a part had no headers at all an empty `MessageHeaders`
    /// will be returned.
    extern fn soup_multipart_input_stream_get_headers(p_multipart: *MultipartInputStream) ?*soup.MessageHeaders;
    pub const getHeaders = soup_multipart_input_stream_get_headers;

    /// Obtains an input stream for the next part.
    ///
    /// When dealing with a multipart response the input stream needs to be wrapped
    /// in a `soup.MultipartInputStream` and this function or its async counterpart
    /// need to be called to obtain the first part for reading.
    ///
    /// After calling this function,
    /// `MultipartInputStream.getHeaders` can be used to obtain the
    /// headers for the first part. A read of 0 bytes indicates the end of
    /// the part; a new call to this function should be done at that point,
    /// to obtain the next part.
    ///
    /// `error` will only be set if an error happens during a read, `NULL`
    /// is a valid return value otherwise.
    extern fn soup_multipart_input_stream_next_part(p_multipart: *MultipartInputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*gio.InputStream;
    pub const nextPart = soup_multipart_input_stream_next_part;

    /// Obtains a `gio.InputStream` for the next request.
    ///
    /// See `MultipartInputStream.nextPart` for details on the workflow.
    extern fn soup_multipart_input_stream_next_part_async(p_multipart: *MultipartInputStream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_data: ?*anyopaque) void;
    pub const nextPartAsync = soup_multipart_input_stream_next_part_async;

    /// Finishes an asynchronous request for the next part.
    extern fn soup_multipart_input_stream_next_part_finish(p_multipart: *MultipartInputStream, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*gio.InputStream;
    pub const nextPartFinish = soup_multipart_input_stream_next_part_finish;

    extern fn soup_multipart_input_stream_get_type() usize;
    pub const getGObjectType = soup_multipart_input_stream_get_type;

    extern fn g_object_ref(p_self: *soup.MultipartInputStream) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.MultipartInputStream) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MultipartInputStream, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `soup.Server` provides a basic implementation of an HTTP server. The
/// recommended usage of this server is for internal use, tasks like
/// a mock server for tests, a private service for IPC, etc. It is not
/// recommended to be exposed to untrusted clients as it may be vulnerable
/// to denial of service attacks or other exploits.
///
/// To begin, create a server using `Server.new`. Add at least one
/// handler by calling `Server.addHandler` or
/// `Server.addEarlyHandler`; the handler will be called to
/// process any requests underneath the path you pass. (If you want all
/// requests to go to the same handler, just pass "/" (or `NULL`) for
/// the path.)
///
/// When a new connection is accepted (or a new request is started on
/// an existing persistent connection), the `soup.Server` will emit
/// `Server.signals.request_started` and then begin processing the request
/// as described below, but note that once the message is assigned a
/// status-code, then callbacks after that point will be
/// skipped. Note also that it is not defined when the callbacks happen
/// relative to various `ServerMessage` signals.
///
/// Once the headers have been read, `soup.Server` will check if there is
/// a `AuthDomain` `(qv)` covering the Request-URI; if so, and if the
/// message does not contain suitable authorization, then the
/// `AuthDomain` will set a status of `SOUP_STATUS_UNAUTHORIZED` on
/// the message.
///
/// After checking for authorization, `soup.Server` will look for "early"
/// handlers (added with `Server.addEarlyHandler`) matching the
/// Request-URI. If one is found, it will be run; in particular, this
/// can be used to connect to signals to do a streaming read of the
/// request body.
///
/// (At this point, if the request headers contain `Expect:
/// 100-continue`, and a status code has been set, then
/// `soup.Server` will skip the remaining steps and return the response.
/// If the request headers contain `Expect:
/// 100-continue` and no status code has been set,
/// `soup.Server` will return a `SOUP_STATUS_CONTINUE` status before
/// continuing.)
///
/// The server will then read in the response body (if present). At
/// this point, if there are no handlers at all defined for the
/// Request-URI, then the server will return `SOUP_STATUS_NOT_FOUND` to
/// the client.
///
/// Otherwise (assuming no previous step assigned a status to the
/// message) any "normal" handlers (added with
/// `Server.addHandler`) for the message's Request-URI will be
/// run.
///
/// Then, if the path has a WebSocket handler registered (and has
/// not yet been assigned a status), `soup.Server` will attempt to
/// validate the WebSocket handshake, filling in the response and
/// setting a status of `SOUP_STATUS_SWITCHING_PROTOCOLS` or
/// `SOUP_STATUS_BAD_REQUEST` accordingly.
///
/// If the message still has no status code at this point (and has not
/// been paused with `ServerMessage.pause`), then it will be
/// given a status of `SOUP_STATUS_INTERNAL_SERVER_ERROR` (because at
/// least one handler ran, but returned without assigning a status).
///
/// Finally, the server will emit `Server.signals.request_finished` (or
/// `Server.signals.request_aborted` if an I/O error occurred before
/// handling was completed).
///
/// If you want to handle the special "*" URI (eg, "OPTIONS *"), you
/// must explicitly register a handler for "*"; the default handler
/// will not be used for that case.
///
/// If you want to process https connections in addition to (or instead
/// of) http connections, you can set the `Server.properties.tls_certificate`
/// property.
///
/// Once the server is set up, make one or more calls to
/// `Server.listen`, `Server.listenLocal`, or
/// `Server.listenAll` to tell it where to listen for
/// connections. (All ports on a `soup.Server` use the same handlers; if
/// you need to handle some ports differently, such as returning
/// different data for http and https, you'll need to create multiple
/// `SoupServer`s, or else check the passed-in URI in the handler
/// function.).
///
/// `soup.Server` will begin processing connections as soon as you return
/// to (or start) the main loop for the current thread-default
/// `glib.MainContext`.
pub const Server = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = soup.ServerClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const request_aborted = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) void {
                return gobject.ext.as(Server.Class, p_class).f_request_aborted.?(gobject.ext.as(Server, p_server), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) callconv(.c) void) void {
                gobject.ext.as(Server.Class, p_class).f_request_aborted = @ptrCast(p_implementation);
            }
        };

        pub const request_finished = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) void {
                return gobject.ext.as(Server.Class, p_class).f_request_finished.?(gobject.ext.as(Server, p_server), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) callconv(.c) void) void {
                gobject.ext.as(Server.Class, p_class).f_request_finished = @ptrCast(p_implementation);
            }
        };

        pub const request_read = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) void {
                return gobject.ext.as(Server.Class, p_class).f_request_read.?(gobject.ext.as(Server, p_server), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) callconv(.c) void) void {
                gobject.ext.as(Server.Class, p_class).f_request_read = @ptrCast(p_implementation);
            }
        };

        pub const request_started = struct {
            pub fn call(p_class: anytype, p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) void {
                return gobject.ext.as(Server.Class, p_class).f_request_started.?(gobject.ext.as(Server, p_server), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_server: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.ServerMessage) callconv(.c) void) void {
                gobject.ext.as(Server.Class, p_class).f_request_started = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// If `TRUE`, percent-encoding in the Request-URI path will not be
        /// automatically decoded.
        pub const raw_paths = struct {
            pub const name = "raw-paths";

            pub const Type = c_int;
        };

        /// Server header.
        ///
        /// If non-`NULL`, the value to use for the "Server" header on
        /// `ServerMessage`s processed by this server.
        ///
        /// The Server header is the server equivalent of the
        /// User-Agent header, and provides information about the
        /// server and its components. It contains a list of one or
        /// more product tokens, separated by whitespace, with the most
        /// significant product token coming first. The tokens must be
        /// brief, ASCII, and mostly alphanumeric (although "-", "_",
        /// and "." are also allowed), and may optionally include a "/"
        /// followed by a version string. You may also put comments,
        /// enclosed in parentheses, between or after the tokens.
        ///
        /// Some HTTP server implementations intentionally do not use
        /// version numbers in their Server header, so that
        /// installations running older versions of the server don't
        /// end up advertising their vulnerability to specific security
        /// holes.
        ///
        /// As with `Session.properties.user_agent`, if you set a
        /// `Server.properties.server_header` property that has trailing
        /// whitespace, `soup.Server` will append its own product token (eg,
        /// `libsoup/2.3.2`) to the end of the header for you.
        pub const server_header = struct {
            pub const name = "server-header";

            pub const Type = ?[*:0]u8;
        };

        /// A `gio.TlsAuthenticationMode` for SSL/TLS client authentication.
        pub const tls_auth_mode = struct {
            pub const name = "tls-auth-mode";

            pub const Type = gio.TlsAuthenticationMode;
        };

        /// A `gio.@"TlsCertificate["` that has a
        /// `gio.TlsCertificate.properties.private_key` set.
        ///
        /// If this is set, then the server will be able to speak
        /// https in addition to (or instead of) plain http.
        pub const tls_certificate = struct {
            pub const name = "tls-certificate";

            pub const Type = ?*gio.TlsCertificate;
        };

        /// A `gio.TlsDatabase` to use for validating SSL/TLS client
        /// certificates.
        pub const tls_database = struct {
            pub const name = "tls-database";

            pub const Type = ?*gio.TlsDatabase;
        };
    };

    pub const signals = struct {
        /// Emitted when processing has failed for a message.
        ///
        /// This could mean either that it could not be read (if
        /// `Server.signals.request_read` has not been emitted for it yet), or that
        /// the response could not be written back (if `Server.signals.request_read`
        /// has been emitted but `Server.signals.request_finished` has not been).
        ///
        /// `message` is in an undefined state when this signal is
        /// emitted; the signal exists primarily to allow the server to
        /// free any state that it may have allocated in
        /// `Server.signals.request_started`.
        pub const request_aborted = struct {
            pub const name = "request-aborted";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_message: *soup.ServerMessage, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Server, p_instance))),
                    gobject.signalLookup("request-aborted", Server.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the server has finished writing a response to
        /// a request.
        pub const request_finished = struct {
            pub const name = "request-finished";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_message: *soup.ServerMessage, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Server, p_instance))),
                    gobject.signalLookup("request-finished", Server.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the server has successfully read a request.
        ///
        /// `message` will have all of its request-side information
        /// filled in, and if the message was authenticated, `client`
        /// will have information about that. This signal is emitted
        /// before any (non-early) handlers are called for the message,
        /// and if it sets the message's `status_code`, then normal
        /// handler processing will be skipped.
        pub const request_read = struct {
            pub const name = "request-read";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_message: *soup.ServerMessage, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Server, p_instance))),
                    gobject.signalLookup("request-read", Server.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the server has started reading a new request.
        ///
        /// `message` will be completely blank; not even the
        /// Request-Line will have been read yet. About the only thing
        /// you can usefully do with it is connect to its signals.
        ///
        /// If the request is read successfully, this will eventually
        /// be followed by a `Server.signals.@"request_read signal"`. If a
        /// response is then sent, the request processing will end with
        /// a `Server.signals.request_finished` signal. If a network error
        /// occurs, the processing will instead end with
        /// `Server.signals.request_aborted`.
        pub const request_started = struct {
            pub const name = "request-started";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_message: *soup.ServerMessage, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Server, p_instance))),
                    gobject.signalLookup("request-started", Server.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `soup.Server`.
    ///
    /// This is exactly equivalent to calling `gobject.Object.new` and
    /// specifying `SOUP_TYPE_SERVER` as the type.
    extern fn soup_server_new(p_optname1: [*:0]const u8, ...) ?*soup.Server;
    pub const new = soup_server_new;

    /// Adds a new client stream to the `server`.
    extern fn soup_server_accept_iostream(p_server: *Server, p_stream: *gio.IOStream, p_local_addr: ?*gio.SocketAddress, p_remote_addr: ?*gio.SocketAddress, p_error: ?*?*glib.Error) c_int;
    pub const acceptIostream = soup_server_accept_iostream;

    /// Adds an authentication domain to `server`.
    ///
    /// Each auth domain will have the chance to require authentication for each
    /// request that comes in; normally auth domains will require authentication for
    /// requests on certain paths that they have been set up to watch, or that meet
    /// other criteria set by the caller. If an auth domain determines that a request
    /// requires authentication (and the request doesn't contain authentication),
    /// `server` will automatically reject the request with an appropriate status (401
    /// Unauthorized or 407 Proxy Authentication Required). If the request used the
    /// SoupServer:100-continue Expectation, `server` will reject it before the
    /// request body is sent.
    extern fn soup_server_add_auth_domain(p_server: *Server, p_auth_domain: *soup.AuthDomain) void;
    pub const addAuthDomain = soup_server_add_auth_domain;

    /// Adds an "early" handler to `server` for requests prefixed by `path`.
    ///
    /// Note that "normal" and "early" handlers are matched up together, so if you
    /// add a normal handler for "/foo" and an early handler for "/foo/bar", then a
    /// request to "/foo/bar" (or any path below it) will run only the early handler.
    /// (But if you add both handlers at the same path, then both will get run.)
    ///
    /// For requests under `path` (that have not already been assigned a
    /// status code by a `AuthDomain` or a signal handler), `callback`
    /// will be invoked after receiving the request headers, but before
    /// receiving the request body; the message's method and
    /// request-headers properties will be set.
    ///
    /// Early handlers are generally used for processing requests with request bodies
    /// in a streaming fashion. If you determine that the request will contain a
    /// message body, normally you would call `MessageBody.setAccumulate` on
    /// the message's request-body to turn off request-body accumulation, and connect
    /// to the message's `ServerMessage.signals.got_chunk` signal to process each
    /// chunk as it comes in.
    ///
    /// To complete the message processing after the full message body has
    /// been read, you can either also connect to `ServerMessage.signals.got_body`,
    /// or else you can register a non-early handler for `path` as well. As
    /// long as you have not set the status-code by the time
    /// `ServerMessage.signals.got_body` is emitted, the non-early handler will be
    /// run as well.
    extern fn soup_server_add_early_handler(p_server: *Server, p_path: ?[*:0]const u8, p_callback: soup.ServerCallback, p_user_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const addEarlyHandler = soup_server_add_early_handler;

    /// Adds a handler to `server` for requests prefixed by `path`.
    ///
    /// If `path` is `NULL` or "/", then this will be the default handler for all
    /// requests that don't have a more specific handler. (Note though that if you
    /// want to handle requests to the special "*" URI, you must explicitly register
    /// a handler for "*"; the default handler will not be used for that case.)
    ///
    /// For requests under `path` (that have not already been assigned a
    /// status code by a `AuthDomain`, an early server handler, or a
    /// signal handler), `callback` will be invoked after receiving the
    /// request body; the `ServerMessage`'s method, request-headers,
    /// and request-body properties will be set.
    ///
    /// After determining what to do with the request, the callback must at a minimum
    /// call `ServerMessage.setStatus` on the message to set the response
    /// status code. Additionally, it may set response headers and/or fill in the
    /// response body.
    ///
    /// If the callback cannot fully fill in the response before returning
    /// (eg, if it needs to wait for information from a database, or
    /// another network server), it should call `ServerMessage.pause`
    /// to tell `server` to not send the response right away. When the
    /// response is ready, call `ServerMessage.unpause` to cause it
    /// to be sent.
    ///
    /// To send the response body a bit at a time using "chunked" encoding, first
    /// call `MessageHeaders.setEncoding` to set `SOUP_ENCODING_CHUNKED` on
    /// the response-headers. Then call `MessageBody.append` (or
    /// `MessageBody.appendBytes`)) to append each chunk as it becomes ready,
    /// and `ServerMessage.unpause` to make sure it's running. (The server
    /// will automatically pause the message if it is using chunked encoding but no
    /// more chunks are available.) When you are done, call
    /// `MessageBody.complete` to indicate that no more chunks are coming.
    extern fn soup_server_add_handler(p_server: *Server, p_path: ?[*:0]const u8, p_callback: soup.ServerCallback, p_user_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const addHandler = soup_server_add_handler;

    /// Add support for a WebSocket extension of the given `extension_type`.
    ///
    /// When a WebSocket client requests an extension of `extension_type`,
    /// a new `WebsocketExtension` of type `extension_type` will be created
    /// to handle the request.
    ///
    /// Note that `WebsocketExtensionDeflate` is supported by default, use
    /// `Server.removeWebsocketExtension` if you want to disable it.
    extern fn soup_server_add_websocket_extension(p_server: *Server, p_extension_type: usize) void;
    pub const addWebsocketExtension = soup_server_add_websocket_extension;

    /// Adds a WebSocket handler to `server` for requests prefixed by `path`.
    ///
    /// If `path` is `NULL` or "/", then this will be the default handler for all
    /// requests that don't have a more specific handler.
    ///
    /// When a path has a WebSocket handler registered, `server` will check
    /// incoming requests for WebSocket handshakes after all other handlers
    /// have run (unless some earlier handler has already set a status code
    /// on the message), and update the request's status, response headers,
    /// and response body accordingly.
    ///
    /// If `origin` is non-`NULL`, then only requests containing a matching
    /// "Origin" header will be accepted. If `protocols` is non-`NULL`, then
    /// only requests containing a compatible "Sec-WebSocket-Protocols"
    /// header will be accepted. More complicated requirements can be
    /// handled by adding a normal handler to `path`, and having it perform
    /// whatever checks are needed and
    /// setting a failure status code if the handshake should be rejected.
    extern fn soup_server_add_websocket_handler(p_server: *Server, p_path: ?[*:0]const u8, p_origin: ?[*:0]const u8, p_protocols: ?[*][*:0]u8, p_callback: soup.ServerWebsocketCallback, p_user_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const addWebsocketHandler = soup_server_add_websocket_handler;

    /// Closes and frees `server`'s listening sockets.
    ///
    /// Note that if there are currently requests in progress on `server`, that they
    /// will continue to be processed if `server`'s `glib.MainContext` is still
    /// running.
    ///
    /// You can call `Server.listen`, etc, after calling this function
    /// if you want to start listening again.
    extern fn soup_server_disconnect(p_server: *Server) void;
    pub const disconnect = soup_server_disconnect;

    /// Gets `server`'s list of listening sockets.
    ///
    /// You should treat these sockets as read-only; writing to or
    /// modifiying any of these sockets may cause `server` to malfunction.
    extern fn soup_server_get_listeners(p_server: *Server) *glib.SList;
    pub const getListeners = soup_server_get_listeners;

    /// Gets the `server` SSL/TLS client authentication mode.
    extern fn soup_server_get_tls_auth_mode(p_server: *Server) gio.TlsAuthenticationMode;
    pub const getTlsAuthMode = soup_server_get_tls_auth_mode;

    /// Gets the `server` SSL/TLS certificate.
    extern fn soup_server_get_tls_certificate(p_server: *Server) ?*gio.TlsCertificate;
    pub const getTlsCertificate = soup_server_get_tls_certificate;

    /// Gets the `server` SSL/TLS database.
    extern fn soup_server_get_tls_database(p_server: *Server) ?*gio.TlsDatabase;
    pub const getTlsDatabase = soup_server_get_tls_database;

    /// Gets a list of URIs corresponding to the interfaces `server` is
    /// listening on.
    ///
    /// These will contain IP addresses, not hostnames, and will also indicate
    /// whether the given listener is http or https.
    ///
    /// Note that if you used `Server.listenAll` the returned URIs will use
    /// the addresses `0.0.0.0` and `::`, rather than actually returning separate
    /// URIs for each interface on the system.
    extern fn soup_server_get_uris(p_server: *Server) *glib.SList;
    pub const getUris = soup_server_get_uris;

    /// Checks whether `server` is capable of https.
    ///
    /// In order for a server to run https, you must call
    /// `Server.setTlsCertificate`, or set the
    /// `Server.properties.tls_certificate` property, to provide it with a
    /// certificate to use.
    ///
    /// If you are using the deprecated single-listener APIs, then a return value of
    /// `TRUE` indicates that the `soup.Server` serves https exclusively. If you are
    /// using `Server.listen`, etc, then a `TRUE` return value merely indicates
    /// that the server is *able* to do https, regardless of whether it actually
    /// currently is or not. Use `Server.getUris` to see if it currently has
    /// any https listeners.
    extern fn soup_server_is_https(p_server: *Server) c_int;
    pub const isHttps = soup_server_is_https;

    /// Attempts to set up `server` to listen for connections on `address`.
    ///
    /// If `options` includes `SOUP_SERVER_LISTEN_HTTPS`, and `server` has
    /// been configured for TLS, then `server` will listen for https
    /// connections on this port. Otherwise it will listen for plain http.
    ///
    /// You may call this method (along with the other "listen" methods)
    /// any number of times on a server, if you want to listen on multiple
    /// ports, or set up both http and https service.
    ///
    /// After calling this method, `server` will begin accepting and processing
    /// connections as soon as the appropriate `glib.MainContext` is run.
    ///
    /// Note that this API does not make use of dual IPv4/IPv6 sockets; if
    /// `address` is an IPv6 address, it will only accept IPv6 connections.
    /// You must configure IPv4 listening separately.
    extern fn soup_server_listen(p_server: *Server, p_address: *gio.SocketAddress, p_options: soup.ServerListenOptions, p_error: ?*?*glib.Error) c_int;
    pub const listen = soup_server_listen;

    /// Attempts to set up `server` to listen for connections on all interfaces
    /// on the system.
    ///
    /// That is, it listens on the addresses `0.0.0.0` and/or `::`, depending on
    /// whether `options` includes `SOUP_SERVER_LISTEN_IPV4_ONLY`,
    /// `SOUP_SERVER_LISTEN_IPV6_ONLY`, or neither.) If `port` is specified, `server`
    /// will listen on that port. If it is 0, `server` will find an unused port to
    /// listen on. (In that case, you can use `Server.getUris` to find out
    /// what port it ended up choosing.
    ///
    /// See `Server.listen` for more details.
    extern fn soup_server_listen_all(p_server: *Server, p_port: c_uint, p_options: soup.ServerListenOptions, p_error: ?*?*glib.Error) c_int;
    pub const listenAll = soup_server_listen_all;

    /// Attempts to set up `server` to listen for connections on "localhost".
    ///
    /// That is, `127.0.0.1` and/or `::1`, depending on whether `options` includes
    /// `SOUP_SERVER_LISTEN_IPV4_ONLY`, `SOUP_SERVER_LISTEN_IPV6_ONLY`, or neither). If
    /// `port` is specified, `server` will listen on that port. If it is 0, `server`
    /// will find an unused port to listen on. (In that case, you can use
    /// `Server.getUris` to find out what port it ended up choosing.
    ///
    /// See `Server.listen` for more details.
    extern fn soup_server_listen_local(p_server: *Server, p_port: c_uint, p_options: soup.ServerListenOptions, p_error: ?*?*glib.Error) c_int;
    pub const listenLocal = soup_server_listen_local;

    /// Attempts to set up `server` to listen for connections on `socket`.
    ///
    /// See `Server.listen` for more details.
    extern fn soup_server_listen_socket(p_server: *Server, p_socket: *gio.Socket, p_options: soup.ServerListenOptions, p_error: ?*?*glib.Error) c_int;
    pub const listenSocket = soup_server_listen_socket;

    /// Pauses I/O on `msg`.
    ///
    /// This can be used when you need to return from the server handler without
    /// having the full response ready yet. Use `Server.unpauseMessage` to
    /// resume I/O.
    ///
    /// This must only be called on a `ServerMessage` which was created by the
    /// `soup.Server` and are currently doing I/O, such as those passed into a
    /// `ServerCallback` or emitted in a `Server.signals.request_read`
    /// signal.
    extern fn soup_server_pause_message(p_server: *Server, p_msg: *soup.ServerMessage) void;
    pub const pauseMessage = soup_server_pause_message;

    /// Removes `auth_domain` from `server`.
    extern fn soup_server_remove_auth_domain(p_server: *Server, p_auth_domain: *soup.AuthDomain) void;
    pub const removeAuthDomain = soup_server_remove_auth_domain;

    /// Removes all handlers (early and normal) registered at `path`.
    extern fn soup_server_remove_handler(p_server: *Server, p_path: [*:0]const u8) void;
    pub const removeHandler = soup_server_remove_handler;

    /// Removes support for WebSocket extension of type `extension_type` (or any subclass of
    /// `extension_type`) from `server`.
    extern fn soup_server_remove_websocket_extension(p_server: *Server, p_extension_type: usize) void;
    pub const removeWebsocketExtension = soup_server_remove_websocket_extension;

    /// Sets `server`'s `gio.TlsAuthenticationMode` to use for SSL/TLS client authentication.
    extern fn soup_server_set_tls_auth_mode(p_server: *Server, p_mode: gio.TlsAuthenticationMode) void;
    pub const setTlsAuthMode = soup_server_set_tls_auth_mode;

    /// Sets `server` up to do https, using the given SSL/TLS `certificate`.
    extern fn soup_server_set_tls_certificate(p_server: *Server, p_certificate: *gio.TlsCertificate) void;
    pub const setTlsCertificate = soup_server_set_tls_certificate;

    /// Sets `server`'s `gio.TlsDatabase` to use for validating SSL/TLS client certificates.
    extern fn soup_server_set_tls_database(p_server: *Server, p_tls_database: *gio.TlsDatabase) void;
    pub const setTlsDatabase = soup_server_set_tls_database;

    /// Resumes I/O on `msg`.
    ///
    /// Use this to resume after calling `Server.pauseMessage`, or after
    /// adding a new chunk to a chunked response.
    ///
    /// I/O won't actually resume until you return to the main loop.
    ///
    /// This must only be called on a `ServerMessage` which was created by the
    /// `soup.Server` and are currently doing I/O, such as those passed into a
    /// `ServerCallback` or emitted in a `Server.signals.request_read`
    /// signal.
    extern fn soup_server_unpause_message(p_server: *Server, p_msg: *soup.ServerMessage) void;
    pub const unpauseMessage = soup_server_unpause_message;

    extern fn soup_server_get_type() usize;
    pub const getGObjectType = soup_server_get_type;

    extern fn g_object_ref(p_self: *soup.Server) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.Server) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Server, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An HTTP server request and response pair.
///
/// A SoupServerMessage represents an HTTP message that is being sent or
/// received on a `Server`.
///
/// `Server` will create `SoupServerMessage`s automatically for
/// incoming requests, which your application will receive via handlers.
///
/// Note that libsoup's terminology here does not quite match the HTTP
/// specification: in RFC 2616, an "HTTP-message" is *either* a Request, *or* a
/// Response. In libsoup, a `soup.ServerMessage` combines both the request and the
/// response.
pub const ServerMessage = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = soup.ServerMessageClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The peer's `gio.TlsCertificate` associated with the message
        pub const tls_peer_certificate = struct {
            pub const name = "tls-peer-certificate";

            pub const Type = ?*gio.TlsCertificate;
        };

        /// The verification errors on `soup.ServerMessage.properties.tls`-peer-certificate
        pub const tls_peer_certificate_errors = struct {
            pub const name = "tls-peer-certificate-errors";

            pub const Type = gio.TlsCertificateFlags;
        };
    };

    pub const signals = struct {
        /// Emitted during the `msg`'s connection TLS handshake
        /// after client TLS certificate has been received.
        /// You can return `TRUE` to accept `tls_certificate` despite
        /// `tls_errors`.
        pub const accept_certificate = struct {
            pub const name = "accept-certificate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tls_peer_certificate: *gio.TlsCertificate, p_tls_peer_errors: gio.TlsCertificateFlags, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("accept-certificate", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the `msg`'s socket is connected and the TLS handshake completed.
        pub const connected = struct {
            pub const name = "connected";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("connected", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the `msg`'s socket is disconnected.
        pub const disconnected = struct {
            pub const name = "disconnected";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("disconnected", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when all HTTP processing is finished for a message.
        /// (After `ServerMessage.signals.wrote_body`).
        pub const finished = struct {
            pub const name = "finished";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("finished", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after receiving the complete request body.
        pub const got_body = struct {
            pub const name = "got-body";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("got-body", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after receiving a chunk of a message body.
        ///
        /// Note that "chunk" in this context means any subpiece of the body, not
        /// necessarily the specific HTTP 1.1 chunks sent by the other side.
        pub const got_chunk = struct {
            pub const name = "got-chunk";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_chunk: *glib.Bytes, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("got-chunk", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after receiving the Request-Line and request headers.
        pub const got_headers = struct {
            pub const name = "got-headers";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("got-headers", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted immediately after writing the complete response body for a
        /// message.
        pub const wrote_body = struct {
            pub const name = "wrote-body";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("wrote-body", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted immediately after writing a portion of the message
        /// body to the network.
        pub const wrote_body_data = struct {
            pub const name = "wrote-body-data";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_chunk_size: c_uint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("wrote-body-data", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted immediately after writing a body chunk for a message.
        ///
        /// Note that this signal is not parallel to
        /// `ServerMessage.signals.got_chunk`; it is emitted only when a complete
        /// chunk (added with `MessageBody.append` or
        /// `MessageBody.appendBytes` has been written. To get
        /// more useful continuous progress information, use
        /// `ServerMessage.signals.wrote_body_data`.
        pub const wrote_chunk = struct {
            pub const name = "wrote-chunk";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("wrote-chunk", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted immediately after writing the response headers for a
        /// message.
        pub const wrote_headers = struct {
            pub const name = "wrote-headers";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("wrote-headers", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted immediately after writing a 1xx (Informational) response.
        pub const wrote_informational = struct {
            pub const name = "wrote-informational";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ServerMessage, p_instance))),
                    gobject.signalLookup("wrote-informational", ServerMessage.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Get the HTTP version of `msg`.
    extern fn soup_server_message_get_http_version(p_msg: *ServerMessage) soup.HTTPVersion;
    pub const getHttpVersion = soup_server_message_get_http_version;

    /// Retrieves the `gio.SocketAddress` associated with the local end
    /// of a connection.
    extern fn soup_server_message_get_local_address(p_msg: *ServerMessage) ?*gio.SocketAddress;
    pub const getLocalAddress = soup_server_message_get_local_address;

    /// Get the HTTP method of `msg`.
    extern fn soup_server_message_get_method(p_msg: *ServerMessage) [*:0]const u8;
    pub const getMethod = soup_server_message_get_method;

    /// Get the HTTP reason phrase of `msg`.
    extern fn soup_server_message_get_reason_phrase(p_msg: *ServerMessage) ?[*:0]const u8;
    pub const getReasonPhrase = soup_server_message_get_reason_phrase;

    /// Retrieves the `gio.SocketAddress` associated with the remote end
    /// of a connection.
    extern fn soup_server_message_get_remote_address(p_msg: *ServerMessage) ?*gio.SocketAddress;
    pub const getRemoteAddress = soup_server_message_get_remote_address;

    /// Retrieves the IP address associated with the remote end of a
    /// connection.
    extern fn soup_server_message_get_remote_host(p_msg: *ServerMessage) ?[*:0]const u8;
    pub const getRemoteHost = soup_server_message_get_remote_host;

    /// Get the request body of `msg`.
    extern fn soup_server_message_get_request_body(p_msg: *ServerMessage) *soup.MessageBody;
    pub const getRequestBody = soup_server_message_get_request_body;

    /// Get the request headers of `msg`.
    extern fn soup_server_message_get_request_headers(p_msg: *ServerMessage) *soup.MessageHeaders;
    pub const getRequestHeaders = soup_server_message_get_request_headers;

    /// Get the response body of `msg`.
    extern fn soup_server_message_get_response_body(p_msg: *ServerMessage) *soup.MessageBody;
    pub const getResponseBody = soup_server_message_get_response_body;

    /// Get the response headers of `msg`.
    extern fn soup_server_message_get_response_headers(p_msg: *ServerMessage) *soup.MessageHeaders;
    pub const getResponseHeaders = soup_server_message_get_response_headers;

    /// Retrieves the `gio.Socket` that `msg` is associated with.
    ///
    /// If you are using this method to observe when multiple requests are
    /// made on the same persistent HTTP connection (eg, as the ntlm-test
    /// test program does), you will need to pay attention to socket
    /// destruction as well (eg, by using weak references), so that you do
    /// not get fooled when the allocator reuses the memory address of a
    /// previously-destroyed socket to represent a new socket.
    extern fn soup_server_message_get_socket(p_msg: *ServerMessage) ?*gio.Socket;
    pub const getSocket = soup_server_message_get_socket;

    /// Get the HTTP status code of `msg`.
    extern fn soup_server_message_get_status(p_msg: *ServerMessage) c_uint;
    pub const getStatus = soup_server_message_get_status;

    /// Gets the peer's `gio.TlsCertificate` associated with `msg`'s connection.
    /// Note that this is not set yet during the emission of
    /// SoupServerMessage::accept-certificate signal.
    extern fn soup_server_message_get_tls_peer_certificate(p_msg: *ServerMessage) ?*gio.TlsCertificate;
    pub const getTlsPeerCertificate = soup_server_message_get_tls_peer_certificate;

    /// Gets the errors associated with validating `msg`'s TLS peer certificate.
    /// Note that this is not set yet during the emission of
    /// SoupServerMessage::accept-certificate signal.
    extern fn soup_server_message_get_tls_peer_certificate_errors(p_msg: *ServerMessage) gio.TlsCertificateFlags;
    pub const getTlsPeerCertificateErrors = soup_server_message_get_tls_peer_certificate_errors;

    /// Get `msg`'s URI.
    extern fn soup_server_message_get_uri(p_msg: *ServerMessage) *glib.Uri;
    pub const getUri = soup_server_message_get_uri;

    /// Gets if `msg` represents an OPTIONS message with the path `*`.
    extern fn soup_server_message_is_options_ping(p_msg: *ServerMessage) c_int;
    pub const isOptionsPing = soup_server_message_is_options_ping;

    /// Pauses I/O on `msg`.
    ///
    /// This can be used when you need to return from the server handler without
    /// having the full response ready yet. Use `ServerMessage.unpause` to
    /// resume I/O.
    extern fn soup_server_message_pause(p_msg: *ServerMessage) void;
    pub const pause = soup_server_message_pause;

    /// Set the HTTP version of `msg`.
    extern fn soup_server_message_set_http_version(p_msg: *ServerMessage, p_version: soup.HTTPVersion) void;
    pub const setHttpVersion = soup_server_message_set_http_version;

    /// Sets `msg`'s status_code to `status_code` and adds a Location header
    /// pointing to `redirect_uri`. Use this from a `Server` when you
    /// want to redirect the client to another URI.
    ///
    /// `redirect_uri` can be a relative URI, in which case it is
    /// interpreted relative to `msg`'s current URI. In particular, if
    /// `redirect_uri` is just a path, it will replace the path
    /// *and query* of `msg`'s URI.
    extern fn soup_server_message_set_redirect(p_msg: *ServerMessage, p_status_code: c_uint, p_redirect_uri: [*:0]const u8) void;
    pub const setRedirect = soup_server_message_set_redirect;

    /// Convenience function to set the response body of a `soup.ServerMessage`. If
    /// `content_type` is `NULL`, the response body must be empty as well.
    extern fn soup_server_message_set_response(p_msg: *ServerMessage, p_content_type: ?[*:0]const u8, p_resp_use: soup.MemoryUse, p_resp_body: ?[*]const u8, p_resp_length: usize) void;
    pub const setResponse = soup_server_message_set_response;

    /// Sets `msg`'s status code to `status_code`.
    ///
    /// If `status_code` is a known value and `reason_phrase` is `NULL`, the
    /// reason_phrase will be set automatically.
    extern fn soup_server_message_set_status(p_msg: *ServerMessage, p_status_code: c_uint, p_reason_phrase: ?[*:0]const u8) void;
    pub const setStatus = soup_server_message_set_status;

    /// "Steals" the HTTP connection associated with `msg` from its `soup.Server`. This
    /// happens immediately, regardless of the current state of the connection; if
    /// the response to `msg` has not yet finished being sent, then it will be
    /// discarded; you can steal the connection from a
    /// `ServerMessage.signals.wrote_informational` or
    /// `ServerMessage.signals.wrote_body` signal handler if you need to wait for
    /// part or all of the response to be sent.
    ///
    /// Note that when calling this function from C, `msg` will most
    /// likely be freed as a side effect.
    extern fn soup_server_message_steal_connection(p_msg: *ServerMessage) *gio.IOStream;
    pub const stealConnection = soup_server_message_steal_connection;

    /// Resumes I/O on `msg`.
    ///
    /// Use this to resume after calling `ServerMessage.pause`, or after
    /// adding a new chunk to a chunked response. I/O won't actually resume until you
    /// return to the main loop.
    extern fn soup_server_message_unpause(p_msg: *ServerMessage) void;
    pub const unpause = soup_server_message_unpause;

    extern fn soup_server_message_get_type() usize;
    pub const getGObjectType = soup_server_message_get_type;

    extern fn g_object_ref(p_self: *soup.ServerMessage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.ServerMessage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ServerMessage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Soup session state object.
///
/// `soup.Session` is the object that controls client-side HTTP. A
/// `soup.Session` encapsulates all of the state that libsoup is keeping
/// on behalf of your program; cached HTTP connections, authentication
/// information, etc. It also keeps track of various global options
/// and features that you are using.
///
/// Most applications will only need a single `soup.Session`; the primary
/// reason you might need multiple sessions is if you need to have
/// multiple independent authentication contexts. (Eg, you are
/// connecting to a server and authenticating as two different users at
/// different times; the easiest way to ensure that each `Message`
/// is sent with the authentication information you intended is to use
/// one session for the first user, and a second session for the other
/// user.)
///
/// Additional `soup.Session` functionality is provided by
/// `SessionFeature` objects, which can be added to a session with
/// `Session.addFeature` or `Session.addFeatureByType`
/// For example, `Logger` provides support for
/// logging HTTP traffic, `ContentDecoder` provides support for
/// compressed response handling, and `ContentSniffer` provides
/// support for HTML5-style response body content sniffing.
/// Additionally, subtypes of `Auth` can be added
/// as features, to add support for additional authentication types.
///
/// All `SoupSession`s are created with a `AuthManager`, and support
/// for `SOUP_TYPE_AUTH_BASIC` and `SOUP_TYPE_AUTH_DIGEST`. Additionally,
/// sessions using the plain `soup.Session` class (rather than one of its deprecated
/// subtypes) have a `ContentDecoder` by default.
///
/// Note that all async methods will invoke their callbacks on the thread-default
/// context at the time of the function call.
pub const Session = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = soup.SessionClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const request_queued = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) void {
                return gobject.ext.as(Session.Class, p_class).f_request_queued.?(gobject.ext.as(Session, p_session), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) callconv(.c) void) void {
                gobject.ext.as(Session.Class, p_class).f_request_queued = @ptrCast(p_implementation);
            }
        };

        pub const request_unqueued = struct {
            pub fn call(p_class: anytype, p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) void {
                return gobject.ext.as(Session.Class, p_class).f_request_unqueued.?(gobject.ext.as(Session, p_session), p_msg);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_session: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_msg: *soup.Message) callconv(.c) void) void {
                gobject.ext.as(Session.Class, p_class).f_request_unqueued = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// If non-`NULL`, the value to use for the "Accept-Language" header
        /// on `Message`s sent from this session.
        ///
        /// Setting this will disable `Session.properties.accept_language_auto`.
        pub const accept_language = struct {
            pub const name = "accept-language";

            pub const Type = ?[*:0]u8;
        };

        /// If `TRUE`, `soup.Session` will automatically set the string
        /// for the "Accept-Language" header on every `Message`
        /// sent, based on the return value of `glib.getLanguageNames`.
        ///
        /// Setting this will override any previous value of
        /// `Session.properties.accept_language`.
        pub const accept_language_auto = struct {
            pub const name = "accept-language-auto";

            pub const Type = c_int;
        };

        /// Connection lifetime (in seconds) when idle. Any connection
        /// left idle longer than this will be closed.
        ///
        /// Although you can change this property at any time, it will
        /// only affect newly-created connections, not currently-open
        /// ones. You can call `Session.abort` after setting this
        /// if you want to ensure that all future connections will have
        /// this timeout value.
        pub const idle_timeout = struct {
            pub const name = "idle-timeout";

            pub const Type = c_uint;
        };

        /// Sets the `gio.InetSocketAddress` to use for the client side of
        /// the connection.
        ///
        /// Use this property if you want for instance to bind the
        /// local socket to a specific IP address.
        pub const local_address = struct {
            pub const name = "local-address";

            pub const Type = ?*gio.InetSocketAddress;
        };

        /// The maximum number of connections that the session can open at once.
        pub const max_conns = struct {
            pub const name = "max-conns";

            pub const Type = c_int;
        };

        /// The maximum number of connections that the session can open at once
        /// to a given host.
        pub const max_conns_per_host = struct {
            pub const name = "max-conns-per-host";

            pub const Type = c_int;
        };

        /// A `gio.ProxyResolver` to use with this session.
        ///
        /// If no proxy resolver is set, then the default proxy resolver
        /// will be used. See `gio.ProxyResolver.getDefault`.
        /// You can set it to `NULL` if you don't want to use proxies, or
        /// set it to your own `gio.ProxyResolver` if you want to control
        /// what proxies get used.
        pub const proxy_resolver = struct {
            pub const name = "proxy-resolver";

            pub const Type = ?*gio.ProxyResolver;
        };

        /// Sets a socket to make outgoing connections on. This will override the default
        /// behaviour of opening TCP/IP sockets to the hosts specified in the URIs.
        ///
        /// This function is not required for common HTTP usage, but only when connecting
        /// to a HTTP service that is not using standard TCP/IP sockets. An example of
        /// this is a local service that uses HTTP over UNIX-domain sockets, in that case
        /// a `gio.UnixSocketAddress` can be passed to this function.
        pub const remote_connectable = struct {
            pub const name = "remote-connectable";

            pub const Type = ?*gio.SocketConnectable;
        };

        /// The timeout (in seconds) for socket I/O operations
        /// (including connecting to a server, and waiting for a reply
        /// to an HTTP request).
        ///
        /// Although you can change this property at any time, it will
        /// only affect newly-created connections, not currently-open
        /// ones. You can call `Session.abort` after setting this
        /// if you want to ensure that all future connections will have
        /// this timeout value.
        ///
        /// Not to be confused with `Session.properties.idle_timeout` (which is
        /// the length of time that idle persistent connections will be
        /// kept open).
        pub const timeout = struct {
            pub const name = "timeout";

            pub const Type = c_uint;
        };

        /// Sets the `gio.TlsDatabase` to use for validating SSL/TLS
        /// certificates.
        ///
        /// If no certificate database is set, then the default database will be
        /// used. See `gio.TlsBackend.getDefaultDatabase`.
        pub const tls_database = struct {
            pub const name = "tls-database";

            pub const Type = ?*gio.TlsDatabase;
        };

        /// A `gio.TlsInteraction` object that will be passed on to any
        /// `gio.TlsConnection`s created by the session.
        ///
        /// This can be used to provide client-side certificates, for example.
        pub const tls_interaction = struct {
            pub const name = "tls-interaction";

            pub const Type = ?*gio.TlsInteraction;
        };

        /// User-Agent string.
        ///
        /// If non-`NULL`, the value to use for the "User-Agent" header
        /// on `Message`s sent from this session.
        ///
        /// RFC 2616 says: "The User-Agent request-header field
        /// contains information about the user agent originating the
        /// request. This is for statistical purposes, the tracing of
        /// protocol violations, and automated recognition of user
        /// agents for the sake of tailoring responses to avoid
        /// particular user agent limitations. User agents SHOULD
        /// include this field with requests."
        ///
        /// The User-Agent header contains a list of one or more
        /// product tokens, separated by whitespace, with the most
        /// significant product token coming first. The tokens must be
        /// brief, ASCII, and mostly alphanumeric (although "-", "_",
        /// and "." are also allowed), and may optionally include a "/"
        /// followed by a version string. You may also put comments,
        /// enclosed in parentheses, between or after the tokens.
        ///
        /// If you set a `Session.properties.user_agent` property that has trailing
        /// whitespace, `soup.Session` will append its own product token
        /// (eg, `libsoup/2.3.2`) to the end of the
        /// header for you.
        pub const user_agent = struct {
            pub const name = "user-agent";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when a request is queued on `session`.
        ///
        /// When sending a request, first `Session.signals.request_queued`
        /// is emitted, indicating that the session has become aware of
        /// the request.
        ///
        /// After a connection is available to send the request various
        /// `Message` signals are emitted as the message is
        /// processed. If the message is requeued, it will emit
        /// `Message.signals.restarted`, which will then be followed by other
        /// `Message` signals when the message is re-sent.
        ///
        /// Eventually, the message will emit `Message.signals.finished`.
        /// Normally, this signals the completion of message
        /// processing. However, it is possible that the application
        /// will requeue the message from the "finished" handler.
        /// In that case the process will loop back.
        ///
        /// Eventually, a message will reach "finished" and not be
        /// requeued. At that point, the session will emit
        /// `Session.signals.request_unqueued` to indicate that it is done
        /// with the message.
        ///
        /// To sum up: `Session.signals.request_queued` and
        /// `Session.signals.request_unqueued` are guaranteed to be emitted
        /// exactly once, but `Message.signals.finished` (and all of the other
        /// `Message` signals) may be invoked multiple times for a given
        /// message.
        pub const request_queued = struct {
            pub const name = "request-queued";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_msg: *soup.Message, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Session, p_instance))),
                    gobject.signalLookup("request-queued", Session.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a request is removed from `session`'s queue,
        /// indicating that `session` is done with it.
        ///
        /// See `Session.signals.request_queued` for a detailed description of
        /// the message lifecycle within a session.
        pub const request_unqueued = struct {
            pub const name = "request-unqueued";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_msg: *soup.Message, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Session, p_instance))),
                    gobject.signalLookup("request-unqueued", Session.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a `soup.Session` with the default options.
    extern fn soup_session_new() *soup.Session;
    pub const new = soup_session_new;

    /// Creates a `soup.Session` with the specified options.
    extern fn soup_session_new_with_options(p_optname1: [*:0]const u8, ...) *soup.Session;
    pub const newWithOptions = soup_session_new_with_options;

    /// Cancels all pending requests in `session` and closes all idle
    /// persistent connections.
    extern fn soup_session_abort(p_session: *Session) void;
    pub const abort = soup_session_abort;

    /// Adds `feature`'s functionality to `session`. You cannot add multiple
    /// features of the same `gobject.Type` to a session.
    ///
    /// See the main `soup.Session` documentation for information on what
    /// features are present in sessions by default.
    extern fn soup_session_add_feature(p_session: *Session, p_feature: *soup.SessionFeature) void;
    pub const addFeature = soup_session_add_feature;

    /// If `feature_type` is the type of a class that implements
    /// `SessionFeature`, this creates a new feature of that type and
    /// adds it to `session` as with `Session.addFeature`. You can use
    /// this when you don't need to customize the new feature in any way.
    /// Adding multiple features of the same `feature_type` is not allowed.
    ///
    /// If `feature_type` is not a `SessionFeature` type, this gives each
    /// existing feature on `session` the chance to accept `feature_type` as
    /// a "subfeature". This can be used to add new `Auth` types, for instance.
    ///
    /// See the main `soup.Session` documentation for information on what
    /// features are present in sessions by default.
    extern fn soup_session_add_feature_by_type(p_session: *Session, p_feature_type: usize) void;
    pub const addFeatureByType = soup_session_add_feature_by_type;

    /// Get the value used by `session` for the "Accept-Language" header on new
    /// requests.
    extern fn soup_session_get_accept_language(p_session: *Session) ?[*:0]const u8;
    pub const getAcceptLanguage = soup_session_get_accept_language;

    /// Gets whether `session` automatically sets the "Accept-Language" header on new
    /// requests.
    extern fn soup_session_get_accept_language_auto(p_session: *Session) c_int;
    pub const getAcceptLanguageAuto = soup_session_get_accept_language_auto;

    /// Gets the `Message` of the `result` asynchronous operation This is useful
    /// to get the `Message` of an asynchronous operation started by `session`
    /// from its `gio.AsyncReadyCallback`.
    extern fn soup_session_get_async_result_message(p_session: *Session, p_result: *gio.AsyncResult) ?*soup.Message;
    pub const getAsyncResultMessage = soup_session_get_async_result_message;

    /// Gets the feature in `session` of type `feature_type`.
    extern fn soup_session_get_feature(p_session: *Session, p_feature_type: usize) ?*soup.SessionFeature;
    pub const getFeature = soup_session_get_feature;

    /// Gets the feature in `session` of type `feature_type`, provided
    /// that it is not disabled for `msg`.
    extern fn soup_session_get_feature_for_message(p_session: *Session, p_feature_type: usize, p_msg: *soup.Message) ?*soup.SessionFeature;
    pub const getFeatureForMessage = soup_session_get_feature_for_message;

    /// Get the timeout in seconds for idle connection lifetime currently used by
    /// `session`.
    extern fn soup_session_get_idle_timeout(p_session: *Session) c_uint;
    pub const getIdleTimeout = soup_session_get_idle_timeout;

    /// Get the `gio.InetSocketAddress` to use for the client side of
    /// connections in `session`.
    extern fn soup_session_get_local_address(p_session: *Session) ?*gio.InetSocketAddress;
    pub const getLocalAddress = soup_session_get_local_address;

    /// Get the maximum number of connections that `session` can open at once.
    extern fn soup_session_get_max_conns(p_session: *Session) c_uint;
    pub const getMaxConns = soup_session_get_max_conns;

    /// Get the maximum number of connections that `session` can open at once to a
    /// given host.
    extern fn soup_session_get_max_conns_per_host(p_session: *Session) c_uint;
    pub const getMaxConnsPerHost = soup_session_get_max_conns_per_host;

    /// Get the `gio.ProxyResolver` currently used by `session`.
    extern fn soup_session_get_proxy_resolver(p_session: *Session) ?*gio.ProxyResolver;
    pub const getProxyResolver = soup_session_get_proxy_resolver;

    /// Gets the remote connectable if one set.
    extern fn soup_session_get_remote_connectable(p_session: *Session) ?*gio.SocketConnectable;
    pub const getRemoteConnectable = soup_session_get_remote_connectable;

    /// Get the timeout in seconds for socket I/O operations currently used by
    /// `session`.
    extern fn soup_session_get_timeout(p_session: *Session) c_uint;
    pub const getTimeout = soup_session_get_timeout;

    /// Get the `gio.TlsDatabase` currently used by `session`.
    extern fn soup_session_get_tls_database(p_session: *Session) ?*gio.TlsDatabase;
    pub const getTlsDatabase = soup_session_get_tls_database;

    /// Get the `gio.TlsInteraction` currently used by `session`.
    extern fn soup_session_get_tls_interaction(p_session: *Session) ?*gio.TlsInteraction;
    pub const getTlsInteraction = soup_session_get_tls_interaction;

    /// Get the value used by `session` for the "User-Agent" header on new requests.
    extern fn soup_session_get_user_agent(p_session: *Session) ?[*:0]const u8;
    pub const getUserAgent = soup_session_get_user_agent;

    /// Tests if `session` has at a feature of type `feature_type` (which can
    /// be the type of either a `SessionFeature`, or else a subtype of
    /// some class managed by another feature, such as `Auth`).
    extern fn soup_session_has_feature(p_session: *Session, p_feature_type: usize) c_int;
    pub const hasFeature = soup_session_has_feature;

    /// Start a preconnection to `msg`.
    ///
    /// Once the connection is done, it will remain in idle state so that it can be
    /// reused by future requests. If there's already an idle connection for the
    /// given `msg` host, the operation finishes successfully without creating a new
    /// connection. If a new request for the given `msg` host is made while the
    /// preconnect is still ongoing, the request will take the ownership of the
    /// connection and the preconnect operation will finish successfully (if there's
    /// a connection error it will be handled by the request).
    ///
    /// The operation finishes when the connection is done or an error occurred.
    extern fn soup_session_preconnect_async(p_session: *Session, p_msg: *soup.Message, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const preconnectAsync = soup_session_preconnect_async;

    /// Complete a preconnect async operation started with `Session.preconnectAsync`.
    extern fn soup_session_preconnect_finish(p_session: *Session, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const preconnectFinish = soup_session_preconnect_finish;

    /// Removes `feature`'s functionality from `session`.
    extern fn soup_session_remove_feature(p_session: *Session, p_feature: *soup.SessionFeature) void;
    pub const removeFeature = soup_session_remove_feature;

    /// Removes all features of type `feature_type` (or any subclass of
    /// `feature_type`) from `session`.
    extern fn soup_session_remove_feature_by_type(p_session: *Session, p_feature_type: usize) void;
    pub const removeFeatureByType = soup_session_remove_feature_by_type;

    /// Synchronously sends `msg` and waits for the beginning of a response.
    ///
    /// On success, a `gio.InputStream` will be returned which you can use to
    /// read the response body. ("Success" here means only that an HTTP
    /// response was received and understood; it does not necessarily mean
    /// that a 2xx class status code was received.)
    ///
    /// If non-`NULL`, `cancellable` can be used to cancel the request;
    /// `Session.send` will return a `G_IO_ERROR_CANCELLED` error. Note that
    /// with requests that have side effects (eg, `POST`, `PUT`, `DELETE`) it is
    /// possible that you might cancel the request after the server acts on it, but
    /// before it returns a response, leaving the remote resource in an unknown
    /// state.
    ///
    /// If `msg` is requeued due to a redirect or authentication, the
    /// initial (`3xx/401/407`) response body will be suppressed, and
    /// `Session.send` will only return once a final response has been
    /// received.
    ///
    /// Possible error domains include `SessionError`, `gio.IOErrorEnum`,
    /// and `gio.TlsError` which you may want to specifically handle.
    extern fn soup_session_send(p_session: *Session, p_msg: *soup.Message, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*gio.InputStream;
    pub const send = soup_session_send;

    /// Synchronously sends `msg` and reads the response body.
    ///
    /// On success, a `glib.Bytes` will be returned with the response body.
    /// This function should only be used when the resource to be retrieved
    /// is not too long and can be stored in memory.
    ///
    /// See `Session.send` for more details on the general semantics.
    extern fn soup_session_send_and_read(p_session: *Session, p_msg: *soup.Message, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*glib.Bytes;
    pub const sendAndRead = soup_session_send_and_read;

    /// Asynchronously sends `msg` and reads the response body.
    ///
    /// When `callback` is called, then either `msg` has been sent, and its response
    /// body read, or else an error has occurred. This function should only be used
    /// when the resource to be retrieved is not too long and can be stored in
    /// memory. Call `Session.sendAndReadFinish` to get a
    /// `glib.Bytes` with the response body.
    ///
    /// See `Session.send` for more details on the general semantics.
    extern fn soup_session_send_and_read_async(p_session: *Session, p_msg: *soup.Message, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const sendAndReadAsync = soup_session_send_and_read_async;

    /// Gets the response to a `Session.sendAndReadAsync`.
    ///
    /// If successful, returns a `glib.Bytes` with the response body.
    extern fn soup_session_send_and_read_finish(p_session: *Session, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*glib.Bytes;
    pub const sendAndReadFinish = soup_session_send_and_read_finish;

    /// Synchronously sends `msg` and splices the response body stream into `out_stream`.
    ///
    /// See `Session.send` for more details on the general semantics.
    extern fn soup_session_send_and_splice(p_session: *Session, p_msg: *soup.Message, p_out_stream: *gio.OutputStream, p_flags: gio.OutputStreamSpliceFlags, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) isize;
    pub const sendAndSplice = soup_session_send_and_splice;

    /// Asynchronously sends `msg` and splices the response body stream into `out_stream`.
    /// When `callback` is called, then either `msg` has been sent and its response body
    /// spliced, or else an error has occurred.
    ///
    /// See `Session.send` for more details on the general semantics.
    extern fn soup_session_send_and_splice_async(p_session: *Session, p_msg: *soup.Message, p_out_stream: *gio.OutputStream, p_flags: gio.OutputStreamSpliceFlags, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const sendAndSpliceAsync = soup_session_send_and_splice_async;

    /// Gets the response to a `Session.sendAndSpliceAsync`.
    extern fn soup_session_send_and_splice_finish(p_session: *Session, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) isize;
    pub const sendAndSpliceFinish = soup_session_send_and_splice_finish;

    /// Asynchronously sends `msg` and waits for the beginning of a response.
    ///
    /// When `callback` is called, then either `msg` has been sent, and its response
    /// headers received, or else an error has occurred. Call
    /// `Session.sendFinish` to get a `gio.InputStream` for reading the
    /// response body.
    ///
    /// See `Session.send` for more details on the general semantics.
    extern fn soup_session_send_async(p_session: *Session, p_msg: *soup.Message, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const sendAsync = soup_session_send_async;

    /// Gets the response to a `Session.sendAsync` call.
    ///
    /// If successful returns a `gio.InputStream` that can be used to read the
    /// response body.
    extern fn soup_session_send_finish(p_session: *Session, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*gio.InputStream;
    pub const sendFinish = soup_session_send_finish;

    /// Set the value to use for the "Accept-Language" header on `Message`s
    /// sent from `session`.
    ///
    /// If `accept_language` is `NULL` then no "Accept-Language" will be included in
    /// requests. See `Session.properties.accept_language` for more information.
    extern fn soup_session_set_accept_language(p_session: *Session, p_accept_language: [*:0]const u8) void;
    pub const setAcceptLanguage = soup_session_set_accept_language;

    /// Set whether `session` will automatically set the "Accept-Language" header on
    /// requests using a value generated from system languages based on
    /// `glib.getLanguageNames`.
    ///
    /// See `Session.properties.accept_language_auto` for more information.
    extern fn soup_session_set_accept_language_auto(p_session: *Session, p_accept_language_auto: c_int) void;
    pub const setAcceptLanguageAuto = soup_session_set_accept_language_auto;

    /// Set a timeout in seconds for idle connection lifetime to be used by `session`
    /// on new connections.
    ///
    /// See `Session.properties.idle_timeout` for more information.
    extern fn soup_session_set_idle_timeout(p_session: *Session, p_timeout: c_uint) void;
    pub const setIdleTimeout = soup_session_set_idle_timeout;

    /// Set a `gio.ProxyResolver` to be used by `session` on new connections.
    ///
    /// If `proxy_resolver` is `NULL` then no proxies will be used. See
    /// `Session.properties.proxy_resolver` for more information.
    extern fn soup_session_set_proxy_resolver(p_session: *Session, p_proxy_resolver: ?*gio.ProxyResolver) void;
    pub const setProxyResolver = soup_session_set_proxy_resolver;

    /// Set a timeout in seconds for socket I/O operations to be used by `session`
    /// on new connections.
    ///
    /// See `Session.properties.timeout` for more information.
    extern fn soup_session_set_timeout(p_session: *Session, p_timeout: c_uint) void;
    pub const setTimeout = soup_session_set_timeout;

    /// Set a `gio.TlsDatabase` to be used by `session` on new connections.
    ///
    /// If `tls_database` is `NULL` then certificate validation will always fail. See
    /// `Session.properties.tls_database` for more information.
    extern fn soup_session_set_tls_database(p_session: *Session, p_tls_database: ?*gio.TlsDatabase) void;
    pub const setTlsDatabase = soup_session_set_tls_database;

    /// Set a `gio.TlsInteraction` to be used by `session` on new connections.
    ///
    /// If `tls_interaction` is `NULL` then client certificate validation will always
    /// fail.
    ///
    /// See `Session.properties.tls_interaction` for more information.
    extern fn soup_session_set_tls_interaction(p_session: *Session, p_tls_interaction: ?*gio.TlsInteraction) void;
    pub const setTlsInteraction = soup_session_set_tls_interaction;

    /// Set the value to use for the "User-Agent" header on `Message`s sent
    /// from `session`.
    ///
    /// If `user_agent` has trailing whitespace, `session` will append its own product
    /// token (eg, `libsoup/3.0.0`) to the end of the header for you. If `user_agent`
    /// is `NULL` then no "User-Agent" will be included in requests. See
    /// `Session.properties.user_agent` for more information.
    extern fn soup_session_set_user_agent(p_session: *Session, p_user_agent: [*:0]const u8) void;
    pub const setUserAgent = soup_session_set_user_agent;

    /// Asynchronously creates a `WebsocketConnection` to communicate with a
    /// remote server.
    ///
    /// All necessary WebSocket-related headers will be added to `msg`, and
    /// it will then be sent and asynchronously processed normally
    /// (including handling of redirection and HTTP authentication).
    ///
    /// If the server returns "101 Switching Protocols", then `msg`'s status
    /// code and response headers will be updated, and then the WebSocket
    /// handshake will be completed. On success,
    /// `Session.websocketConnectFinish` will return a new
    /// `WebsocketConnection`. On failure it will return a `glib.Error`.
    ///
    /// If the server returns a status other than "101 Switching Protocols", then
    /// `msg` will contain the complete response headers and body from the server's
    /// response, and `Session.websocketConnectFinish` will return
    /// `SOUP_WEBSOCKET_ERROR_NOT_WEBSOCKET`.
    extern fn soup_session_websocket_connect_async(p_session: *Session, p_msg: *soup.Message, p_origin: ?[*:0]const u8, p_protocols: ?[*][*:0]u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const websocketConnectAsync = soup_session_websocket_connect_async;

    /// Gets the `WebsocketConnection` response to a
    /// `Session.websocketConnectAsync` call.
    ///
    /// If successful, returns a `WebsocketConnection` that can be used to
    /// communicate with the server.
    extern fn soup_session_websocket_connect_finish(p_session: *Session, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*soup.WebsocketConnection;
    pub const websocketConnectFinish = soup_session_websocket_connect_finish;

    extern fn soup_session_get_type() usize;
    pub const getGObjectType = soup_session_get_type;

    extern fn g_object_ref(p_self: *soup.Session) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.Session) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Session, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The WebSocket Protocol
///
/// Provides support for the [WebSocket](http://tools.ietf.org/html/rfc6455)
/// protocol.
///
/// To connect to a WebSocket server, create a `Session` and call
/// `Session.websocketConnectAsync`. To accept WebSocket
/// connections, create a `Server` and add a handler to it with
/// `Server.addWebsocketHandler`.
///
/// (Lower-level support is available via
/// `websocketClientPrepareHandshake` and
/// `websocketClientVerifyHandshake`, for handling the client side of the
/// WebSocket handshake, and `websocketServerProcessHandshake` for
/// handling the server side.)
///
/// `soup.WebsocketConnection` handles the details of WebSocket communication. You
/// can use `WebsocketConnection.sendText` and
/// `WebsocketConnection.sendBinary` to send data, and the
/// `WebsocketConnection.signals.message` signal to receive data.
/// (`soup.WebsocketConnection` currently only supports asynchronous I/O.)
pub const WebsocketConnection = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = soup.WebsocketConnectionClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The type of connection (client/server).
        pub const connection_type = struct {
            pub const name = "connection-type";

            pub const Type = soup.WebsocketConnectionType;
        };

        /// List of `WebsocketExtension` objects that are active in the connection.
        pub const extensions = struct {
            pub const name = "extensions";

            pub const Type = ?*anyopaque;
        };

        /// The underlying IO stream the WebSocket is communicating
        /// over.
        ///
        /// The input and output streams must be pollable streams.
        pub const io_stream = struct {
            pub const name = "io-stream";

            pub const Type = ?*gio.IOStream;
        };

        /// Interval in seconds on when to send a ping message which will
        /// serve as a keepalive message.
        ///
        /// If set to 0 the keepalive message is disabled.
        pub const keepalive_interval = struct {
            pub const name = "keepalive-interval";

            pub const Type = c_uint;
        };

        /// Timeout in seconds for when the absence of a pong from a keepalive
        /// ping is assumed to be caused by a faulty connection. The WebSocket
        /// will be transitioned to a closed state when this happens.
        ///
        /// If set to 0 then the absence of pongs from keepalive pings is
        /// ignored.
        pub const keepalive_pong_timeout = struct {
            pub const name = "keepalive-pong-timeout";

            pub const Type = c_uint;
        };

        /// The maximum payload size for incoming packets.
        ///
        /// The protocol expects or 0 to not limit it.
        pub const max_incoming_payload_size = struct {
            pub const name = "max-incoming-payload-size";

            pub const Type = u64;
        };

        /// The client's Origin.
        pub const origin = struct {
            pub const name = "origin";

            pub const Type = ?[*:0]u8;
        };

        /// The chosen protocol, or `NULL` if a protocol was not agreed
        /// upon.
        pub const protocol = struct {
            pub const name = "protocol";

            pub const Type = ?[*:0]u8;
        };

        /// The current state of the WebSocket.
        pub const state = struct {
            pub const name = "state";

            pub const Type = soup.WebsocketState;
        };

        /// The URI of the WebSocket.
        ///
        /// For servers this represents the address of the WebSocket,
        /// and for clients it is the address connected to.
        pub const uri = struct {
            pub const name = "uri";

            pub const Type = ?*glib.Uri;
        };
    };

    pub const signals = struct {
        /// Emitted when the connection has completely closed.
        ///
        /// This happens either due to an orderly close from the peer, one
        /// initiated via `WebsocketConnection.close` or a fatal error
        /// condition that caused a close.
        ///
        /// This signal will be emitted once.
        pub const closed = struct {
            pub const name = "closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(WebsocketConnection, p_instance))),
                    gobject.signalLookup("closed", WebsocketConnection.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal will be emitted during an orderly close.
        pub const closing = struct {
            pub const name = "closing";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(WebsocketConnection, p_instance))),
                    gobject.signalLookup("closing", WebsocketConnection.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an error occurred on the WebSocket.
        ///
        /// This may be fired multiple times. Fatal errors will be followed by
        /// the `WebsocketConnection.signals.closed` signal being emitted.
        pub const @"error" = struct {
            pub const name = "error";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_error: *glib.Error, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(WebsocketConnection, p_instance))),
                    gobject.signalLookup("error", WebsocketConnection.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when we receive a message from the peer.
        ///
        /// As a convenience, the `message` data will always be
        /// `NULL`-terminated, but the NUL byte will not be included in
        /// the length count.
        pub const message = struct {
            pub const name = "message";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_type: c_int, p_message: *glib.Bytes, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(WebsocketConnection, p_instance))),
                    gobject.signalLookup("message", WebsocketConnection.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when we receive a Pong frame (solicited or
        /// unsolicited) from the peer.
        ///
        /// As a convenience, the `message` data will always be
        /// `NULL`-terminated, but the NUL byte will not be included in
        /// the length count.
        pub const pong = struct {
            pub const name = "pong";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_message: *glib.Bytes, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(WebsocketConnection, p_instance))),
                    gobject.signalLookup("pong", WebsocketConnection.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a `soup.WebsocketConnection` on `stream` with the given active `extensions`.
    ///
    /// This should be called after completing the handshake to begin using the WebSocket
    /// protocol.
    extern fn soup_websocket_connection_new(p_stream: *gio.IOStream, p_uri: *glib.Uri, p_type: soup.WebsocketConnectionType, p_origin: ?[*:0]const u8, p_protocol: ?[*:0]const u8, p_extensions: *glib.List) *soup.WebsocketConnection;
    pub const new = soup_websocket_connection_new;

    /// Close the connection in an orderly fashion.
    ///
    /// Note that until the `WebsocketConnection.signals.closed` signal fires, the connection
    /// is not yet completely closed. The close message is not even sent until the
    /// main loop runs.
    ///
    /// The `code` and `data` are sent to the peer along with the close request.
    /// If `code` is `SOUP_WEBSOCKET_CLOSE_NO_STATUS` a close message with no body
    /// (without code and data) is sent.
    /// Note that the `data` must be UTF-8 valid.
    extern fn soup_websocket_connection_close(p_self: *WebsocketConnection, p_code: c_ushort, p_data: ?[*:0]const u8) void;
    pub const close = soup_websocket_connection_close;

    /// Get the close code received from the WebSocket peer.
    ///
    /// This only becomes valid once the WebSocket is in the
    /// `SOUP_WEBSOCKET_STATE_CLOSED` state. The value will often be in the
    /// `WebsocketCloseCode` enumeration, but may also be an application
    /// defined close code.
    extern fn soup_websocket_connection_get_close_code(p_self: *WebsocketConnection) c_ushort;
    pub const getCloseCode = soup_websocket_connection_get_close_code;

    /// Get the close data received from the WebSocket peer.
    ///
    /// This only becomes valid once the WebSocket is in the
    /// `SOUP_WEBSOCKET_STATE_CLOSED` state. The data may be freed once
    /// the main loop is run, so copy it if you need to keep it around.
    extern fn soup_websocket_connection_get_close_data(p_self: *WebsocketConnection) [*:0]const u8;
    pub const getCloseData = soup_websocket_connection_get_close_data;

    /// Get the connection type (client/server) of the connection.
    extern fn soup_websocket_connection_get_connection_type(p_self: *WebsocketConnection) soup.WebsocketConnectionType;
    pub const getConnectionType = soup_websocket_connection_get_connection_type;

    /// Get the extensions chosen via negotiation with the peer.
    extern fn soup_websocket_connection_get_extensions(p_self: *WebsocketConnection) *glib.List;
    pub const getExtensions = soup_websocket_connection_get_extensions;

    /// Get the I/O stream the WebSocket is communicating over.
    extern fn soup_websocket_connection_get_io_stream(p_self: *WebsocketConnection) *gio.IOStream;
    pub const getIoStream = soup_websocket_connection_get_io_stream;

    /// Gets the keepalive interval in seconds or 0 if disabled.
    extern fn soup_websocket_connection_get_keepalive_interval(p_self: *WebsocketConnection) c_uint;
    pub const getKeepaliveInterval = soup_websocket_connection_get_keepalive_interval;

    /// Gets the keepalive pong timeout in seconds or 0 if disabled.
    extern fn soup_websocket_connection_get_keepalive_pong_timeout(p_self: *WebsocketConnection) c_uint;
    pub const getKeepalivePongTimeout = soup_websocket_connection_get_keepalive_pong_timeout;

    /// Gets the maximum payload size allowed for incoming packets.
    extern fn soup_websocket_connection_get_max_incoming_payload_size(p_self: *WebsocketConnection) u64;
    pub const getMaxIncomingPayloadSize = soup_websocket_connection_get_max_incoming_payload_size;

    /// Get the origin of the WebSocket.
    extern fn soup_websocket_connection_get_origin(p_self: *WebsocketConnection) ?[*:0]const u8;
    pub const getOrigin = soup_websocket_connection_get_origin;

    /// Get the protocol chosen via negotiation with the peer.
    extern fn soup_websocket_connection_get_protocol(p_self: *WebsocketConnection) ?[*:0]const u8;
    pub const getProtocol = soup_websocket_connection_get_protocol;

    /// Get the current state of the WebSocket.
    extern fn soup_websocket_connection_get_state(p_self: *WebsocketConnection) soup.WebsocketState;
    pub const getState = soup_websocket_connection_get_state;

    /// Get the URI of the WebSocket.
    ///
    /// For servers this represents the address of the WebSocket, and
    /// for clients it is the address connected to.
    extern fn soup_websocket_connection_get_uri(p_self: *WebsocketConnection) *glib.Uri;
    pub const getUri = soup_websocket_connection_get_uri;

    /// Send a binary message to the peer.
    ///
    /// If `length` is 0, `data` may be `NULL`.
    ///
    /// The message is queued to be sent and will be sent when the main loop
    /// is run.
    extern fn soup_websocket_connection_send_binary(p_self: *WebsocketConnection, p_data: ?[*]const u8, p_length: usize) void;
    pub const sendBinary = soup_websocket_connection_send_binary;

    /// Send a message of the given `type` to the peer. Note that this method,
    /// allows to send text messages containing `NULL` characters.
    ///
    /// The message is queued to be sent and will be sent when the main loop
    /// is run.
    extern fn soup_websocket_connection_send_message(p_self: *WebsocketConnection, p_type: soup.WebsocketDataType, p_message: *glib.Bytes) void;
    pub const sendMessage = soup_websocket_connection_send_message;

    /// Send a `NULL`-terminated text (UTF-8) message to the peer.
    ///
    /// If you need to send text messages containing `NULL` characters use
    /// `WebsocketConnection.sendMessage` instead.
    ///
    /// The message is queued to be sent and will be sent when the main loop
    /// is run.
    extern fn soup_websocket_connection_send_text(p_self: *WebsocketConnection, p_text: [*:0]const u8) void;
    pub const sendText = soup_websocket_connection_send_text;

    /// Sets the interval in seconds on when to send a ping message which will serve
    /// as a keepalive message.
    ///
    /// If set to 0 the keepalive message is disabled.
    extern fn soup_websocket_connection_set_keepalive_interval(p_self: *WebsocketConnection, p_interval: c_uint) void;
    pub const setKeepaliveInterval = soup_websocket_connection_set_keepalive_interval;

    /// Set the timeout in seconds for when the absence of a pong from a keepalive
    /// ping is assumed to be caused by a faulty connection.
    ///
    /// If set to 0 then the absence of pongs from keepalive pings is ignored.
    extern fn soup_websocket_connection_set_keepalive_pong_timeout(p_self: *WebsocketConnection, p_pong_timeout: c_uint) void;
    pub const setKeepalivePongTimeout = soup_websocket_connection_set_keepalive_pong_timeout;

    /// Sets the maximum payload size allowed for incoming packets.
    ///
    /// It does not limit the outgoing packet size.
    extern fn soup_websocket_connection_set_max_incoming_payload_size(p_self: *WebsocketConnection, p_max_incoming_payload_size: u64) void;
    pub const setMaxIncomingPayloadSize = soup_websocket_connection_set_max_incoming_payload_size;

    extern fn soup_websocket_connection_get_type() usize;
    pub const getGObjectType = soup_websocket_connection_get_type;

    extern fn g_object_ref(p_self: *soup.WebsocketConnection) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.WebsocketConnection) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WebsocketConnection, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A WebSocket extension
///
/// `soup.WebsocketExtension` is the base class for WebSocket extension objects.
pub const WebsocketExtension = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = soup.WebsocketExtensionClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Configures `extension` with the given `params`.
        pub const configure = struct {
            pub fn call(p_class: anytype, p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_connection_type: soup.WebsocketConnectionType, p_params: ?*glib.HashTable, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(WebsocketExtension.Class, p_class).f_configure.?(gobject.ext.as(WebsocketExtension, p_extension), p_connection_type, p_params, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_connection_type: soup.WebsocketConnectionType, p_params: ?*glib.HashTable, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(WebsocketExtension.Class, p_class).f_configure = @ptrCast(p_implementation);
            }
        };

        /// Get the parameters strings to be included in the request header.
        ///
        /// If the extension doesn't include any parameter in the request, this function
        /// returns `NULL`.
        pub const get_request_params = struct {
            pub fn call(p_class: anytype, p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?[*:0]u8 {
                return gobject.ext.as(WebsocketExtension.Class, p_class).f_get_request_params.?(gobject.ext.as(WebsocketExtension, p_extension));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(WebsocketExtension.Class, p_class).f_get_request_params = @ptrCast(p_implementation);
            }
        };

        /// Get the parameters strings to be included in the response header.
        ///
        /// If the extension doesn't include any parameter in the response, this function
        /// returns `NULL`.
        pub const get_response_params = struct {
            pub fn call(p_class: anytype, p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?[*:0]u8 {
                return gobject.ext.as(WebsocketExtension.Class, p_class).f_get_response_params.?(gobject.ext.as(WebsocketExtension, p_extension));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(WebsocketExtension.Class, p_class).f_get_response_params = @ptrCast(p_implementation);
            }
        };

        /// Process a message after it's received.
        ///
        /// If the payload isn't changed the given `payload` is just returned, otherwise
        /// `glib.Bytes.unref` is called on the given `payload` and a new
        /// `glib.Bytes` is returned with the new data.
        ///
        /// Extensions using reserved bits of the header will reset them in `header`.
        pub const process_incoming_message = struct {
            pub fn call(p_class: anytype, p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_header: *u8, p_payload: *glib.Bytes, p_error: ?*?*glib.Error) ?*glib.Bytes {
                return gobject.ext.as(WebsocketExtension.Class, p_class).f_process_incoming_message.?(gobject.ext.as(WebsocketExtension, p_extension), p_header, p_payload, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_header: *u8, p_payload: *glib.Bytes, p_error: ?*?*glib.Error) callconv(.c) ?*glib.Bytes) void {
                gobject.ext.as(WebsocketExtension.Class, p_class).f_process_incoming_message = @ptrCast(p_implementation);
            }
        };

        /// Process a message before it's sent.
        ///
        /// If the payload isn't changed the given `payload` is just returned, otherwise
        /// `glib.Bytes.unref` is called on the given `payload` and a new
        /// `glib.Bytes` is returned with the new data.
        ///
        /// Extensions using reserved bits of the header will change them in `header`.
        pub const process_outgoing_message = struct {
            pub fn call(p_class: anytype, p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_header: *u8, p_payload: *glib.Bytes, p_error: ?*?*glib.Error) ?*glib.Bytes {
                return gobject.ext.as(WebsocketExtension.Class, p_class).f_process_outgoing_message.?(gobject.ext.as(WebsocketExtension, p_extension), p_header, p_payload, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_extension: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_header: *u8, p_payload: *glib.Bytes, p_error: ?*?*glib.Error) callconv(.c) ?*glib.Bytes) void {
                gobject.ext.as(WebsocketExtension.Class, p_class).f_process_outgoing_message = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Configures `extension` with the given `params`.
    extern fn soup_websocket_extension_configure(p_extension: *WebsocketExtension, p_connection_type: soup.WebsocketConnectionType, p_params: ?*glib.HashTable, p_error: ?*?*glib.Error) c_int;
    pub const configure = soup_websocket_extension_configure;

    /// Get the parameters strings to be included in the request header.
    ///
    /// If the extension doesn't include any parameter in the request, this function
    /// returns `NULL`.
    extern fn soup_websocket_extension_get_request_params(p_extension: *WebsocketExtension) ?[*:0]u8;
    pub const getRequestParams = soup_websocket_extension_get_request_params;

    /// Get the parameters strings to be included in the response header.
    ///
    /// If the extension doesn't include any parameter in the response, this function
    /// returns `NULL`.
    extern fn soup_websocket_extension_get_response_params(p_extension: *WebsocketExtension) ?[*:0]u8;
    pub const getResponseParams = soup_websocket_extension_get_response_params;

    /// Process a message after it's received.
    ///
    /// If the payload isn't changed the given `payload` is just returned, otherwise
    /// `glib.Bytes.unref` is called on the given `payload` and a new
    /// `glib.Bytes` is returned with the new data.
    ///
    /// Extensions using reserved bits of the header will reset them in `header`.
    extern fn soup_websocket_extension_process_incoming_message(p_extension: *WebsocketExtension, p_header: *u8, p_payload: *glib.Bytes, p_error: ?*?*glib.Error) ?*glib.Bytes;
    pub const processIncomingMessage = soup_websocket_extension_process_incoming_message;

    /// Process a message before it's sent.
    ///
    /// If the payload isn't changed the given `payload` is just returned, otherwise
    /// `glib.Bytes.unref` is called on the given `payload` and a new
    /// `glib.Bytes` is returned with the new data.
    ///
    /// Extensions using reserved bits of the header will change them in `header`.
    extern fn soup_websocket_extension_process_outgoing_message(p_extension: *WebsocketExtension, p_header: *u8, p_payload: *glib.Bytes, p_error: ?*?*glib.Error) ?*glib.Bytes;
    pub const processOutgoingMessage = soup_websocket_extension_process_outgoing_message;

    extern fn soup_websocket_extension_get_type() usize;
    pub const getGObjectType = soup_websocket_extension_get_type;

    extern fn g_object_ref(p_self: *soup.WebsocketExtension) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.WebsocketExtension) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WebsocketExtension, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A SoupWebsocketExtensionDeflate is a `WebsocketExtension`
/// implementing permessage-deflate (RFC 7692).
///
/// This extension is used by default in a `Session` when `WebsocketExtensionManager`
/// feature is present, and always used by `Server`.
pub const WebsocketExtensionDeflate = opaque {
    pub const Parent = soup.WebsocketExtension;
    pub const Implements = [_]type{};
    pub const Class = soup.WebsocketExtensionDeflateClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn soup_websocket_extension_deflate_get_type() usize;
    pub const getGObjectType = soup_websocket_extension_deflate_get_type;

    extern fn g_object_ref(p_self: *soup.WebsocketExtensionDeflate) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.WebsocketExtensionDeflate) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WebsocketExtensionDeflate, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// SoupWebsocketExtensionManager is the `SessionFeature` that handles WebSockets
/// extensions for a `Session`.
///
/// A `soup.WebsocketExtensionManager` is added to the session by default, and normally
/// you don't need to worry about it at all. However, if you want to
/// disable WebSocket extensions, you can remove the feature from the
/// session with `Session.removeFeatureByType` or disable it on
/// individual requests with `Message.disableFeature`.
pub const WebsocketExtensionManager = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{soup.SessionFeature};
    pub const Class = soup.WebsocketExtensionManagerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn soup_websocket_extension_manager_get_type() usize;
    pub const getGObjectType = soup_websocket_extension_manager_get_type;

    extern fn g_object_ref(p_self: *soup.WebsocketExtensionManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.WebsocketExtensionManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WebsocketExtensionManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interface for miscellaneous `Session` features.
///
/// `soup.SessionFeature` is the interface used by classes that extend
/// the functionality of a `Session`. Some features like HTTP
/// authentication handling are implemented internally via
/// `SoupSessionFeature`s. Other features can be added to the session
/// by the application. (Eg, `Logger`, `CookieJar`.)
///
/// See `Session.addFeature`, etc, to add a feature to a session.
pub const SessionFeature = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = soup.SessionFeatureInterface;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn soup_session_feature_get_type() usize;
    pub const getGObjectType = soup_session_feature_get_type;

    extern fn g_object_ref(p_self: *soup.SessionFeature) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *soup.SessionFeature) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SessionFeature, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AuthClass = extern struct {
    pub const Instance = soup.Auth;

    f_parent_class: gobject.ObjectClass,
    f_scheme_name: ?[*:0]const u8,
    f_strength: c_uint,
    f_update: ?*const fn (p_auth: *soup.Auth, p_msg: *soup.Message, p_auth_header: *glib.HashTable) callconv(.c) c_int,
    f_get_protection_space: ?*const fn (p_auth: *soup.Auth, p_source_uri: *glib.Uri) callconv(.c) *glib.SList,
    f_authenticate: ?*const fn (p_auth: *soup.Auth, p_username: [*:0]const u8, p_password: [*:0]const u8) callconv(.c) void,
    f_is_authenticated: ?*const fn (p_auth: *soup.Auth) callconv(.c) c_int,
    f_get_authorization: ?*const fn (p_auth: *soup.Auth, p_msg: *soup.Message) callconv(.c) [*:0]u8,
    f_is_ready: ?*const fn (p_auth: *soup.Auth, p_msg: *soup.Message) callconv(.c) c_int,
    f_can_authenticate: ?*const fn (p_auth: *soup.Auth) callconv(.c) c_int,
    f_padding: [6]*anyopaque,

    pub fn as(p_instance: *AuthClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AuthDomainBasicClass = extern struct {
    pub const Instance = soup.AuthDomainBasic;

    f_parent_class: soup.AuthDomainClass,

    pub fn as(p_instance: *AuthDomainBasicClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AuthDomainClass = extern struct {
    pub const Instance = soup.AuthDomain;

    f_parent_class: gobject.ObjectClass,
    f_accepts: ?*const fn (p_domain: *soup.AuthDomain, p_msg: *soup.ServerMessage, p_header: [*:0]const u8) callconv(.c) [*:0]u8,
    f_challenge: ?*const fn (p_domain: *soup.AuthDomain, p_msg: *soup.ServerMessage) callconv(.c) [*:0]u8,
    f_check_password: ?*const fn (p_domain: *soup.AuthDomain, p_msg: *soup.ServerMessage, p_username: [*:0]const u8, p_password: [*:0]const u8) callconv(.c) c_int,
    f_padding: [6]*anyopaque,

    pub fn as(p_instance: *AuthDomainClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AuthDomainDigestClass = extern struct {
    pub const Instance = soup.AuthDomainDigest;

    f_parent_class: soup.AuthDomainClass,

    pub fn as(p_instance: *AuthDomainDigestClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AuthManagerClass = extern struct {
    pub const Instance = soup.AuthManager;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *AuthManagerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CacheClass = extern struct {
    pub const Instance = soup.Cache;

    f_parent_class: gobject.ObjectClass,
    f_get_cacheability: ?*const fn (p_cache: *soup.Cache, p_msg: *soup.Message) callconv(.c) soup.Cacheability,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *CacheClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContentDecoderClass = extern struct {
    pub const Instance = soup.ContentDecoder;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ContentDecoderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContentSnifferClass = extern struct {
    pub const Instance = soup.ContentSniffer;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ContentSnifferClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Implements HTTP cookies, as described by
/// [RFC 6265](http://tools.ietf.org/html/rfc6265.txt).
///
/// To have a `Session` handle cookies for your appliction
/// automatically, use a `CookieJar`.
///
/// `name` and `value` will be set for all cookies. If the cookie is
/// generated from a string that appears to have no name, then `name`
/// will be the empty string.
///
/// `domain` and `path` give the host or domain, and path within that
/// host/domain, to restrict this cookie to. If `domain` starts with
/// ".", that indicates a domain (which matches the string after the
/// ".", or any hostname that has `domain` as a suffix). Otherwise, it
/// is a hostname and must match exactly.
///
/// `expires` will be non-`NULL` if the cookie uses either the original
/// "expires" attribute, or the newer "max-age" attribute. If `expires`
/// is `NULL`, it indicates that neither "expires" nor "max-age" was
/// specified, and the cookie expires at the end of the session.
///
/// If `http_only` is set, the cookie should not be exposed to untrusted
/// code (eg, javascript), so as to minimize the danger posed by
/// cross-site scripting attacks.
pub const Cookie = opaque {
    /// Parses `header` and returns a `soup.Cookie`.
    ///
    /// If `header` contains multiple cookies, only the first one will be parsed.
    ///
    /// If `header` does not have "path" or "domain" attributes, they will
    /// be defaulted from `origin`. If `origin` is `NULL`, path will default
    /// to "/", but domain will be left as `NULL`. Note that this is not a
    /// valid state for a `soup.Cookie`, and you will need to fill in some
    /// appropriate string for the domain if you want to actually make use
    /// of the cookie.
    ///
    /// As of version 3.4.0 the default value of a cookie's same-site-policy
    /// is `SOUP_SAME_SITE_POLICY_LAX`.
    extern fn soup_cookie_parse(p_header: [*:0]const u8, p_origin: ?*glib.Uri) ?*soup.Cookie;
    pub const parse = soup_cookie_parse;

    /// Creates a new `soup.Cookie` with the given attributes.
    ///
    /// Use `Cookie.setSecure` and `Cookie.setHttpOnly` if you
    /// need to set those attributes on the returned cookie.
    ///
    /// If `domain` starts with ".", that indicates a domain (which matches
    /// the string after the ".", or any hostname that has `domain` as a
    /// suffix). Otherwise, it is a hostname and must match exactly.
    ///
    /// `max_age` is used to set the "expires" attribute on the cookie; pass
    /// -1 to not include the attribute (indicating that the cookie expires
    /// with the current session), 0 for an already-expired cookie, or a
    /// lifetime in seconds. You can use the constants
    /// `SOUP_COOKIE_MAX_AGE_ONE_HOUR`, `SOUP_COOKIE_MAX_AGE_ONE_DAY`,
    /// `SOUP_COOKIE_MAX_AGE_ONE_WEEK` and `SOUP_COOKIE_MAX_AGE_ONE_YEAR` (or
    /// multiples thereof) to calculate this value. (If you really care
    /// about setting the exact time that the cookie will expire, use
    /// `Cookie.setExpires`.)
    ///
    /// As of version 3.4.0 the default value of a cookie's same-site-policy
    /// is `SOUP_SAME_SITE_POLICY_LAX`.
    extern fn soup_cookie_new(p_name: [*:0]const u8, p_value: [*:0]const u8, p_domain: [*:0]const u8, p_path: [*:0]const u8, p_max_age: c_int) *soup.Cookie;
    pub const new = soup_cookie_new;

    /// Tests if `cookie` should be sent to `uri`.
    ///
    /// (At the moment, this does not check that `cookie`'s domain matches
    /// `uri`, because it assumes that the caller has already done that.
    /// But don't rely on that; it may change in the future.)
    extern fn soup_cookie_applies_to_uri(p_cookie: *Cookie, p_uri: *glib.Uri) c_int;
    pub const appliesToUri = soup_cookie_applies_to_uri;

    /// Copies `cookie`.
    extern fn soup_cookie_copy(p_cookie: *Cookie) *soup.Cookie;
    pub const copy = soup_cookie_copy;

    /// Checks if the `cookie`'s domain and `host` match.
    ///
    /// The domains match if `cookie` should be sent when making a request to `host`,
    /// or that `cookie` should be accepted when receiving a response from `host`.
    extern fn soup_cookie_domain_matches(p_cookie: *Cookie, p_host: [*:0]const u8) c_int;
    pub const domainMatches = soup_cookie_domain_matches;

    /// Tests if `cookie1` and `cookie2` are equal.
    ///
    /// Note that currently, this does not check that the cookie domains
    /// match. This may change in the future.
    extern fn soup_cookie_equal(p_cookie1: *Cookie, p_cookie2: *soup.Cookie) c_int;
    pub const equal = soup_cookie_equal;

    /// Frees `cookie`.
    extern fn soup_cookie_free(p_cookie: *Cookie) void;
    pub const free = soup_cookie_free;

    /// Gets `cookie`'s domain.
    extern fn soup_cookie_get_domain(p_cookie: *Cookie) [*:0]const u8;
    pub const getDomain = soup_cookie_get_domain;

    /// Gets `cookie`'s expiration time.
    extern fn soup_cookie_get_expires(p_cookie: *Cookie) ?*glib.DateTime;
    pub const getExpires = soup_cookie_get_expires;

    /// Gets `cookie`'s HttpOnly attribute.
    extern fn soup_cookie_get_http_only(p_cookie: *Cookie) c_int;
    pub const getHttpOnly = soup_cookie_get_http_only;

    /// Gets `cookie`'s name.
    extern fn soup_cookie_get_name(p_cookie: *Cookie) [*:0]const u8;
    pub const getName = soup_cookie_get_name;

    /// Gets `cookie`'s path.
    extern fn soup_cookie_get_path(p_cookie: *Cookie) [*:0]const u8;
    pub const getPath = soup_cookie_get_path;

    /// Returns the same-site policy for this cookie.
    extern fn soup_cookie_get_same_site_policy(p_cookie: *Cookie) soup.SameSitePolicy;
    pub const getSameSitePolicy = soup_cookie_get_same_site_policy;

    /// Gets `cookie`'s secure attribute.
    extern fn soup_cookie_get_secure(p_cookie: *Cookie) c_int;
    pub const getSecure = soup_cookie_get_secure;

    /// Gets `cookie`'s value.
    extern fn soup_cookie_get_value(p_cookie: *Cookie) [*:0]const u8;
    pub const getValue = soup_cookie_get_value;

    /// Sets `cookie`'s domain to `domain`.
    extern fn soup_cookie_set_domain(p_cookie: *Cookie, p_domain: [*:0]const u8) void;
    pub const setDomain = soup_cookie_set_domain;

    /// Sets `cookie`'s expiration time to `expires`.
    ///
    /// If `expires` is `NULL`, `cookie` will be a session cookie and will expire at the
    /// end of the client's session.
    ///
    /// (This sets the same property as `Cookie.setMaxAge`.)
    extern fn soup_cookie_set_expires(p_cookie: *Cookie, p_expires: *glib.DateTime) void;
    pub const setExpires = soup_cookie_set_expires;

    /// Sets `cookie`'s HttpOnly attribute to `http_only`.
    ///
    /// If `TRUE`, `cookie` will be marked as "http only", meaning it should not be
    /// exposed to web page scripts or other untrusted code.
    extern fn soup_cookie_set_http_only(p_cookie: *Cookie, p_http_only: c_int) void;
    pub const setHttpOnly = soup_cookie_set_http_only;

    /// Sets `cookie`'s max age to `max_age`.
    ///
    /// If `max_age` is -1, the cookie is a session cookie, and will expire at the end
    /// of the client's session. Otherwise, it is the number of seconds until the
    /// cookie expires. You can use the constants `SOUP_COOKIE_MAX_AGE_ONE_HOUR`,
    /// `SOUP_COOKIE_MAX_AGE_ONE_DAY`, `SOUP_COOKIE_MAX_AGE_ONE_WEEK` and
    /// `SOUP_COOKIE_MAX_AGE_ONE_YEAR` (or multiples thereof) to calculate this value.
    /// (A value of 0 indicates that the cookie should be considered
    /// already-expired.)
    ///
    /// This sets the same property as `Cookie.setExpires`.
    extern fn soup_cookie_set_max_age(p_cookie: *Cookie, p_max_age: c_int) void;
    pub const setMaxAge = soup_cookie_set_max_age;

    /// Sets `cookie`'s name to `name`.
    extern fn soup_cookie_set_name(p_cookie: *Cookie, p_name: [*:0]const u8) void;
    pub const setName = soup_cookie_set_name;

    /// Sets `cookie`'s path to `path`.
    extern fn soup_cookie_set_path(p_cookie: *Cookie, p_path: [*:0]const u8) void;
    pub const setPath = soup_cookie_set_path;

    /// When used in conjunction with
    /// `CookieJar.getCookieListWithSameSiteInfo` this sets the policy
    /// of when this cookie should be exposed.
    extern fn soup_cookie_set_same_site_policy(p_cookie: *Cookie, p_policy: soup.SameSitePolicy) void;
    pub const setSameSitePolicy = soup_cookie_set_same_site_policy;

    /// Sets `cookie`'s secure attribute to `secure`.
    ///
    /// If `TRUE`, `cookie` will only be transmitted from the client to the server over
    /// secure (https) connections.
    extern fn soup_cookie_set_secure(p_cookie: *Cookie, p_secure: c_int) void;
    pub const setSecure = soup_cookie_set_secure;

    /// Sets `cookie`'s value to `value`.
    extern fn soup_cookie_set_value(p_cookie: *Cookie, p_value: [*:0]const u8) void;
    pub const setValue = soup_cookie_set_value;

    /// Serializes `cookie` in the format used by the Cookie header (ie, for
    /// returning a cookie from a `Session` to a server).
    extern fn soup_cookie_to_cookie_header(p_cookie: *Cookie) [*:0]u8;
    pub const toCookieHeader = soup_cookie_to_cookie_header;

    /// Serializes `cookie` in the format used by the Set-Cookie header.
    ///
    /// i.e. for sending a cookie from a `Server` to a client.
    extern fn soup_cookie_to_set_cookie_header(p_cookie: *Cookie) [*:0]u8;
    pub const toSetCookieHeader = soup_cookie_to_set_cookie_header;

    extern fn soup_cookie_get_type() usize;
    pub const getGObjectType = soup_cookie_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CookieJarClass = extern struct {
    pub const Instance = soup.CookieJar;

    f_parent_class: gobject.ObjectClass,
    f_save: ?*const fn (p_jar: *soup.CookieJar) callconv(.c) void,
    f_is_persistent: ?*const fn (p_jar: *soup.CookieJar) callconv(.c) c_int,
    f_changed: ?*const fn (p_jar: *soup.CookieJar, p_old_cookie: *soup.Cookie, p_new_cookie: *soup.Cookie) callconv(.c) void,
    f_padding: [6]*anyopaque,

    pub fn as(p_instance: *CookieJarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CookieJarDBClass = extern struct {
    pub const Instance = soup.CookieJarDB;

    f_parent_class: soup.CookieJarClass,

    pub fn as(p_instance: *CookieJarDBClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CookieJarTextClass = extern struct {
    pub const Instance = soup.CookieJarText;

    f_parent_class: soup.CookieJarClass,

    pub fn as(p_instance: *CookieJarTextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for `soup.HSTSEnforcer`.
pub const HSTSEnforcerClass = extern struct {
    pub const Instance = soup.HSTSEnforcer;

    /// The parent class.
    f_parent_class: gobject.ObjectClass,
    /// The `is_persistent` function advertises whether the enforcer is persistent or
    /// whether changes made to it will be lost when the underlying `Session` is finished.
    f_is_persistent: ?*const fn (p_hsts_enforcer: *soup.HSTSEnforcer) callconv(.c) c_int,
    /// The `has_valid_policy` function is called to check whether there is a valid
    /// policy for the given domain. This method should return `TRUE` for `soup.HSTSEnforcer` to
    /// change the scheme of the `glib.Uri` in the `soup.Message` to HTTPS. Implementations might want to
    /// chain up to the `has_valid_policy` in the parent class to check, for instance, for runtime
    /// policies.
    f_has_valid_policy: ?*const fn (p_hsts_enforcer: *soup.HSTSEnforcer, p_domain: [*:0]const u8) callconv(.c) c_int,
    /// The class closure for the `soup.HSTSEnforcer.signals.changed` signal.
    f_changed: ?*const fn (p_enforcer: *soup.HSTSEnforcer, p_old_policy: *soup.HSTSPolicy, p_new_policy: *soup.HSTSPolicy) callconv(.c) void,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *HSTSEnforcerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HSTSEnforcerDBClass = extern struct {
    pub const Instance = soup.HSTSEnforcerDB;

    f_parent_class: soup.HSTSEnforcerClass,

    pub fn as(p_instance: *HSTSEnforcerDBClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `soup.HSTSPolicy` implements HTTP policies, as described by
/// [RFC 6797](http://tools.ietf.org/html/rfc6797).
///
/// `domain` represents the host that this policy applies to. The domain
/// must be IDNA-canonicalized. `HSTSPolicy.new` and related methods
/// will do this for you.
///
/// `max_age` contains the 'max-age' value from the Strict Transport
/// Security header and indicates the time to live of this policy,
/// in seconds.
///
/// `expires` will be non-`NULL` if the policy has been set by the host and
/// hence has an expiry time. If `expires` is `NULL`, it indicates that the
/// policy is a permanent session policy set by the user agent.
///
/// If `include_subdomains` is `TRUE`, the Strict Transport Security policy
/// must also be enforced on subdomains of `domain`.
pub const HSTSPolicy = opaque {
    /// Creates a new `soup.HSTSPolicy` with the given attributes.
    ///
    /// `domain` is a domain on which the strict transport security policy
    /// represented by this object must be enforced.
    ///
    /// `max_age` is used to set the "expires" attribute on the policy; pass
    /// `SOUP_HSTS_POLICY_MAX_AGE_PAST` for an already-expired policy, or a
    /// lifetime in seconds.
    ///
    /// If `include_subdomains` is `TRUE`, the strict transport security policy
    /// must also be enforced on all subdomains of `domain`.
    extern fn soup_hsts_policy_new(p_domain: [*:0]const u8, p_max_age: c_ulong, p_include_subdomains: c_int) *soup.HSTSPolicy;
    pub const new = soup_hsts_policy_new;

    /// Parses `msg`'s first "Strict-Transport-Security" response header and
    /// returns a `soup.HSTSPolicy`.
    extern fn soup_hsts_policy_new_from_response(p_msg: *soup.Message) ?*soup.HSTSPolicy;
    pub const newFromResponse = soup_hsts_policy_new_from_response;

    /// Full version of `HSTSPolicy.new`, to use with an existing
    /// expiration date.
    ///
    /// See `HSTSPolicy.new` for details.
    extern fn soup_hsts_policy_new_full(p_domain: [*:0]const u8, p_max_age: c_ulong, p_expires: *glib.DateTime, p_include_subdomains: c_int) *soup.HSTSPolicy;
    pub const newFull = soup_hsts_policy_new_full;

    /// Creates a new session `soup.HSTSPolicy` with the given attributes.
    ///
    /// A session policy is a policy that is valid during the lifetime of
    /// the `HSTSEnforcer` it is added to. Contrary to regular policies,
    /// it has no expiration date and is not stored in persistent
    /// enforcers. These policies are useful for user-agent to load their
    /// own or user-defined rules.
    ///
    /// `domain` is a domain on which the strict transport security policy
    /// represented by this object must be enforced.
    ///
    /// If `include_subdomains` is `TRUE`, the strict transport security policy
    /// must also be enforced on all subdomains of `domain`.
    extern fn soup_hsts_policy_new_session_policy(p_domain: [*:0]const u8, p_include_subdomains: c_int) *soup.HSTSPolicy;
    pub const newSessionPolicy = soup_hsts_policy_new_session_policy;

    /// Copies `policy`.
    extern fn soup_hsts_policy_copy(p_policy: *HSTSPolicy) *soup.HSTSPolicy;
    pub const copy = soup_hsts_policy_copy;

    /// Tests if `policy1` and `policy2` are equal.
    extern fn soup_hsts_policy_equal(p_policy1: *HSTSPolicy, p_policy2: *soup.HSTSPolicy) c_int;
    pub const equal = soup_hsts_policy_equal;

    /// Frees `policy`.
    extern fn soup_hsts_policy_free(p_policy: *HSTSPolicy) void;
    pub const free = soup_hsts_policy_free;

    /// Gets `policy`'s domain.
    extern fn soup_hsts_policy_get_domain(p_policy: *HSTSPolicy) [*:0]const u8;
    pub const getDomain = soup_hsts_policy_get_domain;

    /// Returns the expiration date for `policy`.
    extern fn soup_hsts_policy_get_expires(p_policy: *HSTSPolicy) *glib.DateTime;
    pub const getExpires = soup_hsts_policy_get_expires;

    /// Returns the max age for `policy`.
    extern fn soup_hsts_policy_get_max_age(p_policy: *HSTSPolicy) c_ulong;
    pub const getMaxAge = soup_hsts_policy_get_max_age;

    /// Gets whether `policy` include its subdomains.
    extern fn soup_hsts_policy_includes_subdomains(p_policy: *HSTSPolicy) c_int;
    pub const includesSubdomains = soup_hsts_policy_includes_subdomains;

    /// Gets whether `policy` is expired.
    ///
    /// Permanent policies never expire.
    extern fn soup_hsts_policy_is_expired(p_policy: *HSTSPolicy) c_int;
    pub const isExpired = soup_hsts_policy_is_expired;

    /// Gets whether `policy` is a non-permanent, non-expirable session policy.
    ///
    /// See `HSTSPolicy.newSessionPolicy` for details.
    extern fn soup_hsts_policy_is_session_policy(p_policy: *HSTSPolicy) c_int;
    pub const isSessionPolicy = soup_hsts_policy_is_session_policy;

    extern fn soup_hsts_policy_get_type() usize;
    pub const getGObjectType = soup_hsts_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LoggerClass = extern struct {
    pub const Instance = soup.Logger;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *LoggerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `soup.MessageBody` represents the request or response body of a
/// `Message`.
///
/// Note that while `length` always reflects the full length of the
/// message body, `data` is normally `NULL`, and will only be filled in
/// after `MessageBody.flatten` is called. For client-side
/// messages, this automatically happens for the response body after it
/// has been fully read. Likewise, for server-side
/// messages, the request body is automatically filled in after being
/// read.
///
/// As an added bonus, when `data` is filled in, it is always terminated
/// with a `\0` byte (which is not reflected in `length`).
pub const MessageBody = extern struct {
    /// the data
    f_data: ?[*]const u8,
    /// length of `data`
    f_length: i64,

    /// Creates a new `soup.MessageBody`.
    ///
    /// `Message` uses this internally; you
    /// will not normally need to call it yourself.
    extern fn soup_message_body_new() *soup.MessageBody;
    pub const new = soup_message_body_new;

    /// Appends `length` bytes from `data` to `body` according to `use`.
    extern fn soup_message_body_append(p_body: *MessageBody, p_use: soup.MemoryUse, p_data: [*]const u8, p_length: usize) void;
    pub const append = soup_message_body_append;

    /// Appends the data from `buffer` to `body`.
    extern fn soup_message_body_append_bytes(p_body: *MessageBody, p_buffer: *glib.Bytes) void;
    pub const appendBytes = soup_message_body_append_bytes;

    /// Appends `length` bytes from `data` to `body`.
    ///
    /// This function is exactly equivalent to `MessageBody.append`
    /// with `SOUP_MEMORY_TAKE` as second argument; it exists mainly for
    /// convenience and simplifying language bindings.
    extern fn soup_message_body_append_take(p_body: *MessageBody, p_data: [*]u8, p_length: usize) void;
    pub const appendTake = soup_message_body_append_take;

    /// Tags `body` as being complete.
    ///
    /// Call this when using chunked encoding after you have appended the last chunk.
    extern fn soup_message_body_complete(p_body: *MessageBody) void;
    pub const complete = soup_message_body_complete;

    /// Fills in `body`'s data field with a buffer containing all of the
    /// data in `body`.
    ///
    /// Adds an additional `\0` byte not counted by `body`'s
    /// length field.
    extern fn soup_message_body_flatten(p_body: *MessageBody) *glib.Bytes;
    pub const flatten = soup_message_body_flatten;

    /// Gets the accumulate flag on `body`.
    ///
    /// See [method`MessageBody`.set_accumulate. for details.
    extern fn soup_message_body_get_accumulate(p_body: *MessageBody) c_int;
    pub const getAccumulate = soup_message_body_get_accumulate;

    /// Gets a `glib.Bytes` containing data from `body` starting at `offset`.
    ///
    /// The size of the returned chunk is unspecified. You can iterate
    /// through the entire body by first calling
    /// `MessageBody.getChunk` with an offset of 0, and then on each
    /// successive call, increment the offset by the length of the
    /// previously-returned chunk.
    ///
    /// If `offset` is greater than or equal to the total length of `body`,
    /// then the return value depends on whether or not
    /// `MessageBody.complete` has been called or not; if it has,
    /// then `MessageBody.getChunk` will return a 0-length chunk
    /// (indicating the end of `body`). If it has not, then
    /// `MessageBody.getChunk` will return `NULL` (indicating that
    /// `body` may still potentially have more data, but that data is not
    /// currently available).
    extern fn soup_message_body_get_chunk(p_body: *MessageBody, p_offset: i64) ?*glib.Bytes;
    pub const getChunk = soup_message_body_get_chunk;

    /// Handles the `soup.MessageBody` part of receiving a chunk of data from
    /// the network.
    ///
    /// Normally this means appending `chunk` to `body`, exactly as with
    /// `MessageBody.appendBytes`, but if you have set `body`'s accumulate
    /// flag to `FALSE`, then that will not happen.
    ///
    /// This is a low-level method which you should not normally need to
    /// use.
    extern fn soup_message_body_got_chunk(p_body: *MessageBody, p_chunk: *glib.Bytes) void;
    pub const gotChunk = soup_message_body_got_chunk;

    /// Atomically increments the reference count of `body` by one.
    extern fn soup_message_body_ref(p_body: *MessageBody) *soup.MessageBody;
    pub const ref = soup_message_body_ref;

    /// Sets or clears the accumulate flag on `body`.
    ///
    /// (The default value is `TRUE`.) If set to `FALSE`, `body`'s data field will not
    /// be filled in after the body is fully sent/received, and the chunks that make
    /// up `body` may be discarded when they are no longer needed.
    ///
    /// If you set the flag to `FALSE` on the `Message` request_body of a
    /// client-side message, it will block the accumulation of chunks into
    /// `body`'s data field, but it will not normally cause the chunks to
    /// be discarded after being written like in the server-side
    /// `Message` response_body case, because the request body needs to
    /// be kept around in case the request needs to be sent a second time
    /// due to redirection or authentication.
    extern fn soup_message_body_set_accumulate(p_body: *MessageBody, p_accumulate: c_int) void;
    pub const setAccumulate = soup_message_body_set_accumulate;

    /// Deletes all of the data in `body`.
    extern fn soup_message_body_truncate(p_body: *MessageBody) void;
    pub const truncate = soup_message_body_truncate;

    /// Atomically decrements the reference count of `body` by one.
    ///
    /// When the reference count reaches zero, the resources allocated by
    /// `body` are freed
    extern fn soup_message_body_unref(p_body: *MessageBody) void;
    pub const unref = soup_message_body_unref;

    /// Handles the `soup.MessageBody` part of writing a chunk of data to the
    /// network.
    ///
    /// Normally this is a no-op, but if you have set `body`'s accumulate flag to
    /// `FALSE`, then this will cause `chunk` to be discarded to free up memory.
    ///
    /// This is a low-level method which you should not need to use, and
    /// there are further restrictions on its proper use which are not
    /// documented here.
    extern fn soup_message_body_wrote_chunk(p_body: *MessageBody, p_chunk: *glib.Bytes) void;
    pub const wroteChunk = soup_message_body_wrote_chunk;

    extern fn soup_message_body_get_type() usize;
    pub const getGObjectType = soup_message_body_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MessageClass = extern struct {
    pub const Instance = soup.Message;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *MessageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The HTTP message headers associated with a request or response.
pub const MessageHeaders = opaque {
    /// Creates a `soup.MessageHeaders`.
    ///
    /// (`Message` does this automatically for its own headers. You would only
    /// need to use this method if you are manually parsing or generating message
    /// headers.)
    extern fn soup_message_headers_new(p_type: soup.MessageHeadersType) *soup.MessageHeaders;
    pub const new = soup_message_headers_new;

    /// Appends a new header with name `name` and value `value` to `hdrs`.
    ///
    /// (If there is an existing header with name `name`, then this creates a second
    /// one, which is only allowed for list-valued headers; see also
    /// `MessageHeaders.replace`.)
    ///
    /// The caller is expected to make sure that `name` and `value` are
    /// syntactically correct.
    extern fn soup_message_headers_append(p_hdrs: *MessageHeaders, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const append = soup_message_headers_append;

    /// Removes all the headers listed in the Connection header.
    extern fn soup_message_headers_clean_connection_headers(p_hdrs: *MessageHeaders) void;
    pub const cleanConnectionHeaders = soup_message_headers_clean_connection_headers;

    /// Clears `hdrs`.
    extern fn soup_message_headers_clear(p_hdrs: *MessageHeaders) void;
    pub const clear = soup_message_headers_clear;

    /// Calls `func` once for each header value in `hdrs`.
    ///
    /// Beware that unlike `MessageHeaders.getList`, this processes the
    /// headers in exactly the way they were added, rather than
    /// concatenating multiple same-named headers into a single value.
    /// (This is intentional; it ensures that if you call
    /// `MessageHeaders.append` multiple times with the same name,
    /// then the I/O code will output multiple copies of the header when
    /// sending the message to the remote implementation, which may be
    /// required for interoperability in some cases.)
    ///
    /// You may not modify the headers from `func`.
    extern fn soup_message_headers_foreach(p_hdrs: *MessageHeaders, p_func: soup.MessageHeadersForeachFunc, p_user_data: ?*anyopaque) void;
    pub const foreach = soup_message_headers_foreach;

    /// Frees the array of ranges returned from `MessageHeaders.getRanges`.
    extern fn soup_message_headers_free_ranges(p_hdrs: *MessageHeaders, p_ranges: *soup.Range) void;
    pub const freeRanges = soup_message_headers_free_ranges;

    /// Looks up the "Content-Disposition" header in `hdrs`, parses it, and
    /// returns its value in *`disposition` and *`params`.
    ///
    /// `params` can be `NULL` if you are only interested in the disposition-type.
    ///
    /// In HTTP, the most common use of this header is to set a
    /// disposition-type of "attachment", to suggest to the browser that a
    /// response should be saved to disk rather than displayed in the
    /// browser. If `params` contains a "filename" parameter, this is a
    /// suggestion of a filename to use. (If the parameter value in the
    /// header contains an absolute or relative path, libsoup will truncate
    /// it down to just the final path component, so you do not need to
    /// test this yourself.)
    ///
    /// Content-Disposition is also used in "multipart/form-data", however
    /// this is handled automatically by `Multipart` and the associated
    /// form methods.
    extern fn soup_message_headers_get_content_disposition(p_hdrs: *MessageHeaders, p_disposition: *[*:0]u8, p_params: **glib.HashTable) c_int;
    pub const getContentDisposition = soup_message_headers_get_content_disposition;

    /// Gets the message body length that `hdrs` declare.
    ///
    /// This will only be non-0 if `MessageHeaders.getEncoding` returns
    /// `SOUP_ENCODING_CONTENT_LENGTH`.
    extern fn soup_message_headers_get_content_length(p_hdrs: *MessageHeaders) i64;
    pub const getContentLength = soup_message_headers_get_content_length;

    /// Parses `hdrs`'s Content-Range header and returns it in `start`,
    /// `end`, and `total_length`. If the total length field in the header
    /// was specified as "*", then `total_length` will be set to -1.
    extern fn soup_message_headers_get_content_range(p_hdrs: *MessageHeaders, p_start: *i64, p_end: *i64, p_total_length: ?*i64) c_int;
    pub const getContentRange = soup_message_headers_get_content_range;

    /// Looks up the "Content-Type" header in `hdrs`, parses it, and returns
    /// its value in *`content_type` and *`params`.
    ///
    /// `params` can be `NULL` if you are only interested in the content type itself.
    extern fn soup_message_headers_get_content_type(p_hdrs: *MessageHeaders, p_params: ?**glib.HashTable) ?[*:0]const u8;
    pub const getContentType = soup_message_headers_get_content_type;

    /// Gets the message body encoding that `hdrs` declare.
    ///
    /// This may not always correspond to the encoding used on the wire; eg, a HEAD
    /// response may declare a Content-Length or Transfer-Encoding, but it will never
    /// actually include a body.
    extern fn soup_message_headers_get_encoding(p_hdrs: *MessageHeaders) soup.Encoding;
    pub const getEncoding = soup_message_headers_get_encoding;

    /// Gets the expectations declared by `hdrs`'s "Expect" header.
    ///
    /// Currently this will either be `SOUP_EXPECTATION_CONTINUE` or
    /// `SOUP_EXPECTATION_UNRECOGNIZED`.
    extern fn soup_message_headers_get_expectations(p_hdrs: *MessageHeaders) soup.Expectation;
    pub const getExpectations = soup_message_headers_get_expectations;

    /// Gets the type of headers.
    extern fn soup_message_headers_get_headers_type(p_hdrs: *MessageHeaders) soup.MessageHeadersType;
    pub const getHeadersType = soup_message_headers_get_headers_type;

    /// Gets the value of header `name` in `hdrs`.
    ///
    /// Use this for headers whose values are comma-delimited lists, and which are
    /// therefore allowed to appear multiple times in the headers. For
    /// non-list-valued headers, use `MessageHeaders.getOne`.
    ///
    /// If `name` appears multiple times in `hdrs`,
    /// `MessageHeaders.getList` will concatenate all of the values
    /// together, separated by commas. This is sometimes awkward to parse
    /// (eg, WWW-Authenticate, Set-Cookie), but you have to be able to deal
    /// with it anyway, because the HTTP spec explicitly states that this
    /// transformation is allowed, and so an upstream proxy could do the
    /// same thing.
    extern fn soup_message_headers_get_list(p_hdrs: *MessageHeaders, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getList = soup_message_headers_get_list;

    /// Gets the value of header `name` in `hdrs`.
    ///
    /// Use this for headers whose values are *not* comma-delimited lists, and which
    /// therefore can only appear at most once in the headers. For list-valued
    /// headers, use `MessageHeaders.getList`.
    ///
    /// If `hdrs` does erroneously contain multiple copies of the header, it
    /// is not defined which one will be returned. (Ideally, it will return
    /// whichever one makes libsoup most compatible with other HTTP
    /// implementations.)
    extern fn soup_message_headers_get_one(p_hdrs: *MessageHeaders, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getOne = soup_message_headers_get_one;

    /// Parses `hdrs`'s Range header and returns an array of the requested
    /// byte ranges.
    ///
    /// The returned array must be freed with `MessageHeaders.freeRanges`.
    ///
    /// If `total_length` is non-0, its value will be used to adjust the
    /// returned ranges to have explicit start and end values, and the
    /// returned ranges will be sorted and non-overlapping. If
    /// `total_length` is 0, then some ranges may have an end value of -1,
    /// as described under `Range`, and some of the ranges may be
    /// redundant.
    ///
    /// Beware that even if given a `total_length`, this function does not
    /// check that the ranges are satisfiable.
    ///
    /// `soup.Server` has built-in handling for range requests. If your
    /// server handler returns a `SOUP_STATUS_OK` response containing the
    /// complete response body (rather than pausing the message and
    /// returning some of the response body later), and there is a Range
    /// header in the request, then libsoup will automatically convert the
    /// response to a `SOUP_STATUS_PARTIAL_CONTENT` response containing only
    /// the range(s) requested by the client.
    ///
    /// The only time you need to process the Range header yourself is if
    /// either you need to stream the response body rather than returning
    /// it all at once, or you do not already have the complete response
    /// body available, and only want to generate the parts that were
    /// actually requested by the client.
    extern fn soup_message_headers_get_ranges(p_hdrs: *MessageHeaders, p_total_length: i64, p_ranges: *[*]soup.Range, p_length: *c_int) c_int;
    pub const getRanges = soup_message_headers_get_ranges;

    /// Checks whether the list-valued header `name` is present in `hdrs`,
    /// and contains a case-insensitive match for `token`.
    ///
    /// (If `name` is present in `hdrs`, then this is equivalent to calling
    /// `headerContains` on its value.)
    extern fn soup_message_headers_header_contains(p_hdrs: *MessageHeaders, p_name: [*:0]const u8, p_token: [*:0]const u8) c_int;
    pub const headerContains = soup_message_headers_header_contains;

    /// Checks whether the header `name` is present in `hdrs` and is
    /// (case-insensitively) equal to `value`.
    extern fn soup_message_headers_header_equals(p_hdrs: *MessageHeaders, p_name: [*:0]const u8, p_value: [*:0]const u8) c_int;
    pub const headerEquals = soup_message_headers_header_equals;

    /// Atomically increments the reference count of `hdrs` by one.
    extern fn soup_message_headers_ref(p_hdrs: *MessageHeaders) *soup.MessageHeaders;
    pub const ref = soup_message_headers_ref;

    /// Removes `name` from `hdrs`.
    ///
    /// If there are multiple values for `name`, they are all removed.
    extern fn soup_message_headers_remove(p_hdrs: *MessageHeaders, p_name: [*:0]const u8) void;
    pub const remove = soup_message_headers_remove;

    /// Replaces the value of the header `name` in `hdrs` with `value`.
    ///
    /// See also `MessageHeaders.append`.
    ///
    /// The caller is expected to make sure that `name` and `value` are
    /// syntactically correct.
    extern fn soup_message_headers_replace(p_hdrs: *MessageHeaders, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const replace = soup_message_headers_replace;

    /// Sets the "Content-Disposition" header in `hdrs` to `disposition`,
    /// optionally with additional parameters specified in `params`.
    ///
    /// See `MessageHeaders.getContentDisposition` for a discussion
    /// of how Content-Disposition is used in HTTP.
    extern fn soup_message_headers_set_content_disposition(p_hdrs: *MessageHeaders, p_disposition: [*:0]const u8, p_params: ?*glib.HashTable) void;
    pub const setContentDisposition = soup_message_headers_set_content_disposition;

    /// Sets the message body length that `hdrs` will declare, and sets
    /// `hdrs`'s encoding to `SOUP_ENCODING_CONTENT_LENGTH`.
    ///
    /// You do not normally need to call this; if `hdrs` is set to use
    /// Content-Length encoding, libsoup will automatically set its
    /// Content-Length header for you immediately before sending the
    /// headers. One situation in which this method is useful is when
    /// generating the response to a HEAD request; Calling
    /// `MessageHeaders.setContentLength` allows you to put the
    /// correct content length into the response without needing to waste
    /// memory by filling in a response body which won't actually be sent.
    extern fn soup_message_headers_set_content_length(p_hdrs: *MessageHeaders, p_content_length: i64) void;
    pub const setContentLength = soup_message_headers_set_content_length;

    /// Sets `hdrs`'s Content-Range header according to the given values.
    ///
    /// (Note that `total_length` is the total length of the entire resource
    /// that this is a range of, not simply `end` - `start` + 1.)
    ///
    /// `Server` has built-in handling for range requests, and you do
    /// not normally need to call this function youself. See
    /// `MessageHeaders.getRanges` for more details.
    extern fn soup_message_headers_set_content_range(p_hdrs: *MessageHeaders, p_start: i64, p_end: i64, p_total_length: i64) void;
    pub const setContentRange = soup_message_headers_set_content_range;

    /// Sets the "Content-Type" header in `hdrs` to `content_type`.
    ///
    /// Accepts additional parameters specified in `params`.
    extern fn soup_message_headers_set_content_type(p_hdrs: *MessageHeaders, p_content_type: [*:0]const u8, p_params: ?*glib.HashTable) void;
    pub const setContentType = soup_message_headers_set_content_type;

    /// Sets the message body encoding that `hdrs` will declare.
    ///
    /// In particular, you should use this if you are going to send a request or
    /// response in chunked encoding.
    extern fn soup_message_headers_set_encoding(p_hdrs: *MessageHeaders, p_encoding: soup.Encoding) void;
    pub const setEncoding = soup_message_headers_set_encoding;

    /// Sets `hdrs`'s "Expect" header according to `expectations`.
    ///
    /// Currently `SOUP_EXPECTATION_CONTINUE` is the only known expectation
    /// value. You should set this value on a request if you are sending a
    /// large message body (eg, via POST or PUT), and want to give the
    /// server a chance to reject the request after seeing just the headers
    /// (eg, because it will require authentication before allowing you to
    /// post, or because you're POSTing to a URL that doesn't exist). This
    /// saves you from having to transmit the large request body when the
    /// server is just going to ignore it anyway.
    extern fn soup_message_headers_set_expectations(p_hdrs: *MessageHeaders, p_expectations: soup.Expectation) void;
    pub const setExpectations = soup_message_headers_set_expectations;

    /// Sets `hdrs`'s Range header to request the indicated range.
    ///
    /// `start` and `end` are interpreted as in a `Range`.
    ///
    /// If you need to request multiple ranges, use
    /// `MessageHeaders.setRanges`.
    extern fn soup_message_headers_set_range(p_hdrs: *MessageHeaders, p_start: i64, p_end: i64) void;
    pub const setRange = soup_message_headers_set_range;

    /// Sets `hdrs`'s Range header to request the indicated ranges.
    ///
    /// If you only want to request a single range, you can use
    /// `MessageHeaders.setRange`.
    extern fn soup_message_headers_set_ranges(p_hdrs: *MessageHeaders, p_ranges: *soup.Range, p_length: c_int) void;
    pub const setRanges = soup_message_headers_set_ranges;

    /// Atomically decrements the reference count of `hdrs` by one.
    ///
    /// When the reference count reaches zero, the resources allocated by
    /// `hdrs` are freed
    extern fn soup_message_headers_unref(p_hdrs: *MessageHeaders) void;
    pub const unref = soup_message_headers_unref;

    extern fn soup_message_headers_get_type() usize;
    pub const getGObjectType = soup_message_headers_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque type used to iterate over a `soup.MessageHeaders`
/// structure.
///
/// After intializing the iterator with `MessageHeadersIter.init`, call
/// `MessageHeadersIter.next` to fetch data from it.
///
/// You may not modify the headers while iterating over them.
pub const MessageHeadersIter = extern struct {
    f_dummy: [3]*anyopaque,

    /// Initializes `iter` for iterating `hdrs`.
    extern fn soup_message_headers_iter_init(p_iter: *soup.MessageHeadersIter, p_hdrs: *soup.MessageHeaders) void;
    pub const init = soup_message_headers_iter_init;

    /// Yields the next name/value pair in the `MessageHeaders` being
    /// iterated by `iter`.
    ///
    /// If `iter` has already yielded the last header, then
    /// `MessageHeadersIter.next` will return `FALSE` and `name` and `value`
    /// will be unchanged.
    extern fn soup_message_headers_iter_next(p_iter: *soup.MessageHeadersIter, p_name: *[*:0]const u8, p_value: *[*:0]const u8) c_int;
    pub const next = soup_message_headers_iter_next;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains metrics collected while loading a `Message` either from the
/// network or the disk cache.
///
/// Metrics are not collected by default for a `Message`, you need to add the
/// flag `SOUP_MESSAGE_COLLECT_METRICS` to enable the feature.
///
/// Temporal metrics are expressed as a monotonic time and always start with a
/// fetch start event and finish with response end. All other events are optional.
/// An event can be 0 because it hasn't happened yet, because it's optional or
/// because the load failed before the event reached.
///
/// Size metrics are expressed in bytes and are updated while the `Message` is
/// being loaded. You can connect to different `Message` signals to get the
/// final result of every value.
pub const MessageMetrics = opaque {
    /// Copies `metrics`.
    extern fn soup_message_metrics_copy(p_metrics: *MessageMetrics) *soup.MessageMetrics;
    pub const copy = soup_message_metrics_copy;

    /// Frees `metrics`.
    extern fn soup_message_metrics_free(p_metrics: *MessageMetrics) void;
    pub const free = soup_message_metrics_free;

    /// Get the time immediately after the `Message` completed the
    /// connection to the server. This includes the time for the proxy
    /// negotiation and TLS handshake.
    ///
    /// It will be 0 if no network connection was required to fetch the resource (a
    /// persistent connection was used or resource was loaded from the local disk
    /// cache).
    extern fn soup_message_metrics_get_connect_end(p_metrics: *MessageMetrics) u64;
    pub const getConnectEnd = soup_message_metrics_get_connect_end;

    /// Get the time immediately before the `Message` started to
    /// establish the connection to the server.
    ///
    /// It will be 0 if no network connection was required to fetch the resource (a
    /// persistent connection was used or resource was loaded from the local disk
    /// cache).
    extern fn soup_message_metrics_get_connect_start(p_metrics: *MessageMetrics) u64;
    pub const getConnectStart = soup_message_metrics_get_connect_start;

    /// Get the time immediately after the `Message` completed the
    /// domain lookup name for the resource.
    ///
    /// It will be 0 if no domain lookup was required to fetch the resource (a
    /// persistent connection was used or resource was loaded from the local disk
    /// cache).
    extern fn soup_message_metrics_get_dns_end(p_metrics: *MessageMetrics) u64;
    pub const getDnsEnd = soup_message_metrics_get_dns_end;

    /// Get the time immediately before the `Message` started the
    /// domain lookup name for the resource.
    ///
    /// It will be 0 if no domain lookup was required to fetch the resource (a
    /// persistent connection was used or resource was loaded from the local disk
    /// cache).
    extern fn soup_message_metrics_get_dns_start(p_metrics: *MessageMetrics) u64;
    pub const getDnsStart = soup_message_metrics_get_dns_start;

    /// Get the time immediately before the `Message` started to
    /// fetch a resource either from a remote server or local disk cache.
    extern fn soup_message_metrics_get_fetch_start(p_metrics: *MessageMetrics) u64;
    pub const getFetchStart = soup_message_metrics_get_fetch_start;

    /// Get the number of bytes sent to the network for the request body.
    ///
    /// This is the size of the body sent, after encodings are applied, so it might
    /// be greater than the value returned by
    /// `MessageMetrics.getRequestBodySize`. This value is available right
    /// before `Message.signals.wrote_body` signal is emitted, but you might get an
    /// intermediate value if called before.
    extern fn soup_message_metrics_get_request_body_bytes_sent(p_metrics: *MessageMetrics) u64;
    pub const getRequestBodyBytesSent = soup_message_metrics_get_request_body_bytes_sent;

    /// Get the request body size in bytes. This is the size of the original body
    /// given to the request before any encoding is applied.
    ///
    /// This value is available right before `Message.signals.wrote_body` signal is
    /// emitted, but you might get an intermediate value if called before.
    extern fn soup_message_metrics_get_request_body_size(p_metrics: *MessageMetrics) u64;
    pub const getRequestBodySize = soup_message_metrics_get_request_body_size;

    /// Get the number of bytes sent to the network for the request headers.
    ///
    /// This value is available right before `Message.signals.wrote_headers` signal
    /// is emitted, but you might get an intermediate value if called before.
    extern fn soup_message_metrics_get_request_header_bytes_sent(p_metrics: *MessageMetrics) u64;
    pub const getRequestHeaderBytesSent = soup_message_metrics_get_request_header_bytes_sent;

    /// Get the time immediately before the `Message` started the
    /// request of the resource from the server or the local disk cache.
    extern fn soup_message_metrics_get_request_start(p_metrics: *MessageMetrics) u64;
    pub const getRequestStart = soup_message_metrics_get_request_start;

    /// Get the number of bytes received from the network for the response body.
    ///
    /// This value is available right before `Message.signals.got_body` signal is
    /// emitted, but you might get an intermediate value if called before. For
    /// resources loaded from the disk cache this value is always 0.
    extern fn soup_message_metrics_get_response_body_bytes_received(p_metrics: *MessageMetrics) u64;
    pub const getResponseBodyBytesReceived = soup_message_metrics_get_response_body_bytes_received;

    /// Get the response body size in bytes.
    ///
    /// This is the size of the body as given to the user after all encodings are
    /// applied, so it might be greater than the value returned by
    /// `MessageMetrics.getResponseBodyBytesReceived`. This value is
    /// available right before `Message.signals.got_body` signal is emitted, but you
    /// might get an intermediate value if called before.
    extern fn soup_message_metrics_get_response_body_size(p_metrics: *MessageMetrics) u64;
    pub const getResponseBodySize = soup_message_metrics_get_response_body_size;

    /// Get the time immediately after the `Message` received the last
    /// bytes of the response from the server or the local disk cache.
    ///
    /// In case of load failure, this returns the time immediately before the
    /// fetch is aborted.
    extern fn soup_message_metrics_get_response_end(p_metrics: *MessageMetrics) u64;
    pub const getResponseEnd = soup_message_metrics_get_response_end;

    /// Get the number of bytes received from the network for the response headers.
    ///
    /// This value is available right before `Message.signals.got_headers` signal
    /// is emitted, but you might get an intermediate value if called before.
    /// For resources loaded from the disk cache this value is always 0.
    extern fn soup_message_metrics_get_response_header_bytes_received(p_metrics: *MessageMetrics) u64;
    pub const getResponseHeaderBytesReceived = soup_message_metrics_get_response_header_bytes_received;

    /// Get the time immediately after the `Message` received the first
    /// bytes of the response from the server or the local disk cache.
    extern fn soup_message_metrics_get_response_start(p_metrics: *MessageMetrics) u64;
    pub const getResponseStart = soup_message_metrics_get_response_start;

    /// Get the time immediately before the `Message` started the
    /// TLS handshake.
    ///
    /// It will be 0 if no TLS handshake was required to fetch the resource
    /// (connection was not secure, a persistent connection was used or resource was
    /// loaded from the local disk cache).
    extern fn soup_message_metrics_get_tls_start(p_metrics: *MessageMetrics) u64;
    pub const getTlsStart = soup_message_metrics_get_tls_start;

    extern fn soup_message_metrics_get_type() usize;
    pub const getGObjectType = soup_message_metrics_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a multipart HTTP message body, parsed according to the
/// syntax of RFC 2046.
///
/// Of particular interest to HTTP are `multipart/byte-ranges` and
/// `multipart/form-data`,
///
/// Although the headers of a `soup.Multipart` body part will contain the
/// full headers from that body part, libsoup does not interpret them
/// according to MIME rules. For example, each body part is assumed to
/// have "binary" Content-Transfer-Encoding, even if its headers
/// explicitly state otherwise. In other words, don't try to use
/// `soup.Multipart` for handling real MIME multiparts.
pub const Multipart = opaque {
    /// Creates a new empty `soup.Multipart` with a randomly-generated
    /// boundary string.
    ///
    /// Note that `mime_type` must be the full MIME type, including "multipart/".
    ///
    /// See also: `Message.newFromMultipart`.
    extern fn soup_multipart_new(p_mime_type: [*:0]const u8) *soup.Multipart;
    pub const new = soup_multipart_new;

    /// Parses `headers` and `body` to form a new `soup.Multipart`
    extern fn soup_multipart_new_from_message(p_headers: *soup.MessageHeaders, p_body: *glib.Bytes) ?*soup.Multipart;
    pub const newFromMessage = soup_multipart_new_from_message;

    /// Adds a new MIME part containing `body` to `multipart`
    ///
    /// Uses "Content-Disposition: form-data", as per the HTML forms specification.
    extern fn soup_multipart_append_form_file(p_multipart: *Multipart, p_control_name: [*:0]const u8, p_filename: ?[*:0]const u8, p_content_type: ?[*:0]const u8, p_body: *glib.Bytes) void;
    pub const appendFormFile = soup_multipart_append_form_file;

    /// Adds a new MIME part containing `data` to `multipart`.
    ///
    /// Uses "Content-Disposition: form-data", as per the HTML forms specification.
    extern fn soup_multipart_append_form_string(p_multipart: *Multipart, p_control_name: [*:0]const u8, p_data: [*:0]const u8) void;
    pub const appendFormString = soup_multipart_append_form_string;

    /// Adds a new MIME part to `multipart` with the given headers and body.
    ///
    /// (The multipart will make its own copies of `headers` and `body`, so
    /// you should free your copies if you are not using them for anything
    /// else.)
    extern fn soup_multipart_append_part(p_multipart: *Multipart, p_headers: *soup.MessageHeaders, p_body: *glib.Bytes) void;
    pub const appendPart = soup_multipart_append_part;

    /// Frees `multipart`.
    extern fn soup_multipart_free(p_multipart: *Multipart) void;
    pub const free = soup_multipart_free;

    /// Gets the number of body parts in `multipart`.
    extern fn soup_multipart_get_length(p_multipart: *Multipart) c_int;
    pub const getLength = soup_multipart_get_length;

    /// Gets the indicated body part from `multipart`.
    extern fn soup_multipart_get_part(p_multipart: *Multipart, p_part: c_int, p_headers: **soup.MessageHeaders, p_body: **glib.Bytes) c_int;
    pub const getPart = soup_multipart_get_part;

    /// Serializes `multipart` to `dest_headers` and `dest_body`.
    extern fn soup_multipart_to_message(p_multipart: *Multipart, p_dest_headers: *soup.MessageHeaders, p_dest_body: **glib.Bytes) void;
    pub const toMessage = soup_multipart_to_message;

    extern fn soup_multipart_get_type() usize;
    pub const getGObjectType = soup_multipart_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MultipartInputStreamClass = extern struct {
    pub const Instance = soup.MultipartInputStream;

    f_parent_class: gio.FilterInputStreamClass,

    pub fn as(p_instance: *MultipartInputStreamClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a byte range as used in the Range header.
///
/// If `end` is non-negative, then `start` and `end` represent the bounds
/// of of the range, counting from 0. (Eg, the first 500 bytes would be
/// represented as `start` = 0 and `end` = 499.)
///
/// If `end` is -1 and `start` is non-negative, then this represents a
/// range starting at `start` and ending with the last byte of the
/// requested resource body. (Eg, all but the first 500 bytes would be
/// `start` = 500, and `end` = -1.)
///
/// If `end` is -1 and `start` is negative, then it represents a "suffix
/// range", referring to the last -`start` bytes of the resource body.
/// (Eg, the last 500 bytes would be `start` = -500 and `end` = -1.)
pub const Range = extern struct {
    /// the start of the range
    f_start: i64,
    /// the end of the range
    f_end: i64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServerClass = extern struct {
    pub const Instance = soup.Server;

    f_parent_class: gobject.ObjectClass,
    f_request_started: ?*const fn (p_server: *soup.Server, p_msg: *soup.ServerMessage) callconv(.c) void,
    f_request_read: ?*const fn (p_server: *soup.Server, p_msg: *soup.ServerMessage) callconv(.c) void,
    f_request_finished: ?*const fn (p_server: *soup.Server, p_msg: *soup.ServerMessage) callconv(.c) void,
    f_request_aborted: ?*const fn (p_server: *soup.Server, p_msg: *soup.ServerMessage) callconv(.c) void,
    f_padding: [6]*anyopaque,

    pub fn as(p_instance: *ServerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ServerMessageClass = extern struct {
    pub const Instance = soup.ServerMessage;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ServerMessageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SessionClass = extern struct {
    pub const Instance = soup.Session;

    f_parent_class: gobject.ObjectClass,
    f_request_queued: ?*const fn (p_session: *soup.Session, p_msg: *soup.Message) callconv(.c) void,
    f_request_unqueued: ?*const fn (p_session: *soup.Session, p_msg: *soup.Message) callconv(.c) void,
    f__soup_reserved1: ?*const fn () callconv(.c) void,
    f__soup_reserved2: ?*const fn () callconv(.c) void,
    f__soup_reserved3: ?*const fn () callconv(.c) void,
    f__soup_reserved4: ?*const fn () callconv(.c) void,
    f__soup_reserved5: ?*const fn () callconv(.c) void,
    f__soup_reserved6: ?*const fn () callconv(.c) void,
    f__soup_reserved7: ?*const fn () callconv(.c) void,
    f__soup_reserved8: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *SessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The interface implemented by `SessionFeature`s.
pub const SessionFeatureInterface = opaque {
    pub const Instance = soup.SessionFeature;

    pub fn as(p_instance: *SessionFeatureInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The abstract base class for `WebsocketConnection`.
pub const WebsocketConnectionClass = extern struct {
    pub const Instance = soup.WebsocketConnection;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *WebsocketConnectionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The class structure for the `soup.WebsocketExtension`.
pub const WebsocketExtensionClass = extern struct {
    pub const Instance = soup.WebsocketExtension;

    /// the parent class
    f_parent_class: gobject.ObjectClass,
    /// the name of the extension
    f_name: ?[*:0]const u8,
    /// called to configure the extension with the given parameters
    f_configure: ?*const fn (p_extension: *soup.WebsocketExtension, p_connection_type: soup.WebsocketConnectionType, p_params: ?*glib.HashTable, p_error: ?*?*glib.Error) callconv(.c) c_int,
    /// called by the client to build the request header.
    ///    It should include the parameters string starting with ';'
    f_get_request_params: ?*const fn (p_extension: *soup.WebsocketExtension) callconv(.c) ?[*:0]u8,
    /// called by the server to build the response header.
    ///    It should include the parameters string starting with ';'
    f_get_response_params: ?*const fn (p_extension: *soup.WebsocketExtension) callconv(.c) ?[*:0]u8,
    /// called to process the payload data of a message
    ///    before it's sent. Reserved bits of the header should be changed.
    f_process_outgoing_message: ?*const fn (p_extension: *soup.WebsocketExtension, p_header: *u8, p_payload: *glib.Bytes, p_error: ?*?*glib.Error) callconv(.c) ?*glib.Bytes,
    /// called to process the payload data of a message
    ///    after it's received. Reserved bits of the header should be cleared.
    f_process_incoming_message: ?*const fn (p_extension: *soup.WebsocketExtension, p_header: *u8, p_payload: *glib.Bytes, p_error: ?*?*glib.Error) callconv(.c) ?*glib.Bytes,
    f_padding: [6]*anyopaque,

    pub fn as(p_instance: *WebsocketExtensionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebsocketExtensionDeflateClass = extern struct {
    pub const Instance = soup.WebsocketExtensionDeflate;

    f_parent_class: soup.WebsocketExtensionClass,

    pub fn as(p_instance: *WebsocketExtensionDeflateClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebsocketExtensionManagerClass = extern struct {
    pub const Instance = soup.WebsocketExtensionManager;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *WebsocketExtensionManagerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of cache; this affects what kinds of responses will be
/// saved.
pub const CacheType = enum(c_int) {
    single_user = 0,
    shared = 1,
    _,

    extern fn soup_cache_type_get_type() usize;
    pub const getGObjectType = soup_cache_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The policy for accepting or rejecting cookies returned in
/// responses.
pub const CookieJarAcceptPolicy = enum(c_int) {
    always = 0,
    never = 1,
    no_third_party = 2,
    grandfathered_third_party = 3,
    _,

    extern fn soup_cookie_jar_accept_policy_get_type() usize;
    pub const getGObjectType = soup_cookie_jar_accept_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Date formats that `dateTimeToString` can use.
///
/// `SOUP_DATE_HTTP` and `SOUP_DATE_COOKIE` always coerce the time to
/// UTC.
///
/// This enum may be extended with more values in future releases.
pub const DateFormat = enum(c_int) {
    http = 1,
    cookie = 2,
    _,

    extern fn soup_date_format_get_type() usize;
    pub const getGObjectType = soup_date_format_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// How a message body is encoded for transport
pub const Encoding = enum(c_int) {
    unrecognized = 0,
    none = 1,
    content_length = 2,
    eof = 3,
    chunked = 4,
    byteranges = 5,
    _,

    extern fn soup_encoding_get_type() usize;
    pub const getGObjectType = soup_encoding_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the HTTP protocol version being used.
pub const HTTPVersion = enum(c_int) {
    http_1_0 = 0,
    http_1_1 = 1,
    http_2_0 = 2,
    _,

    extern fn soup_http_version_get_type() usize;
    pub const getGObjectType = soup_http_version_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the level of logging output to provide.
pub const LoggerLogLevel = enum(c_int) {
    none = 0,
    minimal = 1,
    headers = 2,
    body = 3,
    _,

    extern fn soup_logger_log_level_get_type() usize;
    pub const getGObjectType = soup_logger_log_level_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The lifetime of the memory being passed.
pub const MemoryUse = enum(c_int) {
    static = 0,
    take = 1,
    copy = 2,
    _,

    extern fn soup_memory_use_get_type() usize;
    pub const getGObjectType = soup_memory_use_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Value passed to `MessageHeaders.new` to set certain default
/// behaviors.
pub const MessageHeadersType = enum(c_int) {
    request = 0,
    response = 1,
    multipart = 2,
    _,

    extern fn soup_message_headers_type_get_type() usize;
    pub const getGObjectType = soup_message_headers_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Priorities that can be set on a `Message` to instruct the message queue
/// to process it before any other message with lower priority.
pub const MessagePriority = enum(c_int) {
    very_low = 0,
    low = 1,
    normal = 2,
    high = 3,
    very_high = 4,
    _,

    extern fn soup_message_priority_get_type() usize;
    pub const getGObjectType = soup_message_priority_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents the same-site policies of a cookie.
pub const SameSitePolicy = enum(c_int) {
    none = 0,
    lax = 1,
    strict = 2,
    _,

    extern fn soup_same_site_policy_get_type() usize;
    pub const getGObjectType = soup_same_site_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `soup.Session` error.
pub const SessionError = enum(c_int) {
    parsing = 0,
    encoding = 1,
    too_many_redirects = 2,
    too_many_restarts = 3,
    redirect_no_location = 4,
    redirect_bad_uri = 5,
    message_already_in_queue = 6,
    _,

    /// Registers error quark for SoupSession if needed.
    extern fn soup_session_error_quark() glib.Quark;
    pub const quark = soup_session_error_quark;

    extern fn soup_session_error_get_type() usize;
    pub const getGObjectType = soup_session_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// These represent the known HTTP status code values, plus various
/// network and internal errors.
///
/// Note that no libsoup functions take or return this type directly;
/// any function that works with status codes will accept unrecognized
/// status codes as well.
pub const Status = enum(c_int) {
    none = 0,
    @"continue" = 100,
    switching_protocols = 101,
    processing = 102,
    ok = 200,
    created = 201,
    accepted = 202,
    non_authoritative = 203,
    no_content = 204,
    reset_content = 205,
    partial_content = 206,
    multi_status = 207,
    multiple_choices = 300,
    moved_permanently = 301,
    found = 302,
    see_other = 303,
    not_modified = 304,
    use_proxy = 305,
    not_appearing_in_this_protocol = 306,
    temporary_redirect = 307,
    permanent_redirect = 308,
    bad_request = 400,
    unauthorized = 401,
    payment_required = 402,
    forbidden = 403,
    not_found = 404,
    method_not_allowed = 405,
    not_acceptable = 406,
    proxy_authentication_required = 407,
    request_timeout = 408,
    conflict = 409,
    gone = 410,
    length_required = 411,
    precondition_failed = 412,
    request_entity_too_large = 413,
    request_uri_too_long = 414,
    unsupported_media_type = 415,
    requested_range_not_satisfiable = 416,
    expectation_failed = 417,
    misdirected_request = 421,
    unprocessable_entity = 422,
    locked = 423,
    failed_dependency = 424,
    internal_server_error = 500,
    not_implemented = 501,
    bad_gateway = 502,
    service_unavailable = 503,
    gateway_timeout = 504,
    http_version_not_supported = 505,
    insufficient_storage = 507,
    not_extended = 510,
    _,

    pub const moved_temporarily = Status.found;
    pub const proxy_unauthorized = Status.proxy_authentication_required;
    pub const invalid_range = Status.requested_range_not_satisfiable;
    /// Looks up the stock HTTP description of `status_code`.
    ///
    /// *There is no reason for you to ever use this
    /// function.* If you wanted the textual description for the
    /// `Message.properties.status_code` of a given `Message`, you should just
    /// look at the message's `Message.properties.reason_phrase`. However, you
    /// should only do that for use in debugging messages; HTTP reason
    /// phrases are not localized, and are not generally very descriptive
    /// anyway, and so they should never be presented to the user directly.
    /// Instead, you should create you own error messages based on the
    /// status code, and on what you were trying to do.
    extern fn soup_status_get_phrase(p_status_code: c_uint) [*:0]const u8;
    pub const getPhrase = soup_status_get_phrase;

    extern fn soup_status_get_type() usize;
    pub const getGObjectType = soup_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error codes for `SOUP_TLD_ERROR`.
pub const TLDError = enum(c_int) {
    invalid_hostname = 0,
    is_ip_address = 1,
    not_enough_domains = 2,
    no_base_domain = 3,
    no_psl_data = 4,
    _,

    /// Registers error quark for `soup.tldGetBaseDomain` if needed.
    extern fn soup_tld_error_quark() glib.Quark;
    pub const quark = soup_tld_error_quark;

    extern fn soup_tld_error_get_type() usize;
    pub const getGObjectType = soup_tld_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enum values passed to `uriCopy` to indicate the components of
/// the URI that should be updated with the given values.
pub const URIComponent = enum(c_int) {
    none = 0,
    scheme = 1,
    user = 2,
    password = 3,
    auth_params = 4,
    host = 5,
    port = 6,
    path = 7,
    query = 8,
    fragment = 9,
    _,

    extern fn soup_uri_component_get_type() usize;
    pub const getGObjectType = soup_uri_component_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Pre-defined close codes that can be passed to
/// `WebsocketConnection.close` or received from
/// `WebsocketConnection.getCloseCode`.
///
/// However, other codes are also allowed.
pub const WebsocketCloseCode = enum(c_int) {
    normal = 1000,
    going_away = 1001,
    protocol_error = 1002,
    unsupported_data = 1003,
    no_status = 1005,
    abnormal = 1006,
    bad_data = 1007,
    policy_violation = 1008,
    too_big = 1009,
    no_extension = 1010,
    server_error = 1011,
    tls_handshake = 1015,
    _,

    extern fn soup_websocket_close_code_get_type() usize;
    pub const getGObjectType = soup_websocket_close_code_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of a `WebsocketConnection`.
pub const WebsocketConnectionType = enum(c_int) {
    unknown = 0,
    client = 1,
    server = 2,
    _,

    extern fn soup_websocket_connection_type_get_type() usize;
    pub const getGObjectType = soup_websocket_connection_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of data contained in a `WebsocketConnection.signals.message` signal.
pub const WebsocketDataType = enum(c_int) {
    text = 1,
    binary = 2,
    _,

    extern fn soup_websocket_data_type_get_type() usize;
    pub const getGObjectType = soup_websocket_data_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// WebSocket-related errors.
pub const WebsocketError = enum(c_int) {
    failed = 0,
    not_websocket = 1,
    bad_handshake = 2,
    bad_origin = 3,
    _,

    /// Registers error quark for SoupWebsocket if needed.
    extern fn soup_websocket_error_quark() glib.Quark;
    pub const quark = soup_websocket_error_quark;

    extern fn soup_websocket_error_get_type() usize;
    pub const getGObjectType = soup_websocket_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The state of the WebSocket connection.
pub const WebsocketState = enum(c_int) {
    open = 1,
    closing = 2,
    closed = 3,
    _,

    extern fn soup_websocket_state_get_type() usize;
    pub const getGObjectType = soup_websocket_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates if a message should or shouldn't be cached.
pub const Cacheability = packed struct(c_uint) {
    cacheable: bool = false,
    uncacheable: bool = false,
    invalidates: bool = false,
    validates: bool = false,
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

    pub const flags_cacheable: Cacheability = @bitCast(@as(c_uint, 1));
    pub const flags_uncacheable: Cacheability = @bitCast(@as(c_uint, 2));
    pub const flags_invalidates: Cacheability = @bitCast(@as(c_uint, 4));
    pub const flags_validates: Cacheability = @bitCast(@as(c_uint, 8));
    extern fn soup_cacheability_get_type() usize;
    pub const getGObjectType = soup_cacheability_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents the parsed value of the "Expect" header.
pub const Expectation = packed struct(c_uint) {
    unrecognized: bool = false,
    @"continue": bool = false,
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

    pub const flags_unrecognized: Expectation = @bitCast(@as(c_uint, 1));
    pub const flags_continue: Expectation = @bitCast(@as(c_uint, 2));
    extern fn soup_expectation_get_type() usize;
    pub const getGObjectType = soup_expectation_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Various flags that can be set on a `soup.Message` to alter its
/// behavior.
pub const MessageFlags = packed struct(c_uint) {
    _padding0: bool = false,
    no_redirect: bool = false,
    new_connection: bool = false,
    idempotent: bool = false,
    do_not_use_auth_cache: bool = false,
    collect_metrics: bool = false,
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

    pub const flags_no_redirect: MessageFlags = @bitCast(@as(c_uint, 2));
    pub const flags_new_connection: MessageFlags = @bitCast(@as(c_uint, 4));
    pub const flags_idempotent: MessageFlags = @bitCast(@as(c_uint, 8));
    pub const flags_do_not_use_auth_cache: MessageFlags = @bitCast(@as(c_uint, 16));
    pub const flags_collect_metrics: MessageFlags = @bitCast(@as(c_uint, 32));
    extern fn soup_message_flags_get_type() usize;
    pub const getGObjectType = soup_message_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Options to pass to `Server.listen`, etc.
///
/// `SOUP_SERVER_LISTEN_IPV4_ONLY` and `SOUP_SERVER_LISTEN_IPV6_ONLY`
/// only make sense with `Server.listenAll` and
/// `Server.listenLocal`, not plain `Server.listen` (which
/// simply listens on whatever kind of socket you give it). And you
/// cannot specify both of them in a single call.
pub const ServerListenOptions = packed struct(c_uint) {
    https: bool = false,
    ipv4_only: bool = false,
    ipv6_only: bool = false,
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

    pub const flags_https: ServerListenOptions = @bitCast(@as(c_uint, 1));
    pub const flags_ipv4_only: ServerListenOptions = @bitCast(@as(c_uint, 2));
    pub const flags_ipv6_only: ServerListenOptions = @bitCast(@as(c_uint, 4));
    extern fn soup_server_listen_options_get_type() usize;
    pub const getGObjectType = soup_server_listen_options_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Like `CHECKVERSION`, but the check for soup_check_version is
/// at runtime instead of compile time.
///
/// This is useful for compiling against older versions of libsoup, but using
/// features from newer versions.
extern fn soup_check_version(p_major: c_uint, p_minor: c_uint, p_micro: c_uint) c_int;
pub const checkVersion = soup_check_version;

/// Frees `cookies`.
extern fn soup_cookies_free(p_cookies: *glib.SList) void;
pub const cookiesFree = soup_cookies_free;

/// Parses `msg`'s Cookie request header and returns a `glib.SList` of
/// `SoupCookie`s.
///
/// As the "Cookie" header, unlike "Set-Cookie", only contains cookie names and
/// values, none of the other `soup.Cookie` fields will be filled in. (Thus, you
/// can't generally pass a cookie returned from this method directly to
/// `cookiesToResponse`.)
extern fn soup_cookies_from_request(p_msg: *soup.Message) *glib.SList;
pub const cookiesFromRequest = soup_cookies_from_request;

/// Parses `msg`'s Set-Cookie response headers and returns a `glib.SList`
/// of `SoupCookie`s.
///
/// Cookies that do not specify "path" or "domain" attributes will have their
/// values defaulted from `msg`.
extern fn soup_cookies_from_response(p_msg: *soup.Message) *glib.SList;
pub const cookiesFromResponse = soup_cookies_from_response;

/// Serializes a `glib.SList` of `soup.Cookie` into a string suitable for
/// setting as the value of the "Cookie" header.
extern fn soup_cookies_to_cookie_header(p_cookies: *glib.SList) [*:0]u8;
pub const cookiesToCookieHeader = soup_cookies_to_cookie_header;

/// Adds the name and value of each cookie in `cookies` to `msg`'s
/// "Cookie" request.
///
/// If `msg` already has a "Cookie" request header, these cookies will be appended
/// to the cookies already present. Be careful that you do not append the same
/// cookies twice, eg, when requeuing a message.
extern fn soup_cookies_to_request(p_cookies: *glib.SList, p_msg: *soup.Message) void;
pub const cookiesToRequest = soup_cookies_to_request;

/// Appends a "Set-Cookie" response header to `msg` for each cookie in
/// `cookies`.
///
/// This is in addition to any other "Set-Cookie" headers
/// `msg` may already have.
extern fn soup_cookies_to_response(p_cookies: *glib.SList, p_msg: *soup.Message) void;
pub const cookiesToResponse = soup_cookies_to_response;

/// Parses `date_string` and tries to extract a date from it.
///
/// This recognizes all of the "HTTP-date" formats from RFC 2616, RFC 2822 dates,
/// and reasonable approximations thereof. (Eg, it is lenient about whitespace,
/// leading "0"s, etc.)
extern fn soup_date_time_new_from_http_string(p_date_string: [*:0]const u8) ?*glib.DateTime;
pub const dateTimeNewFromHttpString = soup_date_time_new_from_http_string;

/// Converts `date` to a string in the format described by `format`.
extern fn soup_date_time_to_string(p_date: *glib.DateTime, p_format: soup.DateFormat) [*:0]u8;
pub const dateTimeToString = soup_date_time_to_string;

/// Decodes `form`.
///
/// which is an urlencoded dataset as defined in the HTML 4.01 spec.
extern fn soup_form_decode(p_encoded_form: [*:0]const u8) *glib.HashTable;
pub const formDecode = soup_form_decode;

/// Decodes the "multipart/form-data" request in `multipart`.
///
/// this is a convenience method for the case when you have a single file upload
/// control in a form. (Or when you don't have any file upload controls, but are
/// still using "multipart/form-data" anyway.) Pass the name of the file upload
/// control in `file_control_name`, and `formDecodeMultipart` will extract
/// the uploaded file data into `filename`, `content_type`, and `file`. All of the
/// other form control data will be returned (as strings, as with
/// `formDecode` in the returned `glib.HashTable`.
///
/// You may pass `NULL` for `filename`, `content_type` and/or `file` if you do not
/// care about those fields. `formDecodeMultipart` may also
/// return `NULL` in those fields if the client did not provide that
/// information. You must free the returned filename and content-type
/// with `glib.free`, and the returned file data with `glib.Bytes.unref`.
///
/// If you have a form with more than one file upload control, you will
/// need to decode it manually, using `Multipart.newFromMessage`
/// and `Multipart.getPart`.
extern fn soup_form_decode_multipart(p_multipart: *soup.Multipart, p_file_control_name: ?[*:0]const u8, p_filename: ?*[*:0]u8, p_content_type: ?*[*:0]u8, p_file: ?**glib.Bytes) ?*glib.HashTable;
pub const formDecodeMultipart = soup_form_decode_multipart;

/// Encodes the given field names and values into a value of type
/// "application/x-www-form-urlencoded".
///
/// Encodes as defined in the HTML 4.01 spec.
///
/// This method requires you to know the names of the form fields (or
/// at the very least, the total number of fields) at compile time; for
/// working with dynamic forms, use `formEncodeHash` or
/// `formEncodeDatalist`.
///
/// See also: `Message.newFromEncodedForm`.
extern fn soup_form_encode(p_first_field: [*:0]const u8, ...) [*:0]u8;
pub const formEncode = soup_form_encode;

/// Encodes `form_data_set` into a value of type
/// "application/x-www-form-urlencoded".
///
/// Encodes as defined in the HTML 4.01 spec. Unlike `formEncodeHash`,
/// this preserves the ordering of the form elements, which may be required in
/// some situations.
///
/// See also: `Message.newFromEncodedForm`.
extern fn soup_form_encode_datalist(p_form_data_set: **glib.Data) [*:0]u8;
pub const formEncodeDatalist = soup_form_encode_datalist;

/// Encodes `form_data_set` into a value of type
/// "application/x-www-form-urlencoded".
///
/// Encodes as defined in the HTML 4.01 spec.
///
/// Note that the HTML spec states that "The control names/values are
/// listed in the order they appear in the document." Since this method
/// takes a hash table, it cannot enforce that; if you care about the
/// ordering of the form fields, use `formEncodeDatalist`.
///
/// See also: `Message.newFromEncodedForm`.
extern fn soup_form_encode_hash(p_form_data_set: *glib.HashTable) [*:0]u8;
pub const formEncodeHash = soup_form_encode_hash;

/// See `formEncode`.
///
/// This is mostly an internal method, used by various other methods such as
/// `formEncode`.
///
/// See also: `Message.newFromEncodedForm`.
extern fn soup_form_encode_valist(p_first_field: [*:0]const u8, p_args: std.builtin.VaList) [*:0]u8;
pub const formEncodeValist = soup_form_encode_valist;

/// Returns the major version number of the libsoup library.
///
/// e.g. in libsoup version 2.42.0 this is 2.
///
/// This function is in the library, so it represents the libsoup library
/// your code is running against. Contrast with the `SOUP_MAJOR_VERSION`
/// macro, which represents the major version of the libsoup headers you
/// have included when compiling your code.
extern fn soup_get_major_version() c_uint;
pub const getMajorVersion = soup_get_major_version;

/// Returns the micro version number of the libsoup library.
///
/// e.g. in libsoup version 2.42.0 this is 0.
///
/// This function is in the library, so it represents the libsoup library
/// your code is running against. Contrast with the `SOUP_MICRO_VERSION`
/// macro, which represents the micro version of the libsoup headers you
/// have included when compiling your code.
extern fn soup_get_micro_version() c_uint;
pub const getMicroVersion = soup_get_micro_version;

/// Returns the minor version number of the libsoup library.
///
/// e.g. in libsoup version 2.42.0 this is 42.
///
/// This function is in the library, so it represents the libsoup library
/// your code is running against. Contrast with the `SOUP_MINOR_VERSION`
/// macro, which represents the minor version of the libsoup headers you
/// have included when compiling your code.
extern fn soup_get_minor_version() c_uint;
pub const getMinorVersion = soup_get_minor_version;

/// Parses `header` to see if it contains the token `token` (matched
/// case-insensitively).
///
/// Note that this can't be used with lists that have qvalues.
extern fn soup_header_contains(p_header: [*:0]const u8, p_token: [*:0]const u8) c_int;
pub const headerContains = soup_header_contains;

/// Frees `list`.
extern fn soup_header_free_list(p_list: *glib.SList) void;
pub const headerFreeList = soup_header_free_list;

/// Frees `param_list`.
extern fn soup_header_free_param_list(p_param_list: *glib.HashTable) void;
pub const headerFreeParamList = soup_header_free_param_list;

/// Appends something like `name=value` to `string`, taking care to quote `value`
/// if needed, and if so, to escape any quotes or backslashes in `value`.
///
/// Alternatively, if `value` is a non-ASCII UTF-8 string, it will be
/// appended using RFC5987 syntax. Although in theory this is supposed
/// to work anywhere in HTTP that uses this style of parameter, in
/// reality, it can only be used portably with the Content-Disposition
/// "filename" parameter.
///
/// If `value` is `NULL`, this will just append `name` to `string`.
extern fn soup_header_g_string_append_param(p_string: *glib.String, p_name: [*:0]const u8, p_value: ?[*:0]const u8) void;
pub const headerGStringAppendParam = soup_header_g_string_append_param;

/// Appends something like `name="value"` to
/// `string`, taking care to escape any quotes or backslashes in `value`.
///
/// If `value` is (non-ASCII) UTF-8, this will instead use RFC 5987
/// encoding, just like `headerGStringAppendParam`.
extern fn soup_header_g_string_append_param_quoted(p_string: *glib.String, p_name: [*:0]const u8, p_value: [*:0]const u8) void;
pub const headerGStringAppendParamQuoted = soup_header_g_string_append_param_quoted;

/// Parses a header whose content is described by RFC2616 as ``something``.
///
/// "something" does not itself contain commas, except as part of quoted-strings.
extern fn soup_header_parse_list(p_header: [*:0]const u8) *glib.SList;
pub const headerParseList = soup_header_parse_list;

/// Parses a header which is a comma-delimited list of something like:
/// `token [ "=" ( token | quoted-string ) ]`.
///
/// Tokens that don't have an associated value will still be added to
/// the resulting hash table, but with a `NULL` value.
///
/// This also handles RFC5987 encoding (which in HTTP is mostly used
/// for giving UTF8-encoded filenames in the Content-Disposition
/// header).
extern fn soup_header_parse_param_list(p_header: [*:0]const u8) *glib.HashTable;
pub const headerParseParamList = soup_header_parse_param_list;

/// A strict version of `headerParseParamList`
/// that bails out if there are duplicate parameters.
///
/// Note that this function will treat RFC5987-encoded
/// parameters as duplicated if an ASCII version is also
/// present. For header fields that might contain
/// RFC5987-encoded parameters, use
/// `headerParseParamList` instead.
extern fn soup_header_parse_param_list_strict(p_header: [*:0]const u8) ?*glib.HashTable;
pub const headerParseParamListStrict = soup_header_parse_param_list_strict;

/// Parses a header whose content is a list of items with optional
/// "qvalue"s (eg, Accept, Accept-Charset, Accept-Encoding,
/// Accept-Language, TE).
///
/// If `unacceptable` is not `NULL`, then on return, it will contain the
/// items with qvalue 0. Either way, those items will be removed from
/// the main list.
extern fn soup_header_parse_quality_list(p_header: [*:0]const u8, p_unacceptable: ?**glib.SList) *glib.SList;
pub const headerParseQualityList = soup_header_parse_quality_list;

/// Parses a header which is a semicolon-delimited list of something
/// like: `token [ "=" ( token | quoted-string ) ]`.
///
/// Tokens that don't have an associated value will still be added to
/// the resulting hash table, but with a `NULL` value.
///
/// This also handles RFC5987 encoding (which in HTTP is mostly used
/// for giving UTF8-encoded filenames in the Content-Disposition
/// header).
extern fn soup_header_parse_semi_param_list(p_header: [*:0]const u8) *glib.HashTable;
pub const headerParseSemiParamList = soup_header_parse_semi_param_list;

/// A strict version of `headerParseSemiParamList`
/// that bails out if there are duplicate parameters.
///
/// Note that this function will treat RFC5987-encoded
/// parameters as duplicated if an ASCII version is also
/// present. For header fields that might contain
/// RFC5987-encoded parameters, use
/// `headerParseSemiParamList` instead.
extern fn soup_header_parse_semi_param_list_strict(p_header: [*:0]const u8) ?*glib.HashTable;
pub const headerParseSemiParamListStrict = soup_header_parse_semi_param_list_strict;

/// Parses the headers of an HTTP request or response in `str` and
/// stores the results in `dest`.
///
/// Beware that `dest` may be modified even on failure.
///
/// This is a low-level method; normally you would use
/// `headersParseRequest` or `headersParseResponse`.
extern fn soup_headers_parse(p_str: [*:0]const u8, p_len: c_int, p_dest: *soup.MessageHeaders) c_int;
pub const headersParse = soup_headers_parse;

/// Parses the headers of an HTTP request in `str` and stores the
/// results in `req_method`, `req_path`, `ver`, and `req_headers`.
///
/// Beware that `req_headers` may be modified even on failure.
extern fn soup_headers_parse_request(p_str: [*:0]const u8, p_len: c_int, p_req_headers: *soup.MessageHeaders, p_req_method: ?*[*:0]u8, p_req_path: ?*[*:0]u8, p_ver: ?*soup.HTTPVersion) c_uint;
pub const headersParseRequest = soup_headers_parse_request;

/// Parses the headers of an HTTP response in `str` and stores the
/// results in `ver`, `status_code`, `reason_phrase`, and `headers`.
///
/// Beware that `headers` may be modified even on failure.
extern fn soup_headers_parse_response(p_str: [*:0]const u8, p_len: c_int, p_headers: *soup.MessageHeaders, p_ver: ?*soup.HTTPVersion, p_status_code: ?*c_uint, p_reason_phrase: ?*[*:0]u8) c_int;
pub const headersParseResponse = soup_headers_parse_response;

/// Parses the HTTP Status-Line string in `status_line` into `ver`,
/// `status_code`, and `reason_phrase`.
///
/// `status_line` must be terminated by either "\0" or "\r\n".
extern fn soup_headers_parse_status_line(p_status_line: [*:0]const u8, p_ver: ?*soup.HTTPVersion, p_status_code: ?*c_uint, p_reason_phrase: ?*[*:0]u8) c_int;
pub const headersParseStatusLine = soup_headers_parse_status_line;

/// Looks whether the `domain` passed as argument is a public domain
/// suffix (.org, .com, .co.uk, etc) or not.
///
/// Prior to libsoup 2.46, this function required that `domain` be in
/// UTF-8 if it was an IDN. From 2.46 on, the name can be in either
/// UTF-8 or ASCII format.
extern fn soup_tld_domain_is_public_suffix(p_domain: [*:0]const u8) c_int;
pub const tldDomainIsPublicSuffix = soup_tld_domain_is_public_suffix;

/// Finds the base domain for a given `hostname`
///
/// The base domain is composed by the top level domain (such as .org, .com,
/// .co.uk, etc) plus the second level domain, for example for
/// myhost.mydomain.com it will return mydomain.com.
///
/// Note that `NULL` will be returned for private URLs (those not ending
/// with any well known TLD) because choosing a base domain for them
/// would be totally arbitrary.
///
/// Prior to libsoup 2.46, this function required that `hostname` be in
/// UTF-8 if it was an IDN. From 2.46 on, the name can be in either
/// UTF-8 or ASCII format (and the return value will be in the same
/// format).
extern fn soup_tld_get_base_domain(p_hostname: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]const u8;
pub const tldGetBaseDomain = soup_tld_get_base_domain;

/// As of 3.4.0 this will detect the default ports of HTTP(s) and WS(S)
/// URIs when copying and set it to the default port of the new scheme.
/// So for example copying `http://localhost:80` while changing the scheme to https
/// will result in `https://localhost:443`.
///
/// Return a copy of `uri` with the given components updated.
extern fn soup_uri_copy(p_uri: *glib.Uri, p_first_component: soup.URIComponent, ...) *glib.Uri;
pub const uriCopy = soup_uri_copy;

/// Decodes the given data URI and returns its contents and `content_type`.
extern fn soup_uri_decode_data_uri(p_uri: [*:0]const u8, p_content_type: ?*[*:0]u8) *glib.Bytes;
pub const uriDecodeDataUri = soup_uri_decode_data_uri;

/// Tests whether or not `uri1` and `uri2` are equal in all parts.
extern fn soup_uri_equal(p_uri1: *glib.Uri, p_uri2: *glib.Uri) c_int;
pub const uriEqual = soup_uri_equal;

/// Adds the necessary headers to `msg` to request a WebSocket
/// handshake including supported WebSocket extensions.
///
/// The message body and non-WebSocket-related headers are
/// not modified.
///
/// This is a low-level function; if you use
/// `Session.websocketConnectAsync` to create a WebSocket connection, it
/// will call this for you.
extern fn soup_websocket_client_prepare_handshake(p_msg: *soup.Message, p_origin: ?[*:0]const u8, p_protocols: ?[*][*:0]u8, p_supported_extensions: ?*glib.PtrArray) void;
pub const websocketClientPrepareHandshake = soup_websocket_client_prepare_handshake;

/// Looks at the response status code and headers in `msg` and
/// determines if they contain a valid WebSocket handshake response
/// (given the handshake request in `msg`'s request headers).
///
/// If `supported_extensions` is non-`NULL`, extensions included in the
/// response "Sec-WebSocket-Extensions" are verified too. Accepted
/// extensions are returned in `accepted_extensions` parameter if non-`NULL`.
///
/// This is a low-level function; if you use
/// `Session.websocketConnectAsync` to create a WebSocket
/// connection, it will call this for you.
extern fn soup_websocket_client_verify_handshake(p_msg: *soup.Message, p_supported_extensions: ?*glib.PtrArray, p_accepted_extensions: ?**glib.List, p_error: ?*?*glib.Error) c_int;
pub const websocketClientVerifyHandshake = soup_websocket_client_verify_handshake;

/// Examines the method and request headers in `msg` and determines
/// whether `msg` contains a valid handshake request.
///
/// If `origin` is non-`NULL`, then only requests containing a matching
/// "Origin" header will be accepted. If `protocols` is non-`NULL`, then
/// only requests containing a compatible "Sec-WebSocket-Protocols"
/// header will be accepted. If `supported_extensions` is non-`NULL`, then
/// only requests containing valid supported extensions in
/// "Sec-WebSocket-Extensions" header will be accepted.
///
/// Normally `websocketServerProcessHandshake`
/// will take care of this for you, and if you use
/// `Server.addWebsocketHandler` to handle accepting WebSocket
/// connections, it will call that for you. However, this function may
/// be useful if you need to perform more complicated validation; eg,
/// accepting multiple different Origins, or handling different protocols
/// depending on the path.
extern fn soup_websocket_server_check_handshake(p_msg: *soup.ServerMessage, p_origin: ?[*:0]const u8, p_protocols: ?[*][*:0]u8, p_supported_extensions: ?*glib.PtrArray, p_error: ?*?*glib.Error) c_int;
pub const websocketServerCheckHandshake = soup_websocket_server_check_handshake;

/// Examines the method and request headers in `msg` and (assuming `msg`
/// contains a valid handshake request), fills in the handshake
/// response.
///
/// If `expected_origin` is non-`NULL`, then only requests containing a matching
/// "Origin" header will be accepted. If `protocols` is non-`NULL`, then
/// only requests containing a compatible "Sec-WebSocket-Protocols"
/// header will be accepted. If `supported_extensions` is non-`NULL`, then
/// only requests containing valid supported extensions in
/// "Sec-WebSocket-Extensions" header will be accepted. The accepted extensions
/// will be returned in `accepted_extensions` parameter if non-`NULL`.
///
/// This is a low-level function; if you use
/// `Server.addWebsocketHandler` to handle accepting WebSocket
/// connections, it will call this for you.
extern fn soup_websocket_server_process_handshake(p_msg: *soup.ServerMessage, p_expected_origin: ?[*:0]const u8, p_protocols: ?[*][*:0]u8, p_supported_extensions: ?*glib.PtrArray, p_accepted_extensions: ?**glib.List) c_int;
pub const websocketServerProcessHandshake = soup_websocket_server_process_handshake;

/// Callback used by `soup.AuthDomainBasic` for authentication purposes.
///
/// The application should verify that `username` and `password` and valid
/// and return `TRUE` or `FALSE`.
///
/// If you are maintaining your own password database (rather than
/// using the password to authenticate against some other system like
/// PAM or a remote server), you should make sure you know what you are
/// doing. In particular, don't store cleartext passwords, or
/// easily-computed hashes of cleartext passwords, even if you don't
/// care that much about the security of your server, because users
/// will frequently use the same password for multiple sites, and so
/// compromising any site with a cleartext (or easily-cracked) password
/// database may give attackers access to other more-interesting sites
/// as well.
pub const AuthDomainBasicAuthCallback = *const fn (p_domain: *soup.AuthDomainBasic, p_msg: *soup.ServerMessage, p_username: [*:0]const u8, p_password: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Callback used by `soup.AuthDomainDigest` for authentication purposes.
///
/// The application should look up `username` in its password database,
/// and return the corresponding encoded password (see
/// `AuthDomainDigest.encodePassword`.
pub const AuthDomainDigestAuthCallback = *const fn (p_domain: *soup.AuthDomainDigest, p_msg: *soup.ServerMessage, p_username: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) ?[*:0]u8;

/// The prototype for a `soup.AuthDomain` filter.
///
/// See `AuthDomain.setFilter` for details.
pub const AuthDomainFilter = *const fn (p_domain: *soup.AuthDomain, p_msg: *soup.ServerMessage, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// The prototype for a `soup.AuthDomain` generic authentication callback.
///
/// The callback should look up the user's password, call
/// `AuthDomain.checkPassword`, and use the return value from that method
/// as its own return value.
///
/// In general, for security reasons, it is preferable to use the
/// auth-domain-specific auth callbacks (eg,
/// `AuthDomainBasicAuthCallback` and
/// `AuthDomainDigestAuthCallback`), because they don't require
/// keeping a cleartext password database. Most users will use the same
/// password for many different sites, meaning if any site with a
/// cleartext password database is compromised, accounts on other
/// servers might be compromised as well. For many of the cases where
/// `Server` is used, this is not really relevant, but it may still
/// be worth considering.
pub const AuthDomainGenericAuthCallback = *const fn (p_domain: *soup.AuthDomain, p_msg: *soup.ServerMessage, p_username: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// The prototype for a logging filter.
///
/// The filter callback will be invoked for each request or response, and should
/// analyze it and return a `LoggerLogLevel` value indicating how much of
/// the message to log.
pub const LoggerFilter = *const fn (p_logger: *soup.Logger, p_msg: *soup.Message, p_user_data: ?*anyopaque) callconv(.c) soup.LoggerLogLevel;

/// The prototype for a custom printing callback.
///
/// `level` indicates what kind of information is being printed. Eg, it
/// will be `SOUP_LOGGER_LOG_HEADERS` if `data` is header data.
///
/// `direction` is either '<', '>', or ' ', and `data` is the single line
/// to print; the printer is expected to add a terminating newline.
///
/// To get the effect of the default printer, you would do:
///
/// ```c
/// printf ("`c` `s`\n", direction, data);
/// ```
pub const LoggerPrinter = *const fn (p_logger: *soup.Logger, p_level: soup.LoggerLogLevel, p_direction: u8, p_data: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

/// The callback passed to `MessageHeaders.foreach`.
pub const MessageHeadersForeachFunc = *const fn (p_name: [*:0]const u8, p_value: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

/// A callback used to handle requests to a `Server`.
///
/// `path` and `query` contain the likewise-named components of the
/// Request-URI, subject to certain assumptions. By default,
/// `Server` decodes all percent-encoding in the URI path, such that
/// `"/foo`@"2Fbar"`"` is treated the same as `"/foo/bar"`. If your
/// server is serving resources in some non-POSIX-filesystem namespace,
/// you may want to distinguish those as two distinct paths. In that
/// case, you can set the `Server.properties.raw_paths` property when creating
/// the `Server`, and it will leave those characters undecoded.
///
/// `query` contains the query component of the Request-URI parsed according to
/// the rules for HTML form handling. Although this is the only commonly-used
/// query string format in HTTP, there is nothing that actually requires that
/// HTTP URIs use that format; if your server needs to use some other format, you
/// can just ignore `query`, and call `Message.getUri` and parse the URI's
/// query field yourself.
///
/// See `Server.addHandler` and `Server.addEarlyHandler`
/// for details of what handlers can/should do.
pub const ServerCallback = *const fn (p_server: *soup.Server, p_msg: *soup.ServerMessage, p_path: [*:0]const u8, p_query: ?*glib.HashTable, p_user_data: ?*anyopaque) callconv(.c) void;

/// A callback used to handle WebSocket requests to a `soup.Server`.
///
/// The callback will be invoked after sending the handshake response back to the
/// client (and is only invoked if the handshake was successful).
///
/// `path` contains the path of the Request-URI, subject to the same
/// rules as `ServerCallback` `(qv)`.
pub const ServerWebsocketCallback = *const fn (p_server: *soup.Server, p_msg: *soup.ServerMessage, p_path: [*:0]const u8, p_connection: *soup.WebsocketConnection, p_user_data: ?*anyopaque) callconv(.c) void;

/// A constant corresponding to 1 day.
///
/// For use with `Cookie.new` and `Cookie.setMaxAge`.
pub const COOKIE_MAX_AGE_ONE_DAY = 0;
/// A constant corresponding to 1 hour.
///
/// For use with `Cookie.new` and `Cookie.setMaxAge`.
pub const COOKIE_MAX_AGE_ONE_HOUR = 3600;
/// A constant corresponding to 1 week.
///
/// For use with `Cookie.new` and `Cookie.setMaxAge`.
pub const COOKIE_MAX_AGE_ONE_WEEK = 0;
/// A constant corresponding to 1 year.
///
/// For use with `Cookie.new` and `Cookie.setMaxAge`.
pub const COOKIE_MAX_AGE_ONE_YEAR = 0;
/// A macro containing the value
/// `multipart/form-data`; the MIME type used for
/// posting form data that contains files to be uploaded.
pub const FORM_MIME_TYPE_MULTIPART = "multipart/form-data";
/// A macro containing the value
/// `application/x-www-form-urlencoded`; the default
/// MIME type for POSTing HTML form data.
pub const FORM_MIME_TYPE_URLENCODED = "application/x-www-form-urlencoded";
/// An expiration date that is always in the past.
pub const HSTS_POLICY_MAX_AGE_PAST = 0;
/// The set of `glib.UriFlags` libsoup expects all `glib.Uri` to use.
pub const HTTP_URI_FLAGS = 482;
/// Like `getMajorVersion`, but from the headers used at application
/// compile time, rather than from the library linked against at application run
/// time.
pub const MAJOR_VERSION = 3;
/// Like `getMicroVersion`, but from the headers used at
/// application compile time, rather than from the library linked
/// against at application run time.
pub const MICRO_VERSION = 5;
/// Like `getMinorVersion`, but from the headers used at
/// application compile time, rather than from the library linked
/// against at application run time.
pub const MINOR_VERSION = 6;
/// A macro that should be defined by the user prior to including
/// `libsoup.h`.
///
/// The definition should be one of the predefined libsoup
/// version macros: `SOUP_VERSION_2_24`, `SOUP_VERSION_2_26`, ...
///
/// This macro defines the earliest version of libsoup that the package
/// is required to be able to compile against.
///
/// If the compiler is configured to warn about the use of deprecated
/// functions, then using functions that were deprecated in version
/// `SOUP_VERSION_MIN_REQUIRED` or earlier will cause warnings (but
/// using functions deprecated in later releases will not).
pub const VERSION_MIN_REQUIRED = 2;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
