pub const ext = @import("ext.zig");
const atspi = @This();

const std = @import("std");
const compat = @import("compat");
const gobject = @import("gobject2");
const glib = @import("glib2");
const dbus = @import("dbus1");
pub const ControllerEventMask = c_uint;

pub const DeviceEventMask = c_uint;

pub const KeyEventMask = c_uint;

pub const KeyMaskType = c_uint;

pub const KeystrokeListener = void;

/// The base interface which is implemented by all accessible objects.
///
/// All objects support interfaces for querying their contained 'children'
/// and position in the accessible-object hierarchy, whether or not they
/// actually have children.
pub const Accessible = extern struct {
    pub const Parent = atspi.Object;
    pub const Implements = [_]type{ atspi.Action, atspi.Collection, atspi.Component, atspi.Document, atspi.EditableText, atspi.Hypertext, atspi.Image, atspi.Selection, atspi.Table, atspi.TableCell, atspi.Text, atspi.Value };
    pub const Class = atspi.AccessibleClass;
    f_parent: atspi.Object,
    f_accessible_parent: ?*atspi.Accessible,
    f_children: ?*glib.PtrArray,
    f_role: atspi.Role,
    f_interfaces: c_int,
    f_name: ?[*:0]u8,
    f_description: ?[*:0]u8,
    f_states: ?*atspi.StateSet,
    f_attributes: ?*glib.HashTable,
    f_cached_properties: c_uint,
    f_priv: ?*atspi.AccessiblePrivate,

    pub const virtual_methods = struct {
        pub const mode_changed = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_enabled: c_int) void {
                return gobject.ext.as(Accessible.Class, p_class).f_mode_changed.?(gobject.ext.as(Accessible, p_accessible), p_enabled);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_enabled: c_int) callconv(.c) void) void {
                gobject.ext.as(Accessible.Class, p_class).f_mode_changed = @ptrCast(p_implementation);
            }
        };

        pub const region_changed = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_current_offset: c_int, p_last_offset: c_int) void {
                return gobject.ext.as(Accessible.Class, p_class).f_region_changed.?(gobject.ext.as(Accessible, p_accessible), p_current_offset, p_last_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_current_offset: c_int, p_last_offset: c_int) callconv(.c) void) void {
                gobject.ext.as(Accessible.Class, p_class).f_region_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The signal "mode-changed" is emitted by a screen reader to indicate
        /// that its mode has changed. This signal supports the following details:
        /// focus-tracking
        /// flat-review
        /// mouse-review
        /// say-all
        /// caret-tracking
        pub const mode_changed = struct {
            pub const name = "mode-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_why: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Accessible, p_instance))),
                    gobject.signalLookup("mode-changed", Accessible.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal "region-changed" is emitted by a screen reader to indicate
        /// that it is now reading or tracking a new object, or, a new piece of
        /// text within an object. This allows a magnifier to gain the information
        /// needed to highlight the object that the screen reader is reading.
        pub const region_changed = struct {
            pub const name = "region-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_arg2: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Accessible, p_instance))),
                    gobject.signalLookup("region-changed", Accessible.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Clears the cached information for the given accessible and all of its
    /// descendants.
    extern fn atspi_accessible_clear_cache(p_obj: *Accessible) void;
    pub const clearCache = atspi_accessible_clear_cache;

    /// Clears the cached information only for the given accessible.
    extern fn atspi_accessible_clear_cache_single(p_obj: *Accessible) void;
    pub const clearCacheSingle = atspi_accessible_clear_cache_single;

    /// Gets the accessible id of the accessible.  This is not meant to be presented
    /// to the user, but to be an id which is stable over application development.
    /// Typically, this is the gtkbuilder id.
    extern fn atspi_accessible_get_accessible_id(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getAccessibleId = atspi_accessible_get_accessible_id;

    /// Gets the `atspi.Action` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_action(p_obj: *Accessible) *atspi.Action;
    pub const getAction = atspi_accessible_get_action;

    /// Gets the `atspi.Action` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_action_iface(p_obj: *Accessible) *atspi.Action;
    pub const getActionIface = atspi_accessible_get_action_iface;

    /// Gets the containing `atspi.Application` for an object.
    extern fn atspi_accessible_get_application(p_obj: *Accessible, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getApplication = atspi_accessible_get_application;

    /// Gets the AT-SPI IPC specification version supported by the application
    /// pointed to by the `atspi.Accessible` object.
    /// Only works on application root objects.
    extern fn atspi_accessible_get_atspi_version(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getAtspiVersion = atspi_accessible_get_atspi_version;

    /// Gets the `AttributeSet` representing any assigned
    /// name-value pair attributes or annotations for this object.
    /// For typographic, textual, or textually-semantic attributes, see
    /// atspi_text_get_attributes instead.
    extern fn atspi_accessible_get_attributes(p_obj: *Accessible, p_error: ?*?*glib.Error) ?*glib.HashTable;
    pub const getAttributes = atspi_accessible_get_attributes;

    /// Gets a `glib.Array` representing any assigned
    /// name-value pair attributes or annotations for this object.
    /// For typographic, textual, or textually-semantic attributes, see
    /// atspi_text_get_attributes_as_array instead.
    extern fn atspi_accessible_get_attributes_as_array(p_obj: *Accessible, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getAttributesAsArray = atspi_accessible_get_attributes_as_array;

    /// Gets the `atspi.Accessible` child of an `atspi.Accessible` object at a given index.
    extern fn atspi_accessible_get_child_at_index(p_obj: *Accessible, p_child_index: c_int, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getChildAtIndex = atspi_accessible_get_child_at_index;

    /// Gets the number of children contained by an `atspi.Accessible` object.
    extern fn atspi_accessible_get_child_count(p_obj: *Accessible, p_error: ?*?*glib.Error) c_int;
    pub const getChildCount = atspi_accessible_get_child_count;

    /// Gets the `atspi.Collection` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_collection(p_obj: *Accessible) *atspi.Collection;
    pub const getCollection = atspi_accessible_get_collection;

    /// Gets the `atspi.Collection` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_collection_iface(p_obj: *Accessible) *atspi.Collection;
    pub const getCollectionIface = atspi_accessible_get_collection_iface;

    /// Gets the `atspi.Component` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_component(p_obj: *Accessible) *atspi.Component;
    pub const getComponent = atspi_accessible_get_component;

    /// Gets the `atspi.Component` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_component_iface(p_obj: *Accessible) *atspi.Component;
    pub const getComponentIface = atspi_accessible_get_component_iface;

    /// Gets the description of an `atspi.Accessible` object.
    extern fn atspi_accessible_get_description(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getDescription = atspi_accessible_get_description;

    /// Gets the `atspi.Document` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_document(p_obj: *Accessible) *atspi.Document;
    pub const getDocument = atspi_accessible_get_document;

    /// Gets the `atspi.Document` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_document_iface(p_obj: *Accessible) *atspi.Document;
    pub const getDocumentIface = atspi_accessible_get_document_iface;

    /// Gets the `atspi.EditableText` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_editable_text(p_obj: *Accessible) *atspi.EditableText;
    pub const getEditableText = atspi_accessible_get_editable_text;

    /// Gets the `atspi.EditableText` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_editable_text_iface(p_obj: *Accessible) *atspi.EditableText;
    pub const getEditableTextIface = atspi_accessible_get_editable_text_iface;

    /// Gets the help text associated with the accessible, if set. When this is
    /// present, it provides information that a screen reader can relay to the user
    /// to explain how to interact with the object.
    extern fn atspi_accessible_get_help_text(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getHelpText = atspi_accessible_get_help_text;

    /// Gets the `atspi.Hyperlink` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_hyperlink(p_obj: *Accessible) *atspi.Hyperlink;
    pub const getHyperlink = atspi_accessible_get_hyperlink;

    /// Gets the `atspi.Hypertext` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_hypertext(p_obj: *Accessible) *atspi.Hypertext;
    pub const getHypertext = atspi_accessible_get_hypertext;

    /// Gets the `atspi.Hypertext` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_hypertext_iface(p_obj: *Accessible) *atspi.Hypertext;
    pub const getHypertextIface = atspi_accessible_get_hypertext_iface;

    /// Gets the application id for a `atspi.Accessible` object.
    /// Only works on application root objects.
    extern fn atspi_accessible_get_id(p_obj: *Accessible, p_error: ?*?*glib.Error) c_int;
    pub const getId = atspi_accessible_get_id;

    /// Gets the `atspi.Image` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_image(p_obj: *Accessible) *atspi.Image;
    pub const getImage = atspi_accessible_get_image;

    /// Gets the `atspi.Image` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_image_iface(p_obj: *Accessible) *atspi.Image;
    pub const getImageIface = atspi_accessible_get_image_iface;

    /// Gets the index of an `atspi.Accessible` object within its parent's
    /// `atspi.Accessible` children list.
    extern fn atspi_accessible_get_index_in_parent(p_obj: *Accessible, p_error: ?*?*glib.Error) c_int;
    pub const getIndexInParent = atspi_accessible_get_index_in_parent;

    /// A set of pointers to all interfaces supported by an `atspi.Accessible`.
    extern fn atspi_accessible_get_interfaces(p_obj: *Accessible) *glib.Array;
    pub const getInterfaces = atspi_accessible_get_interfaces;

    /// Gets a UTF-8 string corresponding to the name of the role played by an
    /// object, translated to the current locale.
    /// This method will return useful values for roles that fall outside the
    /// enumeration used in atspi_accessible_getRole ().
    extern fn atspi_accessible_get_localized_role_name(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getLocalizedRoleName = atspi_accessible_get_localized_role_name;

    /// Gets the name of an `atspi.Accessible` object.
    extern fn atspi_accessible_get_name(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getName = atspi_accessible_get_name;

    extern fn atspi_accessible_get_object_locale(p_accessible: *Accessible, p_error: ?*?*glib.Error) ?[*:0]const u8;
    pub const getObjectLocale = atspi_accessible_get_object_locale;

    /// Gets an `atspi.Accessible` object's parent container.
    extern fn atspi_accessible_get_parent(p_obj: *Accessible, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getParent = atspi_accessible_get_parent;

    /// Returns the process id associated with the given accessible.  Mainly
    /// added for debugging; it is a shortcut to explicitly querying the
    /// accessible's app->bus_name and then calling GetConnectionUnixProcessID.
    extern fn atspi_accessible_get_process_id(p_accessible: *Accessible, p_error: ?*?*glib.Error) c_uint;
    pub const getProcessId = atspi_accessible_get_process_id;

    /// Gets the set of `atspi.Relation` objects which describes this `atspi.Accessible` object's
    /// relationships with other `atspi.Accessible` objects.
    extern fn atspi_accessible_get_relation_set(p_obj: *Accessible, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getRelationSet = atspi_accessible_get_relation_set;

    /// Gets the UI role played by an `atspi.Accessible` object.
    /// This role's name can be obtained via atspi_accessible_get_role_name ().
    extern fn atspi_accessible_get_role(p_obj: *Accessible, p_error: ?*?*glib.Error) atspi.Role;
    pub const getRole = atspi_accessible_get_role;

    /// Gets a UTF-8 string corresponding to the name of the role played by an object.
    /// This method will return useful values for roles that fall outside the
    /// enumeration used in atspi_accessible_get_role ().
    extern fn atspi_accessible_get_role_name(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getRoleName = atspi_accessible_get_role_name;

    /// Gets the `atspi.Selection` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_selection(p_obj: *Accessible) *atspi.Selection;
    pub const getSelection = atspi_accessible_get_selection;

    /// Gets the `atspi.Selection` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_selection_iface(p_obj: *Accessible) *atspi.Selection;
    pub const getSelectionIface = atspi_accessible_get_selection_iface;

    /// Gets the states currently held by an object.
    extern fn atspi_accessible_get_state_set(p_obj: *Accessible) *atspi.StateSet;
    pub const getStateSet = atspi_accessible_get_state_set;

    /// Gets the `atspi.Table` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_table(p_obj: *Accessible) *atspi.Table;
    pub const getTable = atspi_accessible_get_table;

    /// Gets the `atspi.TableCell` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_table_cell(p_obj: *Accessible) *atspi.TableCell;
    pub const getTableCell = atspi_accessible_get_table_cell;

    /// Gets the `atspi.Table` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_table_iface(p_obj: *Accessible) *atspi.Table;
    pub const getTableIface = atspi_accessible_get_table_iface;

    /// Gets the `atspi.Table` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_text(p_obj: *Accessible) *atspi.Text;
    pub const getText = atspi_accessible_get_text;

    /// Gets the `atspi.Table` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_text_iface(p_obj: *Accessible) *atspi.Text;
    pub const getTextIface = atspi_accessible_get_text_iface;

    /// Gets the toolkit name for an `atspi.Accessible` object.
    /// Only works on application root objects.
    extern fn atspi_accessible_get_toolkit_name(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getToolkitName = atspi_accessible_get_toolkit_name;

    /// Gets the toolkit version for an `atspi.Accessible` object.
    /// Only works on application root objects.
    extern fn atspi_accessible_get_toolkit_version(p_obj: *Accessible, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getToolkitVersion = atspi_accessible_get_toolkit_version;

    /// Gets the `atspi.Table` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_value(p_obj: *Accessible) *atspi.Value;
    pub const getValue = atspi_accessible_get_value;

    /// Gets the `atspi.Table` interface for an `atspi.Accessible`.
    extern fn atspi_accessible_get_value_iface(p_obj: *Accessible) *atspi.Value;
    pub const getValueIface = atspi_accessible_get_value_iface;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Action` interface.
    extern fn atspi_accessible_is_action(p_obj: *Accessible) c_int;
    pub const isAction = atspi_accessible_is_action;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Application` interface.
    extern fn atspi_accessible_is_application(p_obj: *Accessible) c_int;
    pub const isApplication = atspi_accessible_is_application;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Collection` interface.
    extern fn atspi_accessible_is_collection(p_obj: *Accessible) c_int;
    pub const isCollection = atspi_accessible_is_collection;

    /// Query whether the specified `atspi.Accessible` implements `atspi.Component`.
    extern fn atspi_accessible_is_component(p_obj: *Accessible) c_int;
    pub const isComponent = atspi_accessible_is_component;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Document` interface.
    extern fn atspi_accessible_is_document(p_obj: *Accessible) c_int;
    pub const isDocument = atspi_accessible_is_document;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.EditableText` interface.
    extern fn atspi_accessible_is_editable_text(p_obj: *Accessible) c_int;
    pub const isEditableText = atspi_accessible_is_editable_text;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Hyperlink` interface.
    extern fn atspi_accessible_is_hyperlink(p_obj: *Accessible) c_int;
    pub const isHyperlink = atspi_accessible_is_hyperlink;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Hypertext` interface.
    extern fn atspi_accessible_is_hypertext(p_obj: *Accessible) c_int;
    pub const isHypertext = atspi_accessible_is_hypertext;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Image` interface.
    extern fn atspi_accessible_is_image(p_obj: *Accessible) c_int;
    pub const isImage = atspi_accessible_is_image;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Selection` interface.
    extern fn atspi_accessible_is_selection(p_obj: *Accessible) c_int;
    pub const isSelection = atspi_accessible_is_selection;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Table` interface.
    extern fn atspi_accessible_is_table(p_obj: *Accessible) c_int;
    pub const isTable = atspi_accessible_is_table;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.TableCell` interface.
    extern fn atspi_accessible_is_table_cell(p_obj: *Accessible) c_int;
    pub const isTableCell = atspi_accessible_is_table_cell;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Text` interface.
    extern fn atspi_accessible_is_text(p_obj: *Accessible) c_int;
    pub const isText = atspi_accessible_is_text;

    /// Query whether the specified `atspi.Accessible` implements the
    /// `atspi.Value` interface.
    extern fn atspi_accessible_is_value(p_obj: *Accessible) c_int;
    pub const isValue = atspi_accessible_is_value;

    /// Sets the type of data to cache for accessibles.
    /// If this is not set for an application or is reset to ATSPI_CACHE_UNDEFINED,
    /// then the desktop's cache flag will be used.
    /// If the desktop's cache flag is also undefined, then all possible data will
    /// be cached.
    /// This function is intended to work around bugs in toolkits where the proper
    /// events are not raised / to aid in testing for such bugs.
    extern fn atspi_accessible_set_cache_mask(p_accessible: *Accessible, p_mask: atspi.Cache) void;
    pub const setCacheMask = atspi_accessible_set_cache_mask;

    extern fn atspi_accessible_get_type() usize;
    pub const getGObjectType = atspi_accessible_get_type;

    extern fn g_object_ref(p_self: *atspi.Accessible) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Accessible) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Accessible, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface identifying the root object associated
/// with a running application.
///
/// An interface identifying an object which is the root of the
/// hierarchy associated with a running application.
pub const Application = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.ApplicationClass;
    f_parent: gobject.Object,
    f_hash: ?*glib.HashTable,
    f_bus_name: ?[*:0]u8,
    f_bus: ?*dbus.Connection,
    f_root: ?*anyopaque,
    f_cache: atspi.Cache,
    f_toolkit_name: ?[*:0]u8,
    f_toolkit_version: ?[*:0]u8,
    f_atspi_version: ?[*:0]u8,
    f_time_added: ?*anyopaque,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn atspi_application_get_type() usize;
    pub const getGObjectType = atspi_application_get_type;

    extern fn g_object_ref(p_self: *atspi.Application) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Application) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Application, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Device = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.DeviceClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const add_key_grab = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_kd: *atspi.KeyDefinition) c_int {
                return gobject.ext.as(Device.Class, p_class).f_add_key_grab.?(gobject.ext.as(Device, p_device), p_kd);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_kd: *atspi.KeyDefinition) callconv(.c) c_int) void {
                gobject.ext.as(Device.Class, p_class).f_add_key_grab = @ptrCast(p_implementation);
            }
        };

        /// Synthesizes a mouse event at a specific screen coordinate.
        /// Most AT clients should use the `AccessibleAction` interface when
        /// tempted to generate mouse events, rather than this method.
        /// Event names: b1p = button 1 press; b2r = button 2 release;
        ///              b3c = button 3 click; b2d = button 2 double-click;
        ///              abs = absolute motion; rel = relative motion.
        pub const generate_mouse_event = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_obj: *atspi.Accessible, p_x: c_int, p_y: c_int, p_name: [*:0]const u8, p_error: ?*?*glib.Error) void {
                return gobject.ext.as(Device.Class, p_class).f_generate_mouse_event.?(gobject.ext.as(Device, p_device), p_obj, p_x, p_y, p_name, p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_obj: *atspi.Accessible, p_x: c_int, p_y: c_int, p_name: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) void) void {
                gobject.ext.as(Device.Class, p_class).f_generate_mouse_event = @ptrCast(p_implementation);
            }
        };

        /// Gets the modifier for a given keysym, if one exists. Does not create a new
        /// mapping. This function should be used when the intention is to query a
        /// locking modifier such as num lock via atspi_device_get_locked_modifiers,
        /// rather than to add key grabs.
        pub const get_keysym_modifier = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keysym: c_uint) c_uint {
                return gobject.ext.as(Device.Class, p_class).f_get_keysym_modifier.?(gobject.ext.as(Device, p_device), p_keysym);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keysym: c_uint) callconv(.c) c_uint) void {
                gobject.ext.as(Device.Class, p_class).f_get_keysym_modifier = @ptrCast(p_implementation);
            }
        };

        /// Returns the locked modifiers (ie, num lock, caps lock) associated with this
        /// keyboard.
        pub const get_locked_modifiers = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_uint {
                return gobject.ext.as(Device.Class, p_class).f_get_locked_modifiers.?(gobject.ext.as(Device, p_device));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_uint) void {
                gobject.ext.as(Device.Class, p_class).f_get_locked_modifiers = @ptrCast(p_implementation);
            }
        };

        /// Gets the modifier for a given keycode, if one exists. Does not create a new
        /// mapping. This function should be used when the intention is to query a
        /// locking modifier such as num lock via atspi_device_get_locked_modifiers,
        /// rather than to add key grabs.
        pub const get_modifier = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keycode: c_int) c_uint {
                return gobject.ext.as(Device.Class, p_class).f_get_modifier.?(gobject.ext.as(Device, p_device), p_keycode);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keycode: c_int) callconv(.c) c_uint) void {
                gobject.ext.as(Device.Class, p_class).f_get_modifier = @ptrCast(p_implementation);
            }
        };

        /// Attempts to grab the entire keyboard. This should only be done
        /// temporarily, as it may conflict with other applications that also want to
        /// grab the keyboard.
        pub const grab_keyboard = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Device.Class, p_class).f_grab_keyboard.?(gobject.ext.as(Device, p_device));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Device.Class, p_class).f_grab_keyboard = @ptrCast(p_implementation);
            }
        };

        /// Maps the specified keysym to a modifier so that it can be used in
        /// conjunction with other keys to create a key grab. If the given keysym is
        /// already mapped, then this function will return the modifier that is
        /// currently mapped to the keysym, without doing anything else. Otherwise,
        /// it will use the last modifier that AT-SPI used to map a keysym. If no keys
        /// have yet been mapped using this device, then it will look for a modifier
        /// that is not currently being used. If no unused modifier can be found,
        /// then it will use the first modifier by default.
        pub const map_keysym_modifier = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keysym: c_uint) c_uint {
                return gobject.ext.as(Device.Class, p_class).f_map_keysym_modifier.?(gobject.ext.as(Device, p_device), p_keysym);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keysym: c_uint) callconv(.c) c_uint) void {
                gobject.ext.as(Device.Class, p_class).f_map_keysym_modifier = @ptrCast(p_implementation);
            }
        };

        /// Maps the specified key code to a modifier so that it can be used in
        /// conjunction with other keys to create a key grab. If the given keycode is
        /// already mapped, then this function will return the modifier that is
        /// currently mapped to the keycode, without doing anything else. Otherwise,
        /// it will use the last modifier that AT-SPI used to map a key. If no keys
        /// have yet been mapped using this device, then it will look for a modifier
        /// that is not currently being used. If no unused modifier can be found,
        /// then it will use the first modifier by default.
        pub const map_modifier = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keycode: c_int) c_uint {
                return gobject.ext.as(Device.Class, p_class).f_map_modifier.?(gobject.ext.as(Device, p_device), p_keycode);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keycode: c_int) callconv(.c) c_uint) void {
                gobject.ext.as(Device.Class, p_class).f_map_modifier = @ptrCast(p_implementation);
            }
        };

        /// Removes the key grab specified by `id`.
        pub const remove_key_grab = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_id: c_uint) void {
                return gobject.ext.as(Device.Class, p_class).f_remove_key_grab.?(gobject.ext.as(Device, p_device), p_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_id: c_uint) callconv(.c) void) void {
                gobject.ext.as(Device.Class, p_class).f_remove_key_grab = @ptrCast(p_implementation);
            }
        };

        /// Removes a keyboard grab added via a call to atspi_device_add_keyboard.
        pub const ungrab_keyboard = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Device.Class, p_class).f_ungrab_keyboard.?(gobject.ext.as(Device, p_device));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Device.Class, p_class).f_ungrab_keyboard = @ptrCast(p_implementation);
            }
        };

        /// Removes a mapped modifier from the given keysym.
        pub const unmap_keysym_modifier = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keysym: c_uint) void {
                return gobject.ext.as(Device.Class, p_class).f_unmap_keysym_modifier.?(gobject.ext.as(Device, p_device), p_keysym);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keysym: c_uint) callconv(.c) void) void {
                gobject.ext.as(Device.Class, p_class).f_unmap_keysym_modifier = @ptrCast(p_implementation);
            }
        };

        /// Removes a mapped modifier from the given keycode.
        pub const unmap_modifier = struct {
            pub fn call(p_class: anytype, p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keycode: c_int) void {
                return gobject.ext.as(Device.Class, p_class).f_unmap_modifier.?(gobject.ext.as(Device, p_device), p_keycode);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_device: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_keycode: c_int) callconv(.c) void) void {
                gobject.ext.as(Device.Class, p_class).f_unmap_modifier = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The application ID of the application that created this device.
        /// The ID might be used for access control purposes
        /// by some device backends.
        pub const app_id = struct {
            pub const name = "app-id";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `atspi.Device`.
    extern fn atspi_device_new() *atspi.Device;
    pub const new = atspi_device_new;

    /// Creates a new `atspi.Device` with a specified app id.
    extern fn atspi_device_new_full(p_app_id: ?[*:0]const u8) *atspi.Device;
    pub const newFull = atspi_device_new_full;

    extern fn atspi_device_add_key_grab(p_device: *Device, p_kd: *atspi.KeyDefinition, p_callback: ?atspi.KeyCallback, p_user_data: ?*anyopaque, p_callback_destroyed: ?glib.DestroyNotify) c_uint;
    pub const addKeyGrab = atspi_device_add_key_grab;

    /// Add a callback that will receive a notification whenever a key is
    /// pressed or released.
    extern fn atspi_device_add_key_watcher(p_device: *Device, p_callback: atspi.KeyCallback, p_user_data: ?*anyopaque, p_callback_destroyed: ?glib.DestroyNotify) void;
    pub const addKeyWatcher = atspi_device_add_key_watcher;

    /// Synthesizes a mouse event at a specific screen coordinate.
    /// Most AT clients should use the `AccessibleAction` interface when
    /// tempted to generate mouse events, rather than this method.
    /// Event names: b1p = button 1 press; b2r = button 2 release;
    ///              b3c = button 3 click; b2d = button 2 double-click;
    ///              abs = absolute motion; rel = relative motion.
    extern fn atspi_device_generate_mouse_event(p_device: *Device, p_obj: *atspi.Accessible, p_x: c_int, p_y: c_int, p_name: [*:0]const u8, p_error: ?*?*glib.Error) void;
    pub const generateMouseEvent = atspi_device_generate_mouse_event;

    /// Returns the application ID of the device.
    extern fn atspi_device_get_app_id(p_device: *Device) [*:0]const u8;
    pub const getAppId = atspi_device_get_app_id;

    extern fn atspi_device_get_grab_by_id(p_device: *Device, p_id: c_uint) *atspi.KeyDefinition;
    pub const getGrabById = atspi_device_get_grab_by_id;

    /// Gets the modifier for a given keysym, if one exists. Does not create a new
    /// mapping. This function should be used when the intention is to query a
    /// locking modifier such as num lock via atspi_device_get_locked_modifiers,
    /// rather than to add key grabs.
    extern fn atspi_device_get_keysym_modifier(p_device: *Device, p_keysym: c_uint) c_uint;
    pub const getKeysymModifier = atspi_device_get_keysym_modifier;

    /// Returns the locked modifiers (ie, num lock, caps lock) associated with this
    /// keyboard.
    extern fn atspi_device_get_locked_modifiers(p_device: *Device) c_uint;
    pub const getLockedModifiers = atspi_device_get_locked_modifiers;

    /// Gets the modifier for a given keycode, if one exists. Does not create a new
    /// mapping. This function should be used when the intention is to query a
    /// locking modifier such as num lock via atspi_device_get_locked_modifiers,
    /// rather than to add key grabs.
    extern fn atspi_device_get_modifier(p_device: *Device, p_keycode: c_int) c_uint;
    pub const getModifier = atspi_device_get_modifier;

    /// Attempts to grab the entire keyboard. This should only be done
    /// temporarily, as it may conflict with other applications that also want to
    /// grab the keyboard.
    extern fn atspi_device_grab_keyboard(p_device: *Device) c_int;
    pub const grabKeyboard = atspi_device_grab_keyboard;

    /// Maps the specified keysym to a modifier so that it can be used in
    /// conjunction with other keys to create a key grab. If the given keysym is
    /// already mapped, then this function will return the modifier that is
    /// currently mapped to the keysym, without doing anything else. Otherwise,
    /// it will use the last modifier that AT-SPI used to map a keysym. If no keys
    /// have yet been mapped using this device, then it will look for a modifier
    /// that is not currently being used. If no unused modifier can be found,
    /// then it will use the first modifier by default.
    extern fn atspi_device_map_keysym_modifier(p_device: *Device, p_keysym: c_uint) c_uint;
    pub const mapKeysymModifier = atspi_device_map_keysym_modifier;

    /// Maps the specified key code to a modifier so that it can be used in
    /// conjunction with other keys to create a key grab. If the given keycode is
    /// already mapped, then this function will return the modifier that is
    /// currently mapped to the keycode, without doing anything else. Otherwise,
    /// it will use the last modifier that AT-SPI used to map a key. If no keys
    /// have yet been mapped using this device, then it will look for a modifier
    /// that is not currently being used. If no unused modifier can be found,
    /// then it will use the first modifier by default.
    extern fn atspi_device_map_modifier(p_device: *Device, p_keycode: c_int) c_uint;
    pub const mapModifier = atspi_device_map_modifier;

    extern fn atspi_device_notify_key(p_device: *Device, p_pressed: c_int, p_keycode: c_int, p_keysym: c_int, p_state: c_int, p_text: [*:0]const u8) c_int;
    pub const notifyKey = atspi_device_notify_key;

    /// Removes the key grab specified by `id`.
    extern fn atspi_device_remove_key_grab(p_device: *Device, p_id: c_uint) void;
    pub const removeKeyGrab = atspi_device_remove_key_grab;

    /// Sets the application ID of the device.
    extern fn atspi_device_set_app_id(p_device: *Device, p_app_id: [*:0]const u8) void;
    pub const setAppId = atspi_device_set_app_id;

    /// Removes a keyboard grab added via a call to atspi_device_add_keyboard.
    extern fn atspi_device_ungrab_keyboard(p_device: *Device) void;
    pub const ungrabKeyboard = atspi_device_ungrab_keyboard;

    /// Removes a mapped modifier from the given keysym.
    extern fn atspi_device_unmap_keysym_modifier(p_device: *Device, p_keysym: c_uint) void;
    pub const unmapKeysymModifier = atspi_device_unmap_keysym_modifier;

    /// Removes a mapped modifier from the given keycode.
    extern fn atspi_device_unmap_modifier(p_device: *Device, p_keycode: c_int) void;
    pub const unmapModifier = atspi_device_unmap_modifier;

    extern fn atspi_device_get_type() usize;
    pub const getGObjectType = atspi_device_get_type;

    extern fn g_object_ref(p_self: *atspi.Device) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Device) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Device, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceA11yManager = opaque {
    pub const Parent = atspi.Device;
    pub const Implements = [_]type{};
    pub const Class = atspi.DeviceA11yManagerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const keyboard_monitor = struct {
            pub const name = "keyboard-monitor";

            pub const Type = @compileError("no type information available");
        };

        pub const session_bus = struct {
            pub const name = "session-bus";

            pub const Type = @compileError("no type information available");
        };
    };

    pub const signals = struct {};

    /// Tries to create a new `atspi.DeviceA11yManager`.
    extern fn atspi_device_a11y_manager_try_new() *atspi.DeviceA11yManager;
    pub const tryNew = atspi_device_a11y_manager_try_new;

    extern fn atspi_device_a11y_manager_try_new_full(p_app_id: ?[*:0]const u8) *atspi.DeviceA11yManager;
    pub const tryNewFull = atspi_device_a11y_manager_try_new_full;

    extern fn atspi_device_a11y_manager_get_type() usize;
    pub const getGObjectType = atspi_device_a11y_manager_get_type;

    extern fn g_object_ref(p_self: *atspi.DeviceA11yManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.DeviceA11yManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DeviceA11yManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceLegacy = extern struct {
    pub const Parent = atspi.Device;
    pub const Implements = [_]type{};
    pub const Class = atspi.DeviceLegacyClass;
    f_parent: atspi.Device,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `atspi.DeviceLegacy`.
    extern fn atspi_device_legacy_new() *atspi.DeviceLegacy;
    pub const new = atspi_device_legacy_new;

    /// Creates a new `atspi.DeviceLegacy` with the given app id.
    extern fn atspi_device_legacy_new_full(p_app_id: ?[*:0]const u8) *atspi.DeviceLegacy;
    pub const newFull = atspi_device_legacy_new_full;

    extern fn atspi_device_legacy_get_type() usize;
    pub const getGObjectType = atspi_device_legacy_get_type;

    extern fn g_object_ref(p_self: *atspi.DeviceLegacy) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.DeviceLegacy) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DeviceLegacy, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceListener = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.DeviceListenerClass;
    f_parent: gobject.Object,
    f_id: c_uint,
    f_callbacks: ?*glib.List,

    pub const virtual_methods = struct {
        pub const device_event = struct {
            pub fn call(p_class: anytype, p_listener: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_event: *const atspi.DeviceEvent) c_int {
                return gobject.ext.as(DeviceListener.Class, p_class).f_device_event.?(gobject.ext.as(DeviceListener, p_listener), p_event);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_listener: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_event: *const atspi.DeviceEvent) callconv(.c) c_int) void {
                gobject.ext.as(DeviceListener.Class, p_class).f_device_event = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `atspi.DeviceListener` with a specified callback function.
    extern fn atspi_device_listener_new(p_callback: ?atspi.DeviceListenerCB, p_user_data: ?*anyopaque, p_callback_destroyed: ?glib.DestroyNotify) *atspi.DeviceListener;
    pub const new = atspi_device_listener_new;

    /// Creates a new `atspi.DeviceListener` with a specified callback function.
    /// This method is similar to `atspi.DeviceListener.new`, but callback
    /// takes no user data.
    extern fn atspi_device_listener_new_simple(p_callback: atspi.DeviceListenerSimpleCB, p_callback_destroyed: ?glib.DestroyNotify) *atspi.DeviceListener;
    pub const newSimple = atspi_device_listener_new_simple;

    /// Adds an in-process callback function to an existing `atspi.DeviceListener`.
    extern fn atspi_device_listener_add_callback(p_listener: *DeviceListener, p_callback: atspi.DeviceListenerCB, p_callback_destroyed: ?glib.DestroyNotify, p_user_data: ?*anyopaque) void;
    pub const addCallback = atspi_device_listener_add_callback;

    /// Removes an in-process callback function from an existing
    /// `atspi.DeviceListener`.
    extern fn atspi_device_listener_remove_callback(p_listener: *DeviceListener, p_callback: atspi.DeviceListenerCB) void;
    pub const removeCallback = atspi_device_listener_remove_callback;

    extern fn atspi_device_listener_get_type() usize;
    pub const getGObjectType = atspi_device_listener_get_type;

    extern fn g_object_ref(p_self: *atspi.DeviceListener) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.DeviceListener) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DeviceListener, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceX11 = extern struct {
    pub const Parent = atspi.Device;
    pub const Implements = [_]type{};
    pub const Class = atspi.DeviceX11Class;
    f_parent: atspi.Device,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `atspi.DeviceX11`.
    extern fn atspi_device_x11_new() *atspi.DeviceX11;
    pub const new = atspi_device_x11_new;

    /// Creates a new `atspi.DeviceX11` with the given app id.
    extern fn atspi_device_x11_new_full(p_app_id: ?[*:0]const u8) *atspi.DeviceX11;
    pub const newFull = atspi_device_x11_new_full;

    extern fn atspi_device_x11_get_type() usize;
    pub const getGObjectType = atspi_device_x11_get_type;

    extern fn g_object_ref(p_self: *atspi.DeviceX11) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.DeviceX11) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DeviceX11, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A generic interface implemented by objects for the receipt of event
/// notifications.
///
/// A generic interface implemented by objects for the receipt of event
/// notifications. atspi-event-listener is the interface via which clients of
/// the atspi-registry receive notification of changes to an application's user
/// interface and content.
pub const EventListener = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.EventListenerClass;
    f_parent: gobject.Object,
    f_callback: ?atspi.EventListenerCB,
    f_user_data: ?*anyopaque,
    f_cb_destroyed: ?glib.DestroyNotify,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Deregisters an `atspi.EventListenerCB` from the registry, for a specific
    /// event type.
    extern fn atspi_event_listener_deregister_from_callback(p_callback: atspi.EventListenerCB, p_user_data: ?*anyopaque, p_event_type: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const deregisterFromCallback = atspi_event_listener_deregister_from_callback;

    /// deregisters an `atspi.EventListenerSimpleCB` from the registry, for a specific
    ///             event type.
    extern fn atspi_event_listener_deregister_no_data(p_callback: atspi.EventListenerSimpleCB, p_event_type: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const deregisterNoData = atspi_event_listener_deregister_no_data;

    /// Registers an `atspi.EventListenerCB` against an `event_type`.
    extern fn atspi_event_listener_register_from_callback(p_callback: atspi.EventListenerCB, p_user_data: ?*anyopaque, p_callback_destroyed: ?glib.DestroyNotify, p_event_type: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const registerFromCallback = atspi_event_listener_register_from_callback;

    extern fn atspi_event_listener_register_from_callback_full(p_callback: atspi.EventListenerCB, p_user_data: ?*anyopaque, p_callback_destroyed: ?glib.DestroyNotify, p_event_type: [*:0]const u8, p_properties: *glib.Array, p_error: ?*?*glib.Error) c_int;
    pub const registerFromCallbackFull = atspi_event_listener_register_from_callback_full;

    extern fn atspi_event_listener_register_from_callback_with_app(p_callback: atspi.EventListenerCB, p_user_data: ?*anyopaque, p_callback_destroyed: ?glib.DestroyNotify, p_event_type: [*:0]const u8, p_properties: *glib.Array, p_app: ?*atspi.Accessible, p_error: ?*?*glib.Error) c_int;
    pub const registerFromCallbackWithApp = atspi_event_listener_register_from_callback_with_app;

    /// Registers an `AtspiEventListenetSimpleCB`. The method is similar to
    /// `atspi.EventListener.register`, but `callback` takes no user_data.
    extern fn atspi_event_listener_register_no_data(p_callback: atspi.EventListenerSimpleCB, p_callback_destroyed: ?glib.DestroyNotify, p_event_type: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const registerNoData = atspi_event_listener_register_no_data;

    /// Creates a new `atspi.EventListener` associated with a specified `callback`.
    extern fn atspi_event_listener_new(p_callback: atspi.EventListenerCB, p_user_data: ?*anyopaque, p_callback_destroyed: ?glib.DestroyNotify) *atspi.EventListener;
    pub const new = atspi_event_listener_new;

    /// Creates a new `atspi.EventListener` associated with a specified `callback`.
    extern fn atspi_event_listener_new_simple(p_callback: atspi.EventListenerSimpleCB, p_callback_destroyed: ?glib.DestroyNotify) *atspi.EventListener;
    pub const newSimple = atspi_event_listener_new_simple;

    /// Deregisters an `atspi.EventListener` from the registry, for a specific
    ///             event type.
    extern fn atspi_event_listener_deregister(p_listener: *EventListener, p_event_type: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const deregister = atspi_event_listener_deregister;

    /// Adds an in-process callback function to an existing `atspi.EventListener`.
    ///
    /// Legal object event types:
    ///
    ///    (property change events)
    ///
    ///            object:property-change
    ///            object:property-change:accessible-name
    ///            object:property-change:accessible-description
    ///            object:property-change:accessible-help-text
    ///            object:property-change:accessible-parent
    ///            object:property-change:accessible-value
    ///            object:property-change:accessible-role
    ///            object:property-change:accessible-table-caption
    ///            object:property-change:accessible-table-column-description
    ///            object:property-change:accessible-table-column-header
    ///            object:property-change:accessible-table-row-description
    ///            object:property-change:accessible-table-row-header
    ///            object:property-change:accessible-table-summary
    ///
    ///    (other object events)
    ///
    ///            object:state-changed
    ///            object:children-changed
    ///            object:visible-data-changed
    ///            object:selection-changed
    ///            object:text-selection-changed
    ///            object:text-changed
    ///            object:text-caret-moved
    ///            object:row-inserted
    ///            object:row-reordered
    ///            object:row-deleted
    ///            object:column-inserted
    ///            object:column-reordered
    ///            object:column-deleted
    ///            object:model-changed
    ///            object:active-descendant-changed
    ///            object:announcement
    ///
    ///  (screen reader events)
    ///             screen-reader:region-changed
    ///
    ///  (window events)
    ///
    ///            window:minimize
    ///            window:maximize
    ///            window:restore
    ///            window:close
    ///            window:create
    ///            window:reparent
    ///            window:desktop-create
    ///            window:desktop-destroy
    ///            window:activate
    ///            window:deactivate
    ///            window:raise
    ///            window:lower
    ///            window:move
    ///            window:resize
    ///            window:shade
    ///            window:unshade
    ///            window:restyle
    ///
    ///  (other events)
    ///
    ///            focus:
    ///            mouse:abs
    ///            mouse:rel
    ///            mouse:b1p
    ///            mouse:b1r
    ///            mouse:b2p
    ///            mouse:b2r
    ///            mouse:b3p
    ///            mouse:b3r
    ///
    /// NOTE: this character string may be UTF-8, but should not contain byte
    /// value 56
    ///            (ascii ':'), except as a delimiter, since non-UTF-8 string
    ///            delimiting functions are used internally.
    ///            In general, listening to
    ///            toolkit-specific events is not recommended.
    ///
    /// Currently, object:text-reading-position needs to be specified explicitly
    /// (it is not implied by object:text), since it is generated by the screen
    /// reader and is thus a special case internally.
    extern fn atspi_event_listener_register(p_listener: *EventListener, p_event_type: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const register = atspi_event_listener_register;

    /// Adds an in-process callback function to an existing `atspi.EventListener`.
    extern fn atspi_event_listener_register_full(p_listener: *EventListener, p_event_type: [*:0]const u8, p_properties: ?*glib.Array, p_error: ?*?*glib.Error) c_int;
    pub const registerFull = atspi_event_listener_register_full;

    /// Adds an in-process callback function to an existing `atspi.EventListener`.
    extern fn atspi_event_listener_register_with_app(p_listener: *EventListener, p_event_type: [*:0]const u8, p_properties: ?*glib.Array, p_app: ?*atspi.Accessible, p_error: ?*?*glib.Error) c_int;
    pub const registerWithApp = atspi_event_listener_register_with_app;

    extern fn atspi_event_listener_get_type() usize;
    pub const getGObjectType = atspi_event_listener_get_type;

    extern fn g_object_ref(p_self: *atspi.EventListener) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.EventListener) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EventListener, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Instances of atspi-hyperlink are the means by which end users
/// and clients interact with linked content.
///
///  Instances of atspi-hyperlink are returned by
/// atspi-hypertext objects, and are the means by
/// which end users and clients interact with linked,
/// and in some cases embedded, content. These instances
/// may have multiple "anchors", where an anchor corresponds to a
/// reference to a particular resource with a corresponding resource
/// identified (URI).
pub const Hyperlink = extern struct {
    pub const Parent = atspi.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.HyperlinkClass;
    f_parent: atspi.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the ending character offset of the text range associated with
    ///       an `atspi.Hyperlink`, in its originating `atspi.Hypertext`.
    extern fn atspi_hyperlink_get_end_index(p_obj: *Hyperlink, p_error: ?*?*glib.Error) c_int;
    pub const getEndIndex = atspi_hyperlink_get_end_index;

    /// Gets the starting and ending character offsets of the text range
    /// associated with an `atspi.Hyperlink`, in its originating `atspi.Hypertext`.
    extern fn atspi_hyperlink_get_index_range(p_obj: *Hyperlink, p_error: ?*?*glib.Error) ?*atspi.Range;
    pub const getIndexRange = atspi_hyperlink_get_index_range;

    /// Gets the total number of anchors which an `atspi.Hyperlink` implementor has.
    /// Though typical hyperlinks have only one anchor, client-side image maps and
    /// other hypertext objects may potentially activate or refer to multiple
    /// URIs.  For each anchor there is a corresponding URI and object.
    ///
    /// see: `atspi.Hyperlink.getUri` and `atspi.Hyperlink.getObject`.
    extern fn atspi_hyperlink_get_n_anchors(p_obj: *Hyperlink, p_error: ?*?*glib.Error) c_int;
    pub const getNAnchors = atspi_hyperlink_get_n_anchors;

    /// Gets the object associated with a particular hyperlink anchor, as an
    /// `atspi.Accessible`.
    extern fn atspi_hyperlink_get_object(p_obj: *Hyperlink, p_i: c_int, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getObject = atspi_hyperlink_get_object;

    /// Gets the starting character offset of the text range associated with
    ///       an `atspi.Hyperlink`, in its originating `atspi.Hypertext`.
    extern fn atspi_hyperlink_get_start_index(p_obj: *Hyperlink, p_error: ?*?*glib.Error) c_int;
    pub const getStartIndex = atspi_hyperlink_get_start_index;

    /// Gets the URI associated with a particular hyperlink anchor.
    extern fn atspi_hyperlink_get_uri(p_obj: *Hyperlink, p_i: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getUri = atspi_hyperlink_get_uri;

    /// Tells whether an `atspi.Hyperlink` object is still valid with respect to its
    ///          originating hypertext object.
    extern fn atspi_hyperlink_is_valid(p_obj: *Hyperlink, p_error: ?*?*glib.Error) c_int;
    pub const isValid = atspi_hyperlink_is_valid;

    extern fn atspi_hyperlink_get_type() usize;
    pub const getGObjectType = atspi_hyperlink_get_type;

    extern fn g_object_ref(p_self: *atspi.Hyperlink) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Hyperlink) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Hyperlink, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface that allows the definition of match rules
/// for accessible objects.
pub const MatchRule = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.MatchRuleClass;
    f_parent: gobject.Object,
    f_states: ?*atspi.StateSet,
    f_statematchtype: atspi.CollectionMatchType,
    f_attributes: ?*glib.HashTable,
    f_attributematchtype: atspi.CollectionMatchType,
    f_interfaces: ?*glib.Array,
    f_interfacematchtype: atspi.CollectionMatchType,
    f_roles: [4]c_int,
    f_rolematchtype: atspi.CollectionMatchType,
    f_invert: c_int,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `atspi.MatchRule` with specified `states`, `attributes`,
    /// `interfaces`, and `roles`.
    extern fn atspi_match_rule_new(p_states: ?*atspi.StateSet, p_statematchtype: atspi.CollectionMatchType, p_attributes: ?*glib.HashTable, p_attributematchtype: atspi.CollectionMatchType, p_roles: ?*glib.Array, p_rolematchtype: atspi.CollectionMatchType, p_interfaces: ?*glib.Array, p_interfacematchtype: atspi.CollectionMatchType, p_invert: c_int) *atspi.MatchRule;
    pub const new = atspi_match_rule_new;

    extern fn atspi_match_rule_get_type() usize;
    pub const getGObjectType = atspi_match_rule_get_type;

    extern fn g_object_ref(p_self: *atspi.MatchRule) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.MatchRule) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MatchRule, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Object = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.ObjectClass;
    f_parent: gobject.Object,
    f_app: ?*atspi.Application,
    f_path: ?[*:0]u8,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn atspi_object_get_type() usize;
    pub const getGObjectType = atspi_object_get_type;

    extern fn g_object_ref(p_self: *atspi.Object) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Object) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Object, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface via which non-hierarchical relationships
/// are indicated.
///
/// An interface via which non-hierarchical relationships
/// are indicated. An instance of this interface represents
/// a "one-to-many" correspondence.
pub const Relation = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.RelationClass;
    f_parent: gobject.Object,
    f_relation_type: atspi.RelationType,
    f_targets: ?*glib.Array,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the number of objects which this relationship has as its
    ///       target objects (the subject is the `atspi.Accessible` from which this
    ///       `atspi.Relation` originated).
    extern fn atspi_relation_get_n_targets(p_obj: *Relation) c_int;
    pub const getNTargets = atspi_relation_get_n_targets;

    /// Gets the type of relationship represented by an `atspi.Relation`.
    extern fn atspi_relation_get_relation_type(p_obj: *Relation) atspi.RelationType;
    pub const getRelationType = atspi_relation_get_relation_type;

    /// Gets the `i`-th target of a specified `atspi.Relation` relationship.
    extern fn atspi_relation_get_target(p_obj: *Relation, p_i: c_int) *atspi.Accessible;
    pub const getTarget = atspi_relation_get_target;

    extern fn atspi_relation_get_type() usize;
    pub const getGObjectType = atspi_relation_get_type;

    extern fn g_object_ref(p_self: *atspi.Relation) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Relation) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Relation, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The atspi-stateset objects implement wrappers around a
/// bitmap of accessible states.
pub const StateSet = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atspi.StateSetClass;
    f_parent: gobject.Object,
    f_accessible: ?*anyopaque,
    f_states: i64,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Generates an `atspi.StateSet` with the given `states`.
    extern fn atspi_state_set_new(p_states: *glib.Array) *atspi.StateSet;
    pub const new = atspi_state_set_new;

    /// Adds a particular `AtspiState` to an `atspi.StateSet` (i.e. sets the
    ///       given state to `TRUE` in the stateset).
    extern fn atspi_state_set_add(p_set: *StateSet, p_state: atspi.StateType) void;
    pub const add = atspi_state_set_add;

    /// Determines the differences between two instances of `atspi.StateSet`.
    ///
    /// `see` `atspi.StateSet.equals`.
    extern fn atspi_state_set_compare(p_set: *StateSet, p_set2: *atspi.StateSet) *atspi.StateSet;
    pub const compare = atspi_state_set_compare;

    /// Determines whether a given `atspi.StateSet` includes a given state; that is,
    ///          whether `state` is true for the `set` in question.
    extern fn atspi_state_set_contains(p_set: *StateSet, p_state: atspi.StateType) c_int;
    pub const contains = atspi_state_set_contains;

    /// Determines whether two instances of `atspi.StateSet` are equivalent (i.e.
    ///          consist of the same `AtspiStates`).  Useful for checking multiple
    ///          state variables at once.
    ///
    /// `see` `atspi.StateSet.compare`.
    extern fn atspi_state_set_equals(p_set: *StateSet, p_set2: *atspi.StateSet) c_int;
    pub const equals = atspi_state_set_equals;

    /// Returns the states in an `atspi.StateSet` as an array.
    extern fn atspi_state_set_get_states(p_set: *StateSet) *glib.Array;
    pub const getStates = atspi_state_set_get_states;

    extern fn atspi_state_set_is_empty(p_set: *StateSet) c_int;
    pub const isEmpty = atspi_state_set_is_empty;

    /// Removes a particular `AtspiState` to an `atspi.StateSet` (i.e. sets the
    ///       given state to `FALSE` in the stateset.)
    extern fn atspi_state_set_remove(p_set: *StateSet, p_state: atspi.StateType) void;
    pub const remove = atspi_state_set_remove;

    /// Enables/disables a state in an `atspi.StateSet` according to its `name`.
    extern fn atspi_state_set_set_by_name(p_set: *StateSet, p_name: [*:0]const u8, p_enabled: c_int) void;
    pub const setByName = atspi_state_set_set_by_name;

    extern fn atspi_state_set_get_type() usize;
    pub const getGObjectType = atspi_state_set_get_type;

    extern fn g_object_ref(p_self: *atspi.StateSet) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.StateSet) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StateSet, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Action = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Action;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Invoke the action indicated by `index`.
    extern fn atspi_action_do_action(p_obj: *Action, p_i: c_int, p_error: ?*?*glib.Error) c_int;
    pub const doAction = atspi_action_do_action;

    /// Get the description of '`i`-th' action invocable on an
    ///      object implementing `atspi.Action`.
    extern fn atspi_action_get_action_description(p_obj: *Action, p_i: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getActionDescription = atspi_action_get_action_description;

    /// Get the name of the '`i`-th' action invocable on an
    ///      object implementing `atspi.Action`.
    extern fn atspi_action_get_action_name(p_obj: *Action, p_i: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getActionName = atspi_action_get_action_name;

    /// Get the description of '`i`-th' action invocable on an
    ///      object implementing `atspi.Action`.
    extern fn atspi_action_get_description(p_obj: *Action, p_i: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getDescription = atspi_action_get_description;

    /// Get the keybindings for the `i`-th action invocable on an
    ///      object implementing `atspi.Action`, if any are defined.
    ///      The keybindings string format is as follows:
    ///        there are multiple parts to a keybinding string (typically 3).
    ///        They are delimited with ";".  The first is the action's
    ///        keybinding which is usable if the object implementing the action
    ///        is currently posted to the screen, e.g. if a menu is posted
    ///        then these keybindings for the corresponding menu-items are
    ///        available.  The second keybinding substring is the full key sequence
    ///        necessary to post the action's widget and activate it, e.g. for
    ///        a menu item such as "File->Open" it would both post the menu and
    ///        activate the item.  Thus the second keybinding string is available
    ///        during the lifetime of the containing toplevel window as a whole,
    ///        whereas the first keybinding string only works while the object
    ///        implementing AtkAction is posted.  The third (and optional)
    ///        keybinding string is the "keyboard shortcut" which invokes the
    ///        action without posting any menus.
    ///        Meta-keys are indicated by the conventional strings
    ///        "&lt;Control&gt;", "&lt;Alt&gt;", "&lt;Shift&gt;", "&lt;Mod2&gt;",
    ///        etc. (we use the same string as `gtk_accelerator_name` in
    ///        gtk+-2.X.
    extern fn atspi_action_get_key_binding(p_obj: *Action, p_i: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getKeyBinding = atspi_action_get_key_binding;

    /// Get the name of the '`i`-th' action invocable on an
    ///      object implementing `atspi.Action`.
    extern fn atspi_action_get_localized_name(p_obj: *Action, p_i: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getLocalizedName = atspi_action_get_localized_name;

    /// Get the number of actions invokable on an `atspi.Action` implementor.
    extern fn atspi_action_get_n_actions(p_obj: *Action, p_error: ?*?*glib.Error) c_int;
    pub const getNActions = atspi_action_get_n_actions;

    /// Get the name of the '`i`-th' action invocable on an
    ///      object implementing `atspi.Action`.
    extern fn atspi_action_get_name(p_obj: *Action, p_i: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getName = atspi_action_get_name;

    extern fn atspi_action_get_type() usize;
    pub const getGObjectType = atspi_action_get_type;

    extern fn g_object_ref(p_self: *atspi.Action) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Action) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Action, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface designed to allow accessibles which satisfy a set of
/// criteria to be returned.
///
/// An interface designed to allow accessibles which satisfy a set of
/// criteria to be returned. This interface can be used to avoid iteration
/// or client-side search of the object tree.
pub const Collection = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Collection;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn atspi_collection_get_active_descendant(p_collection: *Collection, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getActiveDescendant = atspi_collection_get_active_descendant;

    /// Gets all `atspi.Accessible` objects from the `collection` matching a given
    /// `rule`.
    extern fn atspi_collection_get_matches(p_collection: *Collection, p_rule: *atspi.MatchRule, p_sortby: atspi.CollectionSortOrder, p_count: c_int, p_traverse: c_int, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getMatches = atspi_collection_get_matches;

    /// Gets all `atspi.Accessible` objects from the `collection`, before
    /// `current_object`, matching a given `rule`.
    extern fn atspi_collection_get_matches_from(p_collection: *Collection, p_current_object: *atspi.Accessible, p_rule: *atspi.MatchRule, p_sortby: atspi.CollectionSortOrder, p_tree: atspi.CollectionTreeTraversalType, p_count: c_int, p_traverse: c_int, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getMatchesFrom = atspi_collection_get_matches_from;

    /// Gets all `atspi.Accessible` objects from the `collection`, after
    /// `current_object`, matching a given `rule`.
    extern fn atspi_collection_get_matches_to(p_collection: *Collection, p_current_object: *atspi.Accessible, p_rule: *atspi.MatchRule, p_sortby: atspi.CollectionSortOrder, p_tree: atspi.CollectionTreeTraversalType, p_limit_scope: c_int, p_count: c_int, p_traverse: c_int, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getMatchesTo = atspi_collection_get_matches_to;

    /// Not yet implemented.
    extern fn atspi_collection_is_ancestor_of(p_collection: *Collection, p_test: *atspi.Accessible, p_error: ?*?*glib.Error) c_int;
    pub const isAncestorOf = atspi_collection_is_ancestor_of;

    extern fn atspi_collection_get_type() usize;
    pub const getGObjectType = atspi_collection_get_type;

    extern fn g_object_ref(p_self: *atspi.Collection) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Collection) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Collection, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface implemented by objects which have onscreen visual
/// representations.
///
/// The Component interface is implemented by objects which occupy on-screen
/// space, e.g. objects which have onscreen visual representations. The methods
/// in Component allow clients to identify where the objects lie in the onscreen
/// coordinate system, their relative size, stacking order, and position. It
/// also provides a mechanism whereby keyboard focus may be transferred to
/// specific user interface elements programmatically.  This is a 2D API.
/// Coordinates of 3D objects are projected into the 2-dimensional screen view
/// for purposes of this interface.
pub const Component = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Component;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Queries whether a given `atspi.Component` contains a particular point.
    extern fn atspi_component_contains(p_obj: *Component, p_x: c_int, p_y: c_int, p_ctype: atspi.CoordType, p_error: ?*?*glib.Error) c_int;
    pub const contains = atspi_component_contains;

    /// Gets the accessible child at a given coordinate within an `atspi.Component`.
    extern fn atspi_component_get_accessible_at_point(p_obj: *Component, p_x: c_int, p_y: c_int, p_ctype: atspi.CoordType, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getAccessibleAtPoint = atspi_component_get_accessible_at_point;

    /// Gets the opacity/alpha value of a component, if alpha blending is in use.
    extern fn atspi_component_get_alpha(p_obj: *Component, p_error: ?*?*glib.Error) f64;
    pub const getAlpha = atspi_component_get_alpha;

    /// Gets the bounding box of the specified `atspi.Component`.
    /// The returned values are meaningful only if the Component has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_component_get_extents(p_obj: *Component, p_ctype: atspi.CoordType, p_error: ?*?*glib.Error) ?*atspi.Rect;
    pub const getExtents = atspi_component_get_extents;

    /// Queries which layer the component is painted into, to help determine its
    ///      visibility in terms of stacking order.
    extern fn atspi_component_get_layer(p_obj: *Component, p_error: ?*?*glib.Error) atspi.ComponentLayer;
    pub const getLayer = atspi_component_get_layer;

    /// Queries the z stacking order of a component which is in the MDI or window
    ///       layer. (Bigger z-order numbers mean nearer the top)
    extern fn atspi_component_get_mdi_z_order(p_obj: *Component, p_error: ?*?*glib.Error) c_short;
    pub const getMdiZOrder = atspi_component_get_mdi_z_order;

    /// Gets the minimum x and y coordinates of the specified `atspi.Component`.
    /// The returned values are meaningful only if the Component has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_component_get_position(p_obj: *Component, p_ctype: atspi.CoordType, p_error: ?*?*glib.Error) ?*atspi.Point;
    pub const getPosition = atspi_component_get_position;

    /// Gets the size of the specified `atspi.Component`.
    /// The returned values are meaningful only if the Component has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_component_get_size(p_obj: *Component, p_error: ?*?*glib.Error) ?*atspi.Point;
    pub const getSize = atspi_component_get_size;

    /// Attempts to set the keyboard input focus to the specified
    ///         `atspi.Component`.
    extern fn atspi_component_grab_focus(p_obj: *Component, p_error: ?*?*glib.Error) c_int;
    pub const grabFocus = atspi_component_grab_focus;

    /// Scrolls whatever container of the `atspi.Component` object so it becomes
    /// visible on the screen.
    extern fn atspi_component_scroll_to(p_obj: *Component, p_type: atspi.ScrollType, p_error: ?*?*glib.Error) c_int;
    pub const scrollTo = atspi_component_scroll_to;

    /// Scrolls whatever container of the `atspi.Component` object so it becomes
    /// visible on the screen at a given position.
    extern fn atspi_component_scroll_to_point(p_obj: *Component, p_coords: atspi.CoordType, p_x: c_int, p_y: c_int, p_error: ?*?*glib.Error) c_int;
    pub const scrollToPoint = atspi_component_scroll_to_point;

    /// Moves and resizes the specified component.
    extern fn atspi_component_set_extents(p_obj: *Component, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_ctype: atspi.CoordType, p_error: ?*?*glib.Error) c_int;
    pub const setExtents = atspi_component_set_extents;

    /// Moves the component to the specified position.
    extern fn atspi_component_set_position(p_obj: *Component, p_x: c_int, p_y: c_int, p_ctype: atspi.CoordType, p_error: ?*?*glib.Error) c_int;
    pub const setPosition = atspi_component_set_position;

    /// Resizes the specified component to the given pixel dimensions.
    extern fn atspi_component_set_size(p_obj: *Component, p_width: c_int, p_height: c_int, p_error: ?*?*glib.Error) c_int;
    pub const setSize = atspi_component_set_size;

    extern fn atspi_component_get_type() usize;
    pub const getGObjectType = atspi_component_get_type;

    extern fn g_object_ref(p_self: *atspi.Component) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Component) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Component, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Document = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Document;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the value of a single attribute, if specified for the document as a whole.
    extern fn atspi_document_get_attribute_value(p_obj: *Document, p_attribute: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getAttributeValue = atspi_document_get_attribute_value;

    /// Gets all constant attributes for the document as a whole. For attributes
    /// that change within the document content, see `atspi_text_get_attribute_run` instead.
    extern fn atspi_document_get_attributes(p_obj: *Document, p_error: ?*?*glib.Error) ?*glib.HashTable;
    pub const getAttributes = atspi_document_get_attributes;

    /// Gets the current page number of an `AccessibleDocument` object.
    extern fn atspi_document_get_current_page_number(p_obj: *Document, p_error: ?*?*glib.Error) c_int;
    pub const getCurrentPageNumber = atspi_document_get_current_page_number;

    /// Gets the value of a single attribute, if specified for the document as a whole.
    extern fn atspi_document_get_document_attribute_value(p_obj: *Document, p_attribute: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getDocumentAttributeValue = atspi_document_get_document_attribute_value;

    /// Gets all constant attributes for the document as a whole. For attributes
    /// that change within the document content, see `atspi_text_get_attribute_run` instead.
    extern fn atspi_document_get_document_attributes(p_obj: *Document, p_error: ?*?*glib.Error) ?*glib.HashTable;
    pub const getDocumentAttributes = atspi_document_get_document_attributes;

    /// Gets the locale associated with the document's content,
    /// e.g. the locale for LOCALE_TYPE_MESSAGES.
    extern fn atspi_document_get_locale(p_obj: *Document, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getLocale = atspi_document_get_locale;

    /// Gets the page count of an `AccessibleDocument` object.
    extern fn atspi_document_get_page_count(p_obj: *Document, p_error: ?*?*glib.Error) c_int;
    pub const getPageCount = atspi_document_get_page_count;

    /// Returns an array of AtspiTextSelections within this document.
    extern fn atspi_document_get_text_selections(p_document: *Document, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getTextSelections = atspi_document_get_text_selections;

    /// Makes 1 or more selections within this document denoted by the given
    /// array of AtspiTextSelections. Any existing physical selection (inside or
    /// outside this document) is replaced by the new selections. All objects within
    /// the given selection ranges must be descendants of this document. Otherwise
    /// FALSE will be returned.
    extern fn atspi_document_set_text_selections(p_document: *Document, p_selections: *glib.Array, p_error: ?*?*glib.Error) c_int;
    pub const setTextSelections = atspi_document_set_text_selections;

    extern fn atspi_document_get_type() usize;
    pub const getGObjectType = atspi_document_get_type;

    extern fn g_object_ref(p_self: *atspi.Document) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Document) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Document, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EditableText = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = EditableText;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Copies text from an `atspi.EditableText` object into the system clipboard.
    ///
    /// see: `atspi.EditableText.pasteText`
    extern fn atspi_editable_text_copy_text(p_obj: *EditableText, p_start_pos: c_int, p_end_pos: c_int, p_error: ?*?*glib.Error) c_int;
    pub const copyText = atspi_editable_text_copy_text;

    /// Deletes text from an `atspi.EditableText` object, copying the
    ///       excised portion into the system clipboard.
    ///
    /// see: `atspi.EditableText.pasteText`
    extern fn atspi_editable_text_cut_text(p_obj: *EditableText, p_start_pos: c_int, p_end_pos: c_int, p_error: ?*?*glib.Error) c_int;
    pub const cutText = atspi_editable_text_cut_text;

    /// Deletes text from an `atspi.EditableText` object, without copying the
    ///       excised portion into the system clipboard.
    ///
    /// see: `atspi.EditableText.cutText`
    extern fn atspi_editable_text_delete_text(p_obj: *EditableText, p_start_pos: c_int, p_end_pos: c_int, p_error: ?*?*glib.Error) c_int;
    pub const deleteText = atspi_editable_text_delete_text;

    /// Inserts text into an `atspi.EditableText` object.
    /// As with all character offsets, the specified `position` may not be the
    /// same as the resulting byte offset, since the text is in a
    /// variable-width encoding.
    extern fn atspi_editable_text_insert_text(p_obj: *EditableText, p_position: c_int, p_text: [*:0]const u8, p_length: c_int, p_error: ?*?*glib.Error) c_int;
    pub const insertText = atspi_editable_text_insert_text;

    /// Inserts text from the system clipboard into an `atspi.EditableText` object.
    /// As with all character offsets, the specified `position` may not be the
    ///       same as the resulting byte offset, since the text is in a
    ///       variable-width encoding.
    extern fn atspi_editable_text_paste_text(p_obj: *EditableText, p_position: c_int, p_error: ?*?*glib.Error) c_int;
    pub const pasteText = atspi_editable_text_paste_text;

    /// Replace the entire text contents of an `atspi.EditableText` object.
    extern fn atspi_editable_text_set_text_contents(p_obj: *EditableText, p_new_contents: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const setTextContents = atspi_editable_text_set_text_contents;

    extern fn atspi_editable_text_get_type() usize;
    pub const getGObjectType = atspi_editable_text_get_type;

    extern fn g_object_ref(p_self: *atspi.EditableText) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.EditableText) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EditableText, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface used for objects which implement linking between
/// multiple resource locations.
///
/// An interface used for objects which implement linking between
/// multiple resource or content locations, or multiple 'markers'
/// within a single document. A hypertext instance is associated
/// with one or more hyperlinks which are associated with particular
/// offsets within the hypertext's content.
pub const Hypertext = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Hypertext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the `atspi.Hyperlink` object at a specified index.
    extern fn atspi_hypertext_get_link(p_obj: *Hypertext, p_link_index: c_int, p_error: ?*?*glib.Error) ?*atspi.Hyperlink;
    pub const getLink = atspi_hypertext_get_link;

    /// Gets the index of the `atspi.Hyperlink` object at a specified
    ///        character offset.
    extern fn atspi_hypertext_get_link_index(p_obj: *Hypertext, p_character_offset: c_int, p_error: ?*?*glib.Error) c_int;
    pub const getLinkIndex = atspi_hypertext_get_link_index;

    /// Gets the total number of `atspi.Hyperlink` objects that an
    /// `atspi.Hypertext` implementor has.
    extern fn atspi_hypertext_get_n_links(p_obj: *Hypertext, p_error: ?*?*glib.Error) c_int;
    pub const getNLinks = atspi_hypertext_get_n_links;

    extern fn atspi_hypertext_get_type() usize;
    pub const getGObjectType = atspi_hypertext_get_type;

    extern fn g_object_ref(p_self: *atspi.Hypertext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Hypertext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Hypertext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Image = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Image;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the description of the image displayed in an `atspi.Image` object.
    extern fn atspi_image_get_image_description(p_obj: *Image, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getImageDescription = atspi_image_get_image_description;

    /// Gets the bounding box of the image displayed in a
    ///         specified `atspi.Image` implementor.
    /// The returned values are meaningful only if the Image has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_image_get_image_extents(p_obj: *Image, p_ctype: atspi.CoordType, p_error: ?*?*glib.Error) ?*atspi.Rect;
    pub const getImageExtents = atspi_image_get_image_extents;

    /// Gets the locale associated with an image and its textual representation.
    extern fn atspi_image_get_image_locale(p_obj: *Image, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getImageLocale = atspi_image_get_image_locale;

    /// Gets the minimum x and y coordinates of the image displayed in a
    ///         specified `atspi.Image` implementor.
    /// The returned values are meaningful only if the Image has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_image_get_image_position(p_obj: *Image, p_ctype: atspi.CoordType, p_error: ?*?*glib.Error) ?*atspi.Point;
    pub const getImagePosition = atspi_image_get_image_position;

    /// Gets the size of the image displayed in a specified `atspi.Image` object.
    /// The returned values are meaningful only if the Image has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_image_get_image_size(p_obj: *Image, p_error: ?*?*glib.Error) ?*atspi.Point;
    pub const getImageSize = atspi_image_get_image_size;

    extern fn atspi_image_get_type() usize;
    pub const getGObjectType = atspi_image_get_type;

    extern fn g_object_ref(p_self: *atspi.Image) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Image) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Image, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface which indicates that an object exposes a 'selection' model,
/// allowing the selection of one or more of its children.
///
/// An interface which indicates that an object exposes a 'selection'
/// model, allowing the selection of one or more of its children.
/// Read-only Selection instances are possible, in which case the
/// interface is used to programmatically determine the selected-ness
/// of its children.
pub const Selection = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Selection;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Clears the current selection, removing all selected children from the
    ///       specified `atspi.Selection` implementor's selection list.
    extern fn atspi_selection_clear_selection(p_obj: *Selection, p_error: ?*?*glib.Error) c_int;
    pub const clearSelection = atspi_selection_clear_selection;

    /// Deselects a specific child of an `atspi.Selection`.
    ///          Note that `child_index` is the index of the child
    ///          in the parent container.
    ///
    /// See `atspi.Selection.deselectSelectedChild`
    extern fn atspi_selection_deselect_child(p_obj: *Selection, p_child_index: c_int, p_error: ?*?*glib.Error) c_int;
    pub const deselectChild = atspi_selection_deselect_child;

    /// Removes a child from the selected children list of an `atspi.Selection`.
    ///          Note that `child_index` is the index in the selected-children list,
    ///          not the index in the parent container.  `selectedChildIndex` in this
    ///          method, and `child_index` in `atspi.Selection.selectChild`
    ///          are asymmetric.
    extern fn atspi_selection_deselect_selected_child(p_obj: *Selection, p_selected_child_index: c_int, p_error: ?*?*glib.Error) c_int;
    pub const deselectSelectedChild = atspi_selection_deselect_selected_child;

    /// Gets the number of children of an `atspi.Selection` implementor which are
    ///        currently selected.
    extern fn atspi_selection_get_n_selected_children(p_obj: *Selection, p_error: ?*?*glib.Error) c_int;
    pub const getNSelectedChildren = atspi_selection_get_n_selected_children;

    /// Gets the i-th selected `atspi.Accessible` child of an `atspi.Selection`.
    ///      Note that `selected_child_index` refers to the index in the list
    ///      of 'selected'
    ///      children and generally differs from that used in
    ///      `atspi.Accessible.getChildAtIndex` or returned by
    ///      `atspi.Accessible.getIndexInParent`.
    ///      `selected_child_index` must lie between 0
    ///      and `atspi.Selection.getNSelectedChildren` - 1, inclusive.
    extern fn atspi_selection_get_selected_child(p_obj: *Selection, p_selected_child_index: c_int, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getSelectedChild = atspi_selection_get_selected_child;

    /// Determines whether a particular child of an `atspi.Selection` implementor
    ///        is currently selected.  Note that `child_index` is the index into the
    ///        standard `atspi.Accessible` container's list of children.
    extern fn atspi_selection_is_child_selected(p_obj: *Selection, p_child_index: c_int, p_error: ?*?*glib.Error) c_int;
    pub const isChildSelected = atspi_selection_is_child_selected;

    /// Attempts to select all of the children of an `atspi.Selection` implementor.
    /// Not all `atspi.Selection` implementors support this operation.
    extern fn atspi_selection_select_all(p_obj: *Selection, p_error: ?*?*glib.Error) c_int;
    pub const selectAll = atspi_selection_select_all;

    /// Adds a child to the selected children list of an `atspi.Selection`.
    ///         For `atspi.Selection` implementors that only allow
    ///         single selections, this may replace the (single) current
    ///         selection.
    extern fn atspi_selection_select_child(p_obj: *Selection, p_child_index: c_int, p_error: ?*?*glib.Error) c_int;
    pub const selectChild = atspi_selection_select_child;

    extern fn atspi_selection_get_type() usize;
    pub const getGObjectType = atspi_selection_get_type;

    extern fn g_object_ref(p_self: *atspi.Selection) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Selection) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Selection, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface used by containers whose data is arranged in a tabular form.
///
/// An interface used by containers whose contained data is arranged
/// in a tabular (i.e. row-column) form. Tables may resemble
/// a two-dimensional grid, as in a spreadsheet, or may feature objects
/// which span multiple rows and/or columns, but whose bounds are
/// aligned on a row/column matrix. Objects within tables are children
/// of the table object, and they may be referenced either via a child
/// index or via a row/column pair. Table 'cells' may implement other
/// interfaces, such as Text, Action, Image, and Component, and should do
/// so as appropriate to their onscreen presentation and/or behavior.
pub const Table = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Table;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Selects the specified column, adding it to the current column selection.
    /// Not all tables support column selection.
    extern fn atspi_table_add_column_selection(p_obj: *Table, p_column: c_int, p_error: ?*?*glib.Error) c_int;
    pub const addColumnSelection = atspi_table_add_column_selection;

    /// Selects the specified row, adding it to the current row selection.
    /// Not all tables support row selection.
    extern fn atspi_table_add_row_selection(p_obj: *Table, p_row: c_int, p_error: ?*?*glib.Error) c_int;
    pub const addRowSelection = atspi_table_add_row_selection;

    /// Gets the table cell at the specified row and column indices.
    /// To get the accessible object at a particular (x, y) screen
    /// coordinate, use `atspi.Component.getAccessibleAtPoint`.
    extern fn atspi_table_get_accessible_at(p_obj: *Table, p_row: c_int, p_column: c_int, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getAccessibleAt = atspi_table_get_accessible_at;

    /// Gets an accessible representation of the caption for an `atspi.Table`.
    extern fn atspi_table_get_caption(p_obj: *Table, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getCaption = atspi_table_get_caption;

    /// Gets the table column index occupied by the child at a particular 1-D
    /// child index.
    ///
    /// `see` `atspi.Table.getIndexAt`, `atspi.Table.getRowAtIndex`
    extern fn atspi_table_get_column_at_index(p_obj: *Table, p_index: c_int, p_error: ?*?*glib.Error) c_int;
    pub const getColumnAtIndex = atspi_table_get_column_at_index;

    /// Gets a text description of a particular table column.  This differs from
    /// `atspi.Table.getColumnHeader`, which returns an `Accessible`.
    extern fn atspi_table_get_column_description(p_obj: *Table, p_column: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getColumnDescription = atspi_table_get_column_description;

    /// Gets the number of columns spanned by the table cell at the specific
    /// row and column (some tables can have cells which span multiple
    /// rows and/or columns).
    /// The returned values are meaningful only if the Table has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_table_get_column_extent_at(p_obj: *Table, p_row: c_int, p_column: c_int, p_error: ?*?*glib.Error) c_int;
    pub const getColumnExtentAt = atspi_table_get_column_extent_at;

    /// Gets the header associated with a table column, if available.
    /// This differs from `atspi.Table.getColumnDescription`, which
    /// returns a string.
    extern fn atspi_table_get_column_header(p_obj: *Table, p_column: c_int, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getColumnHeader = atspi_table_get_column_header;

    /// Gets the 1-D child index corresponding to the specified 2-D row and
    /// column indices. To get the accessible object at a particular (x, y) screen
    /// coordinate, use `atspi.Component.getAccessibleAtPoint`.
    ///
    /// `see` `atspi.Table.getRowAtIndex`, `atspi.Table.getColumnAtIndex`
    extern fn atspi_table_get_index_at(p_obj: *Table, p_row: c_int, p_column: c_int, p_error: ?*?*glib.Error) c_int;
    pub const getIndexAt = atspi_table_get_index_at;

    /// Gets the number of columns in an `atspi.Table`,
    ///        exclusive of any columns that are programmatically hidden, but inclusive
    ///        of columns that may be outside of the current scrolling window or viewport.
    extern fn atspi_table_get_n_columns(p_obj: *Table, p_error: ?*?*glib.Error) c_int;
    pub const getNColumns = atspi_table_get_n_columns;

    /// Gets the number of rows in an `atspi.Table`,
    ///        exclusive of any rows that are programmatically hidden, but inclusive
    ///        of rows that may be outside of the current scrolling window or viewport.
    extern fn atspi_table_get_n_rows(p_obj: *Table, p_error: ?*?*glib.Error) c_int;
    pub const getNRows = atspi_table_get_n_rows;

    /// Queries a table to find out how many columns are currently selected.
    /// Not all tables support column selection.
    extern fn atspi_table_get_n_selected_columns(p_obj: *Table, p_error: ?*?*glib.Error) c_int;
    pub const getNSelectedColumns = atspi_table_get_n_selected_columns;

    /// Query a table to find out how many rows are currently selected.
    /// Not all tables support row selection.
    extern fn atspi_table_get_n_selected_rows(p_obj: *Table, p_error: ?*?*glib.Error) c_int;
    pub const getNSelectedRows = atspi_table_get_n_selected_rows;

    /// Gets the table row index occupied by the child at a particular 1-D
    /// child index.
    ///
    /// `see` `atspi.Table.getIndexAt`, `atspi.Table.getColumnAtIndex`
    extern fn atspi_table_get_row_at_index(p_obj: *Table, p_index: c_int, p_error: ?*?*glib.Error) c_int;
    pub const getRowAtIndex = atspi_table_get_row_at_index;

    /// Given a child index, determines the row and column indices and
    /// extents, and whether the cell is currently selected.  If
    /// the child at index is not a cell (for instance, if it is
    /// a summary, caption, etc.), `FALSE` is returned.
    /// The returned values are meaningful only if the Table has both
    /// STATE_VISIBLE and STATE_SHOWING.
    ///
    /// Example:
    /// If the `atspi.Table` child at index '6' extends across columns 5 and 6 of
    /// row 2 of an `atspi.Table` instance, and is currently selected, then
    ///
    /// retval = atspi_table_get_row_column_extents_at_index (table, 6,
    ///                                             row, col,
    ///                                             row_extents,
    ///                                             col_extents,
    ///                                             is_selected);
    ///
    /// will return `TRUE`, and after the call
    /// row, col, row_extents, col_extents,
    /// and is_selected will contain 2, 5, 1, 2, and
    /// `TRUE`, respectively.
    extern fn atspi_table_get_row_column_extents_at_index(p_obj: *Table, p_index: c_int, p_row: *c_int, p_col: *c_int, p_row_extents: *c_int, p_col_extents: *c_int, p_is_selected: *c_int, p_error: ?*?*glib.Error) c_int;
    pub const getRowColumnExtentsAtIndex = atspi_table_get_row_column_extents_at_index;

    /// Gets a text description of a particular table row.  This differs from
    /// `atspi.Table.getRowHeader`, which returns an `atspi.Accessible`.
    extern fn atspi_table_get_row_description(p_obj: *Table, p_row: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getRowDescription = atspi_table_get_row_description;

    /// Gets the number of rows spanned by the table cell at the specific row
    /// and column. (some tables can have cells which span multiple rows
    /// and/or columns).
    /// The returned values are meaningful only if the Table has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_table_get_row_extent_at(p_obj: *Table, p_row: c_int, p_column: c_int, p_error: ?*?*glib.Error) c_int;
    pub const getRowExtentAt = atspi_table_get_row_extent_at;

    /// Gets the header associated with a table row, if available. This differs from
    /// `atspi.Table.getRowDescription`, which returns a string.
    extern fn atspi_table_get_row_header(p_obj: *Table, p_row: c_int, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getRowHeader = atspi_table_get_row_header;

    /// Queries a table for a list of indices of columns which are currently
    /// selected.
    extern fn atspi_table_get_selected_columns(p_obj: *Table, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getSelectedColumns = atspi_table_get_selected_columns;

    /// Queries a table for a list of indices of rows which are currently selected.
    extern fn atspi_table_get_selected_rows(p_obj: *Table, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getSelectedRows = atspi_table_get_selected_rows;

    /// Gets an accessible object which summarizes the contents of an `atspi.Table`.
    extern fn atspi_table_get_summary(p_obj: *Table, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getSummary = atspi_table_get_summary;

    /// Determines whether specified table column is selected.
    /// Not all tables support column selection.
    extern fn atspi_table_is_column_selected(p_obj: *Table, p_column: c_int, p_error: ?*?*glib.Error) c_int;
    pub const isColumnSelected = atspi_table_is_column_selected;

    /// Determines whether a table row is selected.  Not all tables support
    /// row selection.
    extern fn atspi_table_is_row_selected(p_obj: *Table, p_row: c_int, p_error: ?*?*glib.Error) c_int;
    pub const isRowSelected = atspi_table_is_row_selected;

    /// Determines whether the cell at a specific row and column is selected.
    extern fn atspi_table_is_selected(p_obj: *Table, p_row: c_int, p_column: c_int, p_error: ?*?*glib.Error) c_int;
    pub const isSelected = atspi_table_is_selected;

    /// De-selects the specified column, removing it from the current column
    /// selection.
    /// Not all tables support column selection.
    extern fn atspi_table_remove_column_selection(p_obj: *Table, p_column: c_int, p_error: ?*?*glib.Error) c_int;
    pub const removeColumnSelection = atspi_table_remove_column_selection;

    /// De-selects the specified row, removing it from the current row selection.
    /// Not all tables support row selection.
    extern fn atspi_table_remove_row_selection(p_obj: *Table, p_row: c_int, p_error: ?*?*glib.Error) c_int;
    pub const removeRowSelection = atspi_table_remove_row_selection;

    extern fn atspi_table_get_type() usize;
    pub const getGObjectType = atspi_table_get_type;

    extern fn g_object_ref(p_self: *atspi.Table) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Table) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Table, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TableCell = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = TableCell;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the column headers as an array of cell accessibles.
    extern fn atspi_table_cell_get_column_header_cells(p_obj: *TableCell, p_error: ?*?*glib.Error) ?*glib.PtrArray;
    pub const getColumnHeaderCells = atspi_table_cell_get_column_header_cells;

    extern fn atspi_table_cell_get_column_index(p_obj: *TableCell, p_error: ?*?*glib.Error) c_int;
    pub const getColumnIndex = atspi_table_cell_get_column_index;

    /// Returns the number of columns occupied by this cell accessible.
    /// The returned values are meaningful only if the table cell has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_table_cell_get_column_span(p_obj: *TableCell, p_error: ?*?*glib.Error) c_int;
    pub const getColumnSpan = atspi_table_cell_get_column_span;

    /// Retrieves the tabular position of this cell.
    extern fn atspi_table_cell_get_position(p_obj: *TableCell, p_row: *c_int, p_column: *c_int, p_error: ?*?*glib.Error) c_int;
    pub const getPosition = atspi_table_cell_get_position;

    /// Gets the row and column indexes and extents of this cell accessible.
    /// The returned values are meaningful only if the table cell has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_table_cell_get_row_column_span(p_obj: *TableCell, p_row: *c_int, p_column: *c_int, p_row_span: *c_int, p_column_span: *c_int, p_error: ?*?*glib.Error) void;
    pub const getRowColumnSpan = atspi_table_cell_get_row_column_span;

    /// Returns the row headers as an array of cell accessibles.
    extern fn atspi_table_cell_get_row_header_cells(p_obj: *TableCell, p_error: ?*?*glib.Error) ?*glib.PtrArray;
    pub const getRowHeaderCells = atspi_table_cell_get_row_header_cells;

    /// Returns the number of rows occupied by this cell accessible.
    /// The returned values are meaningful only if the table cell has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_table_cell_get_row_span(p_obj: *TableCell, p_error: ?*?*glib.Error) c_int;
    pub const getRowSpan = atspi_table_cell_get_row_span;

    /// Returns a reference to the accessible of the containing table.
    extern fn atspi_table_cell_get_table(p_obj: *TableCell, p_error: ?*?*glib.Error) ?*atspi.Accessible;
    pub const getTable = atspi_table_cell_get_table;

    extern fn atspi_table_cell_get_type() usize;
    pub const getGObjectType = atspi_table_cell_get_type;

    extern fn g_object_ref(p_self: *atspi.TableCell) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.TableCell) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TableCell, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface implemented by objects which place textual
/// information onscreen.
///
/// The text interface should be implemented by objects which place textual
/// information onscreen as character strings or glyphs. The text interface
/// allows access to textual content including display attributes and
/// semantic hints associated with runs of text, and to bounding
/// information for glyphs and substrings. It also allows portions of text to
/// be selected, if the objects StateSet includes STATE_SELECTABLE_TEXT.
pub const Text = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Text;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Selects some text (adds a text selection) in an `atspi.Text` object.
    extern fn atspi_text_add_selection(p_obj: *Text, p_start_offset: c_int, p_end_offset: c_int, p_error: ?*?*glib.Error) c_int;
    pub const addSelection = atspi_text_add_selection;

    /// Gets a set of attributes applied to a range of text from an `atspi.Text` object, optionally
    /// including its 'default' attributes.
    extern fn atspi_text_get_attribute_run(p_obj: *Text, p_offset: c_int, p_include_defaults: c_int, p_start_offset: *c_int, p_end_offset: *c_int, p_error: ?*?*glib.Error) ?*glib.HashTable;
    pub const getAttributeRun = atspi_text_get_attribute_run;

    /// Gets the value of a named attribute at a given offset.
    extern fn atspi_text_get_attribute_value(p_obj: *Text, p_offset: c_int, p_attribute_name: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getAttributeValue = atspi_text_get_attribute_value;

    /// Gets the attributes applied to a range of text from an `atspi.Text`
    /// object. The text attributes correspond to CSS attributes
    /// where possible.
    extern fn atspi_text_get_attributes(p_obj: *Text, p_offset: c_int, p_start_offset: *c_int, p_end_offset: *c_int, p_error: ?*?*glib.Error) ?*glib.HashTable;
    pub const getAttributes = atspi_text_get_attributes;

    /// Gets the ranges of text from an `atspi.Text` object which lie within the
    ///          bounds defined by (`x`, `y`) and (`x`+`width`, `y`+`height`).
    extern fn atspi_text_get_bounded_ranges(p_obj: *Text, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_type: atspi.CoordType, p_clipTypeX: atspi.TextClipType, p_clipTypeY: atspi.TextClipType, p_error: ?*?*glib.Error) ?*glib.Array;
    pub const getBoundedRanges = atspi_text_get_bounded_ranges;

    /// Gets the current offset of the text caret in an `atspi.Text` object.
    extern fn atspi_text_get_caret_offset(p_obj: *Text, p_error: ?*?*glib.Error) c_int;
    pub const getCaretOffset = atspi_text_get_caret_offset;

    /// Gets the character at a given offset for an `atspi.Text` object.
    extern fn atspi_text_get_character_at_offset(p_obj: *Text, p_offset: c_int, p_error: ?*?*glib.Error) c_uint;
    pub const getCharacterAtOffset = atspi_text_get_character_at_offset;

    /// Gets the character count of an `AccessibleText` object.
    extern fn atspi_text_get_character_count(p_obj: *Text, p_error: ?*?*glib.Error) c_int;
    pub const getCharacterCount = atspi_text_get_character_count;

    /// Gets a bounding box containing the glyph representing
    ///        the character at a particular text offset.
    /// The returned values are meaningful only if the Text has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_text_get_character_extents(p_obj: *Text, p_offset: c_int, p_type: atspi.CoordType, p_error: ?*?*glib.Error) ?*atspi.Rect;
    pub const getCharacterExtents = atspi_text_get_character_extents;

    /// Gets the default attributes applied to an `atspi.Text`
    /// object. The text attributes correspond to CSS attributes
    /// where possible. The combination of this attribute set and
    /// the attributes reported by `atspi.Text.getAttributes`
    /// describes the entire set of text attributes over a range.
    extern fn atspi_text_get_default_attributes(p_obj: *Text, p_error: ?*?*glib.Error) ?*glib.HashTable;
    pub const getDefaultAttributes = atspi_text_get_default_attributes;

    /// Gets the number of active non-contiguous selections for an
    ///          `atspi.Text` object.
    extern fn atspi_text_get_n_selections(p_obj: *Text, p_error: ?*?*glib.Error) c_int;
    pub const getNSelections = atspi_text_get_n_selections;

    /// Gets the character offset into the text at a given point.
    extern fn atspi_text_get_offset_at_point(p_obj: *Text, p_x: c_int, p_y: c_int, p_type: atspi.CoordType, p_error: ?*?*glib.Error) c_int;
    pub const getOffsetAtPoint = atspi_text_get_offset_at_point;

    /// Gets the bounding box for text within a range in an  `atspi.Text` object.
    /// The returned values are meaningful only if the Text has both
    /// STATE_VISIBLE and STATE_SHOWING.
    extern fn atspi_text_get_range_extents(p_obj: *Text, p_start_offset: c_int, p_end_offset: c_int, p_type: atspi.CoordType, p_error: ?*?*glib.Error) ?*atspi.Rect;
    pub const getRangeExtents = atspi_text_get_range_extents;

    /// Gets the bounds of the `selection_num`-th active text selection for an
    ///         `atspi.Text` object.
    extern fn atspi_text_get_selection(p_obj: *Text, p_selection_num: c_int, p_error: ?*?*glib.Error) ?*atspi.Range;
    pub const getSelection = atspi_text_get_selection;

    /// Gets a portion of the text exposed through an `atspi.Text` according to a given `offset`
    /// and a specific `granularity`, along with the start and end offsets defining the
    /// boundaries of such a portion of text.
    ///
    /// If `granularity` is ATSPI_TEXT_GRANULARITY_CHAR the character at the
    /// offset is returned.
    ///
    /// If `granularity` is ATSPI_TEXT_GRANULARITY_WORD the returned string
    /// is from the word start at or before the offset to the word start after
    /// the offset.
    ///
    /// The returned string will contain the word at the offset if the offset
    /// is inside a word and will contain the word before the offset if the
    /// offset is not inside a word.
    ///
    /// If `granularity` is ATSPI_TEXT_GRANULARITY_SENTENCE the returned string
    /// is from the sentence start at or before the offset to the sentence
    /// start after the offset.
    ///
    /// The returned string will contain the sentence at the offset if the offset
    /// is inside a sentence and will contain the sentence before the offset
    /// if the offset is not inside a sentence.
    ///
    /// If `granularity` is ATSPI_TEXT_GRANULARITY_LINE the returned string
    /// is from the line start at or before the offset to the line
    /// start after the offset.
    ///
    /// If `granularity` is ATSPI_TEXT_GRANULARITY_PARAGRAPH the returned string
    /// is from the start of the paragraph at or before the offset to the start
    /// of the following paragraph after the offset.
    extern fn atspi_text_get_string_at_offset(p_obj: *Text, p_offset: c_int, p_granularity: atspi.TextGranularity, p_error: ?*?*glib.Error) ?*atspi.TextRange;
    pub const getStringAtOffset = atspi_text_get_string_at_offset;

    /// Gets a range of text from an `atspi.Text` object.  The number of bytes
    ///          in the returned string may exceed either end_offset or start_offset, since
    ///          UTF-8 is a variable-width encoding.
    extern fn atspi_text_get_text(p_obj: *Text, p_start_offset: c_int, p_end_offset: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getText = atspi_text_get_text;

    /// Gets delimited text from an `atspi.Text` object which follows a given
    ///          text offset.
    extern fn atspi_text_get_text_after_offset(p_obj: *Text, p_offset: c_int, p_type: atspi.TextBoundaryType, p_error: ?*?*glib.Error) ?*atspi.TextRange;
    pub const getTextAfterOffset = atspi_text_get_text_after_offset;

    /// Gets delimited text from an `atspi.Text` object which includes a given
    ///          text offset.
    extern fn atspi_text_get_text_at_offset(p_obj: *Text, p_offset: c_int, p_type: atspi.TextBoundaryType, p_error: ?*?*glib.Error) ?*atspi.TextRange;
    pub const getTextAtOffset = atspi_text_get_text_at_offset;

    /// Gets the value of a named attribute at a given offset.
    extern fn atspi_text_get_text_attribute_value(p_obj: *Text, p_offset: c_int, p_attribute_name: [*:0]const u8, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getTextAttributeValue = atspi_text_get_text_attribute_value;

    /// Gets the attributes applied to a range of text from an `atspi.Text`
    /// object. The text attributes correspond to CSS attributes
    /// where possible.
    extern fn atspi_text_get_text_attributes(p_obj: *Text, p_offset: c_int, p_start_offset: *c_int, p_end_offset: *c_int, p_error: ?*?*glib.Error) ?*glib.HashTable;
    pub const getTextAttributes = atspi_text_get_text_attributes;

    /// Gets delimited text from an `atspi.Text` object which precedes a given
    ///          text offset.
    extern fn atspi_text_get_text_before_offset(p_obj: *Text, p_offset: c_int, p_type: atspi.TextBoundaryType, p_error: ?*?*glib.Error) ?*atspi.TextRange;
    pub const getTextBeforeOffset = atspi_text_get_text_before_offset;

    /// De-selects a text selection.
    extern fn atspi_text_remove_selection(p_obj: *Text, p_selection_num: c_int, p_error: ?*?*glib.Error) c_int;
    pub const removeSelection = atspi_text_remove_selection;

    /// Scrolls whatever container of the `atspi.Text` text range so it becomes
    /// visible on the screen.
    extern fn atspi_text_scroll_substring_to(p_obj: *Text, p_start_offset: c_int, p_end_offset: c_int, p_type: atspi.ScrollType, p_error: ?*?*glib.Error) c_int;
    pub const scrollSubstringTo = atspi_text_scroll_substring_to;

    /// Scrolls whatever container of the `atspi.Text` text range so it becomes
    /// visible on the screen at a given position.
    extern fn atspi_text_scroll_substring_to_point(p_obj: *Text, p_start_offset: c_int, p_end_offset: c_int, p_coords: atspi.CoordType, p_x: c_int, p_y: c_int, p_error: ?*?*glib.Error) c_int;
    pub const scrollSubstringToPoint = atspi_text_scroll_substring_to_point;

    /// Moves the text caret to a given position.
    extern fn atspi_text_set_caret_offset(p_obj: *Text, p_new_offset: c_int, p_error: ?*?*glib.Error) c_int;
    pub const setCaretOffset = atspi_text_set_caret_offset;

    /// Changes the bounds of an existing `atspi.Text` text selection.
    extern fn atspi_text_set_selection(p_obj: *Text, p_selection_num: c_int, p_start_offset: c_int, p_end_offset: c_int, p_error: ?*?*glib.Error) c_int;
    pub const setSelection = atspi_text_set_selection;

    extern fn atspi_text_get_type() usize;
    pub const getGObjectType = atspi_text_get_type;

    extern fn g_object_ref(p_self: *atspi.Text) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Text) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Text, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface supporting a one-dimensional scalar
/// to be modified, or which reflects its value.
///
/// An interface supporting a one-dimensional scalar
/// to be modified, or which reflects its value. If
/// STATE_EDITABLE is not present, the value is
/// treated as "read only".
pub const Value = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = Value;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the current value for an `atspi.Value`.
    extern fn atspi_value_get_current_value(p_obj: *Value, p_error: ?*?*glib.Error) f64;
    pub const getCurrentValue = atspi_value_get_current_value;

    /// Gets the maximum allowed value for an `atspi.Value`.
    extern fn atspi_value_get_maximum_value(p_obj: *Value, p_error: ?*?*glib.Error) f64;
    pub const getMaximumValue = atspi_value_get_maximum_value;

    /// Gets the minimum increment by which an `atspi.Value` can be adjusted.
    extern fn atspi_value_get_minimum_increment(p_obj: *Value, p_error: ?*?*glib.Error) f64;
    pub const getMinimumIncrement = atspi_value_get_minimum_increment;

    /// Gets the minimum allowed value for an `atspi.Value`.
    extern fn atspi_value_get_minimum_value(p_obj: *Value, p_error: ?*?*glib.Error) f64;
    pub const getMinimumValue = atspi_value_get_minimum_value;

    /// Gets the human readable text alternative associated with the value.
    /// `text` is a newly created string, that must be freed by the
    /// caller. Can be NULL if no descriptor is available.
    extern fn atspi_value_get_text(p_obj: *Value, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const getText = atspi_value_get_text;

    /// Sets the current value of an `atspi.Value`.
    extern fn atspi_value_set_current_value(p_obj: *Value, p_new_value: f64, p_error: ?*?*glib.Error) c_int;
    pub const setCurrentValue = atspi_value_set_current_value;

    extern fn atspi_value_get_type() usize;
    pub const getGObjectType = atspi_value_get_type;

    extern fn g_object_ref(p_self: *atspi.Value) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atspi.Value) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Value, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AccessibleClass = extern struct {
    pub const Instance = atspi.Accessible;

    f_parent_class: atspi.ObjectClass,
    f_region_changed: ?*const fn (p_accessible: *atspi.Accessible, p_current_offset: c_int, p_last_offset: c_int) callconv(.c) void,
    f_mode_changed: ?*const fn (p_accessible: *atspi.Accessible, p_enabled: c_int) callconv(.c) void,

    pub fn as(p_instance: *AccessibleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AccessiblePrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ApplicationClass = extern struct {
    pub const Instance = atspi.Application;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ApplicationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceA11yManagerClass = extern struct {
    pub const Instance = atspi.DeviceA11yManager;

    f_parent_class: atspi.DeviceClass,

    pub fn as(p_instance: *DeviceA11yManagerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceClass = extern struct {
    pub const Instance = atspi.Device;

    f_parent_class: gobject.ObjectClass,
    f_add_key_grab: ?*const fn (p_device: *atspi.Device, p_kd: *atspi.KeyDefinition) callconv(.c) c_int,
    f_remove_key_grab: ?*const fn (p_device: *atspi.Device, p_id: c_uint) callconv(.c) void,
    f_map_modifier: ?*const fn (p_device: *atspi.Device, p_keycode: c_int) callconv(.c) c_uint,
    f_unmap_modifier: ?*const fn (p_device: *atspi.Device, p_keycode: c_int) callconv(.c) void,
    f_get_modifier: ?*const fn (p_device: *atspi.Device, p_keycode: c_int) callconv(.c) c_uint,
    f_grab_keyboard: ?*const fn (p_device: *atspi.Device) callconv(.c) c_int,
    f_ungrab_keyboard: ?*const fn (p_device: *atspi.Device) callconv(.c) void,
    f_get_locked_modifiers: ?*const fn (p_device: *atspi.Device) callconv(.c) c_uint,
    f_generate_mouse_event: ?*const fn (p_device: *atspi.Device, p_obj: *atspi.Accessible, p_x: c_int, p_y: c_int, p_name: [*:0]const u8, p_error: ?*?*glib.Error) callconv(.c) void,
    f_map_keysym_modifier: ?*const fn (p_device: *atspi.Device, p_keysym: c_uint) callconv(.c) c_uint,
    f_unmap_keysym_modifier: ?*const fn (p_device: *atspi.Device, p_keysym: c_uint) callconv(.c) void,
    f_get_keysym_modifier: ?*const fn (p_device: *atspi.Device, p_keysym: c_uint) callconv(.c) c_uint,

    pub fn as(p_instance: *DeviceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceEvent = extern struct {
    f_type: atspi.EventType,
    f_id: c_uint,
    f_hw_code: c_ushort,
    f_modifiers: c_ushort,
    f_timestamp: c_uint,
    f_event_string: ?[*:0]u8,
    f_is_text: c_int,

    extern fn atspi_device_event_get_type() usize;
    pub const getGObjectType = atspi_device_event_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceLegacyClass = extern struct {
    pub const Instance = atspi.DeviceLegacy;

    f_parent_class: atspi.DeviceClass,

    pub fn as(p_instance: *DeviceLegacyClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceListenerClass = extern struct {
    pub const Instance = atspi.DeviceListener;

    f_parent_class: gobject.ObjectClass,
    f_device_event: ?*const fn (p_listener: *atspi.DeviceListener, p_event: *const atspi.DeviceEvent) callconv(.c) c_int,

    pub fn as(p_instance: *DeviceListenerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceX11Class = extern struct {
    pub const Instance = atspi.DeviceX11;

    f_parent_class: atspi.DeviceClass,

    pub fn as(p_instance: *DeviceX11Class, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Event = extern struct {
    f_type: ?[*:0]u8,
    f_source: ?*atspi.Accessible,
    f_detail1: c_int,
    f_detail2: c_int,
    f_any_data: gobject.Value,
    f_sender: ?*atspi.Accessible,

    /// Starts/enters the main event loop for the AT-SPI services.
    ///
    /// NOTE: This method does not return control; it is exited via a call to
    /// `atspi.eventQuit` from within an event handler.
    extern fn atspi_event_main() void;
    pub const main = atspi_event_main;

    /// Quits the last main event loop for the AT-SPI services,
    /// See: `atspi.eventMain`
    extern fn atspi_event_quit() void;
    pub const quit = atspi_event_quit;

    extern fn atspi_event_get_type() usize;
    pub const getGObjectType = atspi_event_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EventListenerClass = extern struct {
    pub const Instance = atspi.EventListener;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *EventListenerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EventListenerMode = extern struct {
    f_synchronous: c_int,
    f_preemptive: c_int,
    f_global: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HyperlinkClass = extern struct {
    pub const Instance = atspi.Hyperlink;

    f_parent_class: atspi.ObjectClass,

    pub fn as(p_instance: *HyperlinkClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const KeyDefinition = extern struct {
    f_keycode: c_int,
    f_keysym: c_int,
    f_keystring: ?[*:0]u8,
    f_modifiers: c_uint,

    extern fn atspi_key_definition_get_type() usize;
    pub const getGObjectType = atspi_key_definition_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Structure containing identifying information about a set of keycode or
///        keysyms.
pub const KeySet = extern struct {
    f_keysyms: ?*c_uint,
    f_keycodes: ?*c_ushort,
    f_keystrings: ?*[*:0]u8,
    f_len: c_short,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MatchRuleClass = extern struct {
    pub const Instance = atspi.MatchRule;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *MatchRuleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ObjectClass = extern struct {
    pub const Instance = atspi.Object;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ObjectClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Point = extern struct {
    f_x: c_int,
    f_y: c_int,

    extern fn atspi_point_copy(p_src: *Point) *atspi.Point;
    pub const copy = atspi_point_copy;

    extern fn atspi_point_get_type() usize;
    pub const getGObjectType = atspi_point_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Range = extern struct {
    f_start_offset: c_int,
    f_end_offset: c_int,

    /// Gets a copy of an `atspi.Range` object.
    extern fn atspi_range_copy(p_src: *Range) *atspi.Range;
    pub const copy = atspi_range_copy;

    extern fn atspi_range_get_type() usize;
    pub const getGObjectType = atspi_range_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Rect = extern struct {
    f_x: c_int,
    f_y: c_int,
    f_width: c_int,
    f_height: c_int,

    extern fn atspi_rect_copy(p_src: *Rect) *atspi.Rect;
    pub const copy = atspi_rect_copy;

    extern fn atspi_rect_get_type() usize;
    pub const getGObjectType = atspi_rect_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RelationClass = extern struct {
    pub const Instance = atspi.Relation;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *RelationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StateSetClass = extern struct {
    pub const Instance = atspi.StateSet;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *StateSetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextRange = extern struct {
    f_start_offset: c_int,
    f_end_offset: c_int,
    f_content: ?[*:0]u8,

    extern fn atspi_text_range_get_type() usize;
    pub const getGObjectType = atspi_text_range_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This structure represents a single  text selection within a document. This
/// selection is defined by two points in the content, where each one is defined
/// by an AtkObject supporting the AtkText interface and a character offset
/// relative to it.
///
/// The end object must appear after the start object in the accessibility tree,
/// i.e. the end object must be reachable from the start object by navigating
/// forward (next, first child etc).
///
/// This struct also contains a `start_is_active` boolean, to communicate if the
/// start of the selection is the active point or not.
///
/// The active point corresponds to the user's focus or point of interest. The
/// user moves the active point to expand or collapse the range. The anchor
/// point is the other point of the range and typically remains constant. In
/// most cases, anchor is the start of the range and active is the end. However,
/// when selecting backwards (e.g. pressing shift+left arrow in a text field),
/// the start of the range is the active point, as the user moves this to
/// manipulate the selection.
pub const TextSelection = extern struct {
    /// the AtspiAccessible containing the start of the selection.
    f_start_object: ?*atspi.Accessible,
    /// the text offset of the beginning of the selection within
    ///                `start_object`.
    f_start_offset: c_int,
    /// the AtspiAccessible containing the end of the selection.
    f_end_object: ?*atspi.Accessible,
    /// the text offset of the end of the selection within `end_object`.
    f_end_offset: c_int,
    /// a gboolean indicating whether the start of the selection
    ///                  is the active point.
    f_start_is_active: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used by `atspi.MatchRule` to specify
/// how to interpret `atspi.Accessible` objects.
pub const CollectionMatchType = enum(c_int) {
    invalid = 0,
    all = 1,
    any = 2,
    none = 3,
    empty = 4,
    last_defined = 5,
    _,

    extern fn atspi_collection_match_type_get_type() usize;
    pub const getGObjectType = atspi_collection_match_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used by interface `atspi.Collection` to specify
/// the way `AtspiAccesible` objects should be sorted.
pub const CollectionSortOrder = enum(c_int) {
    invalid = 0,
    canonical = 1,
    flow = 2,
    tab = 3,
    reverse_canonical = 4,
    reverse_flow = 5,
    reverse_tab = 6,
    last_defined = 7,
    _,

    extern fn atspi_collection_sort_order_get_type() usize;
    pub const getGObjectType = atspi_collection_sort_order_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used by interface `atspi.Collection` to specify
/// restrictions on `AtspiAccesible` objects to be traversed.
pub const CollectionTreeTraversalType = enum(c_int) {
    restrict_children = 0,
    restrict_sibling = 1,
    inorder = 2,
    last_defined = 3,
    _,

    extern fn atspi_collection_tree_traversal_type_get_type() usize;
    pub const getGObjectType = atspi_collection_tree_traversal_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `atspi.ComponentLayer` of an `atspi.Component` instance indicates its
/// relative stacking order with respect to the onscreen visual representation
/// of the UI. `atspi.ComponentLayer`, in combination with `atspi.Component` bounds
/// information, can be used to compute the visibility of all or part of a
/// component.  This is important in programmatic determination of
/// region-of-interest for magnification, and in
/// flat screen review models of the screen, as well as
/// for other uses. Objects residing in two of the `atspi.ComponentLayer`
/// categories support further z-ordering information, with respect to their
/// peers in the same layer: namely, `ATSPI_LAYER_WINDOW` and
/// `ATSPI_LAYER_MDI`.  Relative stacking order for other objects within the
/// same layer is not available; the recommended heuristic is
/// first child paints first. In other words, assume that the
/// first siblings in the child list are subject to being overpainted by later
/// siblings if their bounds intersect. The order of layers, from bottom to top,
///  is: `ATSPI_LAYER_BACKGROUND`, `ATSPI_LAYER_WINDOW`, `ATSPI_LAYER_MDI`,
/// `ATSPI_LAYER_CANVAS`, `ATSPI_LAYER_WIDGET`, `ATSPI_LAYER_POPUP`, and
/// `ATSPI_LAYER_OVERLAY`.
pub const ComponentLayer = enum(c_int) {
    invalid = 0,
    background = 1,
    canvas = 2,
    widget = 3,
    mdi = 4,
    popup = 5,
    overlay = 6,
    window = 7,
    last_defined = 8,
    _,

    extern fn atspi_component_layer_get_type() usize;
    pub const getGObjectType = atspi_component_layer_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used by `atspi.Component`, `atspi.Image`, and `atspi.Text` interfaces
/// to specify whether coordinates are relative to the window or the screen.
pub const CoordType = enum(c_int) {
    screen = 0,
    window = 1,
    parent = 2,
    _,

    extern fn atspi_coord_type_get_type() usize;
    pub const getGObjectType = atspi_coord_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used to specify the event types of interest to an
/// `atspi.EventListener`, or
/// to identify the type of an event for which notification has been sent.
pub const EventType = enum(c_int) {
    key_pressed_event = 0,
    key_released_event = 1,
    button_pressed_event = 2,
    button_released_event = 3,
    _,

    extern fn atspi_event_type_get_type() usize;
    pub const getGObjectType = atspi_event_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Deprecated. Should not be used.
pub const KeyEventType = enum(c_int) {
    pressed = 0,
    released = 1,
    _,

    extern fn atspi_key_event_type_get_type() usize;
    pub const getGObjectType = atspi_key_event_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used when synthesizing keyboard input via
/// `atspi.generateKeyboardEvent`.
pub const KeySynthType = enum(c_int) {
    press = 0,
    release = 1,
    pressrelease = 2,
    sym = 3,
    string = 4,
    lockmodifiers = 5,
    unlockmodifiers = 6,
    _,

    extern fn atspi_key_synth_type_get_type() usize;
    pub const getGObjectType = atspi_key_synth_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used to indicate a type of live region and how assertive it
/// should be in terms of speaking notifications. Currently, this is only used
/// for "announcement" events, but it may be used for additional purposes
/// in the future.
pub const Live = enum(c_int) {
    none = 0,
    polite = 1,
    assertive = 2,
    _,

    extern fn atspi_live_get_type() usize;
    pub const getGObjectType = atspi_live_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used by interfaces `atspi.Text` and `atspi.Document`, this
/// enumeration corresponds to the POSIX 'setlocale' enum values.
pub const LocaleType = enum(c_int) {
    messages = 0,
    collate = 1,
    ctype = 2,
    monetary = 3,
    numeric = 4,
    time = 5,
    _,

    extern fn atspi_locale_type_get_type() usize;
    pub const getGObjectType = atspi_locale_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ModifierType = enum(c_int) {
    shift = 0,
    shiftlock = 1,
    control = 2,
    alt = 3,
    meta = 4,
    meta2 = 5,
    meta3 = 6,
    numlock = 14,
    _,

    extern fn atspi_modifier_type_get_type() usize;
    pub const getGObjectType = atspi_modifier_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `atspi.RelationType` specifies a relationship between objects
/// (possibly one-to-many
/// or many-to-one) outside of the normal parent/child hierarchical
/// relationship. It allows better semantic       identification of how objects
/// are associated with one another.       For instance the
/// `ATSPI_RELATION_LABELLED_BY`
/// relationship may be used to identify labelling information       that should
/// accompany the accessible name property when presenting an object's content or
/// identity       to the end user.  Similarly,
/// `ATSPI_RELATION_CONTROLLER_FOR` can be used
/// to further specify the context in which a valuator is useful, and/or the
/// other UI components which are directly effected by user interactions with
/// the valuator. Common examples include association of scrollbars with the
/// viewport or panel which they control.
///
///
/// Enumeration used to specify
/// the type of relation encapsulated in an `atspi.Relation` object.
pub const RelationType = enum(c_int) {
    null = 0,
    label_for = 1,
    labelled_by = 2,
    controller_for = 3,
    controlled_by = 4,
    member_of = 5,
    tooltip_for = 6,
    node_child_of = 7,
    node_parent_of = 8,
    extended = 9,
    flows_to = 10,
    flows_from = 11,
    subwindow_of = 12,
    embeds = 13,
    embedded_by = 14,
    popup_for = 15,
    parent_window_of = 16,
    description_for = 17,
    described_by = 18,
    details = 19,
    details_for = 20,
    error_message = 21,
    error_for = 22,
    last_defined = 23,
    _,

    extern fn atspi_relation_type_get_type() usize;
    pub const getGObjectType = atspi_relation_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used by interface `atspi.Accessible` to specify the role
/// of an `atspi.Accessible` object.
pub const Role = enum(c_int) {
    invalid = 0,
    accelerator_label = 1,
    alert = 2,
    animation = 3,
    arrow = 4,
    calendar = 5,
    canvas = 6,
    check_box = 7,
    check_menu_item = 8,
    color_chooser = 9,
    column_header = 10,
    combo_box = 11,
    date_editor = 12,
    desktop_icon = 13,
    desktop_frame = 14,
    dial = 15,
    dialog = 16,
    directory_pane = 17,
    drawing_area = 18,
    file_chooser = 19,
    filler = 20,
    focus_traversable = 21,
    font_chooser = 22,
    frame = 23,
    glass_pane = 24,
    html_container = 25,
    icon = 26,
    image = 27,
    internal_frame = 28,
    label = 29,
    layered_pane = 30,
    list = 31,
    list_item = 32,
    menu = 33,
    menu_bar = 34,
    menu_item = 35,
    option_pane = 36,
    page_tab = 37,
    page_tab_list = 38,
    panel = 39,
    password_text = 40,
    popup_menu = 41,
    progress_bar = 42,
    button = 43,
    radio_button = 44,
    radio_menu_item = 45,
    root_pane = 46,
    row_header = 47,
    scroll_bar = 48,
    scroll_pane = 49,
    separator = 50,
    slider = 51,
    spin_button = 52,
    split_pane = 53,
    status_bar = 54,
    table = 55,
    table_cell = 56,
    table_column_header = 57,
    table_row_header = 58,
    tearoff_menu_item = 59,
    terminal = 60,
    text = 61,
    toggle_button = 62,
    tool_bar = 63,
    tool_tip = 64,
    tree = 65,
    tree_table = 66,
    unknown = 67,
    viewport = 68,
    window = 69,
    extended = 70,
    header = 71,
    footer = 72,
    paragraph = 73,
    ruler = 74,
    application = 75,
    autocomplete = 76,
    editbar = 77,
    embedded = 78,
    entry = 79,
    chart = 80,
    caption = 81,
    document_frame = 82,
    heading = 83,
    page = 84,
    section = 85,
    redundant_object = 86,
    form = 87,
    link = 88,
    input_method_window = 89,
    table_row = 90,
    tree_item = 91,
    document_spreadsheet = 92,
    document_presentation = 93,
    document_text = 94,
    document_web = 95,
    document_email = 96,
    comment = 97,
    list_box = 98,
    grouping = 99,
    image_map = 100,
    notification = 101,
    info_bar = 102,
    level_bar = 103,
    title_bar = 104,
    block_quote = 105,
    audio = 106,
    video = 107,
    definition = 108,
    article = 109,
    landmark = 110,
    log = 111,
    marquee = 112,
    math = 113,
    rating = 114,
    timer = 115,
    static = 116,
    math_fraction = 117,
    math_root = 118,
    subscript = 119,
    superscript = 120,
    description_list = 121,
    description_term = 122,
    description_value = 123,
    footnote = 124,
    content_deletion = 125,
    content_insertion = 126,
    mark = 127,
    suggestion = 128,
    push_button_menu = 129,
    @"switch" = 130,
    last_defined = 131,
    _,

    pub const push_button = Role.button;
    /// Gets the localized description string describing the `atspi.Role` `role`.
    extern fn atspi_role_get_localized_name(p_role: atspi.Role) [*:0]u8;
    pub const getLocalizedName = atspi_role_get_localized_name;

    /// Gets a localizable string that indicates the name of an `atspi.Role`.
    extern fn atspi_role_get_name(p_role: atspi.Role) [*:0]u8;
    pub const getName = atspi_role_get_name;

    extern fn atspi_role_get_type() usize;
    pub const getGObjectType = atspi_role_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used by interface `atspi.Accessible` to specify where an
/// `atspi.Accessible` object should be placed on the screen when using scroll_to.
pub const ScrollType = enum(c_int) {
    top_left = 0,
    bottom_right = 1,
    top_edge = 2,
    bottom_edge = 3,
    left_edge = 4,
    right_edge = 5,
    anywhere = 6,
    _,

    extern fn atspi_scroll_type_get_type() usize;
    pub const getGObjectType = atspi_scroll_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used by various interfaces indicating every possible state
/// an `AtspiAccesible` object can assume.
pub const StateType = enum(c_int) {
    invalid = 0,
    active = 1,
    armed = 2,
    busy = 3,
    checked = 4,
    collapsed = 5,
    defunct = 6,
    editable = 7,
    enabled = 8,
    expandable = 9,
    expanded = 10,
    focusable = 11,
    focused = 12,
    has_tooltip = 13,
    horizontal = 14,
    iconified = 15,
    modal = 16,
    multi_line = 17,
    multiselectable = 18,
    @"opaque" = 19,
    pressed = 20,
    resizable = 21,
    selectable = 22,
    selected = 23,
    sensitive = 24,
    showing = 25,
    single_line = 26,
    stale = 27,
    transient = 28,
    vertical = 29,
    visible = 30,
    manages_descendants = 31,
    indeterminate = 32,
    required = 33,
    truncated = 34,
    animated = 35,
    invalid_entry = 36,
    supports_autocompletion = 37,
    selectable_text = 38,
    is_default = 39,
    visited = 40,
    checkable = 41,
    has_popup = 42,
    read_only = 43,
    last_defined = 44,
    _,

    extern fn atspi_state_type_get_type() usize;
    pub const getGObjectType = atspi_state_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the boundary conditions determining a run of text as returned from
/// `atspi.Text.getTextAtOffset`, `atspi.Text.getTextAfterOffset`, and
/// `atspi.Text.getTextBeforeOffset`.
///
/// This enumerationis deprecated since 2.9.90 and should not be used. Use
/// AtspiTextGranularity with `atspi.Text.getStringAtOffset` instead.
pub const TextBoundaryType = enum(c_int) {
    char = 0,
    word_start = 1,
    word_end = 2,
    sentence_start = 3,
    sentence_end = 4,
    line_start = 5,
    line_end = 6,
    _,

    extern fn atspi_text_boundary_type_get_type() usize;
    pub const getGObjectType = atspi_text_boundary_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used by interface `atspi.Text` to indicate
/// how to treat characters intersecting bounding boxes.
pub const TextClipType = enum(c_int) {
    none = 0,
    min = 1,
    max = 2,
    both = 3,
    _,

    extern fn atspi_text_clip_type_get_type() usize;
    pub const getGObjectType = atspi_text_clip_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Text granularity types used for specifying the granularity of the region of
/// text we are interested in.
pub const TextGranularity = enum(c_int) {
    char = 0,
    word = 1,
    sentence = 2,
    line = 3,
    paragraph = 4,
    _,

    extern fn atspi_text_granularity_get_type() usize;
    pub const getGObjectType = atspi_text_granularity_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Cache = packed struct(c_uint) {
    parent: bool = false,
    children: bool = false,
    name: bool = false,
    description: bool = false,
    states: bool = false,
    role: bool = false,
    interfaces: bool = false,
    attributes: bool = false,
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
    undefined: bool = false,
    _padding31: bool = false,

    pub const flags_none: Cache = @bitCast(@as(c_uint, 0));
    pub const flags_parent: Cache = @bitCast(@as(c_uint, 1));
    pub const flags_children: Cache = @bitCast(@as(c_uint, 2));
    pub const flags_name: Cache = @bitCast(@as(c_uint, 4));
    pub const flags_description: Cache = @bitCast(@as(c_uint, 8));
    pub const flags_states: Cache = @bitCast(@as(c_uint, 16));
    pub const flags_role: Cache = @bitCast(@as(c_uint, 32));
    pub const flags_interfaces: Cache = @bitCast(@as(c_uint, 64));
    pub const flags_attributes: Cache = @bitCast(@as(c_uint, 128));
    pub const flags_all: Cache = @bitCast(@as(c_uint, 1073741823));
    pub const flags_default: Cache = @bitCast(@as(c_uint, 127));
    pub const flags_undefined: Cache = @bitCast(@as(c_uint, 1073741824));
    extern fn atspi_cache_get_type() usize;
    pub const getGObjectType = atspi_cache_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the type of a key listener event.
/// The values above can and should be bitwise-'OR'-ed
/// together, observing the compatibility limitations specified in the description of
/// each value.  For instance, `ATSPI_KEYLISTENER_ALL_WINDOWS` | `ATSPI_KEYLISTENER_CANCONSUME` is
/// a commonly used combination which gives the AT complete control over the delivery of matching
/// events.  However, such filters should be used sparingly as they may have a negative impact on
/// system performance.
pub const KeyListenerSyncType = packed struct(c_uint) {
    synchronous: bool = false,
    canconsume: bool = false,
    all_windows: bool = false,
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

    pub const flags_nosync: KeyListenerSyncType = @bitCast(@as(c_uint, 0));
    pub const flags_synchronous: KeyListenerSyncType = @bitCast(@as(c_uint, 1));
    pub const flags_canconsume: KeyListenerSyncType = @bitCast(@as(c_uint, 2));
    pub const flags_all_windows: KeyListenerSyncType = @bitCast(@as(c_uint, 4));
    extern fn atspi_key_listener_sync_type_get_type() usize;
    pub const getGObjectType = atspi_key_listener_sync_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Sets the watch and timeout functions of a `dbus.Connection`
/// to integrate the connection with the GLib main loop.
/// Pass in `NULL` for the `glib.MainContext` unless you're
/// doing something specialized.
///
/// If called twice for the same context, does nothing the second
/// time. If called once with context A and once with context B,
/// context B replaces context A as the context monitoring the
/// connection.
extern fn atspi_dbus_connection_setup_with_g_main(p_connection: *dbus.Connection, p_context: *glib.MainContext) void;
pub const dbusConnectionSetupWithGMain = atspi_dbus_connection_setup_with_g_main;

/// Sets the watch and timeout functions of a `DBusServer`
/// to integrate the server with the GLib main loop.
/// In most cases the context argument should be `NULL`.
///
/// If called twice for the same context, does nothing the second
/// time. If called once with context A and once with context B,
/// context B replaces context A as the context monitoring the
/// connection.
extern fn atspi_dbus_server_setup_with_g_main(p_server: *anyopaque, p_context: *glib.MainContext) void;
pub const dbusServerSetupWithGMain = atspi_dbus_server_setup_with_g_main;

/// Removes a device event listener from the registry's listener queue,
///            ceasing notification of events of the specified type.
extern fn atspi_deregister_device_event_listener(p_listener: *atspi.DeviceListener, p_filter: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
pub const deregisterDeviceEventListener = atspi_deregister_device_event_listener;

/// Removes a keystroke event listener from the registry's listener queue,
///            ceasing notification of events with modifiers matching `modmask`.
extern fn atspi_deregister_keystroke_listener(p_listener: *atspi.DeviceListener, p_key_set: ?*glib.Array, p_modmask: atspi.KeyMaskType, p_event_types: atspi.KeyEventMask, p_error: ?*?*glib.Error) c_int;
pub const deregisterKeystrokeListener = atspi_deregister_keystroke_listener;

/// Disconnects from `AtspiRegistry` instances and releases
/// any floating resources. Call only once at exit.
extern fn atspi_exit() c_int;
pub const exit = atspi_exit;

/// Synthesizes a keyboard event (as if a hardware keyboard event occurred in the
/// current UI context).
extern fn atspi_generate_keyboard_event(p_keyval: c_long, p_keystring: ?[*:0]const u8, p_synth_type: atspi.KeySynthType, p_error: ?*?*glib.Error) c_int;
pub const generateKeyboardEvent = atspi_generate_keyboard_event;

/// Synthesizes a mouse event at a specific screen coordinate.
/// Most AT clients should use the `AccessibleAction` interface when
/// tempted to generate mouse events, rather than this method.
/// Event names: b1p = button 1 press; b2r = button 2 release;
///              b3c = button 3 click; b2d = button 2 double-click;
///              abs = absolute motion; rel = relative motion.
extern fn atspi_generate_mouse_event(p_x: c_long, p_y: c_long, p_name: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
pub const generateMouseEvent = atspi_generate_mouse_event;

/// Like atspi_generate_mouse_event, but asynchronous.
extern fn atspi_generate_mouse_event_async(p_x: c_long, p_y: c_long, p_name: [*:0]const u8, p_callback: atspi.GenerateMouseEventCB, p_callback_data: ?*anyopaque, p_error: ?*?*glib.Error) void;
pub const generateMouseEventAsync = atspi_generate_mouse_event_async;

extern fn atspi_get_a11y_bus() *dbus.Connection;
pub const getA11yBus = atspi_get_a11y_bus;

/// Gets the virtual desktop indicated by index `i`.
/// NOTE: currently multiple virtual desktops are not implemented;
/// as a consequence, any `i` value different from 0 will not return a
/// virtual desktop - instead it will return NULL.
extern fn atspi_get_desktop(p_i: c_int) *atspi.Accessible;
pub const getDesktop = atspi_get_desktop;

/// Gets the number of virtual desktops.
/// NOTE: multiple virtual desktops are not implemented yet; as a
/// consequence, this function always returns 1.
extern fn atspi_get_desktop_count() c_int;
pub const getDesktopCount = atspi_get_desktop_count;

/// Gets the list of virtual desktops.  On return, `list` will point
///     to a newly-created, NULL terminated array of virtual desktop
///     pointers.
///     It is the responsibility of the caller to free this array when
///     it is no longer needed.
/// NOTE: currently multiple virtual desktops are not implemented;
/// this implementation always returns a `Garray` with a single
/// `atspi.Accessible` desktop.
extern fn atspi_get_desktop_list() *glib.Array;
pub const getDesktopList = atspi_get_desktop_list;

/// Returns the version of the AT-SPI library being used at runtime.
extern fn atspi_get_version(p_major: *c_int, p_minor: *c_int, p_micro: *c_int) void;
pub const getVersion = atspi_get_version;

/// Connects to the accessibility registry and initializes the SPI.
extern fn atspi_init() c_int;
pub const init = atspi_init;

/// Indicates whether AT-SPI has been initialized.
extern fn atspi_is_initialized() c_int;
pub const isInitialized = atspi_is_initialized;

/// This function does nothing and should not be called.
extern fn atspi_register_device_event_listener(p_listener: *atspi.DeviceListener, p_event_types: atspi.DeviceEventMask, p_filter: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
pub const registerDeviceEventListener = atspi_register_device_event_listener;

/// Registers a listener for keystroke events, either pre-emptively for
///             all windows (`ATSPI_KEYLISTENER_ALL_WINDOWS`),
///             non-preemptively (`ATSPI_KEYLISTENER_NOSYNC`), or
///             pre-emptively at the toolkit level (`ATSPI_KEYLISTENER_CANCONSUME`).
///             If ALL_WINDOWS or CANCONSUME are used, the event is consumed
///             upon receipt if one of `listener`'s callbacks returns `TRUE`
///             (other sync_type values may be available in the future).
extern fn atspi_register_keystroke_listener(p_listener: *atspi.DeviceListener, p_key_set: ?*glib.Array, p_modmask: atspi.KeyMaskType, p_event_types: atspi.KeyEventMask, p_sync_type: atspi.KeyListenerSyncType, p_error: ?*?*glib.Error) c_int;
pub const registerKeystrokeListener = atspi_register_keystroke_listener;

/// Sets the main loop context that AT-SPI should assume is in use when
/// setting an idle callback.
/// This function should be called by application-side implementors (ie,
/// at-spi2-atk) when it is desirable to re-enter the main loop.
extern fn atspi_set_main_context(p_cnx: *glib.MainContext) void;
pub const setMainContext = atspi_set_main_context;

/// Deprecated. This function no longer does anything and should not be used.
extern fn atspi_set_reference_window(p_accessible: *atspi.Accessible) void;
pub const setReferenceWindow = atspi_set_reference_window;

/// Set the timeout used for method calls. If this is not set explicitly,
/// a default of 800 ms is used.
/// Note that at-spi2-registryd currently uses a timeout of 3 seconds when
/// sending a keyboard event notification. This means that, if an AT makes
/// a call in response to the keyboard notification and the application
/// being called does not respond before the timeout is reached,
/// at-spi2-registryd will time out on the keyboard event notification and
/// pass the key onto the application (ie, reply to indicate that the key
/// was not consumed), so this may make it undesirable to set a timeout
/// larger than 3 seconds.
///
/// By default, the normal timeout is set to 800 ms, and the application startup
/// timeout is set to 15 seconds.
extern fn atspi_set_timeout(p_val: c_int, p_startup_time: c_int) void;
pub const setTimeout = atspi_set_timeout;

/// A callback function prototype via which clients receive device event notifications.
pub const DeviceListenerCB = *const fn (p_stroke: *atspi.DeviceEvent, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Similar to `atspi.DeviceListenerCB`, but with no user data.
pub const DeviceListenerSimpleCB = *const fn (p_stroke: *const atspi.DeviceEvent) callconv(.c) c_int;

/// A function prototype for callbacks via which clients are notified of AT-SPI events.
pub const EventListenerCB = *const fn (p_event: *atspi.Event, p_user_data: ?*anyopaque) callconv(.c) void;

/// Like `AtspiEventlistenerCB`, but with no user_data.
pub const EventListenerSimpleCB = *const fn (p_event: *const atspi.Event) callconv(.c) void;

pub const GenerateMouseEventCB = *const fn (p_user_data: ?*anyopaque) callconv(.c) void;

/// A callback that will be invoked when a key is pressed.
pub const KeyCallback = *const fn (p_device: *atspi.Device, p_pressed: c_int, p_keycode: c_uint, p_keysym: c_uint, p_modifiers: c_uint, p_keystring: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

/// One higher than the highest valid value of `atspi.ComponentLayer`.
pub const COMPONENTLAYER_COUNT = 9;
/// One higher than the highest valid value of `atspi.CoordType`.
pub const COORD_TYPE_COUNT = 3;
pub const DBUS_INTERFACE_ACCESSIBLE = "org.a11y.atspi.Accessible";
pub const DBUS_INTERFACE_ACTION = "org.a11y.atspi.Action";
pub const DBUS_INTERFACE_APPLICATION = "org.a11y.atspi.Application";
pub const DBUS_INTERFACE_CACHE = "org.a11y.atspi.Cache";
pub const DBUS_INTERFACE_COLLECTION = "org.a11y.atspi.Collection";
pub const DBUS_INTERFACE_COMPONENT = "org.a11y.atspi.Component";
pub const DBUS_INTERFACE_DEC = "org.a11y.atspi.DeviceEventController";
pub const DBUS_INTERFACE_DEVICE_EVENT_LISTENER = "org.a11y.atspi.DeviceEventListener";
pub const DBUS_INTERFACE_DOCUMENT = "org.a11y.atspi.Document";
pub const DBUS_INTERFACE_EDITABLE_TEXT = "org.a11y.atspi.EditableText";
pub const DBUS_INTERFACE_EVENT_KEYBOARD = "org.a11y.atspi.Event.Keyboard";
pub const DBUS_INTERFACE_EVENT_MOUSE = "org.a11y.atspi.Event.Mouse";
pub const DBUS_INTERFACE_EVENT_OBJECT = "org.a11y.atspi.Event.Object";
pub const DBUS_INTERFACE_EVENT_SCREEN_READER = "org.a11y.atspi.Event.ScreenReader";
pub const DBUS_INTERFACE_HYPERLINK = "org.a11y.atspi.Hyperlink";
pub const DBUS_INTERFACE_HYPERTEXT = "org.a11y.atspi.Hypertext";
pub const DBUS_INTERFACE_IMAGE = "org.a11y.atspi.Image";
pub const DBUS_INTERFACE_KEYBOARD_MONITOR = "org.freedesktop.a11y.KeyboardMonitor";
pub const DBUS_INTERFACE_REGISTRY = "org.a11y.atspi.Registry";
pub const DBUS_INTERFACE_SELECTION = "org.a11y.atspi.Selection";
pub const DBUS_INTERFACE_SOCKET = "org.a11y.atspi.Socket";
pub const DBUS_INTERFACE_TABLE = "org.a11y.atspi.Table";
pub const DBUS_INTERFACE_TABLE_CELL = "org.a11y.atspi.TableCell";
pub const DBUS_INTERFACE_TEXT = "org.a11y.atspi.Text";
pub const DBUS_INTERFACE_VALUE = "org.a11y.atspi.Value";
pub const DBUS_NAME_A11Y_MANAGER = "org.freedesktop.a11y.Manager";
pub const DBUS_NAME_REGISTRY = "org.a11y.atspi.Registry";
pub const DBUS_PATH_A11Y_MANAGER = "/org/freedesktop/a11y/Manager";
pub const DBUS_PATH_DEC = "/org/a11y/atspi/registry/deviceeventcontroller";
pub const DBUS_PATH_NULL = "/org/a11y/atspi/null";
pub const DBUS_PATH_REGISTRY = "/org/a11y/atspi/registry";
pub const DBUS_PATH_ROOT = "/org/a11y/atspi/accessible/root";
pub const DBUS_PATH_SCREEN_READER = "/org/a11y/atspi/screenreader";
pub const DEVICE_A11Y_MANAGER_VIRTUAL_MOD_END = 31;
pub const DEVICE_A11Y_MANAGER_VIRTUAL_MOD_START = 15;
/// One higher than the highest valid value of `atspi.EventType`.
pub const EVENTTYPE_COUNT = 4;
/// One higher than the highest valid value of `atspi.KeyEventType`.
pub const KEYEVENTTYPE_COUNT = 2;
/// One higher than the highest valid value of `atspi.KeySynthType`.
pub const KEYSYNTHTYPE_COUNT = 5;
/// One higher than the highest valid value of `atspi.LocaleType`.
pub const LOCALE_TYPE_COUNT = 6;
pub const MATCHTYPES_COUNT = 6;
/// One higher than the highest valid value of `atspi.ModifierType`.
pub const MODIFIERTYPE_COUNT = 8;
/// One higher than the highest valid value of `atspi.RelationType`.
pub const RELATIONTYPE_COUNT = 24;
/// One higher than the highest valid value of `atspi.Role`.
pub const ROLE_COUNT = 131;
/// One higher than the highest valid value of `atspi.ScrollType`.
pub const SCROLLTYPE_COUNT = 7;
/// One higher than the highest valid value of `atspi.CollectionSortOrder`.
pub const SORTORDER_COUNT = 8;
/// One higher than the highest valid value of `atspi.StateType`.
pub const STATETYPE_COUNT = 42;
/// One higher than the highest valid value of `atspi.TextBoundaryType`.
pub const TEXT_BOUNDARY_TYPE_COUNT = 7;
/// One higher than the highest valid value of `atspi.TextClipType`.
pub const TEXT_CLIP_TYPE_COUNT = 4;
/// One higher than the highest valid value of
/// `AtspiCollection_TreeTraversalType`.
pub const TREETRAVERSALTYPE_COUNT = 4;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
