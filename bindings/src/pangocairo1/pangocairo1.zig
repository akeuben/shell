pub const ext = @import("ext.zig");
const pangocairo = @This();

const std = @import("std");
const compat = @import("compat");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
/// `PangoCairoFont` is an interface exported by fonts for
/// use with Cairo.
///
/// The actual type of the font will depend on the particular
/// font technology Cairo was compiled to use.
pub const Font = opaque {
    pub const Prerequisites = [_]type{pango.Font};
    pub const Iface = opaque {
        pub const Instance = Font;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the `cairo_scaled_font_t` used by `font`.
    /// The scaled font can be referenced and kept using
    /// `cairo_scaled_font_reference`.
    extern fn pango_cairo_font_get_scaled_font(p_font: ?*Font) ?*cairo.ScaledFont;
    pub const getScaledFont = pango_cairo_font_get_scaled_font;

    extern fn pango_cairo_font_get_type() usize;
    pub const getGObjectType = pango_cairo_font_get_type;

    extern fn g_object_ref(p_self: *pangocairo.Font) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangocairo.Font) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Font, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoCairoFontMap` is an interface exported by font maps for
/// use with Cairo.
///
/// The actual type of the font map will depend on the particular
/// font technology Cairo was compiled to use.
pub const FontMap = opaque {
    pub const Prerequisites = [_]type{pango.FontMap};
    pub const Iface = opaque {
        pub const Instance = FontMap;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets a default `PangoCairoFontMap` to use with Cairo.
    ///
    /// Note that the type of the returned object will depend on the
    /// particular font backend Cairo was compiled to use; you generally
    /// should only use the `PangoFontMap` and `PangoCairoFontMap`
    /// interfaces on the returned object.
    ///
    /// The default Cairo fontmap can be changed by using
    /// `pangocairo.FontMap.setDefault`. This can be used to
    /// change the Cairo font backend that the default fontmap uses
    /// for example.
    ///
    /// Note that since Pango 1.32.6, the default fontmap is per-thread.
    /// Each thread gets its own default fontmap. In this way, PangoCairo
    /// can be used safely from multiple threads.
    extern fn pango_cairo_font_map_get_default() *pango.FontMap;
    pub const getDefault = pango_cairo_font_map_get_default;

    /// Creates a new `PangoCairoFontMap` object.
    ///
    /// A fontmap is used to cache information about available fonts,
    /// and holds certain global parameters such as the resolution.
    /// In most cases, you can use `func`PangoCairo`.font_map_get_default]
    /// instead.
    ///
    /// Note that the type of the returned object will depend
    /// on the particular font backend Cairo was compiled to use;
    /// You generally should only use the `PangoFontMap` and
    /// `PangoCairoFontMap` interfaces on the returned object.
    ///
    /// You can override the type of backend returned by using an
    /// environment variable `PANGOCAIRO_BACKEND`. Supported types,
    /// based on your build, are fc (fontconfig), win32, and coretext.
    /// If requested type is not available, NULL is returned. Ie.
    /// this is only useful for testing, when at least two backends
    /// are compiled in.
    extern fn pango_cairo_font_map_new() *pango.FontMap;
    pub const new = pango_cairo_font_map_new;

    /// Creates a new `PangoCairoFontMap` object of the type suitable
    /// to be used with cairo font backend of type `fonttype`.
    ///
    /// In most cases one should simply use `pangocairo.FontMap.new`, or
    /// in fact in most of those cases, just use `pangocairo.FontMap.getDefault`.
    extern fn pango_cairo_font_map_new_for_font_type(p_fonttype: cairo.FontType) ?*pango.FontMap;
    pub const newForFontType = pango_cairo_font_map_new_for_font_type;

    /// Create a `PangoContext` for the given fontmap.
    extern fn pango_cairo_font_map_create_context(p_fontmap: *FontMap) *pango.Context;
    pub const createContext = pango_cairo_font_map_create_context;

    /// Gets the type of Cairo font backend that `fontmap` uses.
    extern fn pango_cairo_font_map_get_font_type(p_fontmap: *FontMap) cairo.FontType;
    pub const getFontType = pango_cairo_font_map_get_font_type;

    /// Gets the resolution for the fontmap.
    ///
    /// See `pangocairo.FontMap.setResolution`.
    extern fn pango_cairo_font_map_get_resolution(p_fontmap: *FontMap) f64;
    pub const getResolution = pango_cairo_font_map_get_resolution;

    /// Sets a default `PangoCairoFontMap` to use with Cairo.
    ///
    /// This can be used to change the Cairo font backend that the
    /// default fontmap uses for example. The old default font map
    /// is unreffed and the new font map referenced.
    ///
    /// Note that since Pango 1.32.6, the default fontmap is per-thread.
    /// This function only changes the default fontmap for
    /// the current thread. Default fontmaps of existing threads
    /// are not changed. Default fontmaps of any new threads will
    /// still be created using `pangocairo.FontMap.new`.
    ///
    /// A value of `NULL` for `fontmap` will cause the current default
    /// font map to be released and a new default font map to be created
    /// on demand, using `pangocairo.FontMap.new`.
    extern fn pango_cairo_font_map_set_default(p_fontmap: ?*FontMap) void;
    pub const setDefault = pango_cairo_font_map_set_default;

    /// Sets the resolution for the fontmap.
    ///
    /// This is a scale factor between
    /// points specified in a `PangoFontDescription` and Cairo units. The
    /// default value is 96, meaning that a 10 point font will be 13
    /// units high. (10 * 96. / 72. = 13.3).
    extern fn pango_cairo_font_map_set_resolution(p_fontmap: *FontMap, p_dpi: f64) void;
    pub const setResolution = pango_cairo_font_map_set_resolution;

    extern fn pango_cairo_font_map_get_type() usize;
    pub const getGObjectType = pango_cairo_font_map_get_type;

    extern fn g_object_ref(p_self: *pangocairo.FontMap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangocairo.FontMap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontMap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Retrieves any font rendering options previously set with
/// `pangocairo.contextSetFontOptions`.
///
/// This function does not report options that are derived from
/// the target surface by `updateContext`.
extern fn pango_cairo_context_get_font_options(p_context: *pango.Context) ?*const cairo.FontOptions;
pub const contextGetFontOptions = pango_cairo_context_get_font_options;

/// Gets the resolution for the context.
///
/// See `pangocairo.contextSetResolution`
extern fn pango_cairo_context_get_resolution(p_context: *pango.Context) f64;
pub const contextGetResolution = pango_cairo_context_get_resolution;

/// Sets callback function for context to use for rendering attributes
/// of type `PANGO_ATTR_SHAPE`.
///
/// See `PangoCairoShapeRendererFunc` for details.
///
/// Retrieves callback function and associated user data for rendering
/// attributes of type `PANGO_ATTR_SHAPE` as set by
/// `pangocairo.contextSetShapeRenderer`, if any.
extern fn pango_cairo_context_get_shape_renderer(p_context: *pango.Context, p_data: ?*anyopaque) ?pangocairo.ShapeRendererFunc;
pub const contextGetShapeRenderer = pango_cairo_context_get_shape_renderer;

/// Sets the font options used when rendering text with this context.
///
/// These options override any options that `updateContext`
/// derives from the target surface.
extern fn pango_cairo_context_set_font_options(p_context: *pango.Context, p_options: ?*const cairo.FontOptions) void;
pub const contextSetFontOptions = pango_cairo_context_set_font_options;

/// Sets the resolution for the context.
///
/// This is a scale factor between points specified in a `PangoFontDescription`
/// and Cairo units. The default value is 96, meaning that a 10 point font will
/// be 13 units high. (10 * 96. / 72. = 13.3).
extern fn pango_cairo_context_set_resolution(p_context: *pango.Context, p_dpi: f64) void;
pub const contextSetResolution = pango_cairo_context_set_resolution;

/// Sets callback function for context to use for rendering attributes
/// of type `PANGO_ATTR_SHAPE`.
///
/// See `PangoCairoShapeRendererFunc` for details.
extern fn pango_cairo_context_set_shape_renderer(p_context: *pango.Context, p_func: ?pangocairo.ShapeRendererFunc, p_data: ?*anyopaque, p_dnotify: ?glib.DestroyNotify) void;
pub const contextSetShapeRenderer = pango_cairo_context_set_shape_renderer;

/// Creates a context object set up to match the current transformation
/// and target surface of the Cairo context.
///
/// This context can then be
/// used to create a layout using `pango.Layout.new`.
///
/// This function is a convenience function that creates a context using
/// the default font map, then updates it to `cr`. If you just need to
/// create a layout for use with `cr` and do not need to access `PangoContext`
/// directly, you can use `createLayout` instead.
extern fn pango_cairo_create_context(p_cr: *cairo.Context) *pango.Context;
pub const createContext = pango_cairo_create_context;

/// Creates a layout object set up to match the current transformation
/// and target surface of the Cairo context.
///
/// This layout can then be used for text measurement with functions
/// like `pango.Layout.getSize` or drawing with functions like
/// `showLayout`. If you change the transformation or target
/// surface for `cr`, you need to call `updateLayout`.
///
/// This function is the most convenient way to use Cairo with Pango,
/// however it is slightly inefficient since it creates a separate
/// `PangoContext` object for each layout. This might matter in an
/// application that was laying out large amounts of text.
extern fn pango_cairo_create_layout(p_cr: *cairo.Context) *pango.Layout;
pub const createLayout = pango_cairo_create_layout;

/// Add a squiggly line to the current path in the specified cairo context that
/// approximately covers the given rectangle in the style of an underline used
/// to indicate a spelling error.
///
/// The width of the underline is rounded to an integer number of up/down
/// segments and the resulting rectangle is centered in the original rectangle.
extern fn pango_cairo_error_underline_path(p_cr: *cairo.Context, p_x: f64, p_y: f64, p_width: f64, p_height: f64) void;
pub const errorUnderlinePath = pango_cairo_error_underline_path;

/// Adds the glyphs in `glyphs` to the current path in the specified
/// cairo context.
///
/// The origin of the glyphs (the left edge of the baseline)
/// will be at the current point of the cairo context.
extern fn pango_cairo_glyph_string_path(p_cr: *cairo.Context, p_font: *pango.Font, p_glyphs: *pango.GlyphString) void;
pub const glyphStringPath = pango_cairo_glyph_string_path;

/// Adds the text in `PangoLayoutLine` to the current path in the
/// specified cairo context.
///
/// The origin of the glyphs (the left edge of the line) will be
/// at the current point of the cairo context.
extern fn pango_cairo_layout_line_path(p_cr: *cairo.Context, p_line: *pango.LayoutLine) void;
pub const layoutLinePath = pango_cairo_layout_line_path;

/// Adds the text in a `PangoLayout` to the current path in the
/// specified cairo context.
///
/// The top-left corner of the `PangoLayout` will be at the
/// current point of the cairo context.
extern fn pango_cairo_layout_path(p_cr: *cairo.Context, p_layout: *pango.Layout) void;
pub const layoutPath = pango_cairo_layout_path;

/// Draw a squiggly line in the specified cairo context that approximately
/// covers the given rectangle in the style of an underline used to indicate a
/// spelling error.
///
/// The width of the underline is rounded to an integer
/// number of up/down segments and the resulting rectangle is centered in the
/// original rectangle.
extern fn pango_cairo_show_error_underline(p_cr: *cairo.Context, p_x: f64, p_y: f64, p_width: f64, p_height: f64) void;
pub const showErrorUnderline = pango_cairo_show_error_underline;

/// Draws the glyphs in `glyph_item` in the specified cairo context,
///
/// embedding the text associated with the glyphs in the output if the
/// output format supports it (PDF for example), otherwise it acts
/// similar to `showGlyphString`.
///
/// The origin of the glyphs (the left edge of the baseline) will
/// be drawn at the current point of the cairo context.
///
/// Note that `text` is the start of the text for layout, which is then
/// indexed by `glyph_item->item->offset`.
extern fn pango_cairo_show_glyph_item(p_cr: *cairo.Context, p_text: [*:0]const u8, p_glyph_item: *pango.GlyphItem) void;
pub const showGlyphItem = pango_cairo_show_glyph_item;

/// Draws the glyphs in `glyphs` in the specified cairo context.
///
/// The origin of the glyphs (the left edge of the baseline) will
/// be drawn at the current point of the cairo context.
extern fn pango_cairo_show_glyph_string(p_cr: *cairo.Context, p_font: *pango.Font, p_glyphs: *pango.GlyphString) void;
pub const showGlyphString = pango_cairo_show_glyph_string;

/// Draws a `PangoLayout` in the specified cairo context.
///
/// The top-left corner of the `PangoLayout` will be drawn
/// at the current point of the cairo context.
extern fn pango_cairo_show_layout(p_cr: *cairo.Context, p_layout: *pango.Layout) void;
pub const showLayout = pango_cairo_show_layout;

/// Draws a `PangoLayoutLine` in the specified cairo context.
///
/// The origin of the glyphs (the left edge of the line) will
/// be drawn at the current point of the cairo context.
extern fn pango_cairo_show_layout_line(p_cr: *cairo.Context, p_line: *pango.LayoutLine) void;
pub const showLayoutLine = pango_cairo_show_layout_line;

/// Updates a `PangoContext` previously created for use with Cairo to
/// match the current transformation and target surface of a Cairo
/// context.
///
/// If any layouts have been created for the context, it's necessary
/// to call `pango.Layout.contextChanged` on those layouts.
extern fn pango_cairo_update_context(p_cr: *cairo.Context, p_context: *pango.Context) void;
pub const updateContext = pango_cairo_update_context;

/// Updates the private `PangoContext` of a `PangoLayout` created with
/// `createLayout` to match the current transformation and target
/// surface of a Cairo context.
extern fn pango_cairo_update_layout(p_cr: *cairo.Context, p_layout: *pango.Layout) void;
pub const updateLayout = pango_cairo_update_layout;

/// Function type for rendering attributes of type `PANGO_ATTR_SHAPE`
/// with Pango's Cairo renderer.
pub const ShapeRendererFunc = *const fn (p_cr: *cairo.Context, p_attr: *pango.AttrShape, p_do_path: c_int, p_data: ?*anyopaque) callconv(.c) void;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
