pub const ext = @import("ext.zig");
const dbusglib = @This();

const std = @import("std");
const compat = @import("compat");
const gobject = @import("gobject2");
const glib = @import("glib2");
pub const Proxy = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Proxy;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn dbus_g_proxy_get_type() usize;
    pub const getGObjectType = dbus_g_proxy_get_type;

    extern fn g_object_ref(p_self: *dbusglib.Proxy) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *dbusglib.Proxy) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Proxy, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Connection = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MethodInvocation = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProxyClass = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
