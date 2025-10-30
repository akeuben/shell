pub const ext = @import("ext.zig");
const edataserverui = @This();

const std = @import("std");
const compat = @import("compat");
const soup = @import("soup3");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
const gtk = @import("gtk3");
const xlib = @import("xlib2");
const gdk = @import("gdk3");
const cairo = @import("cairo1");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gdkpixbuf = @import("gdkpixbuf2");
const atk = @import("atk1");
const edataserver = @import("edataserver1");
const libxml2 = @import("libxml22");
const json = @import("json1");
const camel = @import("camel1");
const ecal = @import("ecal2");
const icalglib = @import("icalglib3");
pub const CellRendererColor = extern struct {
    pub const Parent = gtk.CellRenderer;
    pub const Implements = [_]type{};
    pub const Class = edataserverui.CellRendererColorClass;
    f_parent: gtk.CellRenderer,
    f_priv: ?*edataserverui.CellRendererColorPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const rgba = struct {
            pub const name = "rgba";

            pub const Type = ?*gdk.RGBA;
        };
    };

    pub const signals = struct {};

    extern fn e_cell_renderer_color_new() *edataserverui.CellRendererColor;
    pub const new = e_cell_renderer_color_new;

    extern fn e_cell_renderer_color_get_type() usize;
    pub const getGObjectType = e_cell_renderer_color_get_type;

    extern fn g_object_ref(p_self: *edataserverui.CellRendererColor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.CellRendererColor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CellRendererColor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CertificateWidget = extern struct {
    pub const Parent = gtk.ScrolledWindow;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = edataserverui.CertificateWidgetClass;
    f_parent: gtk.ScrolledWindow,
    f_priv: ?*edataserverui.CertificateWidgetPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `edataserverui.CertificateWidget`
    extern fn e_certificate_widget_new() *edataserverui.CertificateWidget;
    pub const new = e_certificate_widget_new;

    /// Updates the content of the `self` with the certificate information
    /// described by the `der_data` of the length `der_data_len` in the DER
    /// format.
    ///
    /// The content of the `self` is cleared when the `der_data` is `NULL`.
    extern fn e_certificate_widget_set_der(p_self: *CertificateWidget, p_der_data: ?*const anyopaque, p_der_data_len: c_uint) void;
    pub const setDer = e_certificate_widget_set_der;

    /// Updates the content of the `self` with the certificate information
    /// described by the `pem_data` in the PEM format.
    ///
    /// The content of the `self` is cleared when the `pem_data` is `NULL`.
    extern fn e_certificate_widget_set_pem(p_self: *CertificateWidget, p_pem_data: ?[*:0]const u8) void;
    pub const setPem = e_certificate_widget_set_pem;

    extern fn e_certificate_widget_get_type() usize;
    pub const getGObjectType = e_certificate_widget_get_type;

    extern fn g_object_ref(p_self: *edataserverui.CertificateWidget) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.CertificateWidget) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CertificateWidget, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CredentialsPrompter = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{edataserver.Extensible};
    pub const Class = edataserverui.CredentialsPrompterClass;
    f_parent: gobject.Object,
    f_priv: ?*edataserverui.CredentialsPrompterPrivate,

    pub const virtual_methods = struct {
        /// Returns a `gtk.Window`, which should be used as a dialog parent. This is determined
        /// by an ECredentialsPrompter::get-dialog-parent signal emission. If there is no callback
        /// registered or the current callbacks don't have any suitable window, then there's
        /// chosen the last active window from the default GApplication, if any available.
        pub const get_dialog_parent = struct {
            pub fn call(p_class: anytype, p_prompter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*gtk.Window {
                return gobject.ext.as(CredentialsPrompter.Class, p_class).f_get_dialog_parent.?(gobject.ext.as(CredentialsPrompter, p_prompter));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_prompter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*gtk.Window) void {
                gobject.ext.as(CredentialsPrompter.Class, p_class).f_get_dialog_parent = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Whether the `edataserverui.CredentialsPrompter` can response to credential
        /// requests automatically.
        pub const auto_prompt = struct {
            pub const name = "auto-prompt";

            pub const Type = c_int;
        };

        /// The `edataserver.SourceCredentialsProvider` object, which the prompter uses.
        pub const provider = struct {
            pub const name = "provider";

            pub const Type = ?*edataserver.SourceCredentialsProvider;
        };

        /// The `edataserver.SourceRegistry` object, to whose credential requests the prompter listens.
        pub const registry = struct {
            pub const name = "registry";

            pub const Type = ?*edataserver.SourceRegistry;
        };
    };

    pub const signals = struct {
        /// Emitted when a new dialog will be shown, to get the right parent
        /// window for it. If the result of the call is `NULL`, then it tries
        /// to get the window from the default GtkApplication.
        pub const get_dialog_parent = struct {
            pub const name = "get-dialog-parent";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) ?*gtk.Window, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CredentialsPrompter, p_instance))),
                    gobject.signalLookup("get-dialog-parent", CredentialsPrompter.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a new dialog will be shown, to get the right parent
        /// window for it. If the result of the call is `NULL`, then it tries
        /// to get the window from the default GtkApplication.
        pub const get_dialog_parent_full = struct {
            pub const name = "get-dialog-parent-full";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_auth_source: ?*edataserver.Source, P_Data) callconv(.c) ?*gtk.Window, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CredentialsPrompter, p_instance))),
                    gobject.signalLookup("get-dialog-parent-full", CredentialsPrompter.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `edataserverui.CredentialsPrompter`, which listens for credential requests
    /// from `registry`.
    extern fn e_credentials_prompter_new(p_registry: *edataserver.SourceRegistry) *edataserverui.CredentialsPrompter;
    pub const new = e_credentials_prompter_new;

    /// Returns, whether can respond to credential prompts automatically.
    /// Default value is `TRUE`.
    ///
    /// This property does not influence direct calls of `edataserverui.CredentialsPrompter.prompt`.
    extern fn e_credentials_prompter_get_auto_prompt(p_prompter: *CredentialsPrompter) c_int;
    pub const getAutoPrompt = e_credentials_prompter_get_auto_prompt;

    /// Returns whether the auto-prompt is disabled for the given `source`.
    /// All sources can be auto-prompted by default. This is a complementary
    /// value for the ECredentialsPrompter::auto-prompt property.
    ///
    /// This value does not influence direct calls of `edataserverui.CredentialsPrompter.prompt`.
    extern fn e_credentials_prompter_get_auto_prompt_disabled_for(p_prompter: *CredentialsPrompter, p_source: *edataserver.Source) c_int;
    pub const getAutoPromptDisabledFor = e_credentials_prompter_get_auto_prompt_disabled_for;

    /// Returns a `gtk.Window`, which should be used as a dialog parent. This is determined
    /// by an ECredentialsPrompter::get-dialog-parent signal emission. If there is no callback
    /// registered or the current callbacks don't have any suitable window, then there's
    /// chosen the last active window from the default GApplication, if any available.
    extern fn e_credentials_prompter_get_dialog_parent(p_prompter: *CredentialsPrompter) ?*gtk.Window;
    pub const getDialogParent = e_credentials_prompter_get_dialog_parent;

    /// Returns a `gtk.Window`, which should be used as a dialog parent for the `auth_source`.
    ///
    /// This is determined by an ECredentialsPrompter::get-dialog-parent-full signal emission
    /// and an ECredentialsPrompter::get-dialog-parent when the first doesn't return anything.
    /// If there is no callback registered or the current callbacks don't have any suitable
    /// window, then there's chosen the last active window from the default GApplication,
    /// if any available.
    extern fn e_credentials_prompter_get_dialog_parent_full(p_prompter: *CredentialsPrompter, p_auth_source: ?*edataserver.Source) ?*gtk.Window;
    pub const getDialogParentFull = e_credentials_prompter_get_dialog_parent_full;

    /// Returns an `edataserver.SourceCredentialsProvider`, which the `prompter` uses.
    extern fn e_credentials_prompter_get_provider(p_prompter: *CredentialsPrompter) *edataserver.SourceCredentialsProvider;
    pub const getProvider = e_credentials_prompter_get_provider;

    /// Returns an `edataserver.SourceRegistry`, to which the `prompter` listens.
    extern fn e_credentials_prompter_get_registry(p_prompter: *CredentialsPrompter) *edataserver.SourceRegistry;
    pub const getRegistry = e_credentials_prompter_get_registry;

    /// Runs a credentials prompt loop for `source`, as long as the `func` doesn't
    /// indicate that the provided credentials can be used to successfully
    /// authenticate against `source`<!-- -->'s server, or that the `func`
    /// returns `FALSE`. The loop is also teminated when a used cancels
    /// the credentials prompt or the `cancellable` is cancelled, though
    /// not sooner than the credentials prompt dialog is closed.
    ///
    /// Note: The function doesn't return until the loop is terminated, either
    ///    successfully or unsuccessfully. The function can be called from any
    ///    thread, though a dedicated thread is preferred.
    extern fn e_credentials_prompter_loop_prompt_sync(p_prompter: *CredentialsPrompter, p_source: *edataserver.Source, p_flags: edataserverui.CredentialsPrompterPromptFlags, p_func: edataserverui.CredentialsPrompterLoopPromptFunc, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const loopPromptSync = e_credentials_prompter_loop_prompt_sync;

    /// Process all enabled sources with connection state `E_SOURCE_CONNECTION_STATUS_AWAITING_CREDENTIALS`,
    /// like if they just asked for its credentials for the first time.
    extern fn e_credentials_prompter_process_awaiting_credentials(p_prompter: *CredentialsPrompter) void;
    pub const processAwaitingCredentials = e_credentials_prompter_process_awaiting_credentials;

    /// Continues a credential prompt for `source`. Returns, whether anything will be done.
    /// The `FALSE` either means that the `source`<!-- -->'s connection status is not
    /// the `E_SOURCE_CONNECTION_STATUS_AWAITING_CREDENTIALS` or it is disabled.
    extern fn e_credentials_prompter_process_source(p_prompter: *CredentialsPrompter, p_source: *edataserver.Source) c_int;
    pub const processSource = e_credentials_prompter_process_source;

    /// Asks the `prompter` to prompt for credentials, which are returned
    /// to the caller through `callback`, when available.The `flags` are ignored,
    /// when the `callback` is `NULL`; the credentials are passed to the `source`
    /// with `edataserver.Source.invokeAuthenticate` directly, in this case.
    /// Call `edataserverui.CredentialsPrompter.promptFinish` in `callback` to get to
    /// the provided credentials.
    extern fn e_credentials_prompter_prompt(p_prompter: *CredentialsPrompter, p_source: *edataserver.Source, p_error_text: ?[*:0]const u8, p_flags: edataserverui.CredentialsPrompterPromptFlags, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const prompt = e_credentials_prompter_prompt;

    /// Finishes a credentials prompt previously started with `edataserverui.CredentialsPrompter.prompt`.
    /// The `out_source` will have set a referenced `edataserver.Source`, for which the prompt
    /// was started. Unref it, when  no longer needed. Similarly the `out_credentials`
    /// will have set a newly allocated `edataserver.NamedParameters` structure with provided credentials,
    /// which should be freed with `e_named_credentials_free` when no longer needed.
    /// Both output arguments will be set to `NULL` on error and `FALSE` will be returned.
    extern fn e_credentials_prompter_prompt_finish(p_prompter: *CredentialsPrompter, p_result: *gio.AsyncResult, p_out_source: ?**edataserver.Source, p_out_credentials: ?**edataserver.NamedParameters, p_error: ?*?*glib.Error) c_int;
    pub const promptFinish = e_credentials_prompter_prompt_finish;

    /// Registers a prompter implementation for a given authentication method. If there is
    /// registered a prompter for the same `authentication_method`, then the function does
    /// nothing, otherwise it adds its own reference on the `prompter_impl`, and uses it
    /// for that authentication method. One `prompter_impl` can be registered for multiple
    /// authentication methods.
    ///
    /// A special value `NULL` can be used for the `authentication_method`, which means
    /// a default credentials prompter, that is to be used when there is no prompter
    /// registered for the exact authentication method.
    extern fn e_credentials_prompter_register_impl(p_prompter: *CredentialsPrompter, p_authentication_method: ?[*:0]const u8, p_prompter_impl: *edataserverui.CredentialsPrompterImpl) c_int;
    pub const registerImpl = e_credentials_prompter_register_impl;

    /// Sets whether can respond to credential prompts automatically. That means that
    /// whenever any ESource will ask for credentials, it'll try to provide them.
    ///
    /// Use `edataserverui.CredentialsPrompter.setAutoPromptDisabledFor` to influence
    /// auto-prompt per an `edataserver.Source`.
    ///
    /// This property does not influence direct calls of `edataserverui.CredentialsPrompter.prompt`.
    extern fn e_credentials_prompter_set_auto_prompt(p_prompter: *CredentialsPrompter, p_auto_prompt: c_int) void;
    pub const setAutoPrompt = e_credentials_prompter_set_auto_prompt;

    /// Sets whether the auto-prompt should be disabled for the given `source`.
    /// All sources can be auto-prompted by default. This is a complementary
    /// value for the ECredentialsPrompter::auto-prompt property.
    ///
    /// This value does not influence direct calls of `edataserverui.CredentialsPrompter.prompt`.
    extern fn e_credentials_prompter_set_auto_prompt_disabled_for(p_prompter: *CredentialsPrompter, p_source: *edataserver.Source, p_is_disabled: c_int) void;
    pub const setAutoPromptDisabledFor = e_credentials_prompter_set_auto_prompt_disabled_for;

    /// Unregisters previously registered `prompter_impl` for the given `autnetication_method` with
    /// `edataserverui.CredentialsPrompter.registerImpl`. Function does nothing, if no such authentication
    /// method is registered or if it has set a different prompter implementation.
    extern fn e_credentials_prompter_unregister_impl(p_prompter: *CredentialsPrompter, p_authentication_method: ?[*:0]const u8, p_prompter_impl: *edataserverui.CredentialsPrompterImpl) void;
    pub const unregisterImpl = e_credentials_prompter_unregister_impl;

    extern fn e_credentials_prompter_get_type() usize;
    pub const getGObjectType = e_credentials_prompter_get_type;

    extern fn g_object_ref(p_self: *edataserverui.CredentialsPrompter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.CredentialsPrompter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CredentialsPrompter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Credentials prompter implementation base structure. The descendants
/// implement ECredentialsPrompterImpl::`prompt`, which is used to
/// prompt for credentials. The descendants are automatically registered
/// into an `edataserverui.CredentialsPrompter`.
pub const CredentialsPrompterImpl = extern struct {
    pub const Parent = edataserver.Extension;
    pub const Implements = [_]type{};
    pub const Class = edataserverui.CredentialsPrompterImplClass;
    f_parent: edataserver.Extension,
    f_priv: ?*edataserverui.CredentialsPrompterImplPrivate,

    pub const virtual_methods = struct {
        /// Asks the `prompt_impl` to cancel current prompt, which should have ID `prompt_id`.
        pub const cancel_prompt = struct {
            pub fn call(p_class: anytype, p_prompter_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prompt_id: ?*anyopaque) void {
                return gobject.ext.as(CredentialsPrompterImpl.Class, p_class).f_cancel_prompt.?(gobject.ext.as(CredentialsPrompterImpl, p_prompter_impl), p_prompt_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_prompter_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prompt_id: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(CredentialsPrompterImpl.Class, p_class).f_cancel_prompt = @ptrCast(p_implementation);
            }
        };

        pub const process_prompt = struct {
            pub fn call(p_class: anytype, p_prompter_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prompt_id: ?*anyopaque, p_auth_source: *edataserver.Source, p_cred_source: *edataserver.Source, p_error_text: [*:0]const u8, p_credentials: *const edataserver.NamedParameters) void {
                return gobject.ext.as(CredentialsPrompterImpl.Class, p_class).f_process_prompt.?(gobject.ext.as(CredentialsPrompterImpl, p_prompter_impl), p_prompt_id, p_auth_source, p_cred_source, p_error_text, p_credentials);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_prompter_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prompt_id: ?*anyopaque, p_auth_source: *edataserver.Source, p_cred_source: *edataserver.Source, p_error_text: [*:0]const u8, p_credentials: *const edataserver.NamedParameters) callconv(.c) void) void {
                gobject.ext.as(CredentialsPrompterImpl.Class, p_class).f_process_prompt = @ptrCast(p_implementation);
            }
        };

        pub const prompt_finished = struct {
            pub fn call(p_class: anytype, p_prompter_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prompt_id: ?*anyopaque, p_credentials: *const edataserver.NamedParameters) void {
                return gobject.ext.as(CredentialsPrompterImpl.Class, p_class).f_prompt_finished.?(gobject.ext.as(CredentialsPrompterImpl, p_prompter_impl), p_prompt_id, p_credentials);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_prompter_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_prompt_id: ?*anyopaque, p_credentials: *const edataserver.NamedParameters) callconv(.c) void) void {
                gobject.ext.as(CredentialsPrompterImpl.Class, p_class).f_prompt_finished = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when a prompt of ID `prompt_id` is finished.
        pub const prompt_finished = struct {
            pub const name = "prompt-finished";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_prompt_id: ?*anyopaque, p_credentials: ?*edataserver.NamedParameters, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CredentialsPrompterImpl, p_instance))),
                    gobject.signalLookup("prompt-finished", CredentialsPrompterImpl.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Asks the `prompt_impl` to cancel current prompt, which should have ID `prompt_id`.
    extern fn e_credentials_prompter_impl_cancel_prompt(p_prompter_impl: *CredentialsPrompterImpl, p_prompt_id: ?*anyopaque) void;
    pub const cancelPrompt = e_credentials_prompter_impl_cancel_prompt;

    /// Returns an `edataserverui.CredentialsPrompter` with which the `prompter_impl` is associated.
    extern fn e_credentials_prompter_impl_get_credentials_prompter(p_prompter_impl: *CredentialsPrompterImpl) ?*anyopaque;
    pub const getCredentialsPrompter = e_credentials_prompter_impl_get_credentials_prompter;

    /// Runs a credentials prompt for the `prompter_impl`. The actual prompter implementation
    /// receives the prompt through ECredentialsPrompterImplClass::`process_prompt`, where the given
    /// `prompt_id` is used for an identification. The prompt is left 'active' as long as it is
    /// not finished with a call of `edataserverui.CredentialsPrompterImpl.promptFinish`. This should be
    /// called even for cancelled prompts. The prompt can be cancelled before it's processed,
    /// using the `edataserverui.CredentialsPrompterImpl.cancelPrompt`.
    ///
    /// The `auth_source` can be the same as `cred_source`, in case the credentials
    /// are stored only for that particular source. If the sources share credentials,
    /// which can be a case when the `auth_source` is part of a collection, then
    /// the `cred_stource` can be that collection source.
    extern fn e_credentials_prompter_impl_prompt(p_prompter_impl: *CredentialsPrompterImpl, p_prompt_id: ?*anyopaque, p_auth_source: *edataserver.Source, p_cred_source: *edataserver.Source, p_error_text: ?[*:0]const u8, p_credentials: *const edataserver.NamedParameters) void;
    pub const prompt = e_credentials_prompter_impl_prompt;

    /// The actual credentials prompt implementation finishes a previously started
    /// credentials prompt `prompt_id` with ECredentialsPrompterImplClass::`process_prompt`
    /// by a call to this function. This function should be called regardless the prompt
    /// was or was not cancelled with `edataserverui.CredentialsPrompterImpl.cancelPrompt`.
    /// Once the prompt is finished another queued is started, if any pending exists.
    /// Use `NULL` `credentials` for cancelled prompts, otherwise the credentials are used
    /// for authentication of the associated `edataserver.Source`.
    extern fn e_credentials_prompter_impl_prompt_finish(p_prompter_impl: *CredentialsPrompterImpl, p_prompt_id: ?*anyopaque, p_credentials: ?*const edataserver.NamedParameters) void;
    pub const promptFinish = e_credentials_prompter_impl_prompt_finish;

    extern fn e_credentials_prompter_impl_get_type() usize;
    pub const getGObjectType = e_credentials_prompter_impl_get_type;

    extern fn g_object_ref(p_self: *edataserverui.CredentialsPrompterImpl) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.CredentialsPrompterImpl) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CredentialsPrompterImpl, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CredentialsPrompterImplOAuth2 = extern struct {
    pub const Parent = edataserverui.CredentialsPrompterImpl;
    pub const Implements = [_]type{};
    pub const Class = edataserverui.CredentialsPrompterImplOAuth2Class;
    f_parent: edataserverui.CredentialsPrompterImpl,
    f_priv: ?*edataserverui.CredentialsPrompterImplOAuth2Private,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new instance of an `edataserverui.CredentialsPrompterImplOAuth2`.
    extern fn e_credentials_prompter_impl_oauth2_new() *edataserverui.CredentialsPrompterImplOAuth2;
    pub const new = e_credentials_prompter_impl_oauth2_new;

    extern fn e_credentials_prompter_impl_oauth2_get_type() usize;
    pub const getGObjectType = e_credentials_prompter_impl_oauth2_get_type;

    extern fn g_object_ref(p_self: *edataserverui.CredentialsPrompterImplOAuth2) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.CredentialsPrompterImplOAuth2) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CredentialsPrompterImplOAuth2, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using the
/// functions below.
pub const CredentialsPrompterImplPassword = extern struct {
    pub const Parent = edataserverui.CredentialsPrompterImpl;
    pub const Implements = [_]type{};
    pub const Class = edataserverui.CredentialsPrompterImplPasswordClass;
    f_parent: edataserverui.CredentialsPrompterImpl,
    f_priv: ?*edataserverui.CredentialsPrompterImplPasswordPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new instance of an `edataserverui.CredentialsPrompterImplPassword`.
    extern fn e_credentials_prompter_impl_password_new() *edataserverui.CredentialsPrompterImplPassword;
    pub const new = e_credentials_prompter_impl_password_new;

    extern fn e_credentials_prompter_impl_password_get_type() usize;
    pub const getGObjectType = e_credentials_prompter_impl_password_get_type;

    extern fn g_object_ref(p_self: *edataserverui.CredentialsPrompterImplPassword) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.CredentialsPrompterImplPassword) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CredentialsPrompterImplPassword, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains only private data that should be read and manipulated using
/// the functions below.
pub const RemindersWidget = extern struct {
    pub const Parent = gtk.Grid;
    pub const Implements = [_]type{ atk.ImplementorIface, edataserver.Extensible, gtk.Buildable, gtk.Orientable };
    pub const Class = edataserverui.RemindersWidgetClass;
    f_parent: gtk.Grid,
    f_priv: ?*edataserverui.RemindersWidgetPrivate,

    pub const virtual_methods = struct {
        pub const activated = struct {
            pub fn call(p_class: anytype, p_reminders: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_rd: *const ecal.ReminderData) c_int {
                return gobject.ext.as(RemindersWidget.Class, p_class).f_activated.?(gobject.ext.as(RemindersWidget, p_reminders), p_rd);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_reminders: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_rd: *const ecal.ReminderData) callconv(.c) c_int) void {
                gobject.ext.as(RemindersWidget.Class, p_class).f_activated = @ptrCast(p_implementation);
            }
        };

        pub const changed = struct {
            pub fn call(p_class: anytype, p_reminders: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(RemindersWidget.Class, p_class).f_changed.?(gobject.ext.as(RemindersWidget, p_reminders));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_reminders: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(RemindersWidget.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const empty = struct {
            pub const name = "empty";

            pub const Type = c_int;
        };

        pub const watcher = struct {
            pub const name = "watcher";

            pub const Type = ?*ecal.ReminderWatcher;
        };
    };

    pub const signals = struct {
        pub const activated = struct {
            pub const name = "activated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *ecal.ReminderData, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(RemindersWidget, p_instance))),
                    gobject.signalLookup("activated", RemindersWidget.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(RemindersWidget, p_instance))),
                    gobject.signalLookup("changed", RemindersWidget.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new instance of `edataserverui.RemindersWidget`. It adds its own reference
    /// on the `watcher`.
    extern fn e_reminders_widget_new(p_watcher: *ecal.ReminderWatcher) *edataserverui.RemindersWidget;
    pub const new = e_reminders_widget_new;

    extern fn e_reminders_widget_get_paned(p_reminders: *RemindersWidget) *gtk.Paned;
    pub const getPaned = e_reminders_widget_get_paned;

    extern fn e_reminders_widget_get_settings(p_reminders: *RemindersWidget) *gio.Settings;
    pub const getSettings = e_reminders_widget_get_settings;

    extern fn e_reminders_widget_get_tree_view(p_reminders: *RemindersWidget) *gtk.TreeView;
    pub const getTreeView = e_reminders_widget_get_tree_view;

    extern fn e_reminders_widget_get_watcher(p_reminders: *RemindersWidget) *ecal.ReminderWatcher;
    pub const getWatcher = e_reminders_widget_get_watcher;

    extern fn e_reminders_widget_is_empty(p_reminders: *RemindersWidget) c_int;
    pub const isEmpty = e_reminders_widget_is_empty;

    /// Shows a warning in the GUI with the `error` message, optionally prefixed
    /// with `prefix`. When `error` is `NULL`, an "Unknown error" message is shown
    /// instead.
    extern fn e_reminders_widget_report_error(p_reminders: *RemindersWidget, p_prefix: ?[*:0]const u8, p_error: ?*const glib.Error) void;
    pub const reportError = e_reminders_widget_report_error;

    extern fn e_reminders_widget_get_type() usize;
    pub const getGObjectType = e_reminders_widget_get_type;

    extern fn g_object_ref(p_self: *edataserverui.RemindersWidget) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.RemindersWidget) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *RemindersWidget, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVDiscoverContent = opaque {
    pub const Parent = gtk.Grid;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = edataserverui.WebDAVDiscoverContentClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new WebDAV discovery content, which is a `gtk.Grid` containing necessary
    /// widgets to provide a UI interface for a user to search and select for available
    /// WebDAV (CalDAV or CardDAV) sources provided by the given server. Do not pack
    /// anything into this content, its content can be changed dynamically.
    extern fn e_webdav_discover_content_new(p_credentials_prompter: *edataserverui.CredentialsPrompter, p_source: ?*edataserver.Source, p_base_url: ?[*:0]const u8, p_supports_filter: c_uint) *edataserverui.WebDAVDiscoverContent;
    pub const new = e_webdav_discover_content_new;

    /// Returns currently set base URL for the `content`. This is used to overwrite the one
    /// set on the `edataserver.Source` from the creation time. The URL can be either a full URL, a path
    /// or even a `NULL`.
    extern fn e_webdav_discover_content_get_base_url(p_content: *WebDAVDiscoverContent) [*:0]const u8;
    pub const getBaseUrl = e_webdav_discover_content_get_base_url;

    extern fn e_webdav_discover_content_get_multiselect(p_content: *WebDAVDiscoverContent) c_int;
    pub const getMultiselect = e_webdav_discover_content_get_multiselect;

    /// Returns information about selected source at index `index`. The function can be called
    /// multiple times, with the index starting at zero and as long as it doesn't return `FALSE`.
    /// If the `content` doesn't have allowed multiselection, then the only valid `index` is 0.
    ///
    /// All the `out_href`, `out_display_name` and `out_color` are newly allocated strings, which should
    /// be freed with `glib.free`, when no longer needed.
    extern fn e_webdav_discover_content_get_selected(p_content: *WebDAVDiscoverContent, p_index: c_int, p_out_href: *[*:0]u8, p_out_supports: *c_uint, p_out_display_name: *[*:0]u8, p_out_color: *[*:0]u8, p_out_order: *c_uint) c_int;
    pub const getSelected = e_webdav_discover_content_get_selected;

    /// Returns inner `GtkTreeViewSelection`. This is meant to be able to connect
    /// to its "changed" signal and update other parts of the parent widgets accordingly.
    extern fn e_webdav_discover_content_get_tree_selection(p_content: *WebDAVDiscoverContent) *gtk.TreeSelection;
    pub const getTreeSelection = e_webdav_discover_content_get_tree_selection;

    /// Get currently selected user address in the `content`, if the server returned any.
    /// This value has meaning only with calendar sources.
    extern fn e_webdav_discover_content_get_user_address(p_content: *WebDAVDiscoverContent) ?[*:0]u8;
    pub const getUserAddress = e_webdav_discover_content_get_user_address;

    /// Asynchronously starts refresh of the `content`. This means to access the server
    /// and search it for available sources. The `content` shows a feedback and a Cancel
    /// button during the operation.
    ///
    /// The `display_name` is used only if the `content` wasn't created with an `edataserver.Source` and
    /// it's shown in the password prompts, if there are required any.
    ///
    /// When the operation is finished, `callback` will be called. You can then
    /// call `edataserverui.WebDAVDiscoverContent.refreshFinish` to get the result of the operation.
    extern fn e_webdav_discover_content_refresh(p_content: *WebDAVDiscoverContent, p_display_name: ?[*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const refresh = e_webdav_discover_content_refresh;

    /// Finishes the operation started with `edataserverui.WebDAVDiscoverContent.refresh`. If an
    /// error occurred, the function will set `error` and return `FALSE`. There is
    /// available `edataserverui.WebDAVDiscoverContent.showError` for convenience, which
    /// shows the error within `content` and takes care of it when refreshing
    /// the content.
    extern fn e_webdav_discover_content_refresh_finish(p_content: *WebDAVDiscoverContent, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const refreshFinish = e_webdav_discover_content_refresh_finish;

    /// Sets base URL for the `content`. This is used to overwrite the one set on
    /// the `edataserver.Source` from the creation time. The URL can be either a full URL, a path
    /// or even a `NULL`.
    extern fn e_webdav_discover_content_set_base_url(p_content: *WebDAVDiscoverContent, p_base_url: [*:0]const u8) void;
    pub const setBaseUrl = e_webdav_discover_content_set_base_url;

    /// Sets whether the WebDAV discovery content allows multiselect.
    extern fn e_webdav_discover_content_set_multiselect(p_content: *WebDAVDiscoverContent, p_multiselect: c_int) void;
    pub const setMultiselect = e_webdav_discover_content_set_multiselect;

    /// Shows the `error` within `content`, unless it's a `G_IO_ERROR_CANCELLED`, or `NULL`,
    /// which are safely ignored. The advantage of this function is that the error
    /// message is removed when the refresh operation is started.
    extern fn e_webdav_discover_content_show_error(p_content: *WebDAVDiscoverContent, p_error: *const glib.Error) void;
    pub const showError = e_webdav_discover_content_show_error;

    extern fn e_webdav_discover_content_get_type() usize;
    pub const getGObjectType = e_webdav_discover_content_get_type;

    extern fn g_object_ref(p_self: *edataserverui.WebDAVDiscoverContent) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.WebDAVDiscoverContent) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WebDAVDiscoverContent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVDiscoverDialog = opaque {
    pub const Parent = gtk.Dialog;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = edataserverui.WebDAVDiscoverDialogClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gtk.Dialog` which has as its content a WebDAV discovery widget,
    /// created with `edataserverui.WebDAVDiscoverContent.new`. This dialog can be shown to a user
    /// and when its final response is `GTK_RESPONSE_ACCEPT`, then the inner content
    /// can be asked for currently selected source(s).
    extern fn e_webdav_discover_dialog_new(p_parent: *gtk.Window, p_title: [*:0]const u8, p_credentials_prompter: *edataserverui.CredentialsPrompter, p_source: *edataserver.Source, p_base_url: ?[*:0]const u8, p_supports_filter: c_uint) *edataserverui.WebDAVDiscoverDialog;
    pub const new = e_webdav_discover_dialog_new;

    /// Returns inner WebDAV discovery content, which can be further manipulated.
    extern fn e_webdav_discover_dialog_get_content(p_dialog: *WebDAVDiscoverDialog) *edataserverui.WebDAVDiscoverContent;
    pub const getContent = e_webdav_discover_dialog_get_content;

    /// Invokes refresh of the inner content of the WebDAV discovery dialog.
    extern fn e_webdav_discover_dialog_refresh(p_dialog: *WebDAVDiscoverDialog) void;
    pub const refresh = e_webdav_discover_dialog_refresh;

    extern fn e_webdav_discover_dialog_get_type() usize;
    pub const getGObjectType = e_webdav_discover_dialog_get_type;

    extern fn g_object_ref(p_self: *edataserverui.WebDAVDiscoverDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *edataserverui.WebDAVDiscoverDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *WebDAVDiscoverDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CellRendererColorClass = extern struct {
    pub const Instance = edataserverui.CellRendererColor;

    f_parent_class: gtk.CellRendererClass,
    f__gtk_reserved1: ?*const fn () callconv(.c) void,
    f__gtk_reserved2: ?*const fn () callconv(.c) void,
    f__gtk_reserved3: ?*const fn () callconv(.c) void,
    f__gtk_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *CellRendererColorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CellRendererColorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CertificateWidgetClass = extern struct {
    pub const Instance = edataserverui.CertificateWidget;

    f_parent_class: gtk.ScrolledWindowClass,

    pub fn as(p_instance: *CertificateWidgetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CertificateWidgetPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CredentialsPrompterClass = extern struct {
    pub const Instance = edataserverui.CredentialsPrompter;

    f_parent_class: gobject.ObjectClass,
    f_get_dialog_parent: ?*const fn (p_prompter: *edataserverui.CredentialsPrompter) callconv(.c) ?*gtk.Window,

    pub fn as(p_instance: *CredentialsPrompterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CredentialsPrompterImplClass = extern struct {
    pub const Instance = edataserverui.CredentialsPrompterImpl;

    f_parent_class: edataserver.ExtensionClass,
    f_authentication_methods: ?*const [*:0]const u8,
    f_process_prompt: ?*const fn (p_prompter_impl: *edataserverui.CredentialsPrompterImpl, p_prompt_id: ?*anyopaque, p_auth_source: *edataserver.Source, p_cred_source: *edataserver.Source, p_error_text: [*:0]const u8, p_credentials: *const edataserver.NamedParameters) callconv(.c) void,
    f_cancel_prompt: ?*const fn (p_prompter_impl: *edataserverui.CredentialsPrompterImpl, p_prompt_id: ?*anyopaque) callconv(.c) void,
    f_prompt_finished: ?*const fn (p_prompter_impl: *edataserverui.CredentialsPrompterImpl, p_prompt_id: ?*anyopaque, p_credentials: *const edataserver.NamedParameters) callconv(.c) void,

    pub fn as(p_instance: *CredentialsPrompterImplClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CredentialsPrompterImplOAuth2Class = extern struct {
    pub const Instance = edataserverui.CredentialsPrompterImplOAuth2;

    f_parent_class: edataserverui.CredentialsPrompterImplClass,

    pub fn as(p_instance: *CredentialsPrompterImplOAuth2Class, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CredentialsPrompterImplOAuth2Private = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CredentialsPrompterImplPasswordClass = extern struct {
    pub const Instance = edataserverui.CredentialsPrompterImplPassword;

    f_parent_class: edataserverui.CredentialsPrompterImplClass,

    pub fn as(p_instance: *CredentialsPrompterImplPasswordClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CredentialsPrompterImplPasswordPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CredentialsPrompterImplPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CredentialsPrompterPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for the `edataserverui.RemindersWidget` class.
pub const RemindersWidgetClass = extern struct {
    pub const Instance = edataserverui.RemindersWidget;

    f_parent_class: gtk.GridClass,
    f_changed: ?*const fn (p_reminders: *edataserverui.RemindersWidget) callconv(.c) void,
    f_activated: ?*const fn (p_reminders: *edataserverui.RemindersWidget, p_rd: *const ecal.ReminderData) callconv(.c) c_int,
    f_reserved: [10]*anyopaque,

    pub fn as(p_instance: *RemindersWidgetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RemindersWidgetPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVDiscoverContentClass = extern struct {
    pub const Instance = edataserverui.WebDAVDiscoverContent;

    f_parent_class: gtk.GridClass,

    pub fn as(p_instance: *WebDAVDiscoverContentClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WebDAVDiscoverDialogClass = extern struct {
    pub const Instance = edataserverui.WebDAVDiscoverDialog;

    f_parent_class: gtk.DialogClass,

    pub fn as(p_instance: *WebDAVDiscoverDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An `edataserverui.CredentialsPrompter` prompt flags, influencing behaviour
/// of the `edataserverui.CredentialsPrompter.prompt`.
pub const CredentialsPrompterPromptFlags = packed struct(c_uint) {
    allow_source_save: bool = false,
    allow_stored_credentials: bool = false,
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

    pub const flags_none: CredentialsPrompterPromptFlags = @bitCast(@as(c_uint, 0));
    pub const flags_allow_source_save: CredentialsPrompterPromptFlags = @bitCast(@as(c_uint, 1));
    pub const flags_allow_stored_credentials: CredentialsPrompterPromptFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn e_buffer_tagger_connect(p_textview: *gtk.TextView) void;
pub const bufferTaggerConnect = e_buffer_tagger_connect;

extern fn e_buffer_tagger_disconnect(p_textview: *gtk.TextView) void;
pub const bufferTaggerDisconnect = e_buffer_tagger_disconnect;

extern fn e_buffer_tagger_update_tags(p_textview: *gtk.TextView) void;
pub const bufferTaggerUpdateTags = e_buffer_tagger_update_tags;

/// Converts `flags` into a localized text description of the set bits, one
/// bit description per line. If no bit is set, then an empty string is
/// returned.
extern fn e_trust_prompt_describe_certificate_errors(p_flags: gio.TlsCertificateFlags) [*:0]u8;
pub const trustPromptDescribeCertificateErrors = e_trust_prompt_describe_certificate_errors;

/// Similar to `edataserverui.trustPromptRunModal`, except it also manages all the necessary things
/// around the `source`<!-- -->'s SSL/TLS trust properties when it also contains `E_SOURCE_EXTENSION_WEBDAV`,
/// thus the SSL/TLS trust on the WebDAV `source` is properly updated based on the user's choice.
/// The call is finished with `edataserverui.trustPromptRunForSourceFinish`,
/// which also returns the user's choice. The finish happens in the `callback`.
/// This is necessary, because the `source` can be also saved.
///
/// The function fails, if the `source` doesn't contain the `E_SOURCE_EXTENSION_AUTHENTICATION`.
///
/// Note: The dialog is not shown when the stored certificate trust in the WebDAV `source`
///    matches the `certificate_pem` and the stored result is `E_TRUST_PROMPT_RESPONSE_REJECT`.
extern fn e_trust_prompt_run_for_source(p_parent: *gtk.Window, p_source: *edataserver.Source, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_error_text: ?[*:0]const u8, p_allow_source_save: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
pub const trustPromptRunForSource = e_trust_prompt_run_for_source;

/// Finishes the operation started with `edataserverui.trustPromptRunForSource`.
/// The `response` will contain a code of the user's choice.
/// The `E_TRUST_PROMPT_RESPONSE_UNKNOWN` is used, when the user cancelled the trust
/// prompt dialog and no changes are made with the `source`.
///
/// If an error occurs, the function sets `error` and returns `FALSE`.
extern fn e_trust_prompt_run_for_source_finish(p_source: *edataserver.Source, p_result: *gio.AsyncResult, p_response: *edataserver.TrustPromptResponse, p_error: ?*?*glib.Error) c_int;
pub const trustPromptRunForSourceFinish = e_trust_prompt_run_for_source_finish;

/// Runs modal (doesn't return until the dialog is closed) a trust prompt dialog,
/// it is a prompt whether a user wants to accept or reject the `certificate_pem`
/// for the `host` due to the `certificate_errors` errors.
///
/// The pair `source_extension` and `source_display_name` influences the trust prompt message.
/// If both are set, then the message also contains which source failed to connect according
/// to these two arguments.
///
/// The dialog can contain a custom error text, passed in as `error_text`.
/// The error might be a detailed error string returned by the server. If set,
/// it is prefixed with "Detailed error:" string.
extern fn e_trust_prompt_run_modal(p_parent: *gtk.Window, p_source_extension: ?[*:0]const u8, p_source_display_name: ?[*:0]const u8, p_host: [*:0]const u8, p_certificate_pem: [*:0]const u8, p_certificate_errors: gio.TlsCertificateFlags, p_error_text: ?[*:0]const u8) edataserver.TrustPromptResponse;
pub const trustPromptRunModal = e_trust_prompt_run_modal;

pub const CredentialsPrompterLoopPromptFunc = *const fn (p_prompter: *edataserverui.CredentialsPrompter, p_source: *edataserver.Source, p_credentials: *const edataserver.NamedParameters, p_out_authenticated: *c_int, p_user_data: ?*anyopaque, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) callconv(.c) c_int;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
