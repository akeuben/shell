pub const ext = @import("ext.zig");
const astalbattery = @This();

const std = @import("std");
const compat = @import("compat");
const glib = @import("glib2");
const gobject = @import("gobject2");
/// Client for a UPower [device](https://upower.freedesktop.org/docs/Device.html).
pub const Device = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalbattery.DeviceClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalbattery.DevicePrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// If it is `astalbattery.@"Type.BATTERY"`, you will need to verify that the property power-supply has the value `true` before
        /// considering it as a laptop battery. Otherwise it will likely be the battery for a device of an unknown type.
        pub const device_type = struct {
            pub const name = "device-type";

            pub const Type = astalbattery.Type;
        };

        /// Native path of the power source. This is the sysfs path, for example /sys/devices/LNXSYSTM:00/device:00/PNP0C0A:00/power_supply/BAT0. It is
        /// blank if the device is being driven by a user space driver.
        pub const native_path = struct {
            pub const name = "native-path";

            pub const Type = ?[*:0]u8;
        };

        /// Name of the vendor of the battery.
        pub const vendor = struct {
            pub const name = "vendor";

            pub const Type = ?[*:0]u8;
        };

        /// Name of the model of this battery.
        pub const model = struct {
            pub const name = "model";

            pub const Type = ?[*:0]u8;
        };

        /// Unique serial number of the battery.
        pub const serial = struct {
            pub const name = "serial";

            pub const Type = ?[*:0]u8;
        };

        /// The point in time (seconds since the Epoch) that data was read from the power source.
        pub const update_time = struct {
            pub const name = "update-time";

            pub const Type = u64;
        };

        /// If the power device is used to supply the system. This would be set `true` for laptop batteries and UPS devices, but set to `false` for
        /// wireless mice or PDAs.
        pub const power_supply = struct {
            pub const name = "power-supply";

            pub const Type = c_int;
        };

        /// Whether power is currently being provided through line power.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.LINE_POWER"`.
        pub const online = struct {
            pub const name = "online";

            pub const Type = c_int;
        };

        /// Amount of energy (measured in Wh) currently available in the power source.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const energy = struct {
            pub const name = "energy";

            pub const Type = f64;
        };

        /// Amount of energy (measured in Wh) in the power source when it's considered to be empty.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const energy_empty = struct {
            pub const name = "energy-empty";

            pub const Type = f64;
        };

        /// Amount of energy (measured in Wh) in the power source when it's considered full.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const energy_full = struct {
            pub const name = "energy-full";

            pub const Type = f64;
        };

        /// Amount of energy (measured in Wh) the power source is designed to hold when it's considered full.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const energy_full_design = struct {
            pub const name = "energy-full-design";

            pub const Type = f64;
        };

        /// Amount of energy being drained from the source, measured in W. If positive, the source is being discharged, if negative it's being charged.
        ///
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const energy_rate = struct {
            pub const name = "energy-rate";

            pub const Type = f64;
        };

        /// Voltage in the Cell or being recorded by the meter.
        pub const voltage = struct {
            pub const name = "voltage";

            pub const Type = f64;
        };

        /// The number of charge cycles as defined by the TCO certification, or -1 if that value is unknown or not applicable.
        pub const charge_cycles = struct {
            pub const name = "charge-cycles";

            pub const Type = c_int;
        };

        /// Luminosity being recorded by the meter.
        pub const luminosity = struct {
            pub const name = "luminosity";

            pub const Type = f64;
        };

        /// Number of seconds until the power source is considered empty. Is set to 0 if unknown.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const time_to_empty = struct {
            pub const name = "time-to-empty";

            pub const Type = i64;
        };

        /// Number of seconds until the power source is considered full. Is set to 0 if unknown.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const time_to_full = struct {
            pub const name = "time-to-full";

            pub const Type = i64;
        };

        /// The amount of energy left in the power source expressed as a percentage between 0 and 1.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`. The percentage
        /// will be an approximation if `astalbattery.Device.properties.battery_level` is set to something other than None.
        pub const percentage = struct {
            pub const name = "percentage";

            pub const Type = f64;
        };

        /// The temperature of the device in degrees Celsius.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const temperature = struct {
            pub const name = "temperature";

            pub const Type = f64;
        };

        /// If the power source is present in the bay.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const is_present = struct {
            pub const name = "is-present";

            pub const Type = c_int;
        };

        /// The battery power state.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const state = struct {
            pub const name = "state";

            pub const Type = astalbattery.State;
        };

        /// If the power source is rechargeable.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const is_rechargable = struct {
            pub const name = "is-rechargable";

            pub const Type = c_int;
        };

        /// The capacity of the power source expressed as a percentage between 0 and 1.
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const capacity = struct {
            pub const name = "capacity";

            pub const Type = f64;
        };

        /// Technology used in the battery:
        /// This property is only valid if `astalbattery.Device.properties.device_type` is `astalbattery.@"Type.BATTERY"`.
        pub const technology = struct {
            pub const name = "technology";

            pub const Type = astalbattery.Technology;
        };

        /// Warning level of the battery.
        pub const warning_level = struct {
            pub const name = "warning-level";

            pub const Type = astalbattery.WarningLevel;
        };

        /// The level of the battery for devices which do not report a percentage but rather a coarse battery level. If the value is None. then the device
        /// does not support coarse battery reporting, and the `astalbattery.Device.properties.percentage` should be used instead.
        pub const battery_level = struct {
            pub const name = "battery-level";

            pub const Type = astalbattery.BatteryLevel;
        };

        /// An icon name representing this Device.
        /// NOTE: `astalbattery.Device.properties.battery_icon_name` might be a better fit as it is calculated from percentage.
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// Indicates if `astalbattery.Device.properties.state` is charging or fully charged.
        pub const charging = struct {
            pub const name = "charging";

            pub const Type = c_int;
        };

        /// Indicates if `astalbattery.Device.properties.device_type` is not line power or unknown.
        pub const is_battery = struct {
            pub const name = "is-battery";

            pub const Type = c_int;
        };

        /// An icon name in the form of "battery-level-$percentage-$state-symbolic".
        pub const battery_icon_name = struct {
            pub const name = "battery-icon-name";

            pub const Type = ?[*:0]u8;
        };

        /// A string representation of this device's `astalbattery.Device.properties.device_type`.
        pub const device_type_name = struct {
            pub const name = "device-type-name";

            pub const Type = ?[*:0]u8;
        };

        /// An icon name that can be used to represent this device's `astalbattery.Device.properties.device_type`.
        pub const device_type_icon = struct {
            pub const name = "device-type-icon";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Get the DisplayDevice.
    extern fn astal_battery_device_get_default() ?*astalbattery.Device;
    pub const getDefault = astal_battery_device_get_default;

    extern fn astal_battery_device_new(p_path: *const u8, p_error: ?*?*glib.Error) ?*astalbattery.Device;
    pub const new = astal_battery_device_new;

    extern fn astal_battery_device_get_device_type(p_self: *Device) astalbattery.Type;
    pub const getDeviceType = astal_battery_device_get_device_type;

    extern fn astal_battery_device_get_native_path(p_self: *Device) [*:0]u8;
    pub const getNativePath = astal_battery_device_get_native_path;

    extern fn astal_battery_device_get_vendor(p_self: *Device) [*:0]u8;
    pub const getVendor = astal_battery_device_get_vendor;

    extern fn astal_battery_device_get_model(p_self: *Device) [*:0]u8;
    pub const getModel = astal_battery_device_get_model;

    extern fn astal_battery_device_get_serial(p_self: *Device) [*:0]u8;
    pub const getSerial = astal_battery_device_get_serial;

    extern fn astal_battery_device_get_update_time(p_self: *Device) u64;
    pub const getUpdateTime = astal_battery_device_get_update_time;

    extern fn astal_battery_device_get_power_supply(p_self: *Device) c_int;
    pub const getPowerSupply = astal_battery_device_get_power_supply;

    extern fn astal_battery_device_get_online(p_self: *Device) c_int;
    pub const getOnline = astal_battery_device_get_online;

    extern fn astal_battery_device_get_energy(p_self: *Device) f64;
    pub const getEnergy = astal_battery_device_get_energy;

    extern fn astal_battery_device_get_energy_empty(p_self: *Device) f64;
    pub const getEnergyEmpty = astal_battery_device_get_energy_empty;

    extern fn astal_battery_device_get_energy_full(p_self: *Device) f64;
    pub const getEnergyFull = astal_battery_device_get_energy_full;

    extern fn astal_battery_device_get_energy_full_design(p_self: *Device) f64;
    pub const getEnergyFullDesign = astal_battery_device_get_energy_full_design;

    extern fn astal_battery_device_get_energy_rate(p_self: *Device) f64;
    pub const getEnergyRate = astal_battery_device_get_energy_rate;

    extern fn astal_battery_device_get_voltage(p_self: *Device) f64;
    pub const getVoltage = astal_battery_device_get_voltage;

    extern fn astal_battery_device_get_charge_cycles(p_self: *Device) c_int;
    pub const getChargeCycles = astal_battery_device_get_charge_cycles;

    extern fn astal_battery_device_get_luminosity(p_self: *Device) f64;
    pub const getLuminosity = astal_battery_device_get_luminosity;

    extern fn astal_battery_device_get_time_to_empty(p_self: *Device) i64;
    pub const getTimeToEmpty = astal_battery_device_get_time_to_empty;

    extern fn astal_battery_device_get_time_to_full(p_self: *Device) i64;
    pub const getTimeToFull = astal_battery_device_get_time_to_full;

    extern fn astal_battery_device_get_percentage(p_self: *Device) f64;
    pub const getPercentage = astal_battery_device_get_percentage;

    extern fn astal_battery_device_get_temperature(p_self: *Device) f64;
    pub const getTemperature = astal_battery_device_get_temperature;

    extern fn astal_battery_device_get_is_present(p_self: *Device) c_int;
    pub const getIsPresent = astal_battery_device_get_is_present;

    extern fn astal_battery_device_get_state(p_self: *Device) astalbattery.State;
    pub const getState = astal_battery_device_get_state;

    extern fn astal_battery_device_get_is_rechargable(p_self: *Device) c_int;
    pub const getIsRechargable = astal_battery_device_get_is_rechargable;

    extern fn astal_battery_device_get_capacity(p_self: *Device) f64;
    pub const getCapacity = astal_battery_device_get_capacity;

    extern fn astal_battery_device_get_technology(p_self: *Device) astalbattery.Technology;
    pub const getTechnology = astal_battery_device_get_technology;

    extern fn astal_battery_device_get_warning_level(p_self: *Device) astalbattery.WarningLevel;
    pub const getWarningLevel = astal_battery_device_get_warning_level;

    extern fn astal_battery_device_get_battery_level(p_self: *Device) astalbattery.BatteryLevel;
    pub const getBatteryLevel = astal_battery_device_get_battery_level;

    extern fn astal_battery_device_get_icon_name(p_self: *Device) [*:0]u8;
    pub const getIconName = astal_battery_device_get_icon_name;

    extern fn astal_battery_device_get_charging(p_self: *Device) c_int;
    pub const getCharging = astal_battery_device_get_charging;

    extern fn astal_battery_device_get_is_battery(p_self: *Device) c_int;
    pub const getIsBattery = astal_battery_device_get_is_battery;

    extern fn astal_battery_device_get_battery_icon_name(p_self: *Device) [*:0]const u8;
    pub const getBatteryIconName = astal_battery_device_get_battery_icon_name;

    extern fn astal_battery_device_get_device_type_name(p_self: *Device) [*:0]const u8;
    pub const getDeviceTypeName = astal_battery_device_get_device_type_name;

    extern fn astal_battery_device_get_device_type_icon(p_self: *Device) [*:0]const u8;
    pub const getDeviceTypeIcon = astal_battery_device_get_device_type_icon;

    extern fn astal_battery_device_get_type() usize;
    pub const getGObjectType = astal_battery_device_get_type;

    extern fn g_object_ref(p_self: *astalbattery.Device) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalbattery.Device) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Device, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Client for the UPower [dbus interface](https://upower.freedesktop.org/docs/UPower.html).
pub const UPower = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalbattery.UPowerClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalbattery.UPowerPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// List of UPower devices.
        pub const devices = struct {
            pub const name = "devices";

            pub const Type = ?**glib.List;
        };

        /// A composite device that represents the battery status.
        pub const display_device = struct {
            pub const name = "display-device";

            pub const Type = ?**astalbattery.Device;
        };

        pub const daemon_version = struct {
            pub const name = "daemon-version";

            pub const Type = ?[*:0]u8;
        };

        /// Indicates whether the system is running on battery power.
        pub const on_battery = struct {
            pub const name = "on-battery";

            pub const Type = c_int;
        };

        /// Indicates if the laptop lid is closed where the display cannot be seen.
        pub const lid_is_closed = struct {
            pub const name = "lid-is-closed";

            pub const Type = c_int;
        };

        /// Indicates if the system has a lid device.
        pub const lid_is_present = struct {
            pub const name = "lid-is-present";

            pub const Type = c_int;
        };

        /// When the system's power supply is critical (critically low batteries or UPS), the system will take this action.
        pub const critical_action = struct {
            pub const name = "critical-action";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted when a new device is connected.
        pub const device_added = struct {
            pub const name = "device-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: **astalbattery.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(UPower, p_instance))),
                    gobject.signalLookup("device-added", UPower.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted a new device is disconnected.
        pub const device_removed = struct {
            pub const name = "device-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: **astalbattery.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(UPower, p_instance))),
                    gobject.signalLookup("device-removed", UPower.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_battery_upower_new() *astalbattery.UPower;
    pub const new = astal_battery_upower_new;

    extern fn astal_battery_upower_get_devices(p_self: *UPower) *glib.List;
    pub const getDevices = astal_battery_upower_get_devices;

    extern fn astal_battery_upower_get_display_device(p_self: *UPower) *astalbattery.Device;
    pub const getDisplayDevice = astal_battery_upower_get_display_device;

    extern fn astal_battery_upower_get_daemon_version(p_self: *UPower) [*:0]u8;
    pub const getDaemonVersion = astal_battery_upower_get_daemon_version;

    extern fn astal_battery_upower_get_on_battery(p_self: *UPower) c_int;
    pub const getOnBattery = astal_battery_upower_get_on_battery;

    extern fn astal_battery_upower_get_lid_is_closed(p_self: *UPower) c_int;
    pub const getLidIsClosed = astal_battery_upower_get_lid_is_closed;

    extern fn astal_battery_upower_get_lid_is_present(p_self: *UPower) c_int;
    pub const getLidIsPresent = astal_battery_upower_get_lid_is_present;

    extern fn astal_battery_upower_get_critical_action(p_self: *UPower) [*:0]u8;
    pub const getCriticalAction = astal_battery_upower_get_critical_action;

    extern fn astal_battery_upower_get_type() usize;
    pub const getGObjectType = astal_battery_upower_get_type;

    extern fn g_object_ref(p_self: *astalbattery.UPower) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalbattery.UPower) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *UPower, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceClass = extern struct {
    pub const Instance = astalbattery.Device;

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

pub const UPowerClass = extern struct {
    pub const Instance = astalbattery.UPower;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *UPowerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UPowerPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const State = enum(c_int) {
    unknown = 0,
    charging = 1,
    discharging = 2,
    empty = 3,
    fully_charged = 4,
    pending_charge = 5,
    pending_discharge = 6,
    _,

    extern fn astal_battery_state_get_type() usize;
    pub const getGObjectType = astal_battery_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Technology = enum(c_int) {
    unknown = 0,
    lithium_ion = 1,
    lithium_polymer = 2,
    lithium_iron_phosphate = 3,
    lead_acid = 4,
    nickel_cadmium = 5,
    nickel_metal_hydride = 6,
    _,

    extern fn astal_battery_technology_get_type() usize;
    pub const getGObjectType = astal_battery_technology_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WarningLevel = enum(c_int) {
    unknown = 0,
    none = 1,
    discharging = 2,
    low = 3,
    criticial = 4,
    action = 5,
    _,

    extern fn astal_battery_warning_level_get_type() usize;
    pub const getGObjectType = astal_battery_warning_level_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BatteryLevel = enum(c_int) {
    unknown = 0,
    none = 1,
    low = 2,
    criticial = 3,
    normal = 4,
    high = 5,
    full = 6,
    _,

    extern fn astal_battery_battery_level_get_type() usize;
    pub const getGObjectType = astal_battery_battery_level_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Type = enum(c_int) {
    unknown = 0,
    line_power = 1,
    battery = 2,
    ups = 3,
    monitor = 4,
    mouse = 5,
    keyboard = 6,
    pda = 7,
    phone = 8,
    media_player = 9,
    tablet = 10,
    computer = 11,
    gaming_input = 12,
    pen = 13,
    touchpad = 14,
    modem = 15,
    network = 16,
    headset = 17,
    speakers = 18,
    headphones = 19,
    video = 20,
    other_audio = 21,
    remove_control = 22,
    printer = 23,
    scanner = 24,
    camera = 25,
    wearable = 26,
    toy = 27,
    bluetooth_generic = 28,
    _,

    extern fn astal_battery_type_get_type() usize;
    pub const getGObjectType = astal_battery_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Get the DisplayDevice.
extern fn astal_battery_get_default() *astalbattery.Device;
pub const getDefault = astal_battery_get_default;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
