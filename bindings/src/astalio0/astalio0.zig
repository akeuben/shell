pub const ext = @import("ext.zig");
const astalio = @This();

const std = @import("std");
const compat = @import("compat");
const glib = @import("glib2");
const gobject = @import("gobject2");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
pub const Daemon = extern struct {
    pub const Parent = gio.Application;
    pub const Implements = [_]type{astalio.Application};
    pub const Class = astalio.DaemonClass;
    f_parent_instance: gio.Application,
    f_priv: ?*astalio.DaemonPrivate,

    pub const virtual_methods = struct {
        /// Handler for an incoming request.
        pub const request = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_request: [*:0]const u8, p_conn: *gio.SocketConnection) void {
                return gobject.ext.as(Daemon.Class, p_class).f_request.?(gobject.ext.as(Daemon, p_self), p_request, p_conn);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_request: [*:0]const u8, p_conn: *gio.SocketConnection) callconv(.c) void) void {
                gobject.ext.as(Daemon.Class, p_class).f_request = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn astal_io_daemon_new() *astalio.Daemon;
    pub const new = astal_io_daemon_new;

    /// Handler for an incoming request.
    extern fn astal_io_daemon_request(p_self: *Daemon, p_request: [*:0]const u8, p_conn: *gio.SocketConnection) void;
    pub const request = astal_io_daemon_request;

    extern fn astal_io_daemon_get_type() usize;
    pub const getGObjectType = astal_io_daemon_get_type;

    extern fn g_object_ref(p_self: *astalio.Daemon) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalio.Daemon) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Daemon, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `Process` provides shortcuts for `gio.Subprocess` with sane defaults.
pub const Process = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalio.ProcessClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalio.ProcessPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const argv = struct {
            pub const name = "argv";

            pub const Type = ?[*][*:0]u8;
        };
    };

    pub const signals = struct {
        /// When the underlying subprocess writes to its stdout.
        pub const stdout = struct {
            pub const name = "stdout";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_out: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Process, p_instance))),
                    gobject.signalLookup("stdout", Process.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// When the underlying subprocess writes to its stderr.
        pub const stderr = struct {
            pub const name = "stderr";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_err: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Process, p_instance))),
                    gobject.signalLookup("stderr", Process.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// When the underlying subprocess exits or is terminated.
        pub const exit = struct {
            pub const name = "exit";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_code: c_int, p_terminated: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Process, p_instance))),
                    gobject.signalLookup("exit", Process.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Start a new subprocess with the given command.
    /// The first element of the vector is executed with the remaining elements as the argument list.
    extern fn astal_io_process_subprocessv(p_cmd: [*][*:0]u8, p_cmd_length1: c_int, p_error: ?*?*glib.Error) ?*astalio.Process;
    pub const subprocessv = astal_io_process_subprocessv;

    /// Start a new subprocess with the given command which is parsed using `glib.shellParseArgv`.
    extern fn astal_io_process_subprocess(p_cmd: [*:0]const u8, p_error: ?*?*glib.Error) ?*astalio.Process;
    pub const subprocess = astal_io_process_subprocess;

    /// Execute a command synchronously. The first element of the vector is executed with the remaining elements as the argument list.
    extern fn astal_io_process_execv(p_cmd: [*][*:0]u8, p_cmd_length1: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const execv = astal_io_process_execv;

    /// Execute a command synchronously. The command is parsed using `glib.shellParseArgv`.
    extern fn astal_io_process_exec(p_cmd: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const exec = astal_io_process_exec;

    /// Execute a command asynchronously. The first element of the vector is executed with the remaining elements as the argument list.
    extern fn astal_io_process_exec_asyncv(p_cmd: [*][*:0]u8, p_cmd_length1: c_int, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const execAsyncv = astal_io_process_exec_asyncv;

    extern fn astal_io_process_exec_asyncv_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const execAsyncvFinish = astal_io_process_exec_asyncv_finish;

    /// Execute a command asynchronously. The command is parsed using `glib.shellParseArgv`.
    extern fn astal_io_process_exec_async(p_cmd: [*:0]const u8, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const execAsync = astal_io_process_exec_async;

    extern fn astal_io_process_exec_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const execFinish = astal_io_process_exec_finish;

    /// See `astalio.Process.subprocessv`
    extern fn astal_io_process_new(p_cmd: [*][*:0]u8, p_cmd_length1: c_int, p_error: ?*?*glib.Error) ?*astalio.Process;
    pub const new = astal_io_process_new;

    /// Force quit the subprocess.
    extern fn astal_io_process_kill(p_self: *Process) void;
    pub const kill = astal_io_process_kill;

    /// Send a signal to the subprocess.
    extern fn astal_io_process_signal(p_self: *Process, p_signal_num: c_int) void;
    pub const signal = astal_io_process_signal;

    /// Write a line to the subprocess' stdin synchronously.
    extern fn astal_io_process_write(p_self: *Process, p_in: [*:0]const u8, p_error: ?*?*glib.Error) void;
    pub const write = astal_io_process_write;

    /// Write a line to the subprocess' stdin asynchronously.
    extern fn astal_io_process_write_async(p_self: *Process, p_in: [*:0]const u8, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const writeAsync = astal_io_process_write_async;

    extern fn astal_io_process_write_finish(p_self: *Process, p__res_: *gio.AsyncResult) void;
    pub const writeFinish = astal_io_process_write_finish;

    extern fn astal_io_process_get_argv(p_self: *Process, p_result_length1: *c_int) [*][*:0]u8;
    pub const getArgv = astal_io_process_get_argv;

    extern fn astal_io_process_get_type() usize;
    pub const getGObjectType = astal_io_process_get_type;

    extern fn g_object_ref(p_self: *astalio.Process) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalio.Process) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Process, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `Time` provides shortcuts for GLib timeout functions.
pub const Time = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalio.TimeClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalio.TimePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when the timer ticks.
        pub const now = struct {
            pub const name = "now";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Time, p_instance))),
                    gobject.signalLookup("now", Time.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the timere is cancelled.
        pub const cancelled = struct {
            pub const name = "cancelled";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Time, p_instance))),
                    gobject.signalLookup("cancelled", Time.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Start an interval timer. Ticks immediately then every `interval` milliseconds.
    extern fn astal_io_time_interval(p_interval: c_uint, p_fn: ?*gobject.Closure) *astalio.Time;
    pub const interval = astal_io_time_interval;

    /// Start a timeout timer which ticks after `timeout` milliseconds.
    extern fn astal_io_time_timeout(p_timeout: c_uint, p_fn: ?*gobject.Closure) *astalio.Time;
    pub const timeout = astal_io_time_timeout;

    /// Start a timer which will tick when there are no higher priority tasks pending.
    extern fn astal_io_time_idle(p_fn: ?*gobject.Closure) *astalio.Time;
    pub const idle = astal_io_time_idle;

    /// Start an interval timer with default Priority.
    extern fn astal_io_time_new_interval_prio(p_interval: c_uint, p_prio: c_int, p_fn: ?*gobject.Closure) *astalio.Time;
    pub const intervalPrio = astal_io_time_new_interval_prio;

    /// Start a timeout timer with default Priority.
    extern fn astal_io_time_new_timeout_prio(p_timeout: c_uint, p_prio: c_int, p_fn: ?*gobject.Closure) *astalio.Time;
    pub const timeoutPrio = astal_io_time_new_timeout_prio;

    /// Start an idle timer with default priority.
    extern fn astal_io_time_new_idle_prio(p_prio: c_int, p_fn: ?*gobject.Closure) *astalio.Time;
    pub const idlePrio = astal_io_time_new_idle_prio;

    extern fn astal_io_time_new() *astalio.Time;
    pub const new = astal_io_time_new;

    /// Cancel timer and emit `astalio.Time.signals.cancelled`
    extern fn astal_io_time_cancel(p_self: *Time) void;
    pub const cancel = astal_io_time_cancel;

    extern fn astal_io_time_get_type() usize;
    pub const getGObjectType = astal_io_time_get_type;

    extern fn g_object_ref(p_self: *astalio.Time) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalio.Time) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Time, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VariableBase = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalio.VariableBaseClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalio.VariableBasePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(VariableBase, p_instance))),
                    gobject.signalLookup("changed", VariableBase.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const dropped = struct {
            pub const name = "dropped";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(VariableBase, p_instance))),
                    gobject.signalLookup("dropped", VariableBase.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const @"error" = struct {
            pub const name = "error";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_err: [*:0]const u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(VariableBase, p_instance))),
                    gobject.signalLookup("error", VariableBase.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_io_variable_base_new() *astalio.VariableBase;
    pub const new = astal_io_variable_base_new;

    extern fn astal_io_variable_base_emit_changed(p_self: *VariableBase) void;
    pub const emitChanged = astal_io_variable_base_emit_changed;

    extern fn astal_io_variable_base_emit_dropped(p_self: *VariableBase) void;
    pub const emitDropped = astal_io_variable_base_emit_dropped;

    extern fn astal_io_variable_base_emit_error(p_self: *VariableBase, p_err: [*:0]const u8) void;
    pub const emitError = astal_io_variable_base_emit_error;

    extern fn astal_io_variable_base_get_type() usize;
    pub const getGObjectType = astal_io_variable_base_get_type;

    extern fn g_object_ref(p_self: *astalio.VariableBase) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalio.VariableBase) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VariableBase, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Variable = extern struct {
    pub const Parent = astalio.VariableBase;
    pub const Implements = [_]type{};
    pub const Class = astalio.VariableClass;
    f_parent_instance: astalio.VariableBase,
    f_priv: ?*astalio.VariablePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const value = struct {
            pub const name = "value";

            pub const Type = ?*gobject.Value;
        };
    };

    pub const signals = struct {};

    extern fn astal_io_variable_new(p_init: *gobject.Value) *astalio.Variable;
    pub const new = astal_io_variable_new;

    extern fn astal_io_variable_poll(p_self: *Variable, p_interval: c_uint, p_exec: [*:0]const u8, p_transform: ?*gobject.Closure, p_error: ?*?*glib.Error) ?*astalio.Variable;
    pub const poll = astal_io_variable_poll;

    extern fn astal_io_variable_pollv(p_self: *Variable, p_interval: c_uint, p_execv: [*][*:0]u8, p_execv_length1: c_int, p_transform: ?*gobject.Closure, p_error: ?*?*glib.Error) ?*astalio.Variable;
    pub const pollv = astal_io_variable_pollv;

    extern fn astal_io_variable_pollfn(p_self: *Variable, p_interval: c_uint, p_fn: *gobject.Closure, p_error: ?*?*glib.Error) ?*astalio.Variable;
    pub const pollfn = astal_io_variable_pollfn;

    extern fn astal_io_variable_watch(p_self: *Variable, p_exec: [*:0]const u8, p_transform: ?*gobject.Closure, p_error: ?*?*glib.Error) ?*astalio.Variable;
    pub const watch = astal_io_variable_watch;

    extern fn astal_io_variable_watchv(p_self: *Variable, p_execv: [*][*:0]u8, p_execv_length1: c_int, p_transform: ?*gobject.Closure, p_error: ?*?*glib.Error) ?*astalio.Variable;
    pub const watchv = astal_io_variable_watchv;

    extern fn astal_io_variable_start_poll(p_self: *Variable, p_error: ?*?*glib.Error) void;
    pub const startPoll = astal_io_variable_start_poll;

    extern fn astal_io_variable_start_watch(p_self: *Variable, p_error: ?*?*glib.Error) void;
    pub const startWatch = astal_io_variable_start_watch;

    extern fn astal_io_variable_stop_poll(p_self: *Variable) void;
    pub const stopPoll = astal_io_variable_stop_poll;

    extern fn astal_io_variable_stop_watch(p_self: *Variable) void;
    pub const stopWatch = astal_io_variable_stop_watch;

    extern fn astal_io_variable_is_polling(p_self: *Variable) c_int;
    pub const isPolling = astal_io_variable_is_polling;

    extern fn astal_io_variable_is_watching(p_self: *Variable) c_int;
    pub const isWatching = astal_io_variable_is_watching;

    extern fn astal_io_variable_get_value(p_self: *Variable, p_result: *gobject.Value) void;
    pub const getValue = astal_io_variable_get_value;

    extern fn astal_io_variable_set_value(p_self: *Variable, p_value: *gobject.Value) void;
    pub const setValue = astal_io_variable_set_value;

    extern fn astal_io_variable_get_type() usize;
    pub const getGObjectType = astal_io_variable_get_type;

    extern fn g_object_ref(p_self: *astalio.Variable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalio.Variable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Variable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This interface is used internally in Astal3 and Astal4, not meant for public usage.
pub const Application = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = astalio.ApplicationIface;
    pub const virtual_methods = struct {
        pub const quit = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(Application.Iface, p_class).f_quit.?(gobject.ext.as(Application, p_self), p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(Application.Iface, p_class).f_quit = @ptrCast(p_implementation);
            }
        };

        pub const inspector = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(Application.Iface, p_class).f_inspector.?(gobject.ext.as(Application, p_self), p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(Application.Iface, p_class).f_inspector = @ptrCast(p_implementation);
            }
        };

        pub const toggle_window = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_window: [*:0]const u8, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(Application.Iface, p_class).f_toggle_window.?(gobject.ext.as(Application, p_self), p_window, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_window: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(Application.Iface, p_class).f_toggle_window = @ptrCast(p_implementation);
            }
        };

        pub const acquire_socket = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(Application.Iface, p_class).f_acquire_socket.?(gobject.ext.as(Application, p_self), p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(Application.Iface, p_class).f_acquire_socket = @ptrCast(p_implementation);
            }
        };

        pub const request = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_request: [*:0]const u8, p_conn: *gio.SocketConnection, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(Application.Iface, p_class).f_request.?(gobject.ext.as(Application, p_self), p_request, p_conn, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_request: [*:0]const u8, p_conn: *gio.SocketConnection, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(Application.Iface, p_class).f_request = @ptrCast(p_implementation);
            }
        };

        pub const get_instance_name = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(Application.Iface, p_class).f_get_instance_name.?(gobject.ext.as(Application, p_self));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Application.Iface, p_class).f_get_instance_name = @ptrCast(p_implementation);
            }
        };

        pub const set_instance_name = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: [*:0]const u8) void {
                return gobject.ext.as(Application.Iface, p_class).f_set_instance_name.?(gobject.ext.as(Application, p_self), p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Application.Iface, p_class).f_set_instance_name = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const instance_name = struct {
            pub const name = "instance-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_io_application_quit(p_self: *Application, p_error: ?*?*glib.Error) void;
    pub const quit = astal_io_application_quit;

    extern fn astal_io_application_inspector(p_self: *Application, p_error: ?*?*glib.Error) void;
    pub const inspector = astal_io_application_inspector;

    extern fn astal_io_application_toggle_window(p_self: *Application, p_window: [*:0]const u8, p_error: ?*?*glib.Error) void;
    pub const toggleWindow = astal_io_application_toggle_window;

    extern fn astal_io_application_acquire_socket(p_self: *Application, p_error: ?*?*glib.Error) void;
    pub const acquireSocket = astal_io_application_acquire_socket;

    extern fn astal_io_application_request(p_self: *Application, p_request: [*:0]const u8, p_conn: *gio.SocketConnection, p_error: ?*?*glib.Error) void;
    pub const request = astal_io_application_request;

    extern fn astal_io_application_get_instance_name(p_self: *Application) [*:0]u8;
    pub const getInstanceName = astal_io_application_get_instance_name;

    extern fn astal_io_application_set_instance_name(p_self: *Application, p_value: [*:0]const u8) void;
    pub const setInstanceName = astal_io_application_set_instance_name;

    extern fn astal_io_application_get_type() usize;
    pub const getGObjectType = astal_io_application_get_type;

    extern fn g_object_ref(p_self: *astalio.Application) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalio.Application) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Application, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DaemonClass = extern struct {
    pub const Instance = astalio.Daemon;

    f_parent_class: gio.ApplicationClass,
    f_request: ?*const fn (p_self: *astalio.Daemon, p_request: [*:0]const u8, p_conn: *gio.SocketConnection) callconv(.c) void,

    pub fn as(p_instance: *DaemonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DaemonPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProcessClass = extern struct {
    pub const Instance = astalio.Process;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ProcessClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProcessPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TimeClass = extern struct {
    pub const Instance = astalio.Time;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *TimeClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TimePrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VariableBaseClass = extern struct {
    pub const Instance = astalio.VariableBase;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *VariableBaseClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VariableBasePrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VariableClass = extern struct {
    pub const Instance = astalio.Variable;

    f_parent_class: astalio.VariableBaseClass,

    pub fn as(p_instance: *VariableClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VariablePrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationIface = extern struct {
    pub const Instance = astalio.Application;

    f_parent_iface: gobject.TypeInterface,
    f_quit: ?*const fn (p_self: *astalio.Application, p_error: ?*?*glib.Error) callconv(.c) void,
    f_inspector: ?*const fn (p_self: *astalio.Application, p_error: ?*?*glib.Error) callconv(.c) void,
    f_toggle_window: ?*const fn (p_self: *astalio.Application, p_window: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) void,
    f_acquire_socket: ?*const fn (p_self: *astalio.Application, p_error: ?*?*glib.Error) callconv(.c) void,
    f_request: ?*const fn (p_self: *astalio.Application, p_request: [*:0]const u8, p_conn: *gio.SocketConnection, p_error: ?*?*glib.Error) callconv(.c) void,
    f_get_instance_name: ?*const fn (p_self: *astalio.Application) callconv(.c) [*:0]u8,
    f_set_instance_name: ?*const fn (p_self: *astalio.Application, p_value: [*:0]const u8) callconv(.c) void,

    pub fn as(p_instance: *ApplicationIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AppError = enum(c_int) {
    name_occupied = 0,
    takeover_failed = 1,
    _,

    extern fn astal_io_app_error_get_type() usize;
    pub const getGObjectType = astal_io_app_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Starts a `gio.SocketService` and binds `XDG_RUNTIME_DIR/astal/<instance_name>.sock`. This socket is then used by the astal
/// cli. Not meant for public usage, but for `astalio.Application.acquireSocket`.
extern fn astal_io_acquire_socket(p_app: *astalio.Application, p_sock: *[*:0]u8, p_error: ?*?*glib.Error) ?*gio.SocketService;
pub const acquireSocket = astal_io_acquire_socket;

/// Get a list of running Astal.Application instances. It is the equivalent of `astal --list`.
extern fn astal_io_get_instances() *glib.List;
pub const getInstances = astal_io_get_instances;

/// Quit an an Astal instances. It is the equivalent of `astal --quit -i instance`.
extern fn astal_io_quit_instance(p_instance: [*:0]const u8, p_error: ?*?*glib.Error) void;
pub const quitInstance = astal_io_quit_instance;

/// Open the Gtk debug tool of an an Astal instances. It is the equivalent of `astal --inspector -i instance`.
extern fn astal_io_open_inspector(p_instance: [*:0]const u8, p_error: ?*?*glib.Error) void;
pub const openInspector = astal_io_open_inspector;

/// Toggle a Window of an Astal instances. It is the equivalent of `astal -i instance --toggle window`.
extern fn astal_io_toggle_window_by_name(p_instance: [*:0]const u8, p_window: [*:0]const u8, p_error: ?*?*glib.Error) void;
pub const toggleWindowByName = astal_io_toggle_window_by_name;

/// Use `astalio.sendRequest` instead.
extern fn astal_io_send_message(p_instance: [*:0]const u8, p_request: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
pub const sendMessage = astal_io_send_message;

/// Send a request to an Astal instances. It is the equivalent of `astal -i instance "request content"`.
extern fn astal_io_send_request(p_instance: [*:0]const u8, p_request: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
pub const sendRequest = astal_io_send_request;

/// Read the socket of an Astal.Application instance.
extern fn astal_io_read_sock(p_conn: *gio.SocketConnection, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
pub const readSock = astal_io_read_sock;

extern fn astal_io_read_sock_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
pub const readSockFinish = astal_io_read_sock_finish;

/// Write the socket of an Astal.Application instance.
extern fn astal_io_write_sock(p_conn: *gio.SocketConnection, p_response: [*:0]const u8, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
pub const writeSock = astal_io_write_sock;

extern fn astal_io_write_sock_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
pub const writeSockFinish = astal_io_write_sock_finish;

/// Read the contents of a file synchronously.
extern fn astal_io_read_file(p_path: [*:0]const u8) [*:0]u8;
pub const readFile = astal_io_read_file;

/// Read the contents of a file asynchronously.
extern fn astal_io_read_file_async(p_path: [*:0]const u8, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
pub const readFileAsync = astal_io_read_file_async;

extern fn astal_io_read_file_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
pub const readFileFinish = astal_io_read_file_finish;

/// Write content to a file synchronously.
extern fn astal_io_write_file(p_path: [*:0]const u8, p_content: [*:0]const u8) void;
pub const writeFile = astal_io_write_file;

/// Write content to a file asynchronously.
extern fn astal_io_write_file_async(p_path: [*:0]const u8, p_content: [*:0]const u8, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
pub const writeFileAsync = astal_io_write_file_async;

extern fn astal_io_write_file_finish(p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
pub const writeFileFinish = astal_io_write_file_finish;

/// Monitor a file for changes. If the path is a directory, monitor it recursively. The callback will be called passed two parameters: the path of
/// the file that changed and an `gio.FileMonitorEvent` indicating the reason.
extern fn astal_io_monitor_file(p_path: [*:0]const u8, p_callback: *gobject.Closure) ?*gio.FileMonitor;
pub const monitorFile = astal_io_monitor_file;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
