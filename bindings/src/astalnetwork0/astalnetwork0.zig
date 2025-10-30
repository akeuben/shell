pub const ext = @import("ext.zig");
const astalnetwork = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const nm = @import("nm1");
pub const AccessPoint = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalnetwork.AccessPointClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalnetwork.AccessPointPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const bandwidth = struct {
            pub const name = "bandwidth";

            pub const Type = c_uint;
        };

        pub const bssid = struct {
            pub const name = "bssid";

            pub const Type = ?[*:0]u8;
        };

        pub const frequency = struct {
            pub const name = "frequency";

            pub const Type = c_uint;
        };

        pub const last_seen = struct {
            pub const name = "last-seen";

            pub const Type = c_int;
        };

        pub const max_bitrate = struct {
            pub const name = "max-bitrate";

            pub const Type = c_uint;
        };

        pub const strength = struct {
            pub const name = "strength";

            pub const Type = u8;
        };

        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        pub const mode = struct {
            pub const name = "mode";

            pub const Type = nm.@"80211Mode";
        };

        pub const flags = struct {
            pub const name = "flags";

            pub const Type = nm.@"80211ApFlags";
        };

        pub const rsn_flags = struct {
            pub const name = "rsn-flags";

            pub const Type = nm.@"80211ApSecurityFlags";
        };

        pub const wpa_flags = struct {
            pub const name = "wpa-flags";

            pub const Type = nm.@"80211ApSecurityFlags";
        };

        pub const requires_password = struct {
            pub const name = "requires-password";

            pub const Type = c_int;
        };

        pub const ssid = struct {
            pub const name = "ssid";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_network_access_point_get_connections(p_self: *AccessPoint) *glib.PtrArray;
    pub const getConnections = astal_network_access_point_get_connections;

    extern fn astal_network_access_point_get_path(p_self: *AccessPoint) [*:0]u8;
    pub const getPath = astal_network_access_point_get_path;

    /// Activates the first connection associated with this AccessPoint or creates a new SimpleConnection using "wpa-psk" and activates it.
    /// Returns whether the connection is the new active connection.
    extern fn astal_network_access_point_activate(p_self: *AccessPoint, p_password: ?[*:0]const u8, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const activate = astal_network_access_point_activate;

    extern fn astal_network_access_point_activate_finish(p_self: *AccessPoint, p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
    pub const activateFinish = astal_network_access_point_activate_finish;

    extern fn astal_network_access_point_get_bandwidth(p_self: *AccessPoint) c_uint;
    pub const getBandwidth = astal_network_access_point_get_bandwidth;

    extern fn astal_network_access_point_get_bssid(p_self: *AccessPoint) [*:0]u8;
    pub const getBssid = astal_network_access_point_get_bssid;

    extern fn astal_network_access_point_get_frequency(p_self: *AccessPoint) c_uint;
    pub const getFrequency = astal_network_access_point_get_frequency;

    extern fn astal_network_access_point_get_last_seen(p_self: *AccessPoint) c_int;
    pub const getLastSeen = astal_network_access_point_get_last_seen;

    extern fn astal_network_access_point_get_max_bitrate(p_self: *AccessPoint) c_uint;
    pub const getMaxBitrate = astal_network_access_point_get_max_bitrate;

    extern fn astal_network_access_point_get_strength(p_self: *AccessPoint) u8;
    pub const getStrength = astal_network_access_point_get_strength;

    extern fn astal_network_access_point_get_icon_name(p_self: *AccessPoint) [*:0]const u8;
    pub const getIconName = astal_network_access_point_get_icon_name;

    extern fn astal_network_access_point_get_mode(p_self: *AccessPoint) nm.@"80211Mode";
    pub const getMode = astal_network_access_point_get_mode;

    extern fn astal_network_access_point_get_flags(p_self: *AccessPoint) nm.@"80211ApFlags";
    pub const getFlags = astal_network_access_point_get_flags;

    extern fn astal_network_access_point_get_rsn_flags(p_self: *AccessPoint) nm.@"80211ApSecurityFlags";
    pub const getRsnFlags = astal_network_access_point_get_rsn_flags;

    extern fn astal_network_access_point_get_wpa_flags(p_self: *AccessPoint) nm.@"80211ApSecurityFlags";
    pub const getWpaFlags = astal_network_access_point_get_wpa_flags;

    extern fn astal_network_access_point_get_requires_password(p_self: *AccessPoint) c_int;
    pub const getRequiresPassword = astal_network_access_point_get_requires_password;

    extern fn astal_network_access_point_get_ssid(p_self: *AccessPoint) ?[*:0]u8;
    pub const getSsid = astal_network_access_point_get_ssid;

    extern fn astal_network_access_point_get_type() usize;
    pub const getGObjectType = astal_network_access_point_get_type;

    extern fn g_object_ref(p_self: *astalnetwork.AccessPoint) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalnetwork.AccessPoint) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AccessPoint, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Network = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalnetwork.NetworkClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalnetwork.NetworkPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const client = struct {
            pub const name = "client";

            pub const Type = ?**nm.Client;
        };

        pub const wifi = struct {
            pub const name = "wifi";

            pub const Type = ?**astalnetwork.Wifi;
        };

        pub const wired = struct {
            pub const name = "wired";

            pub const Type = ?**astalnetwork.Wired;
        };

        pub const primary = struct {
            pub const name = "primary";

            pub const Type = astalnetwork.Primary;
        };

        pub const connectivity = struct {
            pub const name = "connectivity";

            pub const Type = astalnetwork.Connectivity;
        };

        pub const state = struct {
            pub const name = "state";

            pub const Type = astalnetwork.State;
        };
    };

    pub const signals = struct {};

    extern fn astal_network_network_get_default() *astalnetwork.Network;
    pub const getDefault = astal_network_network_get_default;

    extern fn astal_network_network_new() *astalnetwork.Network;
    pub const new = astal_network_network_new;

    extern fn astal_network_network_get_client(p_self: *Network) *nm.Client;
    pub const getClient = astal_network_network_get_client;

    extern fn astal_network_network_get_wifi(p_self: *Network) ?*astalnetwork.Wifi;
    pub const getWifi = astal_network_network_get_wifi;

    extern fn astal_network_network_get_wired(p_self: *Network) ?*astalnetwork.Wired;
    pub const getWired = astal_network_network_get_wired;

    extern fn astal_network_network_get_primary(p_self: *Network) astalnetwork.Primary;
    pub const getPrimary = astal_network_network_get_primary;

    extern fn astal_network_network_get_connectivity(p_self: *Network) astalnetwork.Connectivity;
    pub const getConnectivity = astal_network_network_get_connectivity;

    extern fn astal_network_network_get_state(p_self: *Network) astalnetwork.State;
    pub const getState = astal_network_network_get_state;

    extern fn astal_network_network_get_type() usize;
    pub const getGObjectType = astal_network_network_get_type;

    extern fn g_object_ref(p_self: *astalnetwork.Network) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalnetwork.Network) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Network, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Wifi = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalnetwork.WifiClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalnetwork.WifiPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const device = struct {
            pub const name = "device";

            pub const Type = ?**nm.DeviceWifi;
        };

        pub const active_connection = struct {
            pub const name = "active-connection";

            pub const Type = ?**nm.ActiveConnection;
        };

        pub const active_access_point = struct {
            pub const name = "active-access-point";

            pub const Type = ?**astalnetwork.AccessPoint;
        };

        pub const access_points = struct {
            pub const name = "access-points";

            pub const Type = ?**glib.List;
        };

        pub const enabled = struct {
            pub const name = "enabled";

            pub const Type = c_int;
        };

        pub const internet = struct {
            pub const name = "internet";

            pub const Type = astalnetwork.Internet;
        };

        pub const bandwidth = struct {
            pub const name = "bandwidth";

            pub const Type = c_uint;
        };

        pub const ssid = struct {
            pub const name = "ssid";

            pub const Type = ?[*:0]u8;
        };

        pub const strength = struct {
            pub const name = "strength";

            pub const Type = u8;
        };

        pub const frequency = struct {
            pub const name = "frequency";

            pub const Type = c_uint;
        };

        pub const state = struct {
            pub const name = "state";

            pub const Type = astalnetwork.DeviceState;
        };

        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        pub const is_hotspot = struct {
            pub const name = "is-hotspot";

            pub const Type = c_int;
        };

        pub const scanning = struct {
            pub const name = "scanning";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        pub const state_changed = struct {
            pub const name = "state-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_new_state: astalnetwork.DeviceState, p_old_state: astalnetwork.DeviceState, p_reaseon: nm.DeviceStateReason, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Wifi, p_instance))),
                    gobject.signalLookup("state-changed", Wifi.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_network_wifi_scan(p_self: *Wifi) void;
    pub const scan = astal_network_wifi_scan;

    extern fn astal_network_wifi_deactivate_connection(p_self: *Wifi, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const deactivateConnection = astal_network_wifi_deactivate_connection;

    extern fn astal_network_wifi_deactivate_connection_finish(p_self: *Wifi, p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
    pub const deactivateConnectionFinish = astal_network_wifi_deactivate_connection_finish;

    extern fn astal_network_wifi_get_device(p_self: *Wifi) *nm.DeviceWifi;
    pub const getDevice = astal_network_wifi_get_device;

    extern fn astal_network_wifi_set_device(p_self: *Wifi, p_value: *nm.DeviceWifi) void;
    pub const setDevice = astal_network_wifi_set_device;

    extern fn astal_network_wifi_get_active_connection(p_self: *Wifi) ?*nm.ActiveConnection;
    pub const getActiveConnection = astal_network_wifi_get_active_connection;

    extern fn astal_network_wifi_get_active_access_point(p_self: *Wifi) ?*astalnetwork.AccessPoint;
    pub const getActiveAccessPoint = astal_network_wifi_get_active_access_point;

    extern fn astal_network_wifi_get_access_points(p_self: *Wifi) *glib.List;
    pub const getAccessPoints = astal_network_wifi_get_access_points;

    extern fn astal_network_wifi_get_enabled(p_self: *Wifi) c_int;
    pub const getEnabled = astal_network_wifi_get_enabled;

    extern fn astal_network_wifi_set_enabled(p_self: *Wifi, p_value: c_int) void;
    pub const setEnabled = astal_network_wifi_set_enabled;

    extern fn astal_network_wifi_get_internet(p_self: *Wifi) astalnetwork.Internet;
    pub const getInternet = astal_network_wifi_get_internet;

    extern fn astal_network_wifi_get_bandwidth(p_self: *Wifi) c_uint;
    pub const getBandwidth = astal_network_wifi_get_bandwidth;

    extern fn astal_network_wifi_get_ssid(p_self: *Wifi) [*:0]const u8;
    pub const getSsid = astal_network_wifi_get_ssid;

    extern fn astal_network_wifi_get_strength(p_self: *Wifi) u8;
    pub const getStrength = astal_network_wifi_get_strength;

    extern fn astal_network_wifi_get_frequency(p_self: *Wifi) c_uint;
    pub const getFrequency = astal_network_wifi_get_frequency;

    extern fn astal_network_wifi_get_state(p_self: *Wifi) astalnetwork.DeviceState;
    pub const getState = astal_network_wifi_get_state;

    extern fn astal_network_wifi_get_icon_name(p_self: *Wifi) [*:0]const u8;
    pub const getIconName = astal_network_wifi_get_icon_name;

    extern fn astal_network_wifi_get_is_hotspot(p_self: *Wifi) c_int;
    pub const getIsHotspot = astal_network_wifi_get_is_hotspot;

    extern fn astal_network_wifi_get_scanning(p_self: *Wifi) c_int;
    pub const getScanning = astal_network_wifi_get_scanning;

    extern fn astal_network_wifi_get_type() usize;
    pub const getGObjectType = astal_network_wifi_get_type;

    extern fn g_object_ref(p_self: *astalnetwork.Wifi) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalnetwork.Wifi) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Wifi, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Wired = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalnetwork.WiredClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalnetwork.WiredPrivate,
    f_connection: ?*nm.ActiveConnection,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const device = struct {
            pub const name = "device";

            pub const Type = ?**nm.DeviceEthernet;
        };

        pub const speed = struct {
            pub const name = "speed";

            pub const Type = c_uint;
        };

        pub const internet = struct {
            pub const name = "internet";

            pub const Type = astalnetwork.Internet;
        };

        pub const state = struct {
            pub const name = "state";

            pub const Type = astalnetwork.DeviceState;
        };

        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn astal_network_wired_get_device(p_self: *Wired) *nm.DeviceEthernet;
    pub const getDevice = astal_network_wired_get_device;

    extern fn astal_network_wired_set_device(p_self: *Wired, p_value: *nm.DeviceEthernet) void;
    pub const setDevice = astal_network_wired_set_device;

    extern fn astal_network_wired_get_speed(p_self: *Wired) c_uint;
    pub const getSpeed = astal_network_wired_get_speed;

    extern fn astal_network_wired_get_internet(p_self: *Wired) astalnetwork.Internet;
    pub const getInternet = astal_network_wired_get_internet;

    extern fn astal_network_wired_get_state(p_self: *Wired) astalnetwork.DeviceState;
    pub const getState = astal_network_wired_get_state;

    extern fn astal_network_wired_get_icon_name(p_self: *Wired) [*:0]const u8;
    pub const getIconName = astal_network_wired_get_icon_name;

    extern fn astal_network_wired_get_type() usize;
    pub const getGObjectType = astal_network_wired_get_type;

    extern fn g_object_ref(p_self: *astalnetwork.Wired) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalnetwork.Wired) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Wired, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AccessPointClass = extern struct {
    pub const Instance = astalnetwork.AccessPoint;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *AccessPointClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AccessPointPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NetworkClass = extern struct {
    pub const Instance = astalnetwork.Network;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *NetworkClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NetworkPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WifiClass = extern struct {
    pub const Instance = astalnetwork.Wifi;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *WifiClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WifiPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WiredClass = extern struct {
    pub const Instance = astalnetwork.Wired;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *WiredClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WiredPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Primary = enum(c_int) {
    unknown = 0,
    wired = 1,
    wifi = 2,
    _,

    extern fn astal_network_primary_get_type() usize;
    pub const getGObjectType = astal_network_primary_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const State = enum(c_int) {
    unknown = 0,
    asleep = 10,
    disconnected = 20,
    disconnecting = 30,
    connecting = 40,
    connected_local = 50,
    connected_site = 60,
    connected_global = 70,
    _,

    extern fn astal_network_state_get_type() usize;
    pub const getGObjectType = astal_network_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Connectivity = enum(c_int) {
    unknown = 0,
    none = 1,
    portal = 2,
    limited = 3,
    full = 4,
    _,

    extern fn astal_network_connectivity_get_type() usize;
    pub const getGObjectType = astal_network_connectivity_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceState = enum(c_int) {
    unknown = 0,
    unmanaged = 10,
    unavailable = 20,
    disconnected = 30,
    prepare = 40,
    config = 50,
    need_auth = 60,
    ip_config = 70,
    ip_check = 80,
    secondaries = 90,
    activated = 100,
    deactivating = 110,
    failed = 120,
    _,

    extern fn astal_network_device_state_get_type() usize;
    pub const getGObjectType = astal_network_device_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Internet = enum(c_int) {
    connected = 0,
    connecting = 1,
    disconnected = 2,
    _,

    extern fn astal_network_internet_get_type() usize;
    pub const getGObjectType = astal_network_internet_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn astal_network_primary_to_string(p_self: astalnetwork.Primary) [*:0]u8;
pub const primaryToString = astal_network_primary_to_string;

extern fn astal_network_primary_from_connection_type(p_type: [*:0]const u8) astalnetwork.Primary;
pub const primaryFromConnectionType = astal_network_primary_from_connection_type;

extern fn astal_network_state_to_string(p_self: astalnetwork.State) [*:0]u8;
pub const stateToString = astal_network_state_to_string;

extern fn astal_network_connectivity_to_string(p_self: astalnetwork.Connectivity) [*:0]u8;
pub const connectivityToString = astal_network_connectivity_to_string;

extern fn astal_network_device_state_to_string(p_self: astalnetwork.DeviceState) [*:0]u8;
pub const deviceStateToString = astal_network_device_state_to_string;

extern fn astal_network_internet_from_device(p_device: *nm.Device) astalnetwork.Internet;
pub const internetFromDevice = astal_network_internet_from_device;

extern fn astal_network_internet_to_string(p_self: astalnetwork.Internet) [*:0]u8;
pub const internetToString = astal_network_internet_to_string;

extern fn astal_network_get_default() *astalnetwork.Network;
pub const getDefault = astal_network_get_default;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
