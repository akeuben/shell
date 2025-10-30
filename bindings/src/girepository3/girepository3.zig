pub const ext = @import("ext.zig");
const girepository = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// `GIArgInfo` represents an argument of a callable.
///
/// An argument is always part of a `girepository.CallableInfo`.
pub const ArgInfo = extern struct {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ArgInfo;
    };
    f_parent: girepository.BaseInfoStack,
    f_padding: [6]*anyopaque,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the index of the user data argument. This is only valid
    /// for arguments which are callbacks.
    extern fn gi_arg_info_get_closure_index(p_info: *ArgInfo, p_out_closure_index: ?*c_uint) c_int;
    pub const getClosureIndex = gi_arg_info_get_closure_index;

    /// Obtains the index of the `glib.DestroyNotify` argument. This is only
    /// valid for arguments which are callbacks.
    extern fn gi_arg_info_get_destroy_index(p_info: *ArgInfo, p_out_destroy_index: ?*c_uint) c_int;
    pub const getDestroyIndex = gi_arg_info_get_destroy_index;

    /// Obtain the direction of the argument. Check `girepository.Direction`
    /// for possible direction values.
    extern fn gi_arg_info_get_direction(p_info: *ArgInfo) girepository.Direction;
    pub const getDirection = gi_arg_info_get_direction;

    /// Obtain the ownership transfer for this argument.
    /// `girepository.Transfer` contains a list of possible values.
    extern fn gi_arg_info_get_ownership_transfer(p_info: *ArgInfo) girepository.Transfer;
    pub const getOwnershipTransfer = gi_arg_info_get_ownership_transfer;

    /// Obtain the scope type for this argument.
    ///
    /// The scope type explains how a callback is going to be invoked, most
    /// importantly when the resources required to invoke it can be freed.
    ///
    /// `girepository.ScopeType` contains a list of possible values.
    extern fn gi_arg_info_get_scope(p_info: *ArgInfo) girepository.ScopeType;
    pub const getScope = gi_arg_info_get_scope;

    /// Obtain the type information for `info`.
    extern fn gi_arg_info_get_type_info(p_info: *ArgInfo) *girepository.TypeInfo;
    pub const getTypeInfo = gi_arg_info_get_type_info;

    /// Obtain if the argument is a pointer to a struct or object that will
    /// receive an output of a function.
    ///
    /// The default assumption for `GI_DIRECTION_OUT` arguments which have allocation
    /// is that the callee allocates; if this is `TRUE`, then the caller must
    /// allocate.
    extern fn gi_arg_info_is_caller_allocates(p_info: *ArgInfo) c_int;
    pub const isCallerAllocates = gi_arg_info_is_caller_allocates;

    /// Obtain if the argument is optional.
    ///
    /// For ‘out’ arguments this means that you can pass `NULL` in order to ignore
    /// the result.
    extern fn gi_arg_info_is_optional(p_info: *ArgInfo) c_int;
    pub const isOptional = gi_arg_info_is_optional;

    /// Obtain if the argument is a return value. It can either be a
    /// parameter or a return value.
    extern fn gi_arg_info_is_return_value(p_info: *ArgInfo) c_int;
    pub const isReturnValue = gi_arg_info_is_return_value;

    /// Obtain if an argument is only useful in C.
    extern fn gi_arg_info_is_skip(p_info: *ArgInfo) c_int;
    pub const isSkip = gi_arg_info_is_skip;

    /// Obtain information about a the type of given argument `info`; this
    /// function is a variant of `girepository.ArgInfo.getTypeInfo` designed
    /// for stack allocation.
    ///
    /// The initialized `type` must not be referenced after `info` is deallocated.
    ///
    /// Once you are done with `type`, it must be cleared using
    /// `girepository.BaseInfo.clear`.
    extern fn gi_arg_info_load_type_info(p_info: *ArgInfo, p_type: *girepository.TypeInfo) void;
    pub const loadTypeInfo = gi_arg_info_load_type_info;

    /// Obtain if the type of the argument includes the possibility of `NULL`.
    ///
    /// For ‘in’ values this means that `NULL` is a valid value.  For ‘out’
    /// values, this means that `NULL` may be returned.
    ///
    /// See also `girepository.ArgInfo.isOptional`.
    extern fn gi_arg_info_may_be_null(p_info: *ArgInfo) c_int;
    pub const mayBeNull = gi_arg_info_may_be_null;

    extern fn gi_arg_info_get_type() usize;
    pub const getGObjectType = gi_arg_info_get_type;

    pub fn as(p_instance: *ArgInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIBaseInfo` is the common base struct of all other Info structs
/// accessible through the `girepository.Repository` API.
///
/// All info structures can be cast to a `GIBaseInfo`, for instance:
///
/// ```c
///    GIFunctionInfo *function_info = …;
///    GIBaseInfo *info = (GIBaseInfo *) function_info;
/// ```
///
/// Most `girepository.Repository` APIs returning a `GIBaseInfo` are
/// actually creating a new struct; in other words,
/// `girepository.BaseInfo.unref` has to be called when done accessing the
/// data.
///
/// `GIBaseInfo` structuress are normally accessed by calling either
/// `girepository.Repository.findByName`,
/// `girepository.Repository.findByGtype` or
/// `girepository.getInfo`.
///
/// ```c
/// GIBaseInfo *button_info =
///   gi_repository_find_by_name (NULL, "Gtk", "Button");
///
/// // use button_info…
///
/// gi_base_info_unref (button_info);
/// ```
pub const BaseInfo = opaque {
    pub const Parent = gobject.TypeInstance;
    pub const Implements = [_]type{};
    pub const Class = girepository.BaseInfoClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Clears memory allocated internally by a stack-allocated
    /// `girepository.BaseInfo`.
    ///
    /// This does not deallocate the `girepository.BaseInfo` struct itself. It
    /// does clear the struct to zero so that calling this function subsequent times
    /// on the same struct is a no-op.
    ///
    /// This must only be called on stack-allocated `girepository.BaseInfo`s.
    /// Use `girepository.BaseInfo.unref` for heap-allocated ones.
    extern fn gi_base_info_clear(p_info: *BaseInfo) void;
    pub const clear = gi_base_info_clear;

    /// Compare two `GIBaseInfo`s.
    ///
    /// Using pointer comparison is not practical since many functions return
    /// different instances of `GIBaseInfo` that refers to the same part of the
    /// TypeLib; use this function instead to do `GIBaseInfo` comparisons.
    extern fn gi_base_info_equal(p_info1: *BaseInfo, p_info2: *girepository.BaseInfo) c_int;
    pub const equal = gi_base_info_equal;

    /// Retrieve an arbitrary attribute associated with this node.
    extern fn gi_base_info_get_attribute(p_info: *BaseInfo, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getAttribute = gi_base_info_get_attribute;

    /// Obtain the container of the `info`.
    ///
    /// The container is the parent `GIBaseInfo`. For instance, the parent of a
    /// `girepository.FunctionInfo` is an `girepository.ObjectInfo` or
    /// `girepository.InterfaceInfo`.
    extern fn gi_base_info_get_container(p_info: *BaseInfo) *girepository.BaseInfo;
    pub const getContainer = gi_base_info_get_container;

    /// Obtain the name of the `info`.
    ///
    /// What the name represents depends on the type of the
    /// `info`. For instance for `girepository.FunctionInfo` it is the name of
    /// the function.
    extern fn gi_base_info_get_name(p_info: *BaseInfo) ?[*:0]const u8;
    pub const getName = gi_base_info_get_name;

    /// Obtain the namespace of `info`.
    extern fn gi_base_info_get_namespace(p_info: *BaseInfo) [*:0]const u8;
    pub const getNamespace = gi_base_info_get_namespace;

    /// Obtain the typelib this `info` belongs to
    extern fn gi_base_info_get_typelib(p_info: *BaseInfo) *girepository.Typelib;
    pub const getTypelib = gi_base_info_get_typelib;

    /// Obtain whether the `info` is represents a metadata which is
    /// deprecated.
    extern fn gi_base_info_is_deprecated(p_info: *BaseInfo) c_int;
    pub const isDeprecated = gi_base_info_is_deprecated;

    /// Iterate over all attributes associated with this node.
    ///
    /// The iterator structure is typically stack allocated, and must have its first
    /// member initialized to `NULL`.  Attributes are arbitrary namespaced key–value
    /// pairs which can be attached to almost any item.  They are intended for use
    /// by software higher in the toolchain than bindings, and are distinct from
    /// normal GIR annotations.
    ///
    /// Both the `name` and `value` should be treated as constants
    /// and must not be freed.
    ///
    /// ```c
    /// void
    /// print_attributes (GIBaseInfo *info)
    /// {
    ///   GIAttributeIter iter = GI_ATTRIBUTE_ITER_INIT;
    ///   const char *name;
    ///   const char *value;
    ///   while (gi_base_info_iterate_attributes (info, &iter, &name, &value))
    ///     {
    ///       g_print ("attribute name: `s` value: `s`", name, value);
    ///     }
    /// }
    /// ```
    extern fn gi_base_info_iterate_attributes(p_info: *BaseInfo, p_iterator: *girepository.AttributeIter, p_name: *[*:0]const u8, p_value: *[*:0]const u8) c_int;
    pub const iterateAttributes = gi_base_info_iterate_attributes;

    /// Increases the reference count of `info`.
    extern fn gi_base_info_ref(p_info: *BaseInfo) *girepository.BaseInfo;
    pub const ref = gi_base_info_ref;

    /// Decreases the reference count of `info`. When its reference count
    /// drops to 0, the info is freed.
    ///
    /// This must not be called on stack-allocated `girepository.BaseInfo`s —
    /// use `girepository.BaseInfo.clear` for that.
    extern fn gi_base_info_unref(p_info: *BaseInfo) void;
    pub const unref = gi_base_info_unref;

    extern fn gi_base_info_get_type() usize;
    pub const getGObjectType = gi_base_info_get_type;

    pub fn as(p_instance: *BaseInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GICallableInfo` represents an entity which is callable.
///
/// Examples of callable are:
///
///  - functions (`girepository.FunctionInfo`)
///  - virtual functions (`girepository.VFuncInfo`)
///  - callbacks (`girepository.CallbackInfo`).
///
/// A callable has a list of arguments (`girepository.ArgInfo`), a return
/// type, direction and a flag which decides if it returns `NULL`.
pub const CallableInfo = opaque {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = CallableInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Whether the callable can throw a `glib.Error`
    extern fn gi_callable_info_can_throw_gerror(p_info: *CallableInfo) c_int;
    pub const canThrowGerror = gi_callable_info_can_throw_gerror;

    /// Obtain information about a particular argument of this callable.
    extern fn gi_callable_info_get_arg(p_info: *CallableInfo, p_n: c_uint) *girepository.ArgInfo;
    pub const getArg = gi_callable_info_get_arg;

    /// Gets the callable info for the callable's asynchronous version
    extern fn gi_callable_info_get_async_function(p_info: *CallableInfo) ?*girepository.CallableInfo;
    pub const getAsyncFunction = gi_callable_info_get_async_function;

    /// See whether the caller owns the return value of this callable.
    ///
    /// `girepository.Transfer` contains a list of possible transfer values.
    extern fn gi_callable_info_get_caller_owns(p_info: *CallableInfo) girepository.Transfer;
    pub const getCallerOwns = gi_callable_info_get_caller_owns;

    /// Gets the info for an async function's corresponding finish function
    extern fn gi_callable_info_get_finish_function(p_info: *CallableInfo) ?*girepository.CallableInfo;
    pub const getFinishFunction = gi_callable_info_get_finish_function;

    /// Obtains the ownership transfer for the instance argument.
    ///
    /// `girepository.Transfer` contains a list of possible transfer values.
    extern fn gi_callable_info_get_instance_ownership_transfer(p_info: *CallableInfo) girepository.Transfer;
    pub const getInstanceOwnershipTransfer = gi_callable_info_get_instance_ownership_transfer;

    /// Obtain the number of arguments (both ‘in’ and ‘out’) for this callable.
    extern fn gi_callable_info_get_n_args(p_info: *CallableInfo) c_uint;
    pub const getNArgs = gi_callable_info_get_n_args;

    /// Retrieve an arbitrary attribute associated with the return value.
    extern fn gi_callable_info_get_return_attribute(p_info: *CallableInfo, p_name: [*:0]const u8) ?[*:0]const u8;
    pub const getReturnAttribute = gi_callable_info_get_return_attribute;

    /// Obtain the return type of a callable item as a `girepository.TypeInfo`.
    ///
    /// If the callable doesn’t return anything, a `girepository.TypeInfo` of
    /// type `girepository.@"TypeTag.VOID"` will be returned.
    extern fn gi_callable_info_get_return_type(p_info: *CallableInfo) *girepository.TypeInfo;
    pub const getReturnType = gi_callable_info_get_return_type;

    /// Gets the callable info for the callable's synchronous version
    extern fn gi_callable_info_get_sync_function(p_info: *CallableInfo) ?*girepository.CallableInfo;
    pub const getSyncFunction = gi_callable_info_get_sync_function;

    /// Invoke the given `GICallableInfo` by calling the given `function` pointer.
    ///
    /// The set of arguments passed to `function` will be constructed according to the
    /// introspected type of the `GICallableInfo`, using `in_args`, `out_args`
    /// and `error`.
    extern fn gi_callable_info_invoke(p_info: *CallableInfo, p_function: ?*anyopaque, p_in_args: [*]const girepository.Argument, p_n_in_args: usize, p_out_args: [*]girepository.Argument, p_n_out_args: usize, p_return_value: *girepository.Argument, p_error: ?*?*glib.Error) c_int;
    pub const invoke = gi_callable_info_invoke;

    /// Gets whether a callable is ‘async’. Async callables have a
    /// `gio.AsyncReadyCallback` parameter and user data.
    extern fn gi_callable_info_is_async(p_info: *CallableInfo) c_int;
    pub const isAsync = gi_callable_info_is_async;

    /// Determines if the callable info is a method.
    ///
    /// For `girepository.SignalInfo`s, this is always true, and for
    /// `girepository.CallbackInfo`s always false.
    /// For `girepository.FunctionInfo`s this looks at the
    /// `GI_FUNCTION_IS_METHOD` flag on the `girepository.FunctionInfo`.
    /// For `girepository.VFuncInfo`s this is true when the virtual function
    /// has an instance parameter.
    ///
    /// Concretely, this function returns whether
    /// `girepository.CallableInfo.getNArgs` matches the number of arguments
    /// in the raw C method. For methods, there is one more C argument than is
    /// exposed by introspection: the `self` or `this` object.
    extern fn gi_callable_info_is_method(p_info: *CallableInfo) c_int;
    pub const isMethod = gi_callable_info_is_method;

    /// Iterate over all attributes associated with the return value.
    ///
    /// The iterator structure is typically stack allocated, and must have its
    /// first member initialized to `NULL`.
    ///
    /// Both the `name` and `value` should be treated as constants
    /// and must not be freed.
    ///
    /// See `girepository.BaseInfo.iterateAttributes` for an example of how
    /// to use a similar API.
    extern fn gi_callable_info_iterate_return_attributes(p_info: *CallableInfo, p_iterator: *girepository.AttributeIter, p_name: *[*:0]const u8, p_value: *[*:0]const u8) c_int;
    pub const iterateReturnAttributes = gi_callable_info_iterate_return_attributes;

    /// Obtain information about a particular argument of this callable; this
    /// function is a variant of `girepository.CallableInfo.getArg` designed
    /// for stack allocation.
    ///
    /// The initialized `arg` must not be referenced after `info` is deallocated.
    ///
    /// Once you are done with `arg`, it must be cleared using
    /// `girepository.BaseInfo.clear`.
    extern fn gi_callable_info_load_arg(p_info: *CallableInfo, p_n: c_uint, p_arg: *girepository.ArgInfo) void;
    pub const loadArg = gi_callable_info_load_arg;

    /// Obtain information about a return value of callable; this
    /// function is a variant of `girepository.CallableInfo.getReturnType`
    /// designed for stack allocation.
    ///
    /// The initialized `type` must not be referenced after `info` is deallocated.
    ///
    /// Once you are done with `type`, it must be cleared using
    /// `girepository.BaseInfo.clear`.
    extern fn gi_callable_info_load_return_type(p_info: *CallableInfo, p_type: *girepository.TypeInfo) void;
    pub const loadReturnType = gi_callable_info_load_return_type;

    /// See if a callable could return `NULL`.
    extern fn gi_callable_info_may_return_null(p_info: *CallableInfo) c_int;
    pub const mayReturnNull = gi_callable_info_may_return_null;

    /// See if a callable’s return value is only useful in C.
    extern fn gi_callable_info_skip_return(p_info: *CallableInfo) c_int;
    pub const skipReturn = gi_callable_info_skip_return;

    extern fn gi_callable_info_get_type() usize;
    pub const getGObjectType = gi_callable_info_get_type;

    pub fn as(p_instance: *CallableInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GICallbackInfo` represents a callback.
pub const CallbackInfo = opaque {
    pub const Parent = girepository.CallableInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = CallbackInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gi_callback_info_get_type() usize;
    pub const getGObjectType = gi_callback_info_get_type;

    pub fn as(p_instance: *CallbackInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIConstantInfo` represents a constant.
///
/// A constant has a type associated – which can be obtained by calling
/// `girepository.ConstantInfo.getTypeInfo` – and a value – which can be
/// obtained by calling `girepository.ConstantInfo.getValue`.
pub const ConstantInfo = opaque {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ConstantInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Free the value returned from `girepository.ConstantInfo.getValue`.
    extern fn gi_constant_info_free_value(p_info: *ConstantInfo, p_value: *girepository.Argument) void;
    pub const freeValue = gi_constant_info_free_value;

    /// Obtain the type of the constant as a `girepository.TypeInfo`.
    extern fn gi_constant_info_get_type_info(p_info: *ConstantInfo) *girepository.TypeInfo;
    pub const getTypeInfo = gi_constant_info_get_type_info;

    /// Obtain the value associated with the `GIConstantInfo` and store it in the
    /// `value` parameter.
    ///
    /// `argument` needs to be allocated before passing it in.
    ///
    /// The size of the constant value (in bytes) stored in `argument` will be
    /// returned.
    ///
    /// Free the value with `girepository.ConstantInfo.freeValue`.
    extern fn gi_constant_info_get_value(p_info: *ConstantInfo, p_value: *girepository.Argument) usize;
    pub const getValue = gi_constant_info_get_value;

    extern fn gi_constant_info_get_type() usize;
    pub const getGObjectType = gi_constant_info_get_type;

    pub fn as(p_instance: *ConstantInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GIEnumInfo` represents an enumeration.
///
/// The `GIEnumInfo` contains a set of values (each a
/// `girepository.ValueInfo`) and a type.
///
/// The `girepository.ValueInfo` for a value is fetched by calling
/// `girepository.EnumInfo.getValue` on a `GIEnumInfo`.
pub const EnumInfo = opaque {
    pub const Parent = girepository.RegisteredTypeInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = EnumInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the string form of the quark for the error domain associated with
    /// this enum, if any.
    extern fn gi_enum_info_get_error_domain(p_info: *EnumInfo) ?[*:0]const u8;
    pub const getErrorDomain = gi_enum_info_get_error_domain;

    /// Obtain an enum type method at index `n`.
    extern fn gi_enum_info_get_method(p_info: *EnumInfo, p_n: c_uint) *girepository.FunctionInfo;
    pub const getMethod = gi_enum_info_get_method;

    /// Obtain the number of methods that this enum type has.
    extern fn gi_enum_info_get_n_methods(p_info: *EnumInfo) c_uint;
    pub const getNMethods = gi_enum_info_get_n_methods;

    /// Obtain the number of values this enumeration contains.
    extern fn gi_enum_info_get_n_values(p_info: *EnumInfo) c_uint;
    pub const getNValues = gi_enum_info_get_n_values;

    /// Obtain the tag of the type used for the enum in the C ABI. This will
    /// will be a signed or unsigned integral type.
    ///
    /// Note that in the current implementation the width of the type is
    /// computed correctly, but the signed or unsigned nature of the type
    /// may not match the sign of the type used by the C compiler.
    extern fn gi_enum_info_get_storage_type(p_info: *EnumInfo) girepository.TypeTag;
    pub const getStorageType = gi_enum_info_get_storage_type;

    /// Obtain a value for this enumeration.
    extern fn gi_enum_info_get_value(p_info: *EnumInfo, p_n: c_uint) *girepository.ValueInfo;
    pub const getValue = gi_enum_info_get_value;

    extern fn gi_enum_info_get_type() usize;
    pub const getGObjectType = gi_enum_info_get_type;

    pub fn as(p_instance: *EnumInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GIFieldInfo` struct represents a field of a struct, union, or object.
///
/// The `GIFieldInfo` is fetched by calling
/// `girepository.StructInfo.getField`,
/// `girepository.UnionInfo.getField` or
/// `girepository.ObjectInfo.getField`.
///
/// A field has a size, type and a struct offset associated and a set of flags,
/// which are currently `GI_FIELD_IS_READABLE` or `GI_FIELD_IS_WRITABLE`.
///
/// See also: `girepository.StructInfo`, `girepository.UnionInfo`,
/// `girepository.ObjectInfo`
pub const FieldInfo = opaque {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = FieldInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Reads a field identified by a `GIFieldInfo` from a C structure or
    /// union.
    ///
    /// This only handles fields of simple C types. It will fail for a field of a
    /// composite type like a nested structure or union even if that is actually
    /// readable.
    extern fn gi_field_info_get_field(p_field_info: *FieldInfo, p_mem: ?*anyopaque, p_value: *girepository.Argument) c_int;
    pub const getField = gi_field_info_get_field;

    /// Obtain the flags for this `GIFieldInfo`. See
    /// `girepository.FieldInfoFlags` for possible flag values.
    extern fn gi_field_info_get_flags(p_info: *FieldInfo) girepository.FieldInfoFlags;
    pub const getFlags = gi_field_info_get_flags;

    /// Obtain the offset of the field member, in bytes. This is relative
    /// to the beginning of the struct or union.
    extern fn gi_field_info_get_offset(p_info: *FieldInfo) usize;
    pub const getOffset = gi_field_info_get_offset;

    /// Obtain the size of the field member, in bits. This is how
    /// much space you need to allocate to store the field.
    extern fn gi_field_info_get_size(p_info: *FieldInfo) usize;
    pub const getSize = gi_field_info_get_size;

    /// Obtain the type of a field as a `girepository.TypeInfo`.
    extern fn gi_field_info_get_type_info(p_info: *FieldInfo) *girepository.TypeInfo;
    pub const getTypeInfo = gi_field_info_get_type_info;

    /// Writes a field identified by a `GIFieldInfo` to a C structure or
    /// union.
    ///
    /// This only handles fields of simple C types. It will fail for a field of a
    /// composite type like a nested structure or union even if that is actually
    /// writable. Note also that that it will refuse to write fields where memory
    /// management would by required. A field with a type such as `char *` must be
    /// set with a setter function.
    extern fn gi_field_info_set_field(p_field_info: *FieldInfo, p_mem: ?*anyopaque, p_value: *const girepository.Argument) c_int;
    pub const setField = gi_field_info_set_field;

    extern fn gi_field_info_get_type() usize;
    pub const getGObjectType = gi_field_info_get_type;

    pub fn as(p_instance: *FieldInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GIFlagsInfo` represents an enumeration which defines flag values
/// (independently set bits).
///
/// The `GIFlagsInfo` contains a set of values (each a
/// `girepository.ValueInfo`) and a type.
///
/// The `girepository.ValueInfo` for a value is fetched by calling
/// `girepository.EnumInfo.getValue` on a `GIFlagsInfo`.
pub const FlagsInfo = opaque {
    pub const Parent = girepository.EnumInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = FlagsInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gi_flags_info_get_type() usize;
    pub const getGObjectType = gi_flags_info_get_type;

    pub fn as(p_instance: *FlagsInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIFunctionInfo` represents a function, method or constructor.
///
/// To find out what kind of entity a `GIFunctionInfo` represents, call
/// `girepository.FunctionInfo.getFlags`.
///
/// See also `girepository.CallableInfo` for information on how to retrieve
/// arguments and other metadata.
pub const FunctionInfo = opaque {
    pub const Parent = girepository.CallableInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = FunctionInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the `girepository.FunctionInfoFlags` for the `info`.
    extern fn gi_function_info_get_flags(p_info: *FunctionInfo) girepository.FunctionInfoFlags;
    pub const getFlags = gi_function_info_get_flags;

    /// Obtain the property associated with this `GIFunctionInfo`.
    ///
    /// Only `GIFunctionInfo`s with the flag `GI_FUNCTION_IS_GETTER` or
    /// `GI_FUNCTION_IS_SETTER` have a property set. For other cases,
    /// `NULL` will be returned.
    extern fn gi_function_info_get_property(p_info: *FunctionInfo) ?*girepository.PropertyInfo;
    pub const getProperty = gi_function_info_get_property;

    /// Obtain the symbol of the function.
    ///
    /// The symbol is the name of the exported function, suitable to be used as an
    /// argument to `gmodule.Module.symbol`.
    extern fn gi_function_info_get_symbol(p_info: *FunctionInfo) [*:0]const u8;
    pub const getSymbol = gi_function_info_get_symbol;

    /// Obtain the virtual function associated with this `GIFunctionInfo`.
    ///
    /// Only `GIFunctionInfo`s with the flag `GI_FUNCTION_WRAPS_VFUNC` have
    /// a virtual function set. For other cases, `NULL` will be returned.
    extern fn gi_function_info_get_vfunc(p_info: *FunctionInfo) ?*girepository.VFuncInfo;
    pub const getVfunc = gi_function_info_get_vfunc;

    /// Invokes the function described in `info` with the given
    /// arguments.
    ///
    /// Note that ‘inout’ parameters must appear in both argument lists. This
    /// function uses [``dlsym``](man:dlsym(3)) to obtain a pointer to the function,
    /// so the library or shared object containing the described function must either
    /// be linked to the caller, or must have been loaded with
    /// `gmodule.Module.symbol` before calling this function.
    extern fn gi_function_info_invoke(p_info: *FunctionInfo, p_in_args: ?[*]const girepository.Argument, p_n_in_args: usize, p_out_args: ?[*]girepository.Argument, p_n_out_args: usize, p_return_value: *girepository.Argument, p_error: ?*?*glib.Error) c_int;
    pub const invoke = gi_function_info_invoke;

    extern fn gi_function_info_get_type() usize;
    pub const getGObjectType = gi_function_info_get_type;

    pub fn as(p_instance: *FunctionInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIInterfaceInfo` represents a `GInterface` type.
///
/// A `GInterface` has methods, fields, properties, signals,
/// interfaces, constants, virtual functions and prerequisites.
pub const InterfaceInfo = opaque {
    pub const Parent = girepository.RegisteredTypeInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = InterfaceInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain a method of the interface type given a `name`.
    ///
    /// `NULL` will be returned if there’s no method available with that name.
    extern fn gi_interface_info_find_method(p_info: *InterfaceInfo, p_name: [*:0]const u8) ?*girepository.FunctionInfo;
    pub const findMethod = gi_interface_info_find_method;

    /// Obtain a signal of the interface type given a `name`.
    ///
    /// `NULL` will be returned if there’s no signal available with that name.
    extern fn gi_interface_info_find_signal(p_info: *InterfaceInfo, p_name: [*:0]const u8) ?*girepository.SignalInfo;
    pub const findSignal = gi_interface_info_find_signal;

    /// Locate a virtual function slot with name `name`.
    ///
    /// See the documentation for `girepository.ObjectInfo.findVfunc` for
    /// more information on virtuals.
    extern fn gi_interface_info_find_vfunc(p_info: *InterfaceInfo, p_name: [*:0]const u8) ?*girepository.VFuncInfo;
    pub const findVfunc = gi_interface_info_find_vfunc;

    /// Obtain an interface type constant at index `n`.
    extern fn gi_interface_info_get_constant(p_info: *InterfaceInfo, p_n: c_uint) *girepository.ConstantInfo;
    pub const getConstant = gi_interface_info_get_constant;

    /// Returns the layout C structure associated with this `GInterface`.
    extern fn gi_interface_info_get_iface_struct(p_info: *InterfaceInfo) ?*girepository.StructInfo;
    pub const getIfaceStruct = gi_interface_info_get_iface_struct;

    /// Obtain an interface type method at index `n`.
    extern fn gi_interface_info_get_method(p_info: *InterfaceInfo, p_n: c_uint) *girepository.FunctionInfo;
    pub const getMethod = gi_interface_info_get_method;

    /// Obtain the number of constants that this interface type has.
    extern fn gi_interface_info_get_n_constants(p_info: *InterfaceInfo) c_uint;
    pub const getNConstants = gi_interface_info_get_n_constants;

    /// Obtain the number of methods that this interface type has.
    extern fn gi_interface_info_get_n_methods(p_info: *InterfaceInfo) c_uint;
    pub const getNMethods = gi_interface_info_get_n_methods;

    /// Obtain the number of prerequisites for this interface type.
    ///
    /// A prerequisite is another interface that needs to be implemented for
    /// interface, similar to a base class for `gobject.Object`s.
    extern fn gi_interface_info_get_n_prerequisites(p_info: *InterfaceInfo) c_uint;
    pub const getNPrerequisites = gi_interface_info_get_n_prerequisites;

    /// Obtain the number of properties that this interface type has.
    extern fn gi_interface_info_get_n_properties(p_info: *InterfaceInfo) c_uint;
    pub const getNProperties = gi_interface_info_get_n_properties;

    /// Obtain the number of signals that this interface type has.
    extern fn gi_interface_info_get_n_signals(p_info: *InterfaceInfo) c_uint;
    pub const getNSignals = gi_interface_info_get_n_signals;

    /// Obtain the number of virtual functions that this interface type has.
    extern fn gi_interface_info_get_n_vfuncs(p_info: *InterfaceInfo) c_uint;
    pub const getNVfuncs = gi_interface_info_get_n_vfuncs;

    /// Obtain an interface type’s prerequisite at index `n`.
    extern fn gi_interface_info_get_prerequisite(p_info: *InterfaceInfo, p_n: c_uint) *girepository.BaseInfo;
    pub const getPrerequisite = gi_interface_info_get_prerequisite;

    /// Obtain an interface type property at index `n`.
    extern fn gi_interface_info_get_property(p_info: *InterfaceInfo, p_n: c_uint) *girepository.PropertyInfo;
    pub const getProperty = gi_interface_info_get_property;

    /// Obtain an interface type signal at index `n`.
    extern fn gi_interface_info_get_signal(p_info: *InterfaceInfo, p_n: c_uint) *girepository.SignalInfo;
    pub const getSignal = gi_interface_info_get_signal;

    /// Obtain an interface type virtual function at index `n`.
    extern fn gi_interface_info_get_vfunc(p_info: *InterfaceInfo, p_n: c_uint) *girepository.VFuncInfo;
    pub const getVfunc = gi_interface_info_get_vfunc;

    extern fn gi_interface_info_get_type() usize;
    pub const getGObjectType = gi_interface_info_get_type;

    pub fn as(p_instance: *InterfaceInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIObjectInfo` represents a classed type.
///
/// Classed types in `gobject.Type` inherit from
/// `gobject.TypeInstance`; the most common type is `gobject.Object`.
///
/// A `GIObjectInfo` doesn’t represent a specific instance of a classed type,
/// instead this represent the object type (i.e. the class).
///
/// A `GIObjectInfo` has methods, fields, properties, signals, interfaces,
/// constants and virtual functions.
pub const ObjectInfo = opaque {
    pub const Parent = girepository.RegisteredTypeInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ObjectInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain a method of the object type given a `name`.
    ///
    /// `NULL` will be returned if there’s no method available with that name.
    extern fn gi_object_info_find_method(p_info: *ObjectInfo, p_name: [*:0]const u8) ?*girepository.FunctionInfo;
    pub const findMethod = gi_object_info_find_method;

    /// Obtain a method of the object given a `name`, searching both the
    /// object `info` and any interfaces it implements.
    ///
    /// `NULL` will be returned if there’s no method available with that name.
    ///
    /// Note that this function does *not* search parent classes; you will have
    /// to chain up if that’s desired.
    extern fn gi_object_info_find_method_using_interfaces(p_info: *ObjectInfo, p_name: [*:0]const u8, p_declarer: ?**girepository.BaseInfo) ?*girepository.FunctionInfo;
    pub const findMethodUsingInterfaces = gi_object_info_find_method_using_interfaces;

    /// Obtain a signal of the object type given a `name`.
    ///
    /// `NULL` will be returned if there’s no signal available with that name.
    extern fn gi_object_info_find_signal(p_info: *ObjectInfo, p_name: [*:0]const u8) ?*girepository.SignalInfo;
    pub const findSignal = gi_object_info_find_signal;

    /// Locate a virtual function slot with name `name`.
    ///
    /// Note that the namespace for virtuals is distinct from that of methods; there
    /// may or may not be a concrete method associated for a virtual. If there is
    /// one, it may be retrieved using `girepository.VFuncInfo.getInvoker`,
    /// otherwise that method will return `NULL`.
    ///
    /// See the documentation for `girepository.VFuncInfo.getInvoker` for
    /// more information on invoking virtuals.
    extern fn gi_object_info_find_vfunc(p_info: *ObjectInfo, p_name: [*:0]const u8) ?*girepository.VFuncInfo;
    pub const findVfunc = gi_object_info_find_vfunc;

    /// Locate a virtual function slot with name `name`, searching both the object
    /// `info` and any interfaces it implements.
    ///
    /// `NULL` will be returned if there’s no vfunc available with that name.
    ///
    /// Note that the namespace for virtuals is distinct from that of methods; there
    /// may or may not be a concrete method associated for a virtual. If there is
    /// one, it may be retrieved using `girepository.VFuncInfo.getInvoker`,
    /// otherwise that method will return `NULL`.
    ///
    /// Note that this function does *not* search parent classes; you will have
    /// to chain up if that’s desired.
    extern fn gi_object_info_find_vfunc_using_interfaces(p_info: *ObjectInfo, p_name: [*:0]const u8, p_declarer: ?**girepository.BaseInfo) ?*girepository.VFuncInfo;
    pub const findVfuncUsingInterfaces = gi_object_info_find_vfunc_using_interfaces;

    /// Obtain if the object type is an abstract type, i.e. if it cannot be
    /// instantiated.
    extern fn gi_object_info_get_abstract(p_info: *ObjectInfo) c_int;
    pub const getAbstract = gi_object_info_get_abstract;

    /// Every `gobject.Object` has two structures; an instance structure and a
    /// class structure.  This function returns the metadata for the class structure.
    extern fn gi_object_info_get_class_struct(p_info: *ObjectInfo) ?*girepository.StructInfo;
    pub const getClassStruct = gi_object_info_get_class_struct;

    /// Obtain an object type constant at index `n`.
    extern fn gi_object_info_get_constant(p_info: *ObjectInfo, p_n: c_uint) *girepository.ConstantInfo;
    pub const getConstant = gi_object_info_get_constant;

    /// Obtain an object type field at index `n`.
    extern fn gi_object_info_get_field(p_info: *ObjectInfo, p_n: c_uint) *girepository.FieldInfo;
    pub const getField = gi_object_info_get_field;

    /// Checks whether the object type is a final type, i.e. if it cannot
    /// be derived.
    extern fn gi_object_info_get_final(p_info: *ObjectInfo) c_int;
    pub const getFinal = gi_object_info_get_final;

    /// Obtain if the object type is of a fundamental type which is not
    /// `G_TYPE_OBJECT`.
    ///
    /// This is mostly for supporting `GstMiniObject`.
    extern fn gi_object_info_get_fundamental(p_info: *ObjectInfo) c_int;
    pub const getFundamental = gi_object_info_get_fundamental;

    /// Obtain the symbol name of the function that should be called to convert
    /// an object instance pointer of this object type to a `gobject.Value`.
    ///
    /// It’s mainly used for fundamental types. The type signature for the symbol
    /// is `girepository.ObjectInfoGetValueFunction`. To fetch the function
    /// pointer see `girepository.ObjectInfo.getGetValueFunctionPointer`.
    extern fn gi_object_info_get_get_value_function_name(p_info: *ObjectInfo) ?[*:0]const u8;
    pub const getGetValueFunctionName = gi_object_info_get_get_value_function_name;

    /// Obtain a pointer to a function which can be used to extract an instance of
    /// this object type out of a `gobject.Value`.
    ///
    /// This takes derivation into account and will reversely traverse
    /// the base classes of this type, starting at the top type.
    extern fn gi_object_info_get_get_value_function_pointer(p_info: *ObjectInfo) ?girepository.ObjectInfoGetValueFunction;
    pub const getGetValueFunctionPointer = gi_object_info_get_get_value_function_pointer;

    /// Obtain an object type interface at index `n`.
    extern fn gi_object_info_get_interface(p_info: *ObjectInfo, p_n: c_uint) *girepository.InterfaceInfo;
    pub const getInterface = gi_object_info_get_interface;

    /// Obtain an object type method at index `n`.
    extern fn gi_object_info_get_method(p_info: *ObjectInfo, p_n: c_uint) *girepository.FunctionInfo;
    pub const getMethod = gi_object_info_get_method;

    /// Obtain the number of constants that this object type has.
    extern fn gi_object_info_get_n_constants(p_info: *ObjectInfo) c_uint;
    pub const getNConstants = gi_object_info_get_n_constants;

    /// Obtain the number of fields that this object type has.
    extern fn gi_object_info_get_n_fields(p_info: *ObjectInfo) c_uint;
    pub const getNFields = gi_object_info_get_n_fields;

    /// Obtain the number of interfaces that this object type has.
    extern fn gi_object_info_get_n_interfaces(p_info: *ObjectInfo) c_uint;
    pub const getNInterfaces = gi_object_info_get_n_interfaces;

    /// Obtain the number of methods that this object type has.
    extern fn gi_object_info_get_n_methods(p_info: *ObjectInfo) c_uint;
    pub const getNMethods = gi_object_info_get_n_methods;

    /// Obtain the number of properties that this object type has.
    extern fn gi_object_info_get_n_properties(p_info: *ObjectInfo) c_uint;
    pub const getNProperties = gi_object_info_get_n_properties;

    /// Obtain the number of signals that this object type has.
    extern fn gi_object_info_get_n_signals(p_info: *ObjectInfo) c_uint;
    pub const getNSignals = gi_object_info_get_n_signals;

    /// Obtain the number of virtual functions that this object type has.
    extern fn gi_object_info_get_n_vfuncs(p_info: *ObjectInfo) c_uint;
    pub const getNVfuncs = gi_object_info_get_n_vfuncs;

    /// Obtain the parent of the object type.
    extern fn gi_object_info_get_parent(p_info: *ObjectInfo) ?*girepository.ObjectInfo;
    pub const getParent = gi_object_info_get_parent;

    /// Obtain an object type property at index `n`.
    extern fn gi_object_info_get_property(p_info: *ObjectInfo, p_n: c_uint) *girepository.PropertyInfo;
    pub const getProperty = gi_object_info_get_property;

    /// Obtain the symbol name of the function that should be called to ref this
    /// object type.
    ///
    /// It’s mainly used for fundamental types. The type signature for
    /// the symbol is `girepository.ObjectInfoRefFunction`. To fetch the
    /// function pointer see
    /// `girepository.ObjectInfo.getRefFunctionPointer`.
    extern fn gi_object_info_get_ref_function_name(p_info: *ObjectInfo) ?[*:0]const u8;
    pub const getRefFunctionName = gi_object_info_get_ref_function_name;

    /// Obtain a pointer to a function which can be used to
    /// increase the reference count an instance of this object type.
    ///
    /// This takes derivation into account and will reversely traverse
    /// the base classes of this type, starting at the top type.
    extern fn gi_object_info_get_ref_function_pointer(p_info: *ObjectInfo) ?girepository.ObjectInfoRefFunction;
    pub const getRefFunctionPointer = gi_object_info_get_ref_function_pointer;

    /// Obtain the symbol name of the function that should be called to set a
    /// `gobject.Value`, given an object instance pointer of this object type.
    ///
    /// It’s mainly used for fundamental types. The type signature for the symbol
    /// is `girepository.ObjectInfoSetValueFunction`. To fetch the function
    /// pointer see `girepository.ObjectInfo.getSetValueFunctionPointer`.
    extern fn gi_object_info_get_set_value_function_name(p_info: *ObjectInfo) ?[*:0]const u8;
    pub const getSetValueFunctionName = gi_object_info_get_set_value_function_name;

    /// Obtain a pointer to a function which can be used to set a
    /// `gobject.Value`, given an instance of this object type.
    ///
    /// This takes derivation into account and will reversely traverse
    /// the base classes of this type, starting at the top type.
    extern fn gi_object_info_get_set_value_function_pointer(p_info: *ObjectInfo) ?girepository.ObjectInfoSetValueFunction;
    pub const getSetValueFunctionPointer = gi_object_info_get_set_value_function_pointer;

    /// Obtain an object type signal at index `n`.
    extern fn gi_object_info_get_signal(p_info: *ObjectInfo, p_n: c_uint) *girepository.SignalInfo;
    pub const getSignal = gi_object_info_get_signal;

    /// Obtain the name of the function which, when called, will return the
    /// `gobject.Type` for this object type.
    extern fn gi_object_info_get_type_init_function_name(p_info: *ObjectInfo) [*:0]const u8;
    pub const getTypeInitFunctionName = gi_object_info_get_type_init_function_name;

    /// Obtain the name of the object’s class/type.
    extern fn gi_object_info_get_type_name(p_info: *ObjectInfo) [*:0]const u8;
    pub const getTypeName = gi_object_info_get_type_name;

    /// Obtain the symbol name of the function that should be called to unref this
    /// object type.
    ///
    /// It’s mainly used for fundamental types. The type signature for the symbol is
    /// `girepository.ObjectInfoUnrefFunction`. To fetch the function pointer
    /// see `girepository.ObjectInfo.getUnrefFunctionPointer`.
    extern fn gi_object_info_get_unref_function_name(p_info: *ObjectInfo) ?[*:0]const u8;
    pub const getUnrefFunctionName = gi_object_info_get_unref_function_name;

    /// Obtain a pointer to a function which can be used to
    /// decrease the reference count an instance of this object type.
    ///
    /// This takes derivation into account and will reversely traverse
    /// the base classes of this type, starting at the top type.
    extern fn gi_object_info_get_unref_function_pointer(p_info: *ObjectInfo) ?girepository.ObjectInfoUnrefFunction;
    pub const getUnrefFunctionPointer = gi_object_info_get_unref_function_pointer;

    /// Obtain an object type virtual function at index `n`.
    extern fn gi_object_info_get_vfunc(p_info: *ObjectInfo, p_n: c_uint) *girepository.VFuncInfo;
    pub const getVfunc = gi_object_info_get_vfunc;

    extern fn gi_object_info_get_type() usize;
    pub const getGObjectType = gi_object_info_get_type;

    pub fn as(p_instance: *ObjectInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIPropertyInfo` represents a property in a `gobject.Object`.
///
/// A property belongs to either a `girepository.ObjectInfo` or a
/// `girepository.InterfaceInfo`.
pub const PropertyInfo = opaque {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = PropertyInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the flags for this property info.
    ///
    /// See `gobject.ParamFlags` for more information about possible flag
    /// values.
    extern fn gi_property_info_get_flags(p_info: *PropertyInfo) gobject.ParamFlags;
    pub const getFlags = gi_property_info_get_flags;

    /// Obtains the getter function associated with this `GIPropertyInfo`.
    ///
    /// The setter is only available for `G_PARAM_READABLE` properties.
    extern fn gi_property_info_get_getter(p_info: *PropertyInfo) ?*girepository.FunctionInfo;
    pub const getGetter = gi_property_info_get_getter;

    /// Obtain the ownership transfer for this property.
    ///
    /// See `girepository.Transfer` for more information about transfer values.
    extern fn gi_property_info_get_ownership_transfer(p_info: *PropertyInfo) girepository.Transfer;
    pub const getOwnershipTransfer = gi_property_info_get_ownership_transfer;

    /// Obtains the setter function associated with this `GIPropertyInfo`.
    ///
    /// The setter is only available for `G_PARAM_WRITABLE` properties that
    /// are also not `G_PARAM_CONSTRUCT_ONLY`.
    extern fn gi_property_info_get_setter(p_info: *PropertyInfo) ?*girepository.FunctionInfo;
    pub const getSetter = gi_property_info_get_setter;

    /// Obtain the type information for the property `info`.
    extern fn gi_property_info_get_type_info(p_info: *PropertyInfo) *girepository.TypeInfo;
    pub const getTypeInfo = gi_property_info_get_type_info;

    extern fn gi_property_info_get_type() usize;
    pub const getGObjectType = gi_property_info_get_type;

    pub fn as(p_instance: *PropertyInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIRegisteredTypeInfo` represents an entity with a `gobject.Type`
/// associated.
///
/// Could be either a `girepository.EnumInfo`,
/// `girepository.InterfaceInfo`, `girepository.ObjectInfo`,
/// `girepository.StructInfo` or a `girepository.UnionInfo`.
///
/// A registered type info struct has a name and a type function.
///
/// To get the name call `girepository.RegisteredTypeInfo.getTypeName`.
/// Most users want to call `girepository.RegisteredTypeInfo.getGType`
/// and don’t worry about the rest of the details.
///
/// If the registered type is a subtype of `G_TYPE_BOXED`,
/// `girepository.RegisteredTypeInfo.isBoxed` will return true, and
/// `girepository.RegisteredTypeInfo.getTypeName` is guaranteed to
/// return a non-`NULL` value. This is relevant for the
/// `girepository.StructInfo` and `girepository.UnionInfo`
/// subclasses.
pub const RegisteredTypeInfo = opaque {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = RegisteredTypeInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the `gobject.Type` for this registered type.
    ///
    /// If there is no type information associated with `info`, or the shared library
    /// which provides the `type_init` function for `info` cannot be called, then
    /// `G_TYPE_NONE` is returned.
    extern fn gi_registered_type_info_get_g_type(p_info: *RegisteredTypeInfo) usize;
    pub const getGType = gi_registered_type_info_get_g_type;

    /// Obtain the type init function for `info`.
    ///
    /// The type init function is the function which will register the
    /// `gobject.Type` within the GObject type system. Usually this is not
    /// called by language bindings or applications — use
    /// `girepository.RegisteredTypeInfo.getGType` directly instead.
    extern fn gi_registered_type_info_get_type_init_function_name(p_info: *RegisteredTypeInfo) ?[*:0]const u8;
    pub const getTypeInitFunctionName = gi_registered_type_info_get_type_init_function_name;

    /// Obtain the type name of the struct within the GObject type system.
    ///
    /// This type can be passed to `gobject.typeName` to get a
    /// `gobject.Type`.
    extern fn gi_registered_type_info_get_type_name(p_info: *RegisteredTypeInfo) ?[*:0]const u8;
    pub const getTypeName = gi_registered_type_info_get_type_name;

    /// Get whether the registered type is a boxed type.
    ///
    /// A boxed type is a subtype of the fundamental `G_TYPE_BOXED` type.
    /// It’s a type which has registered a `gobject.Type`, and which has
    /// associated copy and free functions.
    ///
    /// Most boxed types are `struct`s; some are `union`s; and it’s possible for a
    /// boxed type to be neither, but that is currently unsupported by
    /// libgirepository. It’s also possible for a `struct` or `union` to have
    /// associated copy and/or free functions *without* being a boxed type, by virtue
    /// of not having registered a `gobject.Type`.
    ///
    /// This function will return false for `gobject.Type`s which are not boxed,
    /// such as classes or interfaces. It will also return false for the `struct`s
    /// associated with a class or interface, which return true from
    /// `girepository.StructInfo.isGtypeStruct`.
    extern fn gi_registered_type_info_is_boxed(p_info: *RegisteredTypeInfo) c_int;
    pub const isBoxed = gi_registered_type_info_is_boxed;

    extern fn gi_registered_type_info_get_type() usize;
    pub const getGObjectType = gi_registered_type_info_get_type;

    pub fn as(p_instance: *RegisteredTypeInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIRepository` is used to manage repositories of namespaces. Namespaces
/// are represented on disk by type libraries (`.typelib` files).
///
/// The individual pieces of API within a type library are represented by
/// subclasses of `girepository.BaseInfo`. These can be found using
/// methods like `girepository.Repository.findByName` or
/// `girepository.Repository.getInfo`.
///
/// You are responsible for ensuring that the lifetime of the
/// `girepository.Repository` exceeds that of the lifetime of any of its
/// `girepository.BaseInfo`s. This cannot be guaranteed by using internal
/// references within libgirepository as that would affect performance.
///
/// ### Discovery of type libraries
///
/// `GIRepository` will typically look for a `girepository-1.0` directory
/// under the library directory used when compiling gobject-introspection. On a
/// standard Linux system this will end up being `/usr/lib/girepository-1.0`.
///
/// It is possible to control the search paths programmatically, using
/// `girepository.Repository.prependSearchPath`. It is also possible to
/// modify the search paths by using the `GI_TYPELIB_PATH` environment variable.
/// The environment variable takes precedence over the default search path
/// and the `girepository.Repository.prependSearchPath` calls.
///
/// ### Namespace ordering
///
/// In situations where namespaces may be searched in order, or returned in a
/// list, the namespaces will be returned in alphabetical order, with all fully
/// loaded namespaces being returned before any lazily loaded ones (those loaded
/// with `GI_REPOSITORY_LOAD_FLAG_LAZY`). This allows for deterministic and
/// reproducible results.
///
/// Similarly, if a symbol (such as a `GType` or error domain) is being searched
/// for in the set of loaded namespaces, the namespaces will be searched in that
/// order. In particular, this means that a symbol which exists in two namespaces
/// will always be returned from the alphabetically-higher namespace. This should
/// only happen in the case of `Gio` and `GioUnix`/`GioWin32`, which all refer to
/// the same `.so` file and expose overlapping sets of symbols. Symbols should
/// always end up being resolved to `GioUnix` or `GioWin32` if they are platform
/// dependent, rather than `Gio` itself.
pub const Repository = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = girepository.RepositoryClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Dump the introspection data from the types specified in `input_filename` to
    /// `output_filename`.
    ///
    /// The input file should be a
    /// UTF-8 Unix-line-ending text file, with each line containing either
    /// `get-type:` followed by the name of a `gobject.Type` `_get_type`
    /// function, or `error-quark:` followed by the name of an error quark function.
    /// No extra whitespace is allowed.
    ///
    /// This function will overwrite the contents of the output file.
    extern fn gi_repository_dump(p_input_filename: [*:0]const u8, p_output_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const dump = gi_repository_dump;

    extern fn gi_repository_error_quark() glib.Quark;
    pub const errorQuark = gi_repository_error_quark;

    /// Obtain the option group for girepository.
    ///
    /// It’s used by the dumper and for programs that want to provide introspection
    /// information
    extern fn gi_repository_get_option_group() *glib.OptionGroup;
    pub const getOptionGroup = gi_repository_get_option_group;

    /// Create a new `girepository.Repository`.
    extern fn gi_repository_new() *girepository.Repository;
    pub const new = gi_repository_new;

    /// Obtain an unordered list of versions (either currently loaded or
    /// available) for `namespace_` in this `repository`.
    ///
    /// The list is guaranteed to be `NULL` terminated. The `NULL` terminator is not
    /// counted in `n_versions_out`.
    extern fn gi_repository_enumerate_versions(p_repository: *Repository, p_namespace_: [*:0]const u8, p_n_versions_out: ?*usize) [*][*:0]u8;
    pub const enumerateVersions = gi_repository_enumerate_versions;

    /// Searches for the enum type corresponding to the given `glib.Error`
    /// domain.
    ///
    /// Before calling this function for a particular namespace, you must call
    /// `girepository.Repository.require` to load the namespace, or otherwise
    /// ensure the namespace has already been loaded.
    extern fn gi_repository_find_by_error_domain(p_repository: *Repository, p_domain: glib.Quark) ?*girepository.EnumInfo;
    pub const findByErrorDomain = gi_repository_find_by_error_domain;

    /// Searches all loaded namespaces for a particular `gobject.Type`.
    ///
    /// Note that in order to locate the metadata, the namespace corresponding to
    /// the type must first have been loaded.  There is currently no
    /// mechanism for determining the namespace which corresponds to an
    /// arbitrary `gobject.Type` — thus, this function will operate most
    /// reliably when you know the `gobject.Type` is from a loaded namespace.
    extern fn gi_repository_find_by_gtype(p_repository: *Repository, p_gtype: usize) ?*girepository.BaseInfo;
    pub const findByGtype = gi_repository_find_by_gtype;

    /// Searches for a particular entry in a namespace.
    ///
    /// Before calling this function for a particular namespace, you must call
    /// `girepository.Repository.require` to load the namespace, or otherwise
    /// ensure the namespace has already been loaded.
    extern fn gi_repository_find_by_name(p_repository: *Repository, p_namespace_: [*:0]const u8, p_name: [*:0]const u8) ?*girepository.BaseInfo;
    pub const findByName = gi_repository_find_by_name;

    /// This function returns the ‘C prefix’, or the C level namespace
    /// associated with the given introspection namespace.
    ///
    /// Each C symbol starts with this prefix, as well each `gobject.Type` in
    /// the library.
    ///
    /// Note: The namespace must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this
    /// function.
    extern fn gi_repository_get_c_prefix(p_repository: *Repository, p_namespace_: [*:0]const u8) ?[*:0]const u8;
    pub const getCPrefix = gi_repository_get_c_prefix;

    /// Retrieves all (transitive) versioned dependencies for
    /// `namespace_`.
    ///
    /// The returned strings are of the form `namespace-version`.
    ///
    /// Note: `namespace_` must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this
    /// function.
    ///
    /// To get only the immediate dependencies for `namespace_`, use
    /// `girepository.Repository.getImmediateDependencies`.
    ///
    /// The list is guaranteed to be `NULL` terminated. The `NULL` terminator is not
    /// counted in `n_dependencies_out`.
    extern fn gi_repository_get_dependencies(p_repository: *Repository, p_namespace_: [*:0]const u8, p_n_dependencies_out: ?*usize) [*][*:0]u8;
    pub const getDependencies = gi_repository_get_dependencies;

    /// Return an array of the immediate versioned dependencies for `namespace_`.
    /// Returned strings are of the form `namespace-version`.
    ///
    /// Note: `namespace_` must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this
    /// function.
    ///
    /// To get the transitive closure of dependencies for `namespace_`, use
    /// `girepository.Repository.getDependencies`.
    ///
    /// The list is guaranteed to be `NULL` terminated. The `NULL` terminator is not
    /// counted in `n_dependencies_out`.
    extern fn gi_repository_get_immediate_dependencies(p_repository: *Repository, p_namespace_: [*:0]const u8, p_n_dependencies_out: ?*usize) [*][*:0]u8;
    pub const getImmediateDependencies = gi_repository_get_immediate_dependencies;

    /// This function returns a particular metadata entry in the
    /// given namespace `namespace_`.
    ///
    /// The namespace must have already been loaded before calling this function.
    /// See `girepository.Repository.getNInfos` to find the maximum number
    /// of entries. It is an error to pass an invalid `idx` to this function.
    extern fn gi_repository_get_info(p_repository: *Repository, p_namespace_: [*:0]const u8, p_idx: c_uint) *girepository.BaseInfo;
    pub const getInfo = gi_repository_get_info;

    /// Returns the current search path `girepository.Repository` will use when
    /// loading shared libraries referenced by imported namespaces.
    ///
    /// The list is internal to `girepository.Repository` and should not be
    /// freed, nor should its string elements.
    ///
    /// The list is guaranteed to be `NULL` terminated. The `NULL` terminator is not
    /// counted in `n_paths_out`.
    extern fn gi_repository_get_library_path(p_repository: *Repository, p_n_paths_out: ?*usize) [*]const [*:0]const u8;
    pub const getLibraryPath = gi_repository_get_library_path;

    /// Return the list of currently loaded namespaces.
    ///
    /// The list is guaranteed to be `NULL` terminated. The `NULL` terminator is not
    /// counted in `n_namespaces_out`.
    extern fn gi_repository_get_loaded_namespaces(p_repository: *Repository, p_n_namespaces_out: ?*usize) [*][*:0]u8;
    pub const getLoadedNamespaces = gi_repository_get_loaded_namespaces;

    /// This function returns the number of metadata entries in
    /// given namespace `namespace_`.
    ///
    /// The namespace must have already been loaded before calling this function.
    extern fn gi_repository_get_n_infos(p_repository: *Repository, p_namespace_: [*:0]const u8) c_uint;
    pub const getNInfos = gi_repository_get_n_infos;

    /// Look up the implemented interfaces for `gtype`.
    ///
    /// This function cannot fail per se; but for a totally ‘unknown’
    /// `gobject.Type`, it may return 0 implemented interfaces.
    ///
    /// The semantics of this function are designed for a dynamic binding,
    /// where in certain cases (such as a function which returns an
    /// interface which may have ‘hidden’ implementation classes), not all
    /// data may be statically known, and will have to be determined from
    /// the `gobject.Type` of the object.  An example is
    /// `gio.File.newForPath` returning a concrete class of
    /// `GLocalFile`, which is a `gobject.Type` we see at runtime, but
    /// not statically.
    extern fn gi_repository_get_object_gtype_interfaces(p_repository: *Repository, p_gtype: usize, p_n_interfaces_out: *usize, p_interfaces_out: *[*]*girepository.InterfaceInfo) void;
    pub const getObjectGtypeInterfaces = gi_repository_get_object_gtype_interfaces;

    /// Returns the current search path `girepository.Repository` will use when
    /// loading typelib files.
    ///
    /// The list is internal to `girepository.Repository` and should not be
    /// freed, nor should its string elements.
    ///
    /// The list is guaranteed to be `NULL` terminated. The `NULL` terminator is not
    /// counted in `n_paths_out`.
    extern fn gi_repository_get_search_path(p_repository: *Repository, p_n_paths_out: ?*usize) [*]const [*:0]const u8;
    pub const getSearchPath = gi_repository_get_search_path;

    /// This function returns an array of paths to the
    /// shared C libraries associated with the given namespace `namespace_`.
    ///
    /// There may be no shared library path associated, in which case this
    /// function will return `NULL`.
    ///
    /// Note: The namespace must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this
    /// function.
    ///
    /// The list is internal to `girepository.Repository` and should not be
    /// freed, nor should its string elements.
    ///
    /// The list is guaranteed to be `NULL` terminated. The `NULL` terminator is not
    /// counted in `out_n_elements`.
    extern fn gi_repository_get_shared_libraries(p_repository: *Repository, p_namespace_: [*:0]const u8, p_out_n_elements: ?*usize) ?[*]const [*:0]const u8;
    pub const getSharedLibraries = gi_repository_get_shared_libraries;

    /// If namespace `namespace_` is loaded, return the full path to the
    /// .typelib file it was loaded from.
    ///
    /// If the typelib for namespace `namespace_` was included in a shared library,
    /// return the special string `<builtin>`.
    extern fn gi_repository_get_typelib_path(p_repository: *Repository, p_namespace_: [*:0]const u8) ?[*:0]const u8;
    pub const getTypelibPath = gi_repository_get_typelib_path;

    /// This function returns the loaded version associated with the given
    /// namespace `namespace_`.
    ///
    /// Note: The namespace must have already been loaded using a function
    /// such as `girepository.Repository.require` before calling this
    /// function.
    extern fn gi_repository_get_version(p_repository: *Repository, p_namespace_: [*:0]const u8) [*:0]const u8;
    pub const getVersion = gi_repository_get_version;

    /// Check whether a particular namespace (and optionally, a specific
    /// version thereof) is currently loaded.
    ///
    /// This function is likely to only be useful in unusual circumstances; in order
    /// to act upon metadata in the namespace, you should call
    /// `girepository.Repository.require` instead which will ensure the
    /// namespace is loaded, and return as quickly as this function will if it has
    /// already been loaded.
    extern fn gi_repository_is_registered(p_repository: *Repository, p_namespace_: [*:0]const u8, p_version: ?[*:0]const u8) c_int;
    pub const isRegistered = gi_repository_is_registered;

    /// Load the given `typelib` into the repository.
    extern fn gi_repository_load_typelib(p_repository: *Repository, p_typelib: *girepository.Typelib, p_flags: girepository.RepositoryLoadFlags, p_error: ?*?*glib.Error) ?[*:0]const u8;
    pub const loadTypelib = gi_repository_load_typelib;

    /// Prepends `directory` to the search path that is used to
    /// search shared libraries referenced by imported namespaces.
    ///
    /// Multiple calls to this function all contribute to the final
    /// list of paths.
    ///
    /// The list of paths is unique to `repository`. When a typelib is loaded by the
    /// repository, the list of paths from the `repository` at that instant is used
    /// by the typelib for loading its modules.
    ///
    /// If the library is not found in the directories configured
    /// in this way, loading will fall back to the system library
    /// path (i.e. `LD_LIBRARY_PATH` and `DT_RPATH` in ELF systems).
    /// See the documentation of your dynamic linker for full details.
    extern fn gi_repository_prepend_library_path(p_repository: *Repository, p_directory: [*:0]const u8) void;
    pub const prependLibraryPath = gi_repository_prepend_library_path;

    /// Prepends `directory` to the typelib search path.
    ///
    /// See also: `girepository.Repository.getSearchPath`.
    extern fn gi_repository_prepend_search_path(p_repository: *Repository, p_directory: [*:0]const u8) void;
    pub const prependSearchPath = gi_repository_prepend_search_path;

    /// Force the namespace `namespace_` to be loaded if it isn’t already.
    ///
    /// If `namespace_` is not loaded, this function will search for a
    /// `.typelib` file using the repository search path.  In addition, a
    /// version `version` of namespace may be specified.  If `version` is
    /// not specified, the latest will be used.
    extern fn gi_repository_require(p_repository: *Repository, p_namespace_: [*:0]const u8, p_version: ?[*:0]const u8, p_flags: girepository.RepositoryLoadFlags, p_error: ?*?*glib.Error) ?*girepository.Typelib;
    pub const require = gi_repository_require;

    /// Force the namespace `namespace_` to be loaded if it isn’t already.
    ///
    /// If `namespace_` is not loaded, this function will search for a
    /// `.typelib` file within the private directory only. In addition, a
    /// version `version` of namespace should be specified.  If `version` is
    /// not specified, the latest will be used.
    extern fn gi_repository_require_private(p_repository: *Repository, p_typelib_dir: [*:0]const u8, p_namespace_: [*:0]const u8, p_version: ?[*:0]const u8, p_flags: girepository.RepositoryLoadFlags, p_error: ?*?*glib.Error) ?*girepository.Typelib;
    pub const requirePrivate = gi_repository_require_private;

    extern fn gi_repository_get_type() usize;
    pub const getGObjectType = gi_repository_get_type;

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

/// `GISignalInfo` represents a signal.
///
/// It’s a sub-struct of `girepository.CallableInfo` and contains a set of
/// flags and a class closure.
///
/// See `girepository.CallableInfo` for information on how to retrieve
/// arguments and other metadata from the signal.
pub const SignalInfo = opaque {
    pub const Parent = girepository.CallableInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = SignalInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the class closure for this signal if one is set.
    ///
    /// The class closure is a virtual function on the type that the signal belongs
    /// to. If the signal lacks a closure, `NULL` will be returned.
    extern fn gi_signal_info_get_class_closure(p_info: *SignalInfo) ?*girepository.VFuncInfo;
    pub const getClassClosure = gi_signal_info_get_class_closure;

    /// Obtain the flags for this signal info.
    ///
    /// See `gobject.SignalFlags` for more information about possible flag
    /// values.
    extern fn gi_signal_info_get_flags(p_info: *SignalInfo) gobject.SignalFlags;
    pub const getFlags = gi_signal_info_get_flags;

    /// Obtain if the returning `TRUE` in the signal handler will stop the emission
    /// of the signal.
    extern fn gi_signal_info_true_stops_emit(p_info: *SignalInfo) c_int;
    pub const trueStopsEmit = gi_signal_info_true_stops_emit;

    extern fn gi_signal_info_get_type() usize;
    pub const getGObjectType = gi_signal_info_get_type;

    pub fn as(p_instance: *SignalInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIStructInfo` represents a generic C structure type.
///
/// A structure has methods and fields.
pub const StructInfo = opaque {
    pub const Parent = girepository.RegisteredTypeInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = StructInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the type information for field named `name`.
    extern fn gi_struct_info_find_field(p_info: *StructInfo, p_name: [*:0]const u8) ?*girepository.FieldInfo;
    pub const findField = gi_struct_info_find_field;

    /// Obtain the type information for method named `name`.
    extern fn gi_struct_info_find_method(p_info: *StructInfo, p_name: [*:0]const u8) ?*girepository.FunctionInfo;
    pub const findMethod = gi_struct_info_find_method;

    /// Obtain the required alignment of the structure.
    extern fn gi_struct_info_get_alignment(p_info: *StructInfo) usize;
    pub const getAlignment = gi_struct_info_get_alignment;

    /// Retrieves the name of the copy function for `info`, if any is set.
    extern fn gi_struct_info_get_copy_function_name(p_info: *StructInfo) ?[*:0]const u8;
    pub const getCopyFunctionName = gi_struct_info_get_copy_function_name;

    /// Obtain the type information for field with specified index.
    extern fn gi_struct_info_get_field(p_info: *StructInfo, p_n: c_uint) *girepository.FieldInfo;
    pub const getField = gi_struct_info_get_field;

    /// Retrieves the name of the free function for `info`, if any is set.
    extern fn gi_struct_info_get_free_function_name(p_info: *StructInfo) ?[*:0]const u8;
    pub const getFreeFunctionName = gi_struct_info_get_free_function_name;

    /// Obtain the type information for method with specified index.
    extern fn gi_struct_info_get_method(p_info: *StructInfo, p_n: c_uint) *girepository.FunctionInfo;
    pub const getMethod = gi_struct_info_get_method;

    /// Obtain the number of fields this structure has.
    extern fn gi_struct_info_get_n_fields(p_info: *StructInfo) c_uint;
    pub const getNFields = gi_struct_info_get_n_fields;

    /// Obtain the number of methods this structure has.
    extern fn gi_struct_info_get_n_methods(p_info: *StructInfo) c_uint;
    pub const getNMethods = gi_struct_info_get_n_methods;

    /// Obtain the total size of the structure.
    extern fn gi_struct_info_get_size(p_info: *StructInfo) usize;
    pub const getSize = gi_struct_info_get_size;

    /// Gets whether the structure is foreign, i.e. if it’s expected to be overridden
    /// by a native language binding instead of relying of introspected bindings.
    extern fn gi_struct_info_is_foreign(p_info: *StructInfo) c_int;
    pub const isForeign = gi_struct_info_is_foreign;

    /// Return true if this structure represents the ‘class structure’ for some
    /// `gobject.Object` or `GInterface`.
    ///
    /// This function is mainly useful to hide this kind of structure from generated
    /// public APIs.
    extern fn gi_struct_info_is_gtype_struct(p_info: *StructInfo) c_int;
    pub const isGtypeStruct = gi_struct_info_is_gtype_struct;

    extern fn gi_struct_info_get_type() usize;
    pub const getGObjectType = gi_struct_info_get_type;

    pub fn as(p_instance: *StructInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GITypeInfo` represents a type, including information about direction and
/// transfer.
///
/// You can retrieve a type info from an argument (see
/// `girepository.ArgInfo`), a function’s return value (see
/// `girepository.FunctionInfo`), a field (see
/// `girepository.FieldInfo`), a property (see
/// `girepository.PropertyInfo`), a constant (see
/// `girepository.ConstantInfo`) or for a union discriminator (see
/// `girepository.UnionInfo`).
///
/// A type can either be a of a basic type which is a standard C primitive
/// type or an interface type. For interface types you need to call
/// `girepository.TypeInfo.getInterface` to get a reference to the base
/// info for that interface.
pub const TypeInfo = extern struct {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = TypeInfo;
    };
    f_parent: girepository.BaseInfoStack,
    f_padding: [6]*anyopaque,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Convert a data pointer from a GLib data structure to a
    /// `girepository.Argument`.
    ///
    /// GLib data structures, such as `glib.List`, `glib.SList`, and
    /// `glib.HashTable`, all store data pointers.
    ///
    /// In the case where the list or hash table is storing single types rather than
    /// structs, these data pointers may have values stuffed into them via macros
    /// such as `GPOINTER_TO_INT`.
    ///
    /// Use this function to ensure that all values are correctly extracted from
    /// stuffed pointers, regardless of the machine’s architecture or endianness.
    ///
    /// This function fills in the appropriate field of `arg` with the value extracted
    /// from `hash_pointer`, depending on the storage type of `info`.
    extern fn gi_type_info_argument_from_hash_pointer(p_info: *TypeInfo, p_hash_pointer: ?*anyopaque, p_arg: *girepository.Argument) void;
    pub const argumentFromHashPointer = gi_type_info_argument_from_hash_pointer;

    /// Obtain the fixed array size of the type, in number of elements (not bytes).
    ///
    /// The type tag must be a `GI_TYPE_TAG_ARRAY` with a fixed size, or `FALSE` will
    /// be returned.
    extern fn gi_type_info_get_array_fixed_size(p_info: *TypeInfo, p_out_size: ?*usize) c_int;
    pub const getArrayFixedSize = gi_type_info_get_array_fixed_size;

    /// Obtain the position of the argument which gives the array length of the type.
    ///
    /// The type tag must be a `GI_TYPE_TAG_ARRAY` with a length argument, or `FALSE`
    /// will be returned.
    extern fn gi_type_info_get_array_length_index(p_info: *TypeInfo, p_out_length_index: ?*c_uint) c_int;
    pub const getArrayLengthIndex = gi_type_info_get_array_length_index;

    /// Obtain the array type for this type.
    ///
    /// See `girepository.ArrayType` for a list of possible values.
    ///
    /// It is an error to call this on an `info` which is not an array type. Use
    /// `girepository.TypeInfo.getTag` to check.
    extern fn gi_type_info_get_array_type(p_info: *TypeInfo) girepository.ArrayType;
    pub const getArrayType = gi_type_info_get_array_type;

    /// For types which have `GI_TYPE_TAG_INTERFACE` such as `gobject.Object`s
    /// and boxed values, this function returns full information about the referenced
    /// type.
    ///
    /// You can then inspect the type of the returned `girepository.BaseInfo`
    /// to further query whether it is a concrete `gobject.Object`, an
    /// interface, a structure, etc., using the type checking macros like
    /// `girepository.ISOBJECTINFO`, or raw `gobject.Type`s with
    /// `gobject.TYPEFROMINSTANCE`.
    extern fn gi_type_info_get_interface(p_info: *TypeInfo) ?*girepository.BaseInfo;
    pub const getInterface = gi_type_info_get_interface;

    /// Obtain the parameter type `n`, or `NULL` if the type is not an array.
    extern fn gi_type_info_get_param_type(p_info: *TypeInfo, p_n: c_uint) ?*girepository.TypeInfo;
    pub const getParamType = gi_type_info_get_param_type;

    /// Obtain the type tag corresponding to the underlying storage type in C for
    /// the type.
    ///
    /// See `girepository.TypeTag` for a list of type tags.
    extern fn gi_type_info_get_storage_type(p_info: *TypeInfo) girepository.TypeTag;
    pub const getStorageType = gi_type_info_get_storage_type;

    /// Obtain the type tag for the type.
    ///
    /// See `girepository.TypeTag` for a list of type tags.
    extern fn gi_type_info_get_tag(p_info: *TypeInfo) girepository.TypeTag;
    pub const getTag = gi_type_info_get_tag;

    /// Convert a `girepository.Argument` to data pointer for use in a GLib
    /// data structure.
    ///
    /// GLib data structures, such as `glib.List`, `glib.SList`, and
    /// `glib.HashTable`, all store data pointers.
    ///
    /// In the case where the list or hash table is storing single types rather than
    /// structs, these data pointers may have values stuffed into them via macros
    /// such as `GPOINTER_TO_INT`.
    ///
    /// Use this function to ensure that all values are correctly stuffed into
    /// pointers, regardless of the machine’s architecture or endianness.
    ///
    /// This function returns a pointer stuffed with the appropriate field of `arg`,
    /// depending on the storage type of `info`.
    extern fn gi_type_info_hash_pointer_from_argument(p_info: *TypeInfo, p_arg: *girepository.Argument) ?*anyopaque;
    pub const hashPointerFromArgument = gi_type_info_hash_pointer_from_argument;

    /// Obtain if the type is passed as a reference.
    ///
    /// Note that the types of `GI_DIRECTION_OUT` and `GI_DIRECTION_INOUT` parameters
    /// will only be pointers if the underlying type being transferred is a pointer
    /// (i.e. only if the type of the C function’s formal parameter is a pointer to a
    /// pointer).
    extern fn gi_type_info_is_pointer(p_info: *TypeInfo) c_int;
    pub const isPointer = gi_type_info_is_pointer;

    /// Obtain if the last element of the array is `NULL`.
    ///
    /// The type tag must be a `GI_TYPE_TAG_ARRAY` or `FALSE` will be returned.
    extern fn gi_type_info_is_zero_terminated(p_info: *TypeInfo) c_int;
    pub const isZeroTerminated = gi_type_info_is_zero_terminated;

    extern fn gi_type_info_get_type() usize;
    pub const getGObjectType = gi_type_info_get_type;

    pub fn as(p_instance: *TypeInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIUnionInfo` represents a union type.
///
/// A union has methods and fields.  Unions can optionally have a
/// discriminator, which is a field deciding what type of real union
/// fields is valid for specified instance.
pub const UnionInfo = opaque {
    pub const Parent = girepository.RegisteredTypeInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = UnionInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the type information for the method named `name`.
    extern fn gi_union_info_find_method(p_info: *UnionInfo, p_name: [*:0]const u8) ?*girepository.FunctionInfo;
    pub const findMethod = gi_union_info_find_method;

    /// Obtain the required alignment of the union.
    extern fn gi_union_info_get_alignment(p_info: *UnionInfo) usize;
    pub const getAlignment = gi_union_info_get_alignment;

    /// Retrieves the name of the copy function for `info`, if any is set.
    extern fn gi_union_info_get_copy_function_name(p_info: *UnionInfo) ?[*:0]const u8;
    pub const getCopyFunctionName = gi_union_info_get_copy_function_name;

    /// Obtain the discriminator value assigned for n-th union field, i.e. the n-th
    /// union field is the active one if the discriminator contains this
    /// constant.
    ///
    /// If the union is not discriminated, `NULL` is returned.
    extern fn gi_union_info_get_discriminator(p_info: *UnionInfo, p_n: usize) ?*girepository.ConstantInfo;
    pub const getDiscriminator = gi_union_info_get_discriminator;

    /// Obtain the offset of the discriminator field within the structure.
    ///
    /// The union must be discriminated, or `FALSE` will be returned.
    extern fn gi_union_info_get_discriminator_offset(p_info: *UnionInfo, p_out_offset: ?*usize) c_int;
    pub const getDiscriminatorOffset = gi_union_info_get_discriminator_offset;

    /// Obtain the type information of the union discriminator.
    extern fn gi_union_info_get_discriminator_type(p_info: *UnionInfo) ?*girepository.TypeInfo;
    pub const getDiscriminatorType = gi_union_info_get_discriminator_type;

    /// Obtain the type information for the field with the specified index.
    extern fn gi_union_info_get_field(p_info: *UnionInfo, p_n: c_uint) *girepository.FieldInfo;
    pub const getField = gi_union_info_get_field;

    /// Retrieves the name of the free function for `info`, if any is set.
    extern fn gi_union_info_get_free_function_name(p_info: *UnionInfo) ?[*:0]const u8;
    pub const getFreeFunctionName = gi_union_info_get_free_function_name;

    /// Obtain the type information for the method with the specified index.
    extern fn gi_union_info_get_method(p_info: *UnionInfo, p_n: c_uint) *girepository.FunctionInfo;
    pub const getMethod = gi_union_info_get_method;

    /// Obtain the number of fields this union has.
    extern fn gi_union_info_get_n_fields(p_info: *UnionInfo) c_uint;
    pub const getNFields = gi_union_info_get_n_fields;

    /// Obtain the number of methods this union has.
    extern fn gi_union_info_get_n_methods(p_info: *UnionInfo) c_uint;
    pub const getNMethods = gi_union_info_get_n_methods;

    /// Obtain the total size of the union.
    extern fn gi_union_info_get_size(p_info: *UnionInfo) usize;
    pub const getSize = gi_union_info_get_size;

    /// Return `TRUE` if this union contains a discriminator field.
    extern fn gi_union_info_is_discriminated(p_info: *UnionInfo) c_int;
    pub const isDiscriminated = gi_union_info_is_discriminated;

    extern fn gi_union_info_get_type() usize;
    pub const getGObjectType = gi_union_info_get_type;

    pub fn as(p_instance: *UnionInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIUnresolvedInfo` represents an unresolved symbol.
pub const UnresolvedInfo = opaque {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = UnresolvedInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gi_unresolved_info_get_type() usize;
    pub const getGObjectType = gi_unresolved_info_get_type;

    pub fn as(p_instance: *UnresolvedInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GIVFuncInfo` represents a virtual function.
///
/// A virtual function is a callable object that belongs to either a
/// `girepository.ObjectInfo` or a `girepository.InterfaceInfo`.
pub const VFuncInfo = opaque {
    pub const Parent = girepository.CallableInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = VFuncInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Looks up where the implementation for `info` is inside the type struct of
    /// `implementor_gtype`.
    extern fn gi_vfunc_info_get_address(p_info: *VFuncInfo, p_implementor_gtype: usize, p_error: ?*?*glib.Error) ?*anyopaque;
    pub const getAddress = gi_vfunc_info_get_address;

    /// Obtain the flags for this virtual function info.
    ///
    /// See `girepository.VFuncInfoFlags` for more information about possible
    /// flag values.
    extern fn gi_vfunc_info_get_flags(p_info: *VFuncInfo) girepository.VFuncInfoFlags;
    pub const getFlags = gi_vfunc_info_get_flags;

    /// If this virtual function has an associated invoker method, this
    /// method will return it.  An invoker method is a C entry point.
    ///
    /// Not all virtuals will have invokers.
    extern fn gi_vfunc_info_get_invoker(p_info: *VFuncInfo) ?*girepository.FunctionInfo;
    pub const getInvoker = gi_vfunc_info_get_invoker;

    /// Obtain the offset of the function pointer in the class struct.
    ///
    /// The value `0xFFFF` indicates that the struct offset is unknown.
    extern fn gi_vfunc_info_get_offset(p_info: *VFuncInfo) usize;
    pub const getOffset = gi_vfunc_info_get_offset;

    /// Obtain the signal for the virtual function if one is set.
    ///
    /// The signal comes from the object or interface to which
    /// this virtual function belongs.
    extern fn gi_vfunc_info_get_signal(p_info: *VFuncInfo) ?*girepository.SignalInfo;
    pub const getSignal = gi_vfunc_info_get_signal;

    /// Invokes the function described in `info` with the given
    /// arguments.
    ///
    /// Note that ‘inout’ parameters must appear in both argument lists.
    extern fn gi_vfunc_info_invoke(p_info: *VFuncInfo, p_implementor: usize, p_in_args: ?[*]const girepository.Argument, p_n_in_args: usize, p_out_args: ?[*]girepository.Argument, p_n_out_args: usize, p_return_value: *girepository.Argument, p_error: ?*?*glib.Error) c_int;
    pub const invoke = gi_vfunc_info_invoke;

    extern fn gi_vfunc_info_get_type() usize;
    pub const getGObjectType = gi_vfunc_info_get_type;

    pub fn as(p_instance: *VFuncInfo, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GIValueInfo` represents a value in an enumeration.
///
/// The `GIValueInfo` is fetched by calling
/// `girepository.EnumInfo.getValue` on a `girepository.EnumInfo`.
pub const ValueInfo = opaque {
    pub const Parent = girepository.BaseInfo;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ValueInfo;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the enumeration value of the `GIValueInfo`.
    extern fn gi_value_info_get_value(p_info: *ValueInfo) i64;
    pub const getValue = gi_value_info_get_value;

    extern fn gi_value_info_get_type() usize;
    pub const getGObjectType = gi_value_info_get_type;

    pub fn as(p_instance: *ValueInfo, comptime P_T: type) *P_T {
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
    f__dummy: [4]*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BaseInfoClass = opaque {
    pub const Instance = girepository.BaseInfo;

    pub fn as(p_instance: *BaseInfoClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BaseInfoStack = extern struct {
    f_parent_instance: gobject.TypeInstance,
    f_dummy0: c_int,
    f_dummy1: [3]*anyopaque,
    f_dummy2: [2]u32,
    f_dummy3: [6]*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RepositoryClass = extern struct {
    pub const Instance = girepository.Repository;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *RepositoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GITypelib` represents a loaded `.typelib` file, which contains a description
/// of a single module’s API.
pub const Typelib = opaque {
    /// Creates a new `girepository.Typelib` from a `glib.Bytes`.
    ///
    /// The `glib.Bytes` can point to a memory location or a mapped file, and
    /// the typelib will hold a reference to it until the repository is destroyed.
    extern fn gi_typelib_new_from_bytes(p_bytes: *glib.Bytes, p_error: ?*?*glib.Error) ?*girepository.Typelib;
    pub const newFromBytes = gi_typelib_new_from_bytes;

    /// Get the name of the namespace represented by `typelib`.
    extern fn gi_typelib_get_namespace(p_typelib: *Typelib) [*:0]const u8;
    pub const getNamespace = gi_typelib_get_namespace;

    /// Increment the reference count of a `girepository.Typelib`.
    extern fn gi_typelib_ref(p_typelib: *Typelib) *girepository.Typelib;
    pub const ref = gi_typelib_ref;

    /// Loads a symbol from a `GITypelib`.
    extern fn gi_typelib_symbol(p_typelib: *Typelib, p_symbol_name: [*:0]const u8, p_symbol: ?*anyopaque) c_int;
    pub const symbol = gi_typelib_symbol;

    /// Decrement the reference count of a `girepository.Typelib`.
    ///
    /// Once the reference count reaches zero, the typelib is freed.
    extern fn gi_typelib_unref(p_typelib: *Typelib) void;
    pub const unref = gi_typelib_unref;

    extern fn gi_typelib_get_type() usize;
    pub const getGObjectType = gi_typelib_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Stores an argument of varying type.
pub const Argument = extern union {
    /// boolean value
    f_v_boolean: c_int,
    /// 8-bit signed integer value
    f_v_int8: i8,
    /// 8-bit unsigned integer value
    f_v_uint8: u8,
    /// 16-bit signed integer value
    f_v_int16: i16,
    /// 16-bit unsigned integer value
    f_v_uint16: u16,
    /// 32-bit signed integer value
    f_v_int32: i32,
    /// 32-bit unsigned integer value
    f_v_uint32: u32,
    /// 64-bit signed integer value
    f_v_int64: i64,
    /// 64-bit unsigned integer value
    f_v_uint64: u64,
    /// single float value
    f_v_float: f32,
    /// double float value
    f_v_double: f64,
    /// signed short integer value
    f_v_short: c_short,
    /// unsigned short integer value
    f_v_ushort: c_ushort,
    /// signed integer value
    f_v_int: c_int,
    /// unsigned integer value
    f_v_uint: c_uint,
    /// signed long integer value
    f_v_long: c_long,
    /// unsigned long integer value
    f_v_ulong: c_ulong,
    /// sized `size_t` value
    f_v_ssize: isize,
    /// unsigned `size_t` value
    f_v_size: usize,
    /// nul-terminated string value
    f_v_string: ?[*:0]u8,
    /// arbitrary pointer value
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

/// An error occurring while invoking a function via
/// `girepository.FunctionInfo.invoke`.
pub const InvokeError = enum(c_int) {
    failed = 0,
    symbol_not_found = 1,
    argument_mismatch = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An error code used with `GI_REPOSITORY_ERROR` in a `glib.Error`
/// returned from a `girepository.Repository` routine.
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

/// Scope type of a `girepository.ArgInfo` representing callback,
/// determines how the callback is invoked and is used to decided when the invoke
/// structs can be freed.
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

/// `GITransfer` specifies who’s responsible for freeing the resources after an
/// ownership transfer is complete.
///
/// The transfer is the exchange of data between two parts, from the callee to
/// the caller.
///
/// The callee is either a function/method/signal or an object/interface where a
/// property is defined. The caller is the side accessing a property or calling a
/// function.
///
/// In the case of a containing type such as a list, an array or a hash table the
/// container itself is specified differently from the items within the
/// container. Each container is freed differently, check the documentation for
/// the types themselves for information on how to free them.
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
    is_async: bool = false,
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
    pub const flags_is_async: FunctionInfoFlags = @bitCast(@as(c_uint, 32));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that control how a typelib is loaded.
pub const RepositoryLoadFlags = packed struct(c_uint) {
    lazy: bool = false,
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

    pub const flags_none: RepositoryLoadFlags = @bitCast(@as(c_uint, 0));
    pub const flags_lazy: RepositoryLoadFlags = @bitCast(@as(c_uint, 1));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags of a `girepository.VFuncInfo` struct.
pub const VFuncInfoFlags = packed struct(c_uint) {
    chain_up: bool = false,
    override: bool = false,
    not_override: bool = false,
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

    pub const flags_chain_up: VFuncInfoFlags = @bitCast(@as(c_uint, 1));
    pub const flags_override: VFuncInfoFlags = @bitCast(@as(c_uint, 2));
    pub const flags_not_override: VFuncInfoFlags = @bitCast(@as(c_uint, 4));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A generic C closure marshal function using ffi and
/// `girepository.Argument`.
extern fn gi_cclosure_marshal_generic(p_closure: *gobject.Closure, p_return_gvalue: ?*gobject.Value, p_n_param_values: c_uint, p_param_values: [*]const gobject.Value, p_invocation_hint: ?*anyopaque, p_marshal_data: ?*anyopaque) void;
pub const cclosureMarshalGeneric = gi_cclosure_marshal_generic;

/// Get the error quark which represents `girepository.InvokeError`.
extern fn gi_invoke_error_quark() glib.Quark;
pub const invokeErrorQuark = gi_invoke_error_quark;

/// Convert a data pointer from a GLib data structure to a
/// `girepository.Argument`.
///
/// GLib data structures, such as `glib.List`, `glib.SList`, and
/// `glib.HashTable`, all store data pointers.
///
/// In the case where the list or hash table is storing single types rather than
/// structs, these data pointers may have values stuffed into them via macros
/// such as `GPOINTER_TO_INT`.
///
/// Use this function to ensure that all values are correctly extracted from
/// stuffed pointers, regardless of the machine’s architecture or endianness.
///
/// This function fills in the appropriate field of `arg` with the value extracted
/// from `hash_pointer`, depending on `storage_type`.
extern fn gi_type_tag_argument_from_hash_pointer(p_storage_type: girepository.TypeTag, p_hash_pointer: ?*anyopaque, p_arg: *girepository.Argument) void;
pub const typeTagArgumentFromHashPointer = gi_type_tag_argument_from_hash_pointer;

/// Convert a `girepository.Argument` to data pointer for use in a GLib
/// data structure.
///
/// GLib data structures, such as `glib.List`, `glib.SList`, and
/// `glib.HashTable`, all store data pointers.
///
/// In the case where the list or hash table is storing single types rather than
/// structs, these data pointers may have values stuffed into them via macros
/// such as `GPOINTER_TO_INT`.
///
/// Use this function to ensure that all values are correctly stuffed into
/// pointers, regardless of the machine’s architecture or endianness.
///
/// This function returns a pointer stuffed with the appropriate field of `arg`,
/// depending on `storage_type`.
extern fn gi_type_tag_hash_pointer_from_argument(p_storage_type: girepository.TypeTag, p_arg: *girepository.Argument) ?*anyopaque;
pub const typeTagHashPointerFromArgument = gi_type_tag_hash_pointer_from_argument;

/// Obtain a string representation of `type`
extern fn gi_type_tag_to_string(p_type: girepository.TypeTag) [*:0]const u8;
pub const typeTagToString = gi_type_tag_to_string;

/// Extract an object instance out of `value`.
pub const ObjectInfoGetValueFunction = *const fn (p_value: *const gobject.Value) callconv(.c) ?*anyopaque;

/// Increases the reference count of an object instance.
pub const ObjectInfoRefFunction = *const fn (p_object: ?*anyopaque) callconv(.c) ?*anyopaque;

/// Update `value` and attach the object instance pointer `object` to it.
pub const ObjectInfoSetValueFunction = *const fn (p_value: *gobject.Value, p_object: ?*anyopaque) callconv(.c) void;

/// Decreases the reference count of an object instance.
pub const ObjectInfoUnrefFunction = *const fn (p_object: ?*anyopaque) callconv(.c) void;

/// Number of entries in `girepository.TypeTag`.
pub const TYPE_TAG_N_TYPES = 22;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
