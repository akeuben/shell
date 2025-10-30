pub const ext = @import("ext.zig");
const girepository = @This();

const std = @import("std");
const compat = @import("compat");
const gobject = @import("gobject2");
const glib = @import("glib2");
/// Represents an argument.
pub const ArgInfo = girepository.BaseInfo;

/// Represents a callable, either `girepository.FunctionInfo`, `girepository.CallbackInfo` or
/// `girepository.VFuncInfo`.
pub const CallableInfo = girepository.BaseInfo;

/// Represents a callback, eg arguments and return value.
pub const CallbackInfo = girepository.BaseInfo;

/// Represents a constant.
pub const ConstantInfo = girepository.BaseInfo;

/// Represents an enum or a flag.
pub const EnumInfo = girepository.BaseInfo;

/// Represents a field of a `girepository.StructInfo` or a `girepository.UnionInfo`.
pub const FieldInfo = girepository.BaseInfo;

/// Represents a function, eg arguments and return value.
pub const FunctionInfo = girepository.BaseInfo;

/// Represents an interface.
pub const InterfaceInfo = girepository.BaseInfo;

/// Represents an object.
pub const ObjectInfo = girepository.BaseInfo;

/// Represents a property of a `girepository.ObjectInfo` or a `girepository.InterfaceInfo`.
pub const PropertyInfo = girepository.BaseInfo;

/// Represent a registered type.
pub const RegisteredTypeInfo = girepository.BaseInfo;

/// Represents a signal.
pub const SignalInfo = girepository.BaseInfo;

/// Represents a struct.
pub const StructInfo = girepository.BaseInfo;

/// Represents type information, direction, transfer etc.
pub const TypeInfo = girepository.BaseInfo;

/// Represents a union.
pub const UnionInfo = girepository.BaseInfo;

/// Represents a virtual function.
pub const VFuncInfo = girepository.BaseInfo;

/// Represents a enum value of a `girepository.EnumInfo`.
pub const ValueInfo = girepository.BaseInfo;

/// `girepository.Repository` is used to manage repositories of namespaces. Namespaces
/// are represented on disk by type libraries (.typelib files).
///
/// ### Discovery of type libraries
///
/// `girepository.Repository` will typically look for a `girepository-1.0` directory
/// under the library directory used when compiling gobject-introspection.
///
/// It is possible to control the search paths programmatically, using
/// `girepository.Repository.prependSearchPath`. It is also possible to modify
/// the search paths by using the `GI_TYPELIB_PATH` environment variable.
/// The environment variable takes precedence over the default search path
/// and the `girepository.Repository.prependSearchPath` calls.
pub const Repository = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = girepository.RepositoryClass;
    f_parent: gobject.Object,
    f_priv: ?*girepository.RepositoryPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn g_irepository_dump(p_arg: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const dump = g_irepository_dump;

    extern fn g_irepository_error_quark() glib.Quark;
    pub const errorQuark = g_irepository_error_quark;

    /// Returns the singleton process-global default `girepository.Repository`. It is
    /// not currently supported to have multiple repositories in a
    /// particular process, but this function is provided in the unlikely
    /// eventuality that it would become possible, and as a convenience for
    /// higher level language bindings to conform to the GObject method
    /// call conventions.
    ///
    /// All methods on `girepository.Repository` also accept `NULL` as an instance
    /// parameter to mean this default repository, which is usually more
    /// convenient for C.
    extern fn g_irepository_get_default() *girepository.Repository;
    pub const getDefault = g_irepository_get_default;

    /// Obtain the option group for girepository, it's used
    /// by the dumper and for programs that wants to provide
    /// introspection information
    extern fn g_irepository_get_option_group() *glib.OptionGroup;
    pub const getOptionGroup = g_irepository_get_option_group;

    /// Returns the current search path `girepository.Repository` will use when loading
    /// typelib files. The list is internal to `girepository.Repository` and should not
    /// be freed, nor should its string elements.
    extern fn g_irepository_get_search_path() *glib.SList;
    pub const getSearchPath = g_irepository_get_search_path;

    extern fn g_irepository_prepend_library_path(p_directory: [*:0]const u8) void;
    pub const prependLibraryPath = g_irepository_prepend_library_path;

    /// Prepends `directory` to the typelib search path.
    ///
    /// See also: `girepository.Repository.getSearchPath`.
    extern fn g_irepository_prepend_search_path(p_directory: [*:0]const u8) void;
    pub const prependSearchPath = g_irepository_prepend_search_path;

    /// Obtain an unordered list of versions (either currently loaded or
    /// available) for `namespace_` in this `repository`.
    extern fn g_irepository_enumerate_versions(p_repository: ?*Repository, p_namespace_: [*:0]const u8) *glib.List;
    pub const enumerateVersions = g_irepository_enumerate_versions;

    /// Searches for the enum type corresponding to the given `glib.Error`
    /// domain. Before calling this function for a particular namespace,
    /// you must call `girepository.Repository.require` once to load the namespace, or
    /// otherwise ensure the namespace has already been loaded.
    extern fn g_irepository_find_by_error_domain(p_repository: ?*Repository, p_domain: glib.Quark) *girepository.EnumInfo;
    pub const findByErrorDomain = g_irepository_find_by_error_domain;

    /// Searches all loaded namespaces for a particular `gobject.Type`.  Note that
    /// in order to locate the metadata, the namespace corresponding to
    /// the type must first have been loaded.  There is currently no
    /// mechanism for determining the namespace which corresponds to an
    /// arbitrary GType - thus, this function will operate most reliably
    /// when you know the GType to originate from be from a loaded namespace.
    extern fn g_irepository_find_by_gtype(p_repository: ?*Repository, p_gtype: usize) *girepository.BaseInfo;
    pub const findByGtype = g_irepository_find_by_gtype;

    /// Searches for a particular entry in a namespace.  Before calling
    /// this function for a particular namespace, you must call
    /// `girepository.Repository.require` once to load the namespace, or otherwise
    /// ensure the namespace has already been loaded.
    extern fn g_irepository_find_by_name(p_repository: ?*Repository, p_namespace_: [*:0]const u8, p_name: [*:0]const u8) *girepository.BaseInfo;
    pub const findByName = g_irepository_find_by_name;

    /// This function returns the "C prefix", or the C level namespace
    /// associated with the given introspection namespace.  Each C symbol
    /// starts with this prefix, as well each `gobject.Type` in the library.
    ///
    /// Note: The namespace must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this function.
    extern fn g_irepository_get_c_prefix(p_repository: ?*Repository, p_namespace_: [*:0]const u8) [*:0]const u8;
    pub const getCPrefix = g_irepository_get_c_prefix;

    /// Retrieves all (transitive) versioned dependencies for
    /// `namespace_`.
    ///
    /// The strings are of the form `namespace-version`.
    ///
    /// Note: `namespace_` must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this function.
    ///
    /// To get only the immediate dependencies for `namespace_`, use
    /// `girepository.Repository.getImmediateDependencies`.
    extern fn g_irepository_get_dependencies(p_repository: ?*Repository, p_namespace_: [*:0]const u8) [*][*:0]u8;
    pub const getDependencies = g_irepository_get_dependencies;

    /// Return an array of the immediate versioned dependencies for `namespace_`.
    /// Returned strings are of the form `namespace-version`.
    ///
    /// Note: `namespace_` must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this function.
    ///
    /// To get the transitive closure of dependencies for `namespace_`, use
    /// `girepository.Repository.getDependencies`.
    extern fn g_irepository_get_immediate_dependencies(p_repository: ?*Repository, p_namespace_: [*:0]const u8) [*][*:0]u8;
    pub const getImmediateDependencies = g_irepository_get_immediate_dependencies;

    /// This function returns a particular metadata entry in the
    /// given namespace `namespace_`.  The namespace must have
    /// already been loaded before calling this function.
    /// See `girepository.Repository.getNInfos` to find the maximum number of
    /// entries.
    extern fn g_irepository_get_info(p_repository: ?*Repository, p_namespace_: [*:0]const u8, p_index: c_int) *girepository.BaseInfo;
    pub const getInfo = g_irepository_get_info;

    /// Return the list of currently loaded namespaces.
    extern fn g_irepository_get_loaded_namespaces(p_repository: ?*Repository) [*][*:0]u8;
    pub const getLoadedNamespaces = g_irepository_get_loaded_namespaces;

    /// This function returns the number of metadata entries in
    /// given namespace `namespace_`.  The namespace must have
    /// already been loaded before calling this function.
    extern fn g_irepository_get_n_infos(p_repository: ?*Repository, p_namespace_: [*:0]const u8) c_int;
    pub const getNInfos = g_irepository_get_n_infos;

    /// Look up the implemented interfaces for `gtype`.  This function
    /// cannot fail per se; but for a totally "unknown" `gobject.Type`, it may
    /// return 0 implemented interfaces.
    ///
    /// The semantics of this function are designed for a dynamic binding,
    /// where in certain cases (such as a function which returns an
    /// interface which may have "hidden" implementation classes), not all
    /// data may be statically known, and will have to be determined from
    /// the `gobject.Type` of the object.  An example is `g_file_new_for_path`
    /// returning a concrete class of `GLocalFile`, which is a `gobject.Type` we
    /// see at runtime, but not statically.
    extern fn g_irepository_get_object_gtype_interfaces(p_repository: ?*Repository, p_gtype: usize, p_n_interfaces_out: *c_uint, p_interfaces_out: *[*]*girepository.InterfaceInfo) void;
    pub const getObjectGtypeInterfaces = g_irepository_get_object_gtype_interfaces;

    /// This function returns a comma-separated list of paths to the
    /// shared C libraries associated with the given namespace `namespace_`.
    /// There may be no shared library path associated, in which case this
    /// function will return `NULL`.
    ///
    /// Note: The namespace must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this function.
    extern fn g_irepository_get_shared_library(p_repository: ?*Repository, p_namespace_: [*:0]const u8) ?[*:0]const u8;
    pub const getSharedLibrary = g_irepository_get_shared_library;

    /// If namespace `namespace_` is loaded, return the full path to the
    /// .typelib file it was loaded from.  If the typelib for
    /// namespace `namespace_` was included in a shared library, return
    /// the special string "&lt;builtin&gt;".
    extern fn g_irepository_get_typelib_path(p_repository: ?*Repository, p_namespace_: [*:0]const u8) [*:0]const u8;
    pub const getTypelibPath = g_irepository_get_typelib_path;

    /// This function returns the loaded version associated with the given
    /// namespace `namespace_`.
    ///
    /// Note: The namespace must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this function.
    extern fn g_irepository_get_version(p_repository: ?*Repository, p_namespace_: [*:0]const u8) [*:0]const u8;
    pub const getVersion = g_irepository_get_version;

    /// Check whether a particular namespace (and optionally, a specific
    /// version thereof) is currently loaded.  This function is likely to
    /// only be useful in unusual circumstances; in order to act upon
    /// metadata in the namespace, you should call `girepository.Repository.require`
    /// instead which will ensure the namespace is loaded, and return as
    /// quickly as this function will if it has already been loaded.
    extern fn g_irepository_is_registered(p_repository: ?*Repository, p_namespace_: [*:0]const u8, p_version: ?[*:0]const u8) c_int;
    pub const isRegistered = g_irepository_is_registered;

    /// TODO
    extern fn g_irepository_load_typelib(p_repository: ?*Repository, p_typelib: *girepository.Typelib, p_flags: girepository.RepositoryLoadFlags, p_error: ?*?*glib.Error) ?[*:0]const u8;
    pub const loadTypelib = g_irepository_load_typelib;

    /// Force the namespace `namespace_` to be loaded if it isn't already.
    /// If `namespace_` is not loaded, this function will search for a
    /// ".typelib" file using the repository search path.  In addition, a
    /// version `version` of namespace may be specified.  If `version` is
    /// not specified, the latest will be used.
    extern fn g_irepository_require(p_repository: ?*Repository, p_namespace_: [*:0]const u8, p_version: ?[*:0]const u8, p_flags: girepository.RepositoryLoadFlags, p_error: ?*?*glib.Error) ?*girepository.Typelib;
    pub const require = g_irepository_require;

    /// Force the namespace `namespace_` to be loaded if it isn't already.
    /// If `namespace_` is not loaded, this function will search for a
    /// ".typelib" file within the private directory only. In addition, a
    /// version `version` of namespace should be specified.  If `version` is
    /// not specified, the latest will be used.
    extern fn g_irepository_require_private(p_repository: ?*Repository, p_typelib_dir: [*:0]const u8, p_namespace_: [*:0]const u8, p_version: ?[*:0]const u8, p_flags: girepository.RepositoryLoadFlags, p_error: ?*?*glib.Error) ?*girepository.Typelib;
    pub const requirePrivate = g_irepository_require_private;

    extern fn g_irepository_get_type() usize;
    pub const getGObjectType = g_irepository_get_type;

    extern fn g_object_ref(p_self: *girepository.Repository) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *girepository.Repository) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Repository, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque structure used to iterate over attributes
/// in a `girepository.BaseInfo` struct.
pub const AttributeIter = extern struct {
    f_data: ?*anyopaque,
    f_data2: ?*anyopaque,
    f_data3: ?*anyopaque,
    f_data4: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// GIBaseInfo is the common base struct of all other Info structs
/// accessible through the `girepository.Repository` API.
///
/// All info structures can be cast to a `girepository.BaseInfo`, for instance:
///
/// ```
///    GIFunctionInfo *function_info = ...;
///    GIBaseInfo *info = (GIBaseInfo *) function_info;
/// ```
///
/// Most `girepository.Repository` APIs returning a `girepository.BaseInfo` is actually
/// creating a new struct; in other words, `girepository.BaseInfo.unref` has to
/// be called when done accessing the data.
///
/// `girepository.BaseInfo` structuress are normally accessed by calling either
/// `girepository.Repository.findByName`, `girepository.Repository.findByGtype` or
/// `girepository.Repository.getInfo`.
///
/// ```
/// GIBaseInfo *button_info =
///   g_irepository_find_by_name (NULL, "Gtk", "Button");
///
/// // ... use button_info ...
///
/// g_base_info_unref (button_info);
/// ```
///
/// ## Hierarchy
///
/// ```
///   GIBaseInfo
///    +---- GIArgInfo
///    +---- GICallableInfo
///    +---- GIConstantInfo
///    +---- GIFieldInfo
///    +---- GIPropertyInfo
///    +---- GIRegisteredTypeInfo
///    +---- GITypeInfo
/// ```
pub const BaseInfo = extern struct {
    f_dummy1: i32,
    f_dummy2: i32,
    f_dummy3: ?*anyopaque,
    f_dummy4: ?*anyopaque,
    f_dummy5: ?*anyopaque,
    f_dummy6: u32,
    f_dummy7: u32,
    f_padding: [4]*anyopaque,

    /// Compare two `girepository.BaseInfo`.
    ///
    /// Using pointer comparison is not practical since many functions return
    /// different instances of `girepository.BaseInfo` that refers to the same part of the
    /// TypeLib; use this function instead to do `girepository.BaseInfo` comparisons.
    extern fn g_base_info_equal(p_info1: *BaseInfo, p_info2: *girepository.BaseInfo) c_int;
    pub const equal = g_base_info_equal;

    /// Retrieve an arbitrary attribute associated with this node.
    extern fn g_base_info_get_attribute(p_info: *BaseInfo, p_name: [*:0]const u8) [*:0]const u8;
    pub const getAttribute = g_base_info_get_attribute;

    /// Obtain the container of the `info`. The container is the parent
    /// GIBaseInfo. For instance, the parent of a `girepository.FunctionInfo` is an
    /// `girepository.ObjectInfo` or `girepository.InterfaceInfo`.
    extern fn g_base_info_get_container(p_info: *BaseInfo) *girepository.BaseInfo;
    pub const getContainer = g_base_info_get_container;

    /// Obtain the name of the `info`. What the name represents depends on
    /// the `girepository.InfoType` of the `info`. For instance for `girepository.FunctionInfo` it is
    /// the name of the function.
    extern fn g_base_info_get_name(p_info: *BaseInfo) [*:0]const u8;
    pub const getName = g_base_info_get_name;

    /// Obtain the namespace of `info`.
    extern fn g_base_info_get_namespace(p_info: *BaseInfo) [*:0]const u8;
    pub const getNamespace = g_base_info_get_namespace;

    /// Obtain the info type of the GIBaseInfo.
    extern fn g_base_info_get_type(p_info: *BaseInfo) girepository.InfoType;
    pub const getType = g_base_info_get_type;

    /// Obtain the typelib this `info` belongs to
    extern fn g_base_info_get_typelib(p_info: *BaseInfo) *girepository.Typelib;
    pub const getTypelib = g_base_info_get_typelib;

    /// Obtain whether the `info` is represents a metadata which is
    /// deprecated or not.
    extern fn g_base_info_is_deprecated(p_info: *BaseInfo) c_int;
    pub const isDeprecated = g_base_info_is_deprecated;

    /// Iterate over all attributes associated with this node.  The iterator
    /// structure is typically stack allocated, and must have its first
    /// member initialized to `NULL`.  Attributes are arbitrary namespaced key–value
    /// pairs which can be attached to almost any item.  They are intended for use
    /// by software higher in the toolchain than bindings, and are distinct from
    /// normal GIR annotations.
    ///
    /// Both the `name` and `value` should be treated as constants
    /// and must not be freed.
    ///
    /// ```
    /// void
    /// print_attributes (GIBaseInfo *info)
    /// {
    ///   GIAttributeIter iter = { 0, };
    ///   char *name;
    ///   char *value;
    ///   while (g_base_info_iterate_attributes (info, &iter, &name, &value))
    ///     {
    ///       g_print ("attribute name: `s` value: `s`", name, value);
    ///     }
    /// }
    /// ```
    extern fn g_base_info_iterate_attributes(p_info: *BaseInfo, p_iterator: *girepository.AttributeIter, p_name: *[*:0]u8, p_value: *[*:0]u8) c_int;
    pub const iterateAttributes = g_base_info_iterate_attributes;

    /// Increases the reference count of `info`.
    extern fn g_base_info_ref(p_info: *BaseInfo) *girepository.BaseInfo;
    pub const ref = g_base_info_ref;

    /// Decreases the reference count of `info`. When its reference count
    /// drops to 0, the info is freed.
    extern fn g_base_info_unref(p_info: *BaseInfo) void;
    pub const unref = g_base_info_unref;

    extern fn g_base_info_gtype_get_type() usize;
    pub const getGObjectType = g_base_info_gtype_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RepositoryClass = extern struct {
    pub const Instance = girepository.Repository;

    f_parent: gobject.ObjectClass,

    pub fn as(p_instance: *RepositoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RepositoryPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// TODO
pub const Typelib = opaque {
    extern fn g_typelib_new_from_const_memory(p_memory: *const u8, p_len: usize, p_error: ?*?*glib.Error) ?*girepository.Typelib;
    pub const newFromConstMemory = g_typelib_new_from_const_memory;

    extern fn g_typelib_new_from_mapped_file(p_mfile: *glib.MappedFile, p_error: ?*?*glib.Error) ?*girepository.Typelib;
    pub const newFromMappedFile = g_typelib_new_from_mapped_file;

    extern fn g_typelib_new_from_memory(p_memory: *u8, p_len: usize, p_error: ?*?*glib.Error) ?*girepository.Typelib;
    pub const newFromMemory = g_typelib_new_from_memory;

    extern fn g_typelib_free(p_typelib: *Typelib) void;
    pub const free = g_typelib_free;

    extern fn g_typelib_get_namespace(p_typelib: *Typelib) [*:0]const u8;
    pub const getNamespace = g_typelib_get_namespace;

    extern fn g_typelib_symbol(p_typelib: *Typelib, p_symbol_name: [*:0]const u8, p_symbol: ?*anyopaque) c_int;
    pub const symbol = g_typelib_symbol;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a unresolved type in a typelib.
pub const UnresolvedInfo = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Stores an argument of varying type
pub const Argument = extern union {
    /// TODO
    f_v_boolean: c_int,
    /// TODO
    f_v_int8: i8,
    /// TODO
    f_v_uint8: u8,
    /// TODO
    f_v_int16: i16,
    /// TODO
    f_v_uint16: u16,
    /// TODO
    f_v_int32: i32,
    /// TODO
    f_v_uint32: u32,
    /// TODO
    f_v_int64: i64,
    /// TODO
    f_v_uint64: u64,
    /// TODO
    f_v_float: f32,
    /// TODO
    f_v_double: f64,
    /// TODO
    f_v_short: c_short,
    /// TODO
    f_v_ushort: c_ushort,
    /// TODO
    f_v_int: c_int,
    /// TODO
    f_v_uint: c_uint,
    /// TODO
    f_v_long: c_long,
    /// TODO
    f_v_ulong: c_ulong,
    /// TODO
    f_v_ssize: isize,
    /// TODO
    f_v_size: usize,
    /// TODO
    f_v_string: ?[*:0]u8,
    /// TODO
    f_v_pointer: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of array in a `girepository.TypeInfo`.
pub const ArrayType = enum(c_int) {
    c = 0,
    array = 1,
    ptr_array = 2,
    byte_array = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The direction of a `girepository.ArgInfo`.
pub const Direction = enum(c_int) {
    in = 0,
    out = 1,
    inout = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of a GIBaseInfo struct.
pub const InfoType = enum(c_int) {
    invalid = 0,
    function = 1,
    callback = 2,
    @"struct" = 3,
    boxed = 4,
    @"enum" = 5,
    flags = 6,
    object = 7,
    interface = 8,
    constant = 9,
    invalid_0 = 10,
    @"union" = 11,
    value = 12,
    signal = 13,
    vfunc = 14,
    property = 15,
    field = 16,
    arg = 17,
    type = 18,
    unresolved = 19,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An error code used with `G_IREPOSITORY_ERROR` in a `glib.Error` returned
/// from a `girepository.Repository` routine.
pub const RepositoryError = enum(c_int) {
    typelib_not_found = 0,
    namespace_mismatch = 1,
    namespace_version_conflict = 2,
    library_not_found = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Scope type of a `girepository.ArgInfo` representing callback, determines how the
/// callback is invoked and is used to decided when the invoke structs
/// can be freed.
pub const ScopeType = enum(c_int) {
    invalid = 0,
    call = 1,
    async = 2,
    notified = 3,
    forever = 4,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The transfer is the exchange of data between two parts, from the callee to
/// the caller. The callee is either a function/method/signal or an
/// object/interface where a property is defined. The caller is the side
/// accessing a property or calling a function.
/// `girepository.Transfer` specifies who's responsible for freeing the resources after the
/// ownership transfer is complete. In case of a containing type such as a list,
/// an array or a hash table the container itself is specified differently from
/// the items within the container itself. Each container is freed differently,
/// check the documentation for the types themselves for information on how to
/// free them.
pub const Transfer = enum(c_int) {
    nothing = 0,
    container = 1,
    everything = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type tag of a `girepository.TypeInfo`.
pub const TypeTag = enum(c_int) {
    void = 0,
    boolean = 1,
    int8 = 2,
    uint8 = 3,
    int16 = 4,
    uint16 = 5,
    int32 = 6,
    uint32 = 7,
    int64 = 8,
    uint64 = 9,
    float = 10,
    double = 11,
    gtype = 12,
    utf8 = 13,
    filename = 14,
    array = 15,
    interface = 16,
    glist = 17,
    gslist = 18,
    ghash = 19,
    @"error" = 20,
    unichar = 21,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An error occuring while invoking a function via
/// `girepository.functionInfoInvoke`.
pub const nvokeError = enum(c_int) {
    failed = 0,
    symbol_not_found = 1,
    argument_mismatch = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags for a `girepository.FieldInfo`.
pub const FieldInfoFlags = packed struct(c_uint) {
    readable: bool = false,
    writable: bool = false,
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

    pub const flags_readable: FieldInfoFlags = @bitCast(@as(c_uint, 1));
    pub const flags_writable: FieldInfoFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags for a `girepository.FunctionInfo` struct.
pub const FunctionInfoFlags = packed struct(c_uint) {
    is_method: bool = false,
    is_constructor: bool = false,
    is_getter: bool = false,
    is_setter: bool = false,
    wraps_vfunc: bool = false,
    throws: bool = false,
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

    pub const flags_is_method: FunctionInfoFlags = @bitCast(@as(c_uint, 1));
    pub const flags_is_constructor: FunctionInfoFlags = @bitCast(@as(c_uint, 2));
    pub const flags_is_getter: FunctionInfoFlags = @bitCast(@as(c_uint, 4));
    pub const flags_is_setter: FunctionInfoFlags = @bitCast(@as(c_uint, 8));
    pub const flags_wraps_vfunc: FunctionInfoFlags = @bitCast(@as(c_uint, 16));
    pub const flags_throws: FunctionInfoFlags = @bitCast(@as(c_uint, 32));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that control how a typelib is loaded.
pub const RepositoryLoadFlags = packed struct(c_uint) {
    irepository_load_flag_lazy: bool = false,
    _padding1: bool = false,
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

    pub const flags_irepository_load_flag_lazy: RepositoryLoadFlags = @bitCast(@as(c_uint, 1));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags of a `girepository.VFuncInfo` struct.
pub const VFuncInfoFlags = packed struct(c_uint) {
    must_chain_up: bool = false,
    must_override: bool = false,
    must_not_override: bool = false,
    throws: bool = false,
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

    pub const flags_must_chain_up: VFuncInfoFlags = @bitCast(@as(c_uint, 1));
    pub const flags_must_override: VFuncInfoFlags = @bitCast(@as(c_uint, 2));
    pub const flags_must_not_override: VFuncInfoFlags = @bitCast(@as(c_uint, 4));
    pub const flags_throws: VFuncInfoFlags = @bitCast(@as(c_uint, 8));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Obtain the index of the user data argument. This is only valid
/// for arguments which are callbacks.
extern fn g_arg_info_get_closure(p_info: *girepository.ArgInfo) c_int;
pub const argInfoGetClosure = g_arg_info_get_closure;

/// Obtains the index of the `glib.DestroyNotify` argument. This is only valid
/// for arguments which are callbacks.
extern fn g_arg_info_get_destroy(p_info: *girepository.ArgInfo) c_int;
pub const argInfoGetDestroy = g_arg_info_get_destroy;

/// Obtain the direction of the argument. Check `girepository.Direction` for possible
/// direction values.
extern fn g_arg_info_get_direction(p_info: *girepository.ArgInfo) girepository.Direction;
pub const argInfoGetDirection = g_arg_info_get_direction;

/// Obtain the ownership transfer for this argument.
/// `girepository.Transfer` contains a list of possible values.
extern fn g_arg_info_get_ownership_transfer(p_info: *girepository.ArgInfo) girepository.Transfer;
pub const argInfoGetOwnershipTransfer = g_arg_info_get_ownership_transfer;

/// Obtain the scope type for this argument. The scope type explains
/// how a callback is going to be invoked, most importantly when
/// the resources required to invoke it can be freed.
/// `girepository.ScopeType` contains a list of possible values.
extern fn g_arg_info_get_scope(p_info: *girepository.ArgInfo) girepository.ScopeType;
pub const argInfoGetScope = g_arg_info_get_scope;

/// Obtain the type information for `info`.
extern fn g_arg_info_get_type(p_info: *girepository.ArgInfo) *girepository.TypeInfo;
pub const argInfoGetType = g_arg_info_get_type;

/// Obtain if the argument is a pointer to a struct or object that will
/// receive an output of a function.  The default assumption for
/// `GI_DIRECTION_OUT` arguments which have allocation is that the
/// callee allocates; if this is `TRUE`, then the caller must allocate.
extern fn g_arg_info_is_caller_allocates(p_info: *girepository.ArgInfo) c_int;
pub const argInfoIsCallerAllocates = g_arg_info_is_caller_allocates;

/// Obtain if the argument is optional.  For 'out' arguments this means
/// that you can pass `NULL` in order to ignore the result.
extern fn g_arg_info_is_optional(p_info: *girepository.ArgInfo) c_int;
pub const argInfoIsOptional = g_arg_info_is_optional;

/// Obtain if the argument is a return value. It can either be a
/// parameter or a return value.
extern fn g_arg_info_is_return_value(p_info: *girepository.ArgInfo) c_int;
pub const argInfoIsReturnValue = g_arg_info_is_return_value;

/// Obtain if an argument is only useful in C.
extern fn g_arg_info_is_skip(p_info: *girepository.ArgInfo) c_int;
pub const argInfoIsSkip = g_arg_info_is_skip;

/// Obtain information about a the type of given argument `info`; this
/// function is a variant of `girepository.argInfoGetType` designed for stack
/// allocation.
///
/// The initialized `type` must not be referenced after `info` is deallocated.
extern fn g_arg_info_load_type(p_info: *girepository.ArgInfo, p_type: *girepository.TypeInfo) void;
pub const argInfoLoadType = g_arg_info_load_type;

/// Obtain if the type of the argument includes the possibility of `NULL`.
/// For 'in' values this means that `NULL` is a valid value.  For 'out'
/// values, this means that `NULL` may be returned.
///
/// See also `girepository.argInfoIsOptional`.
extern fn g_arg_info_may_be_null(p_info: *girepository.ArgInfo) c_int;
pub const argInfoMayBeNull = g_arg_info_may_be_null;

/// TODO
extern fn g_callable_info_can_throw_gerror(p_info: *girepository.CallableInfo) c_int;
pub const callableInfoCanThrowGerror = g_callable_info_can_throw_gerror;

/// Obtain information about a particular argument of this callable.
extern fn g_callable_info_get_arg(p_info: *girepository.CallableInfo, p_n: c_int) *girepository.ArgInfo;
pub const callableInfoGetArg = g_callable_info_get_arg;

/// See whether the caller owns the return value of this callable.
/// `girepository.Transfer` contains a list of possible transfer values.
extern fn g_callable_info_get_caller_owns(p_info: *girepository.CallableInfo) girepository.Transfer;
pub const callableInfoGetCallerOwns = g_callable_info_get_caller_owns;

/// Obtains the ownership transfer for the instance argument.
/// `girepository.Transfer` contains a list of possible transfer values.
extern fn g_callable_info_get_instance_ownership_transfer(p_info: *girepository.CallableInfo) girepository.Transfer;
pub const callableInfoGetInstanceOwnershipTransfer = g_callable_info_get_instance_ownership_transfer;

/// Obtain the number of arguments (both IN and OUT) for this callable.
extern fn g_callable_info_get_n_args(p_info: *girepository.CallableInfo) c_int;
pub const callableInfoGetNArgs = g_callable_info_get_n_args;

/// Retrieve an arbitrary attribute associated with the return value.
extern fn g_callable_info_get_return_attribute(p_info: *girepository.CallableInfo, p_name: [*:0]const u8) [*:0]const u8;
pub const callableInfoGetReturnAttribute = g_callable_info_get_return_attribute;

/// Obtain the return type of a callable item as a `girepository.TypeInfo`.
extern fn g_callable_info_get_return_type(p_info: *girepository.CallableInfo) *girepository.TypeInfo;
pub const callableInfoGetReturnType = g_callable_info_get_return_type;

/// TODO
extern fn g_callable_info_invoke(p_info: *girepository.CallableInfo, p_function: ?*anyopaque, p_in_args: [*]const girepository.Argument, p_n_in_args: c_int, p_out_args: [*]const girepository.Argument, p_n_out_args: c_int, p_return_value: *girepository.Argument, p_is_method: c_int, p_throws: c_int, p_error: ?*?*glib.Error) c_int;
pub const callableInfoInvoke = g_callable_info_invoke;

/// Determines if the callable info is a method. For `girepository.VFuncInfo`<!-- -->s,
/// `girepository.CallbackInfo`<!-- -->s, and `girepository.SignalInfo`<!-- -->s,
/// this is always true. Otherwise, this looks at the `GI_FUNCTION_IS_METHOD`
/// flag on the `girepository.FunctionInfo`.
///
/// Concretely, this function returns whether `girepository.callableInfoGetNArgs`
/// matches the number of arguments in the raw C method. For methods, there
/// is one more C argument than is exposed by introspection: the "self"
/// or "this" object.
extern fn g_callable_info_is_method(p_info: *girepository.CallableInfo) c_int;
pub const callableInfoIsMethod = g_callable_info_is_method;

/// Iterate over all attributes associated with the return value.  The
/// iterator structure is typically stack allocated, and must have its
/// first member initialized to `NULL`.
///
/// Both the `name` and `value` should be treated as constants
/// and must not be freed.
///
/// See `girepository.BaseInfo.iterateAttributes` for an example of how to use a
/// similar API.
extern fn g_callable_info_iterate_return_attributes(p_info: *girepository.CallableInfo, p_iterator: *girepository.AttributeIter, p_name: *[*:0]u8, p_value: *[*:0]u8) c_int;
pub const callableInfoIterateReturnAttributes = g_callable_info_iterate_return_attributes;

/// Obtain information about a particular argument of this callable; this
/// function is a variant of `girepository.callableInfoGetArg` designed for stack
/// allocation.
///
/// The initialized `arg` must not be referenced after `info` is deallocated.
extern fn g_callable_info_load_arg(p_info: *girepository.CallableInfo, p_n: c_int, p_arg: *girepository.ArgInfo) void;
pub const callableInfoLoadArg = g_callable_info_load_arg;

/// Obtain information about a return value of callable; this
/// function is a variant of `girepository.callableInfoGetReturnType` designed for stack
/// allocation.
///
/// The initialized `type` must not be referenced after `info` is deallocated.
extern fn g_callable_info_load_return_type(p_info: *girepository.CallableInfo, p_type: *girepository.TypeInfo) void;
pub const callableInfoLoadReturnType = g_callable_info_load_return_type;

/// See if a callable could return `NULL`.
extern fn g_callable_info_may_return_null(p_info: *girepository.CallableInfo) c_int;
pub const callableInfoMayReturnNull = g_callable_info_may_return_null;

/// See if a callable's return value is only useful in C.
extern fn g_callable_info_skip_return(p_info: *girepository.CallableInfo) c_int;
pub const callableInfoSkipReturn = g_callable_info_skip_return;

extern fn gi_cclosure_marshal_generic(p_closure: *gobject.Closure, p_return_gvalue: *gobject.Value, p_n_param_values: c_uint, p_param_values: *const gobject.Value, p_invocation_hint: ?*anyopaque, p_marshal_data: ?*anyopaque) void;
pub const cclosureMarshalGeneric = gi_cclosure_marshal_generic;

/// Free the value returned from `girepository.constantInfoGetValue`.
extern fn g_constant_info_free_value(p_info: *girepository.ConstantInfo, p_value: *girepository.Argument) void;
pub const constantInfoFreeValue = g_constant_info_free_value;

/// Obtain the type of the constant as a `girepository.TypeInfo`.
extern fn g_constant_info_get_type(p_info: *girepository.ConstantInfo) *girepository.TypeInfo;
pub const constantInfoGetType = g_constant_info_get_type;

/// Obtain the value associated with the `girepository.ConstantInfo` and store it in the
/// `value` parameter. `argument` needs to be allocated before passing it in.
/// The size of the constant value stored in `argument` will be returned.
/// Free the value with `girepository.constantInfoFreeValue`.
extern fn g_constant_info_get_value(p_info: *girepository.ConstantInfo, p_value: *girepository.Argument) c_int;
pub const constantInfoGetValue = g_constant_info_get_value;

/// Obtain the string form of the quark for the error domain associated with
/// this enum, if any.
extern fn g_enum_info_get_error_domain(p_info: *girepository.EnumInfo) [*:0]const u8;
pub const enumInfoGetErrorDomain = g_enum_info_get_error_domain;

/// Obtain an enum type method at index `n`.
extern fn g_enum_info_get_method(p_info: *girepository.EnumInfo, p_n: c_int) *girepository.FunctionInfo;
pub const enumInfoGetMethod = g_enum_info_get_method;

/// Obtain the number of methods that this enum type has.
extern fn g_enum_info_get_n_methods(p_info: *girepository.EnumInfo) c_int;
pub const enumInfoGetNMethods = g_enum_info_get_n_methods;

/// Obtain the number of values this enumeration contains.
extern fn g_enum_info_get_n_values(p_info: *girepository.EnumInfo) c_int;
pub const enumInfoGetNValues = g_enum_info_get_n_values;

/// Obtain the tag of the type used for the enum in the C ABI. This will
/// will be a signed or unsigned integral type.
///
/// Note that in the current implementation the width of the type is
/// computed correctly, but the signed or unsigned nature of the type
/// may not match the sign of the type used by the C compiler.
extern fn g_enum_info_get_storage_type(p_info: *girepository.EnumInfo) girepository.TypeTag;
pub const enumInfoGetStorageType = g_enum_info_get_storage_type;

/// Obtain a value for this enumeration.
extern fn g_enum_info_get_value(p_info: *girepository.EnumInfo, p_n: c_int) *girepository.ValueInfo;
pub const enumInfoGetValue = g_enum_info_get_value;

/// Reads a field identified by a `girepository.FieldInfo` from a C structure or
/// union.  This only handles fields of simple C types. It will fail
/// for a field of a composite type like a nested structure or union
/// even if that is actually readable.
extern fn g_field_info_get_field(p_field_info: *girepository.FieldInfo, p_mem: ?*anyopaque, p_value: *girepository.Argument) c_int;
pub const fieldInfoGetField = g_field_info_get_field;

/// Obtain the flags for this `girepository.FieldInfo`. See `girepository.FieldInfoFlags` for possible
/// flag values.
extern fn g_field_info_get_flags(p_info: *girepository.FieldInfo) girepository.FieldInfoFlags;
pub const fieldInfoGetFlags = g_field_info_get_flags;

/// Obtain the offset in bytes of the field member, this is relative
/// to the beginning of the struct or union.
extern fn g_field_info_get_offset(p_info: *girepository.FieldInfo) c_int;
pub const fieldInfoGetOffset = g_field_info_get_offset;

/// Obtain the size in bits of the field member, this is how
/// much space you need to allocate to store the field.
extern fn g_field_info_get_size(p_info: *girepository.FieldInfo) c_int;
pub const fieldInfoGetSize = g_field_info_get_size;

/// Obtain the type of a field as a `girepository.TypeInfo`.
extern fn g_field_info_get_type(p_info: *girepository.FieldInfo) *girepository.TypeInfo;
pub const fieldInfoGetType = g_field_info_get_type;

/// Writes a field identified by a `girepository.FieldInfo` to a C structure or
/// union.  This only handles fields of simple C types. It will fail
/// for a field of a composite type like a nested structure or union
/// even if that is actually writable. Note also that that it will refuse
/// to write fields where memory management would by required. A field
/// with a type such as 'char *' must be set with a setter function.
extern fn g_field_info_set_field(p_field_info: *girepository.FieldInfo, p_mem: ?*anyopaque, p_value: *const girepository.Argument) c_int;
pub const fieldInfoSetField = g_field_info_set_field;

/// Obtain the `girepository.FunctionInfoFlags` for the `info`.
extern fn g_function_info_get_flags(p_info: *girepository.FunctionInfo) girepository.FunctionInfoFlags;
pub const functionInfoGetFlags = g_function_info_get_flags;

/// Obtain the property associated with this `girepository.FunctionInfo`.
/// Only `girepository.FunctionInfo` with the flag `GI_FUNCTION_IS_GETTER` or
/// `GI_FUNCTION_IS_SETTER` have a property set. For other cases,
/// `NULL` will be returned.
extern fn g_function_info_get_property(p_info: *girepository.FunctionInfo) *girepository.PropertyInfo;
pub const functionInfoGetProperty = g_function_info_get_property;

/// Obtain the symbol of the function. The symbol is the name of the
/// exported function, suitable to be used as an argument to
/// `g_module_symbol`.
extern fn g_function_info_get_symbol(p_info: *girepository.FunctionInfo) [*:0]const u8;
pub const functionInfoGetSymbol = g_function_info_get_symbol;

/// Obtain the virtual function associated with this `girepository.FunctionInfo`.
/// Only `girepository.FunctionInfo` with the flag `GI_FUNCTION_WRAPS_VFUNC` has
/// a virtual function set. For other cases, `NULL` will be returned.
extern fn g_function_info_get_vfunc(p_info: *girepository.FunctionInfo) *girepository.VFuncInfo;
pub const functionInfoGetVfunc = g_function_info_get_vfunc;

/// Invokes the function described in `info` with the given
/// arguments. Note that inout parameters must appear in both
/// argument lists. This function uses `dlsym` to obtain a pointer
/// to the function, so the library or shared object containing the
/// described function must either be linked to the caller, or must
/// have been `g_module_symbol`<!-- -->ed before calling this function.
extern fn g_function_info_invoke(p_info: *girepository.FunctionInfo, p_in_args: [*]const girepository.Argument, p_n_in_args: c_int, p_out_args: [*]const girepository.Argument, p_n_out_args: c_int, p_return_value: *girepository.Argument, p_error: ?*?*glib.Error) c_int;
pub const functionInfoInvoke = g_function_info_invoke;

/// Returns the major version number of the girepository library.
/// (e.g. in version 1.58.2 this is 1.)
extern fn gi_get_major_version() c_uint;
pub const getMajorVersion = gi_get_major_version;

/// Returns the micro version number of the girepository library.
/// (e.g. in version 1.58.2 this is 2.)
extern fn gi_get_micro_version() c_uint;
pub const getMicroVersion = gi_get_micro_version;

/// Returns the minor version number of the girepository library.
/// (e.g. in version 1.58.2 this is 58.)
extern fn gi_get_minor_version() c_uint;
pub const getMinorVersion = gi_get_minor_version;

/// TODO
extern fn g_info_new(p_type: girepository.InfoType, p_container: *girepository.BaseInfo, p_typelib: *girepository.Typelib, p_offset: u32) *girepository.BaseInfo;
pub const infoNew = g_info_new;

/// Obtain a string representation of `type`
extern fn g_info_type_to_string(p_type: girepository.InfoType) [*:0]const u8;
pub const infoTypeToString = g_info_type_to_string;

/// Obtain a method of the interface type given a `name`. `NULL` will be
/// returned if there's no method available with that name.
extern fn g_interface_info_find_method(p_info: *girepository.InterfaceInfo, p_name: [*:0]const u8) *girepository.FunctionInfo;
pub const interfaceInfoFindMethod = g_interface_info_find_method;

/// TODO
extern fn g_interface_info_find_signal(p_info: *girepository.InterfaceInfo, p_name: [*:0]const u8) *girepository.SignalInfo;
pub const interfaceInfoFindSignal = g_interface_info_find_signal;

/// Locate a virtual function slot with name `name`. See the documentation
/// for `girepository.objectInfoFindVfunc` for more information on virtuals.
extern fn g_interface_info_find_vfunc(p_info: *girepository.InterfaceInfo, p_name: [*:0]const u8) *girepository.VFuncInfo;
pub const interfaceInfoFindVfunc = g_interface_info_find_vfunc;

/// Obtain an interface type constant at index `n`.
extern fn g_interface_info_get_constant(p_info: *girepository.InterfaceInfo, p_n: c_int) *girepository.ConstantInfo;
pub const interfaceInfoGetConstant = g_interface_info_get_constant;

/// Returns the layout C structure associated with this `GInterface`.
extern fn g_interface_info_get_iface_struct(p_info: *girepository.InterfaceInfo) *girepository.StructInfo;
pub const interfaceInfoGetIfaceStruct = g_interface_info_get_iface_struct;

/// Obtain an interface type method at index `n`.
extern fn g_interface_info_get_method(p_info: *girepository.InterfaceInfo, p_n: c_int) *girepository.FunctionInfo;
pub const interfaceInfoGetMethod = g_interface_info_get_method;

/// Obtain the number of constants that this interface type has.
extern fn g_interface_info_get_n_constants(p_info: *girepository.InterfaceInfo) c_int;
pub const interfaceInfoGetNConstants = g_interface_info_get_n_constants;

/// Obtain the number of methods that this interface type has.
extern fn g_interface_info_get_n_methods(p_info: *girepository.InterfaceInfo) c_int;
pub const interfaceInfoGetNMethods = g_interface_info_get_n_methods;

/// Obtain the number of prerequisites for this interface type.
/// A prerequisites is another interface that needs to be implemented for
/// interface, similar to an base class for GObjects.
extern fn g_interface_info_get_n_prerequisites(p_info: *girepository.InterfaceInfo) c_int;
pub const interfaceInfoGetNPrerequisites = g_interface_info_get_n_prerequisites;

/// Obtain the number of properties that this interface type has.
extern fn g_interface_info_get_n_properties(p_info: *girepository.InterfaceInfo) c_int;
pub const interfaceInfoGetNProperties = g_interface_info_get_n_properties;

/// Obtain the number of signals that this interface type has.
extern fn g_interface_info_get_n_signals(p_info: *girepository.InterfaceInfo) c_int;
pub const interfaceInfoGetNSignals = g_interface_info_get_n_signals;

/// Obtain the number of virtual functions that this interface type has.
extern fn g_interface_info_get_n_vfuncs(p_info: *girepository.InterfaceInfo) c_int;
pub const interfaceInfoGetNVfuncs = g_interface_info_get_n_vfuncs;

/// Obtain an interface type prerequisites index `n`.
extern fn g_interface_info_get_prerequisite(p_info: *girepository.InterfaceInfo, p_n: c_int) *girepository.BaseInfo;
pub const interfaceInfoGetPrerequisite = g_interface_info_get_prerequisite;

/// Obtain an interface type property at index `n`.
extern fn g_interface_info_get_property(p_info: *girepository.InterfaceInfo, p_n: c_int) *girepository.PropertyInfo;
pub const interfaceInfoGetProperty = g_interface_info_get_property;

/// Obtain an interface type signal at index `n`.
extern fn g_interface_info_get_signal(p_info: *girepository.InterfaceInfo, p_n: c_int) *girepository.SignalInfo;
pub const interfaceInfoGetSignal = g_interface_info_get_signal;

/// Obtain an interface type virtual function at index `n`.
extern fn g_interface_info_get_vfunc(p_info: *girepository.InterfaceInfo, p_n: c_int) *girepository.VFuncInfo;
pub const interfaceInfoGetVfunc = g_interface_info_get_vfunc;

/// TODO
extern fn g_invoke_error_quark() glib.Quark;
pub const invokeErrorQuark = g_invoke_error_quark;

/// Obtain a method of the object type given a `name`. `NULL` will be
/// returned if there's no method available with that name.
extern fn g_object_info_find_method(p_info: *girepository.ObjectInfo, p_name: [*:0]const u8) ?*girepository.FunctionInfo;
pub const objectInfoFindMethod = g_object_info_find_method;

/// Obtain a method of the object given a `name`, searching both the
/// object `info` and any interfaces it implements.  `NULL` will be
/// returned if there's no method available with that name.
///
/// Note that this function does *not* search parent classes; you will have
/// to chain up if that's desired.
extern fn g_object_info_find_method_using_interfaces(p_info: *girepository.ObjectInfo, p_name: [*:0]const u8, p_implementor: **girepository.ObjectInfo) ?*girepository.FunctionInfo;
pub const objectInfoFindMethodUsingInterfaces = g_object_info_find_method_using_interfaces;

/// TODO
extern fn g_object_info_find_signal(p_info: *girepository.ObjectInfo, p_name: [*:0]const u8) ?*girepository.SignalInfo;
pub const objectInfoFindSignal = g_object_info_find_signal;

/// Locate a virtual function slot with name `name`. Note that the namespace
/// for virtuals is distinct from that of methods; there may or may not be
/// a concrete method associated for a virtual. If there is one, it may
/// be retrieved using `girepository.vfuncInfoGetInvoker`, otherwise `NULL` will be
/// returned.
/// See the documentation for `girepository.vfuncInfoGetInvoker` for more
/// information on invoking virtuals.
extern fn g_object_info_find_vfunc(p_info: *girepository.ObjectInfo, p_name: [*:0]const u8) ?*girepository.VFuncInfo;
pub const objectInfoFindVfunc = g_object_info_find_vfunc;

/// Locate a virtual function slot with name `name`, searching both the object
/// `info` and any interfaces it implements.  Note that the namespace for
/// virtuals is distinct from that of methods; there may or may not be a
/// concrete method associated for a virtual. If there is one, it may be
/// retrieved using `girepository.vfuncInfoGetInvoker`, otherwise `NULL` will be
/// returned.
///
/// Note that this function does *not* search parent classes; you will have
/// to chain up if that's desired.
extern fn g_object_info_find_vfunc_using_interfaces(p_info: *girepository.ObjectInfo, p_name: [*:0]const u8, p_implementor: **girepository.ObjectInfo) ?*girepository.VFuncInfo;
pub const objectInfoFindVfuncUsingInterfaces = g_object_info_find_vfunc_using_interfaces;

/// Obtain if the object type is an abstract type, eg if it cannot be
/// instantiated
extern fn g_object_info_get_abstract(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetAbstract = g_object_info_get_abstract;

/// Every `gobject.Object` has two structures; an instance structure and a class
/// structure.  This function returns the metadata for the class structure.
extern fn g_object_info_get_class_struct(p_info: *girepository.ObjectInfo) ?*girepository.StructInfo;
pub const objectInfoGetClassStruct = g_object_info_get_class_struct;

/// Obtain an object type constant at index `n`.
extern fn g_object_info_get_constant(p_info: *girepository.ObjectInfo, p_n: c_int) *girepository.ConstantInfo;
pub const objectInfoGetConstant = g_object_info_get_constant;

/// Obtain an object type field at index `n`.
extern fn g_object_info_get_field(p_info: *girepository.ObjectInfo, p_n: c_int) *girepository.FieldInfo;
pub const objectInfoGetField = g_object_info_get_field;

/// Checks whether the object type is a final type, i.e. if it cannot
/// be derived
extern fn g_object_info_get_final(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetFinal = g_object_info_get_final;

/// Obtain if the object type is of a fundamental type which is not
/// G_TYPE_OBJECT. This is mostly for supporting GstMiniObject.
extern fn g_object_info_get_fundamental(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetFundamental = g_object_info_get_fundamental;

/// Obtain the symbol name of the function that should be called to convert
/// an object instance pointer of this object type to a GValue.
/// I's mainly used fundamental types. The type signature for the symbol
/// is `girepository.ObjectInfoGetValueFunction`, to fetch the function pointer
/// see `girepository.objectInfoGetGetValueFunction`.
extern fn g_object_info_get_get_value_function(p_info: *girepository.ObjectInfo) ?[*:0]const u8;
pub const objectInfoGetGetValueFunction = g_object_info_get_get_value_function;

/// Obtain a pointer to a function which can be used to
/// extract an instance of this object type out of a GValue.
/// This takes derivation into account and will reversely traverse
/// the base classes of this type, starting at the top type.
extern fn g_object_info_get_get_value_function_pointer(p_info: *girepository.ObjectInfo) ?girepository.ObjectInfoGetValueFunction;
pub const objectInfoGetGetValueFunctionPointer = g_object_info_get_get_value_function_pointer;

/// Obtain an object type interface at index `n`.
extern fn g_object_info_get_interface(p_info: *girepository.ObjectInfo, p_n: c_int) *girepository.InterfaceInfo;
pub const objectInfoGetInterface = g_object_info_get_interface;

/// Obtain an object type method at index `n`.
extern fn g_object_info_get_method(p_info: *girepository.ObjectInfo, p_n: c_int) *girepository.FunctionInfo;
pub const objectInfoGetMethod = g_object_info_get_method;

/// Obtain the number of constants that this object type has.
extern fn g_object_info_get_n_constants(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetNConstants = g_object_info_get_n_constants;

/// Obtain the number of fields that this object type has.
extern fn g_object_info_get_n_fields(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetNFields = g_object_info_get_n_fields;

/// Obtain the number of interfaces that this object type has.
extern fn g_object_info_get_n_interfaces(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetNInterfaces = g_object_info_get_n_interfaces;

/// Obtain the number of methods that this object type has.
extern fn g_object_info_get_n_methods(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetNMethods = g_object_info_get_n_methods;

/// Obtain the number of properties that this object type has.
extern fn g_object_info_get_n_properties(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetNProperties = g_object_info_get_n_properties;

/// Obtain the number of signals that this object type has.
extern fn g_object_info_get_n_signals(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetNSignals = g_object_info_get_n_signals;

/// Obtain the number of virtual functions that this object type has.
extern fn g_object_info_get_n_vfuncs(p_info: *girepository.ObjectInfo) c_int;
pub const objectInfoGetNVfuncs = g_object_info_get_n_vfuncs;

/// Obtain the parent of the object type.
extern fn g_object_info_get_parent(p_info: *girepository.ObjectInfo) ?*girepository.ObjectInfo;
pub const objectInfoGetParent = g_object_info_get_parent;

/// Obtain an object type property at index `n`.
extern fn g_object_info_get_property(p_info: *girepository.ObjectInfo, p_n: c_int) *girepository.PropertyInfo;
pub const objectInfoGetProperty = g_object_info_get_property;

/// Obtain the symbol name of the function that should be called to ref this
/// object type. It's mainly used fundamental types. The type signature for
/// the symbol is `girepository.ObjectInfoRefFunction`, to fetch the function pointer
/// see `girepository.objectInfoGetRefFunction`.
extern fn g_object_info_get_ref_function(p_info: *girepository.ObjectInfo) ?[*:0]const u8;
pub const objectInfoGetRefFunction = g_object_info_get_ref_function;

/// Obtain a pointer to a function which can be used to
/// increase the reference count an instance of this object type.
/// This takes derivation into account and will reversely traverse
/// the base classes of this type, starting at the top type.
extern fn g_object_info_get_ref_function_pointer(p_info: *girepository.ObjectInfo) ?girepository.ObjectInfoRefFunction;
pub const objectInfoGetRefFunctionPointer = g_object_info_get_ref_function_pointer;

/// Obtain the symbol name of the function that should be called to convert
/// set a GValue giving an object instance pointer of this object type.
/// I's mainly used fundamental types. The type signature for the symbol
/// is `girepository.ObjectInfoSetValueFunction`, to fetch the function pointer
/// see `girepository.objectInfoGetSetValueFunction`.
extern fn g_object_info_get_set_value_function(p_info: *girepository.ObjectInfo) ?[*:0]const u8;
pub const objectInfoGetSetValueFunction = g_object_info_get_set_value_function;

/// Obtain a pointer to a function which can be used to
/// set a GValue given an instance of this object type.
/// This takes derivation into account and will reversely traverse
/// the base classes of this type, starting at the top type.
extern fn g_object_info_get_set_value_function_pointer(p_info: *girepository.ObjectInfo) ?girepository.ObjectInfoSetValueFunction;
pub const objectInfoGetSetValueFunctionPointer = g_object_info_get_set_value_function_pointer;

/// Obtain an object type signal at index `n`.
extern fn g_object_info_get_signal(p_info: *girepository.ObjectInfo, p_n: c_int) *girepository.SignalInfo;
pub const objectInfoGetSignal = g_object_info_get_signal;

/// Obtain the function which when called will return the GType
/// function for which this object type is registered.
extern fn g_object_info_get_type_init(p_info: *girepository.ObjectInfo) [*:0]const u8;
pub const objectInfoGetTypeInit = g_object_info_get_type_init;

/// Obtain the name of the objects class/type.
extern fn g_object_info_get_type_name(p_info: *girepository.ObjectInfo) [*:0]const u8;
pub const objectInfoGetTypeName = g_object_info_get_type_name;

/// Obtain the symbol name of the function that should be called to unref this
/// object type. It's mainly used fundamental types. The type signature for
/// the symbol is `girepository.ObjectInfoUnrefFunction`, to fetch the function pointer
/// see `girepository.objectInfoGetUnrefFunction`.
extern fn g_object_info_get_unref_function(p_info: *girepository.ObjectInfo) ?[*:0]const u8;
pub const objectInfoGetUnrefFunction = g_object_info_get_unref_function;

/// Obtain a pointer to a function which can be used to
/// decrease the reference count an instance of this object type.
/// This takes derivation into account and will reversely traverse
/// the base classes of this type, starting at the top type.
extern fn g_object_info_get_unref_function_pointer(p_info: *girepository.ObjectInfo) ?girepository.ObjectInfoUnrefFunction;
pub const objectInfoGetUnrefFunctionPointer = g_object_info_get_unref_function_pointer;

/// Obtain an object type virtual function at index `n`.
extern fn g_object_info_get_vfunc(p_info: *girepository.ObjectInfo, p_n: c_int) *girepository.VFuncInfo;
pub const objectInfoGetVfunc = g_object_info_get_vfunc;

/// Obtain the flags for this property info. See `gobject.ParamFlags` for
/// more information about possible flag values.
extern fn g_property_info_get_flags(p_info: *girepository.PropertyInfo) gobject.ParamFlags;
pub const propertyInfoGetFlags = g_property_info_get_flags;

/// Obtains the getter function associated with this `girepository.PropertyInfo`.
///
/// The setter is only available for `G_PARAM_READABLE` properties.
extern fn g_property_info_get_getter(p_info: *girepository.PropertyInfo) ?*girepository.FunctionInfo;
pub const propertyInfoGetGetter = g_property_info_get_getter;

/// Obtain the ownership transfer for this property. See `girepository.Transfer` for more
/// information about transfer values.
extern fn g_property_info_get_ownership_transfer(p_info: *girepository.PropertyInfo) girepository.Transfer;
pub const propertyInfoGetOwnershipTransfer = g_property_info_get_ownership_transfer;

/// Obtains the setter function associated with this `girepository.PropertyInfo`.
///
/// The setter is only available for `G_PARAM_WRITABLE` properties that
/// are also not `G_PARAM_CONSTRUCT_ONLY`.
extern fn g_property_info_get_setter(p_info: *girepository.PropertyInfo) ?*girepository.FunctionInfo;
pub const propertyInfoGetSetter = g_property_info_get_setter;

/// Obtain the type information for the property `info`.
extern fn g_property_info_get_type(p_info: *girepository.PropertyInfo) *girepository.TypeInfo;
pub const propertyInfoGetType = g_property_info_get_type;

/// Obtain the `gobject.Type` for this registered type or G_TYPE_NONE which a special meaning.
/// It means that either there is no type information associated with this `info` or
/// that the shared library which provides the type_init function for this
/// `info` cannot be called.
extern fn g_registered_type_info_get_g_type(p_info: *girepository.RegisteredTypeInfo) usize;
pub const registeredTypeInfoGetGType = g_registered_type_info_get_g_type;

/// Obtain the type init function for `info`. The type init function is the
/// function which will register the GType within the GObject type system.
/// Usually this is not called by langauge bindings or applications, use
/// `girepository.registeredTypeInfoGetGType` directly instead.
extern fn g_registered_type_info_get_type_init(p_info: *girepository.RegisteredTypeInfo) [*:0]const u8;
pub const registeredTypeInfoGetTypeInit = g_registered_type_info_get_type_init;

/// Obtain the type name of the struct within the GObject type system.
/// This type can be passed to `gobject.typeName` to get a `gobject.Type`.
extern fn g_registered_type_info_get_type_name(p_info: *girepository.RegisteredTypeInfo) [*:0]const u8;
pub const registeredTypeInfoGetTypeName = g_registered_type_info_get_type_name;

/// Obtain the class closure for this signal if one is set. The class
/// closure is a virtual function on the type that the signal belongs to.
/// If the signal lacks a closure `NULL` will be returned.
extern fn g_signal_info_get_class_closure(p_info: *girepository.SignalInfo) *girepository.VFuncInfo;
pub const signalInfoGetClassClosure = g_signal_info_get_class_closure;

/// Obtain the flags for this signal info. See `gobject.SignalFlags` for
/// more information about possible flag values.
extern fn g_signal_info_get_flags(p_info: *girepository.SignalInfo) gobject.SignalFlags;
pub const signalInfoGetFlags = g_signal_info_get_flags;

/// Obtain if the returning true in the signal handler will
/// stop the emission of the signal.
extern fn g_signal_info_true_stops_emit(p_info: *girepository.SignalInfo) c_int;
pub const signalInfoTrueStopsEmit = g_signal_info_true_stops_emit;

/// Obtain the type information for field named `name`.
extern fn g_struct_info_find_field(p_info: *girepository.StructInfo, p_name: [*:0]const u8) *girepository.FieldInfo;
pub const structInfoFindField = g_struct_info_find_field;

/// Obtain the type information for method named `name`.
extern fn g_struct_info_find_method(p_info: *girepository.StructInfo, p_name: [*:0]const u8) *girepository.FunctionInfo;
pub const structInfoFindMethod = g_struct_info_find_method;

/// Obtain the required alignment of the structure.
extern fn g_struct_info_get_alignment(p_info: *girepository.StructInfo) usize;
pub const structInfoGetAlignment = g_struct_info_get_alignment;

/// Retrieves the name of the copy function for `info`, if any is set.
extern fn g_struct_info_get_copy_function(p_info: *girepository.StructInfo) ?[*:0]const u8;
pub const structInfoGetCopyFunction = g_struct_info_get_copy_function;

/// Obtain the type information for field with specified index.
extern fn g_struct_info_get_field(p_info: *girepository.StructInfo, p_n: c_int) *girepository.FieldInfo;
pub const structInfoGetField = g_struct_info_get_field;

/// Retrieves the name of the free function for `info`, if any is set.
extern fn g_struct_info_get_free_function(p_info: *girepository.StructInfo) ?[*:0]const u8;
pub const structInfoGetFreeFunction = g_struct_info_get_free_function;

/// Obtain the type information for method with specified index.
extern fn g_struct_info_get_method(p_info: *girepository.StructInfo, p_n: c_int) *girepository.FunctionInfo;
pub const structInfoGetMethod = g_struct_info_get_method;

/// Obtain the number of fields this structure has.
extern fn g_struct_info_get_n_fields(p_info: *girepository.StructInfo) c_int;
pub const structInfoGetNFields = g_struct_info_get_n_fields;

/// Obtain the number of methods this structure has.
extern fn g_struct_info_get_n_methods(p_info: *girepository.StructInfo) c_int;
pub const structInfoGetNMethods = g_struct_info_get_n_methods;

/// Obtain the total size of the structure.
extern fn g_struct_info_get_size(p_info: *girepository.StructInfo) usize;
pub const structInfoGetSize = g_struct_info_get_size;

/// TODO
extern fn g_struct_info_is_foreign(p_info: *girepository.StructInfo) c_int;
pub const structInfoIsForeign = g_struct_info_is_foreign;

/// Return true if this structure represents the "class structure" for some
/// `gobject.Object` or `GInterface`.  This function is mainly useful to hide this kind of structure
/// from generated public APIs.
extern fn g_struct_info_is_gtype_struct(p_info: *girepository.StructInfo) c_int;
pub const structInfoIsGtypeStruct = g_struct_info_is_gtype_struct;

/// GLib data structures, such as `glib.List`, `glib.SList`, and `glib.HashTable`, all store
/// data pointers.
/// In the case where the list or hash table is storing single types rather than
/// structs, these data pointers may have values stuffed into them via macros
/// such as `GPOINTER_TO_INT`.
///
/// Use this function to ensure that all values are correctly extracted from
/// stuffed pointers, regardless of the machine's architecture or endianness.
///
/// This function fills in the appropriate field of `arg` with the value extracted
/// from `hash_pointer`, depending on the storage type of `info`.
extern fn g_type_info_argument_from_hash_pointer(p_info: *girepository.TypeInfo, p_hash_pointer: ?*anyopaque, p_arg: *girepository.Argument) void;
pub const typeInfoArgumentFromHashPointer = g_type_info_argument_from_hash_pointer;

/// Obtain the fixed array size of the type. The type tag must be a
/// `GI_TYPE_TAG_ARRAY` or -1 will be returned.
extern fn g_type_info_get_array_fixed_size(p_info: *girepository.TypeInfo) c_int;
pub const typeInfoGetArrayFixedSize = g_type_info_get_array_fixed_size;

/// Obtain the position of the argument which gives the array length of the type.
/// The type tag must be a `GI_TYPE_TAG_ARRAY` or -1 will be returned.
extern fn g_type_info_get_array_length(p_info: *girepository.TypeInfo) c_int;
pub const typeInfoGetArrayLength = g_type_info_get_array_length;

/// Obtain the array type for this type. See `girepository.ArrayType` for a list of
/// possible values. If the type tag of this type is not array, -1 will be
/// returned.
extern fn g_type_info_get_array_type(p_info: *girepository.TypeInfo) girepository.ArrayType;
pub const typeInfoGetArrayType = g_type_info_get_array_type;

/// For types which have `GI_TYPE_TAG_INTERFACE` such as GObjects and boxed values,
/// this function returns full information about the referenced type.  You can then
/// inspect the type of the returned `girepository.BaseInfo` to further query whether it is
/// a concrete GObject, a GInterface, a structure, etc. using `girepository.BaseInfo.getType`.
extern fn g_type_info_get_interface(p_info: *girepository.TypeInfo) *girepository.BaseInfo;
pub const typeInfoGetInterface = g_type_info_get_interface;

/// Obtain the parameter type `n`.
extern fn g_type_info_get_param_type(p_info: *girepository.TypeInfo, p_n: c_int) *girepository.TypeInfo;
pub const typeInfoGetParamType = g_type_info_get_param_type;

/// Obtain the type tag corresponding to the underlying storage type in C for
/// the type.
/// See `girepository.TypeTag` for a list of type tags.
extern fn g_type_info_get_storage_type(p_info: *girepository.TypeInfo) girepository.TypeTag;
pub const typeInfoGetStorageType = g_type_info_get_storage_type;

/// Obtain the type tag for the type. See `girepository.TypeTag` for a list
/// of type tags.
extern fn g_type_info_get_tag(p_info: *girepository.TypeInfo) girepository.TypeTag;
pub const typeInfoGetTag = g_type_info_get_tag;

/// GLib data structures, such as `glib.List`, `glib.SList`, and `glib.HashTable`, all store
/// data pointers.
/// In the case where the list or hash table is storing single types rather than
/// structs, these data pointers may have values stuffed into them via macros
/// such as `GPOINTER_TO_INT`.
///
/// Use this function to ensure that all values are correctly stuffed into
/// pointers, regardless of the machine's architecture or endianness.
///
/// This function returns a pointer stuffed with the appropriate field of `arg`,
/// depending on the storage type of `info`.
extern fn g_type_info_hash_pointer_from_argument(p_info: *girepository.TypeInfo, p_arg: *girepository.Argument) ?*anyopaque;
pub const typeInfoHashPointerFromArgument = g_type_info_hash_pointer_from_argument;

/// Obtain if the type is passed as a reference.
///
/// Note that the types of `GI_DIRECTION_OUT` and `GI_DIRECTION_INOUT` parameters
/// will only be pointers if the underlying type being transferred is a pointer
/// (i.e. only if the type of the C function’s formal parameter is a pointer to a
/// pointer).
extern fn g_type_info_is_pointer(p_info: *girepository.TypeInfo) c_int;
pub const typeInfoIsPointer = g_type_info_is_pointer;

/// Obtain if the last element of the array is `NULL`. The type tag must be a
/// `GI_TYPE_TAG_ARRAY` or `FALSE` will be returned.
extern fn g_type_info_is_zero_terminated(p_info: *girepository.TypeInfo) c_int;
pub const typeInfoIsZeroTerminated = g_type_info_is_zero_terminated;

/// GLib data structures, such as `glib.List`, `glib.SList`, and `glib.HashTable`, all store
/// data pointers.
/// In the case where the list or hash table is storing single types rather than
/// structs, these data pointers may have values stuffed into them via macros
/// such as `GPOINTER_TO_INT`.
///
/// Use this function to ensure that all values are correctly extracted from
/// stuffed pointers, regardless of the machine's architecture or endianness.
///
/// This function fills in the appropriate field of `arg` with the value extracted
/// from `hash_pointer`, depending on `storage_type`.
extern fn gi_type_tag_argument_from_hash_pointer(p_storage_type: girepository.TypeTag, p_hash_pointer: ?*anyopaque, p_arg: *girepository.Argument) void;
pub const typeTagArgumentFromHashPointer = gi_type_tag_argument_from_hash_pointer;

/// GLib data structures, such as `glib.List`, `glib.SList`, and `glib.HashTable`, all store
/// data pointers.
/// In the case where the list or hash table is storing single types rather than
/// structs, these data pointers may have values stuffed into them via macros
/// such as `GPOINTER_TO_INT`.
///
/// Use this function to ensure that all values are correctly stuffed into
/// pointers, regardless of the machine's architecture or endianness.
///
/// This function returns a pointer stuffed with the appropriate field of `arg`,
/// depending on `storage_type`.
extern fn gi_type_tag_hash_pointer_from_argument(p_storage_type: girepository.TypeTag, p_arg: *girepository.Argument) ?*anyopaque;
pub const typeTagHashPointerFromArgument = gi_type_tag_hash_pointer_from_argument;

/// Obtain a string representation of `type`
extern fn g_type_tag_to_string(p_type: girepository.TypeTag) [*:0]const u8;
pub const typeTagToString = g_type_tag_to_string;

/// Obtain the type information for method named `name`.
extern fn g_union_info_find_method(p_info: *girepository.UnionInfo, p_name: [*:0]const u8) *girepository.FunctionInfo;
pub const unionInfoFindMethod = g_union_info_find_method;

/// Obtain the required alignment of the union.
extern fn g_union_info_get_alignment(p_info: *girepository.UnionInfo) usize;
pub const unionInfoGetAlignment = g_union_info_get_alignment;

/// Retrieves the name of the copy function for `info`, if any is set.
extern fn g_union_info_get_copy_function(p_info: *girepository.UnionInfo) ?[*:0]const u8;
pub const unionInfoGetCopyFunction = g_union_info_get_copy_function;

/// Obtain discriminator value assigned for n-th union field, i.e. n-th
/// union field is the active one if discriminator contains this
/// constant.
extern fn g_union_info_get_discriminator(p_info: *girepository.UnionInfo, p_n: c_int) *girepository.ConstantInfo;
pub const unionInfoGetDiscriminator = g_union_info_get_discriminator;

/// Returns offset of the discriminator field in the structure.
extern fn g_union_info_get_discriminator_offset(p_info: *girepository.UnionInfo) c_int;
pub const unionInfoGetDiscriminatorOffset = g_union_info_get_discriminator_offset;

/// Obtain the type information of the union discriminator.
extern fn g_union_info_get_discriminator_type(p_info: *girepository.UnionInfo) *girepository.TypeInfo;
pub const unionInfoGetDiscriminatorType = g_union_info_get_discriminator_type;

/// Obtain the type information for field with specified index.
extern fn g_union_info_get_field(p_info: *girepository.UnionInfo, p_n: c_int) *girepository.FieldInfo;
pub const unionInfoGetField = g_union_info_get_field;

/// Retrieves the name of the free function for `info`, if any is set.
extern fn g_union_info_get_free_function(p_info: *girepository.UnionInfo) ?[*:0]const u8;
pub const unionInfoGetFreeFunction = g_union_info_get_free_function;

/// Obtain the type information for method with specified index.
extern fn g_union_info_get_method(p_info: *girepository.UnionInfo, p_n: c_int) *girepository.FunctionInfo;
pub const unionInfoGetMethod = g_union_info_get_method;

/// Obtain the number of fields this union has.
extern fn g_union_info_get_n_fields(p_info: *girepository.UnionInfo) c_int;
pub const unionInfoGetNFields = g_union_info_get_n_fields;

/// Obtain the number of methods this union has.
extern fn g_union_info_get_n_methods(p_info: *girepository.UnionInfo) c_int;
pub const unionInfoGetNMethods = g_union_info_get_n_methods;

/// Obtain the total size of the union.
extern fn g_union_info_get_size(p_info: *girepository.UnionInfo) usize;
pub const unionInfoGetSize = g_union_info_get_size;

/// Return true if this union contains discriminator field.
extern fn g_union_info_is_discriminated(p_info: *girepository.UnionInfo) c_int;
pub const unionInfoIsDiscriminated = g_union_info_is_discriminated;

/// Obtain the enumeration value of the `girepository.ValueInfo`.
extern fn g_value_info_get_value(p_info: *girepository.ValueInfo) i64;
pub const valueInfoGetValue = g_value_info_get_value;

/// This method will look up where inside the type struct of `implementor_gtype`
/// is the implementation for `info`.
extern fn g_vfunc_info_get_address(p_info: *girepository.VFuncInfo, p_implementor_gtype: usize, p_error: ?*?*glib.Error) ?*anyopaque;
pub const vfuncInfoGetAddress = g_vfunc_info_get_address;

/// Obtain the flags for this virtual function info. See `girepository.VFuncInfoFlags` for
/// more information about possible flag values.
extern fn g_vfunc_info_get_flags(p_info: *girepository.VFuncInfo) girepository.VFuncInfoFlags;
pub const vfuncInfoGetFlags = g_vfunc_info_get_flags;

/// If this virtual function has an associated invoker method, this
/// method will return it.  An invoker method is a C entry point.
///
/// Not all virtuals will have invokers.
extern fn g_vfunc_info_get_invoker(p_info: *girepository.VFuncInfo) *girepository.FunctionInfo;
pub const vfuncInfoGetInvoker = g_vfunc_info_get_invoker;

/// Obtain the offset of the function pointer in the class struct. The value
/// 0xFFFF indicates that the struct offset is unknown.
extern fn g_vfunc_info_get_offset(p_info: *girepository.VFuncInfo) c_int;
pub const vfuncInfoGetOffset = g_vfunc_info_get_offset;

/// Obtain the signal for the virtual function if one is set.
/// The signal comes from the object or interface to which
/// this virtual function belongs.
extern fn g_vfunc_info_get_signal(p_info: *girepository.VFuncInfo) *girepository.SignalInfo;
pub const vfuncInfoGetSignal = g_vfunc_info_get_signal;

/// Invokes the function described in `info` with the given
/// arguments. Note that inout parameters must appear in both
/// argument lists.
extern fn g_vfunc_info_invoke(p_info: *girepository.VFuncInfo, p_implementor: usize, p_in_args: [*]const girepository.Argument, p_n_in_args: c_int, p_out_args: [*]const girepository.Argument, p_n_out_args: c_int, p_return_value: *girepository.Argument, p_error: ?*?*glib.Error) c_int;
pub const vfuncInfoInvoke = g_vfunc_info_invoke;

/// Extract an object instance out of `value`
pub const ObjectInfoGetValueFunction = *const fn (p_value: *const gobject.Value) callconv(.c) ?*anyopaque;

/// Increases the reference count of an object instance.
pub const ObjectInfoRefFunction = *const fn (p_object: ?*anyopaque) callconv(.c) ?*anyopaque;

/// Update `value` and attach the object instance pointer `object` to it.
pub const ObjectInfoSetValueFunction = *const fn (p_value: *gobject.Value, p_object: ?*anyopaque) callconv(.c) void;

/// Decreases the reference count of an object instance.
pub const ObjectInfoUnrefFunction = *const fn (p_object: ?*anyopaque) callconv(.c) void;

/// The major version number of the girepository library.
pub const MAJOR_VERSION = 1;
/// The micro version number of the girepository library.
pub const MICRO_VERSION = 0;
/// The minor version number of the girepository library.
pub const MINOR_VERSION = 84;
/// TODO
pub const TYPE_TAG_N_TYPES = 22;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
