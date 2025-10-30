pub const ext = @import("ext.zig");
const pangoft2 = @This();

const std = @import("std");
const compat = @import("compat");
const freetype2 = @import("freetype22");
const pangofc = @import("pangofc1");
const fontconfig = @import("fontconfig2");
const pango = @import("pango1");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const harfbuzz = @import("harfbuzz0");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
/// The `PangoFT2FontMap` is the `PangoFontMap` implementation for FreeType fonts.
pub const FontMap = opaque {
    pub const Parent = pangofc.FontMap;
    pub const Implements = [_]type{gio.ListModel};
    pub const Class = opaque {
        pub const Instance = FontMap;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a `PangoFT2FontMap`.
    ///
    /// This font map is cached and should
    /// not be freed. If the font map is no longer needed, it can
    /// be released with `pangoft2.shutdownDisplay`. Use of the
    /// global PangoFT2 fontmap is deprecated; use `pangoft2.FontMap.new`
    /// instead.
    extern fn pango_ft2_font_map_for_display() *pango.FontMap;
    pub const forDisplay = pango_ft2_font_map_for_display;

    /// Create a new `PangoFT2FontMap` object.
    ///
    /// A fontmap is used to cache information about available fonts,
    /// and holds certain global parameters such as the resolution and
    /// the default substitute function (see
    /// `pangoft2.FontMap.setDefaultSubstitute`).
    extern fn pango_ft2_font_map_new() *pangoft2.FontMap;
    pub const new = pango_ft2_font_map_new;

    /// Create a `PangoContext` for the given fontmap.
    extern fn pango_ft2_font_map_create_context(p_fontmap: *FontMap) *pango.Context;
    pub const createContext = pango_ft2_font_map_create_context;

    /// Sets a function that will be called to do final configuration
    /// substitution on a `FcPattern` before it is used to load
    /// the font.
    ///
    /// This function can be used to do things like set
    /// hinting and antialiasing options.
    extern fn pango_ft2_font_map_set_default_substitute(p_fontmap: *FontMap, p_func: pangoft2.SubstituteFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) void;
    pub const setDefaultSubstitute = pango_ft2_font_map_set_default_substitute;

    /// Sets the horizontal and vertical resolutions for the fontmap.
    extern fn pango_ft2_font_map_set_resolution(p_fontmap: *FontMap, p_dpi_x: f64, p_dpi_y: f64) void;
    pub const setResolution = pango_ft2_font_map_set_resolution;

    /// Call this function any time the results of the
    /// default substitution function set with
    /// `pangoft2.FontMap.setDefaultSubstitute` change.
    ///
    /// That is, if your substitution function will return different
    /// results for the same input pattern, you must call this function.
    extern fn pango_ft2_font_map_substitute_changed(p_fontmap: *FontMap) void;
    pub const substituteChanged = pango_ft2_font_map_substitute_changed;

    extern fn pango_ft2_font_map_get_type() usize;
    pub const getGObjectType = pango_ft2_font_map_get_type;

    extern fn g_object_ref(p_self: *pangoft2.FontMap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangoft2.FontMap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontMap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Gets the `PangoCoverage` for a `PangoFT2Font`.
///
/// Use `pango.Font.getCoverage` instead.
extern fn pango_ft2_font_get_coverage(p_font: *pango.Font, p_language: *pango.Language) *pango.Coverage;
pub const fontGetCoverage = pango_ft2_font_get_coverage;

/// Returns the native FreeType2 `FT_Face` structure
/// used for this `PangoFont`.
///
/// This may be useful if you want to use FreeType2
/// functions directly.
///
/// Use `pangofc.Font.lockFace` instead; when you are
/// done with a face from `pangofc.Font.lockFace`, you
/// must call `pangofc.Font.unlockFace`.
extern fn pango_ft2_font_get_face(p_font: *pango.Font) ?freetype2.Face;
pub const fontGetFace = pango_ft2_font_get_face;

/// Retrieves kerning information for a combination of two glyphs.
///
/// Use `pangofc.Font.kernGlyphs` instead.
extern fn pango_ft2_font_get_kerning(p_font: *pango.Font, p_left: pango.Glyph, p_right: pango.Glyph) c_int;
pub const fontGetKerning = pango_ft2_font_get_kerning;

/// Retrieves a `PangoContext` for the default PangoFT2 fontmap
/// (see `pangoft2.FontMap.forDisplay`) and sets the resolution
/// for the default fontmap to `dpi_x` by `dpi_y`.
extern fn pango_ft2_get_context(p_dpi_x: f64, p_dpi_y: f64) *pango.Context;
pub const getContext = pango_ft2_get_context;

/// Return the index of a glyph suitable for drawing unknown
/// characters with `font`, or `PANGO_GLYPH_EMPTY` if no suitable
/// glyph found.
///
/// If you want to draw an unknown-box for a character that
/// is not covered by the font, use `PANGO_GET_UNKNOWN_GLYPH`
/// instead.
extern fn pango_ft2_get_unknown_glyph(p_font: *pango.Font) pango.Glyph;
pub const getUnknownGlyph = pango_ft2_get_unknown_glyph;

/// Renders a `PangoGlyphString` onto a FreeType2 bitmap.
extern fn pango_ft2_render(p_bitmap: *freetype2.Bitmap, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) void;
pub const render = pango_ft2_render;

/// Render a `PangoLayout` onto a FreeType2 bitmap
extern fn pango_ft2_render_layout(p_bitmap: *freetype2.Bitmap, p_layout: *pango.Layout, p_x: c_int, p_y: c_int) void;
pub const renderLayout = pango_ft2_render_layout;

/// Render a `PangoLayoutLine` onto a FreeType2 bitmap
extern fn pango_ft2_render_layout_line(p_bitmap: *freetype2.Bitmap, p_line: *pango.LayoutLine, p_x: c_int, p_y: c_int) void;
pub const renderLayoutLine = pango_ft2_render_layout_line;

/// Render a `PangoLayoutLine` onto a FreeType2 bitmap, with he
/// location specified in fixed-point Pango units rather than
/// pixels.
///
/// (Using this will avoid extra inaccuracies from rounding
/// to integer pixels multiple times, even if the final glyph
/// positions are integers.)
extern fn pango_ft2_render_layout_line_subpixel(p_bitmap: *freetype2.Bitmap, p_line: *pango.LayoutLine, p_x: c_int, p_y: c_int) void;
pub const renderLayoutLineSubpixel = pango_ft2_render_layout_line_subpixel;

/// Render a `PangoLayout` onto a FreeType2 bitmap, with he
/// location specified in fixed-point Pango units rather than
/// pixels.
///
/// (Using this will avoid extra inaccuracies from rounding
/// to integer pixels multiple times, even if the final glyph
/// positions are integers.)
extern fn pango_ft2_render_layout_subpixel(p_bitmap: *freetype2.Bitmap, p_layout: *pango.Layout, p_x: c_int, p_y: c_int) void;
pub const renderLayoutSubpixel = pango_ft2_render_layout_subpixel;

/// Renders a `PangoGlyphString` onto a FreeType2 bitmap, possibly
/// transforming the layed-out coordinates through a transformation
/// matrix.
///
/// Note that the transformation matrix for `font` is not
/// changed, so to produce correct rendering results, the `font`
/// must have been loaded using a `PangoContext` with an identical
/// transformation matrix to that passed in to this function.
extern fn pango_ft2_render_transformed(p_bitmap: *freetype2.Bitmap, p_matrix: ?*const pango.Matrix, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) void;
pub const renderTransformed = pango_ft2_render_transformed;

/// Free the global fontmap. (See `pangoft2.FontMap.forDisplay`)
/// Use of the global PangoFT2 fontmap is deprecated.
extern fn pango_ft2_shutdown_display() void;
pub const shutdownDisplay = pango_ft2_shutdown_display;

/// Function type for doing final config tweaking on prepared FcPatterns.
pub const SubstituteFunc = *const fn (p_pattern: *fontconfig.Pattern, p_data: ?*anyopaque) callconv(.c) void;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
