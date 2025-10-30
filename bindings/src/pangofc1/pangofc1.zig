pub const ext = @import("ext.zig");
const pangofc = @This();

const std = @import("std");
const compat = @import("compat");
const fontconfig = @import("fontconfig2");
const pango = @import("pango1");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
/// `PangoFcDecoder` is a virtual base class that implementations will
/// inherit from.
///
/// It's the interface that is used to define a custom encoding for a font.
/// These objects are created in your code from a function callback that was
/// originally registered with `pangofc.FontMap.addDecoderFindFunc`.
/// Pango requires information about the supported charset for a font as well
/// as the individual character to glyph conversions. Pango gets that
/// information via the `get_charset` and `get_glyph` callbacks into your
/// object implementation.
pub const Decoder = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = pangofc.DecoderClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Generates an `FcCharSet` of supported characters for the `fcfont`
        /// given.
        ///
        /// The returned `FcCharSet` will be a reference to an
        /// internal value stored by the `PangoFcDecoder` and must not
        /// be modified or freed.
        pub const get_charset = struct {
            pub fn call(p_class: anytype, p_decoder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fcfont: *pangofc.Font) *fontconfig.CharSet {
                return gobject.ext.as(Decoder.Class, p_class).f_get_charset.?(gobject.ext.as(Decoder, p_decoder), p_fcfont);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_decoder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fcfont: *pangofc.Font) callconv(.c) *fontconfig.CharSet) void {
                gobject.ext.as(Decoder.Class, p_class).f_get_charset = @ptrCast(p_implementation);
            }
        };

        /// Generates a `PangoGlyph` for the given Unicode point using the
        /// custom decoder.
        ///
        /// For complex scripts where there can be multiple
        /// glyphs for a single character, the decoder will return whatever
        /// glyph is most convenient for it. (Usually whatever glyph is directly
        /// in the fonts character map table.)
        pub const get_glyph = struct {
            pub fn call(p_class: anytype, p_decoder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fcfont: *pangofc.Font, p_wc: u32) pango.Glyph {
                return gobject.ext.as(Decoder.Class, p_class).f_get_glyph.?(gobject.ext.as(Decoder, p_decoder), p_fcfont, p_wc);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_decoder: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_fcfont: *pangofc.Font, p_wc: u32) callconv(.c) pango.Glyph) void {
                gobject.ext.as(Decoder.Class, p_class).f_get_glyph = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Generates an `FcCharSet` of supported characters for the `fcfont`
    /// given.
    ///
    /// The returned `FcCharSet` will be a reference to an
    /// internal value stored by the `PangoFcDecoder` and must not
    /// be modified or freed.
    extern fn pango_fc_decoder_get_charset(p_decoder: *Decoder, p_fcfont: *pangofc.Font) *fontconfig.CharSet;
    pub const getCharset = pango_fc_decoder_get_charset;

    /// Generates a `PangoGlyph` for the given Unicode point using the
    /// custom decoder.
    ///
    /// For complex scripts where there can be multiple
    /// glyphs for a single character, the decoder will return whatever
    /// glyph is most convenient for it. (Usually whatever glyph is directly
    /// in the fonts character map table.)
    extern fn pango_fc_decoder_get_glyph(p_decoder: *Decoder, p_fcfont: *pangofc.Font, p_wc: u32) pango.Glyph;
    pub const getGlyph = pango_fc_decoder_get_glyph;

    extern fn pango_fc_decoder_get_type() usize;
    pub const getGObjectType = pango_fc_decoder_get_type;

    extern fn g_object_ref(p_self: *pangofc.Decoder) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangofc.Decoder) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Decoder, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoFcFont` is a base class for font implementations
/// using the Fontconfig and FreeType libraries.
///
/// It is used in onjunction with `pangofc.FontMap`.
/// When deriving from this class, you need to implement all
/// of its virtual functions other than `shutdown` along with
/// the `get_glyph_extents` virtual function from `PangoFont`.
pub const Font = extern struct {
    pub const Parent = pango.Font;
    pub const Implements = [_]type{};
    pub const Class = pangofc.FontClass;
    f_parent_instance: pango.Font,
    f_font_pattern: ?*fontconfig.Pattern,
    f_fontmap: ?*pango.FontMap,
    f_priv: ?*anyopaque,
    f_matrix: pango.Matrix,
    f_description: ?*pango.FontDescription,
    f_metrics_by_lang: ?*glib.SList,
    bitfields0: packed struct(c_uint) {
        f_is_hinted: u1,
        f_is_transformed: u1,
        _: u30,
    },

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The PangoFc font map this font is associated with.
        pub const fontmap = struct {
            pub const name = "fontmap";

            pub const Type = ?*pangofc.FontMap;
        };

        /// The fontconfig pattern for this font.
        pub const pattern = struct {
            pub const name = "pattern";

            pub const Type = ?*anyopaque;
        };
    };

    pub const signals = struct {};

    /// Creates a `PangoFontDescription` that matches the specified
    /// Fontconfig pattern as closely as possible.
    ///
    /// Many possible Fontconfig pattern values, such as `FC_RASTERIZER`
    /// or `FC_DPI`, don't make sense in the context of `PangoFontDescription`,
    /// so will be ignored.
    extern fn pango_fc_font_description_from_pattern(p_pattern: *fontconfig.Pattern, p_include_size: c_int) *pango.FontDescription;
    pub const descriptionFromPattern = pango_fc_font_description_from_pattern;

    /// Gets the glyph index for a given Unicode character
    /// for `font`.
    ///
    /// If you only want to determine whether the font has
    /// the glyph, use `pangofc.Font.hasChar`.
    extern fn pango_fc_font_get_glyph(p_font: *Font, p_wc: u32) c_uint;
    pub const getGlyph = pango_fc_font_get_glyph;

    /// Returns the languages that are supported by `font`.
    ///
    /// This corresponds to the FC_LANG member of the FcPattern.
    ///
    /// The returned array is only valid as long as the font
    /// and its fontmap are valid.
    extern fn pango_fc_font_get_languages(p_font: *Font) ?[*]*pango.Language;
    pub const getLanguages = pango_fc_font_get_languages;

    /// Returns the FcPattern that `font` is based on.
    extern fn pango_fc_font_get_pattern(p_font: *Font) *fontconfig.Pattern;
    pub const getPattern = pango_fc_font_get_pattern;

    /// Returns the index of a glyph suitable for drawing `wc`
    /// as an unknown character.
    ///
    /// Use `PANGO_GET_UNKNOWN_GLYPH` instead.
    extern fn pango_fc_font_get_unknown_glyph(p_font: *Font, p_wc: u32) pango.Glyph;
    pub const getUnknownGlyph = pango_fc_font_get_unknown_glyph;

    /// Determines whether `font` has a glyph for the codepoint `wc`.
    extern fn pango_fc_font_has_char(p_font: *Font, p_wc: u32) c_int;
    pub const hasChar = pango_fc_font_has_char;

    /// This function used to adjust each adjacent pair of glyphs
    /// in `glyphs` according to kerning information in `font`.
    ///
    /// Since 1.44, it does nothing.
    extern fn pango_fc_font_kern_glyphs(p_font: *Font, p_glyphs: *pango.GlyphString) void;
    pub const kernGlyphs = pango_fc_font_kern_glyphs;

    /// Gets the FreeType `FT_Face` associated with a font.
    ///
    /// This face will be kept around until you call
    /// `pangofc.Font.unlockFace`.
    extern fn pango_fc_font_lock_face(p_font: *Font) freetype2.Face;
    pub const lockFace = pango_fc_font_lock_face;

    /// Releases a font previously obtained with
    /// `pangofc.Font.lockFace`.
    extern fn pango_fc_font_unlock_face(p_font: *Font) void;
    pub const unlockFace = pango_fc_font_unlock_face;

    extern fn pango_fc_font_get_type() usize;
    pub const getGObjectType = pango_fc_font_get_type;

    extern fn g_object_ref(p_self: *pangofc.Font) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangofc.Font) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Font, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoFcFontMap` is a base class for font map implementations using the
/// Fontconfig and FreeType libraries.
///
/// It is used in the Xft and FreeType backends shipped with Pango,
/// but can also be used when creating new backends. Any backend
/// deriving from this base class will take advantage of the wide
/// range of shapers implemented using FreeType that come with Pango.
pub const FontMap = opaque {
    pub const Parent = pango.FontMap;
    pub const Implements = [_]type{gio.ListModel};
    pub const Class = pangofc.FontMapClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// This function saves a callback method in the `PangoFcFontMap` that
    /// will be called whenever new fonts are created.
    ///
    /// If the function returns a `PangoFcDecoder`, that decoder will be used
    /// to determine both coverage via a `FcCharSet` and a one-to-one mapping
    /// of characters to glyphs. This will allow applications to have
    /// application-specific encodings for various fonts.
    extern fn pango_fc_font_map_add_decoder_find_func(p_fcfontmap: *FontMap, p_findfunc: pangofc.DecoderFindFunc, p_user_data: ?*anyopaque, p_dnotify: ?glib.DestroyNotify) void;
    pub const addDecoderFindFunc = pango_fc_font_map_add_decoder_find_func;

    /// Clear all cached information and fontsets for this font map.
    ///
    /// This should be called whenever there is a change in the
    /// output of the `default_substitute` virtual function of the
    /// font map, or if fontconfig has been reinitialized to new
    /// configuration.
    extern fn pango_fc_font_map_cache_clear(p_fcfontmap: *FontMap) void;
    pub const cacheClear = pango_fc_font_map_cache_clear;

    /// Informs font map that the fontconfig configuration (i.e.,
    /// the `FcConfig` object) used by this font map has changed.
    ///
    /// This currently calls `pangofc.FontMap.cacheClear` which
    /// ensures that list of fonts, etc will be regenerated using the
    /// updated configuration.
    extern fn pango_fc_font_map_config_changed(p_fcfontmap: *FontMap) void;
    pub const configChanged = pango_fc_font_map_config_changed;

    /// Creates a new context for this fontmap.
    ///
    /// This function is intended only for backend implementations deriving
    /// from `PangoFcFontMap`; it is possible that a backend will store
    /// additional information needed for correct operation on the `PangoContext`
    /// after calling this function.
    extern fn pango_fc_font_map_create_context(p_fcfontmap: *FontMap) *pango.Context;
    pub const createContext = pango_fc_font_map_create_context;

    /// Finds the decoder to use for `pattern`.
    ///
    /// Decoders can be added to a font map using
    /// `pangofc.FontMap.addDecoderFindFunc`.
    extern fn pango_fc_font_map_find_decoder(p_fcfontmap: *FontMap, p_pattern: *fontconfig.Pattern) ?*pangofc.Decoder;
    pub const findDecoder = pango_fc_font_map_find_decoder;

    /// Fetches the `FcConfig` attached to a font map.
    ///
    /// See also: `pangofc.FontMap.setConfig`.
    extern fn pango_fc_font_map_get_config(p_fcfontmap: *FontMap) ?*fontconfig.Config;
    pub const getConfig = pango_fc_font_map_get_config;

    /// Retrieves the `hb_face_t` for the given `PangoFcFont`.
    extern fn pango_fc_font_map_get_hb_face(p_fcfontmap: *FontMap, p_fcfont: *pangofc.Font) ?*harfbuzz.face_t;
    pub const getHbFace = pango_fc_font_map_get_hb_face;

    /// Set the `FcConfig` for this font map to use.
    ///
    /// The default value is `NULL`, which causes Fontconfig to use its global
    /// "current config". You can create a new `FcConfig` object and use this
    /// API to attach it to a font map.
    ///
    /// This is particularly useful for example, if you want to use application
    /// fonts with Pango. For that, you would create a fresh `FcConfig`, add your
    /// app fonts to it, and attach it to a new Pango font map.
    ///
    /// If `fcconfig` is different from the previous config attached to the font map,
    /// `pangofc.FontMap.configChanged` is called.
    ///
    /// This function acquires a reference to the `FcConfig` object; the caller
    /// does **not** need to retain a reference.
    ///
    /// See `pango.FontMap.addFontFile` for a backend-independent way
    /// of using application fonts with Pango.
    extern fn pango_fc_font_map_set_config(p_fcfontmap: *FontMap, p_fcconfig: ?*fontconfig.Config) void;
    pub const setConfig = pango_fc_font_map_set_config;

    /// Sets a function that will be called to do final configuration
    /// substitution on a `FcPattern` before it is used to load
    /// the font.
    ///
    /// This function can be used to do things like set
    /// hinting and antialiasing options.
    extern fn pango_fc_font_map_set_default_substitute(p_fontmap: *FontMap, p_func: pangofc.SubstituteFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) void;
    pub const setDefaultSubstitute = pango_fc_font_map_set_default_substitute;

    /// Clears all cached information for the fontmap and marks
    /// all fonts open for the fontmap as dead.
    ///
    /// See the `shutdown` virtual function of `PangoFcFont`.
    ///
    /// This function might be used by a backend when the underlying
    /// windowing system for the font map exits. This function is only
    /// intended to be called only for backend implementations deriving
    /// from `PangoFcFontMap`.
    extern fn pango_fc_font_map_shutdown(p_fcfontmap: *FontMap) void;
    pub const shutdown = pango_fc_font_map_shutdown;

    /// Call this function any time the results of the default
    /// substitution function set with
    /// `pangofc.FontMap.setDefaultSubstitute` change.
    ///
    /// That is, if your substitution function will return different
    /// results for the same input pattern, you must call this function.
    extern fn pango_fc_font_map_substitute_changed(p_fontmap: *FontMap) void;
    pub const substituteChanged = pango_fc_font_map_substitute_changed;

    extern fn pango_fc_font_map_get_type() usize;
    pub const getGObjectType = pango_fc_font_map_get_type;

    extern fn g_object_ref(p_self: *pangofc.FontMap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangofc.FontMap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontMap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for `PangoFcDecoder`.
pub const DecoderClass = extern struct {
    pub const Instance = pangofc.Decoder;

    f_parent_class: gobject.ObjectClass,
    /// This returns an `FcCharset` given a `PangoFcFont` that
    ///  includes a list of supported characters in the font.  The
    ///  `fontconfig.CharSet` that is returned should be an internal reference to your
    ///  code.  Pango will not free this structure.  It is important that
    ///  you make this callback fast because this callback is called
    ///  separately for each character to determine Unicode coverage.
    f_get_charset: ?*const fn (p_decoder: *pangofc.Decoder, p_fcfont: *pangofc.Font) callconv(.c) *fontconfig.CharSet,
    /// This returns a single `PangoGlyph` for a given Unicode
    ///  code point.
    f_get_glyph: ?*const fn (p_decoder: *pangofc.Decoder, p_fcfont: *pangofc.Font, p_wc: u32) callconv(.c) pango.Glyph,
    f__pango_reserved1: ?*const fn () callconv(.c) void,
    f__pango_reserved2: ?*const fn () callconv(.c) void,
    f__pango_reserved3: ?*const fn () callconv(.c) void,
    f__pango_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *DecoderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontClass = opaque {
    pub const Instance = pangofc.Font;

    pub fn as(p_instance: *FontClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontMapClass = opaque {
    pub const Instance = pangofc.FontMap;

    pub fn as(p_instance: *FontMapClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontMapPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Callback function passed to `pangofc.FontMap.addDecoderFindFunc`.
pub const DecoderFindFunc = *const fn (p_pattern: *fontconfig.Pattern, p_user_data: ?*anyopaque) callconv(.c) *pangofc.Decoder;

/// Function type for doing final config tweaking on prepared `FcPattern`s.
pub const SubstituteFunc = *const fn (p_pattern: *fontconfig.Pattern, p_data: ?*anyopaque) callconv(.c) void;

/// Fontconfig property that Pango reads from font
/// patterns to populate list of OpenType features
/// to be enabled for the font by default.
///
/// The property will have a number of string elements,
/// each of which is the OpenType feature tag of one feature
/// to enable.
///
/// This is equivalent to FC_FONT_FEATURES in versions of
/// fontconfig that have that.
pub const FONT_FEATURES = "fontfeatures";
/// Fontconfig property that Pango reads from font
/// patterns to populate list of OpenType font variations
/// to be used for a font.
///
/// The property will have a string elements, each of which
/// a comma-separated list of OpenType axis setting of the
/// form AXIS=VALUE.
///
/// This is equivalent to FC_FONT_VARIATIONS in versions of
/// fontconfig that have that.
pub const FONT_VARIATIONS = "fontvariations";
/// Fontconfig property that Pango sets on any
/// fontconfig pattern it passes to fontconfig
/// if a `PangoGravity` other than `PANGO_GRAVITY_SOUTH`
/// is desired.
///
/// The property will have a `PangoGravity` value as a string,
/// like "east". This can be used to write fontconfig configuration
/// rules to choose different fonts for horizontal and vertical
/// writing directions.
pub const GRAVITY = "pangogravity";
/// Fontconfig property that Pango sets on any
/// fontconfig pattern it passes to fontconfig.
///
/// The property will have a string equal to what
/// `glib.getPrgname` returns. This can be used to write
/// fontconfig configuration rules that only affect
/// certain applications.
///
/// This is equivalent to FC_PRGNAME in versions of
/// fontconfig that have that.
pub const PRGNAME = "prgname";
/// Fontconfig property that Pango sets on any
/// fontconfig pattern it passes to fontconfig.
///
/// The property will have an integer value equal to what
/// `pango.version` returns. This can be used to write
/// fontconfig configuration rules that only affect certain
/// pango versions (or only pango-using applications, or only
/// non-pango-using applications).
pub const VERSION = "pangoversion";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
