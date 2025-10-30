pub const ext = @import("ext.zig");
const astalwp = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// is instanciated by `astalwp.Wp`. An instance of this class can only be received there.
///
///  This is a convenience class and acts as a filter for `astalwp.Wp` to filter for audio
/// endpoints and devices.
pub const Audio = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalwp.AudioClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The AstalEndpoint object representing the default microphone
        pub const default_microphone = struct {
            pub const name = "default-microphone";

            pub const Type = ?*astalwp.Endpoint;
        };

        /// The AstalEndpoint object representing the default speaker
        pub const default_speaker = struct {
            pub const name = "default-speaker";

            pub const Type = ?*astalwp.Endpoint;
        };

        /// A list of AstalWpEndpoint objects
        pub const devices = struct {
            pub const name = "devices";

            pub const Type = ?**glib.List;
        };

        /// A list of AstalWpEndpoint objects
        pub const microphones = struct {
            pub const name = "microphones";

            pub const Type = ?**glib.List;
        };

        /// A list of AstalWpStream objects
        pub const recorders = struct {
            pub const name = "recorders";

            pub const Type = ?**glib.List;
        };

        /// A list of AstalWpEndpoint objects
        pub const speakers = struct {
            pub const name = "speakers";

            pub const Type = ?**glib.List;
        };

        /// A list of AstalWpStream objects
        pub const streams = struct {
            pub const name = "streams";

            pub const Type = ?**glib.List;
        };
    };

    pub const signals = struct {
        pub const device_added = struct {
            pub const name = "device-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("device-added", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const device_removed = struct {
            pub const name = "device-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("device-removed", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const microphone_added = struct {
            pub const name = "microphone-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Endpoint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("microphone-added", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const microphone_removed = struct {
            pub const name = "microphone-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Endpoint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("microphone-removed", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const recorder_added = struct {
            pub const name = "recorder-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Stream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("recorder-added", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const recorder_removed = struct {
            pub const name = "recorder-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Stream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("recorder-removed", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const speaker_added = struct {
            pub const name = "speaker-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Endpoint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("speaker-added", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const speaker_removed = struct {
            pub const name = "speaker-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Endpoint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("speaker-removed", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const stream_added = struct {
            pub const name = "stream-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Stream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("stream-added", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const stream_removed = struct {
            pub const name = "stream-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Stream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Audio, p_instance))),
                    gobject.signalLookup("stream-removed", Audio.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// creates a new Audio object. You should use `astalwp.Wp.properties.audio` instead
    extern fn astal_wp_audio_new(p_wp: *astalwp.Wp) *astalwp.Audio;
    pub const new = astal_wp_audio_new;

    /// gets the default microphone object
    extern fn astal_wp_audio_get_default_microphone(p_self: *Audio) *astalwp.Endpoint;
    pub const getDefaultMicrophone = astal_wp_audio_get_default_microphone;

    /// gets the default speaker object
    extern fn astal_wp_audio_get_default_speaker(p_self: *Audio) *astalwp.Endpoint;
    pub const getDefaultSpeaker = astal_wp_audio_get_default_speaker;

    /// gets the device with the given id
    extern fn astal_wp_audio_get_device(p_self: *Audio, p_id: c_uint) ?*astalwp.Device;
    pub const getDevice = astal_wp_audio_get_device;

    /// a GList containing the devices
    extern fn astal_wp_audio_get_devices(p_self: *Audio) ?*glib.List;
    pub const getDevices = astal_wp_audio_get_devices;

    /// gets the microphone with the given id
    extern fn astal_wp_audio_get_microphone(p_self: *Audio, p_id: c_uint) ?*astalwp.Endpoint;
    pub const getMicrophone = astal_wp_audio_get_microphone;

    /// a GList containing the microphones
    extern fn astal_wp_audio_get_microphones(p_self: *Audio) ?*glib.List;
    pub const getMicrophones = astal_wp_audio_get_microphones;

    /// the node with the given id
    extern fn astal_wp_audio_get_node(p_self: *Audio, p_id: c_uint) ?*astalwp.Node;
    pub const getNode = astal_wp_audio_get_node;

    /// gets the recorder with the given id
    extern fn astal_wp_audio_get_recorder(p_self: *Audio, p_id: c_uint) ?*astalwp.Stream;
    pub const getRecorder = astal_wp_audio_get_recorder;

    /// a GList containing the recorders
    extern fn astal_wp_audio_get_recorders(p_self: *Audio) ?*glib.List;
    pub const getRecorders = astal_wp_audio_get_recorders;

    /// gets the speaker with the given id
    extern fn astal_wp_audio_get_speaker(p_self: *Audio, p_id: c_uint) ?*astalwp.Endpoint;
    pub const getSpeaker = astal_wp_audio_get_speaker;

    /// a GList containing the speakers
    extern fn astal_wp_audio_get_speakers(p_self: *Audio) ?*glib.List;
    pub const getSpeakers = astal_wp_audio_get_speakers;

    /// gets the stream with the given id
    extern fn astal_wp_audio_get_stream(p_self: *Audio, p_id: c_uint) ?*astalwp.Stream;
    pub const getStream = astal_wp_audio_get_stream;

    /// a GList containing the streams
    extern fn astal_wp_audio_get_streams(p_self: *Audio) ?*glib.List;
    pub const getStreams = astal_wp_audio_get_streams;

    extern fn astal_wp_audio_get_type() usize;
    pub const getGObjectType = astal_wp_audio_get_type;

    extern fn g_object_ref(p_self: *astalwp.Audio) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Audio) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Audio, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Channel = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalwp.ChannelClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const volume = struct {
            pub const name = "volume";

            pub const Type = f64;
        };

        pub const volume_icon = struct {
            pub const name = "volume-icon";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// the name of the channel
    extern fn astal_wp_channel_get_name(p_self: *Channel) [*:0]const u8;
    pub const getName = astal_wp_channel_get_name;

    /// the volume of the channel
    extern fn astal_wp_channel_get_volume(p_self: *Channel) f64;
    pub const getVolume = astal_wp_channel_get_volume;

    extern fn astal_wp_channel_get_volume_icon(p_self: *Channel) [*:0]const u8;
    pub const getVolumeIcon = astal_wp_channel_get_volume_icon;

    /// sets the volume for this channel. Note that if `astalwp.Node.properties.lock_channels` is true for
    /// the node this channel is associated with, this method will set the volume for all channels.
    extern fn astal_wp_channel_set_volume(p_self: *Channel, p_volume: f64) void;
    pub const setVolume = astal_wp_channel_set_volume;

    extern fn astal_wp_channel_get_type() usize;
    pub const getGObjectType = astal_wp_channel_get_type;

    extern fn g_object_ref(p_self: *astalwp.Channel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Channel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Channel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Device = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalwp.DeviceClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The id of the currently active profile.
        pub const active_profile_id = struct {
            pub const name = "active-profile-id";

            pub const Type = c_int;
        };

        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        pub const device = struct {
            pub const name = "device";

            pub const Type = @compileError("no type information available");
        };

        /// The type of this device
        pub const device_type = struct {
            pub const name = "device-type";

            pub const Type = astalwp.DeviceType;
        };

        /// The from factor of this device.
        pub const form_factor = struct {
            pub const name = "form-factor";

            pub const Type = ?[*:0]u8;
        };

        /// The icon name for this device.
        pub const icon = struct {
            pub const name = "icon";

            pub const Type = ?[*:0]u8;
        };

        /// The id of this device.
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_uint;
        };

        /// The id of the currently active input route.
        pub const input_route_id = struct {
            pub const name = "input-route-id";

            pub const Type = c_int;
        };

        /// A list of available input routes
        pub const input_routes = struct {
            pub const name = "input-routes";

            pub const Type = ?**glib.List;
        };

        /// The id of the currently active output route.
        pub const output_route_id = struct {
            pub const name = "output-route-id";

            pub const Type = c_int;
        };

        /// A list of available output routes
        pub const output_routes = struct {
            pub const name = "output-routes";

            pub const Type = ?**glib.List;
        };

        /// A list of available profiles
        pub const profiles = struct {
            pub const name = "profiles";

            pub const Type = ?**glib.List;
        };

        /// A list of available routes
        pub const routes = struct {
            pub const name = "routes";

            pub const Type = ?**glib.List;
        };
    };

    pub const signals = struct {};

    /// gets the currently active profile of this device
    extern fn astal_wp_device_get_active_profile_id(p_self: *Device) c_int;
    pub const getActiveProfileId = astal_wp_device_get_active_profile_id;

    /// gets the description of this device
    extern fn astal_wp_device_get_description(p_self: *Device) ?[*:0]const u8;
    pub const getDescription = astal_wp_device_get_description;

    /// gets the type of this device
    extern fn astal_wp_device_get_device_type(p_self: *Device) astalwp.DeviceType;
    pub const getDeviceType = astal_wp_device_get_device_type;

    /// gets the form factor of this device.
    extern fn astal_wp_device_get_form_factor(p_self: *Device) ?[*:0]const u8;
    pub const getFormFactor = astal_wp_device_get_form_factor;

    /// gets the icon of this device
    extern fn astal_wp_device_get_icon(p_self: *Device) [*:0]const u8;
    pub const getIcon = astal_wp_device_get_icon;

    /// gets the id of this device
    extern fn astal_wp_device_get_id(p_self: *Device) c_uint;
    pub const getId = astal_wp_device_get_id;

    /// gets the currently active input route of this device
    extern fn astal_wp_device_get_input_route_id(p_self: *Device) c_int;
    pub const getInputRouteId = astal_wp_device_get_input_route_id;

    /// gets a GList containing the input routes
    extern fn astal_wp_device_get_input_routes(p_self: *Device) ?*glib.List;
    pub const getInputRoutes = astal_wp_device_get_input_routes;

    /// gets the currently active output route of this device
    extern fn astal_wp_device_get_output_route_id(p_self: *Device) c_int;
    pub const getOutputRouteId = astal_wp_device_get_output_route_id;

    /// gets a GList containing the output routes
    extern fn astal_wp_device_get_output_routes(p_self: *Device) ?*glib.List;
    pub const getOutputRoutes = astal_wp_device_get_output_routes;

    /// gets the profile with the given id
    extern fn astal_wp_device_get_profile(p_self: *Device, p_id: c_int) ?*astalwp.Profile;
    pub const getProfile = astal_wp_device_get_profile;

    /// gets a GList containing the profiles
    extern fn astal_wp_device_get_profiles(p_self: *Device) ?*glib.List;
    pub const getProfiles = astal_wp_device_get_profiles;

    /// Gets the pipewire property with the give key. You should use the GObject properties of this node
    /// whereever possible, as you can get notified on changes, which is not the case here.
    extern fn astal_wp_device_get_pw_property(p_self: *Device, p_key: [*:0]const u8) ?[*:0]u8;
    pub const getPwProperty = astal_wp_device_get_pw_property;

    /// gets the route with the given id
    extern fn astal_wp_device_get_route(p_self: *Device, p_id: c_int) ?*astalwp.Route;
    pub const getRoute = astal_wp_device_get_route;

    /// gets a GList containing the routes
    extern fn astal_wp_device_get_routes(p_self: *Device) ?*glib.List;
    pub const getRoutes = astal_wp_device_get_routes;

    /// sets the profile for this device
    extern fn astal_wp_device_set_active_profile_id(p_self: *Device, p_profile_id: c_int) void;
    pub const setActiveProfileId = astal_wp_device_set_active_profile_id;

    /// sets the route for this device. You should use the `astalwp.Endpoint.setRoute` instead.
    extern fn astal_wp_device_set_route(p_self: *Device, p_route: *astalwp.Route, p_card_device: c_uint) void;
    pub const setRoute = astal_wp_device_set_route;

    extern fn astal_wp_device_get_type() usize;
    pub const getGObjectType = astal_wp_device_get_type;

    extern fn g_object_ref(p_self: *astalwp.Device) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Device) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Device, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Endpoint = opaque {
    pub const Parent = astalwp.Node;
    pub const Implements = [_]type{};
    pub const Class = astalwp.EndpointClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const default_plugin = struct {
            pub const name = "default-plugin";

            pub const Type = @compileError("no type information available");
        };

        /// The the device associated with this endpoint.
        pub const device = struct {
            pub const name = "device";

            pub const Type = ?*astalwp.Device;
        };

        /// The id of the device associated with this endpoint.
        pub const device_id = struct {
            pub const name = "device-id";

            pub const Type = c_uint;
        };

        /// Whether this node is the default one used for this media-class. Note that setting this
        /// property to false has no effect.
        pub const is_default = struct {
            pub const name = "is-default";

            pub const Type = c_int;
        };

        pub const is_default_node = struct {
            pub const name = "is-default-node";

            pub const Type = c_int;
        };

        pub const route = struct {
            pub const name = "route";

            pub const Type = ?*astalwp.Route;
        };

        pub const route_id = struct {
            pub const name = "route-id";

            pub const Type = c_uint;
        };

        /// A list of available routes
        pub const routes = struct {
            pub const name = "routes";

            pub const Type = ?**glib.List;
        };
    };

    pub const signals = struct {};

    /// gets the device associated with this endpoint
    extern fn astal_wp_endpoint_get_device(p_self: *Endpoint) ?*astalwp.Device;
    pub const getDevice = astal_wp_endpoint_get_device;

    /// gets the id of the device associated with this endpoint
    extern fn astal_wp_endpoint_get_device_id(p_self: *Endpoint) c_uint;
    pub const getDeviceId = astal_wp_endpoint_get_device_id;

    /// is this endpoint configured as the default.
    extern fn astal_wp_endpoint_get_is_default(p_self: *Endpoint) c_int;
    pub const getIsDefault = astal_wp_endpoint_get_is_default;

    /// Gets the currently active `astalwp.Route`
    extern fn astal_wp_endpoint_get_route(p_self: *Endpoint) ?*astalwp.Route;
    pub const getRoute = astal_wp_endpoint_get_route;

    /// gets the id of the currently active route
    extern fn astal_wp_endpoint_get_route_id(p_self: *Endpoint) c_uint;
    pub const getRouteId = astal_wp_endpoint_get_route_id;

    /// Gets a list of available routes.
    /// This list is filtered and contains only routes, that are actually available. You can get a full
    /// list of routes from `astalwp.Device.properties.routes`
    extern fn astal_wp_endpoint_get_routes(p_self: *Endpoint) ?*glib.List;
    pub const getRoutes = astal_wp_endpoint_get_routes;

    /// Sets this endpoint as the default
    extern fn astal_wp_endpoint_set_is_default(p_self: *Endpoint, p_is_default: c_int) void;
    pub const setIsDefault = astal_wp_endpoint_set_is_default;

    /// Sets the currently active `astalwp.Route`
    extern fn astal_wp_endpoint_set_route(p_self: *Endpoint, p_route: *astalwp.Route) void;
    pub const setRoute = astal_wp_endpoint_set_route;

    /// Sets the currently active route id
    extern fn astal_wp_endpoint_set_route_id(p_self: *Endpoint, p_route_id: c_uint) void;
    pub const setRouteId = astal_wp_endpoint_set_route_id;

    extern fn astal_wp_endpoint_get_type() usize;
    pub const getGObjectType = astal_wp_endpoint_get_type;

    extern fn g_object_ref(p_self: *astalwp.Endpoint) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Endpoint) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Endpoint, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Node = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalwp.NodeClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const metadata_changed = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_key: [*:0]const u8, p_type: [*:0]const u8, p_value: [*:0]const u8) void {
                return gobject.ext.as(Node.Class, p_class).f_metadata_changed.?(gobject.ext.as(Node, p_self), p_key, p_type, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_key: [*:0]const u8, p_type: [*:0]const u8, p_value: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Node.Class, p_class).f_metadata_changed = @ptrCast(p_implementation);
            }
        };

        pub const params_changed = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_id: [*:0]const u8) void {
                return gobject.ext.as(Node.Class, p_class).f_params_changed.?(gobject.ext.as(Node, p_self), p_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_id: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Node.Class, p_class).f_params_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// A list of per channel volumes
        pub const channels = struct {
            pub const name = "channels";

            pub const Type = ?**glib.List;
        };

        /// The description of this node
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// The icon of this node. Note that nodes do not have icons associated with them in
        /// pipewire, so the icon of the associated device is used instead.
        pub const icon = struct {
            pub const name = "icon";

            pub const Type = ?[*:0]u8;
        };

        /// The pipewire id of this node.
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_uint;
        };

        /// Whether to lock the channels together or not.
        pub const lock_channels = struct {
            pub const name = "lock-channels";

            pub const Type = c_int;
        };

        /// The media class of this node
        pub const media_class = struct {
            pub const name = "media-class";

            pub const Type = astalwp.MediaClass;
        };

        pub const mixer_plugin = struct {
            pub const name = "mixer-plugin";

            pub const Type = @compileError("no type information available");
        };

        /// The mute state of this node
        pub const mute = struct {
            pub const name = "mute";

            pub const Type = c_int;
        };

        /// The name of this node
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const node = struct {
            pub const name = "node";

            pub const Type = @compileError("no type information available");
        };

        /// The object path of this node
        pub const path = struct {
            pub const name = "path";

            pub const Type = ?[*:0]u8;
        };

        /// The object serial of this node.
        pub const serial = struct {
            pub const name = "serial";

            pub const Type = c_int;
        };

        /// the current state of this node.
        pub const state = struct {
            pub const name = "state";

            pub const Type = astalwp.NodeState;
        };

        /// The volume of this node
        pub const volume = struct {
            pub const name = "volume";

            pub const Type = f64;
        };

        /// The volume icon of this node
        pub const volume_icon = struct {
            pub const name = "volume-icon";

            pub const Type = ?[*:0]u8;
        };

        pub const wp = struct {
            pub const name = "wp";

            pub const Type = ?*astalwp.Wp;
        };
    };

    pub const signals = struct {};

    /// gets the list representing the per channel volumes
    extern fn astal_wp_node_get_channels(p_self: *Node) ?*glib.List;
    pub const getChannels = astal_wp_node_get_channels;

    /// gets the description of this node
    extern fn astal_wp_node_get_description(p_self: *Node) ?[*:0]const u8;
    pub const getDescription = astal_wp_node_get_description;

    /// gets the icon for this node
    extern fn astal_wp_node_get_icon(p_self: *Node) [*:0]const u8;
    pub const getIcon = astal_wp_node_get_icon;

    /// gets the id of the node.
    extern fn astal_wp_node_get_id(p_self: *Node) c_uint;
    pub const getId = astal_wp_node_get_id;

    extern fn astal_wp_node_get_lock_channels(p_self: *Node) c_int;
    pub const getLockChannels = astal_wp_node_get_lock_channels;

    /// gets the media class of the node.
    extern fn astal_wp_node_get_media_class(p_self: *Node) astalwp.MediaClass;
    pub const getMediaClass = astal_wp_node_get_media_class;

    /// gets the mute status of the node.
    extern fn astal_wp_node_get_mute(p_self: *Node) c_int;
    pub const getMute = astal_wp_node_get_mute;

    /// gets the name of this node
    extern fn astal_wp_node_get_name(p_self: *Node) ?[*:0]const u8;
    pub const getName = astal_wp_node_get_name;

    /// gets the object path of this node
    extern fn astal_wp_node_get_path(p_self: *Node) ?[*:0]const u8;
    pub const getPath = astal_wp_node_get_path;

    /// Gets the pipewire property with the give key. You should use the GObject properties of this node
    /// whereever possible, as you can get notified on changes, which is not the case here.
    extern fn astal_wp_node_get_pw_property(p_self: *Node, p_key: [*:0]const u8) ?[*:0]u8;
    pub const getPwProperty = astal_wp_node_get_pw_property;

    /// gets the serial number of this node
    extern fn astal_wp_node_get_serial(p_self: *Node) c_int;
    pub const getSerial = astal_wp_node_get_serial;

    /// gets the current state of this node
    extern fn astal_wp_node_get_state(p_self: *Node) astalwp.NodeState;
    pub const getState = astal_wp_node_get_state;

    /// gets the volume
    extern fn astal_wp_node_get_volume(p_self: *Node) f64;
    pub const getVolume = astal_wp_node_get_volume;

    extern fn astal_wp_node_get_volume_icon(p_self: *Node) [*:0]const u8;
    pub const getVolumeIcon = astal_wp_node_get_volume_icon;

    extern fn astal_wp_node_metadata_changed(p_self: *Node, p_key: [*:0]const u8, p_type: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const metadataChanged = astal_wp_node_metadata_changed;

    extern fn astal_wp_node_params_changed(p_self: *Node, p_id: [*:0]const u8) void;
    pub const paramsChanged = astal_wp_node_params_changed;

    /// Lock the channel volumes together. If set, all channels will always have the same volume.
    extern fn astal_wp_node_set_lock_channels(p_self: *Node, p_lock_channels: c_int) void;
    pub const setLockChannels = astal_wp_node_set_lock_channels;

    /// Sets the mute status for the node.
    extern fn astal_wp_node_set_mute(p_self: *Node, p_mute: c_int) void;
    pub const setMute = astal_wp_node_set_mute;

    /// Sets the volume level for this node. The volume is clamped to be between
    /// 0 and 1.5.
    extern fn astal_wp_node_set_volume(p_self: *Node, p_volume: f64) void;
    pub const setVolume = astal_wp_node_set_volume;

    extern fn astal_wp_node_get_type() usize;
    pub const getGObjectType = astal_wp_node_get_type;

    extern fn g_object_ref(p_self: *astalwp.Node) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Node) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Node, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Profile = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalwp.ProfileClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// the available state of this profile
        pub const available = struct {
            pub const name = "available";

            pub const Type = astalwp.Available;
        };

        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        pub const index = struct {
            pub const name = "index";

            pub const Type = c_int;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const priority = struct {
            pub const name = "priority";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn astal_wp_profile_get_available(p_self: *Profile) astalwp.Available;
    pub const getAvailable = astal_wp_profile_get_available;

    extern fn astal_wp_profile_get_description(p_self: *Profile) [*:0]const u8;
    pub const getDescription = astal_wp_profile_get_description;

    extern fn astal_wp_profile_get_index(p_self: *Profile) c_int;
    pub const getIndex = astal_wp_profile_get_index;

    extern fn astal_wp_profile_get_name(p_self: *Profile) [*:0]const u8;
    pub const getName = astal_wp_profile_get_name;

    extern fn astal_wp_profile_get_priority(p_self: *Profile) c_int;
    pub const getPriority = astal_wp_profile_get_priority;

    extern fn astal_wp_profile_get_type() usize;
    pub const getGObjectType = astal_wp_profile_get_type;

    extern fn g_object_ref(p_self: *astalwp.Profile) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Profile) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Profile, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Route = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalwp.RouteClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// the available state of this route
        pub const available = struct {
            pub const name = "available";

            pub const Type = astalwp.Available;
        };

        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// The direction for this route
        pub const direction = struct {
            pub const name = "direction";

            pub const Type = astalwp.Direction;
        };

        pub const index = struct {
            pub const name = "index";

            pub const Type = c_int;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const priority = struct {
            pub const name = "priority";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn astal_wp_route_get_available(p_self: *Route) astalwp.Available;
    pub const getAvailable = astal_wp_route_get_available;

    extern fn astal_wp_route_get_description(p_self: *Route) [*:0]const u8;
    pub const getDescription = astal_wp_route_get_description;

    extern fn astal_wp_route_get_device(p_self: *Route) c_int;
    pub const getDevice = astal_wp_route_get_device;

    extern fn astal_wp_route_get_direction(p_self: *Route) astalwp.Direction;
    pub const getDirection = astal_wp_route_get_direction;

    extern fn astal_wp_route_get_index(p_self: *Route) c_int;
    pub const getIndex = astal_wp_route_get_index;

    extern fn astal_wp_route_get_name(p_self: *Route) [*:0]const u8;
    pub const getName = astal_wp_route_get_name;

    extern fn astal_wp_route_get_priority(p_self: *Route) c_int;
    pub const getPriority = astal_wp_route_get_priority;

    extern fn astal_wp_route_get_type() usize;
    pub const getGObjectType = astal_wp_route_get_type;

    extern fn g_object_ref(p_self: *astalwp.Route) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Route) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Route, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Stream = opaque {
    pub const Parent = astalwp.Node;
    pub const Implements = [_]type{};
    pub const Class = astalwp.StreamClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// the media category of this stream.
        pub const media_category = struct {
            pub const name = "media-category";

            pub const Type = astalwp.MediaCategory;
        };

        /// the media role of this stream.
        pub const media_role = struct {
            pub const name = "media-role";

            pub const Type = astalwp.MediaRole;
        };

        pub const target_endpoint = struct {
            pub const name = "target-endpoint";

            pub const Type = ?*astalwp.Endpoint;
        };

        pub const target_serial = struct {
            pub const name = "target-serial";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn astal_wp_stream_get_media_category(p_self: *Stream) astalwp.MediaCategory;
    pub const getMediaCategory = astal_wp_stream_get_media_category;

    extern fn astal_wp_stream_get_media_role(p_self: *Stream) astalwp.MediaRole;
    pub const getMediaRole = astal_wp_stream_get_media_role;

    /// get the target `astalwp.Endpoint`
    extern fn astal_wp_stream_get_target_endpoint(p_self: *Stream) ?*astalwp.Endpoint;
    pub const getTargetEndpoint = astal_wp_stream_get_target_endpoint;

    extern fn astal_wp_stream_get_target_serial(p_self: *Stream) c_int;
    pub const getTargetSerial = astal_wp_stream_get_target_serial;

    /// set the target `astalwp.Endpoint`
    extern fn astal_wp_stream_set_target_endpoint(p_self: *Stream, p_target: ?*astalwp.Endpoint) void;
    pub const setTargetEndpoint = astal_wp_stream_set_target_endpoint;

    extern fn astal_wp_stream_set_target_serial(p_self: *Stream, p_serial: c_int) void;
    pub const setTargetSerial = astal_wp_stream_set_target_serial;

    extern fn astal_wp_stream_get_type() usize;
    pub const getGObjectType = astal_wp_stream_get_type;

    extern fn g_object_ref(p_self: *astalwp.Stream) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Stream) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Stream, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// is instanciated by `astalwp.Wp`. An instance of class can only be received there.
///
///  This is a convinience class and acts as a filter for `astalwp.Wp` to filter for video
/// endpoints and devices.
pub const Video = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalwp.VideoClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// A list of AstalWpEndpoint objects
        pub const devices = struct {
            pub const name = "devices";

            pub const Type = ?**glib.List;
        };

        /// A list of AstalWpEndpoint objects
        pub const recorders = struct {
            pub const name = "recorders";

            pub const Type = ?**glib.List;
        };

        /// A list of AstalWpEndpoint objects
        pub const sinks = struct {
            pub const name = "sinks";

            pub const Type = ?**glib.List;
        };

        /// A list of AstalWpEndpoint objects
        pub const sources = struct {
            pub const name = "sources";

            pub const Type = ?**glib.List;
        };

        /// A list of AstalWpEndpoint objects
        pub const streams = struct {
            pub const name = "streams";

            pub const Type = ?**glib.List;
        };
    };

    pub const signals = struct {
        pub const device_added = struct {
            pub const name = "device-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("device-added", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const device_removed = struct {
            pub const name = "device-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("device-removed", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const recorder_added = struct {
            pub const name = "recorder-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Stream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("recorder-added", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const recorder_removed = struct {
            pub const name = "recorder-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Stream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("recorder-removed", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const sink_added = struct {
            pub const name = "sink-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Endpoint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("sink-added", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const sink_removed = struct {
            pub const name = "sink-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Endpoint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("sink-removed", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const source_added = struct {
            pub const name = "source-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Endpoint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("source-added", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const source_removed = struct {
            pub const name = "source-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Endpoint, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("source-removed", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const stream_added = struct {
            pub const name = "stream-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Stream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("stream-added", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const stream_removed = struct {
            pub const name = "stream-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Stream, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Video, p_instance))),
                    gobject.signalLookup("stream-removed", Video.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn astal_wp_video_new(p_wp: *astalwp.Wp) *astalwp.Video;
    pub const new = astal_wp_video_new;

    /// the device with the given id
    extern fn astal_wp_video_get_device(p_self: *Video, p_id: c_uint) ?*astalwp.Device;
    pub const getDevice = astal_wp_video_get_device;

    /// a list containing the devices
    extern fn astal_wp_video_get_devices(p_self: *Video) ?*glib.List;
    pub const getDevices = astal_wp_video_get_devices;

    /// the recorder with the given id
    extern fn astal_wp_video_get_recorder(p_self: *Video, p_id: c_uint) ?*astalwp.Stream;
    pub const getRecorder = astal_wp_video_get_recorder;

    /// a list containing the video recorders
    extern fn astal_wp_video_get_recorders(p_self: *Video) ?*glib.List;
    pub const getRecorders = astal_wp_video_get_recorders;

    /// the sink with the given id
    extern fn astal_wp_video_get_sink(p_self: *Video, p_id: c_uint) ?*astalwp.Endpoint;
    pub const getSink = astal_wp_video_get_sink;

    /// a list containing the video sinks
    extern fn astal_wp_video_get_sinks(p_self: *Video) ?*glib.List;
    pub const getSinks = astal_wp_video_get_sinks;

    /// the source with the given id
    extern fn astal_wp_video_get_source(p_self: *Video, p_id: c_uint) ?*astalwp.Endpoint;
    pub const getSource = astal_wp_video_get_source;

    /// a list containing the video sources
    extern fn astal_wp_video_get_sources(p_self: *Video) ?*glib.List;
    pub const getSources = astal_wp_video_get_sources;

    /// the stream with the given id
    extern fn astal_wp_video_get_stream(p_self: *Video, p_id: c_uint) ?*astalwp.Stream;
    pub const getStream = astal_wp_video_get_stream;

    /// a list containing the video streams
    extern fn astal_wp_video_get_streams(p_self: *Video) ?*glib.List;
    pub const getStreams = astal_wp_video_get_streams;

    extern fn astal_wp_video_get_type() usize;
    pub const getGObjectType = astal_wp_video_get_type;

    extern fn g_object_ref(p_self: *astalwp.Video) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Video) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Video, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// manages the connection to wireplumber. Usually you don't want to use this class directly, but use
/// the `astalwp.Audio` or `astalwp.Video` instead.
pub const Wp = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalwp.WpClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const audio = struct {
            pub const name = "audio";

            pub const Type = ?*astalwp.Audio;
        };

        /// The connection status to the pipewire daemon
        pub const connected = struct {
            pub const name = "connected";

            pub const Type = c_int;
        };

        /// The `astalwp.Endpoint` representing the default micophone
        pub const default_microphone = struct {
            pub const name = "default-microphone";

            pub const Type = ?*astalwp.Endpoint;
        };

        /// The `astalwp.Endpoint` representing the default speaker
        pub const default_speaker = struct {
            pub const name = "default-speaker";

            pub const Type = ?*astalwp.Endpoint;
        };

        /// A list of `astalwp.Device` objects
        pub const devices = struct {
            pub const name = "devices";

            pub const Type = ?**glib.List;
        };

        /// A list of `astalwp.Node` objects
        pub const nodes = struct {
            pub const name = "nodes";

            pub const Type = ?**glib.List;
        };

        /// The scale used for the volume
        pub const scale = struct {
            pub const name = "scale";

            pub const Type = astalwp.Scale;
        };

        pub const video = struct {
            pub const name = "video";

            pub const Type = ?*astalwp.Video;
        };
    };

    pub const signals = struct {
        pub const device_added = struct {
            pub const name = "device-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Wp, p_instance))),
                    gobject.signalLookup("device-added", Wp.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const device_removed = struct {
            pub const name = "device-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Wp, p_instance))),
                    gobject.signalLookup("device-removed", Wp.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const node_added = struct {
            pub const name = "node-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Node, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Wp, p_instance))),
                    gobject.signalLookup("node-added", Wp.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const node_removed = struct {
            pub const name = "node-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *astalwp.Node, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Wp, p_instance))),
                    gobject.signalLookup("node-removed", Wp.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const ready = struct {
            pub const name = "ready";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Wp, p_instance))),
                    gobject.signalLookup("ready", Wp.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// gets the default wireplumber object.
    extern fn astal_wp_wp_get_default() *astalwp.Wp;
    pub const getDefault = astal_wp_wp_get_default;

    /// gets the `astalwp.Audio` object
    extern fn astal_wp_wp_get_audio(p_self: *Wp) *astalwp.Audio;
    pub const getAudio = astal_wp_wp_get_audio;

    /// gets the default microphone object
    extern fn astal_wp_wp_get_default_microphone(p_self: *Wp) *astalwp.Endpoint;
    pub const getDefaultMicrophone = astal_wp_wp_get_default_microphone;

    /// gets the default speaker object
    extern fn astal_wp_wp_get_default_speaker(p_self: *Wp) *astalwp.Endpoint;
    pub const getDefaultSpeaker = astal_wp_wp_get_default_speaker;

    /// the device with the given id
    extern fn astal_wp_wp_get_device(p_self: *Wp, p_id: c_uint) ?*astalwp.Device;
    pub const getDevice = astal_wp_wp_get_device;

    /// the GList containing the devices
    extern fn astal_wp_wp_get_devices(p_self: *Wp) ?*glib.List;
    pub const getDevices = astal_wp_wp_get_devices;

    /// the node with the given id
    extern fn astal_wp_wp_get_node(p_self: *Wp, p_id: c_uint) ?*astalwp.Node;
    pub const getNode = astal_wp_wp_get_node;

    /// finds the AstalWpNode with the give serial.
    extern fn astal_wp_wp_get_node_by_serial(p_self: *Wp, p_serial: c_int) ?*astalwp.Node;
    pub const getNodeBySerial = astal_wp_wp_get_node_by_serial;

    /// a GList containing all nodes
    extern fn astal_wp_wp_get_nodes(p_self: *Wp) ?*glib.List;
    pub const getNodes = astal_wp_wp_get_nodes;

    extern fn astal_wp_wp_get_scale(p_self: *Wp) astalwp.Scale;
    pub const getScale = astal_wp_wp_get_scale;

    /// gets the video object
    extern fn astal_wp_wp_get_video(p_self: *Wp) *astalwp.Video;
    pub const getVideo = astal_wp_wp_get_video;

    extern fn astal_wp_wp_set_scale(p_self: *Wp, p_scale: astalwp.Scale) void;
    pub const setScale = astal_wp_wp_set_scale;

    extern fn astal_wp_wp_get_type() usize;
    pub const getGObjectType = astal_wp_wp_get_type;

    extern fn g_object_ref(p_self: *astalwp.Wp) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalwp.Wp) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Wp, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AudioClass = extern struct {
    pub const Instance = astalwp.Audio;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *AudioClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ChannelClass = extern struct {
    pub const Instance = astalwp.Channel;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ChannelClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceClass = extern struct {
    pub const Instance = astalwp.Device;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *DeviceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EndpointClass = extern struct {
    pub const Instance = astalwp.Endpoint;

    f_parent_class: astalwp.NodeClass,

    pub fn as(p_instance: *EndpointClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NodeClass = extern struct {
    pub const Instance = astalwp.Node;

    f_parent_class: gobject.ObjectClass,
    f_params_changed: ?*const fn (p_self: *astalwp.Node, p_id: [*:0]const u8) callconv(.c) void,
    f_metadata_changed: ?*const fn (p_self: *astalwp.Node, p_key: [*:0]const u8, p_type: [*:0]const u8, p_value: [*:0]const u8) callconv(.c) void,

    pub fn as(p_instance: *NodeClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProfileClass = extern struct {
    pub const Instance = astalwp.Profile;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ProfileClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RouteClass = extern struct {
    pub const Instance = astalwp.Route;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *RouteClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamClass = extern struct {
    pub const Instance = astalwp.Stream;

    f_parent_class: astalwp.NodeClass,

    pub fn as(p_instance: *StreamClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VideoClass = extern struct {
    pub const Instance = astalwp.Video;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *VideoClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WpClass = extern struct {
    pub const Instance = astalwp.Wp;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *WpClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Available = enum(c_int) {
    unknown = 0,
    no = 1,
    yes = 2,
    _,

    extern fn astal_wp_available_get_type() usize;
    pub const getGObjectType = astal_wp_available_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceType = enum(c_int) {
    Unknown = 0,
    Audio_Device = 1,
    Video_Device = 2,
    _,

    extern fn astal_wp_device_type_from_string(p_string: [*:0]const u8) astalwp.DeviceType;
    pub const fromString = astal_wp_device_type_from_string;

    extern fn astal_wp_device_type_to_string(p_device_type: astalwp.DeviceType) [*:0]u8;
    pub const toString = astal_wp_device_type_to_string;

    extern fn astal_wp_device_type_get_type() usize;
    pub const getGObjectType = astal_wp_device_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Direction = enum(c_int) {
    Input = 0,
    Output = 1,
    _,

    extern fn astal_wp_direction_get_type() usize;
    pub const getGObjectType = astal_wp_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MediaCategory = enum(c_int) {
    Unknown = 0,
    Playback = 1,
    Capture = 2,
    Duplex = 3,
    Monitor = 4,
    Manager = 5,
    _,

    extern fn astal_wp_media_category_from_string(p_string: [*:0]const u8) astalwp.MediaCategory;
    pub const fromString = astal_wp_media_category_from_string;

    extern fn astal_wp_media_category_to_string(p_category: astalwp.MediaCategory) [*:0]u8;
    pub const toString = astal_wp_media_category_to_string;

    extern fn astal_wp_media_category_get_type() usize;
    pub const getGObjectType = astal_wp_media_category_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MediaClass = enum(c_int) {
    Unknown = 0,
    Audio_Source = 1,
    Audio_Sink = 2,
    Stream_Input_Audio = 3,
    Stream_Output_Audio = 4,
    Video_Source = 5,
    Video_Sink = 6,
    Stream_Input_Video = 7,
    Stream_Output_Video = 8,
    _,

    extern fn astal_wp_media_class_from_string(p_string: [*:0]const u8) astalwp.MediaClass;
    pub const fromString = astal_wp_media_class_from_string;

    extern fn astal_wp_media_class_to_string(p_media_class: astalwp.MediaClass) [*:0]u8;
    pub const toString = astal_wp_media_class_to_string;

    extern fn astal_wp_media_class_get_type() usize;
    pub const getGObjectType = astal_wp_media_class_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MediaRole = enum(c_int) {
    Unknown = 0,
    Movie = 1,
    Music = 2,
    Camera = 3,
    Screen = 4,
    Communication = 5,
    Game = 6,
    Notification = 7,
    DSP = 8,
    Production = 9,
    Accessibility = 10,
    Test = 11,
    _,

    extern fn astal_wp_media_role_from_string(p_string: [*:0]const u8) astalwp.MediaRole;
    pub const fromString = astal_wp_media_role_from_string;

    extern fn astal_wp_media_role_to_string(p_role: astalwp.MediaRole) [*:0]u8;
    pub const toString = astal_wp_media_role_to_string;

    extern fn astal_wp_media_role_get_type() usize;
    pub const getGObjectType = astal_wp_media_role_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NodeState = enum(c_int) {
    @"error" = -1,
    creating = 0,
    suspended = 1,
    idle = 2,
    running = 3,
    _,

    extern fn astal_wp_node_state_get_type() usize;
    pub const getGObjectType = astal_wp_node_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Scale = enum(c_int) {
    linear = 0,
    cubic = 1,
    _,

    extern fn astal_wp_scale_get_type() usize;
    pub const getGObjectType = astal_wp_scale_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// gets the default wireplumber object.
extern fn astal_wp_get_default() *astalwp.Wp;
pub const getDefault = astal_wp_get_default;

pub const MAJOR_VERSION = 0;
pub const MICRO_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
