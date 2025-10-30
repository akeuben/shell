pub const ext = @import("ext.zig");
const astalgreet = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// Base Request type.
pub const Request = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.RequestClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalgreet.RequestPrivate,

    pub const virtual_methods = struct {
        pub const get_type_name = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Request.Class, p_class).f_get_type_name.?(gobject.ext.as(Request, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Request.Class, p_class).f_get_type_name = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const type_name = struct {
            pub const name = "type-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Send this request to greetd.
    extern fn astal_greet_request_send(p_self: *Request, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const send = astal_greet_request_send;

    extern fn astal_greet_request_send_finish(p_self: *Request, p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*astalgreet.Response;
    pub const sendFinish = astal_greet_request_send_finish;

    extern fn astal_greet_request_get_type_name(p_self: *Request) [*:0]const u8;
    pub const getTypeName = astal_greet_request_get_type_name;

    extern fn astal_greet_request_get_type() usize;
    pub const getGObjectType = astal_greet_request_get_type;

    extern fn g_object_ref(p_self: *astalgreet.Request) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.Request) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Request, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Creates a session and initiates a login attempted for the given user. The session is ready to be started if a success is returned.
pub const CreateSession = extern struct {
    pub const Parent = astalgreet.Request;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.CreateSessionClass;
    f_parent_instance: astalgreet.Request,
    f_priv: ?*astalgreet.CreateSessionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const username = struct {
            pub const name = "username";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_greet_create_session_new(p_username: [*:0]const u8) *astalgreet.CreateSession;
    pub const new = astal_greet_create_session_new;

    extern fn astal_greet_create_session_get_username(p_self: *CreateSession) [*:0]const u8;
    pub const getUsername = astal_greet_create_session_get_username;

    extern fn astal_greet_create_session_set_username(p_self: *CreateSession, p_value: [*:0]const u8) void;
    pub const setUsername = astal_greet_create_session_set_username;

    extern fn astal_greet_create_session_get_type() usize;
    pub const getGObjectType = astal_greet_create_session_get_type;

    extern fn g_object_ref(p_self: *astalgreet.CreateSession) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.CreateSession) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CreateSession, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Answers an authentication message. If the message was informative (info, error), then a response does not need to be set in this
/// message. The session is ready to be started if a success is returned.
pub const PostAuthMesssage = extern struct {
    pub const Parent = astalgreet.Request;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.PostAuthMesssageClass;
    f_parent_instance: astalgreet.Request,
    f_priv: ?*astalgreet.PostAuthMesssagePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const response = struct {
            pub const name = "response";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_greet_post_auth_messsage_new(p_response: [*:0]const u8) *astalgreet.PostAuthMesssage;
    pub const new = astal_greet_post_auth_messsage_new;

    extern fn astal_greet_post_auth_messsage_get_response(p_self: *PostAuthMesssage) [*:0]const u8;
    pub const getResponse = astal_greet_post_auth_messsage_get_response;

    extern fn astal_greet_post_auth_messsage_set_response(p_self: *PostAuthMesssage, p_value: [*:0]const u8) void;
    pub const setResponse = astal_greet_post_auth_messsage_set_response;

    extern fn astal_greet_post_auth_messsage_get_type() usize;
    pub const getGObjectType = astal_greet_post_auth_messsage_get_type;

    extern fn g_object_ref(p_self: *astalgreet.PostAuthMesssage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.PostAuthMesssage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PostAuthMesssage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Requests for the session to be started using the provided command line, adding the supplied environment to that created by PAM. The session
/// will start after the greeter process terminates
pub const StartSession = extern struct {
    pub const Parent = astalgreet.Request;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.StartSessionClass;
    f_parent_instance: astalgreet.Request,
    f_priv: ?*astalgreet.StartSessionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const cmd = struct {
            pub const name = "cmd";

            pub const Type = ?[*][*:0]u8;
        };

        pub const env = struct {
            pub const name = "env";

            pub const Type = ?[*][*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_greet_start_session_new(p_cmd: [*][*:0]u8, p_cmd_length1: c_int, p_env: [*][*:0]u8, p_env_length1: c_int) *astalgreet.StartSession;
    pub const new = astal_greet_start_session_new;

    extern fn astal_greet_start_session_get_cmd(p_self: *StartSession, p_result_length1: *c_int) [*][*:0]u8;
    pub const getCmd = astal_greet_start_session_get_cmd;

    extern fn astal_greet_start_session_set_cmd(p_self: *StartSession, p_value: [*][*:0]u8, p_value_length1: c_int) void;
    pub const setCmd = astal_greet_start_session_set_cmd;

    extern fn astal_greet_start_session_get_env(p_self: *StartSession, p_result_length1: *c_int) [*][*:0]u8;
    pub const getEnv = astal_greet_start_session_get_env;

    extern fn astal_greet_start_session_set_env(p_self: *StartSession, p_value: [*][*:0]u8, p_value_length1: c_int) void;
    pub const setEnv = astal_greet_start_session_set_env;

    extern fn astal_greet_start_session_get_type() usize;
    pub const getGObjectType = astal_greet_start_session_get_type;

    extern fn g_object_ref(p_self: *astalgreet.StartSession) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.StartSession) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StartSession, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Cancels the session that is currently under configuration.
pub const CancelSession = extern struct {
    pub const Parent = astalgreet.Request;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.CancelSessionClass;
    f_parent_instance: astalgreet.Request,
    f_priv: ?*astalgreet.CancelSessionPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn astal_greet_cancel_session_new() *astalgreet.CancelSession;
    pub const new = astal_greet_cancel_session_new;

    extern fn astal_greet_cancel_session_get_type() usize;
    pub const getGObjectType = astal_greet_cancel_session_get_type;

    extern fn g_object_ref(p_self: *astalgreet.CancelSession) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.CancelSession) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CancelSession, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Base Response type.
pub const Response = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.ResponseClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalgreet.ResponsePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn astal_greet_response_get_type() usize;
    pub const getGObjectType = astal_greet_response_get_type;

    extern fn g_object_ref(p_self: *astalgreet.Response) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.Response) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Response, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates that the request succeeded.
pub const Success = extern struct {
    pub const Parent = astalgreet.Response;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.SuccessClass;
    f_parent_instance: astalgreet.Response,
    f_priv: ?*astalgreet.SuccessPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn astal_greet_success_get_type() usize;
    pub const getGObjectType = astal_greet_success_get_type;

    extern fn g_object_ref(p_self: *astalgreet.Success) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.Success) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Success, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates that the request succeeded.
pub const Error = extern struct {
    pub const Parent = astalgreet.Response;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.ErrorClass;
    f_parent_instance: astalgreet.Response,
    f_priv: ?*astalgreet.ErrorPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const error_type = struct {
            pub const name = "error-type";

            pub const Type = astalgreet.ErrorType;
        };

        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_greet_error_get_error_type(p_self: *Error) astalgreet.ErrorType;
    pub const getErrorType = astal_greet_error_get_error_type;

    extern fn astal_greet_error_get_description(p_self: *Error) [*:0]const u8;
    pub const getDescription = astal_greet_error_get_description;

    extern fn astal_greet_error_get_type() usize;
    pub const getGObjectType = astal_greet_error_get_type;

    extern fn g_object_ref(p_self: *astalgreet.Error) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.Error) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Error, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates that the request succeeded.
pub const AuthMessage = extern struct {
    pub const Parent = astalgreet.Response;
    pub const Implements = [_]type{};
    pub const Class = astalgreet.AuthMessageClass;
    f_parent_instance: astalgreet.Response,
    f_priv: ?*astalgreet.AuthMessagePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const message_type = struct {
            pub const name = "message-type";

            pub const Type = astalgreet.AuthMessageType;
        };

        pub const message = struct {
            pub const name = "message";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_greet_auth_message_get_message_type(p_self: *AuthMessage) astalgreet.AuthMessageType;
    pub const getMessageType = astal_greet_auth_message_get_message_type;

    extern fn astal_greet_auth_message_get_message(p_self: *AuthMessage) [*:0]const u8;
    pub const getMessage = astal_greet_auth_message_get_message;

    extern fn astal_greet_auth_message_get_type() usize;
    pub const getGObjectType = astal_greet_auth_message_get_type;

    extern fn g_object_ref(p_self: *astalgreet.AuthMessage) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalgreet.AuthMessage) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AuthMessage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RequestClass = extern struct {
    pub const Instance = astalgreet.Request;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *RequestClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RequestPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CreateSessionClass = extern struct {
    pub const Instance = astalgreet.CreateSession;

    f_parent_class: astalgreet.RequestClass,

    pub fn as(p_instance: *CreateSessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CreateSessionPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PostAuthMesssageClass = extern struct {
    pub const Instance = astalgreet.PostAuthMesssage;

    f_parent_class: astalgreet.RequestClass,

    pub fn as(p_instance: *PostAuthMesssageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PostAuthMesssagePrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StartSessionClass = extern struct {
    pub const Instance = astalgreet.StartSession;

    f_parent_class: astalgreet.RequestClass,

    pub fn as(p_instance: *StartSessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StartSessionPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CancelSessionClass = extern struct {
    pub const Instance = astalgreet.CancelSession;

    f_parent_class: astalgreet.RequestClass,

    pub fn as(p_instance: *CancelSessionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CancelSessionPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ResponseClass = extern struct {
    pub const Instance = astalgreet.Response;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ResponseClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ResponsePrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SuccessClass = extern struct {
    pub const Instance = astalgreet.Success;

    f_parent_class: astalgreet.ResponseClass,

    pub fn as(p_instance: *SuccessClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SuccessPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ErrorClass = extern struct {
    pub const Instance = astalgreet.Error;

    f_parent_class: astalgreet.ResponseClass,

    pub fn as(p_instance: *ErrorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ErrorPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AuthMessageClass = extern struct {
    pub const Instance = astalgreet.AuthMessage;

    f_parent_class: astalgreet.ResponseClass,

    pub fn as(p_instance: *AuthMessageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AuthMessagePrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ErrorType = enum(c_int) {
    auth_error = 0,
    @"error" = 1,
    _,

    extern fn astal_greet_error_type_get_type() usize;
    pub const getGObjectType = astal_greet_error_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AuthMessageType = enum(c_int) {
    visible = 0,
    secret = 1,
    info = 2,
    @"error" = 3,
    _,

    extern fn astal_greet_auth_message_type_get_type() usize;
    pub const getGObjectType = astal_greet_auth_message_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Shorthand for creating a session, posting the password, and starting the session with the given `cmd` which is parsed with [func@
/// GLib.shell_parse_argv].
extern fn astal_greet_login(p_username: [*:0]const u8, p_password: [*:0]const u8, p_cmd: [*:0]const u8, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
pub const login = astal_greet_login;

extern fn astal_greet_login_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
pub const loginFinish = astal_greet_login_finish;

/// Same as `astalgreet.login` but allow for setting additonal env in the form of `name=value` pairs.
extern fn astal_greet_login_with_env(p_username: [*:0]const u8, p_password: [*:0]const u8, p_cmd: [*:0]const u8, p_env: [*][*:0]u8, p_env_length1: c_int, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
pub const loginWithEnv = astal_greet_login_with_env;

extern fn astal_greet_login_with_env_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
pub const loginWithEnvFinish = astal_greet_login_with_env_finish;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
