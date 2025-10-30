pub const ext = @import("ext.zig");
const json = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// `JsonBuilder` provides an object for generating a JSON tree.
///
/// The root of the JSON tree can be either a `json.Object` or a `json.Array`.
/// Thus the first call must necessarily be either
/// `json.Builder.beginObject` or `json.Builder.beginArray`.
///
/// For convenience to language bindings, most `JsonBuilder` method return the
/// instance, making it easy to chain function calls.
///
/// ## Using `JsonBuilder`
///
/// ```c
/// g_autoptr(JsonBuilder) builder = json_builder_new ();
///
/// json_builder_begin_object (builder);
///
/// json_builder_set_member_name (builder, "url");
/// json_builder_add_string_value (builder, "http://www.gnome.org/img/flash/two-thirty.png");
///
/// json_builder_set_member_name (builder, "size");
/// json_builder_begin_array (builder);
/// json_builder_add_int_value (builder, 652);
/// json_builder_add_int_value (builder, 242);
/// json_builder_end_array (builder);
///
/// json_builder_end_object (builder);
///
/// g_autoptr(JsonNode) root = json_builder_get_root (builder);
///
/// g_autoptr(JsonGenerator) gen = json_generator_new ();
/// json_generator_set_root (gen, root);
/// g_autofree char *str = json_generator_to_data (gen, NULL);
///
/// // str now contains the following JSON data
/// // { "url" : "http://www.gnome.org/img/flash/two-thirty.png", "size" : [ 652, 242 ] }
/// ```
pub const Builder = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = json.BuilderClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*json.BuilderPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the tree should be immutable when created.
        ///
        /// Making the output immutable on creation avoids the expense
        /// of traversing it to make it immutable later.
        pub const immutable = struct {
            pub const name = "immutable";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new `JsonBuilder`.
    ///
    /// You can use this object to generate a JSON tree and obtain the root node.
    extern fn json_builder_new() *json.Builder;
    pub const new = json_builder_new;

    /// Creates a new, immutable `JsonBuilder` instance.
    ///
    /// It is equivalent to setting the `json.Builder.properties.immutable` property
    /// set to `TRUE` at construction time.
    extern fn json_builder_new_immutable() *json.Builder;
    pub const newImmutable = json_builder_new_immutable;

    /// Adds a boolean value to the currently open object member or array.
    ///
    /// If called after `json.Builder.setMemberName`, sets the given value
    /// as the value of the current member in the open object; otherwise, the value
    /// is appended to the elements of the open array.
    ///
    /// See also: `json.Builder.addValue`
    extern fn json_builder_add_boolean_value(p_builder: *Builder, p_value: c_int) ?*json.Builder;
    pub const addBooleanValue = json_builder_add_boolean_value;

    /// Adds a floating point value to the currently open object member or array.
    ///
    /// If called after `json.Builder.setMemberName`, sets the given value
    /// as the value of the current member in the open object; otherwise, the value
    /// is appended to the elements of the open array.
    ///
    /// See also: `json.Builder.addValue`
    extern fn json_builder_add_double_value(p_builder: *Builder, p_value: f64) ?*json.Builder;
    pub const addDoubleValue = json_builder_add_double_value;

    /// Adds an integer value to the currently open object member or array.
    ///
    /// If called after `json.Builder.setMemberName`, sets the given value
    /// as the value of the current member in the open object; otherwise, the value
    /// is appended to the elements of the open array.
    ///
    /// See also: `json.Builder.addValue`
    extern fn json_builder_add_int_value(p_builder: *Builder, p_value: i64) ?*json.Builder;
    pub const addIntValue = json_builder_add_int_value;

    /// Adds a null value to the currently open object member or array.
    ///
    /// If called after `json.Builder.setMemberName`, sets the given value
    /// as the value of the current member in the open object; otherwise, the value
    /// is appended to the elements of the open array.
    ///
    /// See also: `json.Builder.addValue`
    extern fn json_builder_add_null_value(p_builder: *Builder) ?*json.Builder;
    pub const addNullValue = json_builder_add_null_value;

    /// Adds a string value to the currently open object member or array.
    ///
    /// If called after `json.Builder.setMemberName`, sets the given value
    /// as the value of the current member in the open object; otherwise, the value
    /// is appended to the elements of the open array.
    ///
    /// See also: `json.Builder.addValue`
    extern fn json_builder_add_string_value(p_builder: *Builder, p_value: [*:0]const u8) ?*json.Builder;
    pub const addStringValue = json_builder_add_string_value;

    /// Adds a value to the currently open object member or array.
    ///
    /// If called after `json.Builder.setMemberName`, sets the given node
    /// as the value of the current member in the open object; otherwise, the node
    /// is appended to the elements of the open array.
    ///
    /// The builder will take ownership of the node.
    extern fn json_builder_add_value(p_builder: *Builder, p_node: *json.Node) ?*json.Builder;
    pub const addValue = json_builder_add_value;

    /// Opens an array inside the given builder.
    ///
    /// You can add a new element to the array by using `json.Builder.addValue`.
    ///
    /// Once you added all elements to the array, you must call
    /// `json.Builder.endArray` to close the array.
    extern fn json_builder_begin_array(p_builder: *Builder) ?*json.Builder;
    pub const beginArray = json_builder_begin_array;

    /// Opens an object inside the given builder.
    ///
    /// You can add a new member to the object by using `json.Builder.setMemberName`,
    /// followed by `json.Builder.addValue`.
    ///
    /// Once you added all members to the object, you must call `json.Builder.endObject`
    /// to close the object.
    ///
    /// If the builder is in an inconsistent state, this function will return `NULL`.
    extern fn json_builder_begin_object(p_builder: *Builder) ?*json.Builder;
    pub const beginObject = json_builder_begin_object;

    /// Closes the array inside the given builder that was opened by the most
    /// recent call to `json.Builder.beginArray`.
    ///
    /// This function cannot be called after `json.Builder.setMemberName`.
    extern fn json_builder_end_array(p_builder: *Builder) ?*json.Builder;
    pub const endArray = json_builder_end_array;

    /// Closes the object inside the given builder that was opened by the most
    /// recent call to `json.Builder.beginObject`.
    ///
    /// This function cannot be called after `json.Builder.setMemberName`.
    extern fn json_builder_end_object(p_builder: *Builder) ?*json.Builder;
    pub const endObject = json_builder_end_object;

    /// Returns the root of the currently constructed tree.
    ///
    /// if the build is incomplete (ie: if there are any opened objects, or any
    /// open object members and array elements) then this function will return
    /// `NULL`.
    extern fn json_builder_get_root(p_builder: *Builder) ?*json.Node;
    pub const getRoot = json_builder_get_root;

    /// Resets the state of the builder back to its initial state.
    extern fn json_builder_reset(p_builder: *Builder) void;
    pub const reset = json_builder_reset;

    /// Sets the name of the member in an object.
    ///
    /// This function must be followed by of these functions:
    ///
    ///  - `json.Builder.addValue`, to add a scalar value to the member
    ///  - `json.Builder.beginObject`, to add an object to the member
    ///  - `json.Builder.beginArray`, to add an array to the member
    ///
    /// This function can only be called within an open object.
    extern fn json_builder_set_member_name(p_builder: *Builder, p_member_name: [*:0]const u8) ?*json.Builder;
    pub const setMemberName = json_builder_set_member_name;

    extern fn json_builder_get_type() usize;
    pub const getGObjectType = json_builder_get_type;

    extern fn g_object_ref(p_self: *json.Builder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *json.Builder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Builder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `JsonGenerator` provides an object for generating a JSON data stream
/// from a tree of `json.Node` instances, and put it into a buffer
/// or a file.
pub const Generator = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = json.GeneratorClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*json.GeneratorPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Number of spaces to be used to indent when pretty printing.
        pub const indent = struct {
            pub const name = "indent";

            pub const Type = c_uint;
        };

        /// The character that should be used when indenting in pretty print.
        pub const indent_char = struct {
            pub const name = "indent-char";

            pub const Type = c_uint;
        };

        /// Whether the output should be "pretty-printed", with indentation and
        /// newlines.
        ///
        /// The indentation level can be controlled by using the
        /// `json.Generator.properties.indent` property.
        pub const pretty = struct {
            pub const name = "pretty";

            pub const Type = c_int;
        };

        /// The root node to be used when constructing a JSON data
        /// stream.
        pub const root = struct {
            pub const name = "root";

            pub const Type = ?*json.Node;
        };
    };

    pub const signals = struct {};

    /// Creates a new `JsonGenerator`.
    ///
    /// You can use this object to generate a JSON data stream starting from a
    /// data object model composed by `json.Node`s.
    extern fn json_generator_new() *json.Generator;
    pub const new = json_generator_new;

    /// Retrieves the value set using `json.Generator.setIndent`.
    extern fn json_generator_get_indent(p_generator: *Generator) c_uint;
    pub const getIndent = json_generator_get_indent;

    /// Retrieves the value set using `json.Generator.setIndentChar`.
    extern fn json_generator_get_indent_char(p_generator: *Generator) u32;
    pub const getIndentChar = json_generator_get_indent_char;

    /// Retrieves the value set using `json.Generator.setPretty`.
    extern fn json_generator_get_pretty(p_generator: *Generator) c_int;
    pub const getPretty = json_generator_get_pretty;

    /// Retrieves a pointer to the root node set using
    /// `json.Generator.setRoot`.
    extern fn json_generator_get_root(p_generator: *Generator) ?*json.Node;
    pub const getRoot = json_generator_get_root;

    /// Sets the number of repetitions for each indentation level.
    extern fn json_generator_set_indent(p_generator: *Generator, p_indent_level: c_uint) void;
    pub const setIndent = json_generator_set_indent;

    /// Sets the character to be used when indenting.
    extern fn json_generator_set_indent_char(p_generator: *Generator, p_indent_char: u32) void;
    pub const setIndentChar = json_generator_set_indent_char;

    /// Sets whether the generated JSON should be pretty printed.
    ///
    /// Pretty printing will use indentation character specified in the
    /// `json.Generator.properties.indent_char` property and the spacing
    /// specified in the `json.Generator.properties.indent` property.
    extern fn json_generator_set_pretty(p_generator: *Generator, p_is_pretty: c_int) void;
    pub const setPretty = json_generator_set_pretty;

    /// Sets the root of the JSON data stream to be serialized by
    /// the given generator.
    ///
    /// The passed `node` is copied by the generator object, so it can be
    /// safely freed after calling this function.
    extern fn json_generator_set_root(p_generator: *Generator, p_node: *json.Node) void;
    pub const setRoot = json_generator_set_root;

    /// Sets the root of the JSON data stream to be serialized by
    /// the given generator.
    ///
    /// The ownership of the passed `node` is transferred to the generator object.
    extern fn json_generator_take_root(p_generator: *Generator, p_node: ?*json.Node) void;
    pub const takeRoot = json_generator_take_root;

    /// Generates a JSON data stream from `generator` and returns it as a
    /// buffer.
    extern fn json_generator_to_data(p_generator: *Generator, p_length: ?*usize) [*:0]u8;
    pub const toData = json_generator_to_data;

    /// Creates a JSON data stream and puts it inside `filename`, overwriting
    /// the file's current contents.
    ///
    /// This operation is atomic, in the sense that the data is written to a
    /// temporary file which is then renamed to the given `filename`.
    extern fn json_generator_to_file(p_generator: *Generator, p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const toFile = json_generator_to_file;

    /// Generates a JSON data stream and appends it to the string buffer.
    extern fn json_generator_to_gstring(p_generator: *Generator, p_string: *glib.String) *glib.String;
    pub const toGstring = json_generator_to_gstring;

    /// Outputs JSON data and writes it (synchronously) to the given stream.
    extern fn json_generator_to_stream(p_generator: *Generator, p_stream: *gio.OutputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const toStream = json_generator_to_stream;

    extern fn json_generator_get_type() usize;
    pub const getGObjectType = json_generator_get_type;

    extern fn g_object_ref(p_self: *json.Generator) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *json.Generator) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Generator, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `JsonParser` provides an object for parsing a JSON data stream, either
/// inside a file or inside a static buffer.
///
/// ## Using `JsonParser`
///
/// The `JsonParser` API is fairly simple:
///
/// ```c
/// gboolean
/// parse_json (const char *filename)
/// {
///   g_autoptr(JsonParser) parser = json_parser_new ();
///   g_autoptr(GError) error = NULL
///
///   json_parser_load_from_file (parser, filename, &error);
///   if (error != NULL)
///     {
///       g_critical ("Unable to parse '`s`': `s`", filename, error->message);
///       return FALSE;
///     }
///
///   g_autoptr(JsonNode) root = json_parser_get_root (parser);
///
///   // manipulate the object tree from the root node
///
///   return TRUE
/// }
/// ```
///
/// By default, the entire process of loading the data and parsing it is
/// synchronous; the `json.Parser.loadFromStreamAsync` API will
/// load the data asynchronously, but parse it in the main context as the
/// signals of the parser must be emitted in the same thread. If you do
/// not use signals, and you wish to also parse the JSON data without blocking,
/// you should use a `GTask` and the synchronous `JsonParser` API inside the
/// task itself.
pub const Parser = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = json.ParserClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*json.ParserPrivate,

    pub const virtual_methods = struct {
        /// class handler for the JsonParser::array-element signal
        pub const array_element = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_array: *json.Array, p_index_: c_int) void {
                return gobject.ext.as(Parser.Class, p_class).f_array_element.?(gobject.ext.as(Parser, p_parser), p_array, p_index_);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_array: *json.Array, p_index_: c_int) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_array_element = @ptrCast(p_implementation);
            }
        };

        /// class handler for the JsonParser::array-end signal
        pub const array_end = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_array: *json.Array) void {
                return gobject.ext.as(Parser.Class, p_class).f_array_end.?(gobject.ext.as(Parser, p_parser), p_array);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_array: *json.Array) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_array_end = @ptrCast(p_implementation);
            }
        };

        /// class handler for the JsonParser::array-start signal
        pub const array_start = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Parser.Class, p_class).f_array_start.?(gobject.ext.as(Parser, p_parser));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_array_start = @ptrCast(p_implementation);
            }
        };

        /// class handler for the JsonParser::error signal
        pub const @"error" = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: *const glib.Error) void {
                return gobject.ext.as(Parser.Class, p_class).f_error.?(gobject.ext.as(Parser, p_parser), p_error);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_error: *const glib.Error) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_error = @ptrCast(p_implementation);
            }
        };

        /// class handler for the JsonParser::object-end signal
        pub const object_end = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_object: *json.Object) void {
                return gobject.ext.as(Parser.Class, p_class).f_object_end.?(gobject.ext.as(Parser, p_parser), p_object);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_object: *json.Object) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_object_end = @ptrCast(p_implementation);
            }
        };

        /// class handler for the JsonParser::object-member signal
        pub const object_member = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_object: *json.Object, p_member_name: [*:0]const u8) void {
                return gobject.ext.as(Parser.Class, p_class).f_object_member.?(gobject.ext.as(Parser, p_parser), p_object, p_member_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_object: *json.Object, p_member_name: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_object_member = @ptrCast(p_implementation);
            }
        };

        /// class handler for the JsonParser::object-start signal
        pub const object_start = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Parser.Class, p_class).f_object_start.?(gobject.ext.as(Parser, p_parser));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_object_start = @ptrCast(p_implementation);
            }
        };

        /// class handler for the JsonParser::parse-end signal
        pub const parse_end = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Parser.Class, p_class).f_parse_end.?(gobject.ext.as(Parser, p_parser));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_parse_end = @ptrCast(p_implementation);
            }
        };

        /// class handler for the JsonParser::parse-start signal
        pub const parse_start = struct {
            pub fn call(p_class: anytype, p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Parser.Class, p_class).f_parse_start.?(gobject.ext.as(Parser, p_parser));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_parser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Parser.Class, p_class).f_parse_start = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Whether the tree built by the parser should be immutable
        /// when created.
        ///
        /// Making the output immutable on creation avoids the expense
        /// of traversing it to make it immutable later.
        pub const immutable = struct {
            pub const name = "immutable";

            pub const Type = c_int;
        };

        /// Whether the parser should be strictly conforming to the
        /// JSON format, or allow custom extensions like comments.
        pub const strict = struct {
            pub const name = "strict";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// The `::array-element` signal is emitted each time a parser
        /// has successfully parsed a single element of a JSON array.
        pub const array_element = struct {
            pub const name = "array-element";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_array: *json.Array, p_index_: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("array-element", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The `::array-end` signal is emitted each time a parser
        /// has successfully parsed an entire JSON array.
        pub const array_end = struct {
            pub const name = "array-end";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_array: *json.Array, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("array-end", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The `::array-start` signal is emitted each time a parser
        /// starts parsing a JSON array.
        pub const array_start = struct {
            pub const name = "array-start";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("array-start", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The `::error` signal is emitted each time a parser encounters
        /// an error in a JSON stream.
        pub const @"error" = struct {
            pub const name = "error";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_error: ?*anyopaque, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("error", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The `::object-end` signal is emitted each time a parser
        /// has successfully parsed an entire JSON object.
        pub const object_end = struct {
            pub const name = "object-end";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *json.Object, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("object-end", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The `::object-member` signal is emitted each time a parser
        /// has successfully parsed a single member of a JSON object.
        pub const object_member = struct {
            pub const name = "object-member";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *json.Object, p_member_name: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("object-member", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted each time a parser starts parsing a JSON object.
        pub const object_start = struct {
            pub const name = "object-start";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("object-start", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when a parser successfully finished parsing a
        /// JSON data stream.
        pub const parse_end = struct {
            pub const name = "parse-end";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("parse-end", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when a parser starts parsing a JSON data stream.
        pub const parse_start = struct {
            pub const name = "parse-start";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Parser, p_instance))),
                    gobject.signalLookup("parse-start", Parser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new JSON parser.
    ///
    /// You can use the `JsonParser` to load a JSON stream from either a file or a
    /// buffer and then walk the hierarchy using the data types API.
    extern fn json_parser_new() *json.Parser;
    pub const new = json_parser_new;

    /// Creates a new parser instance with its `json.Parser.properties.immutable`
    /// property set to `TRUE` to create immutable output trees.
    extern fn json_parser_new_immutable() *json.Parser;
    pub const newImmutable = json_parser_new_immutable;

    /// Retrieves the line currently parsed, starting from 1.
    ///
    /// This function has defined behaviour only while parsing; calling this
    /// function from outside the signal handlers emitted by the parser will
    /// yield 0.
    extern fn json_parser_get_current_line(p_parser: *Parser) c_uint;
    pub const getCurrentLine = json_parser_get_current_line;

    /// Retrieves the current position inside the current line, starting
    /// from 0.
    ///
    /// This function has defined behaviour only while parsing; calling this
    /// function from outside the signal handlers emitted by the parser will
    /// yield 0.
    extern fn json_parser_get_current_pos(p_parser: *Parser) c_uint;
    pub const getCurrentPos = json_parser_get_current_pos;

    /// Retrieves the top level node from the parsed JSON stream.
    ///
    /// If the parser input was an empty string, or if parsing failed, the root
    /// will be `NULL`. It will also be `NULL` if it has been stolen using
    /// `json.Parser.stealRoot`.
    extern fn json_parser_get_root(p_parser: *Parser) ?*json.Node;
    pub const getRoot = json_parser_get_root;

    /// Retrieves whether the parser is operating in strict mode.
    extern fn json_parser_get_strict(p_parser: *Parser) c_int;
    pub const getStrict = json_parser_get_strict;

    /// A JSON data stream might sometimes contain an assignment, like:
    ///
    /// ```
    /// var _json_data = { "member_name" : [ ...
    /// ```
    ///
    /// even though it would technically constitute a violation of the RFC.
    ///
    /// `JsonParser` will ignore the left hand identifier and parse the right
    /// hand value of the assignment. `JsonParser` will record, though, the
    /// existence of the assignment in the data stream and the variable name
    /// used.
    extern fn json_parser_has_assignment(p_parser: *Parser, p_variable_name: ?*[*:0]u8) c_int;
    pub const hasAssignment = json_parser_has_assignment;

    /// Loads a JSON stream from a buffer and parses it.
    ///
    /// You can call this function multiple times with the same parser, but the
    /// contents of the parser will be destroyed each time.
    extern fn json_parser_load_from_data(p_parser: *Parser, p_data: [*:0]const u8, p_length: isize, p_error: ?*?*glib.Error) c_int;
    pub const loadFromData = json_parser_load_from_data;

    /// Loads a JSON stream from the content of `filename` and parses it.
    ///
    /// If the file is large or shared between processes,
    /// `json.Parser.loadFromMappedFile` may be a more efficient
    /// way to load it.
    ///
    /// See also: `json.Parser.loadFromData`
    extern fn json_parser_load_from_file(p_parser: *Parser, p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const loadFromFile = json_parser_load_from_file;

    /// Loads a JSON stream from the content of `filename` and parses it.
    ///
    /// Unlike `json.Parser.loadFromFile`, `filename` will be memory
    /// mapped as read-only and parsed. `filename` will be unmapped before this
    /// function returns.
    ///
    /// If mapping or reading the file fails, a `G_FILE_ERROR` will be returned.
    extern fn json_parser_load_from_mapped_file(p_parser: *Parser, p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const loadFromMappedFile = json_parser_load_from_mapped_file;

    /// Loads the contents of an input stream and parses them.
    ///
    /// If `cancellable` is not `NULL`, then the operation can be cancelled by
    /// triggering the cancellable object from another thread. If the
    /// operation was cancelled, `G_IO_ERROR_CANCELLED` will be set
    /// on the given `error`.
    extern fn json_parser_load_from_stream(p_parser: *Parser, p_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const loadFromStream = json_parser_load_from_stream;

    /// Asynchronously reads the contents of a stream.
    ///
    /// For more details, see `json.Parser.loadFromStream`, which is the
    /// synchronous version of this call.
    ///
    /// When the operation is finished, `callback` will be called. You should
    /// then call `json.Parser.loadFromStreamFinish` to get the result
    /// of the operation.
    extern fn json_parser_load_from_stream_async(p_parser: *Parser, p_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const loadFromStreamAsync = json_parser_load_from_stream_async;

    /// Finishes an asynchronous stream loading started with
    /// `json.Parser.loadFromStreamAsync`.
    extern fn json_parser_load_from_stream_finish(p_parser: *Parser, p_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const loadFromStreamFinish = json_parser_load_from_stream_finish;

    /// Sets whether the parser should operate in strict mode.
    ///
    /// If `strict` is true, `JsonParser` will strictly conform to
    /// the JSON format.
    ///
    /// If `strict` is false, `JsonParser` will allow custom extensions
    /// to the JSON format, like comments.
    extern fn json_parser_set_strict(p_parser: *Parser, p_strict: c_int) void;
    pub const setStrict = json_parser_set_strict;

    /// Steals the top level node from the parsed JSON stream.
    ///
    /// This will be `NULL` in the same situations as `json.Parser.getRoot`
    /// return `NULL`.
    extern fn json_parser_steal_root(p_parser: *Parser) ?*json.Node;
    pub const stealRoot = json_parser_steal_root;

    extern fn json_parser_get_type() usize;
    pub const getGObjectType = json_parser_get_type;

    extern fn g_object_ref(p_self: *json.Parser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *json.Parser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Parser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `JsonPath` is a simple class implementing the JSONPath syntax for extracting
/// data out of a JSON tree.
///
/// While the semantics of the JSONPath expressions are heavily borrowed by the
/// XPath specification for XML, the syntax follows the ECMAScript origins of
/// JSON.
///
/// Once a `JsonPath` instance has been created, it has to compile a JSONPath
/// expression using `json.Path.compile` before being able to match it to
/// a JSON tree; the same `JsonPath` instance can be used to match multiple JSON
/// trees. It it also possible to compile a new JSONPath expression using the
/// same `JsonPath` instance; the previous expression will be discarded only if
/// the compilation of the new expression is successful.
///
/// The simple convenience function `json.Path.query` can be used for
/// one-off matching.
///
/// ## Syntax of the JSONPath expressions
///
/// A JSONPath expression is composed by path indices and operators.
/// Each path index can either be a member name or an element index inside
/// a JSON tree. A JSONPath expression must start with the `$` operator; each
/// path index is separated using either the dot notation or the bracket
/// notation, e.g.:
///
/// ```
/// // dot notation
/// $.store.book[0].title
///
/// // bracket notation
/// $['store']['book'][0]['title']
/// ```
///
/// The available operators are:
///
/// * The `$` character represents the root node of the JSON tree, and
///   matches the entire document.
///
/// * Child nodes can either be matched using `.` or `[]`. For instance,
///   both `$.store.book` and `$['store']['book']` match the contents of
///   the book member of the store object.
///
/// * Child nodes can be reached without specifying the whole tree structure
///   through the recursive descent operator, or `..`. For instance,
///   `$..author` matches all author member in every object.
///
/// * Child nodes can grouped through the wildcard operator, or `*`. For
///   instance, `$.store.book[*].author` matches all author members of any
///   object element contained in the book array of the store object.
///
/// * Element nodes can be accessed using their index (starting from zero)
///   in the subscript operator `[]`. For instance, `$.store.book[0]` matches
///   the first element of the book array of the store object.
///
/// * Subsets of element nodes can be accessed using the set notation
///   operator `[i,j,...]`. For instance, `$.store.book[0,2]` matches the
///   elements 0 and 2 (the first and third) of the book array of the store
///   object.
///
/// * Slices of element nodes can be accessed using the slice notation
///   operation `[start:end:step]`. If start is omitted, the starting index
///   of the slice is implied to be zero; if end is omitted, the ending index
///   of the slice is implied to be the length of the array; if step is
///   omitted, the step of the slice is implied to be 1. For instance,
///   `$.store.book[:2]` matches the first two elements of the book array
///   of the store object.
///
/// More information about JSONPath is available on Stefan Gössner's
/// [JSONPath website](http://goessner.net/articles/JsonPath/).
///
/// ## Example of JSONPath matches
///
/// The following example shows some of the results of using `JsonPath`
/// on a JSON tree. We use the following JSON description of a bookstore:
///
/// ```json
/// { "store": {
///     "book": [
///       { "category": "reference", "author": "Nigel Rees",
///         "title": "Sayings of the Century", "price": "8.95"  },
///       { "category": "fiction", "author": "Evelyn Waugh",
///         "title": "Sword of Honour", "price": "12.99" },
///       { "category": "fiction", "author": "Herman Melville",
///         "title": "Moby Dick", "isbn": "0-553-21311-3",
///         "price": "8.99" },
///       { "category": "fiction", "author": "J. R. R. Tolkien",
///         "title": "The Lord of the Rings", "isbn": "0-395-19395-8",
///         "price": "22.99" }
///     ],
///     "bicycle": { "color": "red", "price": "19.95" }
///   }
/// }
/// ```
///
/// We can parse the JSON using `json.Parser`:
///
/// ```c
/// JsonParser *parser = json_parser_new ();
/// json_parser_load_from_data (parser, json_data, -1, NULL);
/// ```
///
/// If we run the following code:
///
/// ```c
/// JsonNode *result;
/// JsonPath *path = json_path_new ();
/// json_path_compile (path, "$.store..author", NULL);
/// result = json_path_match (path, json_parser_get_root (parser));
/// ```
///
/// The `result` node will contain an array with all values of the
/// author member of the objects in the JSON tree. If we use a
/// `json.Generator` to convert the `result` node to a string
/// and print it:
///
/// ```c
/// JsonGenerator *generator = json_generator_new ();
/// json_generator_set_root (generator, result);
/// char *str = json_generator_to_data (generator, NULL);
/// g_print ("Results: `s`\n", str);
/// ```
///
/// The output will be:
///
/// ```json
/// ["Nigel Rees","Evelyn Waugh","Herman Melville","J. R. R. Tolkien"]
/// ```
pub const Path = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = json.PathClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Queries a JSON tree using a JSONPath expression.
    ///
    /// This function is a simple wrapper around `json.Path.new`,
    /// `json.Path.compile`, and `json.Path.match`. It implicitly
    /// creates a `JsonPath` instance, compiles the given expression and matches
    /// it against the JSON tree pointed by `root`.
    extern fn json_path_query(p_expression: [*:0]const u8, p_root: *json.Node, p_error: ?*?*glib.Error) ?*json.Node;
    pub const query = json_path_query;

    /// Creates a new `JsonPath` instance.
    ///
    /// Once created, the `JsonPath` object should be used with
    /// `json.Path.compile` and `json.Path.match`.
    extern fn json_path_new() *json.Path;
    pub const new = json_path_new;

    /// Validates and decomposes the given expression.
    ///
    /// A JSONPath expression must be compiled before calling
    /// `json.Path.match`.
    extern fn json_path_compile(p_path: *Path, p_expression: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const compile = json_path_compile;

    /// Matches the JSON tree pointed by `root` using the expression compiled
    /// into the `JsonPath`.
    ///
    /// The nodes matching the expression will be copied into an array.
    extern fn json_path_match(p_path: *Path, p_root: *json.Node) *json.Node;
    pub const match = json_path_match;

    extern fn json_path_get_type() usize;
    pub const getGObjectType = json_path_get_type;

    extern fn g_object_ref(p_self: *json.Path) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *json.Path) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Path, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `JsonReader` provides a simple, cursor-based API for parsing a JSON DOM.
///
/// It is similar, in spirit, to the XML Reader API.
///
/// The cursor is moved by the `json_reader_read_*` and the `json_reader_end_*`
/// functions. You can enter a JSON object using `json.Reader.readMember`
/// with the name of the object member, access the value at that position, and
/// move the cursor back one level using `json.Reader.endMember`; arrays
/// work in a similar way, using `json.Reader.readElement` with the
/// index of the element, and using `json.Reader.endElement` to move
/// the cursor back.
///
/// ## Using `JsonReader`
///
/// ```c
/// g_autoptr(JsonParser) parser = json_parser_new ();
///
/// // str is defined elsewhere and contains:
/// // { "url" : "http://www.gnome.org/img/flash/two-thirty.png", "size" : [ 652, 242 ] }
/// json_parser_load_from_data (parser, str, -1, NULL);
///
/// g_autoptr(JsonReader) reader = json_reader_new (json_parser_get_root (parser));
///
/// // Enter the "url" member of the object
/// json_reader_read_member (reader, "url");
///   const char *url = json_reader_get_string_value (reader);
///   // url now contains "http://www.gnome.org/img/flash/two-thirty.png"
///   json_reader_end_member (reader);
///
/// // Enter the "size" member of the object
/// json_reader_read_member (reader, "size");
///   // Enter the first element of the array
///   json_reader_read_element (reader, 0);
///     int width = json_reader_get_int_value (reader);
///     // width now contains 652
///     json_reader_end_element (reader);
///   // Enter the second element of the array
///   json_reader_read_element (reader, 1);
///     int height = json_reader_get_int_value (reader);
///     // height now contains 242
///     json_reader_end_element (reader);
///   json_reader_end_member (reader);
/// ```
///
/// ## Error handling
///
/// In case of error, `JsonReader` will be set in an error state; all subsequent
/// calls will simply be ignored until a function that resets the error state is
/// called, e.g.:
///
/// ```c
/// // ask for the 7th element; if the element does not exist, the
/// // reader will be put in an error state
/// json_reader_read_element (reader, 6);
///
/// // in case of error, this will return NULL, otherwise it will
/// // return the value of the element
/// str = json_reader_get_string_value (value);
///
/// // this function resets the error state if any was set
/// json_reader_end_element (reader);
/// ```
///
/// If you want to detect the error state as soon as possible, you can use
/// `json.Reader.getError`:
///
/// ```c
/// // like the example above, but in this case we print out the
/// // error immediately
/// if (!json_reader_read_element (reader, 6))
///   {
///     const GError *error = json_reader_get_error (reader);
///     g_print ("Unable to read the element: `s`", error->message);
///   }
/// ```
pub const Reader = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = json.ReaderClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*json.ReaderPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The root of the JSON tree that the reader should read.
        pub const root = struct {
            pub const name = "root";

            pub const Type = ?*json.Node;
        };
    };

    pub const signals = struct {};

    /// Creates a new reader.
    ///
    /// You can use this object to read the contents of the JSON tree starting
    /// from the given node.
    extern fn json_reader_new(p_node: ?*json.Node) *json.Reader;
    pub const new = json_reader_new;

    /// Counts the elements of the current position, if the reader is
    /// positioned on an array.
    ///
    /// In case of failure, the reader is set to an error state.
    extern fn json_reader_count_elements(p_reader: *Reader) c_int;
    pub const countElements = json_reader_count_elements;

    /// Counts the members of the current position, if the reader is
    /// positioned on an object.
    ///
    /// In case of failure, the reader is set to an error state.
    extern fn json_reader_count_members(p_reader: *Reader) c_int;
    pub const countMembers = json_reader_count_members;

    /// Moves the cursor back to the previous node after being positioned
    /// inside an array.
    ///
    /// This function resets the error state of the reader, if any was set.
    extern fn json_reader_end_element(p_reader: *Reader) void;
    pub const endElement = json_reader_end_element;

    /// Moves the cursor back to the previous node after being positioned
    /// inside an object.
    ///
    /// This function resets the error state of the reader, if any was set.
    extern fn json_reader_end_member(p_reader: *Reader) void;
    pub const endMember = json_reader_end_member;

    /// Retrieves the boolean value of the current position of the reader.
    ///
    /// See also: `json.Reader.getValue`
    extern fn json_reader_get_boolean_value(p_reader: *Reader) c_int;
    pub const getBooleanValue = json_reader_get_boolean_value;

    /// Retrieves the reader node at the current position.
    extern fn json_reader_get_current_node(p_reader: *Reader) ?*json.Node;
    pub const getCurrentNode = json_reader_get_current_node;

    /// Retrieves the floating point value of the current position of the reader.
    ///
    /// See also: `json.Reader.getValue`
    extern fn json_reader_get_double_value(p_reader: *Reader) f64;
    pub const getDoubleValue = json_reader_get_double_value;

    /// Retrieves the error currently set on the reader.
    extern fn json_reader_get_error(p_reader: *Reader) ?*const glib.Error;
    pub const getError = json_reader_get_error;

    /// Retrieves the integer value of the current position of the reader.
    ///
    /// See also: `json.Reader.getValue`
    extern fn json_reader_get_int_value(p_reader: *Reader) i64;
    pub const getIntValue = json_reader_get_int_value;

    /// Retrieves the name of the current member.
    ///
    /// In case of failure, the reader is set to an error state.
    extern fn json_reader_get_member_name(p_reader: *Reader) ?[*:0]const u8;
    pub const getMemberName = json_reader_get_member_name;

    /// Checks whether the value of the current position of the reader is `null`.
    ///
    /// See also: `json.Reader.getValue`
    extern fn json_reader_get_null_value(p_reader: *Reader) c_int;
    pub const getNullValue = json_reader_get_null_value;

    /// Retrieves the string value of the current position of the reader.
    ///
    /// See also: `json.Reader.getValue`
    extern fn json_reader_get_string_value(p_reader: *Reader) [*:0]const u8;
    pub const getStringValue = json_reader_get_string_value;

    /// Retrieves the value node at the current position of the reader.
    ///
    /// If the current position does not contain a scalar value, the reader
    /// is set to an error state.
    extern fn json_reader_get_value(p_reader: *Reader) ?*json.Node;
    pub const getValue = json_reader_get_value;

    /// Checks whether the reader is currently on an array.
    extern fn json_reader_is_array(p_reader: *Reader) c_int;
    pub const isArray = json_reader_is_array;

    /// Checks whether the reader is currently on an object.
    extern fn json_reader_is_object(p_reader: *Reader) c_int;
    pub const isObject = json_reader_is_object;

    /// Checks whether the reader is currently on a value.
    extern fn json_reader_is_value(p_reader: *Reader) c_int;
    pub const isValue = json_reader_is_value;

    /// Retrieves a list of member names from the current position, if the reader
    /// is positioned on an object.
    ///
    /// In case of failure, the reader is set to an error state.
    extern fn json_reader_list_members(p_reader: *Reader) [*][*:0]u8;
    pub const listMembers = json_reader_list_members;

    /// Advances the cursor of the reader to the element of the array or
    /// the member of the object at the given position.
    ///
    /// You can use `json.Reader.getValue` and its wrapper functions to
    /// retrieve the value of the element; for instance, the following code will
    /// read the first element of the array at the current cursor position:
    ///
    /// ```c
    /// json_reader_read_element (reader, 0);
    /// int_value = json_reader_get_int_value (reader);
    /// ```
    ///
    /// After reading the value, you should call `json.Reader.endElement`
    /// to reposition the cursor inside the reader, e.g.:
    ///
    /// ```c
    /// const char *str_value = NULL;
    ///
    /// json_reader_read_element (reader, 1);
    /// str_value = json_reader_get_string_value (reader);
    /// json_reader_end_element (reader);
    ///
    /// json_reader_read_element (reader, 2);
    /// str_value = json_reader_get_string_value (reader);
    /// json_reader_end_element (reader);
    /// ```
    ///
    /// If the reader is not currently on an array or an object, or if the index is
    /// bigger than the size of the array or the object, the reader will be
    /// put in an error state until `json.Reader.endElement` is called. This
    /// means that, if used conditionally, `json.Reader.endElement` must be
    /// called on all branches:
    ///
    /// ```c
    /// if (!json_reader_read_element (reader, 1))
    ///   {
    ///     g_propagate_error (error, json_reader_get_error (reader));
    ///     json_reader_end_element (reader);
    ///     return FALSE;
    ///   }
    /// else
    ///   {
    ///     const char *str_value = json_reader_get_string_value (reader);
    ///     json_reader_end_element (reader);
    ///
    ///     // use str_value
    ///
    ///     return TRUE;
    ///   }
    /// ```c
    extern fn json_reader_read_element(p_reader: *Reader, p_index_: c_uint) c_int;
    pub const readElement = json_reader_read_element;

    /// Advances the cursor of the reader to the `member_name` of the object at
    /// the current position.
    ///
    /// You can use `json.Reader.getValue` and its wrapper functions to
    /// retrieve the value of the member; for instance:
    ///
    /// ```c
    /// json_reader_read_member (reader, "width");
    /// width = json_reader_get_int_value (reader);
    /// ```
    ///
    /// After reading the value, ``json.Reader.endMember`` should be called to
    /// reposition the cursor inside the reader, e.g.:
    ///
    /// ```c
    /// json_reader_read_member (reader, "author");
    /// author = json_reader_get_string_value (reader);
    /// json_reader_end_member (reader);
    ///
    /// json_reader_read_member (reader, "title");
    /// title = json_reader_get_string_value (reader);
    /// json_reader_end_member (reader);
    /// ```
    ///
    /// If the reader is not currently on an object, or if the `member_name` is not
    /// defined in the object, the reader will be put in an error state until
    /// `json.Reader.endMember` is called. This means that if used
    /// conditionally, `json.Reader.endMember` must be called on all branches:
    ///
    /// ```c
    /// if (!json_reader_read_member (reader, "title"))
    ///   {
    ///     g_propagate_error (error, json_reader_get_error (reader));
    ///     json_reader_end_member (reader);
    ///     return FALSE;
    ///   }
    /// else
    ///   {
    ///     const char *str_value = json_reader_get_string_value (reader);
    ///     json_reader_end_member (reader);
    ///
    ///     // use str_value
    ///
    ///     return TRUE;
    ///   }
    /// ```
    extern fn json_reader_read_member(p_reader: *Reader, p_member_name: [*:0]const u8) c_int;
    pub const readMember = json_reader_read_member;

    /// Sets the root node of the JSON tree to be read by `reader`.
    ///
    /// The reader will take a copy of the node.
    extern fn json_reader_set_root(p_reader: *Reader, p_root: ?*json.Node) void;
    pub const setRoot = json_reader_set_root;

    extern fn json_reader_get_type() usize;
    pub const getGObjectType = json_reader_get_type;

    extern fn g_object_ref(p_self: *json.Reader) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *json.Reader) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Reader, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `JsonSerializable` is an interface for controlling the serialization
/// and deserialization of `GObject` classes.
///
/// Implementing this interface allows controlling how the class is going
/// to be serialized or deserialized by `json.constructGobject` and
/// `json.serializeGobject`, respectively.
pub const Serializable = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = json.SerializableIface;
    pub const virtual_methods = struct {
        /// Asks a `JsonSerializable` implementation to deserialize the
        /// property contained inside `property_node` and place its value
        /// into `value`.
        ///
        /// The `value` can be:
        ///
        /// - an empty `GValue` initialized by `G_VALUE_INIT`, which will be automatically
        ///   initialized with the expected type of the property by using the given
        ///   property description (since JSON-GLib 1.6)
        /// - a `GValue` initialized with the expected type of the property
        ///
        /// This function will not be called for properties that are marked as
        /// as `G_PARAM_CONSTRUCT_ONLY`.
        pub const deserialize_property = struct {
            pub fn call(p_class: anytype, p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_property_name: [*:0]const u8, p_value: *gobject.Value, p_pspec: *gobject.ParamSpec, p_property_node: *json.Node) c_int {
                return gobject.ext.as(Serializable.Iface, p_class).f_deserialize_property.?(gobject.ext.as(Serializable, p_serializable), p_property_name, p_value, p_pspec, p_property_node);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_property_name: [*:0]const u8, p_value: *gobject.Value, p_pspec: *gobject.ParamSpec, p_property_node: *json.Node) callconv(.c) c_int) void {
                gobject.ext.as(Serializable.Iface, p_class).f_deserialize_property = @ptrCast(p_implementation);
            }
        };

        /// Calls the `json.Serializable.virtual_methods.find_property` implementation on
        /// the `JsonSerializable` instance, which will return the property
        /// description for the given name.
        pub const find_property = struct {
            pub fn call(p_class: anytype, p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) ?*gobject.ParamSpec {
                return gobject.ext.as(Serializable.Iface, p_class).f_find_property.?(gobject.ext.as(Serializable, p_serializable), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) ?*gobject.ParamSpec) void {
                gobject.ext.as(Serializable.Iface, p_class).f_find_property = @ptrCast(p_implementation);
            }
        };

        /// Calls the `json.Serializable.virtual_methods.get_property` implementation
        /// on the `JsonSerializable` instance, which will get the value of
        /// the given property.
        pub const get_property = struct {
            pub fn call(p_class: anytype, p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_value: *gobject.Value) void {
                return gobject.ext.as(Serializable.Iface, p_class).f_get_property.?(gobject.ext.as(Serializable, p_serializable), p_pspec, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_value: *gobject.Value) callconv(.c) void) void {
                gobject.ext.as(Serializable.Iface, p_class).f_get_property = @ptrCast(p_implementation);
            }
        };

        /// virtual function for listing the installed property
        ///   definitions
        pub const list_properties = struct {
            pub fn call(p_class: anytype, p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_n_pspecs: *c_uint) **gobject.ParamSpec {
                return gobject.ext.as(Serializable.Iface, p_class).f_list_properties.?(gobject.ext.as(Serializable, p_serializable), p_n_pspecs);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_n_pspecs: *c_uint) callconv(.c) **gobject.ParamSpec) void {
                gobject.ext.as(Serializable.Iface, p_class).f_list_properties = @ptrCast(p_implementation);
            }
        };

        /// Asks a `JsonSerializable` implementation to serialize an object
        /// property into a JSON node.
        pub const serialize_property = struct {
            pub fn call(p_class: anytype, p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_property_name: [*:0]const u8, p_value: *const gobject.Value, p_pspec: *gobject.ParamSpec) ?*json.Node {
                return gobject.ext.as(Serializable.Iface, p_class).f_serialize_property.?(gobject.ext.as(Serializable, p_serializable), p_property_name, p_value, p_pspec);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_property_name: [*:0]const u8, p_value: *const gobject.Value, p_pspec: *gobject.ParamSpec) callconv(.c) ?*json.Node) void {
                gobject.ext.as(Serializable.Iface, p_class).f_serialize_property = @ptrCast(p_implementation);
            }
        };

        /// Calls the `json.Serializable.virtual_methods.set_property` implementation
        /// on the `JsonSerializable` instance, which will set the property
        /// with the given value.
        pub const set_property = struct {
            pub fn call(p_class: anytype, p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_value: *const gobject.Value) void {
                return gobject.ext.as(Serializable.Iface, p_class).f_set_property.?(gobject.ext.as(Serializable, p_serializable), p_pspec, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_serializable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_value: *const gobject.Value) callconv(.c) void) void {
                gobject.ext.as(Serializable.Iface, p_class).f_set_property = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Calls the default implementation of the `json.Serializable.virtual_methods.deserialize_property`
    /// virtual function.
    ///
    /// This function can be used inside a custom implementation of the
    /// ``deserialize_property`` virtual function in lieu of calling the
    /// default implementation through ``gobject.typeDefaultInterfacePeek``:
    ///
    /// ```c
    /// JsonSerializable *iface;
    /// gboolean res;
    ///
    /// iface = g_type_default_interface_peek (JSON_TYPE_SERIALIZABLE);
    /// res = iface->deserialize_property (serializable, property_name,
    ///                                    value,
    ///                                    pspec,
    ///                                    property_node);
    /// ```
    extern fn json_serializable_default_deserialize_property(p_serializable: *Serializable, p_property_name: [*:0]const u8, p_value: *gobject.Value, p_pspec: *gobject.ParamSpec, p_property_node: *json.Node) c_int;
    pub const defaultDeserializeProperty = json_serializable_default_deserialize_property;

    /// Calls the default implementation of the `json.Serializable.virtual_methods.serialize_property`
    /// virtual function.
    ///
    /// This function can be used inside a custom implementation of the
    /// ``serialize_property`` virtual function in lieu of calling the
    /// default implementation through ``gobject.typeDefaultInterfacePeek``:
    ///
    /// ```c
    /// JsonSerializable *iface;
    /// JsonNode *node;
    ///
    /// iface = g_type_default_interface_peek (JSON_TYPE_SERIALIZABLE);
    /// node = iface->serialize_property (serializable, property_name,
    ///                                   value,
    ///                                   pspec);
    /// ```
    ///
    /// This function will return `NULL` if the property could not be
    /// serialized.
    extern fn json_serializable_default_serialize_property(p_serializable: *Serializable, p_property_name: [*:0]const u8, p_value: *const gobject.Value, p_pspec: *gobject.ParamSpec) ?*json.Node;
    pub const defaultSerializeProperty = json_serializable_default_serialize_property;

    /// Asks a `JsonSerializable` implementation to deserialize the
    /// property contained inside `property_node` and place its value
    /// into `value`.
    ///
    /// The `value` can be:
    ///
    /// - an empty `GValue` initialized by `G_VALUE_INIT`, which will be automatically
    ///   initialized with the expected type of the property by using the given
    ///   property description (since JSON-GLib 1.6)
    /// - a `GValue` initialized with the expected type of the property
    ///
    /// This function will not be called for properties that are marked as
    /// as `G_PARAM_CONSTRUCT_ONLY`.
    extern fn json_serializable_deserialize_property(p_serializable: *Serializable, p_property_name: [*:0]const u8, p_value: *gobject.Value, p_pspec: *gobject.ParamSpec, p_property_node: *json.Node) c_int;
    pub const deserializeProperty = json_serializable_deserialize_property;

    /// Calls the `json.Serializable.virtual_methods.find_property` implementation on
    /// the `JsonSerializable` instance, which will return the property
    /// description for the given name.
    extern fn json_serializable_find_property(p_serializable: *Serializable, p_name: [*:0]const u8) ?*gobject.ParamSpec;
    pub const findProperty = json_serializable_find_property;

    /// Calls the `json.Serializable.virtual_methods.get_property` implementation
    /// on the `JsonSerializable` instance, which will get the value of
    /// the given property.
    extern fn json_serializable_get_property(p_serializable: *Serializable, p_pspec: *gobject.ParamSpec, p_value: *gobject.Value) void;
    pub const getProperty = json_serializable_get_property;

    /// Calls the `json.Serializable.virtual_methods.list_properties` implementation on
    /// the `JsonSerializable` instance, which will return the list of serializable
    /// properties.
    extern fn json_serializable_list_properties(p_serializable: *Serializable, p_n_pspecs: *c_uint) [*]*gobject.ParamSpec;
    pub const listProperties = json_serializable_list_properties;

    /// Asks a `JsonSerializable` implementation to serialize an object
    /// property into a JSON node.
    extern fn json_serializable_serialize_property(p_serializable: *Serializable, p_property_name: [*:0]const u8, p_value: *const gobject.Value, p_pspec: *gobject.ParamSpec) ?*json.Node;
    pub const serializeProperty = json_serializable_serialize_property;

    /// Calls the `json.Serializable.virtual_methods.set_property` implementation
    /// on the `JsonSerializable` instance, which will set the property
    /// with the given value.
    extern fn json_serializable_set_property(p_serializable: *Serializable, p_pspec: *gobject.ParamSpec, p_value: *const gobject.Value) void;
    pub const setProperty = json_serializable_set_property;

    extern fn json_serializable_get_type() usize;
    pub const getGObjectType = json_serializable_get_type;

    extern fn g_object_ref(p_self: *json.Serializable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *json.Serializable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Serializable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `JsonArray` is the representation of the array type inside JSON.
///
/// A `JsonArray` contains `json.Node` elements, which may contain
/// fundamental types, other arrays or objects.
///
/// Since arrays can be arbitrarily big, copying them can be expensive; for
/// this reason, they are reference counted. You can control the lifetime of
/// a `JsonArray` using `json.Array.ref` and `json.Array.unref`.
///
/// To append an element, use `json.Array.addElement`.
///
/// To extract an element at a given index, use `json.Array.getElement`.
///
/// To retrieve the entire array in list form, use `json.Array.getElements`.
///
/// To retrieve the length of the array, use `json.Array.getLength`.
pub const Array = opaque {
    /// Creates a new array.
    extern fn json_array_new() *json.Array;
    pub const new = json_array_new;

    /// Creates a new array with `n_elements` slots already allocated.
    extern fn json_array_sized_new(p_n_elements: c_uint) *json.Array;
    pub const sizedNew = json_array_sized_new;

    /// Conveniently adds an array element into an array.
    ///
    /// If `value` is `NULL`, a `null` element will be added instead.
    ///
    /// See also: `json.Array.addElement`, `json.Node.takeArray`
    extern fn json_array_add_array_element(p_array: *Array, p_value: ?*json.Array) void;
    pub const addArrayElement = json_array_add_array_element;

    /// Conveniently adds the given boolean value into an array.
    ///
    /// See also: `json.Array.addElement`, `json.Node.setBoolean`
    extern fn json_array_add_boolean_element(p_array: *Array, p_value: c_int) void;
    pub const addBooleanElement = json_array_add_boolean_element;

    /// Conveniently adds the given floating point value into an array.
    ///
    /// See also: `json.Array.addElement`, `json.Node.setDouble`
    extern fn json_array_add_double_element(p_array: *Array, p_value: f64) void;
    pub const addDoubleElement = json_array_add_double_element;

    /// Appends the given `node` inside an array.
    extern fn json_array_add_element(p_array: *Array, p_node: *json.Node) void;
    pub const addElement = json_array_add_element;

    /// Conveniently adds the given integer value into an array.
    ///
    /// See also: `json.Array.addElement`, `json.Node.setInt`
    extern fn json_array_add_int_element(p_array: *Array, p_value: i64) void;
    pub const addIntElement = json_array_add_int_element;

    /// Conveniently adds a `null` element into an array
    ///
    /// See also: `json.Array.addElement`, `JSON_NODE_NULL`
    extern fn json_array_add_null_element(p_array: *Array) void;
    pub const addNullElement = json_array_add_null_element;

    /// Conveniently adds an object into an array.
    ///
    /// If `value` is `NULL`, a `null` element will be added instead.
    ///
    /// See also: `json.Array.addElement`, `json.Node.takeObject`
    extern fn json_array_add_object_element(p_array: *Array, p_value: ?*json.Object) void;
    pub const addObjectElement = json_array_add_object_element;

    /// Conveniently adds the given string value into an array.
    ///
    /// See also: `json.Array.addElement`, `json.Node.setString`
    extern fn json_array_add_string_element(p_array: *Array, p_value: [*:0]const u8) void;
    pub const addStringElement = json_array_add_string_element;

    /// Retrieves a copy of the element at the given position in the array.
    extern fn json_array_dup_element(p_array: *Array, p_index_: c_uint) *json.Node;
    pub const dupElement = json_array_dup_element;

    /// Check whether two arrays are equal.
    ///
    /// Equality is defined as:
    ///
    ///  - the array have the same number of elements
    ///  - the values of elements in corresponding positions are equal
    extern fn json_array_equal(p_a: *const Array, p_b: *const json.Array) c_int;
    pub const equal = json_array_equal;

    /// Iterates over all elements of an array, and calls a function on
    /// each one of them.
    ///
    /// It is safe to change the value of an element of the array while
    /// iterating over it, but it is not safe to add or remove elements
    /// from the array.
    extern fn json_array_foreach_element(p_array: *Array, p_func: json.ArrayForeach, p_data: ?*anyopaque) void;
    pub const foreachElement = json_array_foreach_element;

    /// Conveniently retrieves the array at the given position inside an array.
    ///
    /// See also: `json.Array.getElement`, `json.Node.getArray`
    extern fn json_array_get_array_element(p_array: *Array, p_index_: c_uint) *json.Array;
    pub const getArrayElement = json_array_get_array_element;

    /// Conveniently retrieves the boolean value of the element at the given
    /// position inside an array.
    ///
    /// See also: `json.Array.getElement`, `json.Node.getBoolean`
    extern fn json_array_get_boolean_element(p_array: *Array, p_index_: c_uint) c_int;
    pub const getBooleanElement = json_array_get_boolean_element;

    /// Conveniently retrieves the floating point value of the element at
    /// the given position inside an array.
    ///
    /// See also: `json.Array.getElement`, `json.Node.getDouble`
    extern fn json_array_get_double_element(p_array: *Array, p_index_: c_uint) f64;
    pub const getDoubleElement = json_array_get_double_element;

    /// Retrieves the element at the given position in the array.
    extern fn json_array_get_element(p_array: *Array, p_index_: c_uint) *json.Node;
    pub const getElement = json_array_get_element;

    /// Retrieves all the elements of an array as a list of nodes.
    extern fn json_array_get_elements(p_array: *Array) ?*glib.List;
    pub const getElements = json_array_get_elements;

    /// Conveniently retrieves the integer value of the element at the given
    /// position inside an array.
    ///
    /// See also: `json.Array.getElement`, `json.Node.getInt`
    extern fn json_array_get_int_element(p_array: *Array, p_index_: c_uint) i64;
    pub const getIntElement = json_array_get_int_element;

    /// Retrieves the length of the given array
    extern fn json_array_get_length(p_array: *Array) c_uint;
    pub const getLength = json_array_get_length;

    /// Conveniently checks whether the element at the given position inside the
    /// array contains a `null` value.
    ///
    /// See also: `json.Array.getElement`, `json.Node.isNull`
    extern fn json_array_get_null_element(p_array: *Array, p_index_: c_uint) c_int;
    pub const getNullElement = json_array_get_null_element;

    /// Conveniently retrieves the object at the given position inside an array.
    ///
    /// See also: `json.Array.getElement`, `json.Node.getObject`
    extern fn json_array_get_object_element(p_array: *Array, p_index_: c_uint) *json.Object;
    pub const getObjectElement = json_array_get_object_element;

    /// Conveniently retrieves the string value of the element at the given
    /// position inside an array.
    ///
    /// See also: `json.Array.getElement`, `json.Node.getString`
    extern fn json_array_get_string_element(p_array: *Array, p_index_: c_uint) [*:0]const u8;
    pub const getStringElement = json_array_get_string_element;

    /// Calculates a hash value for the given `key`.
    ///
    /// The hash is calculated over the array and all its elements, recursively.
    ///
    /// If the array is immutable, this is a fast operation; otherwise, it scales
    /// proportionally with the length of the array.
    extern fn json_array_hash(p_key: *const Array) c_uint;
    pub const hash = json_array_hash;

    /// Check whether the given `array` has been marked as immutable by calling
    /// `json.Array.seal` on it.
    extern fn json_array_is_immutable(p_array: *Array) c_int;
    pub const isImmutable = json_array_is_immutable;

    /// Acquires a reference on the given array.
    extern fn json_array_ref(p_array: *Array) *json.Array;
    pub const ref = json_array_ref;

    /// Removes the element at the given position inside an array.
    ///
    /// This function will release the reference held on the element.
    extern fn json_array_remove_element(p_array: *Array, p_index_: c_uint) void;
    pub const removeElement = json_array_remove_element;

    /// Seals the given array, making it immutable to further changes.
    ///
    /// This function will recursively seal all elements in the array too.
    ///
    /// If the `array` is already immutable, this is a no-op.
    extern fn json_array_seal(p_array: *Array) void;
    pub const seal = json_array_seal;

    /// Releases a reference on the given array.
    ///
    /// If the reference count reaches zero, the array is destroyed and all
    /// its allocated resources are freed.
    extern fn json_array_unref(p_array: *Array) void;
    pub const unref = json_array_unref;

    extern fn json_array_get_type() usize;
    pub const getGObjectType = json_array_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BuilderClass = extern struct {
    pub const Instance = json.Builder;

    f_parent_class: gobject.ObjectClass,
    f__json_reserved1: ?*const fn () callconv(.c) void,
    f__json_reserved2: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *BuilderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BuilderPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GeneratorClass = extern struct {
    pub const Instance = json.Generator;

    f_parent_class: gobject.ObjectClass,
    f__json_reserved1: ?*const fn () callconv(.c) void,
    f__json_reserved2: ?*const fn () callconv(.c) void,
    f__json_reserved3: ?*const fn () callconv(.c) void,
    f__json_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *GeneratorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GeneratorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A generic container of JSON data types.
///
/// `JsonNode` can contain fundamental types (integers, booleans, floating point
/// numbers, strings) and complex types (arrays and objects).
///
/// When parsing a JSON data stream you extract the root node and walk
/// the node tree by retrieving the type of data contained inside the
/// node with the `JSON_NODE_TYPE` macro. If the node contains a fundamental
/// type you can retrieve a copy of the `GValue` holding it with the
/// `json.Node.getValue` function, and then use the `GValue` API to extract
/// the data; if the node contains a complex type you can retrieve the
/// `json.Object` or the `json.Array` using `json.Node.getObject`
/// or `json.Node.getArray` respectively, and then retrieve the nodes
/// they contain.
///
/// A `JsonNode` may be marked as immutable using `json.Node.seal`. This
/// marks the node and all its descendents as read-only, and means that
/// subsequent calls to setter functions (such as `json.Node.setArray`)
/// on them will abort as a programmer error. By marking a node tree as
/// immutable, it may be referenced in multiple places and its hash value cached
/// for fast lookups, without the possibility of a value deep within the tree
/// changing and affecting hash values. Immutable nodes may be passed to
/// functions which retain a reference to them without needing to take a copy.
///
/// A `JsonNode` supports two types of memory management: `malloc`/`free`
/// semantics, and reference counting semantics. The two may be mixed to a
/// limited extent: nodes may be allocated (which gives them a reference count
/// of 1), referenced one or more times, unreferenced exactly that number of
/// times (using `json.Node.unref`), then either unreferenced exactly
/// once more or freed (using `json.Node.free`) to destroy them.
/// The `json.Node.free` function must not be used when a node might
/// have a reference count not equal to 1. To this end, JSON-GLib uses
/// `json.Node.copy` and `json.Node.unref` internally.
pub const Node = opaque {
    /// Allocates a new, uninitialized node.
    ///
    /// Use `json.Node.init` and its variants to initialize the returned value.
    extern fn json_node_alloc() *json.Node;
    pub const alloc = json_node_alloc;

    /// Creates a new node holding the given `type`.
    ///
    /// This is a convenience function for `json.Node.alloc` and
    /// `json.Node.init`, and it's the equivalent of:
    ///
    /// ```c
    ///    json_node_init (json_node_alloc (), type);
    /// ```
    extern fn json_node_new(p_type: json.NodeType) *json.Node;
    pub const new = json_node_new;

    /// Copies `node`.
    ///
    /// If the node contains complex data types, their reference
    /// counts are increased, regardless of whether the node is mutable or
    /// immutable.
    ///
    /// The copy will be immutable if, and only if, `node` is immutable. However,
    /// there should be no need to copy an immutable node.
    extern fn json_node_copy(p_node: *Node) *json.Node;
    pub const copy = json_node_copy;

    /// Retrieves the JSON array inside `node`.
    ///
    /// The reference count of the returned array is increased.
    ///
    /// It is a programmer error to call this on a node which doesn’t hold an
    /// array value. Use `JSON_NODE_HOLDS_ARRAY` first.
    extern fn json_node_dup_array(p_node: *Node) ?*json.Array;
    pub const dupArray = json_node_dup_array;

    /// Retrieves the object inside `node`.
    ///
    /// The reference count of the returned object is increased.
    ///
    /// It is a programmer error to call this on a node which doesn’t hold an
    /// object value. Use `JSON_NODE_HOLDS_OBJECT` first.
    extern fn json_node_dup_object(p_node: *Node) ?*json.Object;
    pub const dupObject = json_node_dup_object;

    /// Gets a copy of the string value stored inside a node.
    ///
    /// If the node does not hold a string value, `NULL` is returned.
    extern fn json_node_dup_string(p_node: *Node) ?[*:0]u8;
    pub const dupString = json_node_dup_string;

    /// Check whether `a` and `b` are equal node, meaning they have the same
    /// type and same values (checked recursively).
    ///
    /// Note that integer values are compared numerically, ignoring type, so a
    /// double value 4.0 is equal to the integer value 4.
    extern fn json_node_equal(p_a: *const Node, p_b: *const json.Node) c_int;
    pub const equal = json_node_equal;

    /// Frees the resources allocated by the node.
    extern fn json_node_free(p_node: *Node) void;
    pub const free = json_node_free;

    /// Retrieves the JSON array stored inside a node.
    ///
    /// It is a programmer error to call this on a node which doesn’t hold an
    /// array value. Use `JSON_NODE_HOLDS_ARRAY` first.
    extern fn json_node_get_array(p_node: *Node) ?*json.Array;
    pub const getArray = json_node_get_array;

    /// Gets the boolean value stored inside a node.
    ///
    /// If the node holds an integer or double value which is zero, `FALSE` is
    /// returned; otherwise `TRUE` is returned.
    ///
    /// If the node holds a `JSON_NODE_NULL` value or a value of another
    /// non-boolean type, `FALSE` is returned.
    extern fn json_node_get_boolean(p_node: *Node) c_int;
    pub const getBoolean = json_node_get_boolean;

    /// Gets the double value stored inside a node.
    ///
    /// If the node holds an integer value, it is returned as a double.
    ///
    /// If the node holds a `FALSE` boolean value, `0.0` is returned; otherwise
    /// a non-zero double is returned.
    ///
    /// If the node holds a `JSON_NODE_NULL` value or a value of another
    /// non-double type, `0.0` is returned.
    extern fn json_node_get_double(p_node: *Node) f64;
    pub const getDouble = json_node_get_double;

    /// Gets the integer value stored inside a node.
    ///
    /// If the node holds a double value, its integer component is returned.
    ///
    /// If the node holds a `FALSE` boolean value, `0` is returned; otherwise,
    /// a non-zero integer is returned.
    ///
    /// If the node holds a `JSON_NODE_NULL` value or a value of another
    /// non-integer type, `0` is returned.
    extern fn json_node_get_int(p_node: *Node) i64;
    pub const getInt = json_node_get_int;

    /// Retrieves the type of a `node`.
    extern fn json_node_get_node_type(p_node: *Node) json.NodeType;
    pub const getNodeType = json_node_get_node_type;

    /// Retrieves the object stored inside a node.
    ///
    /// It is a programmer error to call this on a node which doesn’t hold an
    /// object value. Use `JSON_NODE_HOLDS_OBJECT` first.
    extern fn json_node_get_object(p_node: *Node) ?*json.Object;
    pub const getObject = json_node_get_object;

    /// Retrieves the parent node of the given `node`.
    extern fn json_node_get_parent(p_node: *Node) ?*json.Node;
    pub const getParent = json_node_get_parent;

    /// Gets the string value stored inside a node.
    ///
    /// If the node does not hold a string value, `NULL` is returned.
    extern fn json_node_get_string(p_node: *Node) ?[*:0]const u8;
    pub const getString = json_node_get_string;

    /// Retrieves a value from a node and copies into `value`.
    ///
    /// When done using it, call ``gobject.Value.unset`` on the `GValue` to free the
    /// associated resources.
    ///
    /// It is a programmer error to call this on a node which doesn’t hold a scalar
    /// value. Use `JSON_NODE_HOLDS_VALUE` first.
    extern fn json_node_get_value(p_node: *Node, p_value: *gobject.Value) void;
    pub const getValue = json_node_get_value;

    /// Returns the `GType` of the payload of the node.
    ///
    /// For `JSON_NODE_NULL` nodes, the returned type is `G_TYPE_INVALID`.
    extern fn json_node_get_value_type(p_node: *Node) usize;
    pub const getValueType = json_node_get_value_type;

    /// Calculate a hash value for the given `key`.
    ///
    /// The hash is calculated over the node and its value, recursively. If the node
    /// is immutable, this is a fast operation; otherwise, it scales proportionally
    /// with the size of the node’s value (for example, with the number of members
    /// in the JSON object if this node contains an object).
    extern fn json_node_hash(p_key: *const Node) c_uint;
    pub const hash = json_node_hash;

    /// Initializes a `node` to a specific `type`.
    ///
    /// If the node has already been initialized once, it will be reset to
    /// the given type, and any data contained will be cleared.
    extern fn json_node_init(p_node: *Node, p_type: json.NodeType) *json.Node;
    pub const init = json_node_init;

    /// Initializes `node` to `JSON_NODE_ARRAY` and sets `array` into it.
    ///
    /// This function will take a reference on `array`.
    ///
    /// If the node has already been initialized once, it will be reset to
    /// the given type, and any data contained will be cleared.
    extern fn json_node_init_array(p_node: *Node, p_array: ?*json.Array) *json.Node;
    pub const initArray = json_node_init_array;

    /// Initializes `node` to `JSON_NODE_VALUE` and sets `value` into it.
    ///
    /// If the node has already been initialized once, it will be reset to
    /// the given type, and any data contained will be cleared.
    extern fn json_node_init_boolean(p_node: *Node, p_value: c_int) *json.Node;
    pub const initBoolean = json_node_init_boolean;

    /// Initializes `node` to `JSON_NODE_VALUE` and sets `value` into it.
    ///
    /// If the node has already been initialized once, it will be reset to
    /// the given type, and any data contained will be cleared.
    extern fn json_node_init_double(p_node: *Node, p_value: f64) *json.Node;
    pub const initDouble = json_node_init_double;

    /// Initializes `node` to `JSON_NODE_VALUE` and sets `value` into it.
    ///
    /// If the node has already been initialized once, it will be reset to
    /// the given type, and any data contained will be cleared.
    extern fn json_node_init_int(p_node: *Node, p_value: i64) *json.Node;
    pub const initInt = json_node_init_int;

    /// Initializes `node` to `JSON_NODE_NULL`.
    ///
    /// If the node has already been initialized once, it will be reset to
    /// the given type, and any data contained will be cleared.
    extern fn json_node_init_null(p_node: *Node) *json.Node;
    pub const initNull = json_node_init_null;

    /// Initializes `node` to `JSON_NODE_OBJECT` and sets `object` into it.
    ///
    /// This function will take a reference on `object`.
    ///
    /// If the node has already been initialized once, it will be reset to
    /// the given type, and any data contained will be cleared.
    extern fn json_node_init_object(p_node: *Node, p_object: ?*json.Object) *json.Node;
    pub const initObject = json_node_init_object;

    /// Initializes `node` to `JSON_NODE_VALUE` and sets `value` into it.
    ///
    /// If the node has already been initialized once, it will be reset to
    /// the given type, and any data contained will be cleared.
    extern fn json_node_init_string(p_node: *Node, p_value: ?[*:0]const u8) *json.Node;
    pub const initString = json_node_init_string;

    /// Check whether the given `node` has been marked as immutable by calling
    /// `json.Node.seal` on it.
    extern fn json_node_is_immutable(p_node: *Node) c_int;
    pub const isImmutable = json_node_is_immutable;

    /// Checks whether `node` is a `JSON_NODE_NULL`.
    ///
    /// A `JSON_NODE_NULL` node is not the same as a `NULL` node; a `JSON_NODE_NULL`
    /// represents a literal `null` value in the JSON tree.
    extern fn json_node_is_null(p_node: *Node) c_int;
    pub const isNull = json_node_is_null;

    /// Increments the reference count of `node`.
    extern fn json_node_ref(p_node: *Node) *json.Node;
    pub const ref = json_node_ref;

    /// Seals the given node, making it immutable to further changes.
    ///
    /// In order to be sealed, the `node` must have a type and value set. The value
    /// will be recursively sealed — if the node holds an object, that JSON object
    /// will be sealed, etc.
    ///
    /// If the `node` is already immutable, this is a no-op.
    extern fn json_node_seal(p_node: *Node) void;
    pub const seal = json_node_seal;

    /// Sets `array` inside `node`.
    ///
    /// The reference count of `array` is increased.
    ///
    /// It is a programmer error to call this on a node which doesn’t hold an
    /// array value. Use `JSON_NODE_HOLDS_ARRAY` first.
    extern fn json_node_set_array(p_node: *Node, p_array: *json.Array) void;
    pub const setArray = json_node_set_array;

    /// Sets `value` as the boolean content of the `node`, replacing any existing
    /// content.
    ///
    /// It is an error to call this on an immutable node, or on a node which is not
    /// a value node.
    extern fn json_node_set_boolean(p_node: *Node, p_value: c_int) void;
    pub const setBoolean = json_node_set_boolean;

    /// Sets `value` as the double content of the `node`, replacing any existing
    /// content.
    ///
    /// It is an error to call this on an immutable node, or on a node which is not
    /// a value node.
    extern fn json_node_set_double(p_node: *Node, p_value: f64) void;
    pub const setDouble = json_node_set_double;

    /// Sets `value` as the integer content of the `node`, replacing any existing
    /// content.
    ///
    /// It is an error to call this on an immutable node, or on a node which is not
    /// a value node.
    extern fn json_node_set_int(p_node: *Node, p_value: i64) void;
    pub const setInt = json_node_set_int;

    /// Sets `objects` inside `node`.
    ///
    /// The reference count of `object` is increased.
    ///
    /// If `object` is `NULL`, the node’s existing object is cleared.
    ///
    /// It is an error to call this on an immutable node, or on a node which is not
    /// an object node.
    extern fn json_node_set_object(p_node: *Node, p_object: ?*json.Object) void;
    pub const setObject = json_node_set_object;

    /// Sets the parent node for the given `node`.
    ///
    /// It is an error to call this with an immutable `parent`.
    ///
    /// The `node` may be immutable.
    extern fn json_node_set_parent(p_node: *Node, p_parent: ?*json.Node) void;
    pub const setParent = json_node_set_parent;

    /// Sets `value` as the string content of the `node`, replacing any existing
    /// content.
    ///
    /// It is an error to call this on an immutable node, or on a node which is not
    /// a value node.
    extern fn json_node_set_string(p_node: *Node, p_value: [*:0]const u8) void;
    pub const setString = json_node_set_string;

    /// Sets a scalar value inside the given node.
    ///
    /// The contents of the given `GValue` are copied into the `JsonNode`.
    ///
    /// The following `GValue` types have a direct mapping to JSON types:
    ///
    ///  - `G_TYPE_INT64`
    ///  - `G_TYPE_DOUBLE`
    ///  - `G_TYPE_BOOLEAN`
    ///  - `G_TYPE_STRING`
    ///
    /// JSON-GLib will also automatically promote the following `GValue` types:
    ///
    ///  - `G_TYPE_INT` to `G_TYPE_INT64`
    ///  - `G_TYPE_FLOAT` to `G_TYPE_DOUBLE`
    ///
    /// It is an error to call this on an immutable node, or on a node which is not
    /// a value node.
    extern fn json_node_set_value(p_node: *Node, p_value: *const gobject.Value) void;
    pub const setValue = json_node_set_value;

    /// Sets `array` inside `node`.
    ///
    /// The reference count of `array` is not increased.
    ///
    /// It is a programmer error to call this on a node which doesn’t hold an
    /// array value. Use `JSON_NODE_HOLDS_ARRAY` first.
    extern fn json_node_take_array(p_node: *Node, p_array: *json.Array) void;
    pub const takeArray = json_node_take_array;

    /// Sets `object` inside `node`.
    ///
    /// The reference count of `object` is not increased.
    ///
    /// It is an error to call this on an immutable node, or on a node which is not
    /// an object node.
    extern fn json_node_take_object(p_node: *Node, p_object: *json.Object) void;
    pub const takeObject = json_node_take_object;

    /// Retrieves the user readable name of the data type contained by `node`.
    ///
    /// **Note**: The name is only meant for debugging purposes, and there is no
    /// guarantee the name will stay the same across different versions.
    extern fn json_node_type_name(p_node: *Node) [*:0]const u8;
    pub const typeName = json_node_type_name;

    /// Decrements the reference count of `node`.
    ///
    /// If the reference count reaches zero, the node is freed.
    extern fn json_node_unref(p_node: *Node) void;
    pub const unref = json_node_unref;

    extern fn json_node_get_type() usize;
    pub const getGObjectType = json_node_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `JsonObject` is the representation of the object type inside JSON.
///
/// A `JsonObject` contains `json.Node` "members", which may contain
/// fundamental types, arrays or other objects; each member of an object is
/// accessed using a unique string, or "name".
///
/// Since objects can be arbitrarily big, copying them can be expensive; for
/// this reason they are reference counted. You can control the lifetime of
/// a `JsonObject` using `json.Object.ref` and `json.Object.unref`.
///
/// To add or overwrite a member with a given name, use `json.Object.setMember`.
///
/// To extract a member with a given name, use `json.Object.getMember`.
///
/// To retrieve the list of members, use `json.Object.getMembers`.
///
/// To retrieve the size of the object (that is, the number of members it has),
/// use `json.Object.getSize`.
pub const Object = opaque {
    /// Creates a new object.
    extern fn json_object_new() *json.Object;
    pub const new = json_object_new;

    /// Adds a new member for the given name and value into an object.
    ///
    /// This function will return if the object already contains a member
    /// with the same name.
    extern fn json_object_add_member(p_object: *Object, p_member_name: [*:0]const u8, p_node: *json.Node) void;
    pub const addMember = json_object_add_member;

    /// Retrieves a copy of the value of the given member inside an object.
    extern fn json_object_dup_member(p_object: *Object, p_member_name: [*:0]const u8) ?*json.Node;
    pub const dupMember = json_object_dup_member;

    /// Check whether `a` and `b` are equal objects, meaning they have the same
    /// set of members, and the values of corresponding members are equal.
    extern fn json_object_equal(p_a: *const Object, p_b: *const json.Object) c_int;
    pub const equal = json_object_equal;

    /// Iterates over all members of `object` and calls `func` on
    /// each one of them.
    ///
    /// It is safe to change the value of a member of the oobject
    /// from within the iterator function, but it is not safe to add or
    /// remove members from the object.
    ///
    /// The order in which the object members are iterated is the
    /// insertion order.
    extern fn json_object_foreach_member(p_object: *Object, p_func: json.ObjectForeach, p_data: ?*anyopaque) void;
    pub const foreachMember = json_object_foreach_member;

    /// Convenience function that retrieves the array
    /// stored in `member_name` of `object`. It is an error to specify a
    /// `member_name` which does not exist or which holds a non-`null`, non-array
    /// value.
    ///
    /// If `member_name` contains `null`, then this function will return `NULL`.
    ///
    /// See also: `json.Object.getMember`, `json.Object.hasMember`
    extern fn json_object_get_array_member(p_object: *Object, p_member_name: [*:0]const u8) ?*json.Array;
    pub const getArrayMember = json_object_get_array_member;

    /// Convenience function that retrieves the boolean value
    /// stored in `member_name` of `object`. It is an error to specify a
    /// `member_name` which does not exist or which holds a non-scalar,
    /// non-`null` value.
    ///
    /// See also: `json.Object.getBooleanMemberWithDefault`,
    ///   `json.Object.getMember`, `json.Object.hasMember`
    extern fn json_object_get_boolean_member(p_object: *Object, p_member_name: [*:0]const u8) c_int;
    pub const getBooleanMember = json_object_get_boolean_member;

    /// Convenience function that retrieves the boolean value
    /// stored in `member_name` of `object`.
    ///
    /// If `member_name` does not exist, does not contain a scalar value,
    /// or contains `null`, then `default_value` is returned instead. If
    /// `member_name` contains a non-boolean, non-`null` scalar value, then
    /// whatever `json.Node.getBoolean` would return is returned.
    extern fn json_object_get_boolean_member_with_default(p_object: *Object, p_member_name: [*:0]const u8, p_default_value: c_int) c_int;
    pub const getBooleanMemberWithDefault = json_object_get_boolean_member_with_default;

    /// Convenience function that retrieves the floating point value
    /// stored in `member_name` of `object`. It is an error to specify a
    /// `member_name` which does not exist or which holds a non-scalar,
    /// non-`null` value.
    ///
    /// See also: `json.Object.getDoubleMemberWithDefault`,
    ///   `json.Object.getMember`, `json.Object.hasMember`
    extern fn json_object_get_double_member(p_object: *Object, p_member_name: [*:0]const u8) f64;
    pub const getDoubleMember = json_object_get_double_member;

    /// Convenience function that retrieves the floating point value
    /// stored in `member_name` of `object`.
    ///
    /// If `member_name` does not exist, does not contain a scalar value,
    /// or contains `null`, then `default_value` is returned instead. If
    /// `member_name` contains a non-double, non-`null` scalar value, then
    /// whatever `json.Node.getDouble` would return is returned.
    extern fn json_object_get_double_member_with_default(p_object: *Object, p_member_name: [*:0]const u8, p_default_value: f64) f64;
    pub const getDoubleMemberWithDefault = json_object_get_double_member_with_default;

    /// Convenience function that retrieves the integer value
    /// stored in `member_name` of `object`. It is an error to specify a
    /// `member_name` which does not exist or which holds a non-scalar,
    /// non-`null` value.
    ///
    /// See also: `json.Object.getIntMemberWithDefault`,
    ///   `json.Object.getMember`, `json.Object.hasMember`
    extern fn json_object_get_int_member(p_object: *Object, p_member_name: [*:0]const u8) i64;
    pub const getIntMember = json_object_get_int_member;

    /// Convenience function that retrieves the integer value
    /// stored in `member_name` of `object`.
    ///
    /// If `member_name` does not exist, does not contain a scalar value,
    /// or contains `null`, then `default_value` is returned instead. If
    /// `member_name` contains a non-integer, non-`null` scalar value, then whatever
    /// `json.Node.getInt` would return is returned.
    extern fn json_object_get_int_member_with_default(p_object: *Object, p_member_name: [*:0]const u8, p_default_value: i64) i64;
    pub const getIntMemberWithDefault = json_object_get_int_member_with_default;

    /// Retrieves the value of the given member inside an object.
    extern fn json_object_get_member(p_object: *Object, p_member_name: [*:0]const u8) ?*json.Node;
    pub const getMember = json_object_get_member;

    /// Retrieves all the names of the members of an object.
    ///
    /// You can obtain the value for each member by iterating the returned list
    /// and calling `json.Object.getMember`.
    extern fn json_object_get_members(p_object: *Object) ?*glib.List;
    pub const getMembers = json_object_get_members;

    /// Convenience function that checks whether the value
    /// stored in `member_name` of `object` is null. It is an error to
    /// specify a `member_name` which does not exist.
    ///
    /// See also: `json.Object.getMember`, `json.Object.hasMember`
    extern fn json_object_get_null_member(p_object: *Object, p_member_name: [*:0]const u8) c_int;
    pub const getNullMember = json_object_get_null_member;

    /// Convenience function that retrieves the object
    /// stored in `member_name` of `object`. It is an error to specify a `member_name`
    /// which does not exist or which holds a non-`null`, non-object value.
    ///
    /// If `member_name` contains `null`, then this function will return `NULL`.
    ///
    /// See also: `json.Object.getMember`, `json.Object.hasMember`
    extern fn json_object_get_object_member(p_object: *Object, p_member_name: [*:0]const u8) ?*json.Object;
    pub const getObjectMember = json_object_get_object_member;

    /// Retrieves the number of members of a JSON object.
    extern fn json_object_get_size(p_object: *Object) c_uint;
    pub const getSize = json_object_get_size;

    /// Convenience function that retrieves the string value
    /// stored in `member_name` of `object`. It is an error to specify a
    /// `member_name` that does not exist or which holds a non-scalar,
    /// non-`null` value.
    ///
    /// See also: `json.Object.getStringMemberWithDefault`,
    ///   `json.Object.getMember`, `json.Object.hasMember`
    extern fn json_object_get_string_member(p_object: *Object, p_member_name: [*:0]const u8) [*:0]const u8;
    pub const getStringMember = json_object_get_string_member;

    /// Convenience function that retrieves the string value
    /// stored in `member_name` of `object`.
    ///
    /// If `member_name` does not exist, does not contain a scalar value,
    /// or contains `null`, then `default_value` is returned instead. If
    /// `member_name` contains a non-string, non-`null` scalar value, then
    /// `NULL` is returned.
    extern fn json_object_get_string_member_with_default(p_object: *Object, p_member_name: [*:0]const u8, p_default_value: [*:0]const u8) [*:0]const u8;
    pub const getStringMemberWithDefault = json_object_get_string_member_with_default;

    /// Retrieves all the values of the members of an object.
    extern fn json_object_get_values(p_object: *Object) ?*glib.List;
    pub const getValues = json_object_get_values;

    /// Checks whether `object` has a member named `member_name`.
    extern fn json_object_has_member(p_object: *Object, p_member_name: [*:0]const u8) c_int;
    pub const hasMember = json_object_has_member;

    /// Calculate a hash value for the given `key` (a JSON object).
    ///
    /// The hash is calculated over the object and all its members, recursively. If
    /// the object is immutable, this is a fast operation; otherwise, it scales
    /// proportionally with the number of members in the object.
    extern fn json_object_hash(p_key: *const Object) c_uint;
    pub const hash = json_object_hash;

    /// Checks whether the given object has been marked as immutable by calling
    /// `json.Object.seal` on it.
    extern fn json_object_is_immutable(p_object: *Object) c_int;
    pub const isImmutable = json_object_is_immutable;

    /// Acquires a reference on the given object.
    extern fn json_object_ref(p_object: *Object) *json.Object;
    pub const ref = json_object_ref;

    /// Removes `member_name` from `object`, freeing its allocated resources.
    extern fn json_object_remove_member(p_object: *Object, p_member_name: [*:0]const u8) void;
    pub const removeMember = json_object_remove_member;

    /// Seals the object, making it immutable to further changes.
    ///
    /// This function will recursively seal all members of the object too.
    ///
    /// If the object is already immutable, this is a no-op.
    extern fn json_object_seal(p_object: *Object) void;
    pub const seal = json_object_seal;

    /// Convenience function for setting an object member with an array value.
    ///
    /// See also: `json.Object.setMember`, `json.Node.takeArray`
    extern fn json_object_set_array_member(p_object: *Object, p_member_name: [*:0]const u8, p_value: *json.Array) void;
    pub const setArrayMember = json_object_set_array_member;

    /// Convenience function for setting an object member with a boolean value.
    ///
    /// See also: `json.Object.setMember`, `json.Node.initBoolean`
    extern fn json_object_set_boolean_member(p_object: *Object, p_member_name: [*:0]const u8, p_value: c_int) void;
    pub const setBooleanMember = json_object_set_boolean_member;

    /// Convenience function for setting an object member with a floating point value.
    ///
    /// See also: `json.Object.setMember`, `json.Node.initDouble`
    extern fn json_object_set_double_member(p_object: *Object, p_member_name: [*:0]const u8, p_value: f64) void;
    pub const setDoubleMember = json_object_set_double_member;

    /// Convenience function for setting an object member with an integer value.
    ///
    /// See also: `json.Object.setMember`, `json.Node.initInt`
    extern fn json_object_set_int_member(p_object: *Object, p_member_name: [*:0]const u8, p_value: i64) void;
    pub const setIntMember = json_object_set_int_member;

    /// Sets the value of a member inside an object.
    ///
    /// If the object does not have a member with the given name, a new member
    /// is created.
    ///
    /// If the object already has a member with the given name, the current
    /// value is overwritten with the new.
    extern fn json_object_set_member(p_object: *Object, p_member_name: [*:0]const u8, p_node: *json.Node) void;
    pub const setMember = json_object_set_member;

    /// Convenience function for setting an object member with a `null` value.
    ///
    /// See also: `json.Object.setMember`, `json.Node.initNull`
    extern fn json_object_set_null_member(p_object: *Object, p_member_name: [*:0]const u8) void;
    pub const setNullMember = json_object_set_null_member;

    /// Convenience function for setting an object member with an object value.
    ///
    /// See also: `json.Object.setMember`, `json.Node.takeObject`
    extern fn json_object_set_object_member(p_object: *Object, p_member_name: [*:0]const u8, p_value: *json.Object) void;
    pub const setObjectMember = json_object_set_object_member;

    /// Convenience function for setting an object member with a string value.
    ///
    /// See also: `json.Object.setMember`, `json.Node.initString`
    extern fn json_object_set_string_member(p_object: *Object, p_member_name: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const setStringMember = json_object_set_string_member;

    /// Releases a reference on the given object.
    ///
    /// If the reference count reaches zero, the object is destroyed and
    /// all its resources are freed.
    extern fn json_object_unref(p_object: *Object) void;
    pub const unref = json_object_unref;

    extern fn json_object_get_type() usize;
    pub const getGObjectType = json_object_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An iterator object used to iterate over the members of a JSON object.
///
/// `JsonObjectIter` must be allocated on the stack and initialised using
/// `json.ObjectIter.init` or `json.ObjectIter.initOrdered`.
///
/// The iterator is invalidated if the object is modified during
/// iteration.
///
/// All the fields in the `JsonObjectIter` structure are private and should
/// never be accessed directly.
pub const ObjectIter = extern struct {
    f_priv_pointer: [6]*anyopaque,
    f_priv_int: [2]c_int,
    f_priv_boolean: [1]c_int,

    /// Initialises the `iter` and associate it with `object`.
    ///
    /// ```c
    /// JsonObjectIter iter;
    /// const gchar *member_name;
    /// JsonNode *member_node;
    ///
    /// json_object_iter_init (&iter, some_object);
    /// while (json_object_iter_next (&iter, &member_name, &member_node))
    ///   {
    ///     // Do something with `member_name` and `member_node`.
    ///   }
    /// ```
    ///
    /// The iterator initialized with this function will iterate the
    /// members of the object in an undefined order.
    ///
    /// See also: `json.ObjectIter.initOrdered`
    extern fn json_object_iter_init(p_iter: *ObjectIter, p_object: *json.Object) void;
    pub const init = json_object_iter_init;

    /// Initialises the `iter` and associate it with `object`.
    ///
    /// ```c
    /// JsonObjectIter iter;
    /// const gchar *member_name;
    /// JsonNode *member_node;
    ///
    /// json_object_iter_init_ordered (&iter, some_object);
    /// while (json_object_iter_next_ordered (&iter, &member_name, &member_node))
    ///   {
    ///     // Do something with `member_name` and `member_node`.
    ///   }
    /// ```
    ///
    /// See also: `json.ObjectIter.init`
    extern fn json_object_iter_init_ordered(p_iter: *ObjectIter, p_object: *json.Object) void;
    pub const initOrdered = json_object_iter_init_ordered;

    /// Advances the iterator and retrieves the next member in the object.
    ///
    /// If the end of the object is reached, `FALSE` is returned and `member_name`
    /// and `member_node` are set to invalid values. After that point, the `iter`
    /// is invalid.
    ///
    /// The order in which members are returned by the iterator is undefined. The
    /// iterator is invalidated if the object is modified during iteration.
    ///
    /// You must use this function with an iterator initialized with
    /// `json.ObjectIter.init`; using this function with an iterator
    /// initialized with `json.ObjectIter.initOrdered` yields undefined
    /// behavior.
    ///
    /// See also: `json.ObjectIter.nextOrdered`
    extern fn json_object_iter_next(p_iter: *ObjectIter, p_member_name: ?*[*:0]const u8, p_member_node: ?**json.Node) c_int;
    pub const next = json_object_iter_next;

    /// Advances the iterator and retrieves the next member in the object.
    ///
    /// If the end of the object is reached, `FALSE` is returned and `member_name` and
    /// `member_node` are set to invalid values. After that point, the `iter` is invalid.
    ///
    /// The order in which members are returned by the iterator is the same order in
    /// which the members were added to the `JsonObject`. The iterator is invalidated
    /// if its `JsonObject` is modified during iteration.
    ///
    /// You must use this function with an iterator initialized with
    /// `json.ObjectIter.initOrdered`; using this function with an iterator
    /// initialized with `json.ObjectIter.init` yields undefined behavior.
    ///
    /// See also: `json.ObjectIter.next`
    extern fn json_object_iter_next_ordered(p_iter: *ObjectIter, p_member_name: ?*[*:0]const u8, p_member_node: ?**json.Node) c_int;
    pub const nextOrdered = json_object_iter_next_ordered;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The class structure for the JsonParser type.
pub const ParserClass = extern struct {
    pub const Instance = json.Parser;

    f_parent_class: gobject.ObjectClass,
    /// class handler for the JsonParser::parse-start signal
    f_parse_start: ?*const fn (p_parser: *json.Parser) callconv(.c) void,
    /// class handler for the JsonParser::object-start signal
    f_object_start: ?*const fn (p_parser: *json.Parser) callconv(.c) void,
    /// class handler for the JsonParser::object-member signal
    f_object_member: ?*const fn (p_parser: *json.Parser, p_object: *json.Object, p_member_name: [*:0]const u8) callconv(.c) void,
    /// class handler for the JsonParser::object-end signal
    f_object_end: ?*const fn (p_parser: *json.Parser, p_object: *json.Object) callconv(.c) void,
    /// class handler for the JsonParser::array-start signal
    f_array_start: ?*const fn (p_parser: *json.Parser) callconv(.c) void,
    /// class handler for the JsonParser::array-element signal
    f_array_element: ?*const fn (p_parser: *json.Parser, p_array: *json.Array, p_index_: c_int) callconv(.c) void,
    /// class handler for the JsonParser::array-end signal
    f_array_end: ?*const fn (p_parser: *json.Parser, p_array: *json.Array) callconv(.c) void,
    /// class handler for the JsonParser::parse-end signal
    f_parse_end: ?*const fn (p_parser: *json.Parser) callconv(.c) void,
    /// class handler for the JsonParser::error signal
    f_error: ?*const fn (p_parser: *json.Parser, p_error: *const glib.Error) callconv(.c) void,
    f__json_reserved1: ?*const fn () callconv(.c) void,
    f__json_reserved2: ?*const fn () callconv(.c) void,
    f__json_reserved3: ?*const fn () callconv(.c) void,
    f__json_reserved4: ?*const fn () callconv(.c) void,
    f__json_reserved5: ?*const fn () callconv(.c) void,
    f__json_reserved6: ?*const fn () callconv(.c) void,
    f__json_reserved7: ?*const fn () callconv(.c) void,
    f__json_reserved8: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ParserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParserPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PathClass = opaque {
    pub const Instance = json.Path;

    pub fn as(p_instance: *PathClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ReaderClass = extern struct {
    pub const Instance = json.Reader;

    f_parent_class: gobject.ObjectClass,
    f__json_padding0: ?*const fn () callconv(.c) void,
    f__json_padding1: ?*const fn () callconv(.c) void,
    f__json_padding2: ?*const fn () callconv(.c) void,
    f__json_padding3: ?*const fn () callconv(.c) void,
    f__json_padding4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ReaderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ReaderPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interface that allows serializing and deserializing object instances
/// with properties storing complex data types.
///
/// The `json.gobjectFromData` and `json.gobjectToData`
/// functions will check if the passed object type implements this interface,
/// so it can also be used to override the default property serialization
/// sequence.
pub const SerializableIface = extern struct {
    pub const Instance = json.Serializable;

    f_g_iface: gobject.TypeInterface,
    /// virtual function for serializing an object property
    ///   into JSON
    f_serialize_property: ?*const fn (p_serializable: *json.Serializable, p_property_name: [*:0]const u8, p_value: *const gobject.Value, p_pspec: *gobject.ParamSpec) callconv(.c) ?*json.Node,
    /// virtual function for deserializing JSON
    ///   into an object property
    f_deserialize_property: ?*const fn (p_serializable: *json.Serializable, p_property_name: [*:0]const u8, p_value: *gobject.Value, p_pspec: *gobject.ParamSpec, p_property_node: *json.Node) callconv(.c) c_int,
    /// virtual function for finding a property definition using
    ///   its name
    f_find_property: ?*const fn (p_serializable: *json.Serializable, p_name: [*:0]const u8) callconv(.c) ?*gobject.ParamSpec,
    /// virtual function for listing the installed property
    ///   definitions
    f_list_properties: ?*const fn (p_serializable: *json.Serializable, p_n_pspecs: *c_uint) callconv(.c) **gobject.ParamSpec,
    /// virtual function for setting a property
    f_set_property: ?*const fn (p_serializable: *json.Serializable, p_pspec: *gobject.ParamSpec, p_value: *const gobject.Value) callconv(.c) void,
    /// virtual function for getting a property
    f_get_property: ?*const fn (p_serializable: *json.Serializable, p_pspec: *gobject.ParamSpec, p_value: *gobject.Value) callconv(.c) void,

    pub fn as(p_instance: *SerializableIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the content of a node.
pub const NodeType = enum(c_int) {
    object = 0,
    array = 1,
    value = 2,
    null = 3,
    _,

    extern fn json_node_type_get_type() usize;
    pub const getGObjectType = json_node_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error codes for `JSON_PARSER_ERROR`.
///
/// This enumeration can be extended at later date
pub const ParserError = enum(c_int) {
    parse = 0,
    trailing_comma = 1,
    missing_comma = 2,
    missing_colon = 3,
    invalid_bareword = 4,
    empty_member_name = 5,
    invalid_data = 6,
    unknown = 7,
    nesting = 8,
    invalid_structure = 9,
    invalid_assignment = 10,
    _,

    extern fn json_parser_error_quark() glib.Quark;
    pub const quark = json_parser_error_quark;

    extern fn json_parser_error_get_type() usize;
    pub const getGObjectType = json_parser_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error codes for `JSON_PATH_ERROR`.
///
/// This enumeration can be extended at later date
pub const PathError = enum(c_int) {
    query = 0,
    _,

    extern fn json_path_error_quark() glib.Quark;
    pub const quark = json_path_error_quark;

    extern fn json_path_error_get_type() usize;
    pub const getGObjectType = json_path_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error codes for `JSON_READER_ERROR`.
///
/// This enumeration can be extended at later date
pub const ReaderError = enum(c_int) {
    no_array = 0,
    invalid_index = 1,
    no_object = 2,
    invalid_member = 3,
    invalid_node = 4,
    no_value = 5,
    invalid_type = 6,
    _,

    extern fn json_reader_error_quark() glib.Quark;
    pub const quark = json_reader_error_quark;

    extern fn json_reader_error_get_type() usize;
    pub const getGObjectType = json_reader_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Checks whether it is possible to deserialize a `GBoxed` of
/// type `gboxed_type` from a `json.Node` of type `node_type`.
extern fn json_boxed_can_deserialize(p_gboxed_type: usize, p_node_type: json.NodeType) c_int;
pub const boxedCanDeserialize = json_boxed_can_deserialize;

/// Checks whether it is possible to serialize a `GBoxed` of
/// type `gboxed_type` into a `json.Node`.
///
/// The type of the node is placed inside `node_type` if the function
/// returns `TRUE`, and it's undefined otherwise.
extern fn json_boxed_can_serialize(p_gboxed_type: usize, p_node_type: ?*json.NodeType) c_int;
pub const boxedCanSerialize = json_boxed_can_serialize;

/// Deserializes the given `json.Node` into a `GBoxed` of the given type.
extern fn json_boxed_deserialize(p_gboxed_type: usize, p_node: *json.Node) ?*anyopaque;
pub const boxedDeserialize = json_boxed_deserialize;

/// Registers a deserialization function for a `GBoxed` of type `gboxed_type`
/// from a `json.Node` of type `node_type`.
extern fn json_boxed_register_deserialize_func(p_gboxed_type: usize, p_node_type: json.NodeType, p_deserialize_func: json.BoxedDeserializeFunc) void;
pub const boxedRegisterDeserializeFunc = json_boxed_register_deserialize_func;

/// Registers a serialization function for a `GBoxed` of type `gboxed_type`
/// to a `json.Node` of type `node_type`.
extern fn json_boxed_register_serialize_func(p_gboxed_type: usize, p_node_type: json.NodeType, p_serialize_func: json.BoxedSerializeFunc) void;
pub const boxedRegisterSerializeFunc = json_boxed_register_serialize_func;

/// Serializes a pointer to a `GBoxed` of the given type into a `json.Node`.
///
/// If the serialization is not possible, this function will return `NULL`.
extern fn json_boxed_serialize(p_gboxed_type: usize, p_boxed: ?*const anyopaque) ?*json.Node;
pub const boxedSerialize = json_boxed_serialize;

/// Deserializes a JSON data stream and creates an instance of the given
/// type.
///
/// If the given type implements the `json.Serializable` interface, it
/// will be asked to deserialize all the JSON members into their respective
/// properties; otherwise, the default implementation will be used to translate
/// the compatible JSON native types.
///
/// **Note**: the JSON data stream must be an object.
///
/// For historical reasons, the `length` argument is unused. The given `data`
/// must be a `NUL`-terminated string.
extern fn json_construct_gobject(p_gtype: usize, p_data: [*:0]const u8, p_length: usize, p_error: ?*?*glib.Error) ?*gobject.Object;
pub const constructGobject = json_construct_gobject;

/// Parses the given string and returns the corresponding JSON tree.
///
/// If the string is empty, this function will return `NULL`.
///
/// In case of parsing error, this function returns `NULL` and sets
/// the error appropriately.
extern fn json_from_string(p_str: [*:0]const u8, p_error: ?*?*glib.Error) ?*json.Node;
pub const fromString = json_from_string;

/// Creates a new `GObject` instance of the given type, and constructs it
/// using the members of the object in the given node.
extern fn json_gobject_deserialize(p_gtype: usize, p_node: *json.Node) *gobject.Object;
pub const gobjectDeserialize = json_gobject_deserialize;

/// Deserializes a JSON data stream and creates an instance of the
/// given type.
///
/// If the type implements the `json.Serializable` interface, it will
/// be asked to deserialize all the JSON members into their respective properties;
/// otherwise, the default implementation will be used to translate the
/// compatible JSON native types.
///
/// **Note**: the JSON data stream must be an object
extern fn json_gobject_from_data(p_gtype: usize, p_data: [*:0]const u8, p_length: isize, p_error: ?*?*glib.Error) ?*gobject.Object;
pub const gobjectFromData = json_gobject_from_data;

/// Creates a JSON tree representing the passed object instance.
///
/// Each member of the returned JSON object will map to a property of
/// the object type.
///
/// The returned JSON tree will be returned as a `JsonNode` with a type
/// of `JSON_NODE_OBJECT`.
extern fn json_gobject_serialize(p_gobject: *gobject.Object) *json.Node;
pub const gobjectSerialize = json_gobject_serialize;

/// Serializes a `GObject` instance into a JSON data stream, iterating
/// recursively over each property.
///
/// If the given object implements the `json.Serializable` interface,
/// it will be asked to serialize all its properties; otherwise, the default
/// implementation will be use to translate the compatible types into
/// JSON native types.
extern fn json_gobject_to_data(p_gobject: *gobject.Object, p_length: ?*usize) [*:0]u8;
pub const gobjectToData = json_gobject_to_data;

/// Converts a JSON data structure to a `GVariant`.
///
/// If `signature` is not `NULL`, it will be used to resolve ambiguous
/// data types.
///
/// If no error occurs, the resulting `GVariant` is guaranteed to conform
/// to `signature`.
///
/// If `signature` is not `NULL` but does not represent a valid `GVariant` type
/// string, `NULL` is returned and the `error` is set to
/// `G_IO_ERROR_INVALID_ARGUMENT`.
///
/// If a `signature` is provided but the JSON structure cannot be mapped to it,
/// `NULL` is returned and the `error` is set to `G_IO_ERROR_INVALID_DATA`.
///
/// If `signature` is `NULL`, the conversion is done based strictly on the types
/// in the JSON nodes.
///
/// The returned variant has a floating reference that will need to be sunk
/// by the caller code.
extern fn json_gvariant_deserialize(p_json_node: *json.Node, p_signature: ?[*:0]const u8, p_error: ?*?*glib.Error) ?*glib.Variant;
pub const gvariantDeserialize = json_gvariant_deserialize;

/// Converts a JSON string to a `GVariant` value.
///
/// This function works exactly like `json.gvariantDeserialize`, but
/// takes a JSON encoded string instead.
///
/// The string is first converted to a `json.Node` using
/// `json.Parser`, and then `json_gvariant_deserialize` is called on
/// the node.
///
/// The returned variant has a floating reference that will need to be sunk
/// by the caller code.
extern fn json_gvariant_deserialize_data(p_json: [*:0]const u8, p_length: isize, p_signature: ?[*:0]const u8, p_error: ?*?*glib.Error) ?*glib.Variant;
pub const gvariantDeserializeData = json_gvariant_deserialize_data;

/// Converts `variant` to a JSON tree.
extern fn json_gvariant_serialize(p_variant: *glib.Variant) *json.Node;
pub const gvariantSerialize = json_gvariant_serialize;

/// Converts `variant` to its JSON encoded string representation.
///
/// This is a convenience function around `json.gvariantSerialize`, to
/// obtain the JSON tree, and then `json.Generator` to stringify it.
extern fn json_gvariant_serialize_data(p_variant: *glib.Variant, p_length: ?*usize) [*:0]u8;
pub const gvariantSerializeData = json_gvariant_serialize_data;

/// Serializes a `GObject` instance into a JSON data stream.
///
/// If the object implements the `json.Serializable` interface, it will be
/// asked to serizalize all its properties; otherwise, the default
/// implementation will be use to translate the compatible types into JSON
/// native types.
extern fn json_serialize_gobject(p_gobject: *gobject.Object, p_length: ?*usize) [*:0]u8;
pub const serializeGobject = json_serialize_gobject;

/// Check whether `a` and `b` are equal UTF-8 JSON strings and return an ordering
/// over them in ``strcmp`` style.
extern fn json_string_compare(p_a: [*:0]const u8, p_b: [*:0]const u8) c_int;
pub const stringCompare = json_string_compare;

/// Check whether `a` and `b` are equal UTF-8 JSON strings.
extern fn json_string_equal(p_a: [*:0]const u8, p_b: [*:0]const u8) c_int;
pub const stringEqual = json_string_equal;

/// Calculate a hash value for the given `key` (a UTF-8 JSON string).
///
/// Note: Member names are compared byte-wise, without applying any Unicode
/// decomposition or normalisation. This is not explicitly mentioned in the JSON
/// standard (ECMA-404), but is assumed.
extern fn json_string_hash(p_key: [*:0]const u8) c_uint;
pub const stringHash = json_string_hash;

/// Generates a stringified JSON representation of the contents of
/// the given `node`.
extern fn json_to_string(p_node: *json.Node, p_pretty: c_int) [*:0]u8;
pub const toString = json_to_string;

/// The function to be passed to `json.Array.foreachElement`.
///
/// You should not add or remove elements to and from `array` within
/// this function.
///
/// It is safe to change the value of `element_node`.
pub const ArrayForeach = *const fn (p_array: *json.Array, p_index_: c_uint, p_element_node: *json.Node, p_user_data: ?*anyopaque) callconv(.c) void;

/// Deserializes the contents of the passed `JsonNode` into a `GBoxed`, for instance:
///
/// ```c
/// static gpointer
/// my_point_deserialize (JsonNode *node)
/// {
///   double x = 0.0, y = 0.0;
///
///   if (JSON_NODE_HOLDS_ARRAY (node))
///     {
///       JsonArray *array = json_node_get_array (node);
///
///       if (json_array_get_length (array) == 2)
///         {
///           x = json_array_get_double_element (array, 0);
///           y = json_array_get_double_element (array, 1);
///         }
///     }
///   else if (JSON_NODE_HOLDS_OBJECT (node))
///     {
///       JsonObject *obj = json_node_get_object (node);
///
///       x = json_object_get_double_member_with_default (obj, "x", 0.0);
///       y = json_object_get_double_member_with_default (obj, "y", 0.0);
///     }
///
///   // `my_point_new` is defined elsewhere
///   return my_point_new (x, y);
/// }
/// ```
pub const BoxedDeserializeFunc = *const fn (p_node: *json.Node) callconv(.c) ?*anyopaque;

/// Serializes the passed `GBoxed` and stores it inside a `JsonNode`, for instance:
///
/// ```c
/// static JsonNode *
/// my_point_serialize (gconstpointer boxed)
/// {
///   const MyPoint *point = boxed;
///
///   g_autoptr(JsonBuilder) builder = json_builder_new ();
///
///   json_builder_begin_object (builder);
///   json_builder_set_member_name (builder, "x");
///   json_builder_add_double_value (builder, point->x);
///   json_builder_set_member_name (builder, "y");
///   json_builder_add_double_value (builder, point->y);
///   json_builder_end_object (builder);
///
///   return json_builder_get_root (builder);
/// }
/// ```
pub const BoxedSerializeFunc = *const fn (p_boxed: ?*const anyopaque) callconv(.c) *json.Node;

/// The function to be passed to `json.Object.foreachMember`.
///
/// You should not add or remove members to and from `object` within
/// this function.
///
/// It is safe to change the value of `member_node`.
pub const ObjectForeach = *const fn (p_object: *json.Object, p_member_name: [*:0]const u8, p_member_node: *json.Node, p_user_data: ?*anyopaque) callconv(.c) void;

/// Json major version component (e.g. 1 if `JSON_VERSION` is "1.2.3")
pub const MAJOR_VERSION = 1;
/// Json micro version component (e.g. 3 if `JSON_VERSION` is "1.2.3")
pub const MICRO_VERSION = 8;
/// Json minor version component (e.g. 2 if `JSON_VERSION` is "1.2.3")
pub const MINOR_VERSION = 10;
/// The maximum recursion depth for a JSON tree.
pub const PARSER_MAX_RECURSION_DEPTH = 1024;
/// The version of JSON-GLib, encoded as a string, useful for printing and
/// concatenation.
pub const VERSION_S = "1.10.8";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
