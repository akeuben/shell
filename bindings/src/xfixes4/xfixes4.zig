pub const ext = @import("ext.zig");
const xfixes = @This();

const std = @import("std");
const compat = @import("compat");
pub const XserverRegion = opaque {
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
