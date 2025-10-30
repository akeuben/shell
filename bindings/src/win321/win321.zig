pub const ext = @import("ext.zig");
const win32 = @This();

const std = @import("std");
const compat = @import("compat");
pub const HWND = c_uint;

pub const HICON = c_ulong;

pub const HCURSOR = c_ulong;

pub const HGDIOBJ = c_ulong;

pub const MSG = opaque {
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
