pub const ext = @import("ext.zig");
const pangoxft = @This();

const std = @import("std");
const compat = @import("compat");
const xlib = @import("xlib2");
const xft = @import("xft2");
const pangoot = @import("pangoot1");
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
const pangoft2 = @import("pangoft21");
/// `PangoXftFont` is an implementation of `PangoFcFont` using the Xft
/// library for rendering.  It is used in conjunction with `PangoXftFontMap`.
pub const Font = opaque {
    pub const Parent = pangofc.Font;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Font;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the `XftFont` of a font.
    extern fn pango_xft_font_get_font(p_font: ?*pango.Font) ?*xft.Font;
    pub const getFont = pango_xft_font_get_font;

    /// Returns the X display of the `XftFont` of a font.
    extern fn pango_xft_font_get_display(p_font: *Font) *xlib.Display;
    pub const getDisplay = pango_xft_font_get_display;

    /// Gets the glyph index for a given Unicode character
    /// for `font`.
    ///
    /// If you only want to determine whether the font has
    /// the glyph, use `pangoxft.Font.hasChar`.
    ///
    /// Use `pangofc.Font.getGlyph` instead.
    extern fn pango_xft_font_get_glyph(p_font: *Font, p_wc: u32) c_uint;
    pub const getGlyph = pango_xft_font_get_glyph;

    /// Returns the index of a glyph suitable for drawing `wc` as an
    /// unknown character.
    ///
    /// Use `PANGO_GET_UNKNOWN_GLYPH` instead.
    extern fn pango_xft_font_get_unknown_glyph(p_font: *Font, p_wc: u32) pango.Glyph;
    pub const getUnknownGlyph = pango_xft_font_get_unknown_glyph;

    /// Determines whether `font` has a glyph for the codepoint `wc`.
    ///
    /// Use `pangofc.Font.hasChar` instead.
    extern fn pango_xft_font_has_char(p_font: *Font, p_wc: u32) c_int;
    pub const hasChar = pango_xft_font_has_char;

    /// Gets the FreeType `FT_Face` associated with a font.
    ///
    /// This face will be kept around until you call `pangoxft.Font.unlockFace`.
    ///
    /// Use `pangofc.Font.lockFace` instead.
    extern fn pango_xft_font_lock_face(p_font: *Font) freetype2.Face;
    pub const lockFace = pango_xft_font_lock_face;

    /// Releases a font previously obtained with
    /// `pangoxft.Font.lockFace`.
    ///
    /// Use `pangofc.Font.unlockFace` instead.
    extern fn pango_xft_font_unlock_face(p_font: *Font) void;
    pub const unlockFace = pango_xft_font_unlock_face;

    extern fn pango_xft_font_get_type() usize;
    pub const getGObjectType = pango_xft_font_get_type;

    extern fn g_object_ref(p_self: *pangoxft.Font) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangoxft.Font) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Font, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoXftFontMap` is an implementation of `PangoFcFontMap` suitable for
/// the Xft library as the renderer.  It is used in to create fonts of
/// type `PangoXftFont`.
pub const FontMap = opaque {
    pub const Parent = pangofc.FontMap;
    pub const Implements = [_]type{gio.ListModel};
    pub const Class = opaque {
        pub const Instance = FontMap;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn pango_xft_font_map_get_type() usize;
    pub const getGObjectType = pango_xft_font_map_get_type;

    extern fn g_object_ref(p_self: *pangoxft.FontMap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangoxft.FontMap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontMap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoXftRenderer` is a subclass of `PangoRenderer` used for rendering
/// with Pango's Xft backend. It can be used directly, or it can be
/// further subclassed to modify exactly how drawing of individual
/// elements occurs.
pub const Renderer = extern struct {
    pub const Parent = pango.Renderer;
    pub const Implements = [_]type{};
    pub const Class = pangoxft.RendererClass;
    f_parent_instance: pango.Renderer,
    f_display: ?*xlib.Display,
    f_screen: c_int,
    f_draw: ?*xft.Draw,
    f_priv: ?*pangoxft.RendererPrivate,

    pub const virtual_methods = struct {
        /// draw the specified glyphs using
        ///   the current foreground color and other foreground
        ///   attributes
        pub const composite_glyphs = struct {
            pub fn call(p_class: anytype, p_xftrenderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_xft_font: *xft.Font, p_glyphs: *xft.GlyphSpec, p_n_glyphs: c_int) void {
                return gobject.ext.as(Renderer.Class, p_class).f_composite_glyphs.?(gobject.ext.as(Renderer, p_xftrenderer), p_xft_font, p_glyphs, p_n_glyphs);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_xftrenderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_xft_font: *xft.Font, p_glyphs: *xft.GlyphSpec, p_n_glyphs: c_int) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_composite_glyphs = @ptrCast(p_implementation);
            }
        };

        /// draw the specified trapezoids using
        ///   the current color and other attributes for `part`
        pub const composite_trapezoids = struct {
            pub fn call(p_class: anytype, p_xftrenderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: pango.RenderPart, p_trapezoids: *xlib.XTrapezoid, p_n_trapezoids: c_int) void {
                return gobject.ext.as(Renderer.Class, p_class).f_composite_trapezoids.?(gobject.ext.as(Renderer, p_xftrenderer), p_part, p_trapezoids, p_n_trapezoids);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_xftrenderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: pango.RenderPart, p_trapezoids: *xlib.XTrapezoid, p_n_trapezoids: c_int) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_composite_trapezoids = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*anyopaque;
        };

        pub const screen = struct {
            pub const name = "screen";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Create a new `PangoXftRenderer` to allow rendering Pango objects
    /// with the Xft library.
    ///
    /// You must call `pangoxft.Renderer.setDraw` before
    /// using the renderer.
    extern fn pango_xft_renderer_new(p_display: *xlib.Display, p_screen: c_int) *pangoxft.Renderer;
    pub const new = pango_xft_renderer_new;

    /// Sets the default foreground color for a XftRenderer.
    extern fn pango_xft_renderer_set_default_color(p_xftrenderer: *Renderer, p_default_color: *pango.Color) void;
    pub const setDefaultColor = pango_xft_renderer_set_default_color;

    /// Sets the XftDraw object that the renderer is drawing to.
    /// The renderer must not be currently active.
    extern fn pango_xft_renderer_set_draw(p_xftrenderer: *Renderer, p_draw: *xft.Draw) void;
    pub const setDraw = pango_xft_renderer_set_draw;

    extern fn pango_xft_renderer_get_type() usize;
    pub const getGObjectType = pango_xft_renderer_get_type;

    extern fn g_object_ref(p_self: *pangoxft.Renderer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pangoxft.Renderer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Renderer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The class structure for `PangoXftRenderer`
pub const RendererClass = extern struct {
    pub const Instance = pangoxft.Renderer;

    f_parent_class: pango.RendererClass,
    /// draw the specified trapezoids using
    ///   the current color and other attributes for `part`
    f_composite_trapezoids: ?*const fn (p_xftrenderer: *pangoxft.Renderer, p_part: pango.RenderPart, p_trapezoids: *xlib.XTrapezoid, p_n_trapezoids: c_int) callconv(.c) void,
    /// draw the specified glyphs using
    ///   the current foreground color and other foreground
    ///   attributes
    f_composite_glyphs: ?*const fn (p_xftrenderer: *pangoxft.Renderer, p_xft_font: *xft.Font, p_glyphs: *xft.GlyphSpec, p_n_glyphs: c_int) callconv(.c) void,

    pub fn as(p_instance: *RendererClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RendererPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Retrieves a `PangoContext` appropriate for rendering with
/// Xft fonts on the given screen of the given display.
extern fn pango_xft_get_context(p_display: *xlib.Display, p_screen: c_int) *pango.Context;
pub const getContext = pango_xft_get_context;

/// Returns the `PangoXftFontMap` for the given display and screen.
/// The fontmap is owned by Pango and will be valid until
/// the display is closed.
extern fn pango_xft_get_font_map(p_display: *xlib.Display, p_screen: c_int) *pango.FontMap;
pub const getFontMap = pango_xft_get_font_map;

/// Renders a `PangoGlyphString` onto an Xrender Picture object.
extern fn pango_xft_picture_render(p_display: *xlib.Display, p_src_picture: xlib.Picture, p_dest_picture: xlib.Picture, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) void;
pub const pictureRender = pango_xft_picture_render;

/// Renders a `PangoGlyphString` onto an XftDraw object wrapping an X drawable.
extern fn pango_xft_render(p_draw: *xft.Draw, p_color: *xft.Color, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) void;
pub const render = pango_xft_render;

/// Render a `PangoLayout` onto a XftDraw
extern fn pango_xft_render_layout(p_draw: *xft.Draw, p_color: *xft.Color, p_layout: *pango.Layout, p_x: c_int, p_y: c_int) void;
pub const renderLayout = pango_xft_render_layout;

/// Render a `PangoLayoutLine` onto a XftDraw
extern fn pango_xft_render_layout_line(p_draw: *xft.Draw, p_color: *xft.Color, p_line: *pango.LayoutLine, p_x: c_int, p_y: c_int) void;
pub const renderLayoutLine = pango_xft_render_layout_line;

/// Renders a `PangoGlyphString` onto a XftDraw, possibly
/// transforming the layed-out coordinates through a transformation
/// matrix.
///
/// Note that the transformation matrix for `font` is not
/// changed, so to produce correct rendering results, the `font`
/// must have been loaded using a `PangoContext` with an identical
/// transformation matrix to that passed in to this function.
extern fn pango_xft_render_transformed(p_draw: *xft.Draw, p_color: *xft.Color, p_matrix: ?*pango.Matrix, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) void;
pub const renderTransformed = pango_xft_render_transformed;

/// Sets a function that will be called to do final configuration
/// substitution on a `fontconfig.Pattern` before it is used to load
/// the font. This function can be used to do things like set
/// hinting and antialiasing options.
extern fn pango_xft_set_default_substitute(p_display: *xlib.Display, p_screen: c_int, p_func: pangoxft.SubstituteFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) void;
pub const setDefaultSubstitute = pango_xft_set_default_substitute;

/// Release any resources that have been cached for the
/// combination of `display` and `screen`. Note that when the
/// X display is closed, resources are released automatically,
/// without needing to call this function.
extern fn pango_xft_shutdown_display(p_display: *xlib.Display, p_screen: c_int) void;
pub const shutdownDisplay = pango_xft_shutdown_display;

/// Call this function any time the results of the
/// default substitution function set with
/// `pangoxft.setDefaultSubstitute` change.
/// That is, if your substitution function will return different
/// results for the same input pattern, you must call this function.
extern fn pango_xft_substitute_changed(p_display: *xlib.Display, p_screen: c_int) void;
pub const substituteChanged = pango_xft_substitute_changed;

/// Function type for doing final config tweaking on prepared FcPatterns.
pub const SubstituteFunc = *const fn (p_pattern: *fontconfig.Pattern, p_data: ?*anyopaque) callconv(.c) void;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
