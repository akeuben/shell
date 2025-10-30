pub const ext = @import("ext.zig");
const glibunix = @This();

const std = @import("std");
const compat = @import("compat");
const glib = @import("glib2");
/// A Unix pipe. The advantage of this type over `int[2]` is that it can
/// be closed automatically when it goes out of scope, using `g_auto(GUnixPipe)`,
/// on compilers that support that feature.
pub const Pipe = extern struct {
    /// A pair of file descriptors, each negative if closed or not yet opened.
    ///  The file descriptor with index `G_UNIX_PIPE_END_READ` is readable.
    ///  The file descriptor with index `G_UNIX_PIPE_END_WRITE` is writable.
    f_fds: [2]c_int,

    /// Close both ends of the pipe, unless they have already been closed or
    /// stolen. Any errors are ignored: use `glibunix.Pipe.close` or `g_clear_fd`
    /// if error-handling is required.
    ///
    /// This function is async-signal safe if `error` is `NULL` and each member
    /// of `fds` are either negative or a valid open file descriptor.
    /// As a result, it is safe to call this function or use `g_auto(GUnixPipe)`
    /// (on compilers that support it) in a signal handler or a
    /// `glib.SpawnChildSetupFunc`, as long as those conditions are ensured to be true.
    /// See [`signal(7)`](man:signal(7)) and
    /// [`signal-safety(7)`](man:signal-safety(7)) for more details.
    ///
    /// This function preserves the value of `errno`.
    extern fn g_unix_pipe_clear(p_self: *glib.UnixPipe) void;
    pub const clear = g_unix_pipe_clear;

    /// Close one of the ends of the pipe and set the relevant member of `fds`
    /// to `-1` before returning, equivalent to `g_clear_fd`.
    ///
    /// Like `glib.close`, if closing the file descriptor fails, the error is
    /// stored in both `errno` and `error`. If this function succeeds,
    /// `errno` is undefined.
    ///
    /// This function is async-signal safe if `error` is `NULL` and the relevant
    /// member of `fds` is either negative or a valid open file descriptor.
    /// This makes it safe to call from a signal handler or a `glib.SpawnChildSetupFunc`
    /// under those conditions.
    /// See [`signal(7)`](man:signal(7)) and
    /// [`signal-safety(7)`](man:signal-safety(7)) for more details.
    ///
    /// To close both file descriptors and ignore any errors, use
    /// `glibunix.Pipe.clear` instead.
    extern fn g_unix_pipe_close(p_self: *glib.UnixPipe, p_end: glib.UnixPipeEnd, p_error: ?*?*glib.Error) c_int;
    pub const close = g_unix_pipe_close;

    /// Return one of the ends of the pipe. It remains owned by `self`.
    ///
    /// This function is async-signal safe (see [`signal(7)`](man:signal(7)) and
    /// [`signal-safety(7)`](man:signal-safety(7))), making it safe to call from a
    /// signal handler or a `glib.SpawnChildSetupFunc`.
    ///
    /// This function preserves the value of `errno`.
    extern fn g_unix_pipe_get(p_self: *glib.UnixPipe, p_end: glib.UnixPipeEnd) c_int;
    pub const get = g_unix_pipe_get;

    /// Open a pipe. This is the same as `glib.unixOpenPipe`, but uses the
    /// `glib.UnixPipe` data structure.
    extern fn g_unix_pipe_open(p_self: *glib.UnixPipe, p_flags: c_int, p_error: ?*?*glib.Error) c_int;
    pub const open = g_unix_pipe_open;

    /// Return one of the ends of the pipe. It becomes owned by the caller,
    /// and the file descriptor in the data structure is set to `-1`,
    /// similar to `g_steal_fd`.
    ///
    /// This function is async-signal safe (see [`signal(7)`](man:signal(7)) and
    /// [`signal-safety(7)`](man:signal-safety(7))), making it safe to call from a
    /// signal handler or a `glib.SpawnChildSetupFunc`.
    ///
    /// This function preserves the value of `errno`.
    extern fn g_unix_pipe_steal(p_self: *glib.UnixPipe, p_end: glib.UnixPipeEnd) c_int;
    pub const steal = g_unix_pipe_steal;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Mnemonic constants for the ends of a Unix pipe.
pub const PipeEnd = enum(c_int) {
    read = 0,
    write = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn g_closefrom(p_lowfd: c_int) c_int;
pub const closefrom = g_closefrom;

extern fn g_unix_error_quark() glib.Quark;
pub const errorQuark = g_unix_error_quark;

extern fn g_unix_fd_add(p_fd: c_int, p_condition: glib.IOCondition, p_function: glib.UnixFDSourceFunc, p_user_data: ?*anyopaque) c_uint;
pub const fdAdd = g_unix_fd_add;

extern fn g_unix_fd_add_full(p_priority: c_int, p_fd: c_int, p_condition: glib.IOCondition, p_function: glib.UnixFDSourceFunc, p_user_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
pub const fdAddFull = g_unix_fd_add_full;

extern fn g_unix_fd_source_new(p_fd: c_int, p_condition: glib.IOCondition) *glib.Source;
pub const fdSourceNew = g_unix_fd_source_new;

extern fn g_fdwalk_set_cloexec(p_lowfd: c_int) c_int;
pub const fdwalkSetCloexec = g_fdwalk_set_cloexec;

extern fn g_unix_get_passwd_entry(p_user_name: [*:0]const u8, p_error: ?*?*glib.Error) ?*anyopaque;
pub const getPasswdEntry = g_unix_get_passwd_entry;

extern fn g_unix_open_pipe(p_fds: *c_int, p_flags: c_int, p_error: ?*?*glib.Error) c_int;
pub const openPipe = g_unix_open_pipe;

extern fn g_unix_set_fd_nonblocking(p_fd: c_int, p_nonblock: c_int, p_error: ?*?*glib.Error) c_int;
pub const setFdNonblocking = g_unix_set_fd_nonblocking;

extern fn g_unix_signal_add(p_signum: c_int, p_handler: glib.SourceFunc, p_user_data: ?*anyopaque) c_uint;
pub const signalAdd = g_unix_signal_add;

extern fn g_unix_signal_add_full(p_priority: c_int, p_signum: c_int, p_handler: glib.SourceFunc, p_user_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
pub const signalAddFull = g_unix_signal_add_full;

extern fn g_unix_signal_source_new(p_signum: c_int) *glib.Source;
pub const signalSourceNew = g_unix_signal_source_new;

/// The type of functions to be called when a UNIX fd watch source
/// triggers.
pub const FDSourceFunc = *const fn (p_fd: c_int, p_condition: glib.IOCondition, p_user_data: ?*anyopaque) callconv(.c) c_int;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
