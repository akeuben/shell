pub const ext = @import("ext.zig");
const gdk = @This();

const std = @import("std");
const compat = @import("compat");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const pangocairo = @import("pangocairo1");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const gdkpixbuf = @import("gdkpixbuf2");
/// Handles launching an application in a graphical context.
///
/// It is an implementation of `GAppLaunchContext` that provides startup
/// notification and allows to launch applications on a specific workspace.
///
/// ## Launching an application
///
/// ```c
/// GdkAppLaunchContext *context;
///
/// context = gdk_display_get_app_launch_context (display);
///
/// gdk_app_launch_context_set_timestamp (gdk_event_get_time (event));
///
/// if (!g_app_info_launch_default_for_uri ("http://www.gtk.org", context, &error))
///   g_warning ("Launching failed: `s`\n", error->message);
///
/// g_object_unref (context);
/// ```
pub const AppLaunchContext = opaque {
    pub const Parent = gio.AppLaunchContext;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = AppLaunchContext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The display that the `GdkAppLaunchContext` is on.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };
    };

    pub const signals = struct {};

    /// Gets the `GdkDisplay` that `context` is for.
    extern fn gdk_app_launch_context_get_display(p_context: *AppLaunchContext) *gdk.Display;
    pub const getDisplay = gdk_app_launch_context_get_display;

    /// Sets the workspace on which applications will be launched.
    ///
    /// This only works when running under a window manager that
    /// supports multiple workspaces, as described in the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec).
    /// Specifically this sets the `_NET_WM_DESKTOP` property described
    /// in that spec.
    ///
    /// This only works when using the X11 backend.
    ///
    /// When the workspace is not specified or `desktop` is set to -1,
    /// it is up to the window manager to pick one, typically it will
    /// be the current workspace.
    extern fn gdk_app_launch_context_set_desktop(p_context: *AppLaunchContext, p_desktop: c_int) void;
    pub const setDesktop = gdk_app_launch_context_set_desktop;

    /// Sets the icon for applications that are launched with this
    /// context.
    ///
    /// Window Managers can use this information when displaying startup
    /// notification.
    ///
    /// See also `gdk.AppLaunchContext.setIconName`.
    extern fn gdk_app_launch_context_set_icon(p_context: *AppLaunchContext, p_icon: ?*gio.Icon) void;
    pub const setIcon = gdk_app_launch_context_set_icon;

    /// Sets the icon for applications that are launched with this context.
    ///
    /// The `icon_name` will be interpreted in the same way as the Icon field
    /// in desktop files. See also `gdk.AppLaunchContext.setIcon`.
    ///
    /// If both `icon` and `icon_name` are set, the `icon_name` takes priority.
    /// If neither `icon` or `icon_name` is set, the icon is taken from either
    /// the file that is passed to launched application or from the `GAppInfo`
    /// for the launched application itself.
    extern fn gdk_app_launch_context_set_icon_name(p_context: *AppLaunchContext, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = gdk_app_launch_context_set_icon_name;

    /// Sets the timestamp of `context`.
    ///
    /// The timestamp should ideally be taken from the event that
    /// triggered the launch.
    ///
    /// Window managers can use this information to avoid moving the
    /// focus to the newly launched application when the user is busy
    /// typing in another window. This is also known as 'focus stealing
    /// prevention'.
    extern fn gdk_app_launch_context_set_timestamp(p_context: *AppLaunchContext, p_timestamp: u32) void;
    pub const setTimestamp = gdk_app_launch_context_set_timestamp;

    extern fn gdk_app_launch_context_get_type() usize;
    pub const getGObjectType = gdk_app_launch_context_get_type;

    extern fn g_object_ref(p_self: *gdk.AppLaunchContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.AppLaunchContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AppLaunchContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a button on a pointer device.
pub const ButtonEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ButtonEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extract the button number from a button event.
    extern fn gdk_button_event_get_button(p_event: *ButtonEvent) c_uint;
    pub const getButton = gdk_button_event_get_button;

    extern fn gdk_button_event_get_type() usize;
    pub const getGObjectType = gdk_button_event_get_type;

    pub fn as(p_instance: *ButtonEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents the platform-specific draw context.
///
/// `GdkCairoContext`s are created for a surface using
/// `gdk.Surface.createCairoContext`, and the context
/// can then be used to draw on that surface.
pub const CairoContext = opaque {
    pub const Parent = gdk.DrawContext;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = CairoContext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Retrieves a Cairo context to be used to draw on the `GdkSurface`
    /// of `context`.
    ///
    /// A call to `gdk.DrawContext.beginFrame` with this
    /// `context` must have been done or this function will return `NULL`.
    ///
    /// The returned context is guaranteed to be valid until
    /// `gdk.DrawContext.endFrame` is called.
    extern fn gdk_cairo_context_cairo_create(p_self: *CairoContext) ?*cairo.Context;
    pub const cairoCreate = gdk_cairo_context_cairo_create;

    extern fn gdk_cairo_context_get_type() usize;
    pub const getGObjectType = gdk_cairo_context_get_type;

    extern fn g_object_ref(p_self: *gdk.CairoContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.CairoContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CairoContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains the parameters that define a colorstate with cicp parameters.
///
/// Cicp parameters are specified in the ITU-T H.273
/// [specification](https://www.itu.int/rec/T-REC-H.273/en).
///
/// See the documentation of individual properties for supported values.
///
/// The 'unspecified' value (2) is not treated in any special way, and
/// must be replaced by a different value before creating a color state.
///
/// `GdkCicpParams` can be used as a builder object to construct a color
/// state from Cicp data with `gdk.CicpParams.buildColorState`.
/// The function will return an error if the given parameters are not
/// supported.
///
/// You can obtain a `GdkCicpParams` object from a color state with
/// `gdk.ColorState.createCicpParams`. This can be used to
/// create a variant of a color state, by changing just one of the cicp
/// parameters, or just to obtain information about the color state.
pub const CicpParams = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.CicpParamsClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The color primaries to use.
        ///
        /// Supported values:
        ///
        /// - 1: BT.709 / sRGB
        /// - 2: unspecified
        /// - 5: PAL
        /// - 6,7: BT.601 / NTSC
        /// - 9: BT.2020
        /// - 12: Display P3
        pub const color_primaries = struct {
            pub const name = "color-primaries";

            pub const Type = c_uint;
        };

        /// The matrix coefficients (for YUV to RGB conversion).
        ///
        /// Supported values:
        ///
        /// - 0: RGB
        /// - 2: unspecified
        pub const matrix_coefficients = struct {
            pub const name = "matrix-coefficients";

            pub const Type = c_uint;
        };

        /// Whether the data is using the full range of values.
        ///
        /// The range of the data.
        pub const range = struct {
            pub const name = "range";

            pub const Type = gdk.CicpRange;
        };

        /// The transfer function to use.
        ///
        /// Supported values:
        ///
        /// - 1,6,14,15: BT.709, BT.601, BT.2020
        /// - 2: unspecified
        /// - 4: gamma 2.2
        /// - 5: gamma 2.8
        /// - 8: linear
        /// - 13: sRGB
        /// - 16: BT.2100 PQ
        /// - 18: BT.2100 HLG
        pub const transfer_function = struct {
            pub const name = "transfer-function";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    /// Creates a new `GdkCicpParams` object.
    ///
    /// The initial values of the properties are the values for "undefined"
    /// and need to be set before a color state object can be built.
    extern fn gdk_cicp_params_new() *gdk.CicpParams;
    pub const new = gdk_cicp_params_new;

    /// Creates a new `GdkColorState` object for the cicp parameters in `self`.
    ///
    /// Note that this may fail if the cicp parameters in `self` are not
    /// supported by GTK. In that case, `NULL` is returned, and `error` is set
    /// with an error message that can be presented to the user.
    extern fn gdk_cicp_params_build_color_state(p_self: *CicpParams, p_error: ?*?*glib.Error) ?*gdk.ColorState;
    pub const buildColorState = gdk_cicp_params_build_color_state;

    /// Returns the value of the color-primaries property
    /// of `self`.
    extern fn gdk_cicp_params_get_color_primaries(p_self: *CicpParams) c_uint;
    pub const getColorPrimaries = gdk_cicp_params_get_color_primaries;

    /// Gets the matrix-coefficients property of `self`.
    extern fn gdk_cicp_params_get_matrix_coefficients(p_self: *CicpParams) c_uint;
    pub const getMatrixCoefficients = gdk_cicp_params_get_matrix_coefficients;

    /// Gets the range property of `self`.
    extern fn gdk_cicp_params_get_range(p_self: *CicpParams) gdk.CicpRange;
    pub const getRange = gdk_cicp_params_get_range;

    /// Gets the transfer-function property of `self`.
    extern fn gdk_cicp_params_get_transfer_function(p_self: *CicpParams) c_uint;
    pub const getTransferFunction = gdk_cicp_params_get_transfer_function;

    /// Sets the color-primaries property of `self`.
    extern fn gdk_cicp_params_set_color_primaries(p_self: *CicpParams, p_color_primaries: c_uint) void;
    pub const setColorPrimaries = gdk_cicp_params_set_color_primaries;

    /// `self` a `GdkCicpParams`
    /// Sets the matrix-coefficients property of `self`.
    extern fn gdk_cicp_params_set_matrix_coefficients(p_self: *CicpParams, p_matrix_coefficients: c_uint) void;
    pub const setMatrixCoefficients = gdk_cicp_params_set_matrix_coefficients;

    /// Sets the range property of `self`
    extern fn gdk_cicp_params_set_range(p_self: *CicpParams, p_range: gdk.CicpRange) void;
    pub const setRange = gdk_cicp_params_set_range;

    /// Sets the transfer-function property of `self`.
    extern fn gdk_cicp_params_set_transfer_function(p_self: *CicpParams, p_transfer_function: c_uint) void;
    pub const setTransferFunction = gdk_cicp_params_set_transfer_function;

    extern fn gdk_cicp_params_get_type() usize;
    pub const getGObjectType = gdk_cicp_params_get_type;

    extern fn g_object_ref(p_self: *gdk.CicpParams) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.CicpParams) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CicpParams, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents data shared between applications or inside an application.
///
/// To get a `GdkClipboard` object, use `gdk.Display.getClipboard` or
/// `gdk.Display.getPrimaryClipboard`. You can find out about the data
/// that is currently available in a clipboard using
/// `gdk.Clipboard.getFormats`.
///
/// To make text or image data available in a clipboard, use
/// `gdk.Clipboard.setText` or `gdk.Clipboard.setTexture`.
/// For other data, you can use `gdk.Clipboard.setContent`, which
/// takes a `gdk.ContentProvider` object.
///
/// To read textual or image data from a clipboard, use
/// `gdk.Clipboard.readTextAsync` or
/// `gdk.Clipboard.readTextureAsync`. For other data, use
/// `gdk.Clipboard.readAsync`, which provides a `GInputStream` object.
pub const Clipboard = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Clipboard;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `GdkContentProvider` or `NULL` if the clipboard is empty or contents are
        /// provided otherwise.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gdk.ContentProvider;
        };

        /// The `GdkDisplay` that the clipboard belongs to.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The possible formats that the clipboard can provide its data in.
        pub const formats = struct {
            pub const name = "formats";

            pub const Type = ?*gdk.ContentFormats;
        };

        /// `TRUE` if the contents of the clipboard are owned by this process.
        pub const local = struct {
            pub const name = "local";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted when the clipboard changes ownership.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Clipboard, p_instance))),
                    gobject.signalLookup("changed", Clipboard.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns the `GdkContentProvider` currently set on `clipboard`.
    ///
    /// If the `clipboard` is empty or its contents are not owned by the
    /// current process, `NULL` will be returned.
    extern fn gdk_clipboard_get_content(p_clipboard: *Clipboard) ?*gdk.ContentProvider;
    pub const getContent = gdk_clipboard_get_content;

    /// Gets the `GdkDisplay` that the clipboard was created for.
    extern fn gdk_clipboard_get_display(p_clipboard: *Clipboard) *gdk.Display;
    pub const getDisplay = gdk_clipboard_get_display;

    /// Gets the formats that the clipboard can provide its current contents in.
    extern fn gdk_clipboard_get_formats(p_clipboard: *Clipboard) *gdk.ContentFormats;
    pub const getFormats = gdk_clipboard_get_formats;

    /// Returns if the clipboard is local.
    ///
    /// A clipboard is considered local if it was last claimed
    /// by the running application.
    ///
    /// Note that `gdk.Clipboard.getContent` may return `NULL`
    /// even on a local clipboard. In this case the clipboard is empty.
    extern fn gdk_clipboard_is_local(p_clipboard: *Clipboard) c_int;
    pub const isLocal = gdk_clipboard_is_local;

    /// Asynchronously requests an input stream to read the `clipboard`'s
    /// contents from.
    ///
    /// The clipboard will choose the most suitable mime type from the given list
    /// to fulfill the request, preferring the ones listed first.
    extern fn gdk_clipboard_read_async(p_clipboard: *Clipboard, p_mime_types: [*][*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const readAsync = gdk_clipboard_read_async;

    /// Finishes an asynchronous clipboard read.
    ///
    /// See `gdk.Clipboard.readAsync`.
    extern fn gdk_clipboard_read_finish(p_clipboard: *Clipboard, p_result: *gio.AsyncResult, p_out_mime_type: ?*[*:0]const u8, p_error: ?*?*glib.Error) ?*gio.InputStream;
    pub const readFinish = gdk_clipboard_read_finish;

    /// Asynchronously request the `clipboard` contents converted to a string.
    ///
    /// This is a simple wrapper around `gdk.Clipboard.readValueAsync`.
    /// Use that function or `gdk.Clipboard.readAsync` directly if you
    /// need more control over the operation.
    extern fn gdk_clipboard_read_text_async(p_clipboard: *Clipboard, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const readTextAsync = gdk_clipboard_read_text_async;

    /// Finishes an asynchronous clipboard read.
    ///
    /// See `gdk.Clipboard.readTextAsync`.
    extern fn gdk_clipboard_read_text_finish(p_clipboard: *Clipboard, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const readTextFinish = gdk_clipboard_read_text_finish;

    /// Asynchronously request the `clipboard` contents converted to a `GdkPixbuf`.
    ///
    /// This is a simple wrapper around `gdk.Clipboard.readValueAsync`.
    /// Use that function or `gdk.Clipboard.readAsync` directly if you
    /// need more control over the operation.
    extern fn gdk_clipboard_read_texture_async(p_clipboard: *Clipboard, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const readTextureAsync = gdk_clipboard_read_texture_async;

    /// Finishes an asynchronous clipboard read.
    ///
    /// See `gdk.Clipboard.readTextureAsync`.
    extern fn gdk_clipboard_read_texture_finish(p_clipboard: *Clipboard, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*gdk.Texture;
    pub const readTextureFinish = gdk_clipboard_read_texture_finish;

    /// Asynchronously request the `clipboard` contents converted to the given
    /// `type`.
    ///
    /// For local clipboard contents that are available in the given `GType`,
    /// the value will be copied directly. Otherwise, GDK will try to use
    /// `contentDeserializeAsync` to convert the clipboard's data.
    extern fn gdk_clipboard_read_value_async(p_clipboard: *Clipboard, p_type: usize, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const readValueAsync = gdk_clipboard_read_value_async;

    /// Finishes an asynchronous clipboard read.
    ///
    /// See `gdk.Clipboard.readValueAsync`.
    extern fn gdk_clipboard_read_value_finish(p_clipboard: *Clipboard, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*const gobject.Value;
    pub const readValueFinish = gdk_clipboard_read_value_finish;

    /// Sets the clipboard to contain the value collected from the given varargs.
    ///
    /// Values should be passed the same way they are passed to other value
    /// collecting APIs, such as `gobject.Object.set` or
    /// `gobject.signalEmit`.
    ///
    /// ```c
    /// gdk_clipboard_set (clipboard, GTK_TYPE_STRING, "Hello World");
    ///
    /// gdk_clipboard_set (clipboard, GDK_TYPE_TEXTURE, some_texture);
    /// ```
    extern fn gdk_clipboard_set(p_clipboard: *Clipboard, p_type: usize, ...) void;
    pub const set = gdk_clipboard_set;

    /// Sets a new content provider on `clipboard`.
    ///
    /// The clipboard will claim the `GdkDisplay`'s resources and advertise
    /// these new contents to other applications.
    ///
    /// In the rare case of a failure, this function will return `FALSE`. The
    /// clipboard will then continue reporting its old contents and ignore
    /// `provider`.
    ///
    /// If the contents are read by either an external application or the
    /// `clipboard`'s read functions, `clipboard` will select the best format to
    /// transfer the contents and then request that format from `provider`.
    extern fn gdk_clipboard_set_content(p_clipboard: *Clipboard, p_provider: ?*gdk.ContentProvider) c_int;
    pub const setContent = gdk_clipboard_set_content;

    /// Puts the given `text` into the clipboard.
    extern fn gdk_clipboard_set_text(p_clipboard: *Clipboard, p_text: [*:0]const u8) void;
    pub const setText = gdk_clipboard_set_text;

    /// Puts the given `texture` into the clipboard.
    extern fn gdk_clipboard_set_texture(p_clipboard: *Clipboard, p_texture: *gdk.Texture) void;
    pub const setTexture = gdk_clipboard_set_texture;

    /// Sets the clipboard to contain the value collected from the given `args`.
    extern fn gdk_clipboard_set_valist(p_clipboard: *Clipboard, p_type: usize, p_args: std.builtin.VaList) void;
    pub const setValist = gdk_clipboard_set_valist;

    /// Sets the `clipboard` to contain the given `value`.
    extern fn gdk_clipboard_set_value(p_clipboard: *Clipboard, p_value: *const gobject.Value) void;
    pub const setValue = gdk_clipboard_set_value;

    /// Asynchronously instructs the `clipboard` to store its contents remotely.
    ///
    /// If the clipboard is not local, this function does nothing but report success.
    ///
    /// The purpose of this call is to preserve clipboard contents beyond the
    /// lifetime of an application, so this function is typically called on
    /// exit. Depending on the platform, the functionality may not be available
    /// unless a "clipboard manager" is running.
    ///
    /// This function is called automatically when a
    /// [GtkApplication](../gtk4/class.Application.html)
    /// is shut down, so you likely don't need to call it.
    extern fn gdk_clipboard_store_async(p_clipboard: *Clipboard, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const storeAsync = gdk_clipboard_store_async;

    /// Finishes an asynchronous clipboard store.
    ///
    /// See `gdk.Clipboard.storeAsync`.
    extern fn gdk_clipboard_store_finish(p_clipboard: *Clipboard, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const storeFinish = gdk_clipboard_store_finish;

    extern fn gdk_clipboard_get_type() usize;
    pub const getGObjectType = gdk_clipboard_get_type;

    extern fn g_object_ref(p_self: *gdk.Clipboard) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Clipboard) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Clipboard, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Deserializes content received via inter-application data transfers.
///
/// The `GdkContentDeserializer` transforms serialized content that is
/// identified by a mime type into an object identified by a GType.
///
/// GTK provides serializers and deserializers for common data types
/// such as text, colors, images or file lists. To register your own
/// deserialization functions, use `contentRegisterDeserializer`.
///
/// Also see `gdk.ContentSerializer`.
pub const ContentDeserializer = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.AsyncResult};
    pub const Class = opaque {
        pub const Instance = ContentDeserializer;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the cancellable for the current operation.
    ///
    /// This is the `GCancellable` that was passed to `gdk.contentDeserializeAsync`.
    extern fn gdk_content_deserializer_get_cancellable(p_deserializer: *ContentDeserializer) ?*gio.Cancellable;
    pub const getCancellable = gdk_content_deserializer_get_cancellable;

    /// Gets the `GType` to create an instance of.
    extern fn gdk_content_deserializer_get_gtype(p_deserializer: *ContentDeserializer) usize;
    pub const getGtype = gdk_content_deserializer_get_gtype;

    /// Gets the input stream for the current operation.
    ///
    /// This is the stream that was passed to `gdk.contentDeserializeAsync`.
    extern fn gdk_content_deserializer_get_input_stream(p_deserializer: *ContentDeserializer) *gio.InputStream;
    pub const getInputStream = gdk_content_deserializer_get_input_stream;

    /// Gets the mime type to deserialize from.
    extern fn gdk_content_deserializer_get_mime_type(p_deserializer: *ContentDeserializer) [*:0]const u8;
    pub const getMimeType = gdk_content_deserializer_get_mime_type;

    /// Gets the I/O priority for the current operation.
    ///
    /// This is the priority that was passed to `gdk.contentDeserializeAsync`.
    extern fn gdk_content_deserializer_get_priority(p_deserializer: *ContentDeserializer) c_int;
    pub const getPriority = gdk_content_deserializer_get_priority;

    /// Gets the data that was associated with the current operation.
    ///
    /// See `gdk.ContentDeserializer.setTaskData`.
    extern fn gdk_content_deserializer_get_task_data(p_deserializer: *ContentDeserializer) ?*anyopaque;
    pub const getTaskData = gdk_content_deserializer_get_task_data;

    /// Gets the user data that was passed when the deserializer was registered.
    extern fn gdk_content_deserializer_get_user_data(p_deserializer: *ContentDeserializer) ?*anyopaque;
    pub const getUserData = gdk_content_deserializer_get_user_data;

    /// Gets the `GValue` to store the deserialized object in.
    extern fn gdk_content_deserializer_get_value(p_deserializer: *ContentDeserializer) *gobject.Value;
    pub const getValue = gdk_content_deserializer_get_value;

    /// Indicate that the deserialization has ended with an error.
    ///
    /// This function consumes `error`.
    extern fn gdk_content_deserializer_return_error(p_deserializer: *ContentDeserializer, p_error: *glib.Error) void;
    pub const returnError = gdk_content_deserializer_return_error;

    /// Indicate that the deserialization has been successfully completed.
    extern fn gdk_content_deserializer_return_success(p_deserializer: *ContentDeserializer) void;
    pub const returnSuccess = gdk_content_deserializer_return_success;

    /// Associate data with the current deserialization operation.
    extern fn gdk_content_deserializer_set_task_data(p_deserializer: *ContentDeserializer, p_data: ?*anyopaque, p_notify: glib.DestroyNotify) void;
    pub const setTaskData = gdk_content_deserializer_set_task_data;

    extern fn gdk_content_deserializer_get_type() usize;
    pub const getGObjectType = gdk_content_deserializer_get_type;

    extern fn g_object_ref(p_self: *gdk.ContentDeserializer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.ContentDeserializer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ContentDeserializer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Provides content for the clipboard or for drag-and-drop operations
/// in a number of formats.
///
/// To create a `GdkContentProvider`, use `gdk.ContentProvider.newForValue`
/// or `gdk.ContentProvider.newForBytes`.
///
/// GDK knows how to handle common text and image formats out-of-the-box. See
/// `gdk.ContentSerializer` and `gdk.ContentDeserializer` if you want
/// to add support for application-specific data formats.
pub const ContentProvider = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.ContentProviderClass;
    f_parent: gobject.Object,

    pub const virtual_methods = struct {
        pub const attach_clipboard = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_clipboard: *gdk.Clipboard) void {
                return gobject.ext.as(ContentProvider.Class, p_class).f_attach_clipboard.?(gobject.ext.as(ContentProvider, p_provider), p_clipboard);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_clipboard: *gdk.Clipboard) callconv(.c) void) void {
                gobject.ext.as(ContentProvider.Class, p_class).f_attach_clipboard = @ptrCast(p_implementation);
            }
        };

        /// Emits the ::content-changed signal.
        pub const content_changed = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ContentProvider.Class, p_class).f_content_changed.?(gobject.ext.as(ContentProvider, p_provider));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ContentProvider.Class, p_class).f_content_changed = @ptrCast(p_implementation);
            }
        };

        pub const detach_clipboard = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_clipboard: *gdk.Clipboard) void {
                return gobject.ext.as(ContentProvider.Class, p_class).f_detach_clipboard.?(gobject.ext.as(ContentProvider, p_provider), p_clipboard);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_clipboard: *gdk.Clipboard) callconv(.c) void) void {
                gobject.ext.as(ContentProvider.Class, p_class).f_detach_clipboard = @ptrCast(p_implementation);
            }
        };

        /// Gets the contents of `provider` stored in `value`.
        ///
        /// The `value` will have been initialized to the `GType` the value should be
        /// provided in. This given `GType` does not need to be listed in the formats
        /// returned by `gdk.ContentProvider.refFormats`. However, if the
        /// given `GType` is not supported, this operation can fail and
        /// `G_IO_ERROR_NOT_SUPPORTED` will be reported.
        pub const get_value = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(ContentProvider.Class, p_class).f_get_value.?(gobject.ext.as(ContentProvider, p_provider), p_value, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(ContentProvider.Class, p_class).f_get_value = @ptrCast(p_implementation);
            }
        };

        /// Gets the formats that the provider can provide its current contents in.
        pub const ref_formats = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gdk.ContentFormats {
                return gobject.ext.as(ContentProvider.Class, p_class).f_ref_formats.?(gobject.ext.as(ContentProvider, p_provider));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gdk.ContentFormats) void {
                gobject.ext.as(ContentProvider.Class, p_class).f_ref_formats = @ptrCast(p_implementation);
            }
        };

        /// Gets the formats that the provider suggests other applications to store
        /// the data in.
        ///
        /// An example of such an application would be a clipboard manager.
        ///
        /// This can be assumed to be a subset of `gdk.ContentProvider.refFormats`.
        pub const ref_storable_formats = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gdk.ContentFormats {
                return gobject.ext.as(ContentProvider.Class, p_class).f_ref_storable_formats.?(gobject.ext.as(ContentProvider, p_provider));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gdk.ContentFormats) void {
                gobject.ext.as(ContentProvider.Class, p_class).f_ref_storable_formats = @ptrCast(p_implementation);
            }
        };

        /// Asynchronously writes the contents of `provider` to `stream` in the given
        /// `mime_type`.
        ///
        /// The given mime type does not need to be listed in the formats returned by
        /// `gdk.ContentProvider.refFormats`. However, if the given `GType` is
        /// not supported, `G_IO_ERROR_NOT_SUPPORTED` will be reported.
        ///
        /// The given `stream` will not be closed.
        pub const write_mime_type_async = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8, p_stream: *gio.OutputStream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void {
                return gobject.ext.as(ContentProvider.Class, p_class).f_write_mime_type_async.?(gobject.ext.as(ContentProvider, p_provider), p_mime_type, p_stream, p_io_priority, p_cancellable, p_callback, p_user_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8, p_stream: *gio.OutputStream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(ContentProvider.Class, p_class).f_write_mime_type_async = @ptrCast(p_implementation);
            }
        };

        /// Finishes an asynchronous write operation.
        ///
        /// See `gdk.ContentProvider.writeMimeTypeAsync`.
        pub const write_mime_type_finish = struct {
            pub fn call(p_class: anytype, p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int {
                return gobject.ext.as(ContentProvider.Class, p_class).f_write_mime_type_finish.?(gobject.ext.as(ContentProvider, p_provider), p_result, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_provider: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int) void {
                gobject.ext.as(ContentProvider.Class, p_class).f_write_mime_type_finish = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The possible formats that the provider can provide its data in.
        pub const formats = struct {
            pub const name = "formats";

            pub const Type = ?*gdk.ContentFormats;
        };

        /// The subset of formats that clipboard managers should store this provider's data in.
        pub const storable_formats = struct {
            pub const name = "storable-formats";

            pub const Type = ?*gdk.ContentFormats;
        };
    };

    pub const signals = struct {
        /// Emitted whenever the content provided by this provider has changed.
        pub const content_changed = struct {
            pub const name = "content-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ContentProvider, p_instance))),
                    gobject.signalLookup("content-changed", ContentProvider.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a content provider that provides the given `bytes` as data for
    /// the given `mime_type`.
    extern fn gdk_content_provider_new_for_bytes(p_mime_type: [*:0]const u8, p_bytes: *glib.Bytes) *gdk.ContentProvider;
    pub const newForBytes = gdk_content_provider_new_for_bytes;

    /// Create a content provider that provides the given `value`.
    extern fn gdk_content_provider_new_for_value(p_value: *const gobject.Value) *gdk.ContentProvider;
    pub const newForValue = gdk_content_provider_new_for_value;

    /// Create a content provider that provides the value of the given
    /// `type`.
    ///
    /// The value is provided using `G_VALUE_COLLECT`, so the same rules
    /// apply as when calling `gobject.Object.new` or `gobject.Object.set`.
    extern fn gdk_content_provider_new_typed(p_type: usize, ...) *gdk.ContentProvider;
    pub const newTyped = gdk_content_provider_new_typed;

    /// Creates a content provider that represents all the given `providers`.
    ///
    /// Whenever data needs to be written, the union provider will try the given
    /// `providers` in the given order and the first one supporting a format will
    /// be chosen to provide it.
    ///
    /// This allows an easy way to support providing data in different formats.
    /// For example, an image may be provided by its file and by the image
    /// contents with a call such as
    /// ```c
    /// gdk_content_provider_new_union ((GdkContentProvider *[2]) {
    ///                                   gdk_content_provider_new_typed (G_TYPE_FILE, file),
    ///                                   gdk_content_provider_new_typed (GDK_TYPE_TEXTURE, texture)
    ///                                 }, 2);
    /// ```
    extern fn gdk_content_provider_new_union(p_providers: ?[*]*gdk.ContentProvider, p_n_providers: usize) *gdk.ContentProvider;
    pub const newUnion = gdk_content_provider_new_union;

    /// Emits the ::content-changed signal.
    extern fn gdk_content_provider_content_changed(p_provider: *ContentProvider) void;
    pub const contentChanged = gdk_content_provider_content_changed;

    /// Gets the contents of `provider` stored in `value`.
    ///
    /// The `value` will have been initialized to the `GType` the value should be
    /// provided in. This given `GType` does not need to be listed in the formats
    /// returned by `gdk.ContentProvider.refFormats`. However, if the
    /// given `GType` is not supported, this operation can fail and
    /// `G_IO_ERROR_NOT_SUPPORTED` will be reported.
    extern fn gdk_content_provider_get_value(p_provider: *ContentProvider, p_value: *gobject.Value, p_error: ?*?*glib.Error) c_int;
    pub const getValue = gdk_content_provider_get_value;

    /// Gets the formats that the provider can provide its current contents in.
    extern fn gdk_content_provider_ref_formats(p_provider: *ContentProvider) *gdk.ContentFormats;
    pub const refFormats = gdk_content_provider_ref_formats;

    /// Gets the formats that the provider suggests other applications to store
    /// the data in.
    ///
    /// An example of such an application would be a clipboard manager.
    ///
    /// This can be assumed to be a subset of `gdk.ContentProvider.refFormats`.
    extern fn gdk_content_provider_ref_storable_formats(p_provider: *ContentProvider) *gdk.ContentFormats;
    pub const refStorableFormats = gdk_content_provider_ref_storable_formats;

    /// Asynchronously writes the contents of `provider` to `stream` in the given
    /// `mime_type`.
    ///
    /// The given mime type does not need to be listed in the formats returned by
    /// `gdk.ContentProvider.refFormats`. However, if the given `GType` is
    /// not supported, `G_IO_ERROR_NOT_SUPPORTED` will be reported.
    ///
    /// The given `stream` will not be closed.
    extern fn gdk_content_provider_write_mime_type_async(p_provider: *ContentProvider, p_mime_type: [*:0]const u8, p_stream: *gio.OutputStream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const writeMimeTypeAsync = gdk_content_provider_write_mime_type_async;

    /// Finishes an asynchronous write operation.
    ///
    /// See `gdk.ContentProvider.writeMimeTypeAsync`.
    extern fn gdk_content_provider_write_mime_type_finish(p_provider: *ContentProvider, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const writeMimeTypeFinish = gdk_content_provider_write_mime_type_finish;

    extern fn gdk_content_provider_get_type() usize;
    pub const getGObjectType = gdk_content_provider_get_type;

    extern fn g_object_ref(p_self: *gdk.ContentProvider) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.ContentProvider) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ContentProvider, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Serializes content for inter-application data transfers.
///
/// The `GdkContentSerializer` transforms an object that is identified
/// by a GType into a serialized form (i.e. a byte stream) that is
/// identified by a mime type.
///
/// GTK provides serializers and deserializers for common data types
/// such as text, colors, images or file lists. To register your own
/// serialization functions, use `gdk.contentRegisterSerializer`.
///
/// Also see `gdk.ContentDeserializer`.
pub const ContentSerializer = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.AsyncResult};
    pub const Class = opaque {
        pub const Instance = ContentSerializer;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the cancellable for the current operation.
    ///
    /// This is the `GCancellable` that was passed to `contentSerializeAsync`.
    extern fn gdk_content_serializer_get_cancellable(p_serializer: *ContentSerializer) ?*gio.Cancellable;
    pub const getCancellable = gdk_content_serializer_get_cancellable;

    /// Gets the `GType` to of the object to serialize.
    extern fn gdk_content_serializer_get_gtype(p_serializer: *ContentSerializer) usize;
    pub const getGtype = gdk_content_serializer_get_gtype;

    /// Gets the mime type to serialize to.
    extern fn gdk_content_serializer_get_mime_type(p_serializer: *ContentSerializer) [*:0]const u8;
    pub const getMimeType = gdk_content_serializer_get_mime_type;

    /// Gets the output stream for the current operation.
    ///
    /// This is the stream that was passed to `contentSerializeAsync`.
    extern fn gdk_content_serializer_get_output_stream(p_serializer: *ContentSerializer) *gio.OutputStream;
    pub const getOutputStream = gdk_content_serializer_get_output_stream;

    /// Gets the I/O priority for the current operation.
    ///
    /// This is the priority that was passed to `contentSerializeAsync`.
    extern fn gdk_content_serializer_get_priority(p_serializer: *ContentSerializer) c_int;
    pub const getPriority = gdk_content_serializer_get_priority;

    /// Gets the data that was associated with the current operation.
    ///
    /// See `gdk.ContentSerializer.setTaskData`.
    extern fn gdk_content_serializer_get_task_data(p_serializer: *ContentSerializer) ?*anyopaque;
    pub const getTaskData = gdk_content_serializer_get_task_data;

    /// Gets the user data that was passed when the serializer was registered.
    extern fn gdk_content_serializer_get_user_data(p_serializer: *ContentSerializer) ?*anyopaque;
    pub const getUserData = gdk_content_serializer_get_user_data;

    /// Gets the `GValue` to read the object to serialize from.
    extern fn gdk_content_serializer_get_value(p_serializer: *ContentSerializer) *const gobject.Value;
    pub const getValue = gdk_content_serializer_get_value;

    /// Indicate that the serialization has ended with an error.
    ///
    /// This function consumes `error`.
    extern fn gdk_content_serializer_return_error(p_serializer: *ContentSerializer, p_error: *glib.Error) void;
    pub const returnError = gdk_content_serializer_return_error;

    /// Indicate that the serialization has been successfully completed.
    extern fn gdk_content_serializer_return_success(p_serializer: *ContentSerializer) void;
    pub const returnSuccess = gdk_content_serializer_return_success;

    /// Associate data with the current serialization operation.
    extern fn gdk_content_serializer_set_task_data(p_serializer: *ContentSerializer, p_data: ?*anyopaque, p_notify: glib.DestroyNotify) void;
    pub const setTaskData = gdk_content_serializer_set_task_data;

    extern fn gdk_content_serializer_get_type() usize;
    pub const getGObjectType = gdk_content_serializer_get_type;

    extern fn g_object_ref(p_self: *gdk.ContentSerializer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.ContentSerializer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ContentSerializer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event caused by a pointing device moving between surfaces.
pub const CrossingEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = CrossingEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts the notify detail from a crossing event.
    extern fn gdk_crossing_event_get_detail(p_event: *CrossingEvent) gdk.NotifyType;
    pub const getDetail = gdk_crossing_event_get_detail;

    /// Checks if the `event` surface is the focus surface.
    extern fn gdk_crossing_event_get_focus(p_event: *CrossingEvent) c_int;
    pub const getFocus = gdk_crossing_event_get_focus;

    /// Extracts the crossing mode from a crossing event.
    extern fn gdk_crossing_event_get_mode(p_event: *CrossingEvent) gdk.CrossingMode;
    pub const getMode = gdk_crossing_event_get_mode;

    extern fn gdk_crossing_event_get_type() usize;
    pub const getGObjectType = gdk_crossing_event_get_type;

    pub fn as(p_instance: *CrossingEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used to create and destroy cursors.
///
/// Cursors are immutable objects, so once you created them, there is no way
/// to modify them later. You should create a new cursor when you want to change
/// something about it.
///
/// Cursors by themselves are not very interesting: they must be bound to a
/// window for users to see them. This is done with `gdk.Surface.setCursor`
/// or `gdk.Surface.setDeviceCursor`. Applications will typically
/// use higher-level GTK functions such as [`gtk_widget_set_cursor`](../gtk4/method.Widget.set_cursor.html)
/// instead.
///
/// Cursors are not bound to a given `gdk.Display`, so they can be shared.
/// However, the appearance of cursors may vary when used on different
/// platforms.
///
/// ## Named and texture cursors
///
/// There are multiple ways to create cursors. The platform's own cursors
/// can be created with `gdk.Cursor.newFromName`. That function lists
/// the commonly available names that are shared with the CSS specification.
/// Other names may be available, depending on the platform in use. On some
/// platforms, what images are used for named cursors may be influenced by
/// the cursor theme.
///
/// Another option to create a cursor is to use `gdk.Cursor.newFromTexture`
/// and provide an image to use for the cursor.
///
/// To ease work with unsupported cursors, a fallback cursor can be provided.
/// If a `gdk.Surface` cannot use a cursor because of the reasons mentioned
/// above, it will try the fallback cursor. Fallback cursors can themselves have
/// fallback cursors again, so it is possible to provide a chain of progressively
/// easier to support cursors. If none of the provided cursors can be supported,
/// the default cursor will be the ultimate fallback.
pub const Cursor = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Cursor;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Cursor to fall back to if this cursor cannot be displayed.
        pub const fallback = struct {
            pub const name = "fallback";

            pub const Type = ?*gdk.Cursor;
        };

        /// X position of the cursor hotspot in the cursor image.
        pub const hotspot_x = struct {
            pub const name = "hotspot-x";

            pub const Type = c_int;
        };

        /// Y position of the cursor hotspot in the cursor image.
        pub const hotspot_y = struct {
            pub const name = "hotspot-y";

            pub const Type = c_int;
        };

        /// Name of this this cursor.
        ///
        /// The name will be `NULL` if the cursor was created from a texture.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// The texture displayed by this cursor.
        ///
        /// The texture will be `NULL` if the cursor was created from a name.
        pub const texture = struct {
            pub const name = "texture";

            pub const Type = ?*gdk.Texture;
        };
    };

    pub const signals = struct {};

    /// Creates a new callback-based cursor object.
    ///
    /// Cursors of this kind produce textures for the cursor
    /// image on demand, when the `callback` is called.
    extern fn gdk_cursor_new_from_callback(p_callback: gdk.CursorGetTextureCallback, p_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify, p_fallback: ?*gdk.Cursor) ?*gdk.Cursor;
    pub const newFromCallback = gdk_cursor_new_from_callback;

    /// Creates a new cursor by looking up `name` in the current cursor
    /// theme.
    ///
    /// A recommended set of cursor names that will work across different
    /// platforms can be found in the CSS specification:
    ///
    /// | | | |
    /// | --- | --- | --- |
    /// |                               | "none"          | No cursor |
    /// | ![](default_cursor.png)       | "default"       | The default cursor |
    /// | ![](help_cursor.png)          | "help"          | Help is available |
    /// | ![](pointer_cursor.png)       | "pointer"       | Indicates a link or interactive element |
    /// | ![](context_menu_cursor.png)  |"context-menu"   | A context menu is available |
    /// | ![](progress_cursor.png)      | "progress"      | Progress indicator |
    /// | ![](wait_cursor.png)          | "wait"          | Busy cursor |
    /// | ![](cell_cursor.png)          | "cell"          | Cell(s) may be selected |
    /// | ![](crosshair_cursor.png)     | "crosshair"     | Simple crosshair |
    /// | ![](text_cursor.png)          | "text"          | Text may be selected |
    /// | ![](vertical_text_cursor.png) | "vertical-text" | Vertical text may be selected |
    /// | ![](alias_cursor.png)         | "alias"         | DND: Something will be linked |
    /// | ![](copy_cursor.png)          | "copy"          | DND: Something will be copied |
    /// | ![](move_cursor.png)          | "move"          | DND: Something will be moved |
    /// | ![](dnd_ask_cursor.png)       | "dnd-ask"       | DND: User can choose action to be carried out |
    /// | ![](no_drop_cursor.png)       | "no-drop"       | DND: Can't drop here |
    /// | ![](not_allowed_cursor.png)   | "not-allowed"   | DND: Action will not be carried out |
    /// | ![](grab_cursor.png)          | "grab"          | DND: Something can be grabbed |
    /// | ![](grabbing_cursor.png)      | "grabbing"      | DND: Something is being grabbed |
    /// | ![](n_resize_cursor.png)      | "n-resize"      | Resizing: Move north border |
    /// | ![](e_resize_cursor.png)      | "e-resize"      | Resizing: Move east border |
    /// | ![](s_resize_cursor.png)      | "s-resize"      | Resizing: Move south border |
    /// | ![](w_resize_cursor.png)      | "w-resize"      | Resizing: Move west border |
    /// | ![](ne_resize_cursor.png)     | "ne-resize"     | Resizing: Move north-east corner |
    /// | ![](nw_resize_cursor.png)     | "nw-resize"     | Resizing: Move north-west corner |
    /// | ![](sw_resize_cursor.png)     | "sw-resize"     | Resizing: Move south-west corner |
    /// | ![](se_resize_cursor.png)     | "se-resize"     | Resizing: Move south-east corner |
    /// | ![](col_resize_cursor.png)    | "col-resize"    | Resizing: Move an item or border horizontally |
    /// | ![](row_resize_cursor.png)    | "row-resize"    | Resizing: Move an item or border vertically |
    /// | ![](ew_resize_cursor.png)     | "ew-resize"     | Moving: Something can be moved horizontally |
    /// | ![](ns_resize_cursor.png)     | "ns-resize"     | Moving: Something can be moved vertically |
    /// | ![](nesw_resize_cursor.png)   | "nesw-resize"   | Moving: Something can be moved diagonally, north-east to south-west |
    /// | ![](nwse_resize_cursor.png)   | "nwse-resize"   | Moving: something can be moved diagonally, north-west to south-east |
    /// | ![](all_resize_cursor.png)    | "all-resize"    | Moving: Something can be moved in any direction |
    /// | ![](all_scroll_cursor.png)    | "all-scroll"    | Can scroll in any direction |
    /// | ![](zoom_in_cursor.png)       | "zoom-in"       | Zoom in |
    /// | ![](zoom_out_cursor.png)      | "zoom-out"      | Zoom out |
    extern fn gdk_cursor_new_from_name(p_name: [*:0]const u8, p_fallback: ?*gdk.Cursor) ?*gdk.Cursor;
    pub const newFromName = gdk_cursor_new_from_name;

    /// Creates a new cursor from a `GdkTexture`.
    extern fn gdk_cursor_new_from_texture(p_texture: *gdk.Texture, p_hotspot_x: c_int, p_hotspot_y: c_int, p_fallback: ?*gdk.Cursor) *gdk.Cursor;
    pub const newFromTexture = gdk_cursor_new_from_texture;

    /// Returns the fallback for this `cursor`.
    ///
    /// The fallback will be used if this cursor is not available on a given
    /// `GdkDisplay`. For named cursors, this can happen when using nonstandard
    /// names or when using an incomplete cursor theme. For textured cursors,
    /// this can happen when the texture is too large or when the `GdkDisplay`
    /// it is used on does not support textured cursors.
    extern fn gdk_cursor_get_fallback(p_cursor: *Cursor) ?*gdk.Cursor;
    pub const getFallback = gdk_cursor_get_fallback;

    /// Returns the horizontal offset of the hotspot.
    ///
    /// The hotspot indicates the pixel that will be directly above the cursor.
    ///
    /// Note that named cursors may have a nonzero hotspot, but this function
    /// will only return the hotspot position for cursors created with
    /// `gdk.Cursor.newFromTexture`.
    extern fn gdk_cursor_get_hotspot_x(p_cursor: *Cursor) c_int;
    pub const getHotspotX = gdk_cursor_get_hotspot_x;

    /// Returns the vertical offset of the hotspot.
    ///
    /// The hotspot indicates the pixel that will be directly above the cursor.
    ///
    /// Note that named cursors may have a nonzero hotspot, but this function
    /// will only return the hotspot position for cursors created with
    /// `gdk.Cursor.newFromTexture`.
    extern fn gdk_cursor_get_hotspot_y(p_cursor: *Cursor) c_int;
    pub const getHotspotY = gdk_cursor_get_hotspot_y;

    /// Returns the name of the cursor.
    ///
    /// If the cursor is not a named cursor, `NULL` will be returned.
    extern fn gdk_cursor_get_name(p_cursor: *Cursor) ?[*:0]const u8;
    pub const getName = gdk_cursor_get_name;

    /// Returns the texture for the cursor.
    ///
    /// If the cursor is a named cursor, `NULL` will be returned.
    extern fn gdk_cursor_get_texture(p_cursor: *Cursor) ?*gdk.Texture;
    pub const getTexture = gdk_cursor_get_texture;

    extern fn gdk_cursor_get_type() usize;
    pub const getGObjectType = gdk_cursor_get_type;

    extern fn g_object_ref(p_self: *gdk.Cursor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Cursor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Cursor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to drag and drop operations.
pub const DNDEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DNDEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the `GdkDrop` object from a DND event.
    extern fn gdk_dnd_event_get_drop(p_event: *DNDEvent) ?*gdk.Drop;
    pub const getDrop = gdk_dnd_event_get_drop;

    extern fn gdk_dnd_event_get_type() usize;
    pub const getGObjectType = gdk_dnd_event_get_type;

    pub fn as(p_instance: *DNDEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to closing a top-level surface.
pub const DeleteEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DeleteEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_delete_event_get_type() usize;
    pub const getGObjectType = gdk_delete_event_get_type;

    pub fn as(p_instance: *DeleteEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents an input device, such as a keyboard, mouse or touchpad.
///
/// See the `gdk.Seat` documentation for more information
/// about the various kinds of devices, and their relationships.
pub const Device = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Device;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The index of the keyboard active layout of a `GdkDevice`.
        ///
        /// Will be -1 if there is no valid active layout.
        ///
        /// This is only relevant for keyboard devices.
        pub const active_layout_index = struct {
            pub const name = "active-layout-index";

            pub const Type = c_int;
        };

        /// Whether Caps Lock is on.
        ///
        /// This is only relevant for keyboard devices.
        pub const caps_lock_state = struct {
            pub const name = "caps-lock-state";

            pub const Type = c_int;
        };

        /// The direction of the current layout.
        ///
        /// This is only relevant for keyboard devices.
        pub const direction = struct {
            pub const name = "direction";

            pub const Type = pango.Direction;
        };

        /// The `GdkDisplay` the `GdkDevice` pertains to.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// Whether the device has both right-to-left and left-to-right layouts.
        ///
        /// This is only relevant for keyboard devices.
        pub const has_bidi_layouts = struct {
            pub const name = "has-bidi-layouts";

            pub const Type = c_int;
        };

        /// Whether the device is represented by a cursor on the screen.
        pub const has_cursor = struct {
            pub const name = "has-cursor";

            pub const Type = c_int;
        };

        /// The names of the keyboard layouts of a `GdkDevice`.
        ///
        /// This is only relevant for keyboard devices.
        pub const layout_names = struct {
            pub const name = "layout-names";

            pub const Type = ?[*][*:0]u8;
        };

        /// The current modifier state of the device.
        ///
        /// This is only relevant for keyboard devices.
        pub const modifier_state = struct {
            pub const name = "modifier-state";

            pub const Type = gdk.ModifierType;
        };

        /// Number of axes in the device.
        pub const n_axes = struct {
            pub const name = "n-axes";

            pub const Type = c_uint;
        };

        /// The device name.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// Whether Num Lock is on.
        ///
        /// This is only relevant for keyboard devices.
        pub const num_lock_state = struct {
            pub const name = "num-lock-state";

            pub const Type = c_int;
        };

        /// The maximal number of concurrent touches on a touch device.
        ///
        /// Will be 0 if the device is not a touch device or if the number
        /// of touches is unknown.
        pub const num_touches = struct {
            pub const name = "num-touches";

            pub const Type = c_uint;
        };

        /// Product ID of this device.
        ///
        /// See `gdk.Device.getProductId`.
        pub const product_id = struct {
            pub const name = "product-id";

            pub const Type = ?[*:0]u8;
        };

        /// Whether Scroll Lock is on.
        ///
        /// This is only relevant for keyboard devices.
        pub const scroll_lock_state = struct {
            pub const name = "scroll-lock-state";

            pub const Type = c_int;
        };

        /// `GdkSeat` of this device.
        pub const seat = struct {
            pub const name = "seat";

            pub const Type = ?*gdk.Seat;
        };

        /// Source type for the device.
        pub const source = struct {
            pub const name = "source";

            pub const Type = gdk.InputSource;
        };

        /// The `GdkDeviceTool` that is currently used with this device.
        pub const tool = struct {
            pub const name = "tool";

            pub const Type = ?*gdk.DeviceTool;
        };

        /// Vendor ID of this device.
        ///
        /// See `gdk.Device.getVendorId`.
        pub const vendor_id = struct {
            pub const name = "vendor-id";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// Emitted either when the number of either axes or keys changes.
        ///
        /// On X11 this will normally happen when the physical device
        /// routing events through the logical device changes (for
        /// example, user switches from the USB mouse to a tablet); in
        /// that case the logical device will change to reflect the axes
        /// and keys on the new physical device.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Device, p_instance))),
                    gobject.signalLookup("changed", Device.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted on pen/eraser devices whenever tools enter or leave proximity.
        pub const tool_changed = struct {
            pub const name = "tool-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tool: *gdk.DeviceTool, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Device, p_instance))),
                    gobject.signalLookup("tool-changed", Device.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Retrieves the index of the active layout of the keyboard.
    ///
    /// If there is no valid active layout for the `GdkDevice`, this function will
    /// return -1;
    ///
    /// This is only relevant for keyboard devices.
    extern fn gdk_device_get_active_layout_index(p_device: *Device) c_int;
    pub const getActiveLayoutIndex = gdk_device_get_active_layout_index;

    /// Retrieves whether the Caps Lock modifier of the keyboard is locked.
    ///
    /// This is only relevant for keyboard devices.
    extern fn gdk_device_get_caps_lock_state(p_device: *Device) c_int;
    pub const getCapsLockState = gdk_device_get_caps_lock_state;

    /// Retrieves the current tool for `device`.
    extern fn gdk_device_get_device_tool(p_device: *Device) ?*gdk.DeviceTool;
    pub const getDeviceTool = gdk_device_get_device_tool;

    /// Returns the direction of effective layout of the keyboard.
    ///
    /// This is only relevant for keyboard devices.
    ///
    /// The direction of a layout is the direction of the majority
    /// of its symbols. See `pango.unicharDirection`.
    extern fn gdk_device_get_direction(p_device: *Device) pango.Direction;
    pub const getDirection = gdk_device_get_direction;

    /// Returns the `GdkDisplay` to which `device` pertains.
    extern fn gdk_device_get_display(p_device: *Device) *gdk.Display;
    pub const getDisplay = gdk_device_get_display;

    /// Determines whether the pointer follows device motion.
    ///
    /// This is not meaningful for keyboard devices, which
    /// don't have a pointer.
    extern fn gdk_device_get_has_cursor(p_device: *Device) c_int;
    pub const getHasCursor = gdk_device_get_has_cursor;

    /// Retrieves the names of the layouts of the keyboard.
    ///
    /// This is only relevant for keyboard devices.
    extern fn gdk_device_get_layout_names(p_device: *Device) ?[*][*:0]u8;
    pub const getLayoutNames = gdk_device_get_layout_names;

    /// Retrieves the current modifier state of the keyboard.
    ///
    /// This is only relevant for keyboard devices.
    extern fn gdk_device_get_modifier_state(p_device: *Device) gdk.ModifierType;
    pub const getModifierState = gdk_device_get_modifier_state;

    /// The name of the device, suitable for showing in a user interface.
    extern fn gdk_device_get_name(p_device: *Device) [*:0]const u8;
    pub const getName = gdk_device_get_name;

    /// Retrieves whether the Num Lock modifier of the keyboard is locked.
    ///
    /// This is only relevant for keyboard devices.
    extern fn gdk_device_get_num_lock_state(p_device: *Device) c_int;
    pub const getNumLockState = gdk_device_get_num_lock_state;

    /// Retrieves the number of touch points associated to `device`.
    extern fn gdk_device_get_num_touches(p_device: *Device) c_uint;
    pub const getNumTouches = gdk_device_get_num_touches;

    /// Returns the product ID of this device.
    ///
    /// This ID is retrieved from the device, and does not change.
    /// See `gdk.Device.getVendorId` for more information.
    extern fn gdk_device_get_product_id(p_device: *Device) ?[*:0]const u8;
    pub const getProductId = gdk_device_get_product_id;

    /// Retrieves whether the Scroll Lock modifier of the keyboard is locked.
    ///
    /// This is only relevant for keyboard devices.
    extern fn gdk_device_get_scroll_lock_state(p_device: *Device) c_int;
    pub const getScrollLockState = gdk_device_get_scroll_lock_state;

    /// Returns the `GdkSeat` the device belongs to.
    extern fn gdk_device_get_seat(p_device: *Device) *gdk.Seat;
    pub const getSeat = gdk_device_get_seat;

    /// Determines the type of the device.
    extern fn gdk_device_get_source(p_device: *Device) gdk.InputSource;
    pub const getSource = gdk_device_get_source;

    /// Obtains the surface underneath `device`, returning the location of the
    /// device in `win_x` and `win_y`.
    ///
    /// Returns `NULL` if the surface tree under `device` is not known to GDK
    /// (for example, belongs to another application).
    extern fn gdk_device_get_surface_at_position(p_device: *Device, p_win_x: ?*f64, p_win_y: ?*f64) ?*gdk.Surface;
    pub const getSurfaceAtPosition = gdk_device_get_surface_at_position;

    /// Returns the timestamp of the last activity for this device.
    ///
    /// In practice, this means the timestamp of the last event that was
    /// received from the OS for this device. (GTK may occasionally produce
    /// events for a device that are not received from the OS, and will not
    /// update the timestamp).
    extern fn gdk_device_get_timestamp(p_device: *Device) u32;
    pub const getTimestamp = gdk_device_get_timestamp;

    /// Returns the vendor ID of this device.
    ///
    /// This ID is retrieved from the device, and does not change.
    ///
    /// This function, together with `gdk.Device.getProductId`,
    /// can be used to eg. compose `GSettings` paths to store settings
    /// for this device.
    ///
    /// ```c
    ///  static GSettings *
    ///  get_device_settings (GdkDevice *device)
    ///  {
    ///    const char *vendor, *product;
    ///    GSettings *settings;
    ///    GdkDevice *device;
    ///    char *path;
    ///
    ///    vendor = gdk_device_get_vendor_id (device);
    ///    product = gdk_device_get_product_id (device);
    ///
    ///    path = g_strdup_printf ("/org/example/app/devices/`s`:`s`/", vendor, product);
    ///    settings = g_settings_new_with_path (DEVICE_SCHEMA, path);
    ///    g_free (path);
    ///
    ///    return settings;
    ///  }
    /// ```
    extern fn gdk_device_get_vendor_id(p_device: *Device) ?[*:0]const u8;
    pub const getVendorId = gdk_device_get_vendor_id;

    /// Determines if layouts for both right-to-left and
    /// left-to-right languages are in use on the keyboard.
    ///
    /// This is only relevant for keyboard devices.
    extern fn gdk_device_has_bidi_layouts(p_device: *Device) c_int;
    pub const hasBidiLayouts = gdk_device_has_bidi_layouts;

    extern fn gdk_device_get_type() usize;
    pub const getGObjectType = gdk_device_get_type;

    extern fn g_object_ref(p_self: *gdk.Device) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Device) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Device, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A physical tool associated to a `GdkDevice`.
pub const DeviceTool = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DeviceTool;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The axes of the tool.
        pub const axes = struct {
            pub const name = "axes";

            pub const Type = gdk.AxisFlags;
        };

        /// The hardware ID of the tool.
        pub const hardware_id = struct {
            pub const name = "hardware-id";

            pub const Type = u64;
        };

        /// The serial number of the tool.
        pub const serial = struct {
            pub const name = "serial";

            pub const Type = u64;
        };

        /// The type of the tool.
        pub const tool_type = struct {
            pub const name = "tool-type";

            pub const Type = gdk.DeviceToolType;
        };
    };

    pub const signals = struct {};

    /// Gets the axes of the tool.
    extern fn gdk_device_tool_get_axes(p_tool: *DeviceTool) gdk.AxisFlags;
    pub const getAxes = gdk_device_tool_get_axes;

    /// Gets the hardware ID of this tool, or 0 if it's not known.
    ///
    /// When non-zero, the identifier is unique for the given tool model,
    /// meaning that two identical tools will share the same `hardware_id`,
    /// but will have different serial numbers (see
    /// `gdk.DeviceTool.getSerial`).
    ///
    /// This is a more concrete (and device specific) method to identify
    /// a `GdkDeviceTool` than `gdk.DeviceTool.getToolType`,
    /// as a tablet may support multiple devices with the same
    /// `GdkDeviceToolType`, but different hardware identifiers.
    extern fn gdk_device_tool_get_hardware_id(p_tool: *DeviceTool) u64;
    pub const getHardwareId = gdk_device_tool_get_hardware_id;

    /// Gets the serial number of this tool.
    ///
    /// This value can be used to identify a physical tool
    /// (eg. a tablet pen) across program executions.
    extern fn gdk_device_tool_get_serial(p_tool: *DeviceTool) u64;
    pub const getSerial = gdk_device_tool_get_serial;

    /// Gets the `GdkDeviceToolType` of the tool.
    extern fn gdk_device_tool_get_tool_type(p_tool: *DeviceTool) gdk.DeviceToolType;
    pub const getToolType = gdk_device_tool_get_tool_type;

    extern fn gdk_device_tool_get_type() usize;
    pub const getGObjectType = gdk_device_tool_get_type;

    extern fn g_object_ref(p_self: *gdk.DeviceTool) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DeviceTool) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DeviceTool, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A representation of a workstation.
///
/// Their purpose are two-fold:
///
/// - To manage and provide information about input devices (pointers, keyboards, etc)
/// - To manage and provide information about output devices (monitors, projectors, etc)
///
/// Most of the input device handling has been factored out into separate
/// `gdk.Seat` objects. Every display has a one or more seats, which
/// can be accessed with `gdk.Display.getDefaultSeat` and
/// `gdk.Display.listSeats`.
///
/// Output devices are represented by `gdk.Monitor` objects, which can
/// be accessed with `gdk.Display.getMonitorAtSurface` and similar APIs.
pub const Display = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Display;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// `TRUE` if the display properly composites the alpha channel.
        pub const composited = struct {
            pub const name = "composited";

            pub const Type = c_int;
        };

        /// The dma-buf formats that are supported on this display
        pub const dmabuf_formats = struct {
            pub const name = "dmabuf-formats";

            pub const Type = ?*gdk.DmabufFormats;
        };

        /// `TRUE` if the display supports input shapes.
        pub const input_shapes = struct {
            pub const name = "input-shapes";

            pub const Type = c_int;
        };

        /// `TRUE` if the display supports an alpha channel.
        pub const rgba = struct {
            pub const name = "rgba";

            pub const Type = c_int;
        };

        /// `TRUE` if the display supports extensible frames.
        pub const shadow_width = struct {
            pub const name = "shadow-width";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted when the connection to the windowing system for `display` is closed.
        pub const closed = struct {
            pub const name = "closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_is_error: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("closed", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the connection to the windowing system for `display` is opened.
        pub const opened = struct {
            pub const name = "opened";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("opened", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted whenever a new seat is made known to the windowing system.
        pub const seat_added = struct {
            pub const name = "seat-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_seat: *gdk.Seat, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("seat-added", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted whenever a seat is removed by the windowing system.
        pub const seat_removed = struct {
            pub const name = "seat-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_seat: *gdk.Seat, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("seat-removed", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted whenever a setting changes its value.
        pub const setting_changed = struct {
            pub const name = "setting-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_setting: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("setting-changed", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the default `GdkDisplay`.
    ///
    /// This is a convenience function for:
    ///
    ///     gdk_display_manager_get_default_display (gdk_display_manager_get ())
    extern fn gdk_display_get_default() ?*gdk.Display;
    pub const getDefault = gdk_display_get_default;

    /// Opens a display.
    ///
    /// If opening the display fails, `NULL` is returned.
    extern fn gdk_display_open(p_display_name: ?[*:0]const u8) ?*gdk.Display;
    pub const open = gdk_display_open;

    /// Emits a short beep on `display`
    extern fn gdk_display_beep(p_display: *Display) void;
    pub const beep = gdk_display_beep;

    /// Closes the connection to the windowing system for the given display.
    ///
    /// This cleans up associated resources.
    extern fn gdk_display_close(p_display: *Display) void;
    pub const close = gdk_display_close;

    /// Creates a new `GdkGLContext` for the `GdkDisplay`.
    ///
    /// The context is disconnected from any particular surface or surface
    /// and cannot be used to draw to any surface. It can only be used to
    /// draw to non-surface framebuffers like textures.
    ///
    /// If the creation of the `GdkGLContext` failed, `error` will be set.
    /// Before using the returned `GdkGLContext`, you will need to
    /// call `gdk.GLContext.makeCurrent` or `gdk.GLContext.realize`.
    extern fn gdk_display_create_gl_context(p_self: *Display, p_error: ?*?*glib.Error) ?*gdk.GLContext;
    pub const createGlContext = gdk_display_create_gl_context;

    /// Returns `TRUE` if there is an ongoing grab on `device` for `display`.
    extern fn gdk_display_device_is_grabbed(p_display: *Display, p_device: *gdk.Device) c_int;
    pub const deviceIsGrabbed = gdk_display_device_is_grabbed;

    /// Flushes any requests queued for the windowing system.
    ///
    /// This happens automatically when the main loop blocks waiting for new events,
    /// but if your application is drawing without returning control to the main loop,
    /// you may need to call this function explicitly. A common case where this function
    /// needs to be called is when an application is executing drawing commands
    /// from a thread other than the thread where the main loop is running.
    ///
    /// This is most useful for X11. On windowing systems where requests are
    /// handled synchronously, this function will do nothing.
    extern fn gdk_display_flush(p_display: *Display) void;
    pub const flush = gdk_display_flush;

    /// Returns a `GdkAppLaunchContext` suitable for launching
    /// applications on the given display.
    extern fn gdk_display_get_app_launch_context(p_display: *Display) *gdk.AppLaunchContext;
    pub const getAppLaunchContext = gdk_display_get_app_launch_context;

    /// Gets the clipboard used for copy/paste operations.
    extern fn gdk_display_get_clipboard(p_display: *Display) *gdk.Clipboard;
    pub const getClipboard = gdk_display_get_clipboard;

    /// Returns the default `GdkSeat` for this display.
    ///
    /// Note that a display may not have a seat. In this case,
    /// this function will return `NULL`.
    extern fn gdk_display_get_default_seat(p_display: *Display) ?*gdk.Seat;
    pub const getDefaultSeat = gdk_display_get_default_seat;

    /// Returns the dma-buf formats that are supported on this display.
    ///
    /// GTK may use OpenGL or Vulkan to support some formats.
    /// Calling this function will then initialize them if they aren't yet.
    ///
    /// The formats returned by this function can be used for negotiating
    /// buffer formats with producers such as v4l, pipewire or GStreamer.
    ///
    /// To learn more about dma-bufs, see `gdk.DmabufTextureBuilder`.
    extern fn gdk_display_get_dmabuf_formats(p_display: *Display) *gdk.DmabufFormats;
    pub const getDmabufFormats = gdk_display_get_dmabuf_formats;

    /// Gets the monitor in which the largest area of `surface`
    /// resides.
    extern fn gdk_display_get_monitor_at_surface(p_display: *Display, p_surface: *gdk.Surface) ?*gdk.Monitor;
    pub const getMonitorAtSurface = gdk_display_get_monitor_at_surface;

    /// Gets the list of monitors associated with this display.
    ///
    /// Subsequent calls to this function will always return the
    /// same list for the same display.
    ///
    /// You can listen to the GListModel::items-changed signal on
    /// this list to monitor changes to the monitor of this display.
    extern fn gdk_display_get_monitors(p_self: *Display) *gio.ListModel;
    pub const getMonitors = gdk_display_get_monitors;

    /// Gets the name of the display.
    extern fn gdk_display_get_name(p_display: *Display) [*:0]const u8;
    pub const getName = gdk_display_get_name;

    /// Gets the clipboard used for the primary selection.
    ///
    /// On backends where the primary clipboard is not supported natively,
    /// GDK emulates this clipboard locally.
    extern fn gdk_display_get_primary_clipboard(p_display: *Display) *gdk.Clipboard;
    pub const getPrimaryClipboard = gdk_display_get_primary_clipboard;

    /// Retrieves a desktop-wide setting such as double-click time
    /// for the `display`.
    extern fn gdk_display_get_setting(p_display: *Display, p_name: [*:0]const u8, p_value: *gobject.Value) c_int;
    pub const getSetting = gdk_display_get_setting;

    /// Gets the startup notification ID for a Wayland display, or `NULL`
    /// if no ID has been defined.
    extern fn gdk_display_get_startup_notification_id(p_display: *Display) ?[*:0]const u8;
    pub const getStartupNotificationId = gdk_display_get_startup_notification_id;

    /// Finds out if the display has been closed.
    extern fn gdk_display_is_closed(p_display: *Display) c_int;
    pub const isClosed = gdk_display_is_closed;

    /// Returns whether surfaces can reasonably be expected to have
    /// their alpha channel drawn correctly on the screen.
    ///
    /// Check `gdk.Display.isRgba` for whether the display
    /// supports an alpha channel.
    ///
    /// On X11 this function returns whether a compositing manager is
    /// compositing on `display`.
    ///
    /// On modern displays, this value is always `TRUE`.
    extern fn gdk_display_is_composited(p_display: *Display) c_int;
    pub const isComposited = gdk_display_is_composited;

    /// Returns whether surfaces on this `display` are created with an
    /// alpha channel.
    ///
    /// Even if a `TRUE` is returned, it is possible that the
    /// surface’s alpha channel won’t be honored when displaying the
    /// surface on the screen: in particular, for X an appropriate
    /// windowing manager and compositing manager must be running to
    /// provide appropriate display. Use `gdk.Display.isComposited`
    /// to check if that is the case.
    ///
    /// On modern displays, this value is always `TRUE`.
    extern fn gdk_display_is_rgba(p_display: *Display) c_int;
    pub const isRgba = gdk_display_is_rgba;

    /// Returns the list of seats known to `display`.
    extern fn gdk_display_list_seats(p_display: *Display) *glib.List;
    pub const listSeats = gdk_display_list_seats;

    /// Returns the keyvals bound to `keycode`.
    ///
    /// The Nth `GdkKeymapKey` in `keys` is bound to the Nth keyval in `keyvals`.
    ///
    /// When a keycode is pressed by the user, the keyval from
    /// this list of entries is selected by considering the effective
    /// keyboard group and level.
    ///
    /// Free the returned arrays with `glib.free`.
    extern fn gdk_display_map_keycode(p_display: *Display, p_keycode: c_uint, p_keys: ?*[*]gdk.KeymapKey, p_keyvals: ?*[*]c_uint, p_n_entries: *c_int) c_int;
    pub const mapKeycode = gdk_display_map_keycode;

    /// Obtains a list of keycode/group/level combinations that will
    /// generate `keyval`.
    ///
    /// Groups and levels are two kinds of keyboard mode; in general, the level
    /// determines whether the top or bottom symbol on a key is used, and the
    /// group determines whether the left or right symbol is used.
    ///
    /// On US keyboards, the shift key changes the keyboard level, and there
    /// are no groups. A group switch key might convert a keyboard between
    /// Hebrew to English modes, for example.
    ///
    /// `GdkEventKey` contains a `group` field that indicates the active
    /// keyboard group. The level is computed from the modifier mask.
    ///
    /// The returned array should be freed with `glib.free`.
    extern fn gdk_display_map_keyval(p_display: *Display, p_keyval: c_uint, p_keys: *[*]gdk.KeymapKey, p_n_keys: *c_int) c_int;
    pub const mapKeyval = gdk_display_map_keyval;

    /// Indicates to the GUI environment that the application has
    /// finished loading, using a given identifier.
    ///
    /// GTK will call this function automatically for [GtkWindow](../gtk4/class.Window.html)
    /// with custom startup-notification identifier unless
    /// [`gtk_window_set_auto_startup_notification`](../gtk4/method.Window.set_auto_startup_notification.html)
    /// is called to disable that feature.
    extern fn gdk_display_notify_startup_complete(p_display: *Display, p_startup_id: [*:0]const u8) void;
    pub const notifyStartupComplete = gdk_display_notify_startup_complete;

    /// Checks that OpenGL is available for `self` and ensures that it is
    /// properly initialized.
    /// When this fails, an `error` will be set describing the error and this
    /// function returns `FALSE`.
    ///
    /// Note that even if this function succeeds, creating a `GdkGLContext`
    /// may still fail.
    ///
    /// This function is idempotent. Calling it multiple times will just
    /// return the same value or error.
    ///
    /// You never need to call this function, GDK will call it automatically
    /// as needed. But you can use it as a check when setting up code that
    /// might make use of OpenGL.
    extern fn gdk_display_prepare_gl(p_self: *Display, p_error: ?*?*glib.Error) c_int;
    pub const prepareGl = gdk_display_prepare_gl;

    /// Adds the given event to the event queue for `display`.
    extern fn gdk_display_put_event(p_display: *Display, p_event: *gdk.Event) void;
    pub const putEvent = gdk_display_put_event;

    /// Returns `TRUE` if the display supports input shapes.
    ///
    /// This means that `gdk.Surface.setInputRegion` can
    /// be used to modify the input shape of surfaces on `display`.
    ///
    /// On modern displays, this value is always `TRUE`.
    extern fn gdk_display_supports_input_shapes(p_display: *Display) c_int;
    pub const supportsInputShapes = gdk_display_supports_input_shapes;

    /// Returns whether it's possible for a surface to draw outside of the window area.
    ///
    /// If `TRUE` is returned the application decides if it wants to draw shadows.
    /// If `FALSE` is returned, the compositor decides if it wants to draw shadows.
    extern fn gdk_display_supports_shadow_width(p_display: *Display) c_int;
    pub const supportsShadowWidth = gdk_display_supports_shadow_width;

    /// Flushes any requests queued for the windowing system and waits until all
    /// requests have been handled.
    ///
    /// This is often used for making sure that the display is synchronized
    /// with the current state of the program. Calling `gdk.Display.sync`
    /// before `gdkx11.Display.errorTrapPop` makes sure that any errors
    /// generated from earlier requests are handled before the error trap is removed.
    ///
    /// This is most useful for X11. On windowing systems where requests are
    /// handled synchronously, this function will do nothing.
    extern fn gdk_display_sync(p_display: *Display) void;
    pub const sync = gdk_display_sync;

    /// Translates the contents of a `GdkEventKey` into a keyval, effective group,
    /// and level.
    ///
    /// Modifiers that affected the translation and are thus unavailable for
    /// application use are returned in `consumed_modifiers`.
    ///
    /// The `effective_group` is the group that was actually used for the
    /// translation; some keys such as Enter are not affected by the active
    /// keyboard group. The `level` is derived from `state`.
    ///
    /// `consumed_modifiers` gives modifiers that should be masked out
    /// from `state` when comparing this key press to a keyboard shortcut.
    /// For instance, on a US keyboard, the `plus` symbol is shifted, so
    /// when comparing a key press to a `<Control>plus` accelerator `<Shift>`
    /// should be masked out.
    ///
    /// This function should rarely be needed, since `GdkEventKey` already
    /// contains the translated keyval. It is exported for the benefit of
    /// virtualized test environments.
    extern fn gdk_display_translate_key(p_display: *Display, p_keycode: c_uint, p_state: gdk.ModifierType, p_group: c_int, p_keyval: ?*c_uint, p_effective_group: ?*c_int, p_level: ?*c_int, p_consumed: ?*gdk.ModifierType) c_int;
    pub const translateKey = gdk_display_translate_key;

    extern fn gdk_display_get_type() usize;
    pub const getGObjectType = gdk_display_get_type;

    extern fn g_object_ref(p_self: *gdk.Display) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Display) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Display, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Offers notification when displays appear or disappear.
///
/// `GdkDisplayManager` is a singleton object.
///
/// You can use `gdk.DisplayManager.get` to obtain the `GdkDisplayManager`
/// singleton, but that should be rarely necessary. Typically, initializing
/// GTK opens a display that you can work with without ever accessing the
/// `GdkDisplayManager`.
///
/// The GDK library can be built with support for multiple backends.
/// The `GdkDisplayManager` object determines which backend is used
/// at runtime.
///
/// In the rare case that you need to influence which of the backends
/// is being used, you can use `gdk.setAllowedBackends`. Note
/// that you need to call this function before initializing GTK.
///
/// ## Backend-specific code
///
/// When writing backend-specific code that is supposed to work with
/// multiple GDK backends, you have to consider both compile time and
/// runtime. At compile time, use the `GDK_WINDOWING_X11`, `GDK_WINDOWING_WIN32`
/// macros, etc. to find out which backends are present in the GDK library
/// you are building your application against. At runtime, use type-check
/// macros like `GDK_IS_X11_DISPLAY` to find out which backend is in use:
///
/// ```c
/// `ifdef` GDK_WINDOWING_X11
///   if (GDK_IS_X11_DISPLAY (display))
///     {
///       // make X11-specific calls here
///     }
///   else
/// `endif`
/// `ifdef` GDK_WINDOWING_MACOS
///   if (GDK_IS_MACOS_DISPLAY (display))
///     {
///       // make Quartz-specific calls here
///     }
///   else
/// `endif`
///   g_error ("Unsupported GDK backend");
/// ```
pub const DisplayManager = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DisplayManager;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The default display.
        pub const default_display = struct {
            pub const name = "default-display";

            pub const Type = ?*gdk.Display;
        };
    };

    pub const signals = struct {
        /// Emitted when a display is opened.
        pub const display_opened = struct {
            pub const name = "display-opened";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_display: *gdk.Display, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DisplayManager, p_instance))),
                    gobject.signalLookup("display-opened", DisplayManager.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the singleton `GdkDisplayManager` object.
    ///
    /// When called for the first time, this function consults the
    /// `GDK_BACKEND` environment variable to find out which of the
    /// supported GDK backends to use (in case GDK has been compiled
    /// with multiple backends).
    ///
    /// Applications can use `setAllowedBackends` to limit what
    /// backends will be used.
    extern fn gdk_display_manager_get() *gdk.DisplayManager;
    pub const get = gdk_display_manager_get;

    /// Gets the default `GdkDisplay`.
    extern fn gdk_display_manager_get_default_display(p_manager: *DisplayManager) ?*gdk.Display;
    pub const getDefaultDisplay = gdk_display_manager_get_default_display;

    /// List all currently open displays.
    extern fn gdk_display_manager_list_displays(p_manager: *DisplayManager) *glib.SList;
    pub const listDisplays = gdk_display_manager_list_displays;

    /// Opens a display.
    extern fn gdk_display_manager_open_display(p_manager: *DisplayManager, p_name: ?[*:0]const u8) ?*gdk.Display;
    pub const openDisplay = gdk_display_manager_open_display;

    /// Sets `display` as the default display.
    extern fn gdk_display_manager_set_default_display(p_manager: *DisplayManager, p_display: *gdk.Display) void;
    pub const setDefaultDisplay = gdk_display_manager_set_default_display;

    extern fn gdk_display_manager_get_type() usize;
    pub const getGObjectType = gdk_display_manager_get_type;

    extern fn g_object_ref(p_self: *gdk.DisplayManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DisplayManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DisplayManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GdkTexture` representing a DMA buffer.
///
/// To create a `GdkDmabufTexture`, use the auxiliary
/// `gdk.DmabufTextureBuilder` object.
///
/// Dma-buf textures can only be created on Linux.
pub const DmabufTexture = opaque {
    pub const Parent = gdk.Texture;
    pub const Implements = [_]type{ gdk.Paintable, gio.Icon, gio.LoadableIcon };
    pub const Class = gdk.DmabufTextureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_dmabuf_texture_get_type() usize;
    pub const getGObjectType = gdk_dmabuf_texture_get_type;

    extern fn g_object_ref(p_self: *gdk.DmabufTexture) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DmabufTexture) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DmabufTexture, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Constructs `gdk.Texture` objects from DMA buffers.
///
/// DMA buffers are commonly called **_dma-bufs_**.
///
/// DMA buffers are a feature of the Linux kernel to enable efficient buffer and
/// memory sharing between hardware such as codecs, GPUs, displays, cameras and the
/// kernel drivers controlling them. For example, a decoder may want its output to
/// be directly shared with the display server for rendering without a copy.
///
/// Any device driver which participates in DMA buffer sharing, can do so as either
/// the exporter or importer of buffers (or both).
///
/// The memory that is shared via DMA buffers is usually stored in non-system memory
/// (maybe in device's local memory or something else not directly accessible by the
/// CPU), and accessing this memory from the CPU may have higher-than-usual overhead.
///
/// In particular for graphics data, it is not uncommon that data consists of multiple
/// separate blocks of memory, for example one block for each of the red, green and
/// blue channels. These blocks are called **_planes_**. DMA buffers can have up to
/// four planes. Even if the memory is a single block, the data can be organized in
/// multiple planes, by specifying offsets from the beginning of the data.
///
/// DMA buffers are exposed to user-space as file descriptors allowing to pass them
/// between processes. If a DMA buffer has multiple planes, there is one file
/// descriptor per plane.
///
/// The format of the data (for graphics data, essentially its colorspace) is described
/// by a 32-bit integer. These format identifiers are defined in the header file `drm_fourcc.h`
/// and commonly referred to as **_fourcc_** values, since they are identified by 4 ASCII
/// characters. Additionally, each DMA buffer has a **_modifier_**, which is a 64-bit integer
/// that describes driver-specific details of the memory layout, such as tiling or compression.
///
/// For historical reasons, some producers of dma-bufs don't provide an explicit modifier, but
/// instead return `DMA_FORMAT_MOD_INVALID` to indicate that their modifier is **_implicit_**.
/// GTK tries to accommodate this situation by accepting `DMA_FORMAT_MOD_INVALID` as modifier.
///
/// The operation of `GdkDmabufTextureBuilder` is quite simple: Create a texture builder,
/// set all the necessary properties, and then call `gdk.DmabufTextureBuilder.build`
/// to create the new texture.
///
/// The required properties for a dma-buf texture are
///
///  * The width and height in pixels
///
///  * The `fourcc` code and `modifier` which identify the format and memory layout of the dma-buf
///
///  * The file descriptor, offset and stride for each of the planes
///
/// `GdkDmabufTextureBuilder` can be used for quick one-shot construction of
/// textures as well as kept around and reused to construct multiple textures.
///
/// For further information, see
///
/// * The Linux kernel [documentation](https://docs.kernel.org/driver-api/dma-buf.html)
///
/// * The header file [drm_fourcc.h](https://gitlab.freedesktop.org/mesa/drm/-/blob/main/include/drm/drm_fourcc.h)
pub const DmabufTextureBuilder = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.DmabufTextureBuilderClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The color state of the texture.
        pub const color_state = struct {
            pub const name = "color-state";

            pub const Type = ?*gdk.ColorState;
        };

        /// The display that this texture will be used on.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The format of the texture, as a fourcc value.
        pub const fourcc = struct {
            pub const name = "fourcc";

            pub const Type = c_uint;
        };

        /// The height of the texture.
        pub const height = struct {
            pub const name = "height";

            pub const Type = c_uint;
        };

        /// The modifier.
        pub const modifier = struct {
            pub const name = "modifier";

            pub const Type = u64;
        };

        /// The number of planes of the texture.
        ///
        /// Note that you can set properties for other planes,
        /// but they will be ignored when constructing the texture.
        pub const n_planes = struct {
            pub const name = "n-planes";

            pub const Type = c_uint;
        };

        /// Whether the alpha channel is premultiplied into the others.
        ///
        /// Only relevant if the format has alpha.
        pub const premultiplied = struct {
            pub const name = "premultiplied";

            pub const Type = c_int;
        };

        /// The update region for `gdk.DmabufTextureBuilder.properties.update_texture`.
        pub const update_region = struct {
            pub const name = "update-region";

            pub const Type = ?*cairo.Region;
        };

        /// The texture `gdk.DmabufTextureBuilder.properties.update_region` is an update for.
        pub const update_texture = struct {
            pub const name = "update-texture";

            pub const Type = ?*gdk.Texture;
        };

        /// The width of the texture.
        pub const width = struct {
            pub const name = "width";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    /// Creates a new texture builder.
    extern fn gdk_dmabuf_texture_builder_new() *gdk.DmabufTextureBuilder;
    pub const new = gdk_dmabuf_texture_builder_new;

    /// Builds a new `GdkTexture` with the values set up in the builder.
    ///
    /// It is a programming error to call this function if any mandatory property has not been set.
    ///
    /// Not all formats defined in the `drm_fourcc.h` header are supported. You can use
    /// `gdk.Display.getDmabufFormats` to get a list of supported formats. If the
    /// format is not supported by GTK, `NULL` will be returned and `error` will be set.
    ///
    /// The `destroy` function gets called when the returned texture gets released.
    ///
    /// It is the responsibility of the caller to keep the file descriptors for the planes
    /// open until the created texture is no longer used, and close them afterwards (possibly
    /// using the `destroy` notify).
    ///
    /// It is possible to call this function multiple times to create multiple textures,
    /// possibly with changing properties in between.
    extern fn gdk_dmabuf_texture_builder_build(p_self: *DmabufTextureBuilder, p_destroy: ?glib.DestroyNotify, p_data: ?*anyopaque, p_error: ?*?*glib.Error) ?*gdk.Texture;
    pub const build = gdk_dmabuf_texture_builder_build;

    /// Gets the color state previously set via `gdk.DmabufTextureBuilder.setColorState`.
    extern fn gdk_dmabuf_texture_builder_get_color_state(p_self: *DmabufTextureBuilder) ?*gdk.ColorState;
    pub const getColorState = gdk_dmabuf_texture_builder_get_color_state;

    /// Returns the display that this texture builder is
    /// associated with.
    extern fn gdk_dmabuf_texture_builder_get_display(p_self: *DmabufTextureBuilder) *gdk.Display;
    pub const getDisplay = gdk_dmabuf_texture_builder_get_display;

    /// Gets the file descriptor for a plane.
    extern fn gdk_dmabuf_texture_builder_get_fd(p_self: *DmabufTextureBuilder, p_plane: c_uint) c_int;
    pub const getFd = gdk_dmabuf_texture_builder_get_fd;

    /// Gets the format previously set via `gdk.DmabufTextureBuilder.setFourcc`
    /// or 0 if the format wasn't set.
    ///
    /// The format is specified as a fourcc code.
    extern fn gdk_dmabuf_texture_builder_get_fourcc(p_self: *DmabufTextureBuilder) u32;
    pub const getFourcc = gdk_dmabuf_texture_builder_get_fourcc;

    /// Gets the height previously set via `gdk.DmabufTextureBuilder.setHeight` or
    /// 0 if the height wasn't set.
    extern fn gdk_dmabuf_texture_builder_get_height(p_self: *DmabufTextureBuilder) c_uint;
    pub const getHeight = gdk_dmabuf_texture_builder_get_height;

    /// Gets the modifier value.
    extern fn gdk_dmabuf_texture_builder_get_modifier(p_self: *DmabufTextureBuilder) u64;
    pub const getModifier = gdk_dmabuf_texture_builder_get_modifier;

    /// Gets the number of planes.
    extern fn gdk_dmabuf_texture_builder_get_n_planes(p_self: *DmabufTextureBuilder) c_uint;
    pub const getNPlanes = gdk_dmabuf_texture_builder_get_n_planes;

    /// Gets the offset value for a plane.
    extern fn gdk_dmabuf_texture_builder_get_offset(p_self: *DmabufTextureBuilder, p_plane: c_uint) c_uint;
    pub const getOffset = gdk_dmabuf_texture_builder_get_offset;

    /// Whether the data is premultiplied.
    extern fn gdk_dmabuf_texture_builder_get_premultiplied(p_self: *DmabufTextureBuilder) c_int;
    pub const getPremultiplied = gdk_dmabuf_texture_builder_get_premultiplied;

    /// Gets the stride value for a plane.
    extern fn gdk_dmabuf_texture_builder_get_stride(p_self: *DmabufTextureBuilder, p_plane: c_uint) c_uint;
    pub const getStride = gdk_dmabuf_texture_builder_get_stride;

    /// Gets the region previously set via `gdk.DmabufTextureBuilder.setUpdateRegion` or
    /// `NULL` if none was set.
    extern fn gdk_dmabuf_texture_builder_get_update_region(p_self: *DmabufTextureBuilder) ?*cairo.Region;
    pub const getUpdateRegion = gdk_dmabuf_texture_builder_get_update_region;

    /// Gets the texture previously set via `gdk.DmabufTextureBuilder.setUpdateTexture` or
    /// `NULL` if none was set.
    extern fn gdk_dmabuf_texture_builder_get_update_texture(p_self: *DmabufTextureBuilder) ?*gdk.Texture;
    pub const getUpdateTexture = gdk_dmabuf_texture_builder_get_update_texture;

    /// Gets the width previously set via `gdk.DmabufTextureBuilder.setWidth` or
    /// 0 if the width wasn't set.
    extern fn gdk_dmabuf_texture_builder_get_width(p_self: *DmabufTextureBuilder) c_uint;
    pub const getWidth = gdk_dmabuf_texture_builder_get_width;

    /// Sets the color state for the texture.
    ///
    /// By default, the colorstate is `NULL`. In that case, GTK will choose the
    /// correct colorstate based on the format.
    /// If you don't know what colorstates are, this is probably the right thing.
    extern fn gdk_dmabuf_texture_builder_set_color_state(p_self: *DmabufTextureBuilder, p_color_state: ?*gdk.ColorState) void;
    pub const setColorState = gdk_dmabuf_texture_builder_set_color_state;

    /// Sets the display that this texture builder is
    /// associated with.
    ///
    /// The display is used to determine the supported
    /// dma-buf formats.
    extern fn gdk_dmabuf_texture_builder_set_display(p_self: *DmabufTextureBuilder, p_display: *gdk.Display) void;
    pub const setDisplay = gdk_dmabuf_texture_builder_set_display;

    /// Sets the file descriptor for a plane.
    extern fn gdk_dmabuf_texture_builder_set_fd(p_self: *DmabufTextureBuilder, p_plane: c_uint, p_fd: c_int) void;
    pub const setFd = gdk_dmabuf_texture_builder_set_fd;

    /// Sets the format of the texture.
    ///
    /// The format is specified as a fourcc code.
    ///
    /// The format must be set before calling `gdk.DmabufTextureBuilder.build`.
    extern fn gdk_dmabuf_texture_builder_set_fourcc(p_self: *DmabufTextureBuilder, p_fourcc: u32) void;
    pub const setFourcc = gdk_dmabuf_texture_builder_set_fourcc;

    /// Sets the height of the texture.
    ///
    /// The height must be set before calling `gdk.DmabufTextureBuilder.build`.
    extern fn gdk_dmabuf_texture_builder_set_height(p_self: *DmabufTextureBuilder, p_height: c_uint) void;
    pub const setHeight = gdk_dmabuf_texture_builder_set_height;

    /// Sets the modifier.
    extern fn gdk_dmabuf_texture_builder_set_modifier(p_self: *DmabufTextureBuilder, p_modifier: u64) void;
    pub const setModifier = gdk_dmabuf_texture_builder_set_modifier;

    /// Sets the number of planes of the texture.
    extern fn gdk_dmabuf_texture_builder_set_n_planes(p_self: *DmabufTextureBuilder, p_n_planes: c_uint) void;
    pub const setNPlanes = gdk_dmabuf_texture_builder_set_n_planes;

    /// Sets the offset for a plane.
    extern fn gdk_dmabuf_texture_builder_set_offset(p_self: *DmabufTextureBuilder, p_plane: c_uint, p_offset: c_uint) void;
    pub const setOffset = gdk_dmabuf_texture_builder_set_offset;

    /// Sets whether the data is premultiplied.
    ///
    /// Unless otherwise specified, all formats including alpha channels are assumed
    /// to be premultiplied.
    extern fn gdk_dmabuf_texture_builder_set_premultiplied(p_self: *DmabufTextureBuilder, p_premultiplied: c_int) void;
    pub const setPremultiplied = gdk_dmabuf_texture_builder_set_premultiplied;

    /// Sets the stride for a plane.
    ///
    /// The stride must be set for all planes before calling `gdk.DmabufTextureBuilder.build`.
    extern fn gdk_dmabuf_texture_builder_set_stride(p_self: *DmabufTextureBuilder, p_plane: c_uint, p_stride: c_uint) void;
    pub const setStride = gdk_dmabuf_texture_builder_set_stride;

    /// Sets the region to be updated by this texture. Together with
    /// `gdk.DmabufTextureBuilder.properties.update_texture` this describes an
    /// update of a previous texture.
    ///
    /// When rendering animations of large textures, it is possible that
    /// consecutive textures are only updating contents in parts of the texture.
    /// It is then possible to describe this update via these two properties,
    /// so that GTK can avoid rerendering parts that did not change.
    ///
    /// An example would be a screen recording where only the mouse pointer moves.
    extern fn gdk_dmabuf_texture_builder_set_update_region(p_self: *DmabufTextureBuilder, p_region: ?*cairo.Region) void;
    pub const setUpdateRegion = gdk_dmabuf_texture_builder_set_update_region;

    /// Sets the texture to be updated by this texture. See
    /// `gdk.DmabufTextureBuilder.setUpdateRegion` for an explanation.
    extern fn gdk_dmabuf_texture_builder_set_update_texture(p_self: *DmabufTextureBuilder, p_texture: ?*gdk.Texture) void;
    pub const setUpdateTexture = gdk_dmabuf_texture_builder_set_update_texture;

    /// Sets the width of the texture.
    ///
    /// The width must be set before calling `gdk.DmabufTextureBuilder.build`.
    extern fn gdk_dmabuf_texture_builder_set_width(p_self: *DmabufTextureBuilder, p_width: c_uint) void;
    pub const setWidth = gdk_dmabuf_texture_builder_set_width;

    extern fn gdk_dmabuf_texture_builder_get_type() usize;
    pub const getGObjectType = gdk_dmabuf_texture_builder_get_type;

    extern fn g_object_ref(p_self: *gdk.DmabufTextureBuilder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DmabufTextureBuilder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DmabufTextureBuilder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents the source of an ongoing DND operation.
///
/// A `GdkDrag` is created when a drag is started, and stays alive for duration of
/// the DND operation. After a drag has been started with `gdk.Drag.begin`,
/// the caller gets informed about the status of the ongoing drag operation
/// with signals on the `GdkDrag` object.
///
/// GTK provides a higher level abstraction based on top of these functions,
/// and so they are not normally needed in GTK applications. See the
/// "Drag and Drop" section of the GTK documentation for more information.
pub const Drag = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Drag;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The possible actions of this drag.
        pub const actions = struct {
            pub const name = "actions";

            pub const Type = gdk.DragAction;
        };

        /// The `GdkContentProvider`.
        pub const content = struct {
            pub const name = "content";

            pub const Type = ?*gdk.ContentProvider;
        };

        /// The `GdkDevice` that is performing the drag.
        pub const device = struct {
            pub const name = "device";

            pub const Type = ?*gdk.Device;
        };

        /// The `GdkDisplay` that the drag belongs to.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The possible formats that the drag can provide its data in.
        pub const formats = struct {
            pub const name = "formats";

            pub const Type = ?*gdk.ContentFormats;
        };

        /// The currently selected action of the drag.
        pub const selected_action = struct {
            pub const name = "selected-action";

            pub const Type = gdk.DragAction;
        };

        /// The surface where the drag originates.
        pub const surface = struct {
            pub const name = "surface";

            pub const Type = ?*gdk.Surface;
        };
    };

    pub const signals = struct {
        /// Emitted when the drag operation is cancelled.
        pub const cancel = struct {
            pub const name = "cancel";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_reason: gdk.DragCancelReason, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Drag, p_instance))),
                    gobject.signalLookup("cancel", Drag.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the destination side has finished reading all data.
        ///
        /// The drag object can now free all miscellaneous data.
        pub const dnd_finished = struct {
            pub const name = "dnd-finished";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Drag, p_instance))),
                    gobject.signalLookup("dnd-finished", Drag.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the drop operation is performed on an accepting client.
        pub const drop_performed = struct {
            pub const name = "drop-performed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Drag, p_instance))),
                    gobject.signalLookup("drop-performed", Drag.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Starts a drag and creates a new drag context for it.
    ///
    /// This function is called by the drag source. After this call, you
    /// probably want to set up the drag icon using the surface returned
    /// by `gdk.Drag.getDragSurface`.
    ///
    /// This function returns a reference to the `gdk.Drag` object,
    /// but GTK keeps its own reference as well, as long as the DND operation
    /// is going on.
    ///
    /// Note: if `actions` include `GDK_ACTION_MOVE`, you need to listen for
    /// the `gdk.Drag.signals.dnd_finished` signal and delete the data at
    /// the source if `gdk.Drag.getSelectedAction` returns
    /// `GDK_ACTION_MOVE`.
    extern fn gdk_drag_begin(p_surface: *gdk.Surface, p_device: *gdk.Device, p_content: *gdk.ContentProvider, p_actions: gdk.DragAction, p_dx: f64, p_dy: f64) ?*gdk.Drag;
    pub const begin = gdk_drag_begin;

    /// Informs GDK that the drop ended.
    ///
    /// Passing `FALSE` for `success` may trigger a drag cancellation
    /// animation.
    ///
    /// This function is called by the drag source, and should be the
    /// last call before dropping the reference to the `drag`.
    ///
    /// The `GdkDrag` will only take the first `gdk.Drag.dropDone`
    /// call as effective, if this function is called multiple times,
    /// all subsequent calls will be ignored.
    extern fn gdk_drag_drop_done(p_drag: *Drag, p_success: c_int) void;
    pub const dropDone = gdk_drag_drop_done;

    /// Determines the bitmask of possible actions proposed by the source.
    extern fn gdk_drag_get_actions(p_drag: *Drag) gdk.DragAction;
    pub const getActions = gdk_drag_get_actions;

    /// Returns the `GdkContentProvider` associated to the `GdkDrag` object.
    extern fn gdk_drag_get_content(p_drag: *Drag) *gdk.ContentProvider;
    pub const getContent = gdk_drag_get_content;

    /// Returns the `GdkDevice` associated to the `GdkDrag` object.
    extern fn gdk_drag_get_device(p_drag: *Drag) *gdk.Device;
    pub const getDevice = gdk_drag_get_device;

    /// Gets the `GdkDisplay` that the drag object was created for.
    extern fn gdk_drag_get_display(p_drag: *Drag) *gdk.Display;
    pub const getDisplay = gdk_drag_get_display;

    /// Returns the surface on which the drag icon should be rendered
    /// during the drag operation.
    ///
    /// Note that the surface may not be available until the drag operation
    /// has begun. GDK will move the surface in accordance with the ongoing
    /// drag operation. The surface is owned by `drag` and will be destroyed
    /// when the drag operation is over.
    extern fn gdk_drag_get_drag_surface(p_drag: *Drag) ?*gdk.Surface;
    pub const getDragSurface = gdk_drag_get_drag_surface;

    /// Retrieves the formats supported by this `GdkDrag` object.
    extern fn gdk_drag_get_formats(p_drag: *Drag) *gdk.ContentFormats;
    pub const getFormats = gdk_drag_get_formats;

    /// Determines the action chosen by the drag destination.
    extern fn gdk_drag_get_selected_action(p_drag: *Drag) gdk.DragAction;
    pub const getSelectedAction = gdk_drag_get_selected_action;

    /// Returns the `GdkSurface` where the drag originates.
    extern fn gdk_drag_get_surface(p_drag: *Drag) *gdk.Surface;
    pub const getSurface = gdk_drag_get_surface;

    /// Sets the position of the drag surface that will be kept
    /// under the cursor hotspot.
    ///
    /// Initially, the hotspot is at the top left corner of the drag surface.
    extern fn gdk_drag_set_hotspot(p_drag: *Drag, p_hot_x: c_int, p_hot_y: c_int) void;
    pub const setHotspot = gdk_drag_set_hotspot;

    extern fn gdk_drag_get_type() usize;
    pub const getGObjectType = gdk_drag_get_type;

    extern fn g_object_ref(p_self: *gdk.Drag) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Drag) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Drag, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Base class for objects implementing different rendering methods.
///
/// `GdkDrawContext` is the base object used by contexts implementing different
/// rendering methods, such as `gdk.CairoContext` or `gdk.GLContext`.
/// It provides shared functionality between those contexts.
///
/// You will always interact with one of those subclasses.
///
/// A `GdkDrawContext` is always associated with a single toplevel surface.
pub const DrawContext = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DrawContext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `GdkDisplay` used to create the `GdkDrawContext`.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The `GdkSurface` the context is bound to.
        pub const surface = struct {
            pub const name = "surface";

            pub const Type = ?*gdk.Surface;
        };
    };

    pub const signals = struct {};

    /// Indicates that you are beginning the process of redrawing `region`
    /// on the `context`'s surface.
    ///
    /// Calling this function begins a drawing operation using `context` on the
    /// surface that `context` was created from. The actual requirements and
    /// guarantees for the drawing operation vary for different implementations
    /// of drawing, so a `gdk.CairoContext` and a `gdk.GLContext`
    /// need to be treated differently.
    ///
    /// A call to this function is a requirement for drawing and must be
    /// followed by a call to `gdk.DrawContext.endFrame`, which will
    /// complete the drawing operation and ensure the contents become visible
    /// on screen.
    ///
    /// Note that the `region` passed to this function is the minimum region that
    /// needs to be drawn and depending on implementation, windowing system and
    /// hardware in use, it might be necessary to draw a larger region. Drawing
    /// implementation must use `gdk.DrawContext.getFrameRegion` to
    /// query the region that must be drawn.
    ///
    /// When using GTK, the widget system automatically places calls to
    /// `gdk.DrawContext.beginFrame` and `gdk.DrawContext.endFrame` via the
    /// use of [GskRenderer](../gsk4/class.Renderer.html)s, so application code
    /// does not need to call these functions explicitly.
    extern fn gdk_draw_context_begin_frame(p_context: *DrawContext, p_region: *const cairo.Region) void;
    pub const beginFrame = gdk_draw_context_begin_frame;

    /// Ends a drawing operation started with `gdk.DrawContext.beginFrame`.
    ///
    /// This makes the drawing available on screen.
    /// See `gdk.DrawContext.beginFrame` for more details about drawing.
    ///
    /// When using a `gdk.GLContext`, this function may call ``glFlush``
    /// implicitly before returning; it is not recommended to call ``glFlush``
    /// explicitly before calling this function.
    extern fn gdk_draw_context_end_frame(p_context: *DrawContext) void;
    pub const endFrame = gdk_draw_context_end_frame;

    /// Retrieves the `GdkDisplay` the `context` is created for
    extern fn gdk_draw_context_get_display(p_context: *DrawContext) ?*gdk.Display;
    pub const getDisplay = gdk_draw_context_get_display;

    /// Retrieves the region that is currently being repainted.
    ///
    /// After a call to `gdk.DrawContext.beginFrame` this function will
    /// return a union of the region passed to that function and the area of the
    /// surface that the `context` determined needs to be repainted.
    ///
    /// If `context` is not in between calls to `gdk.DrawContext.beginFrame`
    /// and `gdk.DrawContext.endFrame`, `NULL` will be returned.
    extern fn gdk_draw_context_get_frame_region(p_context: *DrawContext) ?*const cairo.Region;
    pub const getFrameRegion = gdk_draw_context_get_frame_region;

    /// Retrieves the surface that `context` is bound to.
    extern fn gdk_draw_context_get_surface(p_context: *DrawContext) ?*gdk.Surface;
    pub const getSurface = gdk_draw_context_get_surface;

    /// Returns `TRUE` if `context` is in the process of drawing to its surface.
    ///
    /// This is the case between calls to `gdk.DrawContext.beginFrame`
    /// and `gdk.DrawContext.endFrame`. In this situation, drawing commands
    /// may be effecting the contents of the `context`'s surface.
    extern fn gdk_draw_context_is_in_frame(p_context: *DrawContext) c_int;
    pub const isInFrame = gdk_draw_context_is_in_frame;

    extern fn gdk_draw_context_get_type() usize;
    pub const getGObjectType = gdk_draw_context_get_type;

    extern fn g_object_ref(p_self: *gdk.DrawContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DrawContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DrawContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents the target of an ongoing DND operation.
///
/// Possible drop sites get informed about the status of the ongoing drag
/// operation with events of type `GDK_DRAG_ENTER`, `GDK_DRAG_LEAVE`,
/// `GDK_DRAG_MOTION` and `GDK_DROP_START`. The `GdkDrop` object can be obtained
/// from these `gdk.Event` types using `gdk.DNDEvent.getDrop`.
///
/// The actual data transfer is initiated from the target side via an async
/// read, using one of the `GdkDrop` methods for this purpose:
/// `gdk.Drop.readAsync` or `gdk.Drop.readValueAsync`.
///
/// GTK provides a higher level abstraction based on top of these functions,
/// and so they are not normally needed in GTK applications. See the
/// "Drag and Drop" section of the GTK documentation for more information.
pub const Drop = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Drop;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The possible actions for this drop
        pub const actions = struct {
            pub const name = "actions";

            pub const Type = gdk.DragAction;
        };

        /// The `GdkDevice` performing the drop
        pub const device = struct {
            pub const name = "device";

            pub const Type = ?*gdk.Device;
        };

        /// The `GdkDisplay` that the drop belongs to.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The `GdkDrag` that initiated this drop
        pub const drag = struct {
            pub const name = "drag";

            pub const Type = ?*gdk.Drag;
        };

        /// The possible formats that the drop can provide its data in.
        pub const formats = struct {
            pub const name = "formats";

            pub const Type = ?*gdk.ContentFormats;
        };

        /// The `GdkSurface` the drop happens on
        pub const surface = struct {
            pub const name = "surface";

            pub const Type = ?*gdk.Surface;
        };
    };

    pub const signals = struct {};

    /// Ends the drag operation after a drop.
    ///
    /// The `action` must be a single action selected from the actions
    /// available via `gdk.Drop.getActions`.
    extern fn gdk_drop_finish(p_self: *Drop, p_action: gdk.DragAction) void;
    pub const finish = gdk_drop_finish;

    /// Returns the possible actions for this `GdkDrop`.
    ///
    /// If this value contains multiple actions - i.e.
    /// `gdk.DragAction.isUnique` returns `FALSE` for the result -
    /// `gdk.Drop.finish` must choose the action to use when
    /// accepting the drop. This will only happen if you passed
    /// `GDK_ACTION_ASK` as one of the possible actions in
    /// `gdk.Drop.status`. `GDK_ACTION_ASK` itself will not
    /// be included in the actions returned by this function.
    ///
    /// This value may change over the lifetime of the `gdk.Drop`
    /// both as a response to source side actions as well as to calls to
    /// `gdk.Drop.status` or `gdk.Drop.finish`. The source
    /// side will not change this value anymore once a drop has started.
    extern fn gdk_drop_get_actions(p_self: *Drop) gdk.DragAction;
    pub const getActions = gdk_drop_get_actions;

    /// Returns the `GdkDevice` performing the drop.
    extern fn gdk_drop_get_device(p_self: *Drop) *gdk.Device;
    pub const getDevice = gdk_drop_get_device;

    /// Gets the `GdkDisplay` that `self` was created for.
    extern fn gdk_drop_get_display(p_self: *Drop) *gdk.Display;
    pub const getDisplay = gdk_drop_get_display;

    /// If this is an in-app drag-and-drop operation, returns the `GdkDrag`
    /// that corresponds to this drop.
    ///
    /// If it is not, `NULL` is returned.
    extern fn gdk_drop_get_drag(p_self: *Drop) ?*gdk.Drag;
    pub const getDrag = gdk_drop_get_drag;

    /// Returns the `GdkContentFormats` that the drop offers the data
    /// to be read in.
    extern fn gdk_drop_get_formats(p_self: *Drop) *gdk.ContentFormats;
    pub const getFormats = gdk_drop_get_formats;

    /// Returns the `GdkSurface` performing the drop.
    extern fn gdk_drop_get_surface(p_self: *Drop) *gdk.Surface;
    pub const getSurface = gdk_drop_get_surface;

    /// Asynchronously read the dropped data from a `GdkDrop`
    /// in a format that complies with one of the mime types.
    extern fn gdk_drop_read_async(p_self: *Drop, p_mime_types: [*][*:0]const u8, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const readAsync = gdk_drop_read_async;

    /// Finishes an async drop read operation.
    ///
    /// Note that you must not use blocking read calls on the returned stream
    /// in the GTK thread, since some platforms might require communication with
    /// GTK to complete the data transfer. You can use async APIs such as
    /// `gio.InputStream.readBytesAsync`.
    ///
    /// See `gdk.Drop.readAsync`.
    extern fn gdk_drop_read_finish(p_self: *Drop, p_result: *gio.AsyncResult, p_out_mime_type: *[*:0]const u8, p_error: ?*?*glib.Error) ?*gio.InputStream;
    pub const readFinish = gdk_drop_read_finish;

    /// Asynchronously request the drag operation's contents converted
    /// to the given `type`.
    ///
    /// For local drag-and-drop operations that are available in the given
    /// `GType`, the value will be copied directly. Otherwise, GDK will
    /// try to use `gdk.contentDeserializeAsync` to convert the data.
    extern fn gdk_drop_read_value_async(p_self: *Drop, p_type: usize, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const readValueAsync = gdk_drop_read_value_async;

    /// Finishes an async drop read.
    ///
    /// See `gdk.Drop.readValueAsync`.
    extern fn gdk_drop_read_value_finish(p_self: *Drop, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*const gobject.Value;
    pub const readValueFinish = gdk_drop_read_value_finish;

    /// Selects all actions that are potentially supported by the destination.
    ///
    /// When calling this function, do not restrict the passed in actions to
    /// the ones provided by `gdk.Drop.getActions`. Those actions may
    /// change in the future, even depending on the actions you provide here.
    ///
    /// The `preferred` action is a hint to the drag-and-drop mechanism about which
    /// action to use when multiple actions are possible.
    ///
    /// This function should be called by drag destinations in response to
    /// `GDK_DRAG_ENTER` or `GDK_DRAG_MOTION` events. If the destination does
    /// not yet know the exact actions it supports, it should set any possible
    /// actions first and then later call this function again.
    extern fn gdk_drop_status(p_self: *Drop, p_actions: gdk.DragAction, p_preferred: gdk.DragAction) void;
    pub const status = gdk_drop_status;

    extern fn gdk_drop_get_type() usize;
    pub const getGObjectType = gdk_drop_get_type;

    extern fn g_object_ref(p_self: *gdk.Drop) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Drop) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Drop, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents windowing system events.
///
/// In GTK applications the events are handled automatically by toplevel
/// widgets and passed on to the event controllers of appropriate widgets,
/// so using `GdkEvent` and its related API is rarely needed.
///
/// `GdkEvent` structs are immutable.
pub const Event = opaque {
    pub const Parent = gobject.TypeInstance;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Event;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts all axis values from an event.
    ///
    /// To find out which axes are used, use `gdk.DeviceTool.getAxes`
    /// on the device tool returned by `gdk.Event.getDeviceTool`.
    extern fn gdk_event_get_axes(p_event: *Event, p_axes: *[*]f64, p_n_axes: *c_uint) c_int;
    pub const getAxes = gdk_event_get_axes;

    /// Extract the axis value for a particular axis use from
    /// an event structure.
    ///
    /// To find out which axes are used, use `gdk.DeviceTool.getAxes`
    /// on the device tool returned by `gdk.Event.getDeviceTool`.
    extern fn gdk_event_get_axis(p_event: *Event, p_axis_use: gdk.AxisUse, p_value: *f64) c_int;
    pub const getAxis = gdk_event_get_axis;

    /// Returns the device of an event.
    extern fn gdk_event_get_device(p_event: *Event) ?*gdk.Device;
    pub const getDevice = gdk_event_get_device;

    /// Returns a `GdkDeviceTool` representing the tool that
    /// caused the event.
    ///
    /// If the was not generated by a device that supports
    /// different tools (such as a tablet), this function will
    /// return `NULL`.
    ///
    /// Note: the `GdkDeviceTool` will be constant during
    /// the application lifetime, if settings must be stored
    /// persistently across runs, see `gdk.DeviceTool.getSerial`.
    extern fn gdk_event_get_device_tool(p_event: *Event) ?*gdk.DeviceTool;
    pub const getDeviceTool = gdk_event_get_device_tool;

    /// Retrieves the display associated to the `event`.
    extern fn gdk_event_get_display(p_event: *Event) ?*gdk.Display;
    pub const getDisplay = gdk_event_get_display;

    /// Returns the event sequence to which the event belongs.
    ///
    /// Related touch events are connected in a sequence. Other
    /// events typically don't have event sequence information.
    extern fn gdk_event_get_event_sequence(p_event: *Event) *gdk.EventSequence;
    pub const getEventSequence = gdk_event_get_event_sequence;

    /// Retrieves the type of the event.
    extern fn gdk_event_get_event_type(p_event: *Event) gdk.EventType;
    pub const getEventType = gdk_event_get_event_type;

    /// Retrieves the history of the device that `event` is for, as a list of
    /// time and coordinates.
    ///
    /// The history includes positions that are not delivered as separate events
    /// to the application because they occurred in the same frame as `event`.
    ///
    /// Note that only motion and scroll events record history, and motion
    /// events do it only if one of the mouse buttons is down, or the device
    /// has a tool.
    extern fn gdk_event_get_history(p_event: *Event, p_out_n_coords: *c_uint) ?[*]gdk.TimeCoord;
    pub const getHistory = gdk_event_get_history;

    /// Returns the modifier state field of an event.
    extern fn gdk_event_get_modifier_state(p_event: *Event) gdk.ModifierType;
    pub const getModifierState = gdk_event_get_modifier_state;

    /// Returns whether this event is an 'emulated' pointer event.
    ///
    /// Emulated pointer events typically originate from a touch events.
    extern fn gdk_event_get_pointer_emulated(p_event: *Event) c_int;
    pub const getPointerEmulated = gdk_event_get_pointer_emulated;

    /// Extract the event surface relative x/y coordinates from an event.
    ///
    /// This position is in [surface coordinates](coordinates.html).
    extern fn gdk_event_get_position(p_event: *Event, p_x: *f64, p_y: *f64) c_int;
    pub const getPosition = gdk_event_get_position;

    /// Returns the seat that originated the event.
    extern fn gdk_event_get_seat(p_event: *Event) ?*gdk.Seat;
    pub const getSeat = gdk_event_get_seat;

    /// Extracts the surface associated with an event.
    extern fn gdk_event_get_surface(p_event: *Event) ?*gdk.Surface;
    pub const getSurface = gdk_event_get_surface;

    /// Returns the timestamp of `event`.
    ///
    /// Not all events have timestamps. In that case, this function
    /// returns `GDK_CURRENT_TIME`.
    extern fn gdk_event_get_time(p_event: *Event) u32;
    pub const getTime = gdk_event_get_time;

    /// Increase the ref count of `event`.
    extern fn gdk_event_ref(p_event: *Event) *gdk.Event;
    pub const ref = gdk_event_ref;

    /// Returns whether a `GdkEvent` should trigger a context menu,
    /// according to platform conventions.
    ///
    /// The right mouse button typically triggers context menus.
    /// On macOS, Control+left mouse button also triggers.
    ///
    /// This function should always be used instead of simply checking for
    ///
    /// ```c
    /// event->button == GDK_BUTTON_SECONDARY
    /// ```
    extern fn gdk_event_triggers_context_menu(p_event: *Event) c_int;
    pub const triggersContextMenu = gdk_event_triggers_context_menu;

    /// Decrease the ref count of `event`.
    ///
    /// If the last reference is dropped, the structure is freed.
    extern fn gdk_event_unref(p_event: *Event) void;
    pub const unref = gdk_event_unref;

    extern fn gdk_event_get_type() usize;
    pub const getGObjectType = gdk_event_get_type;

    pub fn as(p_instance: *Event, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a keyboard focus change.
pub const FocusEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = FocusEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts whether this event is about focus entering or
    /// leaving the surface.
    extern fn gdk_focus_event_get_in(p_event: *FocusEvent) c_int;
    pub const getIn = gdk_focus_event_get_in;

    extern fn gdk_focus_event_get_type() usize;
    pub const getGObjectType = gdk_focus_event_get_type;

    pub fn as(p_instance: *FocusEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Tells the application when to update and repaint a surface.
///
/// This may be synced to the vertical refresh rate of the monitor, for example.
/// Even when the frame clock uses a simple timer rather than a hardware-based
/// vertical sync, the frame clock helps because it ensures everything paints at
/// the same time (reducing the total number of frames).
///
/// The frame clock can also automatically stop painting when it knows the frames
/// will not be visible, or scale back animation framerates.
///
/// `GdkFrameClock` is designed to be compatible with an OpenGL-based implementation
/// or with mozRequestAnimationFrame in Firefox, for example.
///
/// A frame clock is idle until someone requests a frame with
/// `gdk.FrameClock.requestPhase`. At some later point that makes sense
/// for the synchronization being implemented, the clock will process a frame and
/// emit signals for each phase that has been requested. (See the signals of the
/// `GdkFrameClock` class for documentation of the phases.
/// `GDK_FRAME_CLOCK_PHASE_UPDATE` and the `gdk.FrameClock.signals.update` signal
/// are most interesting for application writers, and are used to update the
/// animations, using the frame time given by `gdk.FrameClock.getFrameTime`.
///
/// The frame time is reported in microseconds and generally in the same
/// timescale as `glib.getMonotonicTime`, however, it is not the same
/// as `glib.getMonotonicTime`. The frame time does not advance during
/// the time a frame is being painted, and outside of a frame, an attempt
/// is made so that all calls to `gdk.FrameClock.getFrameTime` that
/// are called at a “similar” time get the same value. This means that
/// if different animations are timed by looking at the difference in
/// time between an initial value from `gdk.FrameClock.getFrameTime`
/// and the value inside the `gdk.FrameClock.signals.update` signal of the clock,
/// they will stay exactly synchronized.
pub const FrameClock = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.FrameClockClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// This signal ends processing of the frame.
        ///
        /// Applications should generally not handle this signal.
        pub const after_paint = struct {
            pub const name = "after-paint";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("after-paint", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Begins processing of the frame.
        ///
        /// Applications should generally not handle this signal.
        pub const before_paint = struct {
            pub const name = "before-paint";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("before-paint", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Used to flush pending motion events that are being batched up and
        /// compressed together.
        ///
        /// Applications should not handle this signal.
        pub const flush_events = struct {
            pub const name = "flush-events";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("flush-events", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted as the second step of toolkit and application processing
        /// of the frame.
        ///
        /// Any work to update sizes and positions of application elements
        /// should be performed. GTK normally handles this internally.
        pub const layout = struct {
            pub const name = "layout";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("layout", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted as the third step of toolkit and application processing
        /// of the frame.
        ///
        /// The frame is repainted. GDK normally handles this internally and
        /// emits `gdk.Surface.signals.render` signals which are turned into
        /// [GtkWidget::snapshot](../gtk4/signal.Widget.snapshot.html) signals
        /// by GTK.
        pub const paint = struct {
            pub const name = "paint";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("paint", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted after processing of the frame is finished.
        ///
        /// This signal is handled internally by GTK to resume normal
        /// event processing. Applications should not handle this signal.
        pub const resume_events = struct {
            pub const name = "resume-events";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("resume-events", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted as the first step of toolkit and application processing
        /// of the frame.
        ///
        /// Animations should be updated using `gdk.FrameClock.getFrameTime`.
        /// Applications can connect directly to this signal, or use
        /// [`gtk_widget_add_tick_callback`](../gtk4/method.Widget.add_tick_callback.html)
        /// as a more convenient interface.
        pub const update = struct {
            pub const name = "update";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("update", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Starts updates for an animation.
    ///
    /// Until a matching call to `gdk.FrameClock.endUpdating` is made,
    /// the frame clock will continually request a new frame with the
    /// `GDK_FRAME_CLOCK_PHASE_UPDATE` phase. This function may be called multiple
    /// times and frames will be requested until `gdk.FrameClock.endUpdating`
    /// is called the same number of times.
    extern fn gdk_frame_clock_begin_updating(p_frame_clock: *FrameClock) void;
    pub const beginUpdating = gdk_frame_clock_begin_updating;

    /// Stops updates for an animation.
    ///
    /// See the documentation for `gdk.FrameClock.beginUpdating`.
    extern fn gdk_frame_clock_end_updating(p_frame_clock: *FrameClock) void;
    pub const endUpdating = gdk_frame_clock_end_updating;

    /// Gets the frame timings for the current frame.
    extern fn gdk_frame_clock_get_current_timings(p_frame_clock: *FrameClock) ?*gdk.FrameTimings;
    pub const getCurrentTimings = gdk_frame_clock_get_current_timings;

    /// Calculates the current frames-per-second, based on the
    /// frame timings of `frame_clock`.
    extern fn gdk_frame_clock_get_fps(p_frame_clock: *FrameClock) f64;
    pub const getFps = gdk_frame_clock_get_fps;

    /// `GdkFrameClock` maintains a 64-bit counter that increments for
    /// each frame drawn.
    extern fn gdk_frame_clock_get_frame_counter(p_frame_clock: *FrameClock) i64;
    pub const getFrameCounter = gdk_frame_clock_get_frame_counter;

    /// Gets the time that should currently be used for animations.
    ///
    /// Inside the processing of a frame, it’s the time used to compute the
    /// animation position of everything in a frame. Outside of a frame, it's
    /// the time of the conceptual “previous frame,” which may be either
    /// the actual previous frame time, or if that’s too old, an updated
    /// time.
    extern fn gdk_frame_clock_get_frame_time(p_frame_clock: *FrameClock) i64;
    pub const getFrameTime = gdk_frame_clock_get_frame_time;

    /// Returns the frame counter for the oldest frame available in history.
    ///
    /// `GdkFrameClock` internally keeps a history of `GdkFrameTimings`
    /// objects for recent frames that can be retrieved with
    /// `gdk.FrameClock.getTimings`. The set of stored frames
    /// is the set from the counter values given by
    /// `gdk.FrameClock.getHistoryStart` and
    /// `gdk.FrameClock.getFrameCounter`, inclusive.
    extern fn gdk_frame_clock_get_history_start(p_frame_clock: *FrameClock) i64;
    pub const getHistoryStart = gdk_frame_clock_get_history_start;

    /// Predicts a presentation time, based on history.
    ///
    /// Using the frame history stored in the frame clock, finds the last
    /// known presentation time and refresh interval, and assuming that
    /// presentation times are separated by the refresh interval,
    /// predicts a presentation time that is a multiple of the refresh
    /// interval after the last presentation time, and later than `base_time`.
    extern fn gdk_frame_clock_get_refresh_info(p_frame_clock: *FrameClock, p_base_time: i64, p_refresh_interval_return: ?*i64, p_presentation_time_return: *i64) void;
    pub const getRefreshInfo = gdk_frame_clock_get_refresh_info;

    /// Retrieves a `GdkFrameTimings` object holding timing information
    /// for the current frame or a recent frame.
    ///
    /// The `GdkFrameTimings` object may not yet be complete: see
    /// `gdk.FrameTimings.getComplete` and
    /// `gdk.FrameClock.getHistoryStart`.
    extern fn gdk_frame_clock_get_timings(p_frame_clock: *FrameClock, p_frame_counter: i64) ?*gdk.FrameTimings;
    pub const getTimings = gdk_frame_clock_get_timings;

    /// Asks the frame clock to run a particular phase.
    ///
    /// The signal corresponding the requested phase will be emitted the next
    /// time the frame clock processes. Multiple calls to
    /// `gdk.FrameClock.requestPhase` will be combined together
    /// and only one frame processed. If you are displaying animated
    /// content and want to continually request the
    /// `GDK_FRAME_CLOCK_PHASE_UPDATE` phase for a period of time,
    /// you should use `gdk.FrameClock.beginUpdating` instead,
    /// since this allows GTK to adjust system parameters to get maximally
    /// smooth animations.
    extern fn gdk_frame_clock_request_phase(p_frame_clock: *FrameClock, p_phase: gdk.FrameClockPhase) void;
    pub const requestPhase = gdk_frame_clock_request_phase;

    extern fn gdk_frame_clock_get_type() usize;
    pub const getGObjectType = gdk_frame_clock_get_type;

    extern fn g_object_ref(p_self: *gdk.FrameClock) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.FrameClock) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FrameClock, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a platform-specific OpenGL draw context.
///
/// `GdkGLContext`s are created for a surface using
/// `gdk.Surface.createGlContext`, and the context will match
/// the characteristics of the surface.
///
/// A `GdkGLContext` is not tied to any particular normal framebuffer.
/// For instance, it cannot draw to the surface back buffer. The GDK
/// repaint system is in full control of the painting to that. Instead,
/// you can create render buffers or textures and use `cairoDrawFromGl`
/// in the draw function of your widget to draw them. Then GDK will handle
/// the integration of your rendering with that of other widgets.
///
/// Support for `GdkGLContext` is platform-specific and context creation
/// can fail, returning `NULL` context.
///
/// A `GdkGLContext` has to be made "current" in order to start using
/// it, otherwise any OpenGL call will be ignored.
///
/// ## Creating a new OpenGL context
///
/// In order to create a new `GdkGLContext` instance you need a `GdkSurface`,
/// which you typically get during the realize call of a widget.
///
/// A `GdkGLContext` is not realized until either `gdk.GLContext.makeCurrent`
/// or `gdk.GLContext.realize` is called. It is possible to specify
/// details of the GL context like the OpenGL version to be used, or whether
/// the GL context should have extra state validation enabled after calling
/// `gdk.Surface.createGlContext` by calling `gdk.GLContext.realize`.
/// If the realization fails you have the option to change the settings of
/// the `GdkGLContext` and try again.
///
/// ## Using a GdkGLContext
///
/// You will need to make the `GdkGLContext` the current context before issuing
/// OpenGL calls; the system sends OpenGL commands to whichever context is current.
/// It is possible to have multiple contexts, so you always need to ensure that
/// the one which you want to draw with is the current one before issuing commands:
///
/// ```c
/// gdk_gl_context_make_current (context);
/// ```
///
/// You can now perform your drawing using OpenGL commands.
///
/// You can check which `GdkGLContext` is the current one by using
/// `gdk.GLContext.getCurrent`; you can also unset any `GdkGLContext`
/// that is currently set by calling `gdk.GLContext.clearCurrent`.
pub const GLContext = opaque {
    pub const Parent = gdk.DrawContext;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = GLContext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The allowed APIs.
        pub const allowed_apis = struct {
            pub const name = "allowed-apis";

            pub const Type = gdk.GLAPI;
        };

        /// The API currently in use.
        pub const api = struct {
            pub const name = "api";

            pub const Type = gdk.GLAPI;
        };

        /// Always `NULL`
        ///
        /// As many contexts can share data now and no single shared context exists
        /// anymore, this function has been deprecated and now always returns `NULL`.
        pub const shared_context = struct {
            pub const name = "shared-context";

            pub const Type = ?*gdk.GLContext;
        };
    };

    pub const signals = struct {};

    /// Clears the current `GdkGLContext`.
    ///
    /// Any OpenGL call after this function returns will be ignored
    /// until `gdk.GLContext.makeCurrent` is called.
    extern fn gdk_gl_context_clear_current() void;
    pub const clearCurrent = gdk_gl_context_clear_current;

    /// Retrieves the current `GdkGLContext`.
    extern fn gdk_gl_context_get_current() ?*gdk.GLContext;
    pub const getCurrent = gdk_gl_context_get_current;

    /// Gets the allowed APIs set via `gdk.GLContext.setAllowedApis`.
    extern fn gdk_gl_context_get_allowed_apis(p_self: *GLContext) gdk.GLAPI;
    pub const getAllowedApis = gdk_gl_context_get_allowed_apis;

    /// Gets the API currently in use.
    ///
    /// If the renderer has not been realized yet, 0 is returned.
    extern fn gdk_gl_context_get_api(p_self: *GLContext) gdk.GLAPI;
    pub const getApi = gdk_gl_context_get_api;

    /// Retrieves whether the context is doing extra validations and runtime checking.
    ///
    /// See `gdk.GLContext.setDebugEnabled`.
    extern fn gdk_gl_context_get_debug_enabled(p_context: *GLContext) c_int;
    pub const getDebugEnabled = gdk_gl_context_get_debug_enabled;

    /// Retrieves the display the `context` is created for
    extern fn gdk_gl_context_get_display(p_context: *GLContext) ?*gdk.Display;
    pub const getDisplay = gdk_gl_context_get_display;

    /// Retrieves whether the context is forward-compatible.
    ///
    /// See `gdk.GLContext.setForwardCompatible`.
    extern fn gdk_gl_context_get_forward_compatible(p_context: *GLContext) c_int;
    pub const getForwardCompatible = gdk_gl_context_get_forward_compatible;

    /// Retrieves required OpenGL version set as a requirement for the `context`
    /// realization. It will not change even if a greater OpenGL version is supported
    /// and used after the `context` is realized. See
    /// `gdk.GLContext.getVersion` for the real version in use.
    ///
    /// See `gdk.GLContext.setRequiredVersion`.
    extern fn gdk_gl_context_get_required_version(p_context: *GLContext, p_major: ?*c_int, p_minor: ?*c_int) void;
    pub const getRequiredVersion = gdk_gl_context_get_required_version;

    /// Used to retrieves the `GdkGLContext` that this `context` share data with.
    ///
    /// As many contexts can share data now and no single shared context exists
    /// anymore, this function has been deprecated and now always returns `NULL`.
    extern fn gdk_gl_context_get_shared_context(p_context: *GLContext) ?*gdk.GLContext;
    pub const getSharedContext = gdk_gl_context_get_shared_context;

    /// Retrieves the surface used by the `context`.
    extern fn gdk_gl_context_get_surface(p_context: *GLContext) ?*gdk.Surface;
    pub const getSurface = gdk_gl_context_get_surface;

    /// Checks whether the `context` is using an OpenGL or OpenGL ES profile.
    extern fn gdk_gl_context_get_use_es(p_context: *GLContext) c_int;
    pub const getUseEs = gdk_gl_context_get_use_es;

    /// Retrieves the OpenGL version of the `context`.
    ///
    /// The `context` must be realized prior to calling this function.
    extern fn gdk_gl_context_get_version(p_context: *GLContext, p_major: *c_int, p_minor: *c_int) void;
    pub const getVersion = gdk_gl_context_get_version;

    /// Whether the `GdkGLContext` is in legacy mode or not.
    ///
    /// The `GdkGLContext` must be realized before calling this function.
    ///
    /// When realizing a GL context, GDK will try to use the OpenGL 3.2 core
    /// profile; this profile removes all the OpenGL API that was deprecated
    /// prior to the 3.2 version of the specification. If the realization is
    /// successful, this function will return `FALSE`.
    ///
    /// If the underlying OpenGL implementation does not support core profiles,
    /// GDK will fall back to a pre-3.2 compatibility profile, and this function
    /// will return `TRUE`.
    ///
    /// You can use the value returned by this function to decide which kind
    /// of OpenGL API to use, or whether to do extension discovery, or what
    /// kind of shader programs to load.
    extern fn gdk_gl_context_is_legacy(p_context: *GLContext) c_int;
    pub const isLegacy = gdk_gl_context_is_legacy;

    /// Checks if the two GL contexts can share resources.
    ///
    /// When they can, the texture IDs from `other` can be used in `self`. This
    /// is particularly useful when passing `GdkGLTexture` objects between
    /// different contexts.
    ///
    /// Contexts created for the same display with the same properties will
    /// always be compatible, even if they are created for different surfaces.
    /// For other contexts it depends on the GL backend.
    ///
    /// Both contexts must be realized for this check to succeed. If either one
    /// is not, this function will return `FALSE`.
    extern fn gdk_gl_context_is_shared(p_self: *GLContext, p_other: *gdk.GLContext) c_int;
    pub const isShared = gdk_gl_context_is_shared;

    /// Makes the `context` the current one.
    extern fn gdk_gl_context_make_current(p_context: *GLContext) void;
    pub const makeCurrent = gdk_gl_context_make_current;

    /// Realizes the given `GdkGLContext`.
    ///
    /// It is safe to call this function on a realized `GdkGLContext`.
    extern fn gdk_gl_context_realize(p_context: *GLContext, p_error: ?*?*glib.Error) c_int;
    pub const realize = gdk_gl_context_realize;

    /// Sets the allowed APIs. When `gdk.GLContext.realize` is called, only the
    /// allowed APIs will be tried. If you set this to 0, realizing will always fail.
    ///
    /// If you set it on a realized context, the property will not have any effect.
    /// It is only relevant during `gdk.GLContext.realize`.
    ///
    /// By default, all APIs are allowed.
    extern fn gdk_gl_context_set_allowed_apis(p_self: *GLContext, p_apis: gdk.GLAPI) void;
    pub const setAllowedApis = gdk_gl_context_set_allowed_apis;

    /// Sets whether the `GdkGLContext` should perform extra validations and
    /// runtime checking.
    ///
    /// This is useful during development, but has additional overhead.
    ///
    /// The `GdkGLContext` must not be realized or made current prior to
    /// calling this function.
    extern fn gdk_gl_context_set_debug_enabled(p_context: *GLContext, p_enabled: c_int) void;
    pub const setDebugEnabled = gdk_gl_context_set_debug_enabled;

    /// Sets whether the `GdkGLContext` should be forward-compatible.
    ///
    /// Forward-compatible contexts must not support OpenGL functionality that
    /// has been marked as deprecated in the requested version; non-forward
    /// compatible contexts, on the other hand, must support both deprecated and
    /// non deprecated functionality.
    ///
    /// The `GdkGLContext` must not be realized or made current prior to calling
    /// this function.
    extern fn gdk_gl_context_set_forward_compatible(p_context: *GLContext, p_compatible: c_int) void;
    pub const setForwardCompatible = gdk_gl_context_set_forward_compatible;

    /// Sets the major and minor version of OpenGL to request.
    ///
    /// Setting `major` and `minor` to zero will use the default values.
    ///
    /// Setting `major` and `minor` lower than the minimum versions required
    /// by GTK will result in the context choosing the minimum version.
    ///
    /// The `context` must not be realized or made current prior to calling
    /// this function.
    extern fn gdk_gl_context_set_required_version(p_context: *GLContext, p_major: c_int, p_minor: c_int) void;
    pub const setRequiredVersion = gdk_gl_context_set_required_version;

    /// Requests that GDK create an OpenGL ES context instead of an OpenGL one.
    ///
    /// Not all platforms support OpenGL ES.
    ///
    /// The `context` must not have been realized.
    ///
    /// By default, GDK will attempt to automatically detect whether the
    /// underlying GL implementation is OpenGL or OpenGL ES once the `context`
    /// is realized.
    ///
    /// You should check the return value of `gdk.GLContext.getUseEs`
    /// after calling `gdk.GLContext.realize` to decide whether to use
    /// the OpenGL or OpenGL ES API, extensions, or shaders.
    extern fn gdk_gl_context_set_use_es(p_context: *GLContext, p_use_es: c_int) void;
    pub const setUseEs = gdk_gl_context_set_use_es;

    extern fn gdk_gl_context_get_type() usize;
    pub const getGObjectType = gdk_gl_context_get_type;

    extern fn g_object_ref(p_self: *gdk.GLContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.GLContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GLContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GdkTexture` representing a GL texture object.
pub const GLTexture = opaque {
    pub const Parent = gdk.Texture;
    pub const Implements = [_]type{ gdk.Paintable, gio.Icon, gio.LoadableIcon };
    pub const Class = gdk.GLTextureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new texture for an existing GL texture.
    ///
    /// Note that the GL texture must not be modified until `destroy` is called,
    /// which will happen when the GdkTexture object is finalized, or due to
    /// an explicit call of `gdk.GLTexture.release`.
    extern fn gdk_gl_texture_new(p_context: *gdk.GLContext, p_id: c_uint, p_width: c_int, p_height: c_int, p_destroy: glib.DestroyNotify, p_data: ?*anyopaque) *gdk.GLTexture;
    pub const new = gdk_gl_texture_new;

    /// Releases the GL resources held by a `GdkGLTexture`.
    ///
    /// The texture contents are still available via the
    /// `gdk.Texture.download` function, after this
    /// function has been called.
    extern fn gdk_gl_texture_release(p_self: *GLTexture) void;
    pub const release = gdk_gl_texture_release;

    extern fn gdk_gl_texture_get_type() usize;
    pub const getGObjectType = gdk_gl_texture_get_type;

    extern fn g_object_ref(p_self: *gdk.GLTexture) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.GLTexture) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GLTexture, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Constructs `gdk.Texture` objects from GL textures.
///
/// The operation is quite simple: Create a texture builder, set all the necessary
/// properties - keep in mind that the properties `gdk.GLTextureBuilder.properties.context`,
/// `gdk.GLTextureBuilder.properties.id`, `gdk.GLTextureBuilder.properties.width`, and
/// `gdk.GLTextureBuilder.properties.height` are mandatory - and then call
/// `gdk.GLTextureBuilder.build` to create the new texture.
///
/// `GdkGLTextureBuilder` can be used for quick one-shot construction of
/// textures as well as kept around and reused to construct multiple textures.
pub const GLTextureBuilder = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.GLTextureBuilderClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The color state of the texture.
        pub const color_state = struct {
            pub const name = "color-state";

            pub const Type = ?*gdk.ColorState;
        };

        /// The context owning the texture.
        pub const context = struct {
            pub const name = "context";

            pub const Type = ?*gdk.GLContext;
        };

        /// The format when downloading the texture.
        pub const format = struct {
            pub const name = "format";

            pub const Type = gdk.MemoryFormat;
        };

        /// If the texture has a mipmap.
        pub const has_mipmap = struct {
            pub const name = "has-mipmap";

            pub const Type = c_int;
        };

        /// The height of the texture.
        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        /// The texture ID to use.
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_uint;
        };

        /// An optional `GLSync` object.
        ///
        /// If this is set, GTK will wait on it before using the texture.
        pub const sync = struct {
            pub const name = "sync";

            pub const Type = ?*anyopaque;
        };

        /// The update region for `gdk.GLTextureBuilder.properties.update_texture`.
        pub const update_region = struct {
            pub const name = "update-region";

            pub const Type = ?*cairo.Region;
        };

        /// The texture `gdk.GLTextureBuilder.properties.update_region` is an update for.
        pub const update_texture = struct {
            pub const name = "update-texture";

            pub const Type = ?*gdk.Texture;
        };

        /// The width of the texture.
        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new texture builder.
    extern fn gdk_gl_texture_builder_new() *gdk.GLTextureBuilder;
    pub const new = gdk_gl_texture_builder_new;

    /// Builds a new `GdkTexture` with the values set up in the builder.
    ///
    /// The `destroy` function gets called when the returned texture gets released;
    /// either when the texture is finalized or by an explicit call to
    /// `gdk.GLTexture.release`. It should release all GL resources associated
    /// with the texture, such as the `gdk.GLTextureBuilder.properties.id` and the
    /// `gdk.GLTextureBuilder.properties.sync`.
    ///
    /// Note that it is a programming error to call this function if any mandatory
    /// property has not been set.
    ///
    /// It is possible to call this function multiple times to create multiple textures,
    /// possibly with changing properties in between.
    extern fn gdk_gl_texture_builder_build(p_self: *GLTextureBuilder, p_destroy: ?glib.DestroyNotify, p_data: ?*anyopaque) *gdk.Texture;
    pub const build = gdk_gl_texture_builder_build;

    /// Gets the color state previously set via `gdk.GLTextureBuilder.setColorState`.
    extern fn gdk_gl_texture_builder_get_color_state(p_self: *GLTextureBuilder) *gdk.ColorState;
    pub const getColorState = gdk_gl_texture_builder_get_color_state;

    /// Gets the context previously set via `gdk.GLTextureBuilder.setContext` or
    /// `NULL` if none was set.
    extern fn gdk_gl_texture_builder_get_context(p_self: *GLTextureBuilder) ?*gdk.GLContext;
    pub const getContext = gdk_gl_texture_builder_get_context;

    /// Gets the format previously set via `gdk.GLTextureBuilder.setFormat`.
    extern fn gdk_gl_texture_builder_get_format(p_self: *GLTextureBuilder) gdk.MemoryFormat;
    pub const getFormat = gdk_gl_texture_builder_get_format;

    /// Gets whether the texture has a mipmap.
    extern fn gdk_gl_texture_builder_get_has_mipmap(p_self: *GLTextureBuilder) c_int;
    pub const getHasMipmap = gdk_gl_texture_builder_get_has_mipmap;

    /// Gets the height previously set via `gdk.GLTextureBuilder.setHeight` or
    /// 0 if the height wasn't set.
    extern fn gdk_gl_texture_builder_get_height(p_self: *GLTextureBuilder) c_int;
    pub const getHeight = gdk_gl_texture_builder_get_height;

    /// Gets the texture id previously set via `gdk.GLTextureBuilder.setId` or
    /// 0 if the id wasn't set.
    extern fn gdk_gl_texture_builder_get_id(p_self: *GLTextureBuilder) c_uint;
    pub const getId = gdk_gl_texture_builder_get_id;

    /// Gets the `GLsync` previously set via `gdk.GLTextureBuilder.setSync`.
    extern fn gdk_gl_texture_builder_get_sync(p_self: *GLTextureBuilder) ?*anyopaque;
    pub const getSync = gdk_gl_texture_builder_get_sync;

    /// Gets the region previously set via `gdk.GLTextureBuilder.setUpdateRegion` or
    /// `NULL` if none was set.
    extern fn gdk_gl_texture_builder_get_update_region(p_self: *GLTextureBuilder) ?*cairo.Region;
    pub const getUpdateRegion = gdk_gl_texture_builder_get_update_region;

    /// Gets the texture previously set via `gdk.GLTextureBuilder.setUpdateTexture` or
    /// `NULL` if none was set.
    extern fn gdk_gl_texture_builder_get_update_texture(p_self: *GLTextureBuilder) ?*gdk.Texture;
    pub const getUpdateTexture = gdk_gl_texture_builder_get_update_texture;

    /// Gets the width previously set via `gdk.GLTextureBuilder.setWidth` or
    /// 0 if the width wasn't set.
    extern fn gdk_gl_texture_builder_get_width(p_self: *GLTextureBuilder) c_int;
    pub const getWidth = gdk_gl_texture_builder_get_width;

    /// Sets the color state for the texture.
    ///
    /// By default, the sRGB colorstate is used. If you don't know what
    /// colorstates are, this is probably the right thing.
    extern fn gdk_gl_texture_builder_set_color_state(p_self: *GLTextureBuilder, p_color_state: *gdk.ColorState) void;
    pub const setColorState = gdk_gl_texture_builder_set_color_state;

    /// Sets the context to be used for the texture. This is the context that owns
    /// the texture.
    ///
    /// The context must be set before calling `gdk.GLTextureBuilder.build`.
    extern fn gdk_gl_texture_builder_set_context(p_self: *GLTextureBuilder, p_context: ?*gdk.GLContext) void;
    pub const setContext = gdk_gl_texture_builder_set_context;

    /// Sets the format of the texture. The default is `GDK_MEMORY_R8G8B8A8_PREMULTIPLIED`.
    ///
    /// The format is the preferred format the texture data should be downloaded to. The
    /// format must be supported by the GL version of `gdk.GLTextureBuilder.properties.context`.
    ///
    /// GDK's texture download code assumes that the format corresponds to the storage
    /// parameters of the GL texture in an obvious way. For example, a format of
    /// `GDK_MEMORY_R16G16B16A16_PREMULTIPLIED` is expected to be stored as `GL_RGBA16`
    /// texture, and `GDK_MEMORY_G8A8` is expected to be stored as `GL_RG8` texture.
    ///
    /// Setting the right format is particularly useful when using high bit depth textures
    /// to preserve the bit depth, to set the correct value for unpremultiplied textures
    /// and to make sure opaque textures are treated as such.
    ///
    /// Non-RGBA textures need to have swizzling parameters set up properly to be usable
    /// in GSK's shaders.
    extern fn gdk_gl_texture_builder_set_format(p_self: *GLTextureBuilder, p_format: gdk.MemoryFormat) void;
    pub const setFormat = gdk_gl_texture_builder_set_format;

    /// Sets whether the texture has a mipmap. This allows the renderer and other users of the
    /// generated texture to use a higher quality downscaling.
    ///
    /// Typically, the `glGenerateMipmap` function is used to generate a mimap.
    extern fn gdk_gl_texture_builder_set_has_mipmap(p_self: *GLTextureBuilder, p_has_mipmap: c_int) void;
    pub const setHasMipmap = gdk_gl_texture_builder_set_has_mipmap;

    /// Sets the height of the texture.
    ///
    /// The height must be set before calling `gdk.GLTextureBuilder.build`.
    extern fn gdk_gl_texture_builder_set_height(p_self: *GLTextureBuilder, p_height: c_int) void;
    pub const setHeight = gdk_gl_texture_builder_set_height;

    /// Sets the texture id of the texture. The texture id must remain unmodified
    /// until the texture was finalized. See `gdk.GLTextureBuilder.build`
    /// for a longer discussion.
    ///
    /// The id must be set before calling `gdk.GLTextureBuilder.build`.
    extern fn gdk_gl_texture_builder_set_id(p_self: *GLTextureBuilder, p_id: c_uint) void;
    pub const setId = gdk_gl_texture_builder_set_id;

    /// Sets the GLSync object to use for the texture.
    ///
    /// GTK will wait on this object before using the created `GdkTexture`.
    ///
    /// The `destroy` function that is passed to `gdk.GLTextureBuilder.build`
    /// is responsible for freeing the sync object when it is no longer needed.
    /// The texture builder does not destroy it and it is the callers
    /// responsibility to make sure it doesn't leak.
    extern fn gdk_gl_texture_builder_set_sync(p_self: *GLTextureBuilder, p_sync: ?*anyopaque) void;
    pub const setSync = gdk_gl_texture_builder_set_sync;

    /// Sets the region to be updated by this texture. Together with
    /// `gdk.GLTextureBuilder.properties.update_texture` this describes an
    /// update of a previous texture.
    ///
    /// When rendering animations of large textures, it is possible that
    /// consecutive textures are only updating contents in parts of the texture.
    /// It is then possible to describe this update via these two properties,
    /// so that GTK can avoid rerendering parts that did not change.
    ///
    /// An example would be a screen recording where only the mouse pointer moves.
    extern fn gdk_gl_texture_builder_set_update_region(p_self: *GLTextureBuilder, p_region: ?*cairo.Region) void;
    pub const setUpdateRegion = gdk_gl_texture_builder_set_update_region;

    /// Sets the texture to be updated by this texture. See
    /// `gdk.GLTextureBuilder.setUpdateRegion` for an explanation.
    extern fn gdk_gl_texture_builder_set_update_texture(p_self: *GLTextureBuilder, p_texture: ?*gdk.Texture) void;
    pub const setUpdateTexture = gdk_gl_texture_builder_set_update_texture;

    /// Sets the width of the texture.
    ///
    /// The width must be set before calling `gdk.GLTextureBuilder.build`.
    extern fn gdk_gl_texture_builder_set_width(p_self: *GLTextureBuilder, p_width: c_int) void;
    pub const setWidth = gdk_gl_texture_builder_set_width;

    extern fn gdk_gl_texture_builder_get_type() usize;
    pub const getGObjectType = gdk_gl_texture_builder_get_type;

    extern fn g_object_ref(p_self: *gdk.GLTextureBuilder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.GLTextureBuilder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GLTextureBuilder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a broken windowing system grab.
pub const GrabBrokenEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = GrabBrokenEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts the grab surface from a grab broken event.
    extern fn gdk_grab_broken_event_get_grab_surface(p_event: *GrabBrokenEvent) *gdk.Surface;
    pub const getGrabSurface = gdk_grab_broken_event_get_grab_surface;

    /// Checks whether the grab broken event is for an implicit grab.
    extern fn gdk_grab_broken_event_get_implicit(p_event: *GrabBrokenEvent) c_int;
    pub const getImplicit = gdk_grab_broken_event_get_implicit;

    extern fn gdk_grab_broken_event_get_type() usize;
    pub const getGObjectType = gdk_grab_broken_event_get_type;

    pub fn as(p_instance: *GrabBrokenEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a key-based device.
pub const KeyEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = KeyEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts the consumed modifiers from a key event.
    extern fn gdk_key_event_get_consumed_modifiers(p_event: *KeyEvent) gdk.ModifierType;
    pub const getConsumedModifiers = gdk_key_event_get_consumed_modifiers;

    /// Extracts the keycode from a key event.
    extern fn gdk_key_event_get_keycode(p_event: *KeyEvent) c_uint;
    pub const getKeycode = gdk_key_event_get_keycode;

    /// Extracts the keyval from a key event.
    extern fn gdk_key_event_get_keyval(p_event: *KeyEvent) c_uint;
    pub const getKeyval = gdk_key_event_get_keyval;

    /// Extracts the layout from a key event.
    extern fn gdk_key_event_get_layout(p_event: *KeyEvent) c_uint;
    pub const getLayout = gdk_key_event_get_layout;

    /// Extracts the shift level from a key event.
    extern fn gdk_key_event_get_level(p_event: *KeyEvent) c_uint;
    pub const getLevel = gdk_key_event_get_level;

    /// Gets a keyval and modifier combination that will match
    /// the event.
    ///
    /// See `gdk.KeyEvent.matches`.
    extern fn gdk_key_event_get_match(p_event: *KeyEvent, p_keyval: *c_uint, p_modifiers: *gdk.ModifierType) c_int;
    pub const getMatch = gdk_key_event_get_match;

    /// Extracts whether the key event is for a modifier key.
    extern fn gdk_key_event_is_modifier(p_event: *KeyEvent) c_int;
    pub const isModifier = gdk_key_event_is_modifier;

    /// Matches a key event against a keyval and modifiers.
    ///
    /// This is typically used to trigger keyboard shortcuts such as Ctrl-C.
    ///
    /// Partial matches are possible where the combination matches
    /// if the currently active group is ignored.
    ///
    /// Note that we ignore Caps Lock for matching.
    extern fn gdk_key_event_matches(p_event: *KeyEvent, p_keyval: c_uint, p_modifiers: gdk.ModifierType) gdk.KeyMatch;
    pub const matches = gdk_key_event_matches;

    extern fn gdk_key_event_get_type() usize;
    pub const getGObjectType = gdk_key_event_get_type;

    pub fn as(p_instance: *KeyEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GdkTexture` representing image data in memory.
pub const MemoryTexture = opaque {
    pub const Parent = gdk.Texture;
    pub const Implements = [_]type{ gdk.Paintable, gio.Icon, gio.LoadableIcon };
    pub const Class = gdk.MemoryTextureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new texture for a blob of image data.
    ///
    /// The `GBytes` must contain `stride` × `height` pixels
    /// in the given format.
    extern fn gdk_memory_texture_new(p_width: c_int, p_height: c_int, p_format: gdk.MemoryFormat, p_bytes: *glib.Bytes, p_stride: usize) *gdk.MemoryTexture;
    pub const new = gdk_memory_texture_new;

    extern fn gdk_memory_texture_get_type() usize;
    pub const getGObjectType = gdk_memory_texture_get_type;

    extern fn g_object_ref(p_self: *gdk.MemoryTexture) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.MemoryTexture) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MemoryTexture, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Constructs `gdk.Texture` objects from system memory provided
/// via `glib.Bytes`.
///
/// The operation is quite simple: Create a texture builder, set all the necessary
/// properties - keep in mind that the properties `gdk.MemoryTextureBuilder.properties.bytes`,
/// `gdk.MemoryTextureBuilder.properties.stride`, `gdk.MemoryTextureBuilder.properties.width`,
/// and `gdk.MemoryTextureBuilder.properties.height` are mandatory - and then call
/// `gdk.MemoryTextureBuilder.build` to create the new texture.
///
/// `GdkMemoryTextureBuilder` can be used for quick one-shot construction of
/// textures as well as kept around and reused to construct multiple textures.
pub const MemoryTextureBuilder = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.MemoryTextureBuilderClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The bytes holding the data.
        pub const bytes = struct {
            pub const name = "bytes";

            pub const Type = ?*glib.Bytes;
        };

        /// The colorstate describing the data.
        pub const color_state = struct {
            pub const name = "color-state";

            pub const Type = ?*gdk.ColorState;
        };

        /// The format of the data.
        pub const format = struct {
            pub const name = "format";

            pub const Type = gdk.MemoryFormat;
        };

        /// The height of the texture.
        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        /// The rowstride of the texture.
        ///
        /// The rowstride is the number of bytes between the first pixel
        /// in a row of image data, and the first pixel in the next row.
        pub const stride = struct {
            pub const name = "stride";

            pub const Type = u64;
        };

        /// The update region for `gdk.MemoryTextureBuilder.properties.update_texture`.
        pub const update_region = struct {
            pub const name = "update-region";

            pub const Type = ?*cairo.Region;
        };

        /// The texture `gdk.MemoryTextureBuilder.properties.update_region` is an update for.
        pub const update_texture = struct {
            pub const name = "update-texture";

            pub const Type = ?*gdk.Texture;
        };

        /// The width of the texture.
        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new texture builder.
    extern fn gdk_memory_texture_builder_new() *gdk.MemoryTextureBuilder;
    pub const new = gdk_memory_texture_builder_new;

    /// Builds a new `GdkTexture` with the values set up in the builder.
    ///
    /// Note that it is a programming error to call this function if any mandatory
    /// property has not been set.
    ///
    /// It is possible to call this function multiple times to create multiple textures,
    /// possibly with changing properties in between.
    extern fn gdk_memory_texture_builder_build(p_self: *MemoryTextureBuilder) *gdk.Texture;
    pub const build = gdk_memory_texture_builder_build;

    /// Gets the bytes previously set via `gdk.MemoryTextureBuilder.setBytes`
    /// or `NULL` if none was set.
    extern fn gdk_memory_texture_builder_get_bytes(p_self: *MemoryTextureBuilder) ?*glib.Bytes;
    pub const getBytes = gdk_memory_texture_builder_get_bytes;

    /// Gets the colorstate previously set via `gdk.MemoryTextureBuilder.setColorState`.
    extern fn gdk_memory_texture_builder_get_color_state(p_self: *MemoryTextureBuilder) *gdk.ColorState;
    pub const getColorState = gdk_memory_texture_builder_get_color_state;

    /// Gets the format previously set via `gdk.MemoryTextureBuilder.setFormat`.
    extern fn gdk_memory_texture_builder_get_format(p_self: *MemoryTextureBuilder) gdk.MemoryFormat;
    pub const getFormat = gdk_memory_texture_builder_get_format;

    /// Gets the height previously set via `gdk.MemoryTextureBuilder.setHeight`
    /// or 0 if the height wasn't set.
    extern fn gdk_memory_texture_builder_get_height(p_self: *MemoryTextureBuilder) c_int;
    pub const getHeight = gdk_memory_texture_builder_get_height;

    /// Gets the stride previously set via `gdk.MemoryTextureBuilder.setStride`.
    extern fn gdk_memory_texture_builder_get_stride(p_self: *MemoryTextureBuilder) usize;
    pub const getStride = gdk_memory_texture_builder_get_stride;

    /// Gets the region previously set via `gdk.MemoryTextureBuilder.setUpdateRegion`
    /// or `NULL` if none was set.
    extern fn gdk_memory_texture_builder_get_update_region(p_self: *MemoryTextureBuilder) ?*cairo.Region;
    pub const getUpdateRegion = gdk_memory_texture_builder_get_update_region;

    /// Gets the texture previously set via `gdk.MemoryTextureBuilder.setUpdateTexture`
    /// or `NULL` if none was set.
    extern fn gdk_memory_texture_builder_get_update_texture(p_self: *MemoryTextureBuilder) ?*gdk.Texture;
    pub const getUpdateTexture = gdk_memory_texture_builder_get_update_texture;

    /// Gets the width previously set via `gdk.MemoryTextureBuilder.setWidth`
    /// or 0 if the width wasn't set.
    extern fn gdk_memory_texture_builder_get_width(p_self: *MemoryTextureBuilder) c_int;
    pub const getWidth = gdk_memory_texture_builder_get_width;

    /// Sets the data to be shown but the texture.
    ///
    /// The bytes must be set before calling `gdk.MemoryTextureBuilder.build`.
    extern fn gdk_memory_texture_builder_set_bytes(p_self: *MemoryTextureBuilder, p_bytes: ?*glib.Bytes) void;
    pub const setBytes = gdk_memory_texture_builder_set_bytes;

    /// Sets the colorstate describing the data.
    ///
    /// By default, the sRGB colorstate is used. If you don't know
    /// what colorstates are, this is probably the right thing.
    extern fn gdk_memory_texture_builder_set_color_state(p_self: *MemoryTextureBuilder, p_color_state: *gdk.ColorState) void;
    pub const setColorState = gdk_memory_texture_builder_set_color_state;

    /// Sets the format of the bytes.
    ///
    /// The default is `GDK_MEMORY_R8G8B8A8_PREMULTIPLIED`.
    extern fn gdk_memory_texture_builder_set_format(p_self: *MemoryTextureBuilder, p_format: gdk.MemoryFormat) void;
    pub const setFormat = gdk_memory_texture_builder_set_format;

    /// Sets the height of the texture.
    ///
    /// The height must be set before calling `gdk.MemoryTextureBuilder.build`.
    extern fn gdk_memory_texture_builder_set_height(p_self: *MemoryTextureBuilder, p_height: c_int) void;
    pub const setHeight = gdk_memory_texture_builder_set_height;

    /// Sets the rowstride of the bytes used.
    ///
    /// The rowstride must be set before calling `gdk.MemoryTextureBuilder.build`.
    extern fn gdk_memory_texture_builder_set_stride(p_self: *MemoryTextureBuilder, p_stride: usize) void;
    pub const setStride = gdk_memory_texture_builder_set_stride;

    /// Sets the region to be updated by this texture.
    ///
    /// Together with `gdk.MemoryTextureBuilder.properties.update_texture`,
    /// this describes an update of a previous texture.
    ///
    /// When rendering animations of large textures, it is possible that
    /// consecutive textures are only updating contents in parts of the texture.
    /// It is then possible to describe this update via these two properties,
    /// so that GTK can avoid rerendering parts that did not change.
    ///
    /// An example would be a screen recording where only the mouse pointer moves.
    extern fn gdk_memory_texture_builder_set_update_region(p_self: *MemoryTextureBuilder, p_region: ?*cairo.Region) void;
    pub const setUpdateRegion = gdk_memory_texture_builder_set_update_region;

    /// Sets the texture to be updated by this texture.
    ///
    /// See `gdk.MemoryTextureBuilder.setUpdateRegion` for an explanation.
    extern fn gdk_memory_texture_builder_set_update_texture(p_self: *MemoryTextureBuilder, p_texture: ?*gdk.Texture) void;
    pub const setUpdateTexture = gdk_memory_texture_builder_set_update_texture;

    /// Sets the width of the texture.
    ///
    /// The width must be set before calling `gdk.MemoryTextureBuilder.build`.
    extern fn gdk_memory_texture_builder_set_width(p_self: *MemoryTextureBuilder, p_width: c_int) void;
    pub const setWidth = gdk_memory_texture_builder_set_width;

    extern fn gdk_memory_texture_builder_get_type() usize;
    pub const getGObjectType = gdk_memory_texture_builder_get_type;

    extern fn g_object_ref(p_self: *gdk.MemoryTextureBuilder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.MemoryTextureBuilder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MemoryTextureBuilder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents the individual outputs that are associated with a `GdkDisplay`.
///
/// `GdkDisplay` keeps a `GListModel` to enumerate and monitor
/// monitors with `gdk.Display.getMonitors`. You can use
/// `gdk.Display.getMonitorAtSurface` to find a particular
/// monitor.
pub const Monitor = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.MonitorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The connector name.
        pub const connector = struct {
            pub const name = "connector";

            pub const Type = ?[*:0]u8;
        };

        /// A short description of the monitor, meant for display to the user.
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// The `GdkDisplay` of the monitor.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The geometry of the monitor.
        pub const geometry = struct {
            pub const name = "geometry";

            pub const Type = ?*gdk.Rectangle;
        };

        /// The height of the monitor, in millimeters.
        pub const height_mm = struct {
            pub const name = "height-mm";

            pub const Type = c_int;
        };

        /// The manufacturer name.
        pub const manufacturer = struct {
            pub const name = "manufacturer";

            pub const Type = ?[*:0]u8;
        };

        /// The model name.
        pub const model = struct {
            pub const name = "model";

            pub const Type = ?[*:0]u8;
        };

        /// The refresh rate, in milli-Hertz.
        pub const refresh_rate = struct {
            pub const name = "refresh-rate";

            pub const Type = c_int;
        };

        /// The scale of the monitor.
        pub const scale = struct {
            pub const name = "scale";

            pub const Type = f64;
        };

        /// The scale factor.
        ///
        /// The scale factor is the next larger integer,
        /// compared to `gdk.Surface.properties.scale`.
        pub const scale_factor = struct {
            pub const name = "scale-factor";

            pub const Type = c_int;
        };

        /// The subpixel layout.
        pub const subpixel_layout = struct {
            pub const name = "subpixel-layout";

            pub const Type = gdk.SubpixelLayout;
        };

        /// Whether the object is still valid.
        pub const valid = struct {
            pub const name = "valid";

            pub const Type = c_int;
        };

        /// The width of the monitor, in millimeters.
        pub const width_mm = struct {
            pub const name = "width-mm";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted when the output represented by `monitor` gets disconnected.
        pub const invalidate = struct {
            pub const name = "invalidate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Monitor, p_instance))),
                    gobject.signalLookup("invalidate", Monitor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the name of the monitor's connector, if available.
    ///
    /// These are strings such as "eDP-1", or "HDMI-2". They depend
    /// on software and hardware configuration, and should not be
    /// relied on as stable identifiers of a specific monitor.
    extern fn gdk_monitor_get_connector(p_monitor: *Monitor) ?[*:0]const u8;
    pub const getConnector = gdk_monitor_get_connector;

    /// Gets a string describing the monitor, if available.
    ///
    /// This can be used to identify a monitor in the UI.
    extern fn gdk_monitor_get_description(p_monitor: *Monitor) ?[*:0]const u8;
    pub const getDescription = gdk_monitor_get_description;

    /// Gets the display that this monitor belongs to.
    extern fn gdk_monitor_get_display(p_monitor: *Monitor) *gdk.Display;
    pub const getDisplay = gdk_monitor_get_display;

    /// Retrieves the size and position of the monitor within the
    /// display coordinate space.
    ///
    /// The returned geometry is in  ”application pixels”, not in
    /// ”device pixels” (see `gdk.Monitor.getScale`).
    extern fn gdk_monitor_get_geometry(p_monitor: *Monitor, p_geometry: *gdk.Rectangle) void;
    pub const getGeometry = gdk_monitor_get_geometry;

    /// Gets the height in millimeters of the monitor.
    extern fn gdk_monitor_get_height_mm(p_monitor: *Monitor) c_int;
    pub const getHeightMm = gdk_monitor_get_height_mm;

    /// Gets the name or PNP ID of the monitor's manufacturer.
    ///
    /// Note that this value might also vary depending on actual
    /// display backend.
    ///
    /// The PNP ID registry is located at
    /// [https://uefi.org/pnp_id_list](https://uefi.org/pnp_id_list).
    extern fn gdk_monitor_get_manufacturer(p_monitor: *Monitor) ?[*:0]const u8;
    pub const getManufacturer = gdk_monitor_get_manufacturer;

    /// Gets the string identifying the monitor model, if available.
    extern fn gdk_monitor_get_model(p_monitor: *Monitor) ?[*:0]const u8;
    pub const getModel = gdk_monitor_get_model;

    /// Gets the refresh rate of the monitor, if available.
    ///
    /// The value is in milli-Hertz, so a refresh rate of 60Hz
    /// is returned as 60000.
    extern fn gdk_monitor_get_refresh_rate(p_monitor: *Monitor) c_int;
    pub const getRefreshRate = gdk_monitor_get_refresh_rate;

    /// Gets the internal scale factor that maps from monitor coordinates
    /// to device pixels.
    ///
    /// This can be used if you want to create pixel based data for a
    /// particular monitor, but most of the time you’re drawing to a surface
    /// where it is better to use `gdk.Surface.getScale` instead.
    extern fn gdk_monitor_get_scale(p_monitor: *Monitor) f64;
    pub const getScale = gdk_monitor_get_scale;

    /// Gets the internal scale factor that maps from monitor coordinates
    /// to device pixels.
    ///
    /// On traditional systems this is 1, but on very high density outputs
    /// it can be a higher value (often 2).
    ///
    /// This can be used if you want to create pixel based data for a
    /// particular monitor, but most of the time you’re drawing to a surface
    /// where it is better to use `gdk.Surface.getScaleFactor` instead.
    extern fn gdk_monitor_get_scale_factor(p_monitor: *Monitor) c_int;
    pub const getScaleFactor = gdk_monitor_get_scale_factor;

    /// Gets information about the layout of red, green and blue
    /// primaries for pixels.
    extern fn gdk_monitor_get_subpixel_layout(p_monitor: *Monitor) gdk.SubpixelLayout;
    pub const getSubpixelLayout = gdk_monitor_get_subpixel_layout;

    /// Gets the width in millimeters of the monitor.
    extern fn gdk_monitor_get_width_mm(p_monitor: *Monitor) c_int;
    pub const getWidthMm = gdk_monitor_get_width_mm;

    /// Returns `TRUE` if the `monitor` object corresponds to a
    /// physical monitor.
    ///
    /// The `monitor` becomes invalid when the physical monitor
    /// is unplugged or removed.
    extern fn gdk_monitor_is_valid(p_monitor: *Monitor) c_int;
    pub const isValid = gdk_monitor_is_valid;

    extern fn gdk_monitor_get_type() usize;
    pub const getGObjectType = gdk_monitor_get_type;

    extern fn g_object_ref(p_self: *gdk.Monitor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Monitor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Monitor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a pointer or touch device motion.
pub const MotionEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = MotionEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_motion_event_get_type() usize;
    pub const getGObjectType = gdk_motion_event_get_type;

    pub fn as(p_instance: *MotionEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a pad-based device.
pub const PadEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = PadEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts the information from a pad strip or ring event.
    extern fn gdk_pad_event_get_axis_value(p_event: *PadEvent, p_index: *c_uint, p_value: *f64) void;
    pub const getAxisValue = gdk_pad_event_get_axis_value;

    /// Extracts information about the pressed button from
    /// a pad event.
    extern fn gdk_pad_event_get_button(p_event: *PadEvent) c_uint;
    pub const getButton = gdk_pad_event_get_button;

    /// Extracts group and mode information from a pad event.
    extern fn gdk_pad_event_get_group_mode(p_event: *PadEvent, p_group: *c_uint, p_mode: *c_uint) void;
    pub const getGroupMode = gdk_pad_event_get_group_mode;

    extern fn gdk_pad_event_get_type() usize;
    pub const getGObjectType = gdk_pad_event_get_type;

    pub fn as(p_instance: *PadEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to the proximity of a tool to a device.
pub const ProximityEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ProximityEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_proximity_event_get_type() usize;
    pub const getGObjectType = gdk_proximity_event_get_type;

    pub fn as(p_instance: *ProximityEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a scrolling motion.
pub const ScrollEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ScrollEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts the scroll deltas of a scroll event.
    ///
    /// The deltas will be zero unless the scroll direction
    /// is `GDK_SCROLL_SMOOTH`.
    ///
    /// For the representation unit of these deltas, see
    /// `gdk.ScrollEvent.getUnit`.
    extern fn gdk_scroll_event_get_deltas(p_event: *ScrollEvent, p_delta_x: *f64, p_delta_y: *f64) void;
    pub const getDeltas = gdk_scroll_event_get_deltas;

    /// Extracts the direction of a scroll event.
    extern fn gdk_scroll_event_get_direction(p_event: *ScrollEvent) gdk.ScrollDirection;
    pub const getDirection = gdk_scroll_event_get_direction;

    /// Extracts the scroll delta unit of a scroll event.
    ///
    /// The unit will always be `GDK_SCROLL_UNIT_WHEEL` if the scroll direction is not
    /// `GDK_SCROLL_SMOOTH`.
    extern fn gdk_scroll_event_get_unit(p_event: *ScrollEvent) gdk.ScrollUnit;
    pub const getUnit = gdk_scroll_event_get_unit;

    /// Check whether a scroll event is a stop scroll event.
    ///
    /// Scroll sequences with smooth scroll information may provide
    /// a stop scroll event once the interaction with the device finishes,
    /// e.g. by lifting a finger. This stop scroll event is the signal
    /// that a widget may trigger kinetic scrolling based on the current
    /// velocity.
    ///
    /// Stop scroll events always have a delta of 0/0.
    extern fn gdk_scroll_event_is_stop(p_event: *ScrollEvent) c_int;
    pub const isStop = gdk_scroll_event_is_stop;

    extern fn gdk_scroll_event_get_type() usize;
    pub const getGObjectType = gdk_scroll_event_get_type;

    pub fn as(p_instance: *ScrollEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a collection of input devices that belong to a user.
pub const Seat = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Seat;
    };
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// `GdkDisplay` of this seat.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };
    };

    pub const signals = struct {
        /// Emitted when a new input device is related to this seat.
        pub const device_added = struct {
            pub const name = "device-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: *gdk.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Seat, p_instance))),
                    gobject.signalLookup("device-added", Seat.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when an input device is removed (e.g. unplugged).
        pub const device_removed = struct {
            pub const name = "device-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: *gdk.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Seat, p_instance))),
                    gobject.signalLookup("device-removed", Seat.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted whenever a new tool is made known to the seat.
        ///
        /// The tool may later be assigned to a device (i.e. on
        /// proximity with a tablet). The device will emit the
        /// `gdk.Device.signals.tool_changed` signal accordingly.
        ///
        /// A same tool may be used by several devices.
        pub const tool_added = struct {
            pub const name = "tool-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tool: *gdk.DeviceTool, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Seat, p_instance))),
                    gobject.signalLookup("tool-added", Seat.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted whenever a tool is no longer known to this `seat`.
        pub const tool_removed = struct {
            pub const name = "tool-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tool: *gdk.DeviceTool, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Seat, p_instance))),
                    gobject.signalLookup("tool-removed", Seat.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns the capabilities this `GdkSeat` currently has.
    extern fn gdk_seat_get_capabilities(p_seat: *Seat) gdk.SeatCapabilities;
    pub const getCapabilities = gdk_seat_get_capabilities;

    /// Returns the devices that match the given capabilities.
    extern fn gdk_seat_get_devices(p_seat: *Seat, p_capabilities: gdk.SeatCapabilities) *glib.List;
    pub const getDevices = gdk_seat_get_devices;

    /// Returns the `GdkDisplay` this seat belongs to.
    extern fn gdk_seat_get_display(p_seat: *Seat) *gdk.Display;
    pub const getDisplay = gdk_seat_get_display;

    /// Returns the device that routes keyboard events.
    extern fn gdk_seat_get_keyboard(p_seat: *Seat) ?*gdk.Device;
    pub const getKeyboard = gdk_seat_get_keyboard;

    /// Returns the device that routes pointer events.
    extern fn gdk_seat_get_pointer(p_seat: *Seat) ?*gdk.Device;
    pub const getPointer = gdk_seat_get_pointer;

    /// Returns all `GdkDeviceTools` that are known to the application.
    extern fn gdk_seat_get_tools(p_seat: *Seat) *glib.List;
    pub const getTools = gdk_seat_get_tools;

    extern fn gdk_seat_get_type() usize;
    pub const getGObjectType = gdk_seat_get_type;

    extern fn g_object_ref(p_self: *gdk.Seat) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Seat) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Seat, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Base type for snapshot operations.
///
/// The subclass of `GdkSnapshot` used by GTK is [GtkSnapshot](../gtk4/class.Snapshot.html).
pub const Snapshot = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.SnapshotClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_snapshot_get_type() usize;
    pub const getGObjectType = gdk_snapshot_get_type;

    extern fn g_object_ref(p_self: *gdk.Snapshot) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Snapshot) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Snapshot, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a rectangular region on the screen.
///
/// It’s a low-level object, used to implement high-level objects
/// such as [GtkWindow](../gtk4/class.Window.html).
///
/// The surfaces you see in practice are either `gdk.Toplevel` or
/// `gdk.Popup`, and those interfaces provide much of the required
/// API to interact with these surfaces. Other, more specialized surface
/// types exist, but you will rarely interact with them directly.
pub const Surface = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.SurfaceClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The mouse pointer for the `GdkSurface`.
        pub const cursor = struct {
            pub const name = "cursor";

            pub const Type = ?*gdk.Cursor;
        };

        /// The `GdkDisplay` connection of the surface.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The `GdkFrameClock` of the surface.
        pub const frame_clock = struct {
            pub const name = "frame-clock";

            pub const Type = ?*gdk.FrameClock;
        };

        /// The height of the surface, in pixels.
        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        /// Whether the surface is mapped.
        pub const mapped = struct {
            pub const name = "mapped";

            pub const Type = c_int;
        };

        /// The scale of the surface.
        pub const scale = struct {
            pub const name = "scale";

            pub const Type = f64;
        };

        /// The scale factor of the surface.
        ///
        /// The scale factor is the next larger integer,
        /// compared to `gdk.Surface.properties.scale`.
        pub const scale_factor = struct {
            pub const name = "scale-factor";

            pub const Type = c_int;
        };

        /// The width of the surface in pixels.
        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// Emitted when `surface` starts being present on the monitor.
        pub const enter_monitor = struct {
            pub const name = "enter-monitor";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_monitor: *gdk.Monitor, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Surface, p_instance))),
                    gobject.signalLookup("enter-monitor", Surface.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when GDK receives an input event for `surface`.
        pub const event = struct {
            pub const name = "event";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_event: **gdk.Event, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Surface, p_instance))),
                    gobject.signalLookup("event", Surface.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the size of `surface` is changed, or when relayout should
        /// be performed.
        ///
        /// Surface size is reported in ”application pixels”, not
        /// ”device pixels” (see `gdk.Surface.getScaleFactor`).
        pub const layout = struct {
            pub const name = "layout";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_width: c_int, p_height: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Surface, p_instance))),
                    gobject.signalLookup("layout", Surface.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when `surface` stops being present on the monitor.
        pub const leave_monitor = struct {
            pub const name = "leave-monitor";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_monitor: *gdk.Monitor, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Surface, p_instance))),
                    gobject.signalLookup("leave-monitor", Surface.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when part of the surface needs to be redrawn.
        pub const render = struct {
            pub const name = "render";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_region: *cairo.Region, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Surface, p_instance))),
                    gobject.signalLookup("render", Surface.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a new popup surface.
    ///
    /// The surface will be attached to `parent` and can be positioned
    /// relative to it using `gdk.Popup.present`.
    extern fn gdk_surface_new_popup(p_parent: *gdk.Surface, p_autohide: c_int) *gdk.Surface;
    pub const newPopup = gdk_surface_new_popup;

    /// Creates a new toplevel surface.
    extern fn gdk_surface_new_toplevel(p_display: *gdk.Display) *gdk.Surface;
    pub const newToplevel = gdk_surface_new_toplevel;

    /// Emits a short beep associated to `surface`.
    ///
    /// If the display of `surface` does not support per-surface beeps,
    /// emits a short beep on the display just as `gdk.Display.beep`.
    extern fn gdk_surface_beep(p_surface: *Surface) void;
    pub const beep = gdk_surface_beep;

    /// Creates a new `GdkCairoContext` for rendering on `surface`.
    extern fn gdk_surface_create_cairo_context(p_surface: *Surface) *gdk.CairoContext;
    pub const createCairoContext = gdk_surface_create_cairo_context;

    /// Creates a new `GdkGLContext` for the `GdkSurface`.
    ///
    /// The context is disconnected from any particular surface or surface.
    /// If the creation of the `GdkGLContext` failed, `error` will be set.
    /// Before using the returned `GdkGLContext`, you will need to
    /// call `gdk.GLContext.makeCurrent` or `gdk.GLContext.realize`.
    extern fn gdk_surface_create_gl_context(p_surface: *Surface, p_error: ?*?*glib.Error) ?*gdk.GLContext;
    pub const createGlContext = gdk_surface_create_gl_context;

    /// Create a new Cairo surface that is as compatible as possible with the
    /// given `surface`.
    ///
    /// For example the new surface will have the same fallback resolution
    /// and font options as `surface`. Generally, the new surface will also
    /// use the same backend as `surface`, unless that is not possible for
    /// some reason. The type of the returned surface may be examined with
    /// `cairo_surface_get_type`.
    ///
    /// Initially the surface contents are all 0 (transparent if contents
    /// have transparency, black otherwise.)
    ///
    /// This function always returns a valid pointer, but it will return a
    /// pointer to a “nil” surface if `other` is already in an error state
    /// or any other error occurs.
    extern fn gdk_surface_create_similar_surface(p_surface: *Surface, p_content: cairo.Content, p_width: c_int, p_height: c_int) *cairo.Surface;
    pub const createSimilarSurface = gdk_surface_create_similar_surface;

    /// Sets an error and returns `NULL`.
    extern fn gdk_surface_create_vulkan_context(p_surface: *Surface, p_error: ?*?*glib.Error) ?*gdk.VulkanContext;
    pub const createVulkanContext = gdk_surface_create_vulkan_context;

    /// Destroys the window system resources associated with `surface` and
    /// decrements `surface`'s reference count.
    ///
    /// The window system resources for all children of `surface` are also
    /// destroyed, but the children’s reference counts are not decremented.
    ///
    /// Note that a surface will not be destroyed automatically when its
    /// reference count reaches zero. You must call this function yourself
    /// before that happens.
    extern fn gdk_surface_destroy(p_surface: *Surface) void;
    pub const destroy = gdk_surface_destroy;

    /// Retrieves a `GdkCursor` pointer for the cursor currently set on the
    /// `GdkSurface`.
    ///
    /// If the return value is `NULL` then there is no custom cursor set on
    /// the surface, and it is using the cursor for its parent surface.
    ///
    /// Use `gdk.Surface.setCursor` to unset the cursor of the surface.
    extern fn gdk_surface_get_cursor(p_surface: *Surface) ?*gdk.Cursor;
    pub const getCursor = gdk_surface_get_cursor;

    /// Retrieves a `GdkCursor` pointer for the `device` currently set on the
    /// specified `GdkSurface`.
    ///
    /// If the return value is `NULL` then there is no custom cursor set on the
    /// specified surface, and it is using the cursor for its parent surface.
    ///
    /// Use `gdk.Surface.setCursor` to unset the cursor of the surface.
    extern fn gdk_surface_get_device_cursor(p_surface: *Surface, p_device: *gdk.Device) ?*gdk.Cursor;
    pub const getDeviceCursor = gdk_surface_get_device_cursor;

    /// Obtains the current device position and modifier state.
    ///
    /// The position is given in coordinates relative to the upper
    /// left corner of `surface`.
    extern fn gdk_surface_get_device_position(p_surface: *Surface, p_device: *gdk.Device, p_x: ?*f64, p_y: ?*f64, p_mask: ?*gdk.ModifierType) c_int;
    pub const getDevicePosition = gdk_surface_get_device_position;

    /// Gets the `GdkDisplay` associated with a `GdkSurface`.
    extern fn gdk_surface_get_display(p_surface: *Surface) *gdk.Display;
    pub const getDisplay = gdk_surface_get_display;

    /// Gets the frame clock for the surface.
    ///
    /// The frame clock for a surface never changes unless the surface is
    /// reparented to a new toplevel surface.
    extern fn gdk_surface_get_frame_clock(p_surface: *Surface) *gdk.FrameClock;
    pub const getFrameClock = gdk_surface_get_frame_clock;

    /// Returns the height of the given `surface`.
    ///
    /// Surface size is reported in ”application pixels”, not
    /// ”device pixels” (see `gdk.Surface.getScaleFactor`).
    extern fn gdk_surface_get_height(p_surface: *Surface) c_int;
    pub const getHeight = gdk_surface_get_height;

    /// Checks whether the surface has been mapped.
    ///
    /// A surface is mapped with `gdk.Toplevel.present`
    /// or `gdk.Popup.present`.
    extern fn gdk_surface_get_mapped(p_surface: *Surface) c_int;
    pub const getMapped = gdk_surface_get_mapped;

    /// Returns the internal scale that maps from surface coordinates
    /// to the actual device pixels.
    ///
    /// When the scale is bigger than 1, the windowing system prefers to get
    /// buffers with a resolution that is bigger than the surface size (e.g.
    /// to show the surface on a high-resolution display, or in a magnifier).
    ///
    /// Compare with `gdk.Surface.getScaleFactor`, which returns the
    /// next larger integer.
    ///
    /// The scale may change during the lifetime of the surface.
    extern fn gdk_surface_get_scale(p_surface: *Surface) f64;
    pub const getScale = gdk_surface_get_scale;

    /// Returns the internal scale factor that maps from surface coordinates
    /// to the actual device pixels.
    ///
    /// On traditional systems this is 1, but on very high density outputs
    /// this can be a higher value (often 2). A higher value means that drawing
    /// is automatically scaled up to a higher resolution, so any code doing
    /// drawing will automatically look nicer. However, if you are supplying
    /// pixel-based data the scale value can be used to determine whether to
    /// use a pixel resource with higher resolution data.
    ///
    /// The scale factor may change during the lifetime of the surface.
    extern fn gdk_surface_get_scale_factor(p_surface: *Surface) c_int;
    pub const getScaleFactor = gdk_surface_get_scale_factor;

    /// Returns the width of the given `surface`.
    ///
    /// Surface size is reported in ”application pixels”, not
    /// ”device pixels” (see `gdk.Surface.getScaleFactor`).
    extern fn gdk_surface_get_width(p_surface: *Surface) c_int;
    pub const getWidth = gdk_surface_get_width;

    /// Hide the surface.
    ///
    /// For toplevel surfaces, withdraws them, so they will no longer be
    /// known to the window manager; for all surfaces, unmaps them, so
    /// they won’t be displayed. Normally done automatically as
    /// part of [`gtk_widget_hide`](../gtk4/method.Widget.hide.html).
    extern fn gdk_surface_hide(p_surface: *Surface) void;
    pub const hide = gdk_surface_hide;

    /// Check to see if a surface is destroyed.
    extern fn gdk_surface_is_destroyed(p_surface: *Surface) c_int;
    pub const isDestroyed = gdk_surface_is_destroyed;

    /// Forces a `gdk.Surface.signals.render` signal emission for `surface`
    /// to be scheduled.
    ///
    /// This function is useful for implementations that track invalid
    /// regions on their own.
    extern fn gdk_surface_queue_render(p_surface: *Surface) void;
    pub const queueRender = gdk_surface_queue_render;

    /// Request a layout phase from the surface's frame clock.
    ///
    /// See `gdk.FrameClock.requestPhase`.
    extern fn gdk_surface_request_layout(p_surface: *Surface) void;
    pub const requestLayout = gdk_surface_request_layout;

    /// Sets the default mouse pointer for a `GdkSurface`.
    ///
    /// Passing `NULL` for the `cursor` argument means that `surface` will use
    /// the cursor of its parent surface. Most surfaces should use this default.
    /// Note that `cursor` must be for the same display as `surface`.
    ///
    /// Use `gdk.Cursor.newFromName` or `gdk.Cursor.newFromTexture`
    /// to create the cursor. To make the cursor invisible, use `GDK_BLANK_CURSOR`.
    extern fn gdk_surface_set_cursor(p_surface: *Surface, p_cursor: ?*gdk.Cursor) void;
    pub const setCursor = gdk_surface_set_cursor;

    /// Sets a specific `GdkCursor` for a given device when it gets inside `surface`.
    ///
    /// Passing `NULL` for the `cursor` argument means that `surface` will use the
    /// cursor of its parent surface. Most surfaces should use this default.
    ///
    /// Use `gdk.Cursor.newFromName` or `gdk.Cursor.newFromTexture`
    /// to create the cursor. To make the cursor invisible, use `GDK_BLANK_CURSOR`.
    extern fn gdk_surface_set_device_cursor(p_surface: *Surface, p_device: *gdk.Device, p_cursor: *gdk.Cursor) void;
    pub const setDeviceCursor = gdk_surface_set_device_cursor;

    /// Apply the region to the surface for the purpose of event
    /// handling.
    ///
    /// Mouse events which happen while the pointer position corresponds
    /// to an unset bit in the mask will be passed on the surface below
    /// `surface`.
    ///
    /// An input region is typically used with RGBA surfaces. The alpha
    /// channel of the surface defines which pixels are invisible and
    /// allows for nicely antialiased borders, and the input region
    /// controls where the surface is “clickable”.
    ///
    /// Use `gdk.Display.supportsInputShapes` to find out if
    /// a particular backend supports input regions.
    extern fn gdk_surface_set_input_region(p_surface: *Surface, p_region: *cairo.Region) void;
    pub const setInputRegion = gdk_surface_set_input_region;

    /// Marks a region of the `GdkSurface` as opaque.
    ///
    /// For optimisation purposes, compositing window managers may
    /// like to not draw obscured regions of surfaces, or turn off blending
    /// during for these regions. With RGB windows with no transparency,
    /// this is just the shape of the window, but with ARGB32 windows, the
    /// compositor does not know what regions of the window are transparent
    /// or not.
    ///
    /// This function only works for toplevel surfaces.
    ///
    /// GTK will update this property automatically if the `surface` background
    /// is opaque, as we know where the opaque regions are. If your surface
    /// background is not opaque, please update this property in your
    /// [GtkWidgetClass.css_changed](../gtk4/vfunc.Widget.css_changed.html) handler.
    extern fn gdk_surface_set_opaque_region(p_surface: *Surface, p_region: ?*cairo.Region) void;
    pub const setOpaqueRegion = gdk_surface_set_opaque_region;

    /// Translates coordinates between two surfaces.
    ///
    /// Note that this only works if `to` and `from` are popups or
    /// transient-for to the same toplevel (directly or indirectly).
    extern fn gdk_surface_translate_coordinates(p_from: *Surface, p_to: *gdk.Surface, p_x: *f64, p_y: *f64) c_int;
    pub const translateCoordinates = gdk_surface_translate_coordinates;

    extern fn gdk_surface_get_type() usize;
    pub const getGObjectType = gdk_surface_get_type;

    extern fn g_object_ref(p_self: *gdk.Surface) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Surface) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Surface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Refers to pixel data in various forms.
///
/// It is primarily meant for pixel data that will not change over
/// multiple frames, and will be used for a long time.
///
/// There are various ways to create `GdkTexture` objects from a
/// `gdkpixbuf.Pixbuf`, or from bytes stored in memory, a file, or a
/// `gio.Resource`.
///
/// The ownership of the pixel data is transferred to the `GdkTexture`
/// instance; you can only make a copy of it, via `gdk.Texture.download`.
///
/// `GdkTexture` is an immutable object: That means you cannot change
/// anything about it other than increasing the reference count via
/// `gobject.Object.ref`, and consequently, it is a threadsafe object.
///
/// GDK provides a number of threadsafe texture loading functions:
/// `gdk.Texture.newFromResource`,
/// `gdk.Texture.newFromBytes`,
/// `gdk.Texture.newFromFile`,
/// `gdk.Texture.newFromFilename`,
/// `gdk.Texture.newForPixbuf`. Note that these are meant for loading
/// icons and resources that are shipped with the toolkit or application. It
/// is recommended that you use a dedicated image loading framework such as
/// [glycin](https://lib.rs/crates/glycin), if you need to load untrusted image
/// data.
pub const Texture = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{ gdk.Paintable, gio.Icon, gio.LoadableIcon };
    pub const Class = gdk.TextureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The color state of the texture.
        pub const color_state = struct {
            pub const name = "color-state";

            pub const Type = ?*gdk.ColorState;
        };

        /// The height of the texture, in pixels.
        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        /// The width of the texture, in pixels.
        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new texture object representing the `GdkPixbuf`.
    ///
    /// This function is threadsafe, so that you can e.g. use GTask
    /// and `gio.Task.runInThread` to avoid blocking the main thread
    /// while loading a big image.
    extern fn gdk_texture_new_for_pixbuf(p_pixbuf: *gdkpixbuf.Pixbuf) *gdk.Texture;
    pub const newForPixbuf = gdk_texture_new_for_pixbuf;

    /// Creates a new texture by loading an image from memory,
    ///
    /// The file format is detected automatically. The supported formats
    /// are PNG, JPEG and TIFF, though more formats might be available.
    ///
    /// If `NULL` is returned, then `error` will be set.
    ///
    /// This function is threadsafe, so that you can e.g. use GTask
    /// and `gio.Task.runInThread` to avoid blocking the main thread
    /// while loading a big image.
    extern fn gdk_texture_new_from_bytes(p_bytes: *glib.Bytes, p_error: ?*?*glib.Error) ?*gdk.Texture;
    pub const newFromBytes = gdk_texture_new_from_bytes;

    /// Creates a new texture by loading an image from a file.
    ///
    /// The file format is detected automatically. The supported formats
    /// are PNG, JPEG and TIFF, though more formats might be available.
    ///
    /// If `NULL` is returned, then `error` will be set.
    ///
    /// This function is threadsafe, so that you can e.g. use GTask
    /// and `gio.Task.runInThread` to avoid blocking the main thread
    /// while loading a big image.
    extern fn gdk_texture_new_from_file(p_file: *gio.File, p_error: ?*?*glib.Error) ?*gdk.Texture;
    pub const newFromFile = gdk_texture_new_from_file;

    /// Creates a new texture by loading an image from a file.
    ///
    /// The file format is detected automatically. The supported formats
    /// are PNG, JPEG and TIFF, though more formats might be available.
    ///
    /// If `NULL` is returned, then `error` will be set.
    ///
    /// This function is threadsafe, so that you can e.g. use GTask
    /// and `gio.Task.runInThread` to avoid blocking the main thread
    /// while loading a big image.
    extern fn gdk_texture_new_from_filename(p_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*gdk.Texture;
    pub const newFromFilename = gdk_texture_new_from_filename;

    /// Creates a new texture by loading an image from a resource.
    ///
    /// The file format is detected automatically. The supported formats
    /// are PNG and JPEG, though more formats might be available.
    ///
    /// It is a fatal error if `resource_path` does not specify a valid
    /// image resource and the program will abort if that happens.
    /// If you are unsure about the validity of a resource, use
    /// `gdk.Texture.newFromFile` to load it.
    ///
    /// This function is threadsafe, so that you can e.g. use GTask
    /// and `gio.Task.runInThread` to avoid blocking the main thread
    /// while loading a big image.
    extern fn gdk_texture_new_from_resource(p_resource_path: [*:0]const u8) *gdk.Texture;
    pub const newFromResource = gdk_texture_new_from_resource;

    /// Downloads the `texture` into local memory.
    ///
    /// This may be an expensive operation, as the actual texture data
    /// may reside on a GPU or on a remote display server.
    ///
    /// The data format of the downloaded data is equivalent to
    /// `CAIRO_FORMAT_ARGB32`, so every downloaded pixel requires
    /// 4 bytes of memory.
    ///
    /// Downloading a texture into a Cairo image surface:
    /// ```c
    /// surface = cairo_image_surface_create (CAIRO_FORMAT_ARGB32,
    ///                                       gdk_texture_get_width (texture),
    ///                                       gdk_texture_get_height (texture));
    /// gdk_texture_download (texture,
    ///                       cairo_image_surface_get_data (surface),
    ///                       cairo_image_surface_get_stride (surface));
    /// cairo_surface_mark_dirty (surface);
    /// ```
    ///
    /// For more flexible download capabilities, see
    /// `gdk.TextureDownloader`.
    extern fn gdk_texture_download(p_texture: *Texture, p_data: [*]u8, p_stride: usize) void;
    pub const download = gdk_texture_download;

    /// Returns the color state associated with the texture.
    extern fn gdk_texture_get_color_state(p_self: *Texture) *gdk.ColorState;
    pub const getColorState = gdk_texture_get_color_state;

    /// Gets the memory format most closely associated with the data of
    /// the texture.
    ///
    /// Note that it may not be an exact match for texture data
    /// stored on the GPU or with compression.
    ///
    /// The format can give an indication about the bit depth and opacity
    /// of the texture and is useful to determine the best format for
    /// downloading the texture.
    extern fn gdk_texture_get_format(p_self: *Texture) gdk.MemoryFormat;
    pub const getFormat = gdk_texture_get_format;

    /// Returns the height of the `texture`, in pixels.
    extern fn gdk_texture_get_height(p_texture: *Texture) c_int;
    pub const getHeight = gdk_texture_get_height;

    /// Returns the width of `texture`, in pixels.
    extern fn gdk_texture_get_width(p_texture: *Texture) c_int;
    pub const getWidth = gdk_texture_get_width;

    /// Store the given `texture` to the `filename` as a PNG file.
    ///
    /// This is a utility function intended for debugging and testing.
    /// If you want more control over formats, proper error handling or
    /// want to store to a `gio.File` or other location, you might want to
    /// use `gdk.Texture.saveToPngBytes` or look into the
    /// gdk-pixbuf library.
    extern fn gdk_texture_save_to_png(p_texture: *Texture, p_filename: [*:0]const u8) c_int;
    pub const saveToPng = gdk_texture_save_to_png;

    /// Store the given `texture` in memory as a PNG file.
    ///
    /// Use `gdk.Texture.newFromBytes` to read it back.
    ///
    /// If you want to serialize a texture, this is a convenient and
    /// portable way to do that.
    ///
    /// If you need more control over the generated image, such as
    /// attaching metadata, you should look into an image handling
    /// library such as the gdk-pixbuf library.
    ///
    /// If you are dealing with high dynamic range float data, you
    /// might also want to consider `gdk.Texture.saveToTiffBytes`
    /// instead.
    extern fn gdk_texture_save_to_png_bytes(p_texture: *Texture) *glib.Bytes;
    pub const saveToPngBytes = gdk_texture_save_to_png_bytes;

    /// Store the given `texture` to the `filename` as a TIFF file.
    ///
    /// GTK will attempt to store data without loss.
    extern fn gdk_texture_save_to_tiff(p_texture: *Texture, p_filename: [*:0]const u8) c_int;
    pub const saveToTiff = gdk_texture_save_to_tiff;

    /// Store the given `texture` in memory as a TIFF file.
    ///
    /// Use `gdk.Texture.newFromBytes` to read it back.
    ///
    /// This function is intended to store a representation of the
    /// texture's data that is as accurate as possible. This is
    /// particularly relevant when working with high dynamic range
    /// images and floating-point texture data.
    ///
    /// If that is not your concern and you are interested in a
    /// smaller size and a more portable format, you might want to
    /// use `gdk.Texture.saveToPngBytes`.
    extern fn gdk_texture_save_to_tiff_bytes(p_texture: *Texture) *glib.Bytes;
    pub const saveToTiffBytes = gdk_texture_save_to_tiff_bytes;

    extern fn gdk_texture_get_type() usize;
    pub const getGObjectType = gdk_texture_get_type;

    extern fn g_object_ref(p_self: *gdk.Texture) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Texture) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Texture, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a touch-based device.
pub const TouchEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = TouchEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts whether a touch event is emulating a pointer event.
    extern fn gdk_touch_event_get_emulating_pointer(p_event: *TouchEvent) c_int;
    pub const getEmulatingPointer = gdk_touch_event_get_emulating_pointer;

    extern fn gdk_touch_event_get_type() usize;
    pub const getGObjectType = gdk_touch_event_get_type;

    pub fn as(p_instance: *TouchEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An event related to a gesture on a touchpad device.
///
/// Unlike touchscreens, where the windowing system sends basic
/// sequences of begin, update, end events, and leaves gesture
/// recognition to the clients, touchpad gestures are typically
/// processed by the system, resulting in these events.
pub const TouchpadEvent = opaque {
    pub const Parent = gdk.Event;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = TouchpadEvent;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Extracts delta information from a touchpad event.
    extern fn gdk_touchpad_event_get_deltas(p_event: *TouchpadEvent, p_dx: *f64, p_dy: *f64) void;
    pub const getDeltas = gdk_touchpad_event_get_deltas;

    /// Extracts the touchpad gesture phase from a touchpad event.
    extern fn gdk_touchpad_event_get_gesture_phase(p_event: *TouchpadEvent) gdk.TouchpadGesturePhase;
    pub const getGesturePhase = gdk_touchpad_event_get_gesture_phase;

    /// Extracts the number of fingers from a touchpad event.
    extern fn gdk_touchpad_event_get_n_fingers(p_event: *TouchpadEvent) c_uint;
    pub const getNFingers = gdk_touchpad_event_get_n_fingers;

    /// Extracts the angle delta from a touchpad pinch event.
    extern fn gdk_touchpad_event_get_pinch_angle_delta(p_event: *TouchpadEvent) f64;
    pub const getPinchAngleDelta = gdk_touchpad_event_get_pinch_angle_delta;

    /// Extracts the scale from a touchpad pinch event.
    extern fn gdk_touchpad_event_get_pinch_scale(p_event: *TouchpadEvent) f64;
    pub const getPinchScale = gdk_touchpad_event_get_pinch_scale;

    extern fn gdk_touchpad_event_get_type() usize;
    pub const getGObjectType = gdk_touchpad_event_get_type;

    pub fn as(p_instance: *TouchpadEvent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents the platform-specific Vulkan draw context.
///
/// `GdkVulkanContext`s are created for a surface using
/// `gdk.Surface.createVulkanContext`, and the context will match
/// the characteristics of the surface.
///
/// Support for `GdkVulkanContext` is platform-specific and context creation
/// can fail, returning `NULL` context.
pub const VulkanContext = opaque {
    pub const Parent = gdk.DrawContext;
    pub const Implements = [_]type{gio.Initable};
    pub const Class = opaque {
        pub const Instance = VulkanContext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when the images managed by this context have changed.
        ///
        /// Usually this means that the swapchain had to be recreated,
        /// for example in response to a change of the surface size.
        pub const images_updated = struct {
            pub const name = "images-updated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(VulkanContext, p_instance))),
                    gobject.signalLookup("images-updated", VulkanContext.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn gdk_vulkan_context_get_type() usize;
    pub const getGObjectType = gdk_vulkan_context_get_type;

    extern fn g_object_ref(p_self: *gdk.VulkanContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.VulkanContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VulkanContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface for tablet pad devices.
///
/// It allows querying the features provided by the pad device.
///
/// Tablet pads may contain one or more groups, each containing a subset
/// of the buttons/rings/strips available. `gdk.DevicePad.getNGroups`
/// can be used to obtain the number of groups, `gdk.DevicePad.getNFeatures`
/// and `gdk.DevicePad.getFeatureGroup` can be combined to find out
/// the number of buttons/rings/strips the device has, and how are they grouped.
///
/// Each of those groups have different modes, which may be used to map each
/// individual pad feature to multiple actions. Only one mode is effective
/// (current) for each given group, different groups may have different
/// current modes. The number of available modes in a group can be found
/// out through `gdk.DevicePad.getGroupNModes`, and the current mode
/// for a given group will be notified through events of type `GDK_PAD_GROUP_MODE`.
pub const DevicePad = opaque {
    pub const Prerequisites = [_]type{gdk.Device};
    pub const Iface = gdk.DevicePadInterface;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the group the given `feature` and `idx` belong to.
    ///
    /// f the feature or index do not exist in `pad`, -1 is returned.
    extern fn gdk_device_pad_get_feature_group(p_pad: *DevicePad, p_feature: gdk.DevicePadFeature, p_feature_idx: c_int) c_int;
    pub const getFeatureGroup = gdk_device_pad_get_feature_group;

    /// Returns the number of modes that `group` may have.
    extern fn gdk_device_pad_get_group_n_modes(p_pad: *DevicePad, p_group_idx: c_int) c_int;
    pub const getGroupNModes = gdk_device_pad_get_group_n_modes;

    /// Returns the number of features a tablet pad has.
    extern fn gdk_device_pad_get_n_features(p_pad: *DevicePad, p_feature: gdk.DevicePadFeature) c_int;
    pub const getNFeatures = gdk_device_pad_get_n_features;

    /// Returns the number of groups this pad device has.
    ///
    /// Pads have at least one group. A pad group is a subcollection of
    /// buttons/strip/rings that is affected collectively by a same
    /// current mode.
    extern fn gdk_device_pad_get_n_groups(p_pad: *DevicePad) c_int;
    pub const getNGroups = gdk_device_pad_get_n_groups;

    extern fn gdk_device_pad_get_type() usize;
    pub const getGObjectType = gdk_device_pad_get_type;

    extern fn g_object_ref(p_self: *gdk.DevicePad) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DevicePad) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DevicePad, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A surface that is used during DND.
pub const DragSurface = opaque {
    pub const Prerequisites = [_]type{gdk.Surface};
    pub const Iface = gdk.DragSurfaceInterface;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when the size for the surface needs to be computed, when it is
        /// present.
        ///
        /// This signal will normally be emitted during the native surface layout
        /// cycle when the surface size needs to be recomputed.
        ///
        /// It is the responsibility of the drag surface user to handle this signal
        /// and compute the desired size of the surface, storing the computed size
        /// in the `gdk.DragSurfaceSize` object that is passed to the signal
        /// handler, using `gdk.DragSurfaceSize.setSize`.
        ///
        /// Failing to set a size so will result in an arbitrary size being used as
        /// a result.
        pub const compute_size = struct {
            pub const name = "compute-size";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_size: *gdk.DragSurfaceSize, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DragSurface, p_instance))),
                    gobject.signalLookup("compute-size", DragSurface.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Present `drag_surface`.
    extern fn gdk_drag_surface_present(p_drag_surface: *DragSurface, p_width: c_int, p_height: c_int) c_int;
    pub const present = gdk_drag_surface_present;

    extern fn gdk_drag_surface_get_type() usize;
    pub const getGObjectType = gdk_drag_surface_get_type;

    extern fn g_object_ref(p_self: *gdk.DragSurface) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DragSurface) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DragSurface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface for content that can be painted.
///
/// The content of a `GdkPaintable` can be painted anywhere at any size
/// without requiring any sort of layout. The interface is inspired by
/// similar concepts elsewhere, such as
/// [ClutterContent](https://developer.gnome.org/clutter/stable/ClutterContent.html),
/// [HTML/CSS Paint Sources](https://www.w3.org/TR/css-images-4/`paint`-source),
/// or [SVG Paint Servers](https://www.w3.org/TR/SVG2/pservers.html).
///
/// A `GdkPaintable` can be snapshot at any time and size using
/// `gdk.Paintable.snapshot`. How the paintable interprets that size and
/// if it scales or centers itself into the given rectangle is implementation
/// defined, though if you are implementing a `GdkPaintable` and don't know what
/// to do, it is suggested that you scale your paintable ignoring any potential
/// aspect ratio.
///
/// The contents that a `GdkPaintable` produces may depend on the `gdk.Snapshot`
/// passed to it. For example, paintables may decide to use more detailed images
/// on higher resolution screens or when OpenGL is available. A `GdkPaintable`
/// will however always produce the same output for the same snapshot.
///
/// A `GdkPaintable` may change its contents, meaning that it will now produce
/// a different output with the same snapshot. Once that happens, it will call
/// `gdk.Paintable.invalidateContents` which will emit the
/// `gdk.Paintable.signals.invalidate_contents` signal. If a paintable is known
/// to never change its contents, it will set the `GDK_PAINTABLE_STATIC_CONTENTS`
/// flag. If a consumer cannot deal with changing contents, it may call
/// `gdk.Paintable.getCurrentImage` which will return a static
/// paintable and use that.
///
/// A paintable can report an intrinsic (or preferred) size or aspect ratio it
/// wishes to be rendered at, though it doesn't have to. Consumers of the interface
/// can use this information to layout thepaintable appropriately. Just like the
/// contents, the size of a paintable can change. A paintable will indicate this
/// by calling `gdk.Paintable.invalidateSize` which will emit the
/// `gdk.Paintable.signals.invalidate_size` signal. And just like for contents,
/// if a paintable is known to never change its size, it will set the
/// `GDK_PAINTABLE_STATIC_SIZE` flag.
///
/// Besides API for applications, there are some functions that are only
/// useful for implementing subclasses and should not be used by applications:
/// `gdk.Paintable.invalidateContents`,
/// `gdk.Paintable.invalidateSize`,
/// `gdk.Paintable.newEmpty`.
pub const Paintable = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = gdk.PaintableInterface;
    pub const virtual_methods = struct {
        /// Gets an immutable paintable for the current contents displayed by `paintable`.
        ///
        /// This is useful when you want to retain the current state of an animation,
        /// for example to take a screenshot of a running animation.
        ///
        /// If the `paintable` is already immutable, it will return itself.
        pub const get_current_image = struct {
            pub fn call(p_class: anytype, p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gdk.Paintable {
                return gobject.ext.as(Paintable.Iface, p_class).f_get_current_image.?(gobject.ext.as(Paintable, p_paintable));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gdk.Paintable) void {
                gobject.ext.as(Paintable.Iface, p_class).f_get_current_image = @ptrCast(p_implementation);
            }
        };

        /// Get flags for the paintable.
        ///
        /// This is oftentimes useful for optimizations.
        ///
        /// See `gdk.PaintableFlags` for the flags and what they mean.
        pub const get_flags = struct {
            pub fn call(p_class: anytype, p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) gdk.PaintableFlags {
                return gobject.ext.as(Paintable.Iface, p_class).f_get_flags.?(gobject.ext.as(Paintable, p_paintable));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) gdk.PaintableFlags) void {
                gobject.ext.as(Paintable.Iface, p_class).f_get_flags = @ptrCast(p_implementation);
            }
        };

        /// Gets the preferred aspect ratio the `paintable` would like to be displayed at.
        ///
        /// The aspect ratio is the width divided by the height, so a value of 0.5
        /// means that the `paintable` prefers to be displayed twice as high as it
        /// is wide. Consumers of this interface can use this to preserve aspect
        /// ratio when displaying the paintable.
        ///
        /// This is a purely informational value and does not in any way limit the
        /// values that may be passed to `gdk.Paintable.snapshot`.
        ///
        /// Usually when a `paintable` returns nonzero values from
        /// `gdk.Paintable.getIntrinsicWidth` and
        /// `gdk.Paintable.getIntrinsicHeight` the aspect ratio
        /// should conform to those values, though that is not required.
        ///
        /// If the `paintable` does not have a preferred aspect ratio,
        /// it returns 0. Negative values are never returned.
        pub const get_intrinsic_aspect_ratio = struct {
            pub fn call(p_class: anytype, p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) f64 {
                return gobject.ext.as(Paintable.Iface, p_class).f_get_intrinsic_aspect_ratio.?(gobject.ext.as(Paintable, p_paintable));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) f64) void {
                gobject.ext.as(Paintable.Iface, p_class).f_get_intrinsic_aspect_ratio = @ptrCast(p_implementation);
            }
        };

        /// Gets the preferred height the `paintable` would like to be displayed at.
        ///
        /// Consumers of this interface can use this to reserve enough space to draw
        /// the paintable.
        ///
        /// This is a purely informational value and does not in any way limit the
        /// values that may be passed to `gdk.Paintable.snapshot`.
        ///
        /// If the `paintable` does not have a preferred height, it returns 0.
        /// Negative values are never returned.
        pub const get_intrinsic_height = struct {
            pub fn call(p_class: anytype, p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Paintable.Iface, p_class).f_get_intrinsic_height.?(gobject.ext.as(Paintable, p_paintable));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Paintable.Iface, p_class).f_get_intrinsic_height = @ptrCast(p_implementation);
            }
        };

        /// Gets the preferred width the `paintable` would like to be displayed at.
        ///
        /// Consumers of this interface can use this to reserve enough space to draw
        /// the paintable.
        ///
        /// This is a purely informational value and does not in any way limit the
        /// values that may be passed to `gdk.Paintable.snapshot`.
        ///
        /// If the `paintable` does not have a preferred width, it returns 0.
        /// Negative values are never returned.
        pub const get_intrinsic_width = struct {
            pub fn call(p_class: anytype, p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Paintable.Iface, p_class).f_get_intrinsic_width.?(gobject.ext.as(Paintable, p_paintable));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Paintable.Iface, p_class).f_get_intrinsic_width = @ptrCast(p_implementation);
            }
        };

        /// Snapshots the given paintable with the given `width` and `height`.
        ///
        /// The paintable is drawn at the current (0,0) offset of the `snapshot`.
        /// If `width` and `height` are not larger than zero, this function will
        /// do nothing.
        pub const snapshot = struct {
            pub fn call(p_class: anytype, p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_snapshot: *gdk.Snapshot, p_width: f64, p_height: f64) void {
                return gobject.ext.as(Paintable.Iface, p_class).f_snapshot.?(gobject.ext.as(Paintable, p_paintable), p_snapshot, p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_paintable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_snapshot: *gdk.Snapshot, p_width: f64, p_height: f64) callconv(.c) void) void {
                gobject.ext.as(Paintable.Iface, p_class).f_snapshot = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when the contents of the `paintable` change.
        ///
        /// Examples for such an event would be videos changing to the next frame or
        /// the icon theme for an icon changing.
        pub const invalidate_contents = struct {
            pub const name = "invalidate-contents";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Paintable, p_instance))),
                    gobject.signalLookup("invalidate-contents", Paintable.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the intrinsic size of the `paintable` changes.
        ///
        /// This means the values reported by at least one of
        /// `gdk.Paintable.getIntrinsicWidth`,
        /// `gdk.Paintable.getIntrinsicHeight` or
        /// `gdk.Paintable.getIntrinsicAspectRatio`
        /// has changed.
        ///
        /// Examples for such an event would be a paintable displaying
        /// the contents of a toplevel surface being resized.
        pub const invalidate_size = struct {
            pub const name = "invalidate-size";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Paintable, p_instance))),
                    gobject.signalLookup("invalidate-size", Paintable.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns a paintable that has the given intrinsic size and draws nothing.
    ///
    /// This is often useful for implementing the
    /// `gdk.Paintable.virtual_methods.get_current_image` virtual function
    /// when the paintable is in an incomplete state (like a
    /// [GtkMediaStream](../gtk4/class.MediaStream.html) before receiving
    /// the first frame).
    extern fn gdk_paintable_new_empty(p_intrinsic_width: c_int, p_intrinsic_height: c_int) *gdk.Paintable;
    pub const newEmpty = gdk_paintable_new_empty;

    /// Compute a concrete size for the `GdkPaintable`.
    ///
    /// Applies the sizing algorithm outlined in the
    /// [CSS Image spec](https://drafts.csswg.org/css-images-3/`default`-sizing)
    /// to the given `paintable`. See that link for more details.
    ///
    /// It is not necessary to call this function when both `specified_width`
    /// and `specified_height` are known, but it is useful to call this
    /// function in GtkWidget:measure implementations to compute the
    /// other dimension when only one dimension is given.
    extern fn gdk_paintable_compute_concrete_size(p_paintable: *Paintable, p_specified_width: f64, p_specified_height: f64, p_default_width: f64, p_default_height: f64, p_concrete_width: *f64, p_concrete_height: *f64) void;
    pub const computeConcreteSize = gdk_paintable_compute_concrete_size;

    /// Gets an immutable paintable for the current contents displayed by `paintable`.
    ///
    /// This is useful when you want to retain the current state of an animation,
    /// for example to take a screenshot of a running animation.
    ///
    /// If the `paintable` is already immutable, it will return itself.
    extern fn gdk_paintable_get_current_image(p_paintable: *Paintable) *gdk.Paintable;
    pub const getCurrentImage = gdk_paintable_get_current_image;

    /// Get flags for the paintable.
    ///
    /// This is oftentimes useful for optimizations.
    ///
    /// See `gdk.PaintableFlags` for the flags and what they mean.
    extern fn gdk_paintable_get_flags(p_paintable: *Paintable) gdk.PaintableFlags;
    pub const getFlags = gdk_paintable_get_flags;

    /// Gets the preferred aspect ratio the `paintable` would like to be displayed at.
    ///
    /// The aspect ratio is the width divided by the height, so a value of 0.5
    /// means that the `paintable` prefers to be displayed twice as high as it
    /// is wide. Consumers of this interface can use this to preserve aspect
    /// ratio when displaying the paintable.
    ///
    /// This is a purely informational value and does not in any way limit the
    /// values that may be passed to `gdk.Paintable.snapshot`.
    ///
    /// Usually when a `paintable` returns nonzero values from
    /// `gdk.Paintable.getIntrinsicWidth` and
    /// `gdk.Paintable.getIntrinsicHeight` the aspect ratio
    /// should conform to those values, though that is not required.
    ///
    /// If the `paintable` does not have a preferred aspect ratio,
    /// it returns 0. Negative values are never returned.
    extern fn gdk_paintable_get_intrinsic_aspect_ratio(p_paintable: *Paintable) f64;
    pub const getIntrinsicAspectRatio = gdk_paintable_get_intrinsic_aspect_ratio;

    /// Gets the preferred height the `paintable` would like to be displayed at.
    ///
    /// Consumers of this interface can use this to reserve enough space to draw
    /// the paintable.
    ///
    /// This is a purely informational value and does not in any way limit the
    /// values that may be passed to `gdk.Paintable.snapshot`.
    ///
    /// If the `paintable` does not have a preferred height, it returns 0.
    /// Negative values are never returned.
    extern fn gdk_paintable_get_intrinsic_height(p_paintable: *Paintable) c_int;
    pub const getIntrinsicHeight = gdk_paintable_get_intrinsic_height;

    /// Gets the preferred width the `paintable` would like to be displayed at.
    ///
    /// Consumers of this interface can use this to reserve enough space to draw
    /// the paintable.
    ///
    /// This is a purely informational value and does not in any way limit the
    /// values that may be passed to `gdk.Paintable.snapshot`.
    ///
    /// If the `paintable` does not have a preferred width, it returns 0.
    /// Negative values are never returned.
    extern fn gdk_paintable_get_intrinsic_width(p_paintable: *Paintable) c_int;
    pub const getIntrinsicWidth = gdk_paintable_get_intrinsic_width;

    /// Called by implementations of `GdkPaintable` to invalidate their contents.
    ///
    /// Unless the contents are invalidated, implementations must guarantee that
    /// multiple calls of `gdk.Paintable.snapshot` produce the same output.
    ///
    /// This function will emit the `gdk.Paintable.signals.invalidate_contents`
    /// signal.
    ///
    /// If a `paintable` reports the `GDK_PAINTABLE_STATIC_CONTENTS` flag,
    /// it must not call this function.
    extern fn gdk_paintable_invalidate_contents(p_paintable: *Paintable) void;
    pub const invalidateContents = gdk_paintable_invalidate_contents;

    /// Called by implementations of `GdkPaintable` to invalidate their size.
    ///
    /// As long as the size is not invalidated, `paintable` must return the same
    /// values for its intrinsic width, height and aspect ratio.
    ///
    /// This function will emit the `gdk.Paintable.signals.invalidate_size`
    /// signal.
    ///
    /// If a `paintable` reports the `GDK_PAINTABLE_STATIC_SIZE` flag,
    /// it must not call this function.
    extern fn gdk_paintable_invalidate_size(p_paintable: *Paintable) void;
    pub const invalidateSize = gdk_paintable_invalidate_size;

    /// Snapshots the given paintable with the given `width` and `height`.
    ///
    /// The paintable is drawn at the current (0,0) offset of the `snapshot`.
    /// If `width` and `height` are not larger than zero, this function will
    /// do nothing.
    extern fn gdk_paintable_snapshot(p_paintable: *Paintable, p_snapshot: *gdk.Snapshot, p_width: f64, p_height: f64) void;
    pub const snapshot = gdk_paintable_snapshot;

    extern fn gdk_paintable_get_type() usize;
    pub const getGObjectType = gdk_paintable_get_type;

    extern fn g_object_ref(p_self: *gdk.Paintable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Paintable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Paintable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A surface that is attached to another surface.
///
/// The `GdkPopup` is positioned relative to its parent surface.
///
/// `GdkPopup`s are typically used to implement menus and similar popups.
/// They can be modal, which is indicated by the `gdk.Popup.properties.autohide`
/// property.
pub const Popup = opaque {
    pub const Prerequisites = [_]type{gdk.Surface};
    pub const Iface = gdk.PopupInterface;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether to hide on outside clicks.
        pub const autohide = struct {
            pub const name = "autohide";

            pub const Type = c_int;
        };

        /// The parent surface.
        pub const parent = struct {
            pub const name = "parent";

            pub const Type = ?*gdk.Surface;
        };
    };

    pub const signals = struct {};

    /// Returns whether this popup is set to hide on outside clicks.
    extern fn gdk_popup_get_autohide(p_popup: *Popup) c_int;
    pub const getAutohide = gdk_popup_get_autohide;

    /// Returns the parent surface of a popup.
    extern fn gdk_popup_get_parent(p_popup: *Popup) ?*gdk.Surface;
    pub const getParent = gdk_popup_get_parent;

    /// Obtains the position of the popup relative to its parent.
    extern fn gdk_popup_get_position_x(p_popup: *Popup) c_int;
    pub const getPositionX = gdk_popup_get_position_x;

    /// Obtains the position of the popup relative to its parent.
    extern fn gdk_popup_get_position_y(p_popup: *Popup) c_int;
    pub const getPositionY = gdk_popup_get_position_y;

    /// Gets the current popup rectangle anchor.
    ///
    /// The value returned may change after calling `gdk.Popup.present`,
    /// or after the `gdk.Surface.signals.layout` signal is emitted.
    extern fn gdk_popup_get_rect_anchor(p_popup: *Popup) gdk.Gravity;
    pub const getRectAnchor = gdk_popup_get_rect_anchor;

    /// Gets the current popup surface anchor.
    ///
    /// The value returned may change after calling `gdk.Popup.present`,
    /// or after the `gdk.Surface.signals.layout` signal is emitted.
    extern fn gdk_popup_get_surface_anchor(p_popup: *Popup) gdk.Gravity;
    pub const getSurfaceAnchor = gdk_popup_get_surface_anchor;

    /// Present `popup` after having processed the `GdkPopupLayout` rules.
    ///
    /// If the popup was previously not showing, it will be shown,
    /// otherwise it will change position according to `layout`.
    ///
    /// After calling this function, the result should be handled in response
    /// to the `gdk.Surface.signals.layout` signal being emitted. The resulting
    /// popup position can be queried using `gdk.Popup.getPositionX`,
    /// `gdk.Popup.getPositionY`, and the resulting size will be sent as
    /// parameters in the layout signal. Use `gdk.Popup.getRectAnchor`
    /// and `gdk.Popup.getSurfaceAnchor` to get the resulting anchors.
    ///
    /// Presenting may fail, for example if the `popup` is set to autohide
    /// and is immediately hidden upon being presented. If presenting failed,
    /// the `gdk.Surface.signals.layout` signal will not me emitted.
    extern fn gdk_popup_present(p_popup: *Popup, p_width: c_int, p_height: c_int, p_layout: *gdk.PopupLayout) c_int;
    pub const present = gdk_popup_present;

    extern fn gdk_popup_get_type() usize;
    pub const getGObjectType = gdk_popup_get_type;

    extern fn g_object_ref(p_self: *gdk.Popup) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Popup) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Popup, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A freestanding toplevel surface.
///
/// The `GdkToplevel` interface provides useful APIs for interacting with
/// the windowing system, such as controlling maximization and size of the
/// surface, setting icons and transient parents for dialogs.
pub const Toplevel = opaque {
    pub const Prerequisites = [_]type{gdk.Surface};
    pub const Iface = gdk.ToplevelInterface;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the window manager should add decorations.
        pub const decorated = struct {
            pub const name = "decorated";

            pub const Type = c_int;
        };

        /// Whether the window manager should allow to close the surface.
        pub const deletable = struct {
            pub const name = "deletable";

            pub const Type = c_int;
        };

        /// The fullscreen mode of the surface.
        pub const fullscreen_mode = struct {
            pub const name = "fullscreen-mode";

            pub const Type = gdk.FullscreenMode;
        };

        /// A list of textures to use as icon.
        pub const icon_list = struct {
            pub const name = "icon-list";

            pub const Type = ?*anyopaque;
        };

        /// Whether the surface is modal.
        pub const modal = struct {
            pub const name = "modal";

            pub const Type = c_int;
        };

        /// Whether the surface should inhibit keyboard shortcuts.
        pub const shortcuts_inhibited = struct {
            pub const name = "shortcuts-inhibited";

            pub const Type = c_int;
        };

        /// The startup ID of the surface.
        ///
        /// See `gdk.AppLaunchContext` for more information about
        /// startup feedback.
        pub const startup_id = struct {
            pub const name = "startup-id";

            pub const Type = ?[*:0]u8;
        };

        /// The state of the toplevel.
        pub const state = struct {
            pub const name = "state";

            pub const Type = gdk.ToplevelState;
        };

        /// The title of the surface.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// The transient parent of the surface.
        pub const transient_for = struct {
            pub const name = "transient-for";

            pub const Type = ?*gdk.Surface;
        };
    };

    pub const signals = struct {
        /// Emitted when the size for the surface needs to be computed, when
        /// it is present.
        ///
        /// This signal will normally be emitted during or after a call to
        /// `gdk.Toplevel.present`, depending on the configuration
        /// received by the windowing system. It may also be emitted at any
        /// other point in time, in response to the windowing system
        /// spontaneously changing the configuration of the toplevel surface.
        ///
        /// It is the responsibility of the toplevel user to handle this signal
        /// and compute the desired size of the toplevel, given the information
        /// passed via the `gdk.ToplevelSize` object. Failing to do so
        /// will result in an arbitrary size being used as a result.
        pub const compute_size = struct {
            pub const name = "compute-size";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_size: *gdk.ToplevelSize, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Toplevel, p_instance))),
                    gobject.signalLookup("compute-size", Toplevel.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Begins an interactive move operation.
    ///
    /// You might use this function to implement draggable titlebars.
    extern fn gdk_toplevel_begin_move(p_toplevel: *Toplevel, p_device: *gdk.Device, p_button: c_int, p_x: f64, p_y: f64, p_timestamp: u32) void;
    pub const beginMove = gdk_toplevel_begin_move;

    /// Begins an interactive resize operation.
    ///
    /// You might use this function to implement a “window resize grip.”
    extern fn gdk_toplevel_begin_resize(p_toplevel: *Toplevel, p_edge: gdk.SurfaceEdge, p_device: ?*gdk.Device, p_button: c_int, p_x: f64, p_y: f64, p_timestamp: u32) void;
    pub const beginResize = gdk_toplevel_begin_resize;

    /// Sets keyboard focus to `surface`.
    ///
    /// In most cases, [`gtk_window_present_with_time`](../gtk4/method.Window.present_with_time.html)
    /// should be used on a [GtkWindow](../gtk4/class.Window.html), rather than
    /// calling this function.
    extern fn gdk_toplevel_focus(p_toplevel: *Toplevel, p_timestamp: u32) void;
    pub const focus = gdk_toplevel_focus;

    /// Gets the bitwise or of the currently active surface state flags,
    /// from the `GdkToplevelState` enumeration.
    extern fn gdk_toplevel_get_state(p_toplevel: *Toplevel) gdk.ToplevelState;
    pub const getState = gdk_toplevel_get_state;

    /// Requests that the `toplevel` inhibit the system shortcuts.
    ///
    /// This is asking the desktop environment/windowing system to let all
    /// keyboard events reach the surface, as long as it is focused, instead
    /// of triggering system actions.
    ///
    /// If granted, the rerouting remains active until the default shortcuts
    /// processing is restored with `gdk.Toplevel.restoreSystemShortcuts`,
    /// or the request is revoked by the desktop environment, windowing system
    /// or the user.
    ///
    /// A typical use case for this API is remote desktop or virtual machine
    /// viewers which need to inhibit the default system keyboard shortcuts
    /// so that the remote session or virtual host gets those instead of the
    /// local environment.
    ///
    /// The windowing system or desktop environment may ask the user to grant
    /// or deny the request or even choose to ignore the request entirely.
    ///
    /// The caller can be notified whenever the request is granted or revoked
    /// by listening to the `gdk.Toplevel.properties.shortcuts_inhibited` property.
    extern fn gdk_toplevel_inhibit_system_shortcuts(p_toplevel: *Toplevel, p_event: ?*gdk.Event) void;
    pub const inhibitSystemShortcuts = gdk_toplevel_inhibit_system_shortcuts;

    /// Asks to lower the `toplevel` below other windows.
    ///
    /// The windowing system may choose to ignore the request.
    extern fn gdk_toplevel_lower(p_toplevel: *Toplevel) c_int;
    pub const lower = gdk_toplevel_lower;

    /// Asks to minimize the `toplevel`.
    ///
    /// The windowing system may choose to ignore the request.
    extern fn gdk_toplevel_minimize(p_toplevel: *Toplevel) c_int;
    pub const minimize = gdk_toplevel_minimize;

    /// Present `toplevel` after having processed the `GdkToplevelLayout` rules.
    ///
    /// If the toplevel was previously not showing, it will be showed,
    /// otherwise it will change layout according to `layout`.
    ///
    /// GDK may emit the `gdk.Toplevel.signals.compute_size` signal to let
    /// the user of this toplevel compute the preferred size of the toplevel
    /// surface.
    ///
    /// Presenting is asynchronous and the specified layout parameters are not
    /// guaranteed to be respected.
    extern fn gdk_toplevel_present(p_toplevel: *Toplevel, p_layout: *gdk.ToplevelLayout) void;
    pub const present = gdk_toplevel_present;

    /// Restore default system keyboard shortcuts which were previously
    /// inhibited.
    ///
    /// This undoes the effect of `gdk.Toplevel.inhibitSystemShortcuts`.
    extern fn gdk_toplevel_restore_system_shortcuts(p_toplevel: *Toplevel) void;
    pub const restoreSystemShortcuts = gdk_toplevel_restore_system_shortcuts;

    /// Sets the toplevel to be decorated.
    ///
    /// Setting `decorated` to `FALSE` hints the desktop environment
    /// that the surface has its own, client-side decorations and
    /// does not need to have window decorations added.
    extern fn gdk_toplevel_set_decorated(p_toplevel: *Toplevel, p_decorated: c_int) void;
    pub const setDecorated = gdk_toplevel_set_decorated;

    /// Sets the toplevel to be deletable.
    ///
    /// Setting `deletable` to `TRUE` hints the desktop environment
    /// that it should offer the user a way to close the surface.
    extern fn gdk_toplevel_set_deletable(p_toplevel: *Toplevel, p_deletable: c_int) void;
    pub const setDeletable = gdk_toplevel_set_deletable;

    /// Sets a list of icons for the surface.
    ///
    /// One of these will be used to represent the surface in iconic form.
    /// The icon may be shown in window lists or task bars. Which icon
    /// size is shown depends on the window manager. The window manager
    /// can scale the icon but setting several size icons can give better
    /// image quality.
    ///
    /// Note that some platforms don't support surface icons.
    extern fn gdk_toplevel_set_icon_list(p_toplevel: *Toplevel, p_surfaces: *glib.List) void;
    pub const setIconList = gdk_toplevel_set_icon_list;

    /// Sets the toplevel to be modal.
    ///
    /// The application can use this hint to tell the
    /// window manager that a certain surface has modal
    /// behaviour. The window manager can use this information
    /// to handle modal surfaces in a special way.
    ///
    /// You should only use this on surfaces for which you have
    /// previously called `gdk.Toplevel.setTransientFor`.
    extern fn gdk_toplevel_set_modal(p_toplevel: *Toplevel, p_modal: c_int) void;
    pub const setModal = gdk_toplevel_set_modal;

    /// Sets the startup notification ID.
    ///
    /// When using GTK, typically you should use
    /// [`gtk_window_set_startup_id`](../gtk4/method.Window.set_startup_id.html)
    /// instead of this low-level function.
    extern fn gdk_toplevel_set_startup_id(p_toplevel: *Toplevel, p_startup_id: [*:0]const u8) void;
    pub const setStartupId = gdk_toplevel_set_startup_id;

    /// Sets the title of a toplevel surface.
    ///
    /// The title maybe be displayed in the titlebar,
    /// in lists of windows, etc.
    extern fn gdk_toplevel_set_title(p_toplevel: *Toplevel, p_title: [*:0]const u8) void;
    pub const setTitle = gdk_toplevel_set_title;

    /// Sets a transient-for parent.
    ///
    /// Indicates to the window manager that `surface` is a transient
    /// dialog associated with the application surface `parent`. This
    /// allows the window manager to do things like center `surface`
    /// on `parent` and keep `surface` above `parent`.
    ///
    /// See [`gtk_window_set_transient_for`](../gtk4/method.Window.set_transient_for.html)
    /// if you’re using [GtkWindow](../gtk4/class.Window.html).
    extern fn gdk_toplevel_set_transient_for(p_toplevel: *Toplevel, p_parent: *gdk.Surface) void;
    pub const setTransientFor = gdk_toplevel_set_transient_for;

    /// Asks the windowing system to show the window menu.
    ///
    /// The window menu is the menu shown when right-clicking the titlebar
    /// on traditional windows managed by the window manager. This is useful
    /// for windows using client-side decorations, activating it with a
    /// right-click on the window decorations.
    extern fn gdk_toplevel_show_window_menu(p_toplevel: *Toplevel, p_event: *gdk.Event) c_int;
    pub const showWindowMenu = gdk_toplevel_show_window_menu;

    /// Returns whether the desktop environment supports
    /// tiled window states.
    extern fn gdk_toplevel_supports_edge_constraints(p_toplevel: *Toplevel) c_int;
    pub const supportsEdgeConstraints = gdk_toplevel_supports_edge_constraints;

    /// Performs a title bar gesture.
    extern fn gdk_toplevel_titlebar_gesture(p_toplevel: *Toplevel, p_gesture: gdk.TitlebarGesture) c_int;
    pub const titlebarGesture = gdk_toplevel_titlebar_gesture;

    extern fn gdk_toplevel_get_type() usize;
    pub const getGObjectType = gdk_toplevel_get_type;

    extern fn g_object_ref(p_self: *gdk.Toplevel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Toplevel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Toplevel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CicpParamsClass = opaque {
    pub const Instance = gdk.CicpParams;

    pub fn as(p_instance: *CicpParamsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Provides information to interpret colors and pixels in a variety of ways.
///
/// They are also known as
/// [*color spaces*](https://en.wikipedia.org/wiki/Color_space).
///
/// Crucially, GTK knows how to convert colors from one color
/// state to another.
///
/// `GdkColorState` objects are immutable and therefore threadsafe.
pub const ColorState = opaque {
    /// Returns the color state object representing the oklab color space.
    ///
    /// This is a perceptually uniform color state.
    extern fn gdk_color_state_get_oklab() *gdk.ColorState;
    pub const getOklab = gdk_color_state_get_oklab;

    /// Returns the color state object representing the oklch color space.
    ///
    /// This is the polar variant of oklab, in which the hue is encoded as
    /// a polar coordinate.
    extern fn gdk_color_state_get_oklch() *gdk.ColorState;
    pub const getOklch = gdk_color_state_get_oklch;

    /// Returns the color state object representing the linear rec2100 color space.
    ///
    /// This color state uses the primaries defined by BT.2020-2 and BT.2100-0 and a linear
    /// transfer function.
    ///
    /// It is equivalent to the [Cicp](class.CicpParams.html) tuple 9/8/0/1.
    ///
    /// See e.g. [the CSS HDR Module](https://drafts.csswg.org/css-color-hdr/`valdef`-color-rec2100-linear)
    /// for details about this colorstate.
    extern fn gdk_color_state_get_rec2100_linear() *gdk.ColorState;
    pub const getRec2100Linear = gdk_color_state_get_rec2100_linear;

    /// Returns the color state object representing the rec2100-pq color space.
    ///
    /// This color state uses the primaries defined by BT.2020-2 and BT.2100-0 and the transfer
    /// function defined by SMPTE ST 2084 and BT.2100-2.
    ///
    /// It is equivalent to the [Cicp](class.CicpParams.html) tuple 9/16/0/1.
    ///
    /// See e.g. [the CSS HDR Module](https://drafts.csswg.org/css-color-hdr/`valdef`-color-rec2100-pq)
    /// for details about this colorstate.
    extern fn gdk_color_state_get_rec2100_pq() *gdk.ColorState;
    pub const getRec2100Pq = gdk_color_state_get_rec2100_pq;

    /// Returns the color state object representing the sRGB color space.
    ///
    /// This color state uses the primaries defined by BT.709-6 and the transfer function
    /// defined by IEC 61966-2-1.
    ///
    /// It is equivalent to the [Cicp](class.CicpParams.html) tuple 1/13/0/1.
    ///
    /// See e.g. [the CSS Color Module](https://www.w3.org/TR/css-color-4/`predefined`-sRGB)
    /// for details about this colorstate.
    extern fn gdk_color_state_get_srgb() *gdk.ColorState;
    pub const getSrgb = gdk_color_state_get_srgb;

    /// Returns the color state object representing the linearized sRGB color space.
    ///
    /// This color state uses the primaries defined by BT.709-6 and a linear transfer function.
    ///
    /// It is equivalent to the [Cicp](class.CicpParams.html) tuple 1/8/0/1.
    ///
    /// See e.g. [the CSS Color Module](https://www.w3.org/TR/css-color-4/`predefined`-sRGB-linear)
    /// for details about this colorstate.
    extern fn gdk_color_state_get_srgb_linear() *gdk.ColorState;
    pub const getSrgbLinear = gdk_color_state_get_srgb_linear;

    /// Create a `gdk.CicpParams` representing the colorstate.
    ///
    /// It is not guaranteed that every `GdkColorState` can be
    /// represented with Cicp parameters. If that is the case,
    /// this function returns `NULL`.
    extern fn gdk_color_state_create_cicp_params(p_self: *ColorState) ?*gdk.CicpParams;
    pub const createCicpParams = gdk_color_state_create_cicp_params;

    /// Compares two `GdkColorStates` for equality.
    ///
    /// Note that this function is not guaranteed to be perfect and two objects
    /// describing the same color state may compare not equal. However, different
    /// color states will never compare equal.
    extern fn gdk_color_state_equal(p_self: *ColorState, p_other: *gdk.ColorState) c_int;
    pub const equal = gdk_color_state_equal;

    /// Increase the reference count of `self`.
    extern fn gdk_color_state_ref(p_self: *ColorState) *gdk.ColorState;
    pub const ref = gdk_color_state_ref;

    /// Decrease the reference count of `self`.
    ///
    /// Unless `self` is static, it will be freed
    /// when the reference count reaches zero.
    extern fn gdk_color_state_unref(p_self: *ColorState) void;
    pub const unref = gdk_color_state_unref;

    extern fn gdk_color_state_get_type() usize;
    pub const getGObjectType = gdk_color_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used to advertise and negotiate the format of content.
///
/// You will encounter `GdkContentFormats` when interacting with objects
/// controlling operations that pass data between different widgets, window
/// or application, like `gdk.Drag`, `gdk.Drop`,
/// `gdk.Clipboard` or `gdk.ContentProvider`.
///
/// GDK supports content in 2 forms: `GType` and mime type.
/// Using `GTypes` is meant only for in-process content transfers. Mime types
/// are meant to be used for data passing both in-process and out-of-process.
/// The details of how data is passed is described in the documentation of
/// the actual implementations. To transform between the two forms,
/// `gdk.ContentSerializer` and `gdk.ContentDeserializer` are used.
///
/// A `GdkContentFormats` describes a set of possible formats content can be
/// exchanged in. It is assumed that this set is ordered. `GTypes` are more
/// important than mime types. Order between different `GTypes` or mime types
/// is the order they were added in, most important first. Functions that
/// care about order, such as `gdk.ContentFormats.@"union"`, will describe
/// in their documentation how they interpret that order, though in general the
/// order of the first argument is considered the primary order of the result,
/// followed by the order of further arguments.
///
/// For debugging purposes, the function `gdk.ContentFormats.toString`
/// exists. It will print a comma-separated list of formats from most important
/// to least important.
///
/// `GdkContentFormats` is an immutable struct. After creation, you cannot change
/// the types it represents. Instead, new `GdkContentFormats` have to be created.
/// The `gdk.ContentFormatsBuilder` structure is meant to help in this
/// endeavor.
pub const ContentFormats = opaque {
    /// Parses the given `string` into `GdkContentFormats` and
    /// returns the formats.
    ///
    /// Strings printed via `gdk.ContentFormats.toString`
    /// can be read in again successfully using this function.
    ///
    /// If `string` does not describe valid content formats, `NULL`
    /// is returned.
    extern fn gdk_content_formats_parse(p_string: [*:0]const u8) ?*gdk.ContentFormats;
    pub const parse = gdk_content_formats_parse;

    /// Creates a new `GdkContentFormats` from an array of mime types.
    ///
    /// The mime types must be valid and different from each other or the
    /// behavior of the return value is undefined. If you cannot guarantee
    /// this, use `gdk.ContentFormatsBuilder` instead.
    extern fn gdk_content_formats_new(p_mime_types: ?[*][*:0]const u8, p_n_mime_types: c_uint) *gdk.ContentFormats;
    pub const new = gdk_content_formats_new;

    /// Creates a new `GdkContentFormats` for a given `GType`.
    extern fn gdk_content_formats_new_for_gtype(p_type: usize) *gdk.ContentFormats;
    pub const newForGtype = gdk_content_formats_new_for_gtype;

    /// Checks if a given `GType` is part of the given `formats`.
    extern fn gdk_content_formats_contain_gtype(p_formats: *const ContentFormats, p_type: usize) c_int;
    pub const containGtype = gdk_content_formats_contain_gtype;

    /// Checks if a given mime type is part of the given `formats`.
    extern fn gdk_content_formats_contain_mime_type(p_formats: *const ContentFormats, p_mime_type: [*:0]const u8) c_int;
    pub const containMimeType = gdk_content_formats_contain_mime_type;

    /// Gets the `GType`s included in `formats`.
    ///
    /// Note that `formats` may not contain any `GType`s, in particular when
    /// they are empty. In that case `NULL` will be returned.
    extern fn gdk_content_formats_get_gtypes(p_formats: *const ContentFormats, p_n_gtypes: ?*usize) ?[*:0]const usize;
    pub const getGtypes = gdk_content_formats_get_gtypes;

    /// Gets the mime types included in `formats`.
    ///
    /// Note that `formats` may not contain any mime types, in particular
    /// when they are empty. In that case `NULL` will be returned.
    extern fn gdk_content_formats_get_mime_types(p_formats: *const ContentFormats, p_n_mime_types: ?*usize) ?[*:null]const ?[*:0]const u8;
    pub const getMimeTypes = gdk_content_formats_get_mime_types;

    /// Returns whether the content formats contain any formats.
    extern fn gdk_content_formats_is_empty(p_formats: *ContentFormats) c_int;
    pub const isEmpty = gdk_content_formats_is_empty;

    /// Checks if `first` and `second` have any matching formats.
    extern fn gdk_content_formats_match(p_first: *const ContentFormats, p_second: *const gdk.ContentFormats) c_int;
    pub const match = gdk_content_formats_match;

    /// Finds the first `GType` from `first` that is also contained
    /// in `second`.
    ///
    /// If no matching `GType` is found, `G_TYPE_INVALID` is returned.
    extern fn gdk_content_formats_match_gtype(p_first: *const ContentFormats, p_second: *const gdk.ContentFormats) usize;
    pub const matchGtype = gdk_content_formats_match_gtype;

    /// Finds the first mime type from `first` that is also contained
    /// in `second`.
    ///
    /// If no matching mime type is found, `NULL` is returned.
    extern fn gdk_content_formats_match_mime_type(p_first: *const ContentFormats, p_second: *const gdk.ContentFormats) ?[*:0]const u8;
    pub const matchMimeType = gdk_content_formats_match_mime_type;

    /// Prints the given `formats` into a string for human consumption.
    ///
    /// The result of this function can later be parsed with
    /// `gdk.ContentFormats.parse`.
    extern fn gdk_content_formats_print(p_formats: *ContentFormats, p_string: *glib.String) void;
    pub const print = gdk_content_formats_print;

    /// Increases the reference count of a `GdkContentFormats` by one.
    extern fn gdk_content_formats_ref(p_formats: *ContentFormats) *gdk.ContentFormats;
    pub const ref = gdk_content_formats_ref;

    /// Prints the given `formats` into a human-readable string.
    ///
    /// The resulting string can be parsed with `gdk.ContentFormats.parse`.
    ///
    /// This is a small wrapper around `gdk.ContentFormats.print`
    /// to help when debugging.
    extern fn gdk_content_formats_to_string(p_formats: *ContentFormats) [*:0]u8;
    pub const toString = gdk_content_formats_to_string;

    /// Append all missing types from `second` to `first`, in the order
    /// they had in `second`.
    extern fn gdk_content_formats_union(p_first: *ContentFormats, p_second: *const gdk.ContentFormats) *gdk.ContentFormats;
    pub const @"union" = gdk_content_formats_union;

    /// Add GTypes for mime types in `formats` for which deserializers are
    /// registered.
    extern fn gdk_content_formats_union_deserialize_gtypes(p_formats: *ContentFormats) *gdk.ContentFormats;
    pub const unionDeserializeGtypes = gdk_content_formats_union_deserialize_gtypes;

    /// Add mime types for GTypes in `formats` for which deserializers are
    /// registered.
    extern fn gdk_content_formats_union_deserialize_mime_types(p_formats: *ContentFormats) *gdk.ContentFormats;
    pub const unionDeserializeMimeTypes = gdk_content_formats_union_deserialize_mime_types;

    /// Add GTypes for the mime types in `formats` for which serializers are
    /// registered.
    extern fn gdk_content_formats_union_serialize_gtypes(p_formats: *ContentFormats) *gdk.ContentFormats;
    pub const unionSerializeGtypes = gdk_content_formats_union_serialize_gtypes;

    /// Add mime types for GTypes in `formats` for which serializers are
    /// registered.
    extern fn gdk_content_formats_union_serialize_mime_types(p_formats: *ContentFormats) *gdk.ContentFormats;
    pub const unionSerializeMimeTypes = gdk_content_formats_union_serialize_mime_types;

    /// Decreases the reference count of a `GdkContentFormats` by one.
    ///
    /// If the resulting reference count is zero, frees the formats.
    extern fn gdk_content_formats_unref(p_formats: *ContentFormats) void;
    pub const unref = gdk_content_formats_unref;

    extern fn gdk_content_formats_get_type() usize;
    pub const getGObjectType = gdk_content_formats_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Creates `GdkContentFormats` objects.
pub const ContentFormatsBuilder = opaque {
    /// Create a new `GdkContentFormatsBuilder` object.
    ///
    /// The resulting builder would create an empty `GdkContentFormats`.
    /// Use addition functions to add types to it.
    extern fn gdk_content_formats_builder_new() *gdk.ContentFormatsBuilder;
    pub const new = gdk_content_formats_builder_new;

    /// Appends all formats from `formats` to `builder`, skipping those that
    /// already exist.
    extern fn gdk_content_formats_builder_add_formats(p_builder: *ContentFormatsBuilder, p_formats: *const gdk.ContentFormats) void;
    pub const addFormats = gdk_content_formats_builder_add_formats;

    /// Appends `type` to `builder` if it has not already been added.
    extern fn gdk_content_formats_builder_add_gtype(p_builder: *ContentFormatsBuilder, p_type: usize) void;
    pub const addGtype = gdk_content_formats_builder_add_gtype;

    /// Appends `mime_type` to `builder` if it has not already been added.
    extern fn gdk_content_formats_builder_add_mime_type(p_builder: *ContentFormatsBuilder, p_mime_type: [*:0]const u8) void;
    pub const addMimeType = gdk_content_formats_builder_add_mime_type;

    /// Creates a new `GdkContentFormats` from the current state of the
    /// given `builder`, and frees the `builder` instance.
    extern fn gdk_content_formats_builder_free_to_formats(p_builder: *ContentFormatsBuilder) *gdk.ContentFormats;
    pub const freeToFormats = gdk_content_formats_builder_free_to_formats;

    /// Acquires a reference on the given `builder`.
    ///
    /// This function is intended primarily for bindings.
    /// `GdkContentFormatsBuilder` objects should not be kept around.
    extern fn gdk_content_formats_builder_ref(p_builder: *ContentFormatsBuilder) *gdk.ContentFormatsBuilder;
    pub const ref = gdk_content_formats_builder_ref;

    /// Creates a new `GdkContentFormats` from the given `builder`.
    ///
    /// The given `GdkContentFormatsBuilder` is reset once this function returns;
    /// you cannot call this function multiple times on the same `builder` instance.
    ///
    /// This function is intended primarily for bindings. C code should use
    /// `gdk.ContentFormatsBuilder.freeToFormats`.
    extern fn gdk_content_formats_builder_to_formats(p_builder: *ContentFormatsBuilder) *gdk.ContentFormats;
    pub const toFormats = gdk_content_formats_builder_to_formats;

    /// Releases a reference on the given `builder`.
    extern fn gdk_content_formats_builder_unref(p_builder: *ContentFormatsBuilder) void;
    pub const unref = gdk_content_formats_builder_unref;

    extern fn gdk_content_formats_builder_get_type() usize;
    pub const getGObjectType = gdk_content_formats_builder_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for `GdkContentProvider`.
pub const ContentProviderClass = extern struct {
    pub const Instance = gdk.ContentProvider;

    f_parent_class: gobject.ObjectClass,
    /// Signal class closure for `GdkContentProvider::content-changed`
    f_content_changed: ?*const fn (p_provider: *gdk.ContentProvider) callconv(.c) void,
    f_attach_clipboard: ?*const fn (p_provider: *gdk.ContentProvider, p_clipboard: *gdk.Clipboard) callconv(.c) void,
    f_detach_clipboard: ?*const fn (p_provider: *gdk.ContentProvider, p_clipboard: *gdk.Clipboard) callconv(.c) void,
    f_ref_formats: ?*const fn (p_provider: *gdk.ContentProvider) callconv(.c) *gdk.ContentFormats,
    f_ref_storable_formats: ?*const fn (p_provider: *gdk.ContentProvider) callconv(.c) *gdk.ContentFormats,
    f_write_mime_type_async: ?*const fn (p_provider: *gdk.ContentProvider, p_mime_type: [*:0]const u8, p_stream: *gio.OutputStream, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) callconv(.c) void,
    f_write_mime_type_finish: ?*const fn (p_provider: *gdk.ContentProvider, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_get_value: ?*const fn (p_provider: *gdk.ContentProvider, p_value: *gobject.Value, p_error: ?*?*glib.Error) callconv(.c) c_int,
    f_padding: [8]*anyopaque,

    pub fn as(p_instance: *ContentProviderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DevicePadInterface = opaque {
    pub const Instance = gdk.DevicePad;

    pub fn as(p_instance: *DevicePadInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Provides information about supported DMA buffer formats.
///
/// You can query whether a given format is supported with
/// `gdk.DmabufFormats.contains` and you can iterate
/// over the list of all supported formats with
/// `gdk.DmabufFormats.getNFormats` and
/// `gdk.DmabufFormats.getFormat`.
///
/// The list of supported formats is sorted by preference,
/// with the best formats coming first.
///
/// The list may contains (format, modifier) pairs where the modifier
/// is `DMA_FORMAT_MOD_INVALID`, indicating that **_implicit modifiers_**
/// may be used with this format.
///
/// See `gdk.DmabufTextureBuilder` for more information
/// about DMA buffers.
///
/// Note that DMA buffers only exist on Linux.
pub const DmabufFormats = opaque {
    /// Returns whether a given format is contained in `formats`.
    extern fn gdk_dmabuf_formats_contains(p_formats: *DmabufFormats, p_fourcc: u32, p_modifier: u64) c_int;
    pub const contains = gdk_dmabuf_formats_contains;

    /// Returns whether `formats1` and `formats2` contain the
    /// same dmabuf formats, in the same order.
    extern fn gdk_dmabuf_formats_equal(p_formats1: ?*const DmabufFormats, p_formats2: ?*const gdk.DmabufFormats) c_int;
    pub const equal = gdk_dmabuf_formats_equal;

    /// Gets the fourcc code and modifier for a format
    /// that is contained in `formats`.
    extern fn gdk_dmabuf_formats_get_format(p_formats: *DmabufFormats, p_idx: usize, p_fourcc: *u32, p_modifier: *u64) void;
    pub const getFormat = gdk_dmabuf_formats_get_format;

    /// Returns the number of formats that the `formats` object
    /// contains.
    ///
    /// Note that DMA buffers are a Linux concept, so on other
    /// platforms, `gdk.DmabufFormats.getNFormats` will
    /// always return zero.
    extern fn gdk_dmabuf_formats_get_n_formats(p_formats: *DmabufFormats) usize;
    pub const getNFormats = gdk_dmabuf_formats_get_n_formats;

    /// Increases the reference count of `formats`.
    extern fn gdk_dmabuf_formats_ref(p_formats: *DmabufFormats) *gdk.DmabufFormats;
    pub const ref = gdk_dmabuf_formats_ref;

    /// Decreases the reference count of `formats`.
    ///
    /// When the reference count reaches zero,
    /// the object is freed.
    extern fn gdk_dmabuf_formats_unref(p_formats: *DmabufFormats) void;
    pub const unref = gdk_dmabuf_formats_unref;

    extern fn gdk_dmabuf_formats_get_type() usize;
    pub const getGObjectType = gdk_dmabuf_formats_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DmabufTextureBuilderClass = opaque {
    pub const Instance = gdk.DmabufTextureBuilder;

    pub fn as(p_instance: *DmabufTextureBuilderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DmabufTextureClass = opaque {
    pub const Instance = gdk.DmabufTexture;

    pub fn as(p_instance: *DmabufTextureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `GdkDragSurfaceInterface` implementation is private to GDK.
pub const DragSurfaceInterface = opaque {
    pub const Instance = gdk.DragSurface;

    pub fn as(p_instance: *DragSurfaceInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains information that is useful to compute the size of a drag surface.
pub const DragSurfaceSize = opaque {
    /// Sets the size the drag surface prefers to be resized to.
    extern fn gdk_drag_surface_size_set_size(p_size: *DragSurfaceSize, p_width: c_int, p_height: c_int) void;
    pub const setSize = gdk_drag_surface_size_set_size;

    extern fn gdk_drag_surface_size_get_type() usize;
    pub const getGObjectType = gdk_drag_surface_size_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque type representing a sequence of related events.
pub const EventSequence = opaque {
    extern fn gdk_event_sequence_get_type() usize;
    pub const getGObjectType = gdk_event_sequence_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque type representing a list of files.
pub const FileList = opaque {
    /// Creates a new `GdkFileList` for the given array of files.
    ///
    /// This function is meant to be used by language bindings.
    extern fn gdk_file_list_new_from_array(p_files: [*]*gio.File, p_n_files: usize) *gdk.FileList;
    pub const newFromArray = gdk_file_list_new_from_array;

    /// Creates a new files list container from a singly linked list of
    /// `GFile` instances.
    ///
    /// This function is meant to be used by language bindings
    extern fn gdk_file_list_new_from_list(p_files: *glib.SList) *gdk.FileList;
    pub const newFromList = gdk_file_list_new_from_list;

    /// Retrieves the list of files inside a `GdkFileList`.
    ///
    /// This function is meant for language bindings.
    extern fn gdk_file_list_get_files(p_file_list: *FileList) *glib.SList;
    pub const getFiles = gdk_file_list_get_files;

    extern fn gdk_file_list_get_type() usize;
    pub const getGObjectType = gdk_file_list_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameClockClass = opaque {
    pub const Instance = gdk.FrameClock;

    pub fn as(p_instance: *FrameClockClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameClockPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Holds timing information for a single frame of the application’s displays.
///
/// To retrieve `GdkFrameTimings` objects, use `gdk.FrameClock.getTimings`
/// or `gdk.FrameClock.getCurrentTimings`. The information in
/// `GdkFrameTimings` is useful for precise synchronization of video with
/// the event or audio streams, and for measuring quality metrics for the
/// application’s display, such as latency and jitter.
pub const FrameTimings = opaque {
    /// Returns whether `timings` are complete.
    ///
    /// The timing information in a `GdkFrameTimings` is filled in
    /// incrementally as the frame as drawn and passed off to the
    /// window system for processing and display to the user. The
    /// accessor functions for `GdkFrameTimings` can return 0 to
    /// indicate an unavailable value for two reasons: either because
    /// the information is not yet available, or because it isn't
    /// available at all.
    ///
    /// Once this function returns `TRUE` for a frame, you can be
    /// certain that no further values will become available and be
    /// stored in the `GdkFrameTimings`.
    extern fn gdk_frame_timings_get_complete(p_timings: *FrameTimings) c_int;
    pub const getComplete = gdk_frame_timings_get_complete;

    /// Gets the frame counter value of the `GdkFrameClock` when
    /// this frame was drawn.
    extern fn gdk_frame_timings_get_frame_counter(p_timings: *FrameTimings) i64;
    pub const getFrameCounter = gdk_frame_timings_get_frame_counter;

    /// Returns the frame time for the frame.
    ///
    /// This is the time value that is typically used to time
    /// animations for the frame. See `gdk.FrameClock.getFrameTime`.
    extern fn gdk_frame_timings_get_frame_time(p_timings: *FrameTimings) i64;
    pub const getFrameTime = gdk_frame_timings_get_frame_time;

    /// Gets the predicted time at which this frame will be displayed.
    ///
    /// Although no predicted time may be available, if one is available,
    /// it will be available while the frame is being generated, in contrast
    /// to `gdk.FrameTimings.getPresentationTime`, which is only
    /// available after the frame has been presented.
    ///
    /// In general, if you are simply animating, you should use
    /// `gdk.FrameClock.getFrameTime` rather than this function,
    /// but this function is useful for applications that want exact control
    /// over latency. For example, a movie player may want this information
    /// for Audio/Video synchronization.
    extern fn gdk_frame_timings_get_predicted_presentation_time(p_timings: *FrameTimings) i64;
    pub const getPredictedPresentationTime = gdk_frame_timings_get_predicted_presentation_time;

    /// Reurns the presentation time.
    ///
    /// This is the time at which the frame became visible to the user.
    extern fn gdk_frame_timings_get_presentation_time(p_timings: *FrameTimings) i64;
    pub const getPresentationTime = gdk_frame_timings_get_presentation_time;

    /// Gets the natural interval between presentation times for
    /// the display that this frame was displayed on.
    ///
    /// Frame presentation usually happens during the “vertical
    /// blanking interval”.
    extern fn gdk_frame_timings_get_refresh_interval(p_timings: *FrameTimings) i64;
    pub const getRefreshInterval = gdk_frame_timings_get_refresh_interval;

    /// Increases the reference count of `timings`.
    extern fn gdk_frame_timings_ref(p_timings: *FrameTimings) *gdk.FrameTimings;
    pub const ref = gdk_frame_timings_ref;

    /// Decreases the reference count of `timings`.
    ///
    /// If `timings` is no longer referenced, it will be freed.
    extern fn gdk_frame_timings_unref(p_timings: *FrameTimings) void;
    pub const unref = gdk_frame_timings_unref;

    extern fn gdk_frame_timings_get_type() usize;
    pub const getGObjectType = gdk_frame_timings_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GLTextureBuilderClass = opaque {
    pub const Instance = gdk.GLTextureBuilder;

    pub fn as(p_instance: *GLTextureBuilderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GLTextureClass = opaque {
    pub const Instance = gdk.GLTexture;

    pub fn as(p_instance: *GLTextureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a hardware key that can be mapped to a keyval.
pub const KeymapKey = extern struct {
    /// the hardware keycode. This is an identifying number for a
    ///   physical key.
    f_keycode: c_uint,
    /// indicates movement in a horizontal direction. Usually groups are used
    ///   for two different languages. In group 0, a key might have two English
    ///   characters, and in group 1 it might have two Hebrew characters. The Hebrew
    ///   characters will be printed on the key next to the English characters.
    f_group: c_int,
    /// indicates which symbol on the key will be used, in a vertical direction.
    ///   So on a standard US keyboard, the key with the number “1” on it also has the
    ///   exclamation point ("!") character on it. The level indicates whether to use
    ///   the “1” or the “!” symbol. The letter keys are considered to have a lowercase
    ///   letter at level 0, and an uppercase letter at level 1, though only the
    ///   uppercase letter is printed.
    f_level: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MemoryTextureBuilderClass = opaque {
    pub const Instance = gdk.MemoryTextureBuilder;

    pub fn as(p_instance: *MemoryTextureBuilderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MemoryTextureClass = opaque {
    pub const Instance = gdk.MemoryTexture;

    pub fn as(p_instance: *MemoryTextureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MonitorClass = opaque {
    pub const Instance = gdk.Monitor;

    pub fn as(p_instance: *MonitorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The list of functions that can be implemented for the `GdkPaintable`
/// interface.
///
/// Note that apart from the `gdk.Paintable.virtual_methods.snapshot` function,
/// no virtual function of this interface is mandatory to implement, though it
/// is a good idea to implement `gdk.Paintable.virtual_methods.get_current_image`
/// for non-static paintables and `gdk.Paintable.virtual_methods.get_flags` if the
/// image is not dynamic as the default implementation returns no flags and
/// that will make the implementation likely quite slow.
pub const PaintableInterface = extern struct {
    pub const Instance = gdk.Paintable;

    f_g_iface: gobject.TypeInterface,
    /// Snapshot the paintable. The given `width` and `height` are
    ///   guaranteed to be larger than 0.0. The resulting snapshot must modify
    ///   only the area in the rectangle from (0,0) to (width, height).
    ///   This is the only function that must be implemented for this interface.
    f_snapshot: ?*const fn (p_paintable: *gdk.Paintable, p_snapshot: *gdk.Snapshot, p_width: f64, p_height: f64) callconv(.c) void,
    /// return a `GdkPaintable` that does not change over
    ///   time. This means the `GDK_PAINTABLE_STATIC_SIZE` and
    ///   `GDK_PAINTABLE_STATIC_CONTENTS` flag are set.
    f_get_current_image: ?*const fn (p_paintable: *gdk.Paintable) callconv(.c) *gdk.Paintable,
    /// Get the flags for this instance. See `gdk.PaintableFlags`
    ///   for details.
    f_get_flags: ?*const fn (p_paintable: *gdk.Paintable) callconv(.c) gdk.PaintableFlags,
    /// The preferred width for this object to be
    ///   snapshot at or 0 if none. This is purely a hint. The object must still
    ///   be able to render at any size.
    f_get_intrinsic_width: ?*const fn (p_paintable: *gdk.Paintable) callconv(.c) c_int,
    /// The preferred height for this object to be
    ///   snapshot at or 0 if none. This is purely a hint. The object must still
    ///   be able to render at any size.
    f_get_intrinsic_height: ?*const fn (p_paintable: *gdk.Paintable) callconv(.c) c_int,
    /// The preferred aspect ratio for this object
    ///   or 0 if none. If both `gdk.Paintable.virtual_methods.get_intrinsic_width`
    ///   and `gdk.Paintable.virtual_methods.get_intrinsic_height` return non-zero
    ///   values, this function should return the aspect ratio computed from those.
    f_get_intrinsic_aspect_ratio: ?*const fn (p_paintable: *gdk.Paintable) callconv(.c) f64,

    pub fn as(p_instance: *PaintableInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PopupInterface = opaque {
    pub const Instance = gdk.Popup;

    pub fn as(p_instance: *PopupInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains information that is necessary position a `gdk.Popup`
/// relative to its parent.
///
/// The positioning requires a negotiation with the windowing system,
/// since it depends on external constraints, such as the position of
/// the parent surface, and the screen dimensions.
///
/// The basic ingredients are a rectangle on the parent surface,
/// and the anchor on both that rectangle and the popup. The anchors
/// specify a side or corner to place next to each other.
///
/// ![Popup anchors](popup-anchors.png)
///
/// For cases where placing the anchors next to each other would make
/// the popup extend offscreen, the layout includes some hints for how
/// to resolve this problem. The hints may suggest to flip the anchor
/// position to the other side, or to 'slide' the popup along a side,
/// or to resize it.
///
/// ![Flipping popups](popup-flip.png)
///
/// ![Sliding popups](popup-slide.png)
///
/// These hints may be combined.
///
/// Ultimatively, it is up to the windowing system to determine the position
/// and size of the popup. You can learn about the result by calling
/// `gdk.Popup.getPositionX`, `gdk.Popup.getPositionY`,
/// `gdk.Popup.getRectAnchor` and `gdk.Popup.getSurfaceAnchor`
/// after the popup has been presented. This can be used to adjust the rendering.
/// For example, [GtkPopover](../gtk4/class.Popover.html) changes its arrow position
/// accordingly. But you have to be careful avoid changing the size of the popover,
/// or it has to be presented again.
pub const PopupLayout = opaque {
    /// Create a popup layout description.
    ///
    /// Used together with `gdk.Popup.present` to describe how a popup
    /// surface should be placed and behave on-screen.
    ///
    /// `anchor_rect` is relative to the top-left corner of the surface's parent.
    /// `rect_anchor` and `surface_anchor` determine anchor points on `anchor_rect`
    /// and surface to pin together.
    ///
    /// The position of `anchor_rect`'s anchor point can optionally be offset using
    /// `gdk.PopupLayout.setOffset`, which is equivalent to offsetting the
    /// position of surface.
    extern fn gdk_popup_layout_new(p_anchor_rect: *const gdk.Rectangle, p_rect_anchor: gdk.Gravity, p_surface_anchor: gdk.Gravity) *gdk.PopupLayout;
    pub const new = gdk_popup_layout_new;

    /// Makes a copy of `layout`.
    extern fn gdk_popup_layout_copy(p_layout: *PopupLayout) *gdk.PopupLayout;
    pub const copy = gdk_popup_layout_copy;

    /// Check whether `layout` and `other` has identical layout properties.
    extern fn gdk_popup_layout_equal(p_layout: *PopupLayout, p_other: *gdk.PopupLayout) c_int;
    pub const equal = gdk_popup_layout_equal;

    /// Get the `GdkAnchorHints`.
    extern fn gdk_popup_layout_get_anchor_hints(p_layout: *PopupLayout) gdk.AnchorHints;
    pub const getAnchorHints = gdk_popup_layout_get_anchor_hints;

    /// Get the anchor rectangle.
    extern fn gdk_popup_layout_get_anchor_rect(p_layout: *PopupLayout) *const gdk.Rectangle;
    pub const getAnchorRect = gdk_popup_layout_get_anchor_rect;

    /// Retrieves the offset for the anchor rectangle.
    extern fn gdk_popup_layout_get_offset(p_layout: *PopupLayout, p_dx: *c_int, p_dy: *c_int) void;
    pub const getOffset = gdk_popup_layout_get_offset;

    /// Returns the anchor position on the anchor rectangle.
    extern fn gdk_popup_layout_get_rect_anchor(p_layout: *PopupLayout) gdk.Gravity;
    pub const getRectAnchor = gdk_popup_layout_get_rect_anchor;

    /// Obtains the shadow widths of this layout.
    extern fn gdk_popup_layout_get_shadow_width(p_layout: *PopupLayout, p_left: *c_int, p_right: *c_int, p_top: *c_int, p_bottom: *c_int) void;
    pub const getShadowWidth = gdk_popup_layout_get_shadow_width;

    /// Returns the anchor position on the popup surface.
    extern fn gdk_popup_layout_get_surface_anchor(p_layout: *PopupLayout) gdk.Gravity;
    pub const getSurfaceAnchor = gdk_popup_layout_get_surface_anchor;

    /// Increases the reference count of `value`.
    extern fn gdk_popup_layout_ref(p_layout: *PopupLayout) *gdk.PopupLayout;
    pub const ref = gdk_popup_layout_ref;

    /// Set new anchor hints.
    ///
    /// The set `anchor_hints` determines how `surface` will be moved
    /// if the anchor points cause it to move off-screen. For example,
    /// `GDK_ANCHOR_FLIP_X` will replace `GDK_GRAVITY_NORTH_WEST` with
    /// `GDK_GRAVITY_NORTH_EAST` and vice versa if `surface` extends
    /// beyond the left or right edges of the monitor.
    extern fn gdk_popup_layout_set_anchor_hints(p_layout: *PopupLayout, p_anchor_hints: gdk.AnchorHints) void;
    pub const setAnchorHints = gdk_popup_layout_set_anchor_hints;

    /// Set the anchor rectangle.
    extern fn gdk_popup_layout_set_anchor_rect(p_layout: *PopupLayout, p_anchor_rect: *const gdk.Rectangle) void;
    pub const setAnchorRect = gdk_popup_layout_set_anchor_rect;

    /// Offset the position of the anchor rectangle with the given delta.
    extern fn gdk_popup_layout_set_offset(p_layout: *PopupLayout, p_dx: c_int, p_dy: c_int) void;
    pub const setOffset = gdk_popup_layout_set_offset;

    /// Set the anchor on the anchor rectangle.
    extern fn gdk_popup_layout_set_rect_anchor(p_layout: *PopupLayout, p_anchor: gdk.Gravity) void;
    pub const setRectAnchor = gdk_popup_layout_set_rect_anchor;

    /// Sets the shadow width of the popup.
    ///
    /// The shadow width corresponds to the part of the computed
    /// surface size that would consist of the shadow margin
    /// surrounding the window, would there be any.
    extern fn gdk_popup_layout_set_shadow_width(p_layout: *PopupLayout, p_left: c_int, p_right: c_int, p_top: c_int, p_bottom: c_int) void;
    pub const setShadowWidth = gdk_popup_layout_set_shadow_width;

    /// Set the anchor on the popup surface.
    extern fn gdk_popup_layout_set_surface_anchor(p_layout: *PopupLayout, p_anchor: gdk.Gravity) void;
    pub const setSurfaceAnchor = gdk_popup_layout_set_surface_anchor;

    /// Decreases the reference count of `value`.
    extern fn gdk_popup_layout_unref(p_layout: *PopupLayout) void;
    pub const unref = gdk_popup_layout_unref;

    extern fn gdk_popup_layout_get_type() usize;
    pub const getGObjectType = gdk_popup_layout_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a color, in a way that is compatible with cairo’s notion of color.
///
/// `GdkRGBA` is a convenient way to pass colors around. It’s based on
/// cairo’s way to deal with colors and mirrors its behavior. All values
/// are in the range from 0.0 to 1.0 inclusive. So the color
/// (0.0, 0.0, 0.0, 0.0) represents transparent black and
/// (1.0, 1.0, 1.0, 1.0) is opaque white. Other values will
/// be clamped to this range when drawing.
pub const RGBA = extern struct {
    /// The intensity of the red channel from 0.0 to 1.0 inclusive
    f_red: f32,
    /// The intensity of the green channel from 0.0 to 1.0 inclusive
    f_green: f32,
    /// The intensity of the blue channel from 0.0 to 1.0 inclusive
    f_blue: f32,
    /// The opacity of the color from 0.0 for completely translucent to
    ///   1.0 for opaque
    f_alpha: f32,

    /// Makes a copy of a `GdkRGBA`.
    ///
    /// The result must be freed through `gdk.RGBA.free`.
    extern fn gdk_rgba_copy(p_rgba: *const RGBA) *gdk.RGBA;
    pub const copy = gdk_rgba_copy;

    /// Compares two `GdkRGBA` colors.
    extern fn gdk_rgba_equal(p_p1: *const RGBA, p_p2: *const gdk.RGBA) c_int;
    pub const equal = gdk_rgba_equal;

    /// Frees a `GdkRGBA`.
    extern fn gdk_rgba_free(p_rgba: *RGBA) void;
    pub const free = gdk_rgba_free;

    /// A hash function suitable for using for a hash
    /// table that stores `GdkRGBA`s.
    extern fn gdk_rgba_hash(p_p: *const RGBA) c_uint;
    pub const hash = gdk_rgba_hash;

    /// Checks if an `rgba` value is transparent.
    ///
    /// That is, drawing with the value would not produce any change.
    extern fn gdk_rgba_is_clear(p_rgba: *const RGBA) c_int;
    pub const isClear = gdk_rgba_is_clear;

    /// Checks if an `rgba` value is opaque.
    ///
    /// That is, drawing with the value will not retain any results
    /// from previous contents.
    extern fn gdk_rgba_is_opaque(p_rgba: *const RGBA) c_int;
    pub const isOpaque = gdk_rgba_is_opaque;

    /// Parses a textual representation of a color.
    ///
    /// The string can be either one of:
    ///
    /// - A standard name (Taken from the CSS specification).
    /// - A hexadecimal value in the form “\#rgb”, “\#rrggbb”,
    ///   “\#rrrgggbbb” or ”\#rrrrggggbbbb”
    /// - A hexadecimal value in the form “\#rgba”, “\#rrggbbaa”,
    ///   or ”\#rrrrggggbbbbaaaa”
    /// - A RGB color in the form “rgb(r,g,b)” (In this case the color
    ///   will have full opacity)
    /// - A RGBA color in the form “rgba(r,g,b,a)”
    /// - A HSL color in the form "hsl(hue, saturation, lightness)"
    /// - A HSLA color in the form "hsla(hue, saturation, lightness, alpha)"
    ///
    /// Where “r”, “g”, “b” and “a” are respectively the red, green,
    /// blue and alpha color values. In the last two cases, “r”, “g”,
    /// and “b” are either integers in the range 0 to 255 or percentage
    /// values in the range 0% to 100%, and a is a floating point value
    /// in the range 0 to 1.
    extern fn gdk_rgba_parse(p_rgba: *RGBA, p_spec: [*:0]const u8) c_int;
    pub const parse = gdk_rgba_parse;

    /// Returns a textual specification of `rgba` in the form
    /// `rgb(r,g,b)` or `rgba(r,g,b,a)`, where “r”, “g”, “b” and
    /// “a” represent the red, green, blue and alpha values
    /// respectively. “r”, “g”, and “b” are represented as integers
    /// in the range 0 to 255, and “a” is represented as a floating
    /// point value in the range 0 to 1.
    ///
    /// These string forms are string forms that are supported by
    /// the CSS3 colors module, and can be parsed by `gdk.RGBA.parse`.
    ///
    /// Note that this string representation may lose some precision,
    /// since “r”, “g” and “b” are represented as 8-bit integers. If
    /// this is a concern, you should use a different representation.
    extern fn gdk_rgba_to_string(p_rgba: *const RGBA) [*:0]u8;
    pub const toString = gdk_rgba_to_string;

    extern fn gdk_rgba_get_type() usize;
    pub const getGObjectType = gdk_rgba_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a rectangle.
///
/// `GdkRectangle` is identical to `cairo_rectangle_t`. Together with Cairo’s
/// `cairo_region_t` data type, these are the central types for representing
/// sets of pixels.
///
/// The intersection of two rectangles can be computed with
/// `gdk.Rectangle.intersect`; to find the union of two rectangles use
/// `gdk.Rectangle.@"union"`.
///
/// The `cairo_region_t` type provided by Cairo is usually used for managing
/// non-rectangular clipping of graphical operations.
///
/// The Graphene library has a number of other data types for regions and
/// volumes in 2D and 3D.
pub const Rectangle = extern struct {
    /// the x coordinate of the top left corner
    f_x: c_int,
    /// the y coordinate of the top left corner
    f_y: c_int,
    /// the width of the rectangle
    f_width: c_int,
    /// the height of the rectangle
    f_height: c_int,

    /// Returns `TRUE` if `rect` contains the point described by `x` and `y`.
    extern fn gdk_rectangle_contains_point(p_rect: *const Rectangle, p_x: c_int, p_y: c_int) c_int;
    pub const containsPoint = gdk_rectangle_contains_point;

    /// Checks if the two given rectangles are equal.
    extern fn gdk_rectangle_equal(p_rect1: *const Rectangle, p_rect2: *const gdk.Rectangle) c_int;
    pub const equal = gdk_rectangle_equal;

    /// Calculates the intersection of two rectangles.
    ///
    /// It is allowed for `dest` to be the same as either `src1` or `src2`.
    /// If the rectangles do not intersect, `dest`’s width and height is set
    /// to 0 and its x and y values are undefined. If you are only interested
    /// in whether the rectangles intersect, but not in the intersecting area
    /// itself, pass `NULL` for `dest`.
    extern fn gdk_rectangle_intersect(p_src1: *const Rectangle, p_src2: *const gdk.Rectangle, p_dest: ?*gdk.Rectangle) c_int;
    pub const intersect = gdk_rectangle_intersect;

    /// Calculates the union of two rectangles.
    ///
    /// The union of rectangles `src1` and `src2` is the smallest rectangle which
    /// includes both `src1` and `src2` within it. It is allowed for `dest` to be
    /// the same as either `src1` or `src2`.
    ///
    /// Note that this function does not ignore 'empty' rectangles (ie. with
    /// zero width or height).
    extern fn gdk_rectangle_union(p_src1: *const Rectangle, p_src2: *const gdk.Rectangle, p_dest: *gdk.Rectangle) void;
    pub const @"union" = gdk_rectangle_union;

    extern fn gdk_rectangle_get_type() usize;
    pub const getGObjectType = gdk_rectangle_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SnapshotClass = opaque {
    pub const Instance = gdk.Snapshot;

    pub fn as(p_instance: *SnapshotClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SurfaceClass = opaque {
    pub const Instance = gdk.Surface;

    pub fn as(p_instance: *SurfaceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextureClass = opaque {
    pub const Instance = gdk.Texture;

    pub fn as(p_instance: *TextureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used to download the contents of a `gdk.Texture`.
///
/// It is intended to be created as a short-term object for a single download,
/// but can be used for multiple downloads of different textures or with different
/// settings.
///
/// `GdkTextureDownloader` can be used to convert data between different formats.
/// Create a `GdkTexture` for the existing format and then download it in a
/// different format.
pub const TextureDownloader = opaque {
    /// Creates a new texture downloader for `texture`.
    ///
    /// By default, the downloader will convert the data to
    /// the default memory format, and to the sRGB color state.
    extern fn gdk_texture_downloader_new(p_texture: *gdk.Texture) *gdk.TextureDownloader;
    pub const new = gdk_texture_downloader_new;

    /// Creates a copy of the downloader.
    ///
    /// This function is meant for language bindings.
    extern fn gdk_texture_downloader_copy(p_self: *const TextureDownloader) *gdk.TextureDownloader;
    pub const copy = gdk_texture_downloader_copy;

    /// Downloads the given texture pixels into a `GBytes`. The rowstride will
    /// be stored in the stride value.
    ///
    /// This function will abort if it tries to download a large texture and
    /// fails to allocate memory. If you think that may happen, you should handle
    /// memory allocation yourself and use `gdk.TextureDownloader.downloadInto`
    /// once allocation succeeded.
    extern fn gdk_texture_downloader_download_bytes(p_self: *const TextureDownloader, p_out_stride: *usize) *glib.Bytes;
    pub const downloadBytes = gdk_texture_downloader_download_bytes;

    /// Downloads the `texture` into local memory.
    extern fn gdk_texture_downloader_download_into(p_self: *const TextureDownloader, p_data: [*]u8, p_stride: usize) void;
    pub const downloadInto = gdk_texture_downloader_download_into;

    /// Frees the given downloader and all its associated resources.
    extern fn gdk_texture_downloader_free(p_self: *TextureDownloader) void;
    pub const free = gdk_texture_downloader_free;

    /// Gets the color state that the data will be downloaded in.
    extern fn gdk_texture_downloader_get_color_state(p_self: *const TextureDownloader) *gdk.ColorState;
    pub const getColorState = gdk_texture_downloader_get_color_state;

    /// Gets the format that the data will be downloaded in.
    extern fn gdk_texture_downloader_get_format(p_self: *const TextureDownloader) gdk.MemoryFormat;
    pub const getFormat = gdk_texture_downloader_get_format;

    /// Gets the texture that the downloader will download.
    extern fn gdk_texture_downloader_get_texture(p_self: *const TextureDownloader) *gdk.Texture;
    pub const getTexture = gdk_texture_downloader_get_texture;

    /// Sets the color state the downloader will convert the data to.
    ///
    /// By default, the sRGB colorstate returned by `ColorState.getSrgb`
    /// is used.
    extern fn gdk_texture_downloader_set_color_state(p_self: *TextureDownloader, p_color_state: *gdk.ColorState) void;
    pub const setColorState = gdk_texture_downloader_set_color_state;

    /// Sets the format the downloader will download.
    ///
    /// By default, GDK_MEMORY_DEFAULT is set.
    extern fn gdk_texture_downloader_set_format(p_self: *TextureDownloader, p_format: gdk.MemoryFormat) void;
    pub const setFormat = gdk_texture_downloader_set_format;

    /// Changes the texture the downloader will download.
    extern fn gdk_texture_downloader_set_texture(p_self: *TextureDownloader, p_texture: *gdk.Texture) void;
    pub const setTexture = gdk_texture_downloader_set_texture;

    extern fn gdk_texture_downloader_get_type() usize;
    pub const getGObjectType = gdk_texture_downloader_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Stores a single event in a motion history.
///
/// To check whether an axis is present, check whether the corresponding
/// flag from the `gdk.AxisFlags` enumeration is set in the `flags`
/// To access individual axis values, use the values of the values of
/// the `gdk.AxisUse` enumerations as indices.
pub const TimeCoord = extern struct {
    /// The timestamp for this event
    f_time: u32,
    /// Flags indicating what axes are present, see `gdk.AxisFlags`
    f_flags: gdk.AxisFlags,
    /// axis values, indexed by `gdk.AxisUse`
    f_axes: [12]f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ToplevelInterface = opaque {
    pub const Instance = gdk.Toplevel;

    pub fn as(p_instance: *ToplevelInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains information that is necessary to present a sovereign
/// window on screen.
///
/// The `GdkToplevelLayout` struct is necessary for using
/// `gdk.Toplevel.present`.
///
/// Toplevel surfaces are sovereign windows that can be presented
/// to the user in various states (maximized, on all workspaces,
/// etc).
pub const ToplevelLayout = opaque {
    /// Create a toplevel layout description.
    ///
    /// Used together with `gdk.Toplevel.present` to describe
    /// how a toplevel surface should be placed and behave on-screen.
    ///
    /// The size is in ”application pixels”, not
    /// ”device pixels” (see `gdk.Surface.getScaleFactor`).
    extern fn gdk_toplevel_layout_new() *gdk.ToplevelLayout;
    pub const new = gdk_toplevel_layout_new;

    /// Create a new `GdkToplevelLayout` and copy the contents of `layout` into it.
    extern fn gdk_toplevel_layout_copy(p_layout: *ToplevelLayout) *gdk.ToplevelLayout;
    pub const copy = gdk_toplevel_layout_copy;

    /// Check whether `layout` and `other` has identical layout properties.
    extern fn gdk_toplevel_layout_equal(p_layout: *ToplevelLayout, p_other: *gdk.ToplevelLayout) c_int;
    pub const equal = gdk_toplevel_layout_equal;

    /// If the layout specifies whether to the toplevel should go fullscreen,
    /// the value pointed to by `fullscreen` is set to `TRUE` if it should go
    /// fullscreen, or `FALSE`, if it should go unfullscreen.
    extern fn gdk_toplevel_layout_get_fullscreen(p_layout: *ToplevelLayout, p_fullscreen: *c_int) c_int;
    pub const getFullscreen = gdk_toplevel_layout_get_fullscreen;

    /// Returns the monitor that the layout is fullscreening
    /// the surface on.
    extern fn gdk_toplevel_layout_get_fullscreen_monitor(p_layout: *ToplevelLayout) ?*gdk.Monitor;
    pub const getFullscreenMonitor = gdk_toplevel_layout_get_fullscreen_monitor;

    /// If the layout specifies whether to the toplevel should go maximized,
    /// the value pointed to by `maximized` is set to `TRUE` if it should go
    /// fullscreen, or `FALSE`, if it should go unmaximized.
    extern fn gdk_toplevel_layout_get_maximized(p_layout: *ToplevelLayout, p_maximized: *c_int) c_int;
    pub const getMaximized = gdk_toplevel_layout_get_maximized;

    /// Returns whether the layout should allow the user
    /// to resize the surface.
    extern fn gdk_toplevel_layout_get_resizable(p_layout: *ToplevelLayout) c_int;
    pub const getResizable = gdk_toplevel_layout_get_resizable;

    /// Increases the reference count of `layout`.
    extern fn gdk_toplevel_layout_ref(p_layout: *ToplevelLayout) *gdk.ToplevelLayout;
    pub const ref = gdk_toplevel_layout_ref;

    /// Sets whether the layout should cause the surface
    /// to be fullscreen when presented.
    extern fn gdk_toplevel_layout_set_fullscreen(p_layout: *ToplevelLayout, p_fullscreen: c_int, p_monitor: ?*gdk.Monitor) void;
    pub const setFullscreen = gdk_toplevel_layout_set_fullscreen;

    /// Sets whether the layout should cause the surface
    /// to be maximized when presented.
    extern fn gdk_toplevel_layout_set_maximized(p_layout: *ToplevelLayout, p_maximized: c_int) void;
    pub const setMaximized = gdk_toplevel_layout_set_maximized;

    /// Sets whether the layout should allow the user
    /// to resize the surface after it has been presented.
    extern fn gdk_toplevel_layout_set_resizable(p_layout: *ToplevelLayout, p_resizable: c_int) void;
    pub const setResizable = gdk_toplevel_layout_set_resizable;

    /// Decreases the reference count of `layout`.
    extern fn gdk_toplevel_layout_unref(p_layout: *ToplevelLayout) void;
    pub const unref = gdk_toplevel_layout_unref;

    extern fn gdk_toplevel_layout_get_type() usize;
    pub const getGObjectType = gdk_toplevel_layout_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains information that is useful to compute the size of a toplevel.
pub const ToplevelSize = opaque {
    /// Retrieves the bounds the toplevel is placed within.
    ///
    /// The bounds represent the largest size a toplevel may have while still being
    /// able to fit within some type of boundary. Depending on the backend, this may
    /// be equivalent to the dimensions of the work area or the monitor on which the
    /// window is being presented on, or something else that limits the way a
    /// toplevel can be presented.
    extern fn gdk_toplevel_size_get_bounds(p_size: *ToplevelSize, p_bounds_width: *c_int, p_bounds_height: *c_int) void;
    pub const getBounds = gdk_toplevel_size_get_bounds;

    /// Sets the minimum size of the toplevel.
    ///
    /// The minimum size corresponds to the limitations the toplevel can be shrunk
    /// to, without resulting in incorrect painting. A user of a `GdkToplevel` should
    /// calculate these given both the existing size, and the bounds retrieved from
    /// the `GdkToplevelSize` object.
    ///
    /// The minimum size should be within the bounds (see
    /// `gdk.ToplevelSize.getBounds`).
    extern fn gdk_toplevel_size_set_min_size(p_size: *ToplevelSize, p_min_width: c_int, p_min_height: c_int) void;
    pub const setMinSize = gdk_toplevel_size_set_min_size;

    /// Sets the shadows size of the toplevel.
    ///
    /// The shadow width corresponds to the part of the computed surface size
    /// that would consist of the shadow margin surrounding the window, would
    /// there be any.
    ///
    /// Shadow width should only be set if
    /// `gtk.Display.supportsShadowWidth` is `TRUE`.
    extern fn gdk_toplevel_size_set_shadow_width(p_size: *ToplevelSize, p_left: c_int, p_right: c_int, p_top: c_int, p_bottom: c_int) void;
    pub const setShadowWidth = gdk_toplevel_size_set_shadow_width;

    /// Sets the size the toplevel prefers to be resized to.
    ///
    /// The size should be within the bounds (see
    /// `gdk.ToplevelSize.getBounds`). The set size should
    /// be considered as a hint, and should not be assumed to be
    /// respected by the windowing system, or backend.
    extern fn gdk_toplevel_size_set_size(p_size: *ToplevelSize, p_width: c_int, p_height: c_int) void;
    pub const setSize = gdk_toplevel_size_set_size;

    extern fn gdk_toplevel_size_get_type() usize;
    pub const getGObjectType = gdk_toplevel_size_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines how device axes are interpreted by GTK.
///
/// Note that the X and Y axes are not really needed; pointer devices
/// report their location via the x/y members of events regardless. Whether
/// X and Y are present as axes depends on the GDK backend.
pub const AxisUse = enum(c_int) {
    ignore = 0,
    x = 1,
    y = 2,
    delta_x = 3,
    delta_y = 4,
    pressure = 5,
    xtilt = 6,
    ytilt = 7,
    wheel = 8,
    distance = 9,
    rotation = 10,
    slider = 11,
    last = 12,
    _,

    extern fn gdk_axis_use_get_type() usize;
    pub const getGObjectType = gdk_axis_use_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The values of this enumeration describe whether image data uses
/// the full range of 8-bit values.
///
/// In digital broadcasting, it is common to reserve the lowest and
/// highest values. Typically the allowed values for the narrow range
/// are 16-235 for Y and 16-240 for u,v (when dealing with YUV data).
pub const CicpRange = enum(c_int) {
    narrow = 0,
    full = 1,
    _,

    extern fn gdk_cicp_range_get_type() usize;
    pub const getGObjectType = gdk_cicp_range_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the crossing mode for enter and leave events.
pub const CrossingMode = enum(c_int) {
    normal = 0,
    grab = 1,
    ungrab = 2,
    gtk_grab = 3,
    gtk_ungrab = 4,
    state_changed = 5,
    touch_begin = 6,
    touch_end = 7,
    device_switch = 8,
    _,

    extern fn gdk_crossing_mode_get_type() usize;
    pub const getGObjectType = gdk_crossing_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A pad feature.
pub const DevicePadFeature = enum(c_int) {
    button = 0,
    ring = 1,
    strip = 2,
    _,

    extern fn gdk_device_pad_feature_get_type() usize;
    pub const getGObjectType = gdk_device_pad_feature_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the specific type of tool being used being a tablet. Such as an
/// airbrush, pencil, etc.
pub const DeviceToolType = enum(c_int) {
    unknown = 0,
    pen = 1,
    eraser = 2,
    brush = 3,
    pencil = 4,
    airbrush = 5,
    mouse = 6,
    lens = 7,
    _,

    extern fn gdk_device_tool_type_get_type() usize;
    pub const getGObjectType = gdk_device_tool_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error enumeration for `GdkDmabufTexture`.
pub const DmabufError = enum(c_int) {
    not_available = 0,
    unsupported_format = 1,
    creation_failed = 2,
    _,

    /// Registers an error quark for `gdk.DmabufTexture` errors.
    extern fn gdk_dmabuf_error_quark() glib.Quark;
    pub const quark = gdk_dmabuf_error_quark;

    extern fn gdk_dmabuf_error_get_type() usize;
    pub const getGObjectType = gdk_dmabuf_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used in `GdkDrag` to the reason of a cancelled DND operation.
pub const DragCancelReason = enum(c_int) {
    no_target = 0,
    user_cancelled = 1,
    @"error" = 2,
    _,

    extern fn gdk_drag_cancel_reason_get_type() usize;
    pub const getGObjectType = gdk_drag_cancel_reason_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the type of the event.
pub const EventType = enum(c_int) {
    delete = 0,
    motion_notify = 1,
    button_press = 2,
    button_release = 3,
    key_press = 4,
    key_release = 5,
    enter_notify = 6,
    leave_notify = 7,
    focus_change = 8,
    proximity_in = 9,
    proximity_out = 10,
    drag_enter = 11,
    drag_leave = 12,
    drag_motion = 13,
    drop_start = 14,
    scroll = 15,
    grab_broken = 16,
    touch_begin = 17,
    touch_update = 18,
    touch_end = 19,
    touch_cancel = 20,
    touchpad_swipe = 21,
    touchpad_pinch = 22,
    pad_button_press = 23,
    pad_button_release = 24,
    pad_ring = 25,
    pad_strip = 26,
    pad_group_mode = 27,
    touchpad_hold = 28,
    event_last = 29,
    _,

    extern fn gdk_event_type_get_type() usize;
    pub const getGObjectType = gdk_event_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates which monitor a surface should span over when in fullscreen mode.
pub const FullscreenMode = enum(c_int) {
    current_monitor = 0,
    all_monitors = 1,
    _,

    extern fn gdk_fullscreen_mode_get_type() usize;
    pub const getGObjectType = gdk_fullscreen_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error enumeration for `GdkGLContext`.
pub const GLError = enum(c_int) {
    not_available = 0,
    unsupported_format = 1,
    unsupported_profile = 2,
    compilation_failed = 3,
    link_failed = 4,
    _,

    /// Registers an error quark for `gdk.GLContext` errors.
    extern fn gdk_gl_error_quark() glib.Quark;
    pub const quark = gdk_gl_error_quark;

    extern fn gdk_gl_error_get_type() usize;
    pub const getGObjectType = gdk_gl_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the reference point of a surface and is used in `GdkPopupLayout`.
pub const Gravity = enum(c_int) {
    north_west = 1,
    north = 2,
    north_east = 3,
    west = 4,
    center = 5,
    east = 6,
    south_west = 7,
    south = 8,
    south_east = 9,
    static = 10,
    _,

    extern fn gdk_gravity_get_type() usize;
    pub const getGObjectType = gdk_gravity_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration describing the type of an input device in general terms.
pub const InputSource = enum(c_int) {
    mouse = 0,
    pen = 1,
    keyboard = 2,
    touchscreen = 3,
    touchpad = 4,
    trackpoint = 5,
    tablet_pad = 6,
    _,

    extern fn gdk_input_source_get_type() usize;
    pub const getGObjectType = gdk_input_source_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes how well an event matches a given keyval and modifiers.
///
/// `GdkKeyMatch` values are returned by `gdk.KeyEvent.matches`.
pub const KeyMatch = enum(c_int) {
    none = 0,
    partial = 1,
    exact = 2,
    _,

    extern fn gdk_key_match_get_type() usize;
    pub const getGObjectType = gdk_key_match_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes formats that image data can have in memory.
///
/// It describes formats by listing the contents of the memory passed to it.
/// So `GDK_MEMORY_A8R8G8B8` will be 1 byte (8 bits) of alpha, followed by a
/// byte each of red, green and blue. It is not endian-dependent, so
/// `CAIRO_FORMAT_ARGB32` is represented by different `GdkMemoryFormats`
/// on architectures with different endiannesses.
///
/// Its naming is modelled after
/// [VkFormat](https://www.khronos.org/registry/vulkan/specs/1.0/html/vkspec.html`VkFormat`)
/// for details).
pub const MemoryFormat = enum(c_int) {
    b8g8r8a8_premultiplied = 0,
    a8r8g8b8_premultiplied = 1,
    r8g8b8a8_premultiplied = 2,
    b8g8r8a8 = 3,
    a8r8g8b8 = 4,
    r8g8b8a8 = 5,
    a8b8g8r8 = 6,
    r8g8b8 = 7,
    b8g8r8 = 8,
    r16g16b16 = 9,
    r16g16b16a16_premultiplied = 10,
    r16g16b16a16 = 11,
    r16g16b16_float = 12,
    r16g16b16a16_float_premultiplied = 13,
    r16g16b16a16_float = 14,
    r32g32b32_float = 15,
    r32g32b32a32_float_premultiplied = 16,
    r32g32b32a32_float = 17,
    g8a8_premultiplied = 18,
    g8a8 = 19,
    g8 = 20,
    g16a16_premultiplied = 21,
    g16a16 = 22,
    g16 = 23,
    a8 = 24,
    a16 = 25,
    a16_float = 26,
    a32_float = 27,
    a8b8g8r8_premultiplied = 28,
    b8g8r8x8 = 29,
    x8r8g8b8 = 30,
    r8g8b8x8 = 31,
    x8b8g8r8 = 32,
    n_formats = 33,
    _,

    extern fn gdk_memory_format_get_type() usize;
    pub const getGObjectType = gdk_memory_format_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the kind of crossing for enter and leave events.
///
/// See the X11 protocol specification of LeaveNotify for
/// full details of crossing event generation.
pub const NotifyType = enum(c_int) {
    ancestor = 0,
    virtual = 1,
    inferior = 2,
    nonlinear = 3,
    nonlinear_virtual = 4,
    unknown = 5,
    _,

    extern fn gdk_notify_type_get_type() usize;
    pub const getGObjectType = gdk_notify_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the direction for scroll events.
pub const ScrollDirection = enum(c_int) {
    up = 0,
    down = 1,
    left = 2,
    right = 3,
    smooth = 4,
    _,

    extern fn gdk_scroll_direction_get_type() usize;
    pub const getGObjectType = gdk_scroll_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the unit of scroll deltas.
///
/// When you get `GDK_SCROLL_UNIT_WHEEL`, a delta of 1.0 means 1 wheel detent
/// click in the south direction, 2.0 means 2 wheel detent clicks in the south
/// direction... This is the same logic for negative values but in the north
/// direction.
///
/// If you get `GDK_SCROLL_UNIT_SURFACE`, are managing a scrollable view and get a
/// value of 123, you have to scroll 123 surface logical pixels right if it's
/// `delta_x` or down if it's `delta_y`. This is the same logic for negative values
/// but you have to scroll left instead of right if it's `delta_x` and up instead
/// of down if it's `delta_y`.
///
/// 1 surface logical pixel is equal to 1 real screen pixel multiplied by the
/// final scale factor of your graphical interface (the product of the desktop
/// scale factor and eventually a custom scale factor in your app).
pub const ScrollUnit = enum(c_int) {
    wheel = 0,
    surface = 1,
    _,

    extern fn gdk_scroll_unit_get_type() usize;
    pub const getGObjectType = gdk_scroll_unit_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This enumeration describes how the red, green and blue components
/// of physical pixels on an output device are laid out.
pub const SubpixelLayout = enum(c_int) {
    unknown = 0,
    none = 1,
    horizontal_rgb = 2,
    horizontal_bgr = 3,
    vertical_rgb = 4,
    vertical_bgr = 5,
    _,

    extern fn gdk_subpixel_layout_get_type() usize;
    pub const getGObjectType = gdk_subpixel_layout_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Determines a surface edge or corner.
pub const SurfaceEdge = enum(c_int) {
    north_west = 0,
    north = 1,
    north_east = 2,
    west = 3,
    east = 4,
    south_west = 5,
    south = 6,
    south_east = 7,
    _,

    extern fn gdk_surface_edge_get_type() usize;
    pub const getGObjectType = gdk_surface_edge_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Possible errors that can be returned by `GdkTexture` constructors.
pub const TextureError = enum(c_int) {
    too_large = 0,
    corrupt_image = 1,
    unsupported_content = 2,
    unsupported_format = 3,
    _,

    /// Registers an error quark for `gdk.Texture` errors.
    extern fn gdk_texture_error_quark() glib.Quark;
    pub const quark = gdk_texture_error_quark;

    extern fn gdk_texture_error_get_type() usize;
    pub const getGObjectType = gdk_texture_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The kind of title bar gesture to emit with
/// `gdk.Toplevel.titlebarGesture`.
pub const TitlebarGesture = enum(c_int) {
    double_click = 1,
    right_click = 2,
    middle_click = 3,
    _,

    extern fn gdk_titlebar_gesture_get_type() usize;
    pub const getGObjectType = gdk_titlebar_gesture_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the current state of a touchpad gesture.
///
/// All gestures are guaranteed to begin with an event with phase
/// `GDK_TOUCHPAD_GESTURE_PHASE_BEGIN`, followed by 0 or several events
/// with phase `GDK_TOUCHPAD_GESTURE_PHASE_UPDATE`.
///
/// A finished gesture may have 2 possible outcomes, an event with phase
/// `GDK_TOUCHPAD_GESTURE_PHASE_END` will be emitted when the gesture is
/// considered successful, this should be used as the hint to perform any
/// permanent changes.
///
/// Cancelled gestures may be so for a variety of reasons, due to hardware
/// or the compositor, or due to the gesture recognition layers hinting the
/// gesture did not finish resolutely (eg. a 3rd finger being added during
/// a pinch gesture). In these cases, the last event will report the phase
/// `GDK_TOUCHPAD_GESTURE_PHASE_CANCEL`, this should be used as a hint
/// to undo any visible/permanent changes that were done throughout the
/// progress of the gesture.
pub const TouchpadGesturePhase = enum(c_int) {
    begin = 0,
    update = 1,
    end = 2,
    cancel = 3,
    _,

    extern fn gdk_touchpad_gesture_phase_get_type() usize;
    pub const getGObjectType = gdk_touchpad_gesture_phase_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error enumeration for `GdkVulkanContext`.
pub const VulkanError = enum(c_int) {
    unsupported = 0,
    not_available = 1,
    _,

    /// Registers an error quark for `gdk.VulkanContext` errors.
    extern fn gdk_vulkan_error_quark() glib.Quark;
    pub const quark = gdk_vulkan_error_quark;

    extern fn gdk_vulkan_error_get_type() usize;
    pub const getGObjectType = gdk_vulkan_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Positioning hints for aligning a surface relative to a rectangle.
///
/// These hints determine how the surface should be positioned in the case that
/// the surface would fall off-screen if placed in its ideal position.
///
/// For example, `GDK_ANCHOR_FLIP_X` will replace `GDK_GRAVITY_NORTH_WEST` with
/// `GDK_GRAVITY_NORTH_EAST` and vice versa if the surface extends beyond the left
/// or right edges of the monitor.
///
/// If `GDK_ANCHOR_SLIDE_X` is set, the surface can be shifted horizontally to fit
/// on-screen. If `GDK_ANCHOR_RESIZE_X` is set, the surface can be shrunken
/// horizontally to fit.
///
/// In general, when multiple flags are set, flipping should take precedence over
/// sliding, which should take precedence over resizing.
pub const AnchorHints = packed struct(c_uint) {
    flip_x: bool = false,
    flip_y: bool = false,
    slide_x: bool = false,
    slide_y: bool = false,
    resize_x: bool = false,
    resize_y: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_flip_x: AnchorHints = @bitCast(@as(c_uint, 1));
    pub const flags_flip_y: AnchorHints = @bitCast(@as(c_uint, 2));
    pub const flags_slide_x: AnchorHints = @bitCast(@as(c_uint, 4));
    pub const flags_slide_y: AnchorHints = @bitCast(@as(c_uint, 8));
    pub const flags_resize_x: AnchorHints = @bitCast(@as(c_uint, 16));
    pub const flags_resize_y: AnchorHints = @bitCast(@as(c_uint, 32));
    pub const flags_flip: AnchorHints = @bitCast(@as(c_uint, 3));
    pub const flags_slide: AnchorHints = @bitCast(@as(c_uint, 12));
    pub const flags_resize: AnchorHints = @bitCast(@as(c_uint, 48));
    extern fn gdk_anchor_hints_get_type() usize;
    pub const getGObjectType = gdk_anchor_hints_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags describing the current capabilities of a device/tool.
pub const AxisFlags = packed struct(c_uint) {
    _padding0: bool = false,
    x: bool = false,
    y: bool = false,
    delta_x: bool = false,
    delta_y: bool = false,
    pressure: bool = false,
    xtilt: bool = false,
    ytilt: bool = false,
    wheel: bool = false,
    distance: bool = false,
    rotation: bool = false,
    slider: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_x: AxisFlags = @bitCast(@as(c_uint, 2));
    pub const flags_y: AxisFlags = @bitCast(@as(c_uint, 4));
    pub const flags_delta_x: AxisFlags = @bitCast(@as(c_uint, 8));
    pub const flags_delta_y: AxisFlags = @bitCast(@as(c_uint, 16));
    pub const flags_pressure: AxisFlags = @bitCast(@as(c_uint, 32));
    pub const flags_xtilt: AxisFlags = @bitCast(@as(c_uint, 64));
    pub const flags_ytilt: AxisFlags = @bitCast(@as(c_uint, 128));
    pub const flags_wheel: AxisFlags = @bitCast(@as(c_uint, 256));
    pub const flags_distance: AxisFlags = @bitCast(@as(c_uint, 512));
    pub const flags_rotation: AxisFlags = @bitCast(@as(c_uint, 1024));
    pub const flags_slider: AxisFlags = @bitCast(@as(c_uint, 2048));
    extern fn gdk_axis_flags_get_type() usize;
    pub const getGObjectType = gdk_axis_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used in `GdkDrop` and `GdkDrag` to indicate the actions that the
/// destination can and should do with the dropped data.
pub const DragAction = packed struct(c_uint) {
    copy: bool = false,
    move: bool = false,
    link: bool = false,
    ask: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_copy: DragAction = @bitCast(@as(c_uint, 1));
    pub const flags_move: DragAction = @bitCast(@as(c_uint, 2));
    pub const flags_link: DragAction = @bitCast(@as(c_uint, 4));
    pub const flags_ask: DragAction = @bitCast(@as(c_uint, 8));
    /// Checks if `action` represents a single action or includes
    /// multiple actions.
    ///
    /// When `action` is 0 - ie no action was given, `TRUE`
    /// is returned.
    extern fn gdk_drag_action_is_unique(p_action: gdk.DragAction) c_int;
    pub const isUnique = gdk_drag_action_is_unique;

    extern fn gdk_drag_action_get_type() usize;
    pub const getGObjectType = gdk_drag_action_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used to represent the different paint clock phases that can be requested.
///
/// The elements of the enumeration correspond to the signals of `GdkFrameClock`.
pub const FrameClockPhase = packed struct(c_uint) {
    flush_events: bool = false,
    before_paint: bool = false,
    update: bool = false,
    layout: bool = false,
    paint: bool = false,
    resume_events: bool = false,
    after_paint: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_none: FrameClockPhase = @bitCast(@as(c_uint, 0));
    pub const flags_flush_events: FrameClockPhase = @bitCast(@as(c_uint, 1));
    pub const flags_before_paint: FrameClockPhase = @bitCast(@as(c_uint, 2));
    pub const flags_update: FrameClockPhase = @bitCast(@as(c_uint, 4));
    pub const flags_layout: FrameClockPhase = @bitCast(@as(c_uint, 8));
    pub const flags_paint: FrameClockPhase = @bitCast(@as(c_uint, 16));
    pub const flags_resume_events: FrameClockPhase = @bitCast(@as(c_uint, 32));
    pub const flags_after_paint: FrameClockPhase = @bitCast(@as(c_uint, 64));
    extern fn gdk_frame_clock_phase_get_type() usize;
    pub const getGObjectType = gdk_frame_clock_phase_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The list of the different APIs that GdkGLContext can potentially support.
pub const GLAPI = packed struct(c_uint) {
    gl: bool = false,
    gles: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_gl: GLAPI = @bitCast(@as(c_uint, 1));
    pub const flags_gles: GLAPI = @bitCast(@as(c_uint, 2));
    extern fn gdk_gl_api_get_type() usize;
    pub const getGObjectType = gdk_gl_api_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags to indicate the state of modifier keys and mouse buttons
/// in events.
///
/// Typical modifier keys are Shift, Control, Meta, Super, Hyper, Alt, Compose,
/// Apple, CapsLock or ShiftLock.
///
/// Note that GDK may add internal values to events which include values outside
/// of this enumeration. Your code should preserve and ignore them. You can use
/// `GDK_MODIFIER_MASK` to remove all private values.
pub const ModifierType = packed struct(c_uint) {
    shift_mask: bool = false,
    lock_mask: bool = false,
    control_mask: bool = false,
    alt_mask: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    button1_mask: bool = false,
    button2_mask: bool = false,
    button3_mask: bool = false,
    button4_mask: bool = false,
    button5_mask: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    super_mask: bool = false,
    hyper_mask: bool = false,
    meta_mask: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_no_modifier_mask: ModifierType = @bitCast(@as(c_uint, 0));
    pub const flags_shift_mask: ModifierType = @bitCast(@as(c_uint, 1));
    pub const flags_lock_mask: ModifierType = @bitCast(@as(c_uint, 2));
    pub const flags_control_mask: ModifierType = @bitCast(@as(c_uint, 4));
    pub const flags_alt_mask: ModifierType = @bitCast(@as(c_uint, 8));
    pub const flags_button1_mask: ModifierType = @bitCast(@as(c_uint, 256));
    pub const flags_button2_mask: ModifierType = @bitCast(@as(c_uint, 512));
    pub const flags_button3_mask: ModifierType = @bitCast(@as(c_uint, 1024));
    pub const flags_button4_mask: ModifierType = @bitCast(@as(c_uint, 2048));
    pub const flags_button5_mask: ModifierType = @bitCast(@as(c_uint, 4096));
    pub const flags_super_mask: ModifierType = @bitCast(@as(c_uint, 67108864));
    pub const flags_hyper_mask: ModifierType = @bitCast(@as(c_uint, 134217728));
    pub const flags_meta_mask: ModifierType = @bitCast(@as(c_uint, 268435456));
    extern fn gdk_modifier_type_get_type() usize;
    pub const getGObjectType = gdk_modifier_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags about a paintable object.
///
/// Implementations use these for optimizations such as caching.
pub const PaintableFlags = packed struct(c_uint) {
    size: bool = false,
    contents: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_size: PaintableFlags = @bitCast(@as(c_uint, 1));
    pub const flags_contents: PaintableFlags = @bitCast(@as(c_uint, 2));
    extern fn gdk_paintable_flags_get_type() usize;
    pub const getGObjectType = gdk_paintable_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags describing the seat capabilities.
pub const SeatCapabilities = packed struct(c_uint) {
    pointer: bool = false,
    touch: bool = false,
    tablet_stylus: bool = false,
    keyboard: bool = false,
    tablet_pad: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_none: SeatCapabilities = @bitCast(@as(c_uint, 0));
    pub const flags_pointer: SeatCapabilities = @bitCast(@as(c_uint, 1));
    pub const flags_touch: SeatCapabilities = @bitCast(@as(c_uint, 2));
    pub const flags_tablet_stylus: SeatCapabilities = @bitCast(@as(c_uint, 4));
    pub const flags_keyboard: SeatCapabilities = @bitCast(@as(c_uint, 8));
    pub const flags_tablet_pad: SeatCapabilities = @bitCast(@as(c_uint, 16));
    pub const flags_all_pointing: SeatCapabilities = @bitCast(@as(c_uint, 7));
    pub const flags_all: SeatCapabilities = @bitCast(@as(c_uint, 31));
    extern fn gdk_seat_capabilities_get_type() usize;
    pub const getGObjectType = gdk_seat_capabilities_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the state of a toplevel surface.
///
/// On platforms that support information about individual edges, the
/// `GDK_TOPLEVEL_STATE_TILED` state will be set whenever any of the individual
/// tiled states is set. On platforms that lack that support, the tiled state
/// will give an indication of tiledness without any of the per-edge states
/// being set.
pub const ToplevelState = packed struct(c_uint) {
    minimized: bool = false,
    maximized: bool = false,
    sticky: bool = false,
    fullscreen: bool = false,
    above: bool = false,
    below: bool = false,
    focused: bool = false,
    tiled: bool = false,
    top_tiled: bool = false,
    top_resizable: bool = false,
    right_tiled: bool = false,
    right_resizable: bool = false,
    bottom_tiled: bool = false,
    bottom_resizable: bool = false,
    left_tiled: bool = false,
    left_resizable: bool = false,
    suspended: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_minimized: ToplevelState = @bitCast(@as(c_uint, 1));
    pub const flags_maximized: ToplevelState = @bitCast(@as(c_uint, 2));
    pub const flags_sticky: ToplevelState = @bitCast(@as(c_uint, 4));
    pub const flags_fullscreen: ToplevelState = @bitCast(@as(c_uint, 8));
    pub const flags_above: ToplevelState = @bitCast(@as(c_uint, 16));
    pub const flags_below: ToplevelState = @bitCast(@as(c_uint, 32));
    pub const flags_focused: ToplevelState = @bitCast(@as(c_uint, 64));
    pub const flags_tiled: ToplevelState = @bitCast(@as(c_uint, 128));
    pub const flags_top_tiled: ToplevelState = @bitCast(@as(c_uint, 256));
    pub const flags_top_resizable: ToplevelState = @bitCast(@as(c_uint, 512));
    pub const flags_right_tiled: ToplevelState = @bitCast(@as(c_uint, 1024));
    pub const flags_right_resizable: ToplevelState = @bitCast(@as(c_uint, 2048));
    pub const flags_bottom_tiled: ToplevelState = @bitCast(@as(c_uint, 4096));
    pub const flags_bottom_resizable: ToplevelState = @bitCast(@as(c_uint, 8192));
    pub const flags_left_tiled: ToplevelState = @bitCast(@as(c_uint, 16384));
    pub const flags_left_resizable: ToplevelState = @bitCast(@as(c_uint, 32768));
    pub const flags_suspended: ToplevelState = @bitCast(@as(c_uint, 65536));
    extern fn gdk_toplevel_state_get_type() usize;
    pub const getGObjectType = gdk_toplevel_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Draws GL content onto a cairo context.
///
/// It takes a render buffer ID (`source_type` == GL_RENDERBUFFER) or a texture
/// id (`source_type` == GL_TEXTURE) and draws it onto `cr` with an OVER operation,
/// respecting the current clip. The top left corner of the rectangle specified
/// by `x`, `y`, `width` and `height` will be drawn at the current (0,0) position of
/// the `cairo_t`.
///
/// This will work for *all* `cairo_t`, as long as `surface` is realized, but the
/// fallback implementation that reads back the pixels from the buffer may be
/// used in the general case. In the case of direct drawing to a surface with
/// no special effects applied to `cr` it will however use a more efficient
/// approach.
///
/// For GL_RENDERBUFFER the code will always fall back to software for buffers
/// with alpha components, so make sure you use GL_TEXTURE if using alpha.
///
/// Calling this may change the current GL context.
extern fn gdk_cairo_draw_from_gl(p_cr: *cairo.Context, p_surface: *gdk.Surface, p_source: c_int, p_source_type: c_int, p_buffer_scale: c_int, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) void;
pub const cairoDrawFromGl = gdk_cairo_draw_from_gl;

/// Adds the given rectangle to the current path of `cr`.
extern fn gdk_cairo_rectangle(p_cr: *cairo.Context, p_rectangle: *const gdk.Rectangle) void;
pub const cairoRectangle = gdk_cairo_rectangle;

/// Adds the given region to the current path of `cr`.
extern fn gdk_cairo_region(p_cr: *cairo.Context, p_region: *const cairo.Region) void;
pub const cairoRegion = gdk_cairo_region;

/// Creates region that covers the area where the given
/// `surface` is more than 50% opaque.
///
/// This function takes into account device offsets that might be
/// set with `cairo_surface_set_device_offset`.
extern fn gdk_cairo_region_create_from_surface(p_surface: *cairo.Surface) *cairo.Region;
pub const cairoRegionCreateFromSurface = gdk_cairo_region_create_from_surface;

/// Sets the given pixbuf as the source pattern for `cr`.
///
/// The pattern has an extend mode of `CAIRO_EXTEND_NONE` and is aligned
/// so that the origin of `pixbuf` is `pixbuf_x`, `pixbuf_y`.
extern fn gdk_cairo_set_source_pixbuf(p_cr: *cairo.Context, p_pixbuf: *const gdkpixbuf.Pixbuf, p_pixbuf_x: f64, p_pixbuf_y: f64) void;
pub const cairoSetSourcePixbuf = gdk_cairo_set_source_pixbuf;

/// Sets the specified `GdkRGBA` as the source color of `cr`.
extern fn gdk_cairo_set_source_rgba(p_cr: *cairo.Context, p_rgba: *const gdk.RGBA) void;
pub const cairoSetSourceRgba = gdk_cairo_set_source_rgba;

/// Reads content from the given input stream and deserialize it, asynchronously.
///
/// The default I/O priority is `G_PRIORITY_DEFAULT` (i.e. 0), and lower numbers
/// indicate a higher priority.
extern fn gdk_content_deserialize_async(p_stream: *gio.InputStream, p_mime_type: [*:0]const u8, p_type: usize, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
pub const contentDeserializeAsync = gdk_content_deserialize_async;

/// Finishes a content deserialization operation.
extern fn gdk_content_deserialize_finish(p_result: *gio.AsyncResult, p_value: *gobject.Value, p_error: ?*?*glib.Error) c_int;
pub const contentDeserializeFinish = gdk_content_deserialize_finish;

/// Registers a function to deserialize object of a given type.
extern fn gdk_content_register_deserializer(p_mime_type: [*:0]const u8, p_type: usize, p_deserialize: gdk.ContentDeserializeFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) void;
pub const contentRegisterDeserializer = gdk_content_register_deserializer;

/// Registers a function to serialize objects of a given type.
extern fn gdk_content_register_serializer(p_type: usize, p_mime_type: [*:0]const u8, p_serialize: gdk.ContentSerializeFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) void;
pub const contentRegisterSerializer = gdk_content_register_serializer;

/// Serialize content and write it to the given output stream, asynchronously.
///
/// The default I/O priority is `G_PRIORITY_DEFAULT` (i.e. 0), and lower numbers
/// indicate a higher priority.
extern fn gdk_content_serialize_async(p_stream: *gio.OutputStream, p_mime_type: [*:0]const u8, p_value: *const gobject.Value, p_io_priority: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
pub const contentSerializeAsync = gdk_content_serialize_async;

/// Finishes a content serialization operation.
extern fn gdk_content_serialize_finish(p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
pub const contentSerializeFinish = gdk_content_serialize_finish;

/// Returns the relative angle from `event1` to `event2`.
///
/// The relative angle is the angle between the X axis and the line
/// through both events' positions. The rotation direction for positive
/// angles is from the positive X axis towards the positive Y axis.
///
/// This assumes that both events have X/Y information.
/// If not, this function returns `FALSE`.
extern fn gdk_events_get_angle(p_event1: *gdk.Event, p_event2: *gdk.Event, p_angle: *f64) c_int;
pub const eventsGetAngle = gdk_events_get_angle;

/// Returns the point halfway between the events' positions.
///
/// This assumes that both events have X/Y information.
/// If not, this function returns `FALSE`.
extern fn gdk_events_get_center(p_event1: *gdk.Event, p_event2: *gdk.Event, p_x: *f64, p_y: *f64) c_int;
pub const eventsGetCenter = gdk_events_get_center;

/// Returns the distance between the event locations.
///
/// This assumes that both events have X/Y information.
/// If not, this function returns `FALSE`.
extern fn gdk_events_get_distance(p_event1: *gdk.Event, p_event2: *gdk.Event, p_distance: *f64) c_int;
pub const eventsGetDistance = gdk_events_get_distance;

/// Canonicalizes the given mime type and interns the result.
///
/// If `string` is not a valid mime type, `NULL` is returned instead.
/// See RFC 2048 for the syntax if mime types.
extern fn gdk_intern_mime_type(p_string: [*:0]const u8) ?[*:0]const u8;
pub const internMimeType = gdk_intern_mime_type;

/// Obtains the upper- and lower-case versions of the keyval `symbol`.
///
/// Examples of keyvals are `GDK_KEY_a`, `GDK_KEY_Enter`, `GDK_KEY_F1`, etc.
extern fn gdk_keyval_convert_case(p_symbol: c_uint, p_lower: *c_uint, p_upper: *c_uint) void;
pub const keyvalConvertCase = gdk_keyval_convert_case;

/// Converts a key name to a key value.
///
/// The names are the same as those in the
/// `gdk/gdkkeysyms.h` header file
/// but without the leading “GDK_KEY_”.
extern fn gdk_keyval_from_name(p_keyval_name: [*:0]const u8) c_uint;
pub const keyvalFromName = gdk_keyval_from_name;

/// Returns true if the given key value is in lower case.
extern fn gdk_keyval_is_lower(p_keyval: c_uint) c_int;
pub const keyvalIsLower = gdk_keyval_is_lower;

/// Returns true if the given key value is in upper case.
extern fn gdk_keyval_is_upper(p_keyval: c_uint) c_int;
pub const keyvalIsUpper = gdk_keyval_is_upper;

/// Converts a key value into a symbolic name.
///
/// The names are the same as those in the
/// `gdk/gdkkeysyms.h` header file
/// but without the leading “GDK_KEY_”.
extern fn gdk_keyval_name(p_keyval: c_uint) ?[*:0]const u8;
pub const keyvalName = gdk_keyval_name;

/// Converts a key value to lower case, if applicable.
extern fn gdk_keyval_to_lower(p_keyval: c_uint) c_uint;
pub const keyvalToLower = gdk_keyval_to_lower;

/// Converts from a GDK key symbol to the corresponding Unicode
/// character.
///
/// Note that the conversion does not take the current locale
/// into consideration, which might be expected for particular
/// keyvals, such as `GDK_KEY_KP_Decimal`.
extern fn gdk_keyval_to_unicode(p_keyval: c_uint) u32;
pub const keyvalToUnicode = gdk_keyval_to_unicode;

/// Converts a key value to upper case, if applicable.
extern fn gdk_keyval_to_upper(p_keyval: c_uint) c_uint;
pub const keyvalToUpper = gdk_keyval_to_upper;

/// Obtains a clip region which contains the areas where the given ranges
/// of text would be drawn.
///
/// `x_origin` and `y_origin` are the top left point to center the layout.
/// `index_ranges` should contain ranges of bytes in the layout’s text.
///
/// Note that the regions returned correspond to logical extents of the text
/// ranges, not ink extents. So the drawn layout may in fact touch areas out of
/// the clip region.  The clip region is mainly useful for highlightling parts
/// of text, such as when text is selected.
extern fn gdk_pango_layout_get_clip_region(p_layout: *pango.Layout, p_x_origin: c_int, p_y_origin: c_int, p_index_ranges: *const c_int, p_n_ranges: c_int) *cairo.Region;
pub const pangoLayoutGetClipRegion = gdk_pango_layout_get_clip_region;

/// Obtains a clip region which contains the areas where the given
/// ranges of text would be drawn.
///
/// `x_origin` and `y_origin` are the top left position of the layout.
/// `index_ranges` should contain ranges of bytes in the layout’s text.
/// The clip region will include space to the left or right of the line
/// (to the layout bounding box) if you have indexes above or below the
/// indexes contained inside the line. This is to draw the selection all
/// the way to the side of the layout. However, the clip region is in line
/// coordinates, not layout coordinates.
///
/// Note that the regions returned correspond to logical extents of the text
/// ranges, not ink extents. So the drawn line may in fact touch areas out of
/// the clip region.  The clip region is mainly useful for highlightling parts
/// of text, such as when text is selected.
extern fn gdk_pango_layout_line_get_clip_region(p_line: *pango.LayoutLine, p_x_origin: c_int, p_y_origin: c_int, p_index_ranges: [*]const c_int, p_n_ranges: c_int) *cairo.Region;
pub const pangoLayoutLineGetClipRegion = gdk_pango_layout_line_get_clip_region;

/// Transfers image data from a `cairo_surface_t` and converts it
/// to a `GdkPixbuf`.
///
/// This allows you to efficiently read individual pixels from cairo surfaces.
///
/// This function will create an RGB pixbuf with 8 bits per channel.
/// The pixbuf will contain an alpha channel if the `surface` contains one.
extern fn gdk_pixbuf_get_from_surface(p_surface: *cairo.Surface, p_src_x: c_int, p_src_y: c_int, p_width: c_int, p_height: c_int) ?*gdkpixbuf.Pixbuf;
pub const pixbufGetFromSurface = gdk_pixbuf_get_from_surface;

/// Creates a new pixbuf from `texture`.
///
/// This should generally not be used in newly written code as later
/// stages will almost certainly convert the pixbuf back into a texture
/// to draw it on screen.
extern fn gdk_pixbuf_get_from_texture(p_texture: *gdk.Texture) ?*gdkpixbuf.Pixbuf;
pub const pixbufGetFromTexture = gdk_pixbuf_get_from_texture;

/// Sets a list of backends that GDK should try to use.
///
/// This can be useful if your application does not
/// work with certain GDK backends.
///
/// By default, GDK tries all included backends.
///
/// For example:
///
/// ```c
/// gdk_set_allowed_backends ("wayland,macos,*");
/// ```
///
/// instructs GDK to try the Wayland backend first, followed by the
/// MacOs backend, and then all others.
///
/// If the `GDK_BACKEND` environment variable is set, it determines
/// what backends are tried in what order, while still respecting the
/// set of allowed backends that are specified by this function.
///
/// The possible backend names are:
///
///   - `broadway`
///   - `macos`
///   - `wayland`.
///   - `win32`
///   - `x11`
///
/// You can also include a `*` in the list to try all remaining backends.
///
/// This call must happen prior to functions that open a display, such
/// as `gdk.Display.open`, ``gtk_init``, or ``gtk_init_check``
/// in order to take effect.
extern fn gdk_set_allowed_backends(p_backends: [*:0]const u8) void;
pub const setAllowedBackends = gdk_set_allowed_backends;

/// Converts from a Unicode character to a key symbol.
extern fn gdk_unicode_to_keyval(p_wc: u32) c_uint;
pub const unicodeToKeyval = gdk_unicode_to_keyval;

/// The type of a function that can be registered with `gdk.contentRegisterDeserializer`.
///
/// When the function gets called to operate on content, it can call functions on the
/// `deserializer` object to obtain the mime type, input stream, user data, etc. for its
/// operation.
pub const ContentDeserializeFunc = *const fn (p_deserializer: *gdk.ContentDeserializer) callconv(.c) void;

/// The type of a function that can be registered with `gdk.contentRegisterSerializer`.
///
/// When the function gets called to operate on content, it can call functions on the
/// `serializer` object to obtain the mime type, output stream, user data, etc. for its
/// operation.
pub const ContentSerializeFunc = *const fn (p_serializer: *gdk.ContentSerializer) callconv(.c) void;

/// The type of callback used by a dynamic `GdkCursor` to generate
/// a texture for the cursor image at the given `cursor_size`
/// and `scale`.
///
/// The actual cursor size in application pixels may be different
/// from `cursor_size` x `cursor_size`, and will be returned in
/// `width`, `height`. The returned texture should have a size that
/// corresponds to the actual cursor size, in device pixels (i.e.
/// application pixels, multiplied by `scale`).
///
/// This function may fail and return `NULL`, in which case
/// the fallback cursor will be used.
pub const CursorGetTextureCallback = *const fn (p_cursor: *gdk.Cursor, p_cursor_size: c_int, p_scale: f64, p_width: *c_int, p_height: *c_int, p_hotspot_x: *c_int, p_hotspot_y: *c_int, p_data: ?*anyopaque) callconv(.c) ?*gdk.Texture;

/// Defines all possible DND actions.
///
/// This can be used in `gdk.Drop.status` messages when any drop
/// can be accepted or a more specific drop method is not yet known.
pub const ACTION_ALL = 7;
/// The middle button.
pub const BUTTON_MIDDLE = 2;
/// The primary button. This is typically the left mouse button, or the
/// right button in a left-handed setup.
pub const BUTTON_PRIMARY = 1;
/// The secondary button. This is typically the right mouse button, or the
/// left button in a left-handed setup.
pub const BUTTON_SECONDARY = 3;
/// Represents the current time, and can be used anywhere a time is expected.
pub const CURRENT_TIME = 0;
/// Use this macro as the return value for continuing the propagation of
/// an event handler.
pub const EVENT_PROPAGATE = false;
/// Use this macro as the return value for stopping the propagation of
/// an event handler.
pub const EVENT_STOP = true;
pub const KEY_0 = 48;
pub const KEY_1 = 49;
pub const KEY_10ChannelsDown = 268964281;
pub const KEY_10ChannelsUp = 268964280;
pub const KEY_2 = 50;
pub const KEY_3 = 51;
pub const KEY_3270_AltCursor = 64784;
pub const KEY_3270_Attn = 64782;
pub const KEY_3270_BackTab = 64773;
pub const KEY_3270_ChangeScreen = 64793;
pub const KEY_3270_Copy = 64789;
pub const KEY_3270_CursorBlink = 64783;
pub const KEY_3270_CursorSelect = 64796;
pub const KEY_3270_DeleteWord = 64794;
pub const KEY_3270_Duplicate = 64769;
pub const KEY_3270_Enter = 64798;
pub const KEY_3270_EraseEOF = 64774;
pub const KEY_3270_EraseInput = 64775;
pub const KEY_3270_ExSelect = 64795;
pub const KEY_3270_FieldMark = 64770;
pub const KEY_3270_Ident = 64787;
pub const KEY_3270_Jump = 64786;
pub const KEY_3270_KeyClick = 64785;
pub const KEY_3270_Left2 = 64772;
pub const KEY_3270_PA1 = 64778;
pub const KEY_3270_PA2 = 64779;
pub const KEY_3270_PA3 = 64780;
pub const KEY_3270_Play = 64790;
pub const KEY_3270_PrintScreen = 64797;
pub const KEY_3270_Quit = 64777;
pub const KEY_3270_Record = 64792;
pub const KEY_3270_Reset = 64776;
pub const KEY_3270_Right2 = 64771;
pub const KEY_3270_Rule = 64788;
pub const KEY_3270_Setup = 64791;
pub const KEY_3270_Test = 64781;
pub const KEY_3DMode = 268964463;
pub const KEY_4 = 52;
pub const KEY_5 = 53;
pub const KEY_6 = 54;
pub const KEY_7 = 55;
pub const KEY_8 = 56;
pub const KEY_9 = 57;
pub const KEY_A = 65;
pub const KEY_AE = 198;
pub const KEY_ALSToggle = 268964400;
pub const KEY_Aacute = 193;
pub const KEY_Abelowdot = 16785056;
pub const KEY_Abreve = 451;
pub const KEY_Abreveacute = 16785070;
pub const KEY_Abrevebelowdot = 16785078;
pub const KEY_Abrevegrave = 16785072;
pub const KEY_Abrevehook = 16785074;
pub const KEY_Abrevetilde = 16785076;
pub const KEY_AccessX_Enable = 65136;
pub const KEY_AccessX_Feedback_Enable = 65137;
pub const KEY_Accessibility = 268964430;
pub const KEY_Acircumflex = 194;
pub const KEY_Acircumflexacute = 16785060;
pub const KEY_Acircumflexbelowdot = 16785068;
pub const KEY_Acircumflexgrave = 16785062;
pub const KEY_Acircumflexhook = 16785064;
pub const KEY_Acircumflextilde = 16785066;
pub const KEY_AddFavorite = 269025081;
pub const KEY_Addressbook = 268964269;
pub const KEY_Adiaeresis = 196;
pub const KEY_Agrave = 192;
pub const KEY_Ahook = 16785058;
pub const KEY_Alt_L = 65513;
pub const KEY_Alt_R = 65514;
pub const KEY_Amacron = 960;
pub const KEY_Aogonek = 417;
pub const KEY_AppSelect = 268964420;
pub const KEY_ApplicationLeft = 269025104;
pub const KEY_ApplicationRight = 269025105;
pub const KEY_Arabic_0 = 16778848;
pub const KEY_Arabic_1 = 16778849;
pub const KEY_Arabic_2 = 16778850;
pub const KEY_Arabic_3 = 16778851;
pub const KEY_Arabic_4 = 16778852;
pub const KEY_Arabic_5 = 16778853;
pub const KEY_Arabic_6 = 16778854;
pub const KEY_Arabic_7 = 16778855;
pub const KEY_Arabic_8 = 16778856;
pub const KEY_Arabic_9 = 16778857;
pub const KEY_Arabic_ain = 1497;
pub const KEY_Arabic_alef = 1479;
pub const KEY_Arabic_alefmaksura = 1513;
pub const KEY_Arabic_beh = 1480;
pub const KEY_Arabic_comma = 1452;
pub const KEY_Arabic_dad = 1494;
pub const KEY_Arabic_dal = 1487;
pub const KEY_Arabic_damma = 1519;
pub const KEY_Arabic_dammatan = 1516;
pub const KEY_Arabic_ddal = 16778888;
pub const KEY_Arabic_farsi_yeh = 16778956;
pub const KEY_Arabic_fatha = 1518;
pub const KEY_Arabic_fathatan = 1515;
pub const KEY_Arabic_feh = 1505;
pub const KEY_Arabic_fullstop = 16778964;
pub const KEY_Arabic_gaf = 16778927;
pub const KEY_Arabic_ghain = 1498;
pub const KEY_Arabic_ha = 1511;
pub const KEY_Arabic_hah = 1485;
pub const KEY_Arabic_hamza = 1473;
pub const KEY_Arabic_hamza_above = 16778836;
pub const KEY_Arabic_hamza_below = 16778837;
pub const KEY_Arabic_hamzaonalef = 1475;
pub const KEY_Arabic_hamzaonwaw = 1476;
pub const KEY_Arabic_hamzaonyeh = 1478;
pub const KEY_Arabic_hamzaunderalef = 1477;
pub const KEY_Arabic_heh = 1511;
pub const KEY_Arabic_heh_doachashmee = 16778942;
pub const KEY_Arabic_heh_goal = 16778945;
pub const KEY_Arabic_jeem = 1484;
pub const KEY_Arabic_jeh = 16778904;
pub const KEY_Arabic_kaf = 1507;
pub const KEY_Arabic_kasra = 1520;
pub const KEY_Arabic_kasratan = 1517;
pub const KEY_Arabic_keheh = 16778921;
pub const KEY_Arabic_khah = 1486;
pub const KEY_Arabic_lam = 1508;
pub const KEY_Arabic_madda_above = 16778835;
pub const KEY_Arabic_maddaonalef = 1474;
pub const KEY_Arabic_meem = 1509;
pub const KEY_Arabic_noon = 1510;
pub const KEY_Arabic_noon_ghunna = 16778938;
pub const KEY_Arabic_peh = 16778878;
pub const KEY_Arabic_percent = 16778858;
pub const KEY_Arabic_qaf = 1506;
pub const KEY_Arabic_question_mark = 1471;
pub const KEY_Arabic_ra = 1489;
pub const KEY_Arabic_rreh = 16778897;
pub const KEY_Arabic_sad = 1493;
pub const KEY_Arabic_seen = 1491;
pub const KEY_Arabic_semicolon = 1467;
pub const KEY_Arabic_shadda = 1521;
pub const KEY_Arabic_sheen = 1492;
pub const KEY_Arabic_sukun = 1522;
pub const KEY_Arabic_superscript_alef = 16778864;
pub const KEY_Arabic_switch = 65406;
pub const KEY_Arabic_tah = 1495;
pub const KEY_Arabic_tatweel = 1504;
pub const KEY_Arabic_tcheh = 16778886;
pub const KEY_Arabic_teh = 1482;
pub const KEY_Arabic_tehmarbuta = 1481;
pub const KEY_Arabic_thal = 1488;
pub const KEY_Arabic_theh = 1483;
pub const KEY_Arabic_tteh = 16778873;
pub const KEY_Arabic_veh = 16778916;
pub const KEY_Arabic_waw = 1512;
pub const KEY_Arabic_yeh = 1514;
pub const KEY_Arabic_yeh_baree = 16778962;
pub const KEY_Arabic_zah = 1496;
pub const KEY_Arabic_zain = 1490;
pub const KEY_Aring = 197;
pub const KEY_Armenian_AT = 16778552;
pub const KEY_Armenian_AYB = 16778545;
pub const KEY_Armenian_BEN = 16778546;
pub const KEY_Armenian_CHA = 16778569;
pub const KEY_Armenian_DA = 16778548;
pub const KEY_Armenian_DZA = 16778561;
pub const KEY_Armenian_E = 16778551;
pub const KEY_Armenian_FE = 16778582;
pub const KEY_Armenian_GHAT = 16778562;
pub const KEY_Armenian_GIM = 16778547;
pub const KEY_Armenian_HI = 16778565;
pub const KEY_Armenian_HO = 16778560;
pub const KEY_Armenian_INI = 16778555;
pub const KEY_Armenian_JE = 16778571;
pub const KEY_Armenian_KE = 16778580;
pub const KEY_Armenian_KEN = 16778559;
pub const KEY_Armenian_KHE = 16778557;
pub const KEY_Armenian_LYUN = 16778556;
pub const KEY_Armenian_MEN = 16778564;
pub const KEY_Armenian_NU = 16778566;
pub const KEY_Armenian_O = 16778581;
pub const KEY_Armenian_PE = 16778570;
pub const KEY_Armenian_PYUR = 16778579;
pub const KEY_Armenian_RA = 16778572;
pub const KEY_Armenian_RE = 16778576;
pub const KEY_Armenian_SE = 16778573;
pub const KEY_Armenian_SHA = 16778567;
pub const KEY_Armenian_TCHE = 16778563;
pub const KEY_Armenian_TO = 16778553;
pub const KEY_Armenian_TSA = 16778558;
pub const KEY_Armenian_TSO = 16778577;
pub const KEY_Armenian_TYUN = 16778575;
pub const KEY_Armenian_VEV = 16778574;
pub const KEY_Armenian_VO = 16778568;
pub const KEY_Armenian_VYUN = 16778578;
pub const KEY_Armenian_YECH = 16778549;
pub const KEY_Armenian_ZA = 16778550;
pub const KEY_Armenian_ZHE = 16778554;
pub const KEY_Armenian_accent = 16778587;
pub const KEY_Armenian_amanak = 16778588;
pub const KEY_Armenian_apostrophe = 16778586;
pub const KEY_Armenian_at = 16778600;
pub const KEY_Armenian_ayb = 16778593;
pub const KEY_Armenian_ben = 16778594;
pub const KEY_Armenian_but = 16778589;
pub const KEY_Armenian_cha = 16778617;
pub const KEY_Armenian_da = 16778596;
pub const KEY_Armenian_dza = 16778609;
pub const KEY_Armenian_e = 16778599;
pub const KEY_Armenian_exclam = 16778588;
pub const KEY_Armenian_fe = 16778630;
pub const KEY_Armenian_full_stop = 16778633;
pub const KEY_Armenian_ghat = 16778610;
pub const KEY_Armenian_gim = 16778595;
pub const KEY_Armenian_hi = 16778613;
pub const KEY_Armenian_ho = 16778608;
pub const KEY_Armenian_hyphen = 16778634;
pub const KEY_Armenian_ini = 16778603;
pub const KEY_Armenian_je = 16778619;
pub const KEY_Armenian_ke = 16778628;
pub const KEY_Armenian_ken = 16778607;
pub const KEY_Armenian_khe = 16778605;
pub const KEY_Armenian_ligature_ew = 16778631;
pub const KEY_Armenian_lyun = 16778604;
pub const KEY_Armenian_men = 16778612;
pub const KEY_Armenian_nu = 16778614;
pub const KEY_Armenian_o = 16778629;
pub const KEY_Armenian_paruyk = 16778590;
pub const KEY_Armenian_pe = 16778618;
pub const KEY_Armenian_pyur = 16778627;
pub const KEY_Armenian_question = 16778590;
pub const KEY_Armenian_ra = 16778620;
pub const KEY_Armenian_re = 16778624;
pub const KEY_Armenian_se = 16778621;
pub const KEY_Armenian_separation_mark = 16778589;
pub const KEY_Armenian_sha = 16778615;
pub const KEY_Armenian_shesht = 16778587;
pub const KEY_Armenian_tche = 16778611;
pub const KEY_Armenian_to = 16778601;
pub const KEY_Armenian_tsa = 16778606;
pub const KEY_Armenian_tso = 16778625;
pub const KEY_Armenian_tyun = 16778623;
pub const KEY_Armenian_verjaket = 16778633;
pub const KEY_Armenian_vev = 16778622;
pub const KEY_Armenian_vo = 16778616;
pub const KEY_Armenian_vyun = 16778626;
pub const KEY_Armenian_yech = 16778597;
pub const KEY_Armenian_yentamna = 16778634;
pub const KEY_Armenian_za = 16778598;
pub const KEY_Armenian_zhe = 16778602;
pub const KEY_AspectRatio = 268964215;
pub const KEY_Assistant = 268964423;
pub const KEY_Atilde = 195;
pub const KEY_AttendantOff = 268964380;
pub const KEY_AttendantOn = 268964379;
pub const KEY_AttendantToggle = 268964381;
pub const KEY_AudibleBell_Enable = 65146;
pub const KEY_Audio = 268964232;
pub const KEY_AudioCycleTrack = 269025179;
pub const KEY_AudioDesc = 268964462;
pub const KEY_AudioForward = 269025175;
pub const KEY_AudioLowerVolume = 269025041;
pub const KEY_AudioMedia = 269025074;
pub const KEY_AudioMicMute = 269025202;
pub const KEY_AudioMute = 269025042;
pub const KEY_AudioNext = 269025047;
pub const KEY_AudioPause = 269025073;
pub const KEY_AudioPlay = 269025044;
pub const KEY_AudioPreset = 269025206;
pub const KEY_AudioPrev = 269025046;
pub const KEY_AudioRaiseVolume = 269025043;
pub const KEY_AudioRandomPlay = 269025177;
pub const KEY_AudioRecord = 269025052;
pub const KEY_AudioRepeat = 269025176;
pub const KEY_AudioRewind = 269025086;
pub const KEY_AudioStop = 269025045;
pub const KEY_AutopilotEngageToggle = 268964477;
pub const KEY_Away = 269025165;
pub const KEY_B = 66;
pub const KEY_Babovedot = 16784898;
pub const KEY_Back = 269025062;
pub const KEY_BackForward = 269025087;
pub const KEY_BackSpace = 65288;
pub const KEY_Battery = 269025171;
pub const KEY_Begin = 65368;
pub const KEY_Blue = 269025190;
pub const KEY_Bluetooth = 269025172;
pub const KEY_Book = 269025106;
pub const KEY_BounceKeys_Enable = 65140;
pub const KEY_Break = 65387;
pub const KEY_BrightnessAdjust = 269025083;
pub const KEY_BrightnessAuto = 268964084;
pub const KEY_BrightnessMax = 268964433;
pub const KEY_BrightnessMin = 268964432;
pub const KEY_Buttonconfig = 268964416;
pub const KEY_Byelorussian_SHORTU = 1726;
pub const KEY_Byelorussian_shortu = 1710;
pub const KEY_C = 67;
pub const KEY_CD = 269025107;
pub const KEY_CH = 65186;
pub const KEY_C_H = 65189;
pub const KEY_C_h = 65188;
pub const KEY_Cabovedot = 709;
pub const KEY_Cacute = 454;
pub const KEY_Calculator = 269025053;
pub const KEY_Calendar = 269025056;
pub const KEY_CameraAccessDisable = 268964428;
pub const KEY_CameraAccessEnable = 268964427;
pub const KEY_CameraAccessToggle = 268964429;
pub const KEY_CameraDown = 268964376;
pub const KEY_CameraFocus = 268964368;
pub const KEY_CameraLeft = 268964377;
pub const KEY_CameraRight = 268964378;
pub const KEY_CameraUp = 268964375;
pub const KEY_CameraZoomIn = 268964373;
pub const KEY_CameraZoomOut = 268964374;
pub const KEY_Cancel = 65385;
pub const KEY_Caps_Lock = 65509;
pub const KEY_Ccaron = 456;
pub const KEY_Ccedilla = 199;
pub const KEY_Ccircumflex = 710;
pub const KEY_Ch = 65185;
pub const KEY_ChannelDown = 268964243;
pub const KEY_ChannelUp = 268964242;
pub const KEY_Clear = 65291;
pub const KEY_ClearGrab = 269024801;
pub const KEY_ClearvuSonar = 268964486;
pub const KEY_Close = 269025110;
pub const KEY_Codeinput = 65335;
pub const KEY_ColonSign = 16785569;
pub const KEY_Community = 269025085;
pub const KEY_ContextMenu = 268964278;
pub const KEY_ContrastAdjust = 269025058;
pub const KEY_ControlPanel = 268964419;
pub const KEY_Control_L = 65507;
pub const KEY_Control_R = 65508;
pub const KEY_Copy = 269025111;
pub const KEY_CruzeiroSign = 16785570;
pub const KEY_Cut = 269025112;
pub const KEY_CycleAngle = 269025180;
pub const KEY_Cyrillic_A = 1761;
pub const KEY_Cyrillic_BE = 1762;
pub const KEY_Cyrillic_CHE = 1790;
pub const KEY_Cyrillic_CHE_descender = 16778422;
pub const KEY_Cyrillic_CHE_vertstroke = 16778424;
pub const KEY_Cyrillic_DE = 1764;
pub const KEY_Cyrillic_DZHE = 1727;
pub const KEY_Cyrillic_E = 1788;
pub const KEY_Cyrillic_EF = 1766;
pub const KEY_Cyrillic_EL = 1772;
pub const KEY_Cyrillic_EM = 1773;
pub const KEY_Cyrillic_EN = 1774;
pub const KEY_Cyrillic_EN_descender = 16778402;
pub const KEY_Cyrillic_ER = 1778;
pub const KEY_Cyrillic_ES = 1779;
pub const KEY_Cyrillic_GHE = 1767;
pub const KEY_Cyrillic_GHE_bar = 16778386;
pub const KEY_Cyrillic_HA = 1768;
pub const KEY_Cyrillic_HARDSIGN = 1791;
pub const KEY_Cyrillic_HA_descender = 16778418;
pub const KEY_Cyrillic_I = 1769;
pub const KEY_Cyrillic_IE = 1765;
pub const KEY_Cyrillic_IO = 1715;
pub const KEY_Cyrillic_I_macron = 16778466;
pub const KEY_Cyrillic_JE = 1720;
pub const KEY_Cyrillic_KA = 1771;
pub const KEY_Cyrillic_KA_descender = 16778394;
pub const KEY_Cyrillic_KA_vertstroke = 16778396;
pub const KEY_Cyrillic_LJE = 1721;
pub const KEY_Cyrillic_NJE = 1722;
pub const KEY_Cyrillic_O = 1775;
pub const KEY_Cyrillic_O_bar = 16778472;
pub const KEY_Cyrillic_PE = 1776;
pub const KEY_Cyrillic_SCHWA = 16778456;
pub const KEY_Cyrillic_SHA = 1787;
pub const KEY_Cyrillic_SHCHA = 1789;
pub const KEY_Cyrillic_SHHA = 16778426;
pub const KEY_Cyrillic_SHORTI = 1770;
pub const KEY_Cyrillic_SOFTSIGN = 1784;
pub const KEY_Cyrillic_TE = 1780;
pub const KEY_Cyrillic_TSE = 1763;
pub const KEY_Cyrillic_U = 1781;
pub const KEY_Cyrillic_U_macron = 16778478;
pub const KEY_Cyrillic_U_straight = 16778414;
pub const KEY_Cyrillic_U_straight_bar = 16778416;
pub const KEY_Cyrillic_VE = 1783;
pub const KEY_Cyrillic_YA = 1777;
pub const KEY_Cyrillic_YERU = 1785;
pub const KEY_Cyrillic_YU = 1760;
pub const KEY_Cyrillic_ZE = 1786;
pub const KEY_Cyrillic_ZHE = 1782;
pub const KEY_Cyrillic_ZHE_descender = 16778390;
pub const KEY_Cyrillic_a = 1729;
pub const KEY_Cyrillic_be = 1730;
pub const KEY_Cyrillic_che = 1758;
pub const KEY_Cyrillic_che_descender = 16778423;
pub const KEY_Cyrillic_che_vertstroke = 16778425;
pub const KEY_Cyrillic_de = 1732;
pub const KEY_Cyrillic_dzhe = 1711;
pub const KEY_Cyrillic_e = 1756;
pub const KEY_Cyrillic_ef = 1734;
pub const KEY_Cyrillic_el = 1740;
pub const KEY_Cyrillic_em = 1741;
pub const KEY_Cyrillic_en = 1742;
pub const KEY_Cyrillic_en_descender = 16778403;
pub const KEY_Cyrillic_er = 1746;
pub const KEY_Cyrillic_es = 1747;
pub const KEY_Cyrillic_ghe = 1735;
pub const KEY_Cyrillic_ghe_bar = 16778387;
pub const KEY_Cyrillic_ha = 1736;
pub const KEY_Cyrillic_ha_descender = 16778419;
pub const KEY_Cyrillic_hardsign = 1759;
pub const KEY_Cyrillic_i = 1737;
pub const KEY_Cyrillic_i_macron = 16778467;
pub const KEY_Cyrillic_ie = 1733;
pub const KEY_Cyrillic_io = 1699;
pub const KEY_Cyrillic_je = 1704;
pub const KEY_Cyrillic_ka = 1739;
pub const KEY_Cyrillic_ka_descender = 16778395;
pub const KEY_Cyrillic_ka_vertstroke = 16778397;
pub const KEY_Cyrillic_lje = 1705;
pub const KEY_Cyrillic_nje = 1706;
pub const KEY_Cyrillic_o = 1743;
pub const KEY_Cyrillic_o_bar = 16778473;
pub const KEY_Cyrillic_pe = 1744;
pub const KEY_Cyrillic_schwa = 16778457;
pub const KEY_Cyrillic_sha = 1755;
pub const KEY_Cyrillic_shcha = 1757;
pub const KEY_Cyrillic_shha = 16778427;
pub const KEY_Cyrillic_shorti = 1738;
pub const KEY_Cyrillic_softsign = 1752;
pub const KEY_Cyrillic_te = 1748;
pub const KEY_Cyrillic_tse = 1731;
pub const KEY_Cyrillic_u = 1749;
pub const KEY_Cyrillic_u_macron = 16778479;
pub const KEY_Cyrillic_u_straight = 16778415;
pub const KEY_Cyrillic_u_straight_bar = 16778417;
pub const KEY_Cyrillic_ve = 1751;
pub const KEY_Cyrillic_ya = 1745;
pub const KEY_Cyrillic_yeru = 1753;
pub const KEY_Cyrillic_yu = 1728;
pub const KEY_Cyrillic_ze = 1754;
pub const KEY_Cyrillic_zhe = 1750;
pub const KEY_Cyrillic_zhe_descender = 16778391;
pub const KEY_D = 68;
pub const KEY_DOS = 269025114;
pub const KEY_DVD = 268964229;
pub const KEY_Dabovedot = 16784906;
pub const KEY_Data = 268964471;
pub const KEY_Database = 268964266;
pub const KEY_Dcaron = 463;
pub const KEY_Delete = 65535;
pub const KEY_Dictate = 268964426;
pub const KEY_Display = 269025113;
pub const KEY_DisplayOff = 268964085;
pub const KEY_DisplayToggle = 268964271;
pub const KEY_DoNotDisturb = 268964431;
pub const KEY_Documents = 269025115;
pub const KEY_DongSign = 16785579;
pub const KEY_Down = 65364;
pub const KEY_Dstroke = 464;
pub const KEY_DualRangeRadar = 268964483;
pub const KEY_E = 69;
pub const KEY_ENG = 957;
pub const KEY_ETH = 208;
pub const KEY_EZH = 16777655;
pub const KEY_Eabovedot = 972;
pub const KEY_Eacute = 201;
pub const KEY_Ebelowdot = 16785080;
pub const KEY_Ecaron = 460;
pub const KEY_Ecircumflex = 202;
pub const KEY_Ecircumflexacute = 16785086;
pub const KEY_Ecircumflexbelowdot = 16785094;
pub const KEY_Ecircumflexgrave = 16785088;
pub const KEY_Ecircumflexhook = 16785090;
pub const KEY_Ecircumflextilde = 16785092;
pub const KEY_EcuSign = 16785568;
pub const KEY_Ediaeresis = 203;
pub const KEY_Editor = 268964262;
pub const KEY_Egrave = 200;
pub const KEY_Ehook = 16785082;
pub const KEY_Eisu_Shift = 65327;
pub const KEY_Eisu_toggle = 65328;
pub const KEY_Eject = 269025068;
pub const KEY_Emacron = 938;
pub const KEY_EmojiPicker = 268964425;
pub const KEY_End = 65367;
pub const KEY_Eogonek = 458;
pub const KEY_Escape = 65307;
pub const KEY_Eth = 208;
pub const KEY_Etilde = 16785084;
pub const KEY_EuroSign = 8364;
pub const KEY_Excel = 269025116;
pub const KEY_Execute = 65378;
pub const KEY_Explorer = 269025117;
pub const KEY_F = 70;
pub const KEY_F1 = 65470;
pub const KEY_F10 = 65479;
pub const KEY_F11 = 65480;
pub const KEY_F12 = 65481;
pub const KEY_F13 = 65482;
pub const KEY_F14 = 65483;
pub const KEY_F15 = 65484;
pub const KEY_F16 = 65485;
pub const KEY_F17 = 65486;
pub const KEY_F18 = 65487;
pub const KEY_F19 = 65488;
pub const KEY_F2 = 65471;
pub const KEY_F20 = 65489;
pub const KEY_F21 = 65490;
pub const KEY_F22 = 65491;
pub const KEY_F23 = 65492;
pub const KEY_F24 = 65493;
pub const KEY_F25 = 65494;
pub const KEY_F26 = 65495;
pub const KEY_F27 = 65496;
pub const KEY_F28 = 65497;
pub const KEY_F29 = 65498;
pub const KEY_F3 = 65472;
pub const KEY_F30 = 65499;
pub const KEY_F31 = 65500;
pub const KEY_F32 = 65501;
pub const KEY_F33 = 65502;
pub const KEY_F34 = 65503;
pub const KEY_F35 = 65504;
pub const KEY_F4 = 65473;
pub const KEY_F5 = 65474;
pub const KEY_F6 = 65475;
pub const KEY_F7 = 65476;
pub const KEY_F8 = 65477;
pub const KEY_F9 = 65478;
pub const KEY_FFrancSign = 16785571;
pub const KEY_Fabovedot = 16784926;
pub const KEY_Farsi_0 = 16778992;
pub const KEY_Farsi_1 = 16778993;
pub const KEY_Farsi_2 = 16778994;
pub const KEY_Farsi_3 = 16778995;
pub const KEY_Farsi_4 = 16778996;
pub const KEY_Farsi_5 = 16778997;
pub const KEY_Farsi_6 = 16778998;
pub const KEY_Farsi_7 = 16778999;
pub const KEY_Farsi_8 = 16779000;
pub const KEY_Farsi_9 = 16779001;
pub const KEY_Farsi_yeh = 16778956;
pub const KEY_FastReverse = 268964469;
pub const KEY_Favorites = 269025072;
pub const KEY_Finance = 269025084;
pub const KEY_Find = 65384;
pub const KEY_First_Virtual_Screen = 65232;
pub const KEY_FishingChart = 268964481;
pub const KEY_Fn = 268964304;
pub const KEY_FnRightShift = 268964325;
pub const KEY_Fn_Esc = 268964305;
pub const KEY_Forward = 269025063;
pub const KEY_FrameBack = 269025181;
pub const KEY_FrameForward = 269025182;
pub const KEY_FullScreen = 269025208;
pub const KEY_G = 71;
pub const KEY_Gabovedot = 725;
pub const KEY_Game = 269025118;
pub const KEY_Gbreve = 683;
pub const KEY_Gcaron = 16777702;
pub const KEY_Gcedilla = 939;
pub const KEY_Gcircumflex = 728;
pub const KEY_Georgian_an = 16781520;
pub const KEY_Georgian_ban = 16781521;
pub const KEY_Georgian_can = 16781546;
pub const KEY_Georgian_char = 16781549;
pub const KEY_Georgian_chin = 16781545;
pub const KEY_Georgian_cil = 16781548;
pub const KEY_Georgian_don = 16781523;
pub const KEY_Georgian_en = 16781524;
pub const KEY_Georgian_fi = 16781558;
pub const KEY_Georgian_gan = 16781522;
pub const KEY_Georgian_ghan = 16781542;
pub const KEY_Georgian_hae = 16781552;
pub const KEY_Georgian_har = 16781556;
pub const KEY_Georgian_he = 16781553;
pub const KEY_Georgian_hie = 16781554;
pub const KEY_Georgian_hoe = 16781557;
pub const KEY_Georgian_in = 16781528;
pub const KEY_Georgian_jhan = 16781551;
pub const KEY_Georgian_jil = 16781547;
pub const KEY_Georgian_kan = 16781529;
pub const KEY_Georgian_khar = 16781541;
pub const KEY_Georgian_las = 16781530;
pub const KEY_Georgian_man = 16781531;
pub const KEY_Georgian_nar = 16781532;
pub const KEY_Georgian_on = 16781533;
pub const KEY_Georgian_par = 16781534;
pub const KEY_Georgian_phar = 16781540;
pub const KEY_Georgian_qar = 16781543;
pub const KEY_Georgian_rae = 16781536;
pub const KEY_Georgian_san = 16781537;
pub const KEY_Georgian_shin = 16781544;
pub const KEY_Georgian_tan = 16781527;
pub const KEY_Georgian_tar = 16781538;
pub const KEY_Georgian_un = 16781539;
pub const KEY_Georgian_vin = 16781525;
pub const KEY_Georgian_we = 16781555;
pub const KEY_Georgian_xan = 16781550;
pub const KEY_Georgian_zen = 16781526;
pub const KEY_Georgian_zhar = 16781535;
pub const KEY_Go = 269025119;
pub const KEY_GraphicsEditor = 268964264;
pub const KEY_Greek_ALPHA = 1985;
pub const KEY_Greek_ALPHAaccent = 1953;
pub const KEY_Greek_BETA = 1986;
pub const KEY_Greek_CHI = 2007;
pub const KEY_Greek_DELTA = 1988;
pub const KEY_Greek_EPSILON = 1989;
pub const KEY_Greek_EPSILONaccent = 1954;
pub const KEY_Greek_ETA = 1991;
pub const KEY_Greek_ETAaccent = 1955;
pub const KEY_Greek_GAMMA = 1987;
pub const KEY_Greek_IOTA = 1993;
pub const KEY_Greek_IOTAaccent = 1956;
pub const KEY_Greek_IOTAdiaeresis = 1957;
pub const KEY_Greek_IOTAdieresis = 1957;
pub const KEY_Greek_KAPPA = 1994;
pub const KEY_Greek_LAMBDA = 1995;
pub const KEY_Greek_LAMDA = 1995;
pub const KEY_Greek_MU = 1996;
pub const KEY_Greek_NU = 1997;
pub const KEY_Greek_OMEGA = 2009;
pub const KEY_Greek_OMEGAaccent = 1963;
pub const KEY_Greek_OMICRON = 1999;
pub const KEY_Greek_OMICRONaccent = 1959;
pub const KEY_Greek_PHI = 2006;
pub const KEY_Greek_PI = 2000;
pub const KEY_Greek_PSI = 2008;
pub const KEY_Greek_RHO = 2001;
pub const KEY_Greek_SIGMA = 2002;
pub const KEY_Greek_TAU = 2004;
pub const KEY_Greek_THETA = 1992;
pub const KEY_Greek_UPSILON = 2005;
pub const KEY_Greek_UPSILONaccent = 1960;
pub const KEY_Greek_UPSILONdieresis = 1961;
pub const KEY_Greek_XI = 1998;
pub const KEY_Greek_ZETA = 1990;
pub const KEY_Greek_accentdieresis = 1966;
pub const KEY_Greek_alpha = 2017;
pub const KEY_Greek_alphaaccent = 1969;
pub const KEY_Greek_beta = 2018;
pub const KEY_Greek_chi = 2039;
pub const KEY_Greek_delta = 2020;
pub const KEY_Greek_epsilon = 2021;
pub const KEY_Greek_epsilonaccent = 1970;
pub const KEY_Greek_eta = 2023;
pub const KEY_Greek_etaaccent = 1971;
pub const KEY_Greek_finalsmallsigma = 2035;
pub const KEY_Greek_gamma = 2019;
pub const KEY_Greek_horizbar = 1967;
pub const KEY_Greek_iota = 2025;
pub const KEY_Greek_iotaaccent = 1972;
pub const KEY_Greek_iotaaccentdieresis = 1974;
pub const KEY_Greek_iotadieresis = 1973;
pub const KEY_Greek_kappa = 2026;
pub const KEY_Greek_lambda = 2027;
pub const KEY_Greek_lamda = 2027;
pub const KEY_Greek_mu = 2028;
pub const KEY_Greek_nu = 2029;
pub const KEY_Greek_omega = 2041;
pub const KEY_Greek_omegaaccent = 1979;
pub const KEY_Greek_omicron = 2031;
pub const KEY_Greek_omicronaccent = 1975;
pub const KEY_Greek_phi = 2038;
pub const KEY_Greek_pi = 2032;
pub const KEY_Greek_psi = 2040;
pub const KEY_Greek_rho = 2033;
pub const KEY_Greek_sigma = 2034;
pub const KEY_Greek_switch = 65406;
pub const KEY_Greek_tau = 2036;
pub const KEY_Greek_theta = 2024;
pub const KEY_Greek_upsilon = 2037;
pub const KEY_Greek_upsilonaccent = 1976;
pub const KEY_Greek_upsilonaccentdieresis = 1978;
pub const KEY_Greek_upsilondieresis = 1977;
pub const KEY_Greek_xi = 2030;
pub const KEY_Greek_zeta = 2022;
pub const KEY_Green = 269025188;
pub const KEY_H = 72;
pub const KEY_Hangul = 65329;
pub const KEY_Hangul_A = 3775;
pub const KEY_Hangul_AE = 3776;
pub const KEY_Hangul_AraeA = 3830;
pub const KEY_Hangul_AraeAE = 3831;
pub const KEY_Hangul_Banja = 65337;
pub const KEY_Hangul_Cieuc = 3770;
pub const KEY_Hangul_Codeinput = 65335;
pub const KEY_Hangul_Dikeud = 3751;
pub const KEY_Hangul_E = 3780;
pub const KEY_Hangul_EO = 3779;
pub const KEY_Hangul_EU = 3793;
pub const KEY_Hangul_End = 65331;
pub const KEY_Hangul_Hanja = 65332;
pub const KEY_Hangul_Hieuh = 3774;
pub const KEY_Hangul_I = 3795;
pub const KEY_Hangul_Ieung = 3767;
pub const KEY_Hangul_J_Cieuc = 3818;
pub const KEY_Hangul_J_Dikeud = 3802;
pub const KEY_Hangul_J_Hieuh = 3822;
pub const KEY_Hangul_J_Ieung = 3816;
pub const KEY_Hangul_J_Jieuj = 3817;
pub const KEY_Hangul_J_Khieuq = 3819;
pub const KEY_Hangul_J_Kiyeog = 3796;
pub const KEY_Hangul_J_KiyeogSios = 3798;
pub const KEY_Hangul_J_KkogjiDalrinIeung = 3833;
pub const KEY_Hangul_J_Mieum = 3811;
pub const KEY_Hangul_J_Nieun = 3799;
pub const KEY_Hangul_J_NieunHieuh = 3801;
pub const KEY_Hangul_J_NieunJieuj = 3800;
pub const KEY_Hangul_J_PanSios = 3832;
pub const KEY_Hangul_J_Phieuf = 3821;
pub const KEY_Hangul_J_Pieub = 3812;
pub const KEY_Hangul_J_PieubSios = 3813;
pub const KEY_Hangul_J_Rieul = 3803;
pub const KEY_Hangul_J_RieulHieuh = 3810;
pub const KEY_Hangul_J_RieulKiyeog = 3804;
pub const KEY_Hangul_J_RieulMieum = 3805;
pub const KEY_Hangul_J_RieulPhieuf = 3809;
pub const KEY_Hangul_J_RieulPieub = 3806;
pub const KEY_Hangul_J_RieulSios = 3807;
pub const KEY_Hangul_J_RieulTieut = 3808;
pub const KEY_Hangul_J_Sios = 3814;
pub const KEY_Hangul_J_SsangKiyeog = 3797;
pub const KEY_Hangul_J_SsangSios = 3815;
pub const KEY_Hangul_J_Tieut = 3820;
pub const KEY_Hangul_J_YeorinHieuh = 3834;
pub const KEY_Hangul_Jamo = 65333;
pub const KEY_Hangul_Jeonja = 65336;
pub const KEY_Hangul_Jieuj = 3768;
pub const KEY_Hangul_Khieuq = 3771;
pub const KEY_Hangul_Kiyeog = 3745;
pub const KEY_Hangul_KiyeogSios = 3747;
pub const KEY_Hangul_KkogjiDalrinIeung = 3827;
pub const KEY_Hangul_Mieum = 3761;
pub const KEY_Hangul_MultipleCandidate = 65341;
pub const KEY_Hangul_Nieun = 3748;
pub const KEY_Hangul_NieunHieuh = 3750;
pub const KEY_Hangul_NieunJieuj = 3749;
pub const KEY_Hangul_O = 3783;
pub const KEY_Hangul_OE = 3786;
pub const KEY_Hangul_PanSios = 3826;
pub const KEY_Hangul_Phieuf = 3773;
pub const KEY_Hangul_Pieub = 3762;
pub const KEY_Hangul_PieubSios = 3764;
pub const KEY_Hangul_PostHanja = 65339;
pub const KEY_Hangul_PreHanja = 65338;
pub const KEY_Hangul_PreviousCandidate = 65342;
pub const KEY_Hangul_Rieul = 3753;
pub const KEY_Hangul_RieulHieuh = 3760;
pub const KEY_Hangul_RieulKiyeog = 3754;
pub const KEY_Hangul_RieulMieum = 3755;
pub const KEY_Hangul_RieulPhieuf = 3759;
pub const KEY_Hangul_RieulPieub = 3756;
pub const KEY_Hangul_RieulSios = 3757;
pub const KEY_Hangul_RieulTieut = 3758;
pub const KEY_Hangul_RieulYeorinHieuh = 3823;
pub const KEY_Hangul_Romaja = 65334;
pub const KEY_Hangul_SingleCandidate = 65340;
pub const KEY_Hangul_Sios = 3765;
pub const KEY_Hangul_Special = 65343;
pub const KEY_Hangul_SsangDikeud = 3752;
pub const KEY_Hangul_SsangJieuj = 3769;
pub const KEY_Hangul_SsangKiyeog = 3746;
pub const KEY_Hangul_SsangPieub = 3763;
pub const KEY_Hangul_SsangSios = 3766;
pub const KEY_Hangul_Start = 65330;
pub const KEY_Hangul_SunkyeongeumMieum = 3824;
pub const KEY_Hangul_SunkyeongeumPhieuf = 3828;
pub const KEY_Hangul_SunkyeongeumPieub = 3825;
pub const KEY_Hangul_Tieut = 3772;
pub const KEY_Hangul_U = 3788;
pub const KEY_Hangul_WA = 3784;
pub const KEY_Hangul_WAE = 3785;
pub const KEY_Hangul_WE = 3790;
pub const KEY_Hangul_WEO = 3789;
pub const KEY_Hangul_WI = 3791;
pub const KEY_Hangul_YA = 3777;
pub const KEY_Hangul_YAE = 3778;
pub const KEY_Hangul_YE = 3782;
pub const KEY_Hangul_YEO = 3781;
pub const KEY_Hangul_YI = 3794;
pub const KEY_Hangul_YO = 3787;
pub const KEY_Hangul_YU = 3792;
pub const KEY_Hangul_YeorinHieuh = 3829;
pub const KEY_Hangul_switch = 65406;
pub const KEY_HangupPhone = 268964286;
pub const KEY_Hankaku = 65321;
pub const KEY_Hcircumflex = 678;
pub const KEY_Hebrew_switch = 65406;
pub const KEY_Help = 65386;
pub const KEY_Henkan = 65315;
pub const KEY_Henkan_Mode = 65315;
pub const KEY_Hibernate = 269025192;
pub const KEY_Hiragana = 65317;
pub const KEY_Hiragana_Katakana = 65319;
pub const KEY_History = 269025079;
pub const KEY_Home = 65360;
pub const KEY_HomePage = 269025048;
pub const KEY_HotLinks = 269025082;
pub const KEY_Hstroke = 673;
pub const KEY_Hyper_L = 65517;
pub const KEY_Hyper_R = 65518;
pub const KEY_I = 73;
pub const KEY_ISO_Center_Object = 65075;
pub const KEY_ISO_Continuous_Underline = 65072;
pub const KEY_ISO_Discontinuous_Underline = 65073;
pub const KEY_ISO_Emphasize = 65074;
pub const KEY_ISO_Enter = 65076;
pub const KEY_ISO_Fast_Cursor_Down = 65071;
pub const KEY_ISO_Fast_Cursor_Left = 65068;
pub const KEY_ISO_Fast_Cursor_Right = 65069;
pub const KEY_ISO_Fast_Cursor_Up = 65070;
pub const KEY_ISO_First_Group = 65036;
pub const KEY_ISO_First_Group_Lock = 65037;
pub const KEY_ISO_Group_Latch = 65030;
pub const KEY_ISO_Group_Lock = 65031;
pub const KEY_ISO_Group_Shift = 65406;
pub const KEY_ISO_Last_Group = 65038;
pub const KEY_ISO_Last_Group_Lock = 65039;
pub const KEY_ISO_Left_Tab = 65056;
pub const KEY_ISO_Level2_Latch = 65026;
pub const KEY_ISO_Level3_Latch = 65028;
pub const KEY_ISO_Level3_Lock = 65029;
pub const KEY_ISO_Level3_Shift = 65027;
pub const KEY_ISO_Level5_Latch = 65042;
pub const KEY_ISO_Level5_Lock = 65043;
pub const KEY_ISO_Level5_Shift = 65041;
pub const KEY_ISO_Lock = 65025;
pub const KEY_ISO_Move_Line_Down = 65058;
pub const KEY_ISO_Move_Line_Up = 65057;
pub const KEY_ISO_Next_Group = 65032;
pub const KEY_ISO_Next_Group_Lock = 65033;
pub const KEY_ISO_Partial_Line_Down = 65060;
pub const KEY_ISO_Partial_Line_Up = 65059;
pub const KEY_ISO_Partial_Space_Left = 65061;
pub const KEY_ISO_Partial_Space_Right = 65062;
pub const KEY_ISO_Prev_Group = 65034;
pub const KEY_ISO_Prev_Group_Lock = 65035;
pub const KEY_ISO_Release_Both_Margins = 65067;
pub const KEY_ISO_Release_Margin_Left = 65065;
pub const KEY_ISO_Release_Margin_Right = 65066;
pub const KEY_ISO_Set_Margin_Left = 65063;
pub const KEY_ISO_Set_Margin_Right = 65064;
pub const KEY_Iabovedot = 681;
pub const KEY_Iacute = 205;
pub const KEY_Ibelowdot = 16785098;
pub const KEY_Ibreve = 16777516;
pub const KEY_Icircumflex = 206;
pub const KEY_Idiaeresis = 207;
pub const KEY_Igrave = 204;
pub const KEY_Ihook = 16785096;
pub const KEY_Imacron = 975;
pub const KEY_Images = 268964282;
pub const KEY_Info = 268964198;
pub const KEY_Insert = 65379;
pub const KEY_Iogonek = 967;
pub const KEY_Itilde = 933;
pub const KEY_J = 74;
pub const KEY_Jcircumflex = 684;
pub const KEY_Journal = 268964418;
pub const KEY_K = 75;
pub const KEY_KP_0 = 65456;
pub const KEY_KP_1 = 65457;
pub const KEY_KP_2 = 65458;
pub const KEY_KP_3 = 65459;
pub const KEY_KP_4 = 65460;
pub const KEY_KP_5 = 65461;
pub const KEY_KP_6 = 65462;
pub const KEY_KP_7 = 65463;
pub const KEY_KP_8 = 65464;
pub const KEY_KP_9 = 65465;
pub const KEY_KP_Add = 65451;
pub const KEY_KP_Begin = 65437;
pub const KEY_KP_Decimal = 65454;
pub const KEY_KP_Delete = 65439;
pub const KEY_KP_Divide = 65455;
pub const KEY_KP_Down = 65433;
pub const KEY_KP_End = 65436;
pub const KEY_KP_Enter = 65421;
pub const KEY_KP_Equal = 65469;
pub const KEY_KP_F1 = 65425;
pub const KEY_KP_F2 = 65426;
pub const KEY_KP_F3 = 65427;
pub const KEY_KP_F4 = 65428;
pub const KEY_KP_Home = 65429;
pub const KEY_KP_Insert = 65438;
pub const KEY_KP_Left = 65430;
pub const KEY_KP_Multiply = 65450;
pub const KEY_KP_Next = 65435;
pub const KEY_KP_Page_Down = 65435;
pub const KEY_KP_Page_Up = 65434;
pub const KEY_KP_Prior = 65434;
pub const KEY_KP_Right = 65432;
pub const KEY_KP_Separator = 65452;
pub const KEY_KP_Space = 65408;
pub const KEY_KP_Subtract = 65453;
pub const KEY_KP_Tab = 65417;
pub const KEY_KP_Up = 65431;
pub const KEY_Kana_Lock = 65325;
pub const KEY_Kana_Shift = 65326;
pub const KEY_Kanji = 65313;
pub const KEY_Kanji_Bangou = 65335;
pub const KEY_Katakana = 65318;
pub const KEY_KbdBrightnessDown = 269025030;
pub const KEY_KbdBrightnessUp = 269025029;
pub const KEY_KbdInputAssistAccept = 268964452;
pub const KEY_KbdInputAssistCancel = 268964453;
pub const KEY_KbdInputAssistNext = 268964449;
pub const KEY_KbdInputAssistNextgroup = 268964451;
pub const KEY_KbdInputAssistPrev = 268964448;
pub const KEY_KbdInputAssistPrevgroup = 268964450;
pub const KEY_KbdLcdMenu1 = 268964536;
pub const KEY_KbdLcdMenu2 = 268964537;
pub const KEY_KbdLcdMenu3 = 268964538;
pub const KEY_KbdLcdMenu4 = 268964539;
pub const KEY_KbdLcdMenu5 = 268964540;
pub const KEY_KbdLightOnOff = 269025028;
pub const KEY_Kcedilla = 979;
pub const KEY_Keyboard = 269025203;
pub const KEY_Korean_Won = 3839;
pub const KEY_L = 76;
pub const KEY_L1 = 65480;
pub const KEY_L10 = 65489;
pub const KEY_L2 = 65481;
pub const KEY_L3 = 65482;
pub const KEY_L4 = 65483;
pub const KEY_L5 = 65484;
pub const KEY_L6 = 65485;
pub const KEY_L7 = 65486;
pub const KEY_L8 = 65487;
pub const KEY_L9 = 65488;
pub const KEY_Lacute = 453;
pub const KEY_Last_Virtual_Screen = 65236;
pub const KEY_Launch0 = 269025088;
pub const KEY_Launch1 = 269025089;
pub const KEY_Launch2 = 269025090;
pub const KEY_Launch3 = 269025091;
pub const KEY_Launch4 = 269025092;
pub const KEY_Launch5 = 269025093;
pub const KEY_Launch6 = 269025094;
pub const KEY_Launch7 = 269025095;
pub const KEY_Launch8 = 269025096;
pub const KEY_Launch9 = 269025097;
pub const KEY_LaunchA = 269025098;
pub const KEY_LaunchB = 269025099;
pub const KEY_LaunchC = 269025100;
pub const KEY_LaunchD = 269025101;
pub const KEY_LaunchE = 269025102;
pub const KEY_LaunchF = 269025103;
pub const KEY_Lbelowdot = 16784950;
pub const KEY_Lcaron = 421;
pub const KEY_Lcedilla = 934;
pub const KEY_Left = 65361;
pub const KEY_LeftDown = 268964457;
pub const KEY_LeftUp = 268964456;
pub const KEY_LightBulb = 269025077;
pub const KEY_LightsToggle = 268964382;
pub const KEY_Linefeed = 65290;
pub const KEY_LiraSign = 16785572;
pub const KEY_LogGrabInfo = 269024805;
pub const KEY_LogOff = 269025121;
pub const KEY_LogWindowTree = 269024804;
pub const KEY_Lstroke = 419;
pub const KEY_M = 77;
pub const KEY_Mabovedot = 16784960;
pub const KEY_Macedonia_DSE = 1717;
pub const KEY_Macedonia_GJE = 1714;
pub const KEY_Macedonia_KJE = 1724;
pub const KEY_Macedonia_dse = 1701;
pub const KEY_Macedonia_gje = 1698;
pub const KEY_Macedonia_kje = 1708;
pub const KEY_Macro1 = 268964496;
pub const KEY_Macro10 = 268964505;
pub const KEY_Macro11 = 268964506;
pub const KEY_Macro12 = 268964507;
pub const KEY_Macro13 = 268964508;
pub const KEY_Macro14 = 268964509;
pub const KEY_Macro15 = 268964510;
pub const KEY_Macro16 = 268964511;
pub const KEY_Macro17 = 268964512;
pub const KEY_Macro18 = 268964513;
pub const KEY_Macro19 = 268964514;
pub const KEY_Macro2 = 268964497;
pub const KEY_Macro20 = 268964515;
pub const KEY_Macro21 = 268964516;
pub const KEY_Macro22 = 268964517;
pub const KEY_Macro23 = 268964518;
pub const KEY_Macro24 = 268964519;
pub const KEY_Macro25 = 268964520;
pub const KEY_Macro26 = 268964521;
pub const KEY_Macro27 = 268964522;
pub const KEY_Macro28 = 268964523;
pub const KEY_Macro29 = 268964524;
pub const KEY_Macro3 = 268964498;
pub const KEY_Macro30 = 268964525;
pub const KEY_Macro4 = 268964499;
pub const KEY_Macro5 = 268964500;
pub const KEY_Macro6 = 268964501;
pub const KEY_Macro7 = 268964502;
pub const KEY_Macro8 = 268964503;
pub const KEY_Macro9 = 268964504;
pub const KEY_MacroPreset1 = 268964531;
pub const KEY_MacroPreset2 = 268964532;
pub const KEY_MacroPreset3 = 268964533;
pub const KEY_MacroPresetCycle = 268964530;
pub const KEY_MacroRecordStart = 268964528;
pub const KEY_MacroRecordStop = 268964529;
pub const KEY_Mae_Koho = 65342;
pub const KEY_Mail = 269025049;
pub const KEY_MailForward = 269025168;
pub const KEY_MarkWaypoint = 268964478;
pub const KEY_Market = 269025122;
pub const KEY_Massyo = 65324;
pub const KEY_MediaRepeat = 268964279;
pub const KEY_MediaTopMenu = 268964459;
pub const KEY_Meeting = 269025123;
pub const KEY_Memo = 269025054;
pub const KEY_Menu = 65383;
pub const KEY_MenuKB = 269025125;
pub const KEY_MenuPB = 269025126;
pub const KEY_Messenger = 269025166;
pub const KEY_Meta_L = 65511;
pub const KEY_Meta_R = 65512;
pub const KEY_MillSign = 16785573;
pub const KEY_ModeLock = 269025025;
pub const KEY_Mode_switch = 65406;
pub const KEY_MonBrightnessCycle = 269025031;
pub const KEY_MonBrightnessDown = 269025027;
pub const KEY_MonBrightnessUp = 269025026;
pub const KEY_MouseKeys_Accel_Enable = 65143;
pub const KEY_MouseKeys_Enable = 65142;
pub const KEY_Muhenkan = 65314;
pub const KEY_Multi_key = 65312;
pub const KEY_MultipleCandidate = 65341;
pub const KEY_Music = 269025170;
pub const KEY_MyComputer = 269025075;
pub const KEY_MySites = 269025127;
pub const KEY_N = 78;
pub const KEY_Nacute = 465;
pub const KEY_NairaSign = 16785574;
pub const KEY_NavChart = 268964480;
pub const KEY_NavInfo = 268964488;
pub const KEY_Ncaron = 466;
pub const KEY_Ncedilla = 977;
pub const KEY_New = 269025128;
pub const KEY_NewSheqelSign = 16785578;
pub const KEY_News = 269025129;
pub const KEY_Next = 65366;
pub const KEY_NextElement = 268964475;
pub const KEY_NextFavorite = 268964464;
pub const KEY_Next_VMode = 269024802;
pub const KEY_Next_Virtual_Screen = 65234;
pub const KEY_NotificationCenter = 268964284;
pub const KEY_Ntilde = 209;
pub const KEY_Num_Lock = 65407;
pub const KEY_Numeric0 = 268964352;
pub const KEY_Numeric1 = 268964353;
pub const KEY_Numeric11 = 268964460;
pub const KEY_Numeric12 = 268964461;
pub const KEY_Numeric2 = 268964354;
pub const KEY_Numeric3 = 268964355;
pub const KEY_Numeric4 = 268964356;
pub const KEY_Numeric5 = 268964357;
pub const KEY_Numeric6 = 268964358;
pub const KEY_Numeric7 = 268964359;
pub const KEY_Numeric8 = 268964360;
pub const KEY_Numeric9 = 268964361;
pub const KEY_NumericA = 268964364;
pub const KEY_NumericB = 268964365;
pub const KEY_NumericC = 268964366;
pub const KEY_NumericD = 268964367;
pub const KEY_NumericPound = 268964363;
pub const KEY_NumericStar = 268964362;
pub const KEY_O = 79;
pub const KEY_OE = 5052;
pub const KEY_Oacute = 211;
pub const KEY_Obarred = 16777631;
pub const KEY_Obelowdot = 16785100;
pub const KEY_Ocaron = 16777681;
pub const KEY_Ocircumflex = 212;
pub const KEY_Ocircumflexacute = 16785104;
pub const KEY_Ocircumflexbelowdot = 16785112;
pub const KEY_Ocircumflexgrave = 16785106;
pub const KEY_Ocircumflexhook = 16785108;
pub const KEY_Ocircumflextilde = 16785110;
pub const KEY_Odiaeresis = 214;
pub const KEY_Odoubleacute = 469;
pub const KEY_OfficeHome = 269025130;
pub const KEY_Ograve = 210;
pub const KEY_Ohook = 16785102;
pub const KEY_Ohorn = 16777632;
pub const KEY_Ohornacute = 16785114;
pub const KEY_Ohornbelowdot = 16785122;
pub const KEY_Ohorngrave = 16785116;
pub const KEY_Ohornhook = 16785118;
pub const KEY_Ohorntilde = 16785120;
pub const KEY_Omacron = 978;
pub const KEY_OnScreenKeyboard = 268964472;
pub const KEY_Ooblique = 216;
pub const KEY_Open = 269025131;
pub const KEY_OpenURL = 269025080;
pub const KEY_Option = 269025132;
pub const KEY_Oslash = 216;
pub const KEY_Otilde = 213;
pub const KEY_Overlay1_Enable = 65144;
pub const KEY_Overlay2_Enable = 65145;
pub const KEY_P = 80;
pub const KEY_Pabovedot = 16784982;
pub const KEY_Page_Down = 65366;
pub const KEY_Page_Up = 65365;
pub const KEY_Paste = 269025133;
pub const KEY_Pause = 65299;
pub const KEY_PauseRecord = 268964466;
pub const KEY_PesetaSign = 16785575;
pub const KEY_Phone = 269025134;
pub const KEY_PickupPhone = 268964285;
pub const KEY_Pictures = 269025169;
pub const KEY_Pointer_Accelerate = 65274;
pub const KEY_Pointer_Button1 = 65257;
pub const KEY_Pointer_Button2 = 65258;
pub const KEY_Pointer_Button3 = 65259;
pub const KEY_Pointer_Button4 = 65260;
pub const KEY_Pointer_Button5 = 65261;
pub const KEY_Pointer_Button_Dflt = 65256;
pub const KEY_Pointer_DblClick1 = 65263;
pub const KEY_Pointer_DblClick2 = 65264;
pub const KEY_Pointer_DblClick3 = 65265;
pub const KEY_Pointer_DblClick4 = 65266;
pub const KEY_Pointer_DblClick5 = 65267;
pub const KEY_Pointer_DblClick_Dflt = 65262;
pub const KEY_Pointer_DfltBtnNext = 65275;
pub const KEY_Pointer_DfltBtnPrev = 65276;
pub const KEY_Pointer_Down = 65251;
pub const KEY_Pointer_DownLeft = 65254;
pub const KEY_Pointer_DownRight = 65255;
pub const KEY_Pointer_Drag1 = 65269;
pub const KEY_Pointer_Drag2 = 65270;
pub const KEY_Pointer_Drag3 = 65271;
pub const KEY_Pointer_Drag4 = 65272;
pub const KEY_Pointer_Drag5 = 65277;
pub const KEY_Pointer_Drag_Dflt = 65268;
pub const KEY_Pointer_EnableKeys = 65273;
pub const KEY_Pointer_Left = 65248;
pub const KEY_Pointer_Right = 65249;
pub const KEY_Pointer_Up = 65250;
pub const KEY_Pointer_UpLeft = 65252;
pub const KEY_Pointer_UpRight = 65253;
pub const KEY_PowerDown = 269025057;
pub const KEY_PowerOff = 269025066;
pub const KEY_Presentation = 268964265;
pub const KEY_Prev_VMode = 269024803;
pub const KEY_Prev_Virtual_Screen = 65233;
pub const KEY_PreviousCandidate = 65342;
pub const KEY_PreviousElement = 268964476;
pub const KEY_Print = 65377;
pub const KEY_Prior = 65365;
pub const KEY_PrivacyScreenToggle = 268964473;
pub const KEY_Q = 81;
pub const KEY_R = 82;
pub const KEY_R1 = 65490;
pub const KEY_R10 = 65499;
pub const KEY_R11 = 65500;
pub const KEY_R12 = 65501;
pub const KEY_R13 = 65502;
pub const KEY_R14 = 65503;
pub const KEY_R15 = 65504;
pub const KEY_R2 = 65491;
pub const KEY_R3 = 65492;
pub const KEY_R4 = 65493;
pub const KEY_R5 = 65494;
pub const KEY_R6 = 65495;
pub const KEY_R7 = 65496;
pub const KEY_R8 = 65497;
pub const KEY_R9 = 65498;
pub const KEY_RFKill = 269025205;
pub const KEY_Racute = 448;
pub const KEY_RadarOverlay = 268964484;
pub const KEY_Rcaron = 472;
pub const KEY_Rcedilla = 931;
pub const KEY_Red = 269025187;
pub const KEY_Redo = 65382;
pub const KEY_Refresh = 269025065;
pub const KEY_RefreshRateToggle = 268964402;
pub const KEY_Reload = 269025139;
pub const KEY_RepeatKeys_Enable = 65138;
pub const KEY_Reply = 269025138;
pub const KEY_Return = 65293;
pub const KEY_Right = 65363;
pub const KEY_RightDown = 268964455;
pub const KEY_RightUp = 268964454;
pub const KEY_RockerDown = 269025060;
pub const KEY_RockerEnter = 269025061;
pub const KEY_RockerUp = 269025059;
pub const KEY_Romaji = 65316;
pub const KEY_RootMenu = 268964458;
pub const KEY_RotateWindows = 269025140;
pub const KEY_RotationKB = 269025142;
pub const KEY_RotationLockToggle = 269025207;
pub const KEY_RotationPB = 269025141;
pub const KEY_RupeeSign = 16785576;
pub const KEY_S = 83;
pub const KEY_SCHWA = 16777615;
pub const KEY_Sabovedot = 16784992;
pub const KEY_Sacute = 422;
pub const KEY_Save = 269025143;
pub const KEY_Scaron = 425;
pub const KEY_Scedilla = 426;
pub const KEY_Scircumflex = 734;
pub const KEY_ScreenSaver = 269025069;
pub const KEY_Screensaver = 268964421;
pub const KEY_ScrollClick = 269025146;
pub const KEY_ScrollDown = 269025145;
pub const KEY_ScrollUp = 269025144;
pub const KEY_Scroll_Lock = 65300;
pub const KEY_Search = 269025051;
pub const KEY_Select = 65376;
pub const KEY_SelectButton = 269025184;
pub const KEY_SelectiveScreenshot = 268964474;
pub const KEY_Send = 269025147;
pub const KEY_Serbian_DJE = 1713;
pub const KEY_Serbian_DZE = 1727;
pub const KEY_Serbian_JE = 1720;
pub const KEY_Serbian_LJE = 1721;
pub const KEY_Serbian_NJE = 1722;
pub const KEY_Serbian_TSHE = 1723;
pub const KEY_Serbian_dje = 1697;
pub const KEY_Serbian_dze = 1711;
pub const KEY_Serbian_je = 1704;
pub const KEY_Serbian_lje = 1705;
pub const KEY_Serbian_nje = 1706;
pub const KEY_Serbian_tshe = 1707;
pub const KEY_Shift_L = 65505;
pub const KEY_Shift_Lock = 65510;
pub const KEY_Shift_R = 65506;
pub const KEY_Shop = 269025078;
pub const KEY_SidevuSonar = 268964487;
pub const KEY_SingleCandidate = 65340;
pub const KEY_SingleRangeRadar = 268964482;
pub const KEY_Sinh_a = 16780677;
pub const KEY_Sinh_aa = 16780678;
pub const KEY_Sinh_aa2 = 16780751;
pub const KEY_Sinh_ae = 16780679;
pub const KEY_Sinh_ae2 = 16780752;
pub const KEY_Sinh_aee = 16780680;
pub const KEY_Sinh_aee2 = 16780753;
pub const KEY_Sinh_ai = 16780691;
pub const KEY_Sinh_ai2 = 16780763;
pub const KEY_Sinh_al = 16780746;
pub const KEY_Sinh_au = 16780694;
pub const KEY_Sinh_au2 = 16780766;
pub const KEY_Sinh_ba = 16780726;
pub const KEY_Sinh_bha = 16780727;
pub const KEY_Sinh_ca = 16780704;
pub const KEY_Sinh_cha = 16780705;
pub const KEY_Sinh_dda = 16780713;
pub const KEY_Sinh_ddha = 16780714;
pub const KEY_Sinh_dha = 16780719;
pub const KEY_Sinh_dhha = 16780720;
pub const KEY_Sinh_e = 16780689;
pub const KEY_Sinh_e2 = 16780761;
pub const KEY_Sinh_ee = 16780690;
pub const KEY_Sinh_ee2 = 16780762;
pub const KEY_Sinh_fa = 16780742;
pub const KEY_Sinh_ga = 16780700;
pub const KEY_Sinh_gha = 16780701;
pub const KEY_Sinh_h2 = 16780675;
pub const KEY_Sinh_ha = 16780740;
pub const KEY_Sinh_i = 16780681;
pub const KEY_Sinh_i2 = 16780754;
pub const KEY_Sinh_ii = 16780682;
pub const KEY_Sinh_ii2 = 16780755;
pub const KEY_Sinh_ja = 16780706;
pub const KEY_Sinh_jha = 16780707;
pub const KEY_Sinh_jnya = 16780709;
pub const KEY_Sinh_ka = 16780698;
pub const KEY_Sinh_kha = 16780699;
pub const KEY_Sinh_kunddaliya = 16780788;
pub const KEY_Sinh_la = 16780733;
pub const KEY_Sinh_lla = 16780741;
pub const KEY_Sinh_lu = 16780687;
pub const KEY_Sinh_lu2 = 16780767;
pub const KEY_Sinh_luu = 16780688;
pub const KEY_Sinh_luu2 = 16780787;
pub const KEY_Sinh_ma = 16780728;
pub const KEY_Sinh_mba = 16780729;
pub const KEY_Sinh_na = 16780721;
pub const KEY_Sinh_ndda = 16780716;
pub const KEY_Sinh_ndha = 16780723;
pub const KEY_Sinh_ng = 16780674;
pub const KEY_Sinh_ng2 = 16780702;
pub const KEY_Sinh_nga = 16780703;
pub const KEY_Sinh_nja = 16780710;
pub const KEY_Sinh_nna = 16780715;
pub const KEY_Sinh_nya = 16780708;
pub const KEY_Sinh_o = 16780692;
pub const KEY_Sinh_o2 = 16780764;
pub const KEY_Sinh_oo = 16780693;
pub const KEY_Sinh_oo2 = 16780765;
pub const KEY_Sinh_pa = 16780724;
pub const KEY_Sinh_pha = 16780725;
pub const KEY_Sinh_ra = 16780731;
pub const KEY_Sinh_ri = 16780685;
pub const KEY_Sinh_rii = 16780686;
pub const KEY_Sinh_ru2 = 16780760;
pub const KEY_Sinh_ruu2 = 16780786;
pub const KEY_Sinh_sa = 16780739;
pub const KEY_Sinh_sha = 16780737;
pub const KEY_Sinh_ssha = 16780738;
pub const KEY_Sinh_tha = 16780717;
pub const KEY_Sinh_thha = 16780718;
pub const KEY_Sinh_tta = 16780711;
pub const KEY_Sinh_ttha = 16780712;
pub const KEY_Sinh_u = 16780683;
pub const KEY_Sinh_u2 = 16780756;
pub const KEY_Sinh_uu = 16780684;
pub const KEY_Sinh_uu2 = 16780758;
pub const KEY_Sinh_va = 16780736;
pub const KEY_Sinh_ya = 16780730;
pub const KEY_Sleep = 269025071;
pub const KEY_SlowKeys_Enable = 65139;
pub const KEY_SlowReverse = 268964470;
pub const KEY_Sos = 268964479;
pub const KEY_Spell = 269025148;
pub const KEY_SpellCheck = 268964272;
pub const KEY_SplitScreen = 269025149;
pub const KEY_Standby = 269025040;
pub const KEY_Start = 269025050;
pub const KEY_StickyKeys_Enable = 65141;
pub const KEY_Stop = 269025064;
pub const KEY_StopRecord = 268964465;
pub const KEY_Subtitle = 269025178;
pub const KEY_Super_L = 65515;
pub const KEY_Super_R = 65516;
pub const KEY_Support = 269025150;
pub const KEY_Suspend = 269025191;
pub const KEY_Switch_VT_1 = 269024769;
pub const KEY_Switch_VT_10 = 269024778;
pub const KEY_Switch_VT_11 = 269024779;
pub const KEY_Switch_VT_12 = 269024780;
pub const KEY_Switch_VT_2 = 269024770;
pub const KEY_Switch_VT_3 = 269024771;
pub const KEY_Switch_VT_4 = 269024772;
pub const KEY_Switch_VT_5 = 269024773;
pub const KEY_Switch_VT_6 = 269024774;
pub const KEY_Switch_VT_7 = 269024775;
pub const KEY_Switch_VT_8 = 269024776;
pub const KEY_Switch_VT_9 = 269024777;
pub const KEY_Sys_Req = 65301;
pub const KEY_T = 84;
pub const KEY_THORN = 222;
pub const KEY_Tab = 65289;
pub const KEY_Tabovedot = 16785002;
pub const KEY_TaskPane = 269025151;
pub const KEY_Taskmanager = 268964417;
pub const KEY_Tcaron = 427;
pub const KEY_Tcedilla = 478;
pub const KEY_Terminal = 269025152;
pub const KEY_Terminate_Server = 65237;
pub const KEY_Thai_baht = 3551;
pub const KEY_Thai_bobaimai = 3514;
pub const KEY_Thai_chochan = 3496;
pub const KEY_Thai_chochang = 3498;
pub const KEY_Thai_choching = 3497;
pub const KEY_Thai_chochoe = 3500;
pub const KEY_Thai_dochada = 3502;
pub const KEY_Thai_dodek = 3508;
pub const KEY_Thai_fofa = 3517;
pub const KEY_Thai_fofan = 3519;
pub const KEY_Thai_hohip = 3531;
pub const KEY_Thai_honokhuk = 3534;
pub const KEY_Thai_khokhai = 3490;
pub const KEY_Thai_khokhon = 3493;
pub const KEY_Thai_khokhuat = 3491;
pub const KEY_Thai_khokhwai = 3492;
pub const KEY_Thai_khorakhang = 3494;
pub const KEY_Thai_kokai = 3489;
pub const KEY_Thai_lakkhangyao = 3557;
pub const KEY_Thai_lekchet = 3575;
pub const KEY_Thai_lekha = 3573;
pub const KEY_Thai_lekhok = 3574;
pub const KEY_Thai_lekkao = 3577;
pub const KEY_Thai_leknung = 3569;
pub const KEY_Thai_lekpaet = 3576;
pub const KEY_Thai_leksam = 3571;
pub const KEY_Thai_leksi = 3572;
pub const KEY_Thai_leksong = 3570;
pub const KEY_Thai_leksun = 3568;
pub const KEY_Thai_lochula = 3532;
pub const KEY_Thai_loling = 3525;
pub const KEY_Thai_lu = 3526;
pub const KEY_Thai_maichattawa = 3563;
pub const KEY_Thai_maiek = 3560;
pub const KEY_Thai_maihanakat = 3537;
pub const KEY_Thai_maihanakat_maitho = 3550;
pub const KEY_Thai_maitaikhu = 3559;
pub const KEY_Thai_maitho = 3561;
pub const KEY_Thai_maitri = 3562;
pub const KEY_Thai_maiyamok = 3558;
pub const KEY_Thai_moma = 3521;
pub const KEY_Thai_ngongu = 3495;
pub const KEY_Thai_nikhahit = 3565;
pub const KEY_Thai_nonen = 3507;
pub const KEY_Thai_nonu = 3513;
pub const KEY_Thai_oang = 3533;
pub const KEY_Thai_paiyannoi = 3535;
pub const KEY_Thai_phinthu = 3546;
pub const KEY_Thai_phophan = 3518;
pub const KEY_Thai_phophung = 3516;
pub const KEY_Thai_phosamphao = 3520;
pub const KEY_Thai_popla = 3515;
pub const KEY_Thai_rorua = 3523;
pub const KEY_Thai_ru = 3524;
pub const KEY_Thai_saraa = 3536;
pub const KEY_Thai_saraaa = 3538;
pub const KEY_Thai_saraae = 3553;
pub const KEY_Thai_saraaimaimalai = 3556;
pub const KEY_Thai_saraaimaimuan = 3555;
pub const KEY_Thai_saraam = 3539;
pub const KEY_Thai_sarae = 3552;
pub const KEY_Thai_sarai = 3540;
pub const KEY_Thai_saraii = 3541;
pub const KEY_Thai_sarao = 3554;
pub const KEY_Thai_sarau = 3544;
pub const KEY_Thai_saraue = 3542;
pub const KEY_Thai_sarauee = 3543;
pub const KEY_Thai_sarauu = 3545;
pub const KEY_Thai_sorusi = 3529;
pub const KEY_Thai_sosala = 3528;
pub const KEY_Thai_soso = 3499;
pub const KEY_Thai_sosua = 3530;
pub const KEY_Thai_thanthakhat = 3564;
pub const KEY_Thai_thonangmontho = 3505;
pub const KEY_Thai_thophuthao = 3506;
pub const KEY_Thai_thothahan = 3511;
pub const KEY_Thai_thothan = 3504;
pub const KEY_Thai_thothong = 3512;
pub const KEY_Thai_thothung = 3510;
pub const KEY_Thai_topatak = 3503;
pub const KEY_Thai_totao = 3509;
pub const KEY_Thai_wowaen = 3527;
pub const KEY_Thai_yoyak = 3522;
pub const KEY_Thai_yoying = 3501;
pub const KEY_Thorn = 222;
pub const KEY_Time = 269025183;
pub const KEY_ToDoList = 269025055;
pub const KEY_Tools = 269025153;
pub const KEY_TopMenu = 269025186;
pub const KEY_TouchpadOff = 269025201;
pub const KEY_TouchpadOn = 269025200;
pub const KEY_TouchpadToggle = 269025193;
pub const KEY_Touroku = 65323;
pub const KEY_TraditionalSonar = 268964485;
pub const KEY_Travel = 269025154;
pub const KEY_Tslash = 940;
pub const KEY_U = 85;
pub const KEY_UWB = 269025174;
pub const KEY_Uacute = 218;
pub const KEY_Ubelowdot = 16785124;
pub const KEY_Ubreve = 733;
pub const KEY_Ucircumflex = 219;
pub const KEY_Udiaeresis = 220;
pub const KEY_Udoubleacute = 475;
pub const KEY_Ugrave = 217;
pub const KEY_Uhook = 16785126;
pub const KEY_Uhorn = 16777647;
pub const KEY_Uhornacute = 16785128;
pub const KEY_Uhornbelowdot = 16785136;
pub const KEY_Uhorngrave = 16785130;
pub const KEY_Uhornhook = 16785132;
pub const KEY_Uhorntilde = 16785134;
pub const KEY_Ukrainian_GHE_WITH_UPTURN = 1725;
pub const KEY_Ukrainian_I = 1718;
pub const KEY_Ukrainian_IE = 1716;
pub const KEY_Ukrainian_YI = 1719;
pub const KEY_Ukrainian_ghe_with_upturn = 1709;
pub const KEY_Ukrainian_i = 1702;
pub const KEY_Ukrainian_ie = 1700;
pub const KEY_Ukrainian_yi = 1703;
pub const KEY_Ukranian_I = 1718;
pub const KEY_Ukranian_JE = 1716;
pub const KEY_Ukranian_YI = 1719;
pub const KEY_Ukranian_i = 1702;
pub const KEY_Ukranian_je = 1700;
pub const KEY_Ukranian_yi = 1703;
pub const KEY_Umacron = 990;
pub const KEY_Undo = 65381;
pub const KEY_Ungrab = 269024800;
pub const KEY_Unmute = 268964468;
pub const KEY_Uogonek = 985;
pub const KEY_Up = 65362;
pub const KEY_Uring = 473;
pub const KEY_User1KB = 269025157;
pub const KEY_User2KB = 269025158;
pub const KEY_UserPB = 269025156;
pub const KEY_Utilde = 989;
pub const KEY_V = 86;
pub const KEY_VOD = 268964467;
pub const KEY_VendorHome = 269025076;
pub const KEY_Video = 269025159;
pub const KEY_VideoPhone = 268964256;
pub const KEY_View = 269025185;
pub const KEY_VoiceCommand = 268964422;
pub const KEY_Voicemail = 268964268;
pub const KEY_VoidSymbol = 16777215;
pub const KEY_W = 87;
pub const KEY_WLAN = 269025173;
pub const KEY_WPSButton = 268964369;
pub const KEY_WWAN = 269025204;
pub const KEY_WWW = 269025070;
pub const KEY_Wacute = 16785026;
pub const KEY_WakeUp = 269025067;
pub const KEY_Wcircumflex = 16777588;
pub const KEY_Wdiaeresis = 16785028;
pub const KEY_WebCam = 269025167;
pub const KEY_Wgrave = 16785024;
pub const KEY_WheelButton = 269025160;
pub const KEY_WindowClear = 269025109;
pub const KEY_WonSign = 16785577;
pub const KEY_Word = 269025161;
pub const KEY_X = 88;
pub const KEY_Xabovedot = 16785034;
pub const KEY_Xfer = 269025162;
pub const KEY_Y = 89;
pub const KEY_Yacute = 221;
pub const KEY_Ybelowdot = 16785140;
pub const KEY_Ycircumflex = 16777590;
pub const KEY_Ydiaeresis = 5054;
pub const KEY_Yellow = 269025189;
pub const KEY_Ygrave = 16785138;
pub const KEY_Yhook = 16785142;
pub const KEY_Ytilde = 16785144;
pub const KEY_Z = 90;
pub const KEY_Zabovedot = 431;
pub const KEY_Zacute = 428;
pub const KEY_Zcaron = 430;
pub const KEY_Zen_Koho = 65341;
pub const KEY_Zenkaku = 65320;
pub const KEY_Zenkaku_Hankaku = 65322;
pub const KEY_ZoomIn = 269025163;
pub const KEY_ZoomOut = 269025164;
pub const KEY_ZoomReset = 268964260;
pub const KEY_Zstroke = 16777653;
pub const KEY_a = 97;
pub const KEY_aacute = 225;
pub const KEY_abelowdot = 16785057;
pub const KEY_abovedot = 511;
pub const KEY_abreve = 483;
pub const KEY_abreveacute = 16785071;
pub const KEY_abrevebelowdot = 16785079;
pub const KEY_abrevegrave = 16785073;
pub const KEY_abrevehook = 16785075;
pub const KEY_abrevetilde = 16785077;
pub const KEY_acircumflex = 226;
pub const KEY_acircumflexacute = 16785061;
pub const KEY_acircumflexbelowdot = 16785069;
pub const KEY_acircumflexgrave = 16785063;
pub const KEY_acircumflexhook = 16785065;
pub const KEY_acircumflextilde = 16785067;
pub const KEY_acute = 180;
pub const KEY_adiaeresis = 228;
pub const KEY_ae = 230;
pub const KEY_agrave = 224;
pub const KEY_ahook = 16785059;
pub const KEY_amacron = 992;
pub const KEY_ampersand = 38;
pub const KEY_aogonek = 433;
pub const KEY_apostrophe = 39;
pub const KEY_approxeq = 16785992;
pub const KEY_approximate = 2248;
pub const KEY_aring = 229;
pub const KEY_asciicircum = 94;
pub const KEY_asciitilde = 126;
pub const KEY_asterisk = 42;
pub const KEY_at = 64;
pub const KEY_atilde = 227;
pub const KEY_b = 98;
pub const KEY_babovedot = 16784899;
pub const KEY_backslash = 92;
pub const KEY_ballotcross = 2804;
pub const KEY_bar = 124;
pub const KEY_because = 16785973;
pub const KEY_blank = 2527;
pub const KEY_botintegral = 2213;
pub const KEY_botleftparens = 2220;
pub const KEY_botleftsqbracket = 2216;
pub const KEY_botleftsummation = 2226;
pub const KEY_botrightparens = 2222;
pub const KEY_botrightsqbracket = 2218;
pub const KEY_botrightsummation = 2230;
pub const KEY_bott = 2550;
pub const KEY_botvertsummationconnector = 2228;
pub const KEY_braceleft = 123;
pub const KEY_braceright = 125;
pub const KEY_bracketleft = 91;
pub const KEY_bracketright = 93;
pub const KEY_braille_blank = 16787456;
pub const KEY_braille_dot_1 = 65521;
pub const KEY_braille_dot_10 = 65530;
pub const KEY_braille_dot_2 = 65522;
pub const KEY_braille_dot_3 = 65523;
pub const KEY_braille_dot_4 = 65524;
pub const KEY_braille_dot_5 = 65525;
pub const KEY_braille_dot_6 = 65526;
pub const KEY_braille_dot_7 = 65527;
pub const KEY_braille_dot_8 = 65528;
pub const KEY_braille_dot_9 = 65529;
pub const KEY_braille_dots_1 = 16787457;
pub const KEY_braille_dots_12 = 16787459;
pub const KEY_braille_dots_123 = 16787463;
pub const KEY_braille_dots_1234 = 16787471;
pub const KEY_braille_dots_12345 = 16787487;
pub const KEY_braille_dots_123456 = 16787519;
pub const KEY_braille_dots_1234567 = 16787583;
pub const KEY_braille_dots_12345678 = 16787711;
pub const KEY_braille_dots_1234568 = 16787647;
pub const KEY_braille_dots_123457 = 16787551;
pub const KEY_braille_dots_1234578 = 16787679;
pub const KEY_braille_dots_123458 = 16787615;
pub const KEY_braille_dots_12346 = 16787503;
pub const KEY_braille_dots_123467 = 16787567;
pub const KEY_braille_dots_1234678 = 16787695;
pub const KEY_braille_dots_123468 = 16787631;
pub const KEY_braille_dots_12347 = 16787535;
pub const KEY_braille_dots_123478 = 16787663;
pub const KEY_braille_dots_12348 = 16787599;
pub const KEY_braille_dots_1235 = 16787479;
pub const KEY_braille_dots_12356 = 16787511;
pub const KEY_braille_dots_123567 = 16787575;
pub const KEY_braille_dots_1235678 = 16787703;
pub const KEY_braille_dots_123568 = 16787639;
pub const KEY_braille_dots_12357 = 16787543;
pub const KEY_braille_dots_123578 = 16787671;
pub const KEY_braille_dots_12358 = 16787607;
pub const KEY_braille_dots_1236 = 16787495;
pub const KEY_braille_dots_12367 = 16787559;
pub const KEY_braille_dots_123678 = 16787687;
pub const KEY_braille_dots_12368 = 16787623;
pub const KEY_braille_dots_1237 = 16787527;
pub const KEY_braille_dots_12378 = 16787655;
pub const KEY_braille_dots_1238 = 16787591;
pub const KEY_braille_dots_124 = 16787467;
pub const KEY_braille_dots_1245 = 16787483;
pub const KEY_braille_dots_12456 = 16787515;
pub const KEY_braille_dots_124567 = 16787579;
pub const KEY_braille_dots_1245678 = 16787707;
pub const KEY_braille_dots_124568 = 16787643;
pub const KEY_braille_dots_12457 = 16787547;
pub const KEY_braille_dots_124578 = 16787675;
pub const KEY_braille_dots_12458 = 16787611;
pub const KEY_braille_dots_1246 = 16787499;
pub const KEY_braille_dots_12467 = 16787563;
pub const KEY_braille_dots_124678 = 16787691;
pub const KEY_braille_dots_12468 = 16787627;
pub const KEY_braille_dots_1247 = 16787531;
pub const KEY_braille_dots_12478 = 16787659;
pub const KEY_braille_dots_1248 = 16787595;
pub const KEY_braille_dots_125 = 16787475;
pub const KEY_braille_dots_1256 = 16787507;
pub const KEY_braille_dots_12567 = 16787571;
pub const KEY_braille_dots_125678 = 16787699;
pub const KEY_braille_dots_12568 = 16787635;
pub const KEY_braille_dots_1257 = 16787539;
pub const KEY_braille_dots_12578 = 16787667;
pub const KEY_braille_dots_1258 = 16787603;
pub const KEY_braille_dots_126 = 16787491;
pub const KEY_braille_dots_1267 = 16787555;
pub const KEY_braille_dots_12678 = 16787683;
pub const KEY_braille_dots_1268 = 16787619;
pub const KEY_braille_dots_127 = 16787523;
pub const KEY_braille_dots_1278 = 16787651;
pub const KEY_braille_dots_128 = 16787587;
pub const KEY_braille_dots_13 = 16787461;
pub const KEY_braille_dots_134 = 16787469;
pub const KEY_braille_dots_1345 = 16787485;
pub const KEY_braille_dots_13456 = 16787517;
pub const KEY_braille_dots_134567 = 16787581;
pub const KEY_braille_dots_1345678 = 16787709;
pub const KEY_braille_dots_134568 = 16787645;
pub const KEY_braille_dots_13457 = 16787549;
pub const KEY_braille_dots_134578 = 16787677;
pub const KEY_braille_dots_13458 = 16787613;
pub const KEY_braille_dots_1346 = 16787501;
pub const KEY_braille_dots_13467 = 16787565;
pub const KEY_braille_dots_134678 = 16787693;
pub const KEY_braille_dots_13468 = 16787629;
pub const KEY_braille_dots_1347 = 16787533;
pub const KEY_braille_dots_13478 = 16787661;
pub const KEY_braille_dots_1348 = 16787597;
pub const KEY_braille_dots_135 = 16787477;
pub const KEY_braille_dots_1356 = 16787509;
pub const KEY_braille_dots_13567 = 16787573;
pub const KEY_braille_dots_135678 = 16787701;
pub const KEY_braille_dots_13568 = 16787637;
pub const KEY_braille_dots_1357 = 16787541;
pub const KEY_braille_dots_13578 = 16787669;
pub const KEY_braille_dots_1358 = 16787605;
pub const KEY_braille_dots_136 = 16787493;
pub const KEY_braille_dots_1367 = 16787557;
pub const KEY_braille_dots_13678 = 16787685;
pub const KEY_braille_dots_1368 = 16787621;
pub const KEY_braille_dots_137 = 16787525;
pub const KEY_braille_dots_1378 = 16787653;
pub const KEY_braille_dots_138 = 16787589;
pub const KEY_braille_dots_14 = 16787465;
pub const KEY_braille_dots_145 = 16787481;
pub const KEY_braille_dots_1456 = 16787513;
pub const KEY_braille_dots_14567 = 16787577;
pub const KEY_braille_dots_145678 = 16787705;
pub const KEY_braille_dots_14568 = 16787641;
pub const KEY_braille_dots_1457 = 16787545;
pub const KEY_braille_dots_14578 = 16787673;
pub const KEY_braille_dots_1458 = 16787609;
pub const KEY_braille_dots_146 = 16787497;
pub const KEY_braille_dots_1467 = 16787561;
pub const KEY_braille_dots_14678 = 16787689;
pub const KEY_braille_dots_1468 = 16787625;
pub const KEY_braille_dots_147 = 16787529;
pub const KEY_braille_dots_1478 = 16787657;
pub const KEY_braille_dots_148 = 16787593;
pub const KEY_braille_dots_15 = 16787473;
pub const KEY_braille_dots_156 = 16787505;
pub const KEY_braille_dots_1567 = 16787569;
pub const KEY_braille_dots_15678 = 16787697;
pub const KEY_braille_dots_1568 = 16787633;
pub const KEY_braille_dots_157 = 16787537;
pub const KEY_braille_dots_1578 = 16787665;
pub const KEY_braille_dots_158 = 16787601;
pub const KEY_braille_dots_16 = 16787489;
pub const KEY_braille_dots_167 = 16787553;
pub const KEY_braille_dots_1678 = 16787681;
pub const KEY_braille_dots_168 = 16787617;
pub const KEY_braille_dots_17 = 16787521;
pub const KEY_braille_dots_178 = 16787649;
pub const KEY_braille_dots_18 = 16787585;
pub const KEY_braille_dots_2 = 16787458;
pub const KEY_braille_dots_23 = 16787462;
pub const KEY_braille_dots_234 = 16787470;
pub const KEY_braille_dots_2345 = 16787486;
pub const KEY_braille_dots_23456 = 16787518;
pub const KEY_braille_dots_234567 = 16787582;
pub const KEY_braille_dots_2345678 = 16787710;
pub const KEY_braille_dots_234568 = 16787646;
pub const KEY_braille_dots_23457 = 16787550;
pub const KEY_braille_dots_234578 = 16787678;
pub const KEY_braille_dots_23458 = 16787614;
pub const KEY_braille_dots_2346 = 16787502;
pub const KEY_braille_dots_23467 = 16787566;
pub const KEY_braille_dots_234678 = 16787694;
pub const KEY_braille_dots_23468 = 16787630;
pub const KEY_braille_dots_2347 = 16787534;
pub const KEY_braille_dots_23478 = 16787662;
pub const KEY_braille_dots_2348 = 16787598;
pub const KEY_braille_dots_235 = 16787478;
pub const KEY_braille_dots_2356 = 16787510;
pub const KEY_braille_dots_23567 = 16787574;
pub const KEY_braille_dots_235678 = 16787702;
pub const KEY_braille_dots_23568 = 16787638;
pub const KEY_braille_dots_2357 = 16787542;
pub const KEY_braille_dots_23578 = 16787670;
pub const KEY_braille_dots_2358 = 16787606;
pub const KEY_braille_dots_236 = 16787494;
pub const KEY_braille_dots_2367 = 16787558;
pub const KEY_braille_dots_23678 = 16787686;
pub const KEY_braille_dots_2368 = 16787622;
pub const KEY_braille_dots_237 = 16787526;
pub const KEY_braille_dots_2378 = 16787654;
pub const KEY_braille_dots_238 = 16787590;
pub const KEY_braille_dots_24 = 16787466;
pub const KEY_braille_dots_245 = 16787482;
pub const KEY_braille_dots_2456 = 16787514;
pub const KEY_braille_dots_24567 = 16787578;
pub const KEY_braille_dots_245678 = 16787706;
pub const KEY_braille_dots_24568 = 16787642;
pub const KEY_braille_dots_2457 = 16787546;
pub const KEY_braille_dots_24578 = 16787674;
pub const KEY_braille_dots_2458 = 16787610;
pub const KEY_braille_dots_246 = 16787498;
pub const KEY_braille_dots_2467 = 16787562;
pub const KEY_braille_dots_24678 = 16787690;
pub const KEY_braille_dots_2468 = 16787626;
pub const KEY_braille_dots_247 = 16787530;
pub const KEY_braille_dots_2478 = 16787658;
pub const KEY_braille_dots_248 = 16787594;
pub const KEY_braille_dots_25 = 16787474;
pub const KEY_braille_dots_256 = 16787506;
pub const KEY_braille_dots_2567 = 16787570;
pub const KEY_braille_dots_25678 = 16787698;
pub const KEY_braille_dots_2568 = 16787634;
pub const KEY_braille_dots_257 = 16787538;
pub const KEY_braille_dots_2578 = 16787666;
pub const KEY_braille_dots_258 = 16787602;
pub const KEY_braille_dots_26 = 16787490;
pub const KEY_braille_dots_267 = 16787554;
pub const KEY_braille_dots_2678 = 16787682;
pub const KEY_braille_dots_268 = 16787618;
pub const KEY_braille_dots_27 = 16787522;
pub const KEY_braille_dots_278 = 16787650;
pub const KEY_braille_dots_28 = 16787586;
pub const KEY_braille_dots_3 = 16787460;
pub const KEY_braille_dots_34 = 16787468;
pub const KEY_braille_dots_345 = 16787484;
pub const KEY_braille_dots_3456 = 16787516;
pub const KEY_braille_dots_34567 = 16787580;
pub const KEY_braille_dots_345678 = 16787708;
pub const KEY_braille_dots_34568 = 16787644;
pub const KEY_braille_dots_3457 = 16787548;
pub const KEY_braille_dots_34578 = 16787676;
pub const KEY_braille_dots_3458 = 16787612;
pub const KEY_braille_dots_346 = 16787500;
pub const KEY_braille_dots_3467 = 16787564;
pub const KEY_braille_dots_34678 = 16787692;
pub const KEY_braille_dots_3468 = 16787628;
pub const KEY_braille_dots_347 = 16787532;
pub const KEY_braille_dots_3478 = 16787660;
pub const KEY_braille_dots_348 = 16787596;
pub const KEY_braille_dots_35 = 16787476;
pub const KEY_braille_dots_356 = 16787508;
pub const KEY_braille_dots_3567 = 16787572;
pub const KEY_braille_dots_35678 = 16787700;
pub const KEY_braille_dots_3568 = 16787636;
pub const KEY_braille_dots_357 = 16787540;
pub const KEY_braille_dots_3578 = 16787668;
pub const KEY_braille_dots_358 = 16787604;
pub const KEY_braille_dots_36 = 16787492;
pub const KEY_braille_dots_367 = 16787556;
pub const KEY_braille_dots_3678 = 16787684;
pub const KEY_braille_dots_368 = 16787620;
pub const KEY_braille_dots_37 = 16787524;
pub const KEY_braille_dots_378 = 16787652;
pub const KEY_braille_dots_38 = 16787588;
pub const KEY_braille_dots_4 = 16787464;
pub const KEY_braille_dots_45 = 16787480;
pub const KEY_braille_dots_456 = 16787512;
pub const KEY_braille_dots_4567 = 16787576;
pub const KEY_braille_dots_45678 = 16787704;
pub const KEY_braille_dots_4568 = 16787640;
pub const KEY_braille_dots_457 = 16787544;
pub const KEY_braille_dots_4578 = 16787672;
pub const KEY_braille_dots_458 = 16787608;
pub const KEY_braille_dots_46 = 16787496;
pub const KEY_braille_dots_467 = 16787560;
pub const KEY_braille_dots_4678 = 16787688;
pub const KEY_braille_dots_468 = 16787624;
pub const KEY_braille_dots_47 = 16787528;
pub const KEY_braille_dots_478 = 16787656;
pub const KEY_braille_dots_48 = 16787592;
pub const KEY_braille_dots_5 = 16787472;
pub const KEY_braille_dots_56 = 16787504;
pub const KEY_braille_dots_567 = 16787568;
pub const KEY_braille_dots_5678 = 16787696;
pub const KEY_braille_dots_568 = 16787632;
pub const KEY_braille_dots_57 = 16787536;
pub const KEY_braille_dots_578 = 16787664;
pub const KEY_braille_dots_58 = 16787600;
pub const KEY_braille_dots_6 = 16787488;
pub const KEY_braille_dots_67 = 16787552;
pub const KEY_braille_dots_678 = 16787680;
pub const KEY_braille_dots_68 = 16787616;
pub const KEY_braille_dots_7 = 16787520;
pub const KEY_braille_dots_78 = 16787648;
pub const KEY_braille_dots_8 = 16787584;
pub const KEY_breve = 418;
pub const KEY_brokenbar = 166;
pub const KEY_c = 99;
pub const KEY_c_h = 65187;
pub const KEY_cabovedot = 741;
pub const KEY_cacute = 486;
pub const KEY_careof = 2744;
pub const KEY_caret = 2812;
pub const KEY_caron = 439;
pub const KEY_ccaron = 488;
pub const KEY_ccedilla = 231;
pub const KEY_ccircumflex = 742;
pub const KEY_cedilla = 184;
pub const KEY_cent = 162;
pub const KEY_ch = 65184;
pub const KEY_checkerboard = 2529;
pub const KEY_checkmark = 2803;
pub const KEY_circle = 3023;
pub const KEY_club = 2796;
pub const KEY_colon = 58;
pub const KEY_combining_acute = 16777985;
pub const KEY_combining_belowdot = 16778019;
pub const KEY_combining_grave = 16777984;
pub const KEY_combining_hook = 16777993;
pub const KEY_combining_tilde = 16777987;
pub const KEY_comma = 44;
pub const KEY_containsas = 16785931;
pub const KEY_copyright = 169;
pub const KEY_cr = 2532;
pub const KEY_crossinglines = 2542;
pub const KEY_cuberoot = 16785947;
pub const KEY_currency = 164;
pub const KEY_cursor = 2815;
pub const KEY_d = 100;
pub const KEY_dabovedot = 16784907;
pub const KEY_dagger = 2801;
pub const KEY_dcaron = 495;
pub const KEY_dead_A = 65153;
pub const KEY_dead_E = 65155;
pub const KEY_dead_I = 65157;
pub const KEY_dead_O = 65159;
pub const KEY_dead_SCHWA = 65163;
pub const KEY_dead_U = 65161;
pub const KEY_dead_a = 65152;
pub const KEY_dead_abovecomma = 65124;
pub const KEY_dead_abovedot = 65110;
pub const KEY_dead_abovereversedcomma = 65125;
pub const KEY_dead_abovering = 65112;
pub const KEY_dead_aboveverticalline = 65169;
pub const KEY_dead_acute = 65105;
pub const KEY_dead_belowbreve = 65131;
pub const KEY_dead_belowcircumflex = 65129;
pub const KEY_dead_belowcomma = 65134;
pub const KEY_dead_belowdiaeresis = 65132;
pub const KEY_dead_belowdot = 65120;
pub const KEY_dead_belowmacron = 65128;
pub const KEY_dead_belowring = 65127;
pub const KEY_dead_belowtilde = 65130;
pub const KEY_dead_belowverticalline = 65170;
pub const KEY_dead_breve = 65109;
pub const KEY_dead_capital_schwa = 65163;
pub const KEY_dead_caron = 65114;
pub const KEY_dead_cedilla = 65115;
pub const KEY_dead_circumflex = 65106;
pub const KEY_dead_currency = 65135;
pub const KEY_dead_dasia = 65125;
pub const KEY_dead_diaeresis = 65111;
pub const KEY_dead_doubleacute = 65113;
pub const KEY_dead_doublegrave = 65126;
pub const KEY_dead_e = 65154;
pub const KEY_dead_grave = 65104;
pub const KEY_dead_greek = 65164;
pub const KEY_dead_hamza = 65165;
pub const KEY_dead_hook = 65121;
pub const KEY_dead_horn = 65122;
pub const KEY_dead_i = 65156;
pub const KEY_dead_invertedbreve = 65133;
pub const KEY_dead_iota = 65117;
pub const KEY_dead_longsolidusoverlay = 65171;
pub const KEY_dead_lowline = 65168;
pub const KEY_dead_macron = 65108;
pub const KEY_dead_o = 65158;
pub const KEY_dead_ogonek = 65116;
pub const KEY_dead_perispomeni = 65107;
pub const KEY_dead_psili = 65124;
pub const KEY_dead_schwa = 65162;
pub const KEY_dead_semivoiced_sound = 65119;
pub const KEY_dead_small_schwa = 65162;
pub const KEY_dead_stroke = 65123;
pub const KEY_dead_tilde = 65107;
pub const KEY_dead_u = 65160;
pub const KEY_dead_voiced_sound = 65118;
pub const KEY_decimalpoint = 2749;
pub const KEY_degree = 176;
pub const KEY_diaeresis = 168;
pub const KEY_diamond = 2797;
pub const KEY_digitspace = 2725;
pub const KEY_dintegral = 16785964;
pub const KEY_division = 247;
pub const KEY_dollar = 36;
pub const KEY_doubbaselinedot = 2735;
pub const KEY_doubleacute = 445;
pub const KEY_doubledagger = 2802;
pub const KEY_doublelowquotemark = 2814;
pub const KEY_downarrow = 2302;
pub const KEY_downcaret = 2984;
pub const KEY_downshoe = 3030;
pub const KEY_downstile = 3012;
pub const KEY_downtack = 3010;
pub const KEY_dstroke = 496;
pub const KEY_e = 101;
pub const KEY_eabovedot = 1004;
pub const KEY_eacute = 233;
pub const KEY_ebelowdot = 16785081;
pub const KEY_ecaron = 492;
pub const KEY_ecircumflex = 234;
pub const KEY_ecircumflexacute = 16785087;
pub const KEY_ecircumflexbelowdot = 16785095;
pub const KEY_ecircumflexgrave = 16785089;
pub const KEY_ecircumflexhook = 16785091;
pub const KEY_ecircumflextilde = 16785093;
pub const KEY_ediaeresis = 235;
pub const KEY_egrave = 232;
pub const KEY_ehook = 16785083;
pub const KEY_eightsubscript = 16785544;
pub const KEY_eightsuperior = 16785528;
pub const KEY_elementof = 16785928;
pub const KEY_ellipsis = 2734;
pub const KEY_em3space = 2723;
pub const KEY_em4space = 2724;
pub const KEY_emacron = 954;
pub const KEY_emdash = 2729;
pub const KEY_emfilledcircle = 2782;
pub const KEY_emfilledrect = 2783;
pub const KEY_emopencircle = 2766;
pub const KEY_emopenrectangle = 2767;
pub const KEY_emptyset = 16785925;
pub const KEY_emspace = 2721;
pub const KEY_endash = 2730;
pub const KEY_enfilledcircbullet = 2790;
pub const KEY_enfilledsqbullet = 2791;
pub const KEY_eng = 959;
pub const KEY_enopencircbullet = 2784;
pub const KEY_enopensquarebullet = 2785;
pub const KEY_enspace = 2722;
pub const KEY_eogonek = 490;
pub const KEY_equal = 61;
pub const KEY_eth = 240;
pub const KEY_etilde = 16785085;
pub const KEY_exclam = 33;
pub const KEY_exclamdown = 161;
pub const KEY_ezh = 16777874;
pub const KEY_f = 102;
pub const KEY_fabovedot = 16784927;
pub const KEY_femalesymbol = 2808;
pub const KEY_ff = 2531;
pub const KEY_figdash = 2747;
pub const KEY_filledlefttribullet = 2780;
pub const KEY_filledrectbullet = 2779;
pub const KEY_filledrighttribullet = 2781;
pub const KEY_filledtribulletdown = 2793;
pub const KEY_filledtribulletup = 2792;
pub const KEY_fiveeighths = 2757;
pub const KEY_fivesixths = 2743;
pub const KEY_fivesubscript = 16785541;
pub const KEY_fivesuperior = 16785525;
pub const KEY_fourfifths = 2741;
pub const KEY_foursubscript = 16785540;
pub const KEY_foursuperior = 16785524;
pub const KEY_fourthroot = 16785948;
pub const KEY_function = 2294;
pub const KEY_g = 103;
pub const KEY_gabovedot = 757;
pub const KEY_gbreve = 699;
pub const KEY_gcaron = 16777703;
pub const KEY_gcedilla = 955;
pub const KEY_gcircumflex = 760;
pub const KEY_grave = 96;
pub const KEY_greater = 62;
pub const KEY_greaterthanequal = 2238;
pub const KEY_guillemetleft = 171;
pub const KEY_guillemetright = 187;
pub const KEY_guillemotleft = 171;
pub const KEY_guillemotright = 187;
pub const KEY_h = 104;
pub const KEY_hairspace = 2728;
pub const KEY_hcircumflex = 694;
pub const KEY_heart = 2798;
pub const KEY_hebrew_aleph = 3296;
pub const KEY_hebrew_ayin = 3314;
pub const KEY_hebrew_bet = 3297;
pub const KEY_hebrew_beth = 3297;
pub const KEY_hebrew_chet = 3303;
pub const KEY_hebrew_dalet = 3299;
pub const KEY_hebrew_daleth = 3299;
pub const KEY_hebrew_doublelowline = 3295;
pub const KEY_hebrew_finalkaph = 3306;
pub const KEY_hebrew_finalmem = 3309;
pub const KEY_hebrew_finalnun = 3311;
pub const KEY_hebrew_finalpe = 3315;
pub const KEY_hebrew_finalzade = 3317;
pub const KEY_hebrew_finalzadi = 3317;
pub const KEY_hebrew_gimel = 3298;
pub const KEY_hebrew_gimmel = 3298;
pub const KEY_hebrew_he = 3300;
pub const KEY_hebrew_het = 3303;
pub const KEY_hebrew_kaph = 3307;
pub const KEY_hebrew_kuf = 3319;
pub const KEY_hebrew_lamed = 3308;
pub const KEY_hebrew_mem = 3310;
pub const KEY_hebrew_nun = 3312;
pub const KEY_hebrew_pe = 3316;
pub const KEY_hebrew_qoph = 3319;
pub const KEY_hebrew_resh = 3320;
pub const KEY_hebrew_samech = 3313;
pub const KEY_hebrew_samekh = 3313;
pub const KEY_hebrew_shin = 3321;
pub const KEY_hebrew_taf = 3322;
pub const KEY_hebrew_taw = 3322;
pub const KEY_hebrew_tet = 3304;
pub const KEY_hebrew_teth = 3304;
pub const KEY_hebrew_waw = 3301;
pub const KEY_hebrew_yod = 3305;
pub const KEY_hebrew_zade = 3318;
pub const KEY_hebrew_zadi = 3318;
pub const KEY_hebrew_zain = 3302;
pub const KEY_hebrew_zayin = 3302;
pub const KEY_hexagram = 2778;
pub const KEY_horizconnector = 2211;
pub const KEY_horizlinescan1 = 2543;
pub const KEY_horizlinescan3 = 2544;
pub const KEY_horizlinescan5 = 2545;
pub const KEY_horizlinescan7 = 2546;
pub const KEY_horizlinescan9 = 2547;
pub const KEY_hstroke = 689;
pub const KEY_ht = 2530;
pub const KEY_hyphen = 173;
pub const KEY_i = 105;
pub const KEY_iTouch = 269025120;
pub const KEY_iacute = 237;
pub const KEY_ibelowdot = 16785099;
pub const KEY_ibreve = 16777517;
pub const KEY_icircumflex = 238;
pub const KEY_identical = 2255;
pub const KEY_idiaeresis = 239;
pub const KEY_idotless = 697;
pub const KEY_ifonlyif = 2253;
pub const KEY_igrave = 236;
pub const KEY_ihook = 16785097;
pub const KEY_imacron = 1007;
pub const KEY_implies = 2254;
pub const KEY_includedin = 2266;
pub const KEY_includes = 2267;
pub const KEY_infinity = 2242;
pub const KEY_integral = 2239;
pub const KEY_intersection = 2268;
pub const KEY_iogonek = 999;
pub const KEY_itilde = 949;
pub const KEY_j = 106;
pub const KEY_jcircumflex = 700;
pub const KEY_jot = 3018;
pub const KEY_k = 107;
pub const KEY_kana_A = 1201;
pub const KEY_kana_CHI = 1217;
pub const KEY_kana_E = 1204;
pub const KEY_kana_FU = 1228;
pub const KEY_kana_HA = 1226;
pub const KEY_kana_HE = 1229;
pub const KEY_kana_HI = 1227;
pub const KEY_kana_HO = 1230;
pub const KEY_kana_HU = 1228;
pub const KEY_kana_I = 1202;
pub const KEY_kana_KA = 1206;
pub const KEY_kana_KE = 1209;
pub const KEY_kana_KI = 1207;
pub const KEY_kana_KO = 1210;
pub const KEY_kana_KU = 1208;
pub const KEY_kana_MA = 1231;
pub const KEY_kana_ME = 1234;
pub const KEY_kana_MI = 1232;
pub const KEY_kana_MO = 1235;
pub const KEY_kana_MU = 1233;
pub const KEY_kana_N = 1245;
pub const KEY_kana_NA = 1221;
pub const KEY_kana_NE = 1224;
pub const KEY_kana_NI = 1222;
pub const KEY_kana_NO = 1225;
pub const KEY_kana_NU = 1223;
pub const KEY_kana_O = 1205;
pub const KEY_kana_RA = 1239;
pub const KEY_kana_RE = 1242;
pub const KEY_kana_RI = 1240;
pub const KEY_kana_RO = 1243;
pub const KEY_kana_RU = 1241;
pub const KEY_kana_SA = 1211;
pub const KEY_kana_SE = 1214;
pub const KEY_kana_SHI = 1212;
pub const KEY_kana_SO = 1215;
pub const KEY_kana_SU = 1213;
pub const KEY_kana_TA = 1216;
pub const KEY_kana_TE = 1219;
pub const KEY_kana_TI = 1217;
pub const KEY_kana_TO = 1220;
pub const KEY_kana_TSU = 1218;
pub const KEY_kana_TU = 1218;
pub const KEY_kana_U = 1203;
pub const KEY_kana_WA = 1244;
pub const KEY_kana_WO = 1190;
pub const KEY_kana_YA = 1236;
pub const KEY_kana_YO = 1238;
pub const KEY_kana_YU = 1237;
pub const KEY_kana_a = 1191;
pub const KEY_kana_closingbracket = 1187;
pub const KEY_kana_comma = 1188;
pub const KEY_kana_conjunctive = 1189;
pub const KEY_kana_e = 1194;
pub const KEY_kana_fullstop = 1185;
pub const KEY_kana_i = 1192;
pub const KEY_kana_middledot = 1189;
pub const KEY_kana_o = 1195;
pub const KEY_kana_openingbracket = 1186;
pub const KEY_kana_switch = 65406;
pub const KEY_kana_tsu = 1199;
pub const KEY_kana_tu = 1199;
pub const KEY_kana_u = 1193;
pub const KEY_kana_ya = 1196;
pub const KEY_kana_yo = 1198;
pub const KEY_kana_yu = 1197;
pub const KEY_kappa = 930;
pub const KEY_kcedilla = 1011;
pub const KEY_kra = 930;
pub const KEY_l = 108;
pub const KEY_lacute = 485;
pub const KEY_latincross = 2777;
pub const KEY_lbelowdot = 16784951;
pub const KEY_lcaron = 437;
pub const KEY_lcedilla = 950;
pub const KEY_leftanglebracket = 2748;
pub const KEY_leftarrow = 2299;
pub const KEY_leftcaret = 2979;
pub const KEY_leftdoublequotemark = 2770;
pub const KEY_leftmiddlecurlybrace = 2223;
pub const KEY_leftopentriangle = 2764;
pub const KEY_leftpointer = 2794;
pub const KEY_leftradical = 2209;
pub const KEY_leftshoe = 3034;
pub const KEY_leftsinglequotemark = 2768;
pub const KEY_leftt = 2548;
pub const KEY_lefttack = 3036;
pub const KEY_less = 60;
pub const KEY_lessthanequal = 2236;
pub const KEY_lf = 2533;
pub const KEY_logicaland = 2270;
pub const KEY_logicalor = 2271;
pub const KEY_lowleftcorner = 2541;
pub const KEY_lowrightcorner = 2538;
pub const KEY_lstroke = 435;
pub const KEY_m = 109;
pub const KEY_mabovedot = 16784961;
pub const KEY_macron = 175;
pub const KEY_malesymbol = 2807;
pub const KEY_maltesecross = 2800;
pub const KEY_marker = 2751;
pub const KEY_masculine = 186;
pub const KEY_minus = 45;
pub const KEY_minutes = 2774;
pub const KEY_mu = 181;
pub const KEY_multiply = 215;
pub const KEY_musicalflat = 2806;
pub const KEY_musicalsharp = 2805;
pub const KEY_n = 110;
pub const KEY_nabla = 2245;
pub const KEY_nacute = 497;
pub const KEY_ncaron = 498;
pub const KEY_ncedilla = 1009;
pub const KEY_ninesubscript = 16785545;
pub const KEY_ninesuperior = 16785529;
pub const KEY_nl = 2536;
pub const KEY_nobreakspace = 160;
pub const KEY_notapproxeq = 16785991;
pub const KEY_notelementof = 16785929;
pub const KEY_notequal = 2237;
pub const KEY_notidentical = 16786018;
pub const KEY_notsign = 172;
pub const KEY_ntilde = 241;
pub const KEY_numbersign = 35;
pub const KEY_numerosign = 1712;
pub const KEY_o = 111;
pub const KEY_oacute = 243;
pub const KEY_obarred = 16777845;
pub const KEY_obelowdot = 16785101;
pub const KEY_ocaron = 16777682;
pub const KEY_ocircumflex = 244;
pub const KEY_ocircumflexacute = 16785105;
pub const KEY_ocircumflexbelowdot = 16785113;
pub const KEY_ocircumflexgrave = 16785107;
pub const KEY_ocircumflexhook = 16785109;
pub const KEY_ocircumflextilde = 16785111;
pub const KEY_odiaeresis = 246;
pub const KEY_odoubleacute = 501;
pub const KEY_oe = 5053;
pub const KEY_ogonek = 434;
pub const KEY_ograve = 242;
pub const KEY_ohook = 16785103;
pub const KEY_ohorn = 16777633;
pub const KEY_ohornacute = 16785115;
pub const KEY_ohornbelowdot = 16785123;
pub const KEY_ohorngrave = 16785117;
pub const KEY_ohornhook = 16785119;
pub const KEY_ohorntilde = 16785121;
pub const KEY_omacron = 1010;
pub const KEY_oneeighth = 2755;
pub const KEY_onefifth = 2738;
pub const KEY_onehalf = 189;
pub const KEY_onequarter = 188;
pub const KEY_onesixth = 2742;
pub const KEY_onesubscript = 16785537;
pub const KEY_onesuperior = 185;
pub const KEY_onethird = 2736;
pub const KEY_ooblique = 248;
pub const KEY_openrectbullet = 2786;
pub const KEY_openstar = 2789;
pub const KEY_opentribulletdown = 2788;
pub const KEY_opentribulletup = 2787;
pub const KEY_ordfeminine = 170;
pub const KEY_ordmasculine = 186;
pub const KEY_oslash = 248;
pub const KEY_otilde = 245;
pub const KEY_overbar = 3008;
pub const KEY_overline = 1150;
pub const KEY_p = 112;
pub const KEY_pabovedot = 16784983;
pub const KEY_paragraph = 182;
pub const KEY_parenleft = 40;
pub const KEY_parenright = 41;
pub const KEY_partdifferential = 16785922;
pub const KEY_partialderivative = 2287;
pub const KEY_percent = 37;
pub const KEY_period = 46;
pub const KEY_periodcentered = 183;
pub const KEY_permille = 2773;
pub const KEY_phonographcopyright = 2811;
pub const KEY_plus = 43;
pub const KEY_plusminus = 177;
pub const KEY_prescription = 2772;
pub const KEY_prolongedsound = 1200;
pub const KEY_punctspace = 2726;
pub const KEY_q = 113;
pub const KEY_quad = 3020;
pub const KEY_question = 63;
pub const KEY_questiondown = 191;
pub const KEY_quotedbl = 34;
pub const KEY_quoteleft = 96;
pub const KEY_quoteright = 39;
pub const KEY_r = 114;
pub const KEY_racute = 480;
pub const KEY_radical = 2262;
pub const KEY_rcaron = 504;
pub const KEY_rcedilla = 947;
pub const KEY_registered = 174;
pub const KEY_rightanglebracket = 2750;
pub const KEY_rightarrow = 2301;
pub const KEY_rightcaret = 2982;
pub const KEY_rightdoublequotemark = 2771;
pub const KEY_rightmiddlecurlybrace = 2224;
pub const KEY_rightmiddlesummation = 2231;
pub const KEY_rightopentriangle = 2765;
pub const KEY_rightpointer = 2795;
pub const KEY_rightshoe = 3032;
pub const KEY_rightsinglequotemark = 2769;
pub const KEY_rightt = 2549;
pub const KEY_righttack = 3068;
pub const KEY_s = 115;
pub const KEY_sabovedot = 16784993;
pub const KEY_sacute = 438;
pub const KEY_scaron = 441;
pub const KEY_scedilla = 442;
pub const KEY_schwa = 16777817;
pub const KEY_scircumflex = 766;
pub const KEY_script_switch = 65406;
pub const KEY_seconds = 2775;
pub const KEY_section = 167;
pub const KEY_semicolon = 59;
pub const KEY_semivoicedsound = 1247;
pub const KEY_seveneighths = 2758;
pub const KEY_sevensubscript = 16785543;
pub const KEY_sevensuperior = 16785527;
pub const KEY_signaturemark = 2762;
pub const KEY_signifblank = 2732;
pub const KEY_similarequal = 2249;
pub const KEY_singlelowquotemark = 2813;
pub const KEY_sixsubscript = 16785542;
pub const KEY_sixsuperior = 16785526;
pub const KEY_slash = 47;
pub const KEY_soliddiamond = 2528;
pub const KEY_space = 32;
pub const KEY_squareroot = 16785946;
pub const KEY_ssharp = 223;
pub const KEY_sterling = 163;
pub const KEY_stricteq = 16786019;
pub const KEY_t = 116;
pub const KEY_tabovedot = 16785003;
pub const KEY_tcaron = 443;
pub const KEY_tcedilla = 510;
pub const KEY_telephone = 2809;
pub const KEY_telephonerecorder = 2810;
pub const KEY_therefore = 2240;
pub const KEY_thinspace = 2727;
pub const KEY_thorn = 254;
pub const KEY_threeeighths = 2756;
pub const KEY_threefifths = 2740;
pub const KEY_threequarters = 190;
pub const KEY_threesubscript = 16785539;
pub const KEY_threesuperior = 179;
pub const KEY_tintegral = 16785965;
pub const KEY_topintegral = 2212;
pub const KEY_topleftparens = 2219;
pub const KEY_topleftradical = 2210;
pub const KEY_topleftsqbracket = 2215;
pub const KEY_topleftsummation = 2225;
pub const KEY_toprightparens = 2221;
pub const KEY_toprightsqbracket = 2217;
pub const KEY_toprightsummation = 2229;
pub const KEY_topt = 2551;
pub const KEY_topvertsummationconnector = 2227;
pub const KEY_trademark = 2761;
pub const KEY_trademarkincircle = 2763;
pub const KEY_tslash = 956;
pub const KEY_twofifths = 2739;
pub const KEY_twosubscript = 16785538;
pub const KEY_twosuperior = 178;
pub const KEY_twothirds = 2737;
pub const KEY_u = 117;
pub const KEY_uacute = 250;
pub const KEY_ubelowdot = 16785125;
pub const KEY_ubreve = 765;
pub const KEY_ucircumflex = 251;
pub const KEY_udiaeresis = 252;
pub const KEY_udoubleacute = 507;
pub const KEY_ugrave = 249;
pub const KEY_uhook = 16785127;
pub const KEY_uhorn = 16777648;
pub const KEY_uhornacute = 16785129;
pub const KEY_uhornbelowdot = 16785137;
pub const KEY_uhorngrave = 16785131;
pub const KEY_uhornhook = 16785133;
pub const KEY_uhorntilde = 16785135;
pub const KEY_umacron = 1022;
pub const KEY_underbar = 3014;
pub const KEY_underscore = 95;
pub const KEY_union = 2269;
pub const KEY_uogonek = 1017;
pub const KEY_uparrow = 2300;
pub const KEY_upcaret = 2985;
pub const KEY_upleftcorner = 2540;
pub const KEY_uprightcorner = 2539;
pub const KEY_upshoe = 3011;
pub const KEY_upstile = 3027;
pub const KEY_uptack = 3022;
pub const KEY_uring = 505;
pub const KEY_utilde = 1021;
pub const KEY_v = 118;
pub const KEY_variation = 2241;
pub const KEY_vertbar = 2552;
pub const KEY_vertconnector = 2214;
pub const KEY_voicedsound = 1246;
pub const KEY_vt = 2537;
pub const KEY_w = 119;
pub const KEY_wacute = 16785027;
pub const KEY_wcircumflex = 16777589;
pub const KEY_wdiaeresis = 16785029;
pub const KEY_wgrave = 16785025;
pub const KEY_x = 120;
pub const KEY_xabovedot = 16785035;
pub const KEY_y = 121;
pub const KEY_yacute = 253;
pub const KEY_ybelowdot = 16785141;
pub const KEY_ycircumflex = 16777591;
pub const KEY_ydiaeresis = 255;
pub const KEY_yen = 165;
pub const KEY_ygrave = 16785139;
pub const KEY_yhook = 16785143;
pub const KEY_ytilde = 16785145;
pub const KEY_z = 122;
pub const KEY_zabovedot = 447;
pub const KEY_zacute = 444;
pub const KEY_zcaron = 446;
pub const KEY_zerosubscript = 16785536;
pub const KEY_zerosuperior = 16785520;
pub const KEY_zstroke = 16777654;
/// A mask covering all entries in `GdkModifierType`.
pub const MODIFIER_MASK = 469769999;
/// This is the priority that the idle handler processing surface updates
/// is given in the main loop.
pub const PRIORITY_REDRAW = 120;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
