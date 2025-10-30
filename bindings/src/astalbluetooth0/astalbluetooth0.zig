pub const ext = @import("ext.zig");
const astalbluetooth = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// Object representing an [adapter](https://github.com/RadiusNetworks/bluez/blob/master/doc/adapter-api.txt).
pub const Adapter = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalbluetooth.AdapterClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalbluetooth.AdapterPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// List of 128-bit UUIDs that represents the available local services.
        pub const uuids = struct {
            pub const name = "uuids";

            pub const Type = ?[*][*:0]u8;
        };

        /// Indicates that a device discovery procedure is active.
        pub const discovering = struct {
            pub const name = "discovering";

            pub const Type = c_int;
        };

        /// Local Device ID information in modalias format used by the kernel and udev.
        pub const modalias = struct {
            pub const name = "modalias";

            pub const Type = ?[*:0]u8;
        };

        /// The Bluetooth system name (pretty hostname).
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// The Bluetooth class of device.
        pub const class = struct {
            pub const name = "class";

            pub const Type = c_uint;
        };

        /// The Bluetooth device address.
        pub const address = struct {
            pub const name = "address";

            pub const Type = ?[*:0]u8;
        };

        /// Switch an adapter to discoverable or non-discoverable to either make it visible or hide it.
        pub const discoverable = struct {
            pub const name = "discoverable";

            pub const Type = c_int;
        };

        /// Switch an adapter to pairable or non-pairable.
        pub const pairable = struct {
            pub const name = "pairable";

            pub const Type = c_int;
        };

        /// Switch an adapter on or off.
        pub const powered = struct {
            pub const name = "powered";

            pub const Type = c_int;
        };

        /// The Bluetooth friendly name.
        /// In case no alias is set, it will return `astalbluetooth.Adapter.properties.name`.
        pub const alias = struct {
            pub const name = "alias";

            pub const Type = ?[*:0]u8;
        };

        /// The discoverable timeout in seconds. A value of zero means that the timeout is disabled and it will stay in discoverable/limited mode forever
        /// until `astalbluetooth.Adapter.stopDiscovery` is invoked. The default value for the discoverable timeout should be `180`.
        pub const discoverable_timeout = struct {
            pub const name = "discoverable-timeout";

            pub const Type = c_uint;
        };

        /// The pairable timeout in seconds.
        /// A value of zero means that the timeout is disabled and it will stay in pairable mode forever. The default value for pairable timeout should be
        /// disabled `0`.
        pub const pairable_timeout = struct {
            pub const name = "pairable-timeout";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    /// This removes the remote device and the pairing information.
    /// Possible errors: `InvalidArguments`, `Failed`.
    extern fn astal_bluetooth_adapter_remove_device(p_self: *Adapter, p_device: *astalbluetooth.Device, p_error: ?*?*glib.Error) void;
    pub const removeDevice = astal_bluetooth_adapter_remove_device;

    /// This method starts the device discovery procedure.
    /// Possible errors: `NotReady`, `Failed`.
    extern fn astal_bluetooth_adapter_start_discovery(p_self: *Adapter, p_error: ?*?*glib.Error) void;
    pub const startDiscovery = astal_bluetooth_adapter_start_discovery;

    /// This method will cancel any previous `astalbluetooth.Adapter.startDiscovery` procedure.
    /// Possible errors: `NotReady`, `Failed`, `NotAuthorized`.
    extern fn astal_bluetooth_adapter_stop_discovery(p_self: *Adapter, p_error: ?*?*glib.Error) void;
    pub const stopDiscovery = astal_bluetooth_adapter_stop_discovery;

    extern fn astal_bluetooth_adapter_get_uuids(p_self: *Adapter, p_result_length1: *c_int) [*][*:0]u8;
    pub const getUuids = astal_bluetooth_adapter_get_uuids;

    extern fn astal_bluetooth_adapter_get_discovering(p_self: *Adapter) c_int;
    pub const getDiscovering = astal_bluetooth_adapter_get_discovering;

    extern fn astal_bluetooth_adapter_get_modalias(p_self: *Adapter) [*:0]u8;
    pub const getModalias = astal_bluetooth_adapter_get_modalias;

    extern fn astal_bluetooth_adapter_get_name(p_self: *Adapter) [*:0]u8;
    pub const getName = astal_bluetooth_adapter_get_name;

    extern fn astal_bluetooth_adapter_get_class(p_self: *Adapter) c_uint;
    pub const getClass = astal_bluetooth_adapter_get_class;

    extern fn astal_bluetooth_adapter_get_address(p_self: *Adapter) [*:0]u8;
    pub const getAddress = astal_bluetooth_adapter_get_address;

    extern fn astal_bluetooth_adapter_get_discoverable(p_self: *Adapter) c_int;
    pub const getDiscoverable = astal_bluetooth_adapter_get_discoverable;

    extern fn astal_bluetooth_adapter_set_discoverable(p_self: *Adapter, p_value: c_int) void;
    pub const setDiscoverable = astal_bluetooth_adapter_set_discoverable;

    extern fn astal_bluetooth_adapter_get_pairable(p_self: *Adapter) c_int;
    pub const getPairable = astal_bluetooth_adapter_get_pairable;

    extern fn astal_bluetooth_adapter_set_pairable(p_self: *Adapter, p_value: c_int) void;
    pub const setPairable = astal_bluetooth_adapter_set_pairable;

    extern fn astal_bluetooth_adapter_get_powered(p_self: *Adapter) c_int;
    pub const getPowered = astal_bluetooth_adapter_get_powered;

    extern fn astal_bluetooth_adapter_set_powered(p_self: *Adapter, p_value: c_int) void;
    pub const setPowered = astal_bluetooth_adapter_set_powered;

    extern fn astal_bluetooth_adapter_get_alias(p_self: *Adapter) [*:0]u8;
    pub const getAlias = astal_bluetooth_adapter_get_alias;

    extern fn astal_bluetooth_adapter_set_alias(p_self: *Adapter, p_value: [*:0]const u8) void;
    pub const setAlias = astal_bluetooth_adapter_set_alias;

    extern fn astal_bluetooth_adapter_get_discoverable_timeout(p_self: *Adapter) c_uint;
    pub const getDiscoverableTimeout = astal_bluetooth_adapter_get_discoverable_timeout;

    extern fn astal_bluetooth_adapter_set_discoverable_timeout(p_self: *Adapter, p_value: c_uint) void;
    pub const setDiscoverableTimeout = astal_bluetooth_adapter_set_discoverable_timeout;

    extern fn astal_bluetooth_adapter_get_pairable_timeout(p_self: *Adapter) c_uint;
    pub const getPairableTimeout = astal_bluetooth_adapter_get_pairable_timeout;

    extern fn astal_bluetooth_adapter_set_pairable_timeout(p_self: *Adapter, p_value: c_uint) void;
    pub const setPairableTimeout = astal_bluetooth_adapter_set_pairable_timeout;

    extern fn astal_bluetooth_adapter_get_type() usize;
    pub const getGObjectType = astal_bluetooth_adapter_get_type;

    extern fn g_object_ref(p_self: *astalbluetooth.Adapter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalbluetooth.Adapter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Adapter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Manager object for `org.bluez`.
pub const Bluetooth = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalbluetooth.BluetoothClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalbluetooth.BluetoothPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// `true` if any of the `astalbluetooth.Bluetooth.properties.adapters` are powered.
        pub const is_powered = struct {
            pub const name = "is-powered";

            pub const Type = c_int;
        };

        /// `true` if any of the `astalbluetooth.Bluetooth.properties.devices` is connected.
        pub const is_connected = struct {
            pub const name = "is-connected";

            pub const Type = c_int;
        };

        /// The first registered adapter which is usually the only adapter.
        pub const adapter = struct {
            pub const name = "adapter";

            pub const Type = ?**astalbluetooth.Adapter;
        };

        /// List of adapters available on the host device.
        pub const adapters = struct {
            pub const name = "adapters";

            pub const Type = ?**glib.List;
        };

        /// List of registered devices on the `org.bluez` bus.
        pub const devices = struct {
            pub const name = "devices";

            pub const Type = ?**glib.List;
        };
    };

    pub const signals = struct {
        /// Emitted when a new device is registered on the `org.bluez` bus.
        pub const device_added = struct {
            pub const name = "device-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: **astalbluetooth.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Bluetooth, p_instance))),
                    gobject.signalLookup("device-added", Bluetooth.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a device is unregistered on the `org.bluez` bus.
        pub const device_removed = struct {
            pub const name = "device-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: **astalbluetooth.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Bluetooth, p_instance))),
                    gobject.signalLookup("device-removed", Bluetooth.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an adapter is registered on the `org.bluez` bus.
        pub const adapter_added = struct {
            pub const name = "adapter-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_adapter: **astalbluetooth.Adapter, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Bluetooth, p_instance))),
                    gobject.signalLookup("adapter-added", Bluetooth.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an adapter is unregistered on the `org.bluez` bus.
        pub const adapter_removed = struct {
            pub const name = "adapter-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_adapter: **astalbluetooth.Adapter, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Bluetooth, p_instance))),
                    gobject.signalLookup("adapter-removed", Bluetooth.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the default singleton Bluetooth object.
    extern fn astal_bluetooth_bluetooth_get_default() *astalbluetooth.Bluetooth;
    pub const getDefault = astal_bluetooth_bluetooth_get_default;

    extern fn astal_bluetooth_bluetooth_new() *astalbluetooth.Bluetooth;
    pub const new = astal_bluetooth_bluetooth_new;

    /// Toggle the `astalbluetooth.Adapter.properties.powered` property of the `astalbluetooth.Bluetooth.properties.adapter`.
    extern fn astal_bluetooth_bluetooth_toggle(p_self: *Bluetooth) void;
    pub const toggle = astal_bluetooth_bluetooth_toggle;

    extern fn astal_bluetooth_bluetooth_get_is_powered(p_self: *Bluetooth) c_int;
    pub const getIsPowered = astal_bluetooth_bluetooth_get_is_powered;

    extern fn astal_bluetooth_bluetooth_get_is_connected(p_self: *Bluetooth) c_int;
    pub const getIsConnected = astal_bluetooth_bluetooth_get_is_connected;

    extern fn astal_bluetooth_bluetooth_get_adapter(p_self: *Bluetooth) ?*astalbluetooth.Adapter;
    pub const getAdapter = astal_bluetooth_bluetooth_get_adapter;

    extern fn astal_bluetooth_bluetooth_get_adapters(p_self: *Bluetooth) *glib.List;
    pub const getAdapters = astal_bluetooth_bluetooth_get_adapters;

    extern fn astal_bluetooth_bluetooth_get_devices(p_self: *Bluetooth) *glib.List;
    pub const getDevices = astal_bluetooth_bluetooth_get_devices;

    extern fn astal_bluetooth_bluetooth_get_type() usize;
    pub const getGObjectType = astal_bluetooth_bluetooth_get_type;

    extern fn g_object_ref(p_self: *astalbluetooth.Bluetooth) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalbluetooth.Bluetooth) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Bluetooth, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Object representing a [device](https://github.com/luetzel/bluez/blob/master/doc/device-api.txt).
pub const Device = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalbluetooth.DeviceClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalbluetooth.DevicePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// List of 128-bit UUIDs that represents the available remote services.
        pub const uuids = struct {
            pub const name = "uuids";

            pub const Type = ?[*][*:0]u8;
        };

        /// Indicates if the remote device is currently connected.
        pub const connected = struct {
            pub const name = "connected";

            pub const Type = c_int;
        };

        /// `true` if the device only supports the pre-2.1 pairing mechanism.
        pub const legacy_pairing = struct {
            pub const name = "legacy-pairing";

            pub const Type = c_int;
        };

        /// Indicates if the remote device is paired.
        pub const paired = struct {
            pub const name = "paired";

            pub const Type = c_int;
        };

        /// Received Signal Strength Indicator of the remote device (inquiry or advertising).
        pub const rssi = struct {
            pub const name = "rssi";

            pub const Type = i16;
        };

        /// The object path of the adapter the device belongs to.
        pub const adapter = struct {
            pub const name = "adapter";

            pub const Type = ?*u8;
        };

        /// The Bluetooth device address of the remote device.
        pub const address = struct {
            pub const name = "address";

            pub const Type = ?[*:0]u8;
        };

        /// Proposed icon name.
        pub const icon = struct {
            pub const name = "icon";

            pub const Type = ?[*:0]u8;
        };

        /// Remote Device ID information in modalias format used by the kernel and udev.
        pub const modalias = struct {
            pub const name = "modalias";

            pub const Type = ?[*:0]u8;
        };

        /// The Bluetooth remote name.
        /// It is always better to use `astalbluetooth.Device.properties.alias`.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// External appearance of device, as found on GAP service.
        pub const appearance = struct {
            pub const name = "appearance";

            pub const Type = u16;
        };

        /// The Bluetooth class of device of the remote device.
        pub const class = struct {
            pub const name = "class";

            pub const Type = u32;
        };

        /// Indicates if this device is currently trying to be connected.
        pub const connecting = struct {
            pub const name = "connecting";

            pub const Type = c_int;
        };

        /// If set to `true` any incoming connections from the device will be immediately rejected.
        pub const blocked = struct {
            pub const name = "blocked";

            pub const Type = c_int;
        };

        /// Indicates if the remote is seen as trusted.
        pub const trusted = struct {
            pub const name = "trusted";

            pub const Type = c_int;
        };

        /// The percentage of battery left on the device if it has one, else -1.
        pub const battery_percentage = struct {
            pub const name = "battery-percentage";

            pub const Type = f64;
        };

        /// The name alias for the remote device.
        /// In case no alias is set, it will return the remote device `astalbluetooth.Device.properties.name`.
        pub const alias = struct {
            pub const name = "alias";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// This is a generic method to connect any profiles the remote device supports that can be connected to.
    /// Possible errors: `NotReady`, `Failed`, `InProgress`, `AlreadyConnected`.
    extern fn astal_bluetooth_device_connect_device(p_self: *Device, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const connectDevice = astal_bluetooth_device_connect_device;

    extern fn astal_bluetooth_device_connect_device_finish(p_self: *Device, p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
    pub const connectDeviceFinish = astal_bluetooth_device_connect_device_finish;

    /// This method gracefully disconnects all connected profiles.
    /// Possible errors: `NotConnected`.
    extern fn astal_bluetooth_device_disconnect_device(p_self: *Device, p__callback_: ?gio.AsyncReadyCallback, p__callback__target: ?*anyopaque) void;
    pub const disconnectDevice = astal_bluetooth_device_disconnect_device;

    extern fn astal_bluetooth_device_disconnect_device_finish(p_self: *Device, p__res_: *gio.AsyncResult, p_error: ?*?*glib.Error) void;
    pub const disconnectDeviceFinish = astal_bluetooth_device_disconnect_device_finish;

    /// This method connects a specific profile of this device. The UUID provided is the remote service UUID for the profile.
    /// Possible errors: `Failed`, `InProgress`, `InvalidArguments`, `NotAvailable`, `NotReady`.
    extern fn astal_bluetooth_device_connect_profile(p_self: *Device, p_uuid: [*:0]const u8, p_error: ?*?*glib.Error) void;
    pub const connectProfile = astal_bluetooth_device_connect_profile;

    /// This method disconnects a specific profile of this device.
    /// Possible errors: `Failed`, `InProgress`, `InvalidArguments`, `NotSupported`.
    extern fn astal_bluetooth_device_disconnect_profile(p_self: *Device, p_uuid: [*:0]const u8, p_error: ?*?*glib.Error) void;
    pub const disconnectProfile = astal_bluetooth_device_disconnect_profile;

    /// This method will connect to the remote device and initiate pairing.
    /// Possible errors: `InvalidArguments`, `Failed`, `AlreadyExists`, `AuthenticationCanceled`, `AuthenticationFailed`, `AuthenticationRejected`,
    /// `AuthenticationTimeout`, `ConnectionAttemptFailed`.
    extern fn astal_bluetooth_device_pair(p_self: *Device, p_error: ?*?*glib.Error) void;
    pub const pair = astal_bluetooth_device_pair;

    /// This method can be used to cancel a pairing operation initiated by `astalbluetooth.Device.pair`.
    /// Possible errors: `DoesNotExist`, `Failed`.
    extern fn astal_bluetooth_device_cancel_pairing(p_self: *Device, p_error: ?*?*glib.Error) void;
    pub const cancelPairing = astal_bluetooth_device_cancel_pairing;

    extern fn astal_bluetooth_device_get_uuids(p_self: *Device, p_result_length1: *c_int) [*][*:0]u8;
    pub const getUuids = astal_bluetooth_device_get_uuids;

    extern fn astal_bluetooth_device_get_connected(p_self: *Device) c_int;
    pub const getConnected = astal_bluetooth_device_get_connected;

    extern fn astal_bluetooth_device_get_legacy_pairing(p_self: *Device) c_int;
    pub const getLegacyPairing = astal_bluetooth_device_get_legacy_pairing;

    extern fn astal_bluetooth_device_get_paired(p_self: *Device) c_int;
    pub const getPaired = astal_bluetooth_device_get_paired;

    extern fn astal_bluetooth_device_get_rssi(p_self: *Device) i16;
    pub const getRssi = astal_bluetooth_device_get_rssi;

    extern fn astal_bluetooth_device_get_adapter(p_self: *Device) *u8;
    pub const getAdapter = astal_bluetooth_device_get_adapter;

    extern fn astal_bluetooth_device_get_address(p_self: *Device) [*:0]u8;
    pub const getAddress = astal_bluetooth_device_get_address;

    extern fn astal_bluetooth_device_get_icon(p_self: *Device) [*:0]u8;
    pub const getIcon = astal_bluetooth_device_get_icon;

    extern fn astal_bluetooth_device_get_modalias(p_self: *Device) [*:0]u8;
    pub const getModalias = astal_bluetooth_device_get_modalias;

    extern fn astal_bluetooth_device_get_name(p_self: *Device) [*:0]u8;
    pub const getName = astal_bluetooth_device_get_name;

    extern fn astal_bluetooth_device_get_appearance(p_self: *Device) u16;
    pub const getAppearance = astal_bluetooth_device_get_appearance;

    extern fn astal_bluetooth_device_get_class(p_self: *Device) u32;
    pub const getClass = astal_bluetooth_device_get_class;

    extern fn astal_bluetooth_device_get_connecting(p_self: *Device) c_int;
    pub const getConnecting = astal_bluetooth_device_get_connecting;

    extern fn astal_bluetooth_device_get_blocked(p_self: *Device) c_int;
    pub const getBlocked = astal_bluetooth_device_get_blocked;

    extern fn astal_bluetooth_device_set_blocked(p_self: *Device, p_value: c_int) void;
    pub const setBlocked = astal_bluetooth_device_set_blocked;

    extern fn astal_bluetooth_device_get_trusted(p_self: *Device) c_int;
    pub const getTrusted = astal_bluetooth_device_get_trusted;

    extern fn astal_bluetooth_device_set_trusted(p_self: *Device, p_value: c_int) void;
    pub const setTrusted = astal_bluetooth_device_set_trusted;

    extern fn astal_bluetooth_device_get_battery_percentage(p_self: *Device) f64;
    pub const getBatteryPercentage = astal_bluetooth_device_get_battery_percentage;

    extern fn astal_bluetooth_device_get_alias(p_self: *Device) [*:0]u8;
    pub const getAlias = astal_bluetooth_device_get_alias;

    extern fn astal_bluetooth_device_set_alias(p_self: *Device, p_value: [*:0]const u8) void;
    pub const setAlias = astal_bluetooth_device_set_alias;

    extern fn astal_bluetooth_device_get_type() usize;
    pub const getGObjectType = astal_bluetooth_device_get_type;

    extern fn g_object_ref(p_self: *astalbluetooth.Device) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalbluetooth.Device) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Device, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AdapterClass = extern struct {
    pub const Instance = astalbluetooth.Adapter;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *AdapterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AdapterPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BluetoothClass = extern struct {
    pub const Instance = astalbluetooth.Bluetooth;

    f_parent_class: gobject.ObjectClass,
    f_device_added: ?*const fn (p_self: *astalbluetooth.Bluetooth, p_device: *astalbluetooth.Device) callconv(.c) void,
    f_device_removed: ?*const fn (p_self: *astalbluetooth.Bluetooth, p_device: *astalbluetooth.Device) callconv(.c) void,
    f_adapter_added: ?*const fn (p_self: *astalbluetooth.Bluetooth, p_adapter: *astalbluetooth.Adapter) callconv(.c) void,
    f_adapter_removed: ?*const fn (p_self: *astalbluetooth.Bluetooth, p_adapter: *astalbluetooth.Adapter) callconv(.c) void,

    pub fn as(p_instance: *BluetoothClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BluetoothPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceClass = extern struct {
    pub const Instance = astalbluetooth.Device;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *DeviceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DevicePrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Gets the default singleton Bluetooth object.
extern fn astal_bluetooth_get_default() *astalbluetooth.Bluetooth;
pub const getDefault = astal_bluetooth_get_default;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
