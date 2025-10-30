pub const ext = @import("ext.zig");
const gsk = @This();

const std = @import("std");
const compat = @import("compat");
const graphene = @import("graphene1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gdk = @import("gdk4");
const cairo = @import("cairo1");
const pangocairo = @import("pangocairo1");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const gdkpixbuf = @import("gdkpixbuf2");
/// A render node applying a blending function between its two child nodes.
pub const BlendNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = BlendNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will use `blend_mode` to blend the `top`
    /// node onto the `bottom` node.
    extern fn gsk_blend_node_new(p_bottom: *gsk.RenderNode, p_top: *gsk.RenderNode, p_blend_mode: gsk.BlendMode) *gsk.BlendNode;
    pub const new = gsk_blend_node_new;

    /// Retrieves the blend mode used by `node`.
    extern fn gsk_blend_node_get_blend_mode(p_node: *const BlendNode) gsk.BlendMode;
    pub const getBlendMode = gsk_blend_node_get_blend_mode;

    /// Retrieves the bottom `GskRenderNode` child of the `node`.
    extern fn gsk_blend_node_get_bottom_child(p_node: *const BlendNode) *gsk.RenderNode;
    pub const getBottomChild = gsk_blend_node_get_bottom_child;

    /// Retrieves the top `GskRenderNode` child of the `node`.
    extern fn gsk_blend_node_get_top_child(p_node: *const BlendNode) *gsk.RenderNode;
    pub const getTopChild = gsk_blend_node_get_top_child;

    extern fn gsk_blend_node_get_type() usize;
    pub const getGObjectType = gsk_blend_node_get_type;

    pub fn as(p_instance: *BlendNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node applying a blur effect to its single child.
pub const BlurNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = BlurNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a render node that blurs the child.
    extern fn gsk_blur_node_new(p_child: *gsk.RenderNode, p_radius: f32) *gsk.BlurNode;
    pub const new = gsk_blur_node_new;

    /// Retrieves the child `GskRenderNode` of the blur `node`.
    extern fn gsk_blur_node_get_child(p_node: *const BlurNode) *gsk.RenderNode;
    pub const getChild = gsk_blur_node_get_child;

    /// Retrieves the blur radius of the `node`.
    extern fn gsk_blur_node_get_radius(p_node: *const BlurNode) f32;
    pub const getRadius = gsk_blur_node_get_radius;

    extern fn gsk_blur_node_get_type() usize;
    pub const getGObjectType = gsk_blur_node_get_type;

    pub fn as(p_instance: *BlurNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a border.
pub const BorderNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = BorderNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will stroke a border rectangle inside the
    /// given `outline`.
    ///
    /// The 4 sides of the border can have different widths and colors.
    extern fn gsk_border_node_new(p_outline: *const gsk.RoundedRect, p_border_width: *const [4]f32, p_border_color: *const [4]gdk.RGBA) *gsk.BorderNode;
    pub const new = gsk_border_node_new;

    /// Retrieves the colors of the border.
    extern fn gsk_border_node_get_colors(p_node: *const BorderNode) *const [4]gdk.RGBA;
    pub const getColors = gsk_border_node_get_colors;

    /// Retrieves the outline of the border.
    extern fn gsk_border_node_get_outline(p_node: *const BorderNode) *const gsk.RoundedRect;
    pub const getOutline = gsk_border_node_get_outline;

    /// Retrieves the stroke widths of the border.
    extern fn gsk_border_node_get_widths(p_node: *const BorderNode) *const [4]f32;
    pub const getWidths = gsk_border_node_get_widths;

    extern fn gsk_border_node_get_type() usize;
    pub const getGObjectType = gsk_border_node_get_type;

    pub fn as(p_instance: *BorderNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A Broadway based renderer.
///
/// See `gsk.Renderer`.
pub const BroadwayRenderer = opaque {
    pub const Parent = gsk.Renderer;
    pub const Implements = [_]type{};
    pub const Class = gsk.BroadwayRendererClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new Broadway renderer.
    ///
    /// The Broadway renderer is the default renderer for the broadway backend.
    /// It will only work with broadway surfaces, otherwise it will fail the
    /// call to `gsk.Renderer.realize`.
    ///
    /// This function is only available when GTK was compiled with Broadway
    /// support.
    extern fn gsk_broadway_renderer_new() *gsk.BroadwayRenderer;
    pub const new = gsk_broadway_renderer_new;

    extern fn gsk_broadway_renderer_get_type() usize;
    pub const getGObjectType = gsk_broadway_renderer_get_type;

    extern fn g_object_ref(p_self: *gsk.BroadwayRenderer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gsk.BroadwayRenderer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BroadwayRenderer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a Cairo surface.
pub const CairoNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = CairoNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will render a cairo surface
    /// into the area given by `bounds`.
    ///
    /// You can draw to the cairo surface using `gsk.CairoNode.getDrawContext`.
    extern fn gsk_cairo_node_new(p_bounds: *const graphene.Rect) *gsk.CairoNode;
    pub const new = gsk_cairo_node_new;

    /// Creates a Cairo context for drawing using the surface associated
    /// to the render node.
    ///
    /// If no surface exists yet, a surface will be created optimized for
    /// rendering to `renderer`.
    extern fn gsk_cairo_node_get_draw_context(p_node: *CairoNode) *cairo.Context;
    pub const getDrawContext = gsk_cairo_node_get_draw_context;

    /// Retrieves the Cairo surface used by the render node.
    extern fn gsk_cairo_node_get_surface(p_node: *CairoNode) *cairo.Surface;
    pub const getSurface = gsk_cairo_node_get_surface;

    extern fn gsk_cairo_node_get_type() usize;
    pub const getGObjectType = gsk_cairo_node_get_type;

    pub fn as(p_instance: *CairoNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Renders a GSK rendernode tree with cairo.
///
/// Since it is using cairo, this renderer cannot support
/// 3D transformations.
pub const CairoRenderer = opaque {
    pub const Parent = gsk.Renderer;
    pub const Implements = [_]type{};
    pub const Class = gsk.CairoRendererClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new Cairo renderer.
    ///
    /// The Cairo renderer is the fallback renderer drawing in ways similar
    /// to how GTK 3 drew its content. Its primary use is as comparison tool.
    ///
    /// The Cairo renderer is incomplete. It cannot render 3D transformed
    /// content and will instead render an error marker. Its usage should be
    /// avoided.
    extern fn gsk_cairo_renderer_new() *gsk.CairoRenderer;
    pub const new = gsk_cairo_renderer_new;

    extern fn gsk_cairo_renderer_get_type() usize;
    pub const getGObjectType = gsk_cairo_renderer_get_type;

    extern fn g_object_ref(p_self: *gsk.CairoRenderer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gsk.CairoRenderer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CairoRenderer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node applying a rectangular clip to its single child node.
pub const ClipNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ClipNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will clip the `child` to the area
    /// given by `clip`.
    extern fn gsk_clip_node_new(p_child: *gsk.RenderNode, p_clip: *const graphene.Rect) *gsk.ClipNode;
    pub const new = gsk_clip_node_new;

    /// Gets the child node that is getting clipped by the given `node`.
    extern fn gsk_clip_node_get_child(p_node: *const ClipNode) *gsk.RenderNode;
    pub const getChild = gsk_clip_node_get_child;

    /// Retrieves the clip rectangle for `node`.
    extern fn gsk_clip_node_get_clip(p_node: *const ClipNode) *const graphene.Rect;
    pub const getClip = gsk_clip_node_get_clip;

    extern fn gsk_clip_node_get_type() usize;
    pub const getGObjectType = gsk_clip_node_get_type;

    pub fn as(p_instance: *ClipNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node controlling the color matrix of its single child node.
pub const ColorMatrixNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ColorMatrixNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will drawn the `child` with
    /// `color_matrix`.
    ///
    /// In particular, the node will transform colors by applying
    ///
    ///     pixel = transpose(color_matrix) * pixel + color_offset
    ///
    /// for every pixel. The transformation operates on unpremultiplied
    /// colors, with color components ordered R, G, B, A.
    extern fn gsk_color_matrix_node_new(p_child: *gsk.RenderNode, p_color_matrix: *const graphene.Matrix, p_color_offset: *const graphene.Vec4) *gsk.ColorMatrixNode;
    pub const new = gsk_color_matrix_node_new;

    /// Gets the child node that is getting its colors modified by the given `node`.
    extern fn gsk_color_matrix_node_get_child(p_node: *const ColorMatrixNode) *gsk.RenderNode;
    pub const getChild = gsk_color_matrix_node_get_child;

    /// Retrieves the color matrix used by the `node`.
    extern fn gsk_color_matrix_node_get_color_matrix(p_node: *const ColorMatrixNode) *const graphene.Matrix;
    pub const getColorMatrix = gsk_color_matrix_node_get_color_matrix;

    /// Retrieves the color offset used by the `node`.
    extern fn gsk_color_matrix_node_get_color_offset(p_node: *const ColorMatrixNode) *const graphene.Vec4;
    pub const getColorOffset = gsk_color_matrix_node_get_color_offset;

    extern fn gsk_color_matrix_node_get_type() usize;
    pub const getGObjectType = gsk_color_matrix_node_get_type;

    pub fn as(p_instance: *ColorMatrixNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a solid color.
pub const ColorNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ColorNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will render the color specified by `rgba` into
    /// the area given by `bounds`.
    extern fn gsk_color_node_new(p_rgba: *const gdk.RGBA, p_bounds: *const graphene.Rect) *gsk.ColorNode;
    pub const new = gsk_color_node_new;

    /// Retrieves the color of the given `node`.
    ///
    /// The value returned by this function will not be correct
    /// if the render node was created for a non-sRGB color.
    extern fn gsk_color_node_get_color(p_node: *const ColorNode) *const gdk.RGBA;
    pub const getColor = gsk_color_node_get_color;

    extern fn gsk_color_node_get_type() usize;
    pub const getGObjectType = gsk_color_node_get_type;

    pub fn as(p_instance: *ColorNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a conic gradient.
pub const ConicGradientNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ConicGradientNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that draws a conic gradient.
    ///
    /// The conic gradient
    /// starts around `center` in the direction of `rotation`. A rotation of 0 means
    /// that the gradient points up. Color stops are then added clockwise.
    extern fn gsk_conic_gradient_node_new(p_bounds: *const graphene.Rect, p_center: *const graphene.Point, p_rotation: f32, p_color_stops: [*]const gsk.ColorStop, p_n_color_stops: usize) *gsk.ConicGradientNode;
    pub const new = gsk_conic_gradient_node_new;

    /// Retrieves the angle for the gradient in radians, normalized in [0, 2 * PI].
    ///
    /// The angle is starting at the top and going clockwise, as expressed
    /// in the css specification:
    ///
    ///     angle = 90 - `gsk.ConicGradientNode.getRotation`
    extern fn gsk_conic_gradient_node_get_angle(p_node: *const ConicGradientNode) f32;
    pub const getAngle = gsk_conic_gradient_node_get_angle;

    /// Retrieves the center pointer for the gradient.
    extern fn gsk_conic_gradient_node_get_center(p_node: *const ConicGradientNode) *const graphene.Point;
    pub const getCenter = gsk_conic_gradient_node_get_center;

    /// Retrieves the color stops in the gradient.
    extern fn gsk_conic_gradient_node_get_color_stops(p_node: *const ConicGradientNode, p_n_stops: ?*usize) [*]const gsk.ColorStop;
    pub const getColorStops = gsk_conic_gradient_node_get_color_stops;

    /// Retrieves the number of color stops in the gradient.
    extern fn gsk_conic_gradient_node_get_n_color_stops(p_node: *const ConicGradientNode) usize;
    pub const getNColorStops = gsk_conic_gradient_node_get_n_color_stops;

    /// Retrieves the rotation for the gradient in degrees.
    extern fn gsk_conic_gradient_node_get_rotation(p_node: *const ConicGradientNode) f32;
    pub const getRotation = gsk_conic_gradient_node_get_rotation;

    extern fn gsk_conic_gradient_node_get_type() usize;
    pub const getGObjectType = gsk_conic_gradient_node_get_type;

    pub fn as(p_instance: *ConicGradientNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node that can contain other render nodes.
pub const ContainerNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ContainerNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `GskRenderNode` instance for holding the given `children`.
    ///
    /// The new node will acquire a reference to each of the children.
    extern fn gsk_container_node_new(p_children: [*]*gsk.RenderNode, p_n_children: c_uint) *gsk.ContainerNode;
    pub const new = gsk_container_node_new;

    /// Gets one of the children of `container`.
    extern fn gsk_container_node_get_child(p_node: *const ContainerNode, p_idx: c_uint) *gsk.RenderNode;
    pub const getChild = gsk_container_node_get_child;

    /// Retrieves the number of direct children of `node`.
    extern fn gsk_container_node_get_n_children(p_node: *const ContainerNode) c_uint;
    pub const getNChildren = gsk_container_node_get_n_children;

    extern fn gsk_container_node_get_type() usize;
    pub const getGObjectType = gsk_container_node_get_type;

    pub fn as(p_instance: *ContainerNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node cross fading between two child nodes.
pub const CrossFadeNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = CrossFadeNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will do a cross-fade between `start` and `end`.
    extern fn gsk_cross_fade_node_new(p_start: *gsk.RenderNode, p_end: *gsk.RenderNode, p_progress: f32) *gsk.CrossFadeNode;
    pub const new = gsk_cross_fade_node_new;

    /// Retrieves the child `GskRenderNode` at the end of the cross-fade.
    extern fn gsk_cross_fade_node_get_end_child(p_node: *const CrossFadeNode) *gsk.RenderNode;
    pub const getEndChild = gsk_cross_fade_node_get_end_child;

    /// Retrieves the progress value of the cross fade.
    extern fn gsk_cross_fade_node_get_progress(p_node: *const CrossFadeNode) f32;
    pub const getProgress = gsk_cross_fade_node_get_progress;

    /// Retrieves the child `GskRenderNode` at the beginning of the cross-fade.
    extern fn gsk_cross_fade_node_get_start_child(p_node: *const CrossFadeNode) *gsk.RenderNode;
    pub const getStartChild = gsk_cross_fade_node_get_start_child;

    extern fn gsk_cross_fade_node_get_type() usize;
    pub const getGObjectType = gsk_cross_fade_node_get_type;

    pub fn as(p_instance: *CrossFadeNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node that emits a debugging message when drawing its
/// child node.
pub const DebugNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DebugNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will add debug information about
    /// the given `child`.
    ///
    /// Adding this node has no visual effect.
    extern fn gsk_debug_node_new(p_child: *gsk.RenderNode, p_message: [*:0]u8) *gsk.DebugNode;
    pub const new = gsk_debug_node_new;

    /// Gets the child node that is getting drawn by the given `node`.
    extern fn gsk_debug_node_get_child(p_node: *const DebugNode) *gsk.RenderNode;
    pub const getChild = gsk_debug_node_get_child;

    /// Gets the debug message that was set on this node
    extern fn gsk_debug_node_get_message(p_node: *const DebugNode) [*:0]const u8;
    pub const getMessage = gsk_debug_node_get_message;

    extern fn gsk_debug_node_get_type() usize;
    pub const getGObjectType = gsk_debug_node_get_type;

    pub fn as(p_instance: *DebugNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node filling the area given by `gsk.Path`
/// and `gsk.FillRule` with the child node.
pub const FillNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = FillNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will fill the `child` in the area
    /// given by `path` and `fill_rule`.
    extern fn gsk_fill_node_new(p_child: *gsk.RenderNode, p_path: *gsk.Path, p_fill_rule: gsk.FillRule) *gsk.FillNode;
    pub const new = gsk_fill_node_new;

    /// Gets the child node that is getting drawn by the given `node`.
    extern fn gsk_fill_node_get_child(p_node: *const FillNode) *gsk.RenderNode;
    pub const getChild = gsk_fill_node_get_child;

    /// Retrieves the fill rule used to determine how the path is filled.
    extern fn gsk_fill_node_get_fill_rule(p_node: *const FillNode) gsk.FillRule;
    pub const getFillRule = gsk_fill_node_get_fill_rule;

    /// Retrieves the path used to describe the area filled with the contents of
    /// the `node`.
    extern fn gsk_fill_node_get_path(p_node: *const FillNode) *gsk.Path;
    pub const getPath = gsk_fill_node_get_path;

    extern fn gsk_fill_node_get_type() usize;
    pub const getGObjectType = gsk_fill_node_get_type;

    pub fn as(p_instance: *FillNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Renders a GSK rendernode tree with OpenGL.
///
/// See `gsk.Renderer`.
pub const GLRenderer = opaque {
    pub const Parent = gsk.Renderer;
    pub const Implements = [_]type{};
    pub const Class = gsk.GLRendererClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates an instance of the GL renderer.
    extern fn gsk_gl_renderer_new() *gsk.GLRenderer;
    pub const new = gsk_gl_renderer_new;

    extern fn gsk_gl_renderer_get_type() usize;
    pub const getGObjectType = gsk_gl_renderer_get_type;

    extern fn g_object_ref(p_self: *gsk.GLRenderer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gsk.GLRenderer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GLRenderer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Implements a fragment shader using GLSL.
///
/// A fragment shader gets the coordinates being rendered as input and
/// produces the pixel values for that particular pixel. Additionally,
/// the shader can declare a set of other input arguments, called
/// uniforms (as they are uniform over all the calls to your shader in
/// each instance of use). A shader can also receive up to 4
/// textures that it can use as input when producing the pixel data.
///
/// `GskGLShader` is usually used with `gtk_snapshot_push_gl_shader`
/// to produce a `gsk.GLShaderNode` in the rendering hierarchy,
/// and then its input textures are constructed by rendering the child
/// nodes to textures before rendering the shader node itself. (You can
/// pass texture nodes as children if you want to directly use a texture
/// as input).
///
/// The actual shader code is GLSL code that gets combined with
/// some other code into the fragment shader. Since the exact
/// capabilities of the GPU driver differs between different OpenGL
/// drivers and hardware, GTK adds some defines that you can use
/// to ensure your GLSL code runs on as many drivers as it can.
///
/// If the OpenGL driver is GLES, then the shader language version
/// is set to 100, and GSK_GLES will be defined in the shader.
///
/// Otherwise, if the OpenGL driver does not support the 3.2 core profile,
/// then the shader will run with language version 110 for GL2 and 130 for GL3,
/// and GSK_LEGACY will be defined in the shader.
///
/// If the OpenGL driver supports the 3.2 code profile, it will be used,
/// the shader language version is set to 150, and GSK_GL3 will be defined
/// in the shader.
///
/// The main function the shader must implement is:
///
/// ```glsl
///  void mainImage(out vec4 fragColor,
///                 in vec2 fragCoord,
///                 in vec2 resolution,
///                 in vec2 uv)
/// ```
///
/// Where the input `fragCoord` is the coordinate of the pixel we're
/// currently rendering, relative to the boundary rectangle that was
/// specified in the `GskGLShaderNode`, and `resolution` is the width and
/// height of that rectangle. This is in the typical GTK coordinate
/// system with the origin in the top left. `uv` contains the u and v
/// coordinates that can be used to index a texture at the
/// corresponding point. These coordinates are in the [0..1]x[0..1]
/// region, with 0, 0 being in the lower left corder (which is typical
/// for OpenGL).
///
/// The output `fragColor` should be a RGBA color (with
/// premultiplied alpha) that will be used as the output for the
/// specified pixel location. Note that this output will be
/// automatically clipped to the clip region of the glshader node.
///
/// In addition to the function arguments the shader can define
/// up to 4 uniforms for textures which must be called u_textureN
/// (i.e. u_texture1 to u_texture4) as well as any custom uniforms
/// you want of types int, uint, bool, float, vec2, vec3 or vec4.
///
/// All textures sources contain premultiplied alpha colors, but if some
/// there are outer sources of colors there is a `gsk_premultiply` helper
/// to compute premultiplication when needed.
///
/// Note that GTK parses the uniform declarations, so each uniform has to
/// be on a line by itself with no other code, like so:
///
/// ```glsl
/// uniform float u_time;
/// uniform vec3 u_color;
/// uniform sampler2D u_texture1;
/// uniform sampler2D u_texture2;
/// ```
///
/// GTK uses the "gsk" namespace in the symbols it uses in the
/// shader, so your code should not use any symbols with the prefix gsk
/// or GSK. There are some helper functions declared that you can use:
///
/// ```glsl
/// vec4 GskTexture(sampler2D sampler, vec2 texCoords);
/// ```
///
/// This samples a texture (e.g. u_texture1) at the specified
/// coordinates, and contains some helper ifdefs to ensure that
/// it works on all OpenGL versions.
///
/// You can compile the shader yourself using `gsk.GLShader.compile`,
/// otherwise the GSK renderer will do it when it handling the glshader
/// node. If errors occurs, the returned `error` will include the glsl
/// sources, so you can see what GSK was passing to the compiler. You
/// can also set GSK_DEBUG=shaders in the environment to see the sources
/// and other relevant information about all shaders that GSK is handling.
///
/// # An example shader
///
/// ```glsl
/// uniform float position;
/// uniform sampler2D u_texture1;
/// uniform sampler2D u_texture2;
///
/// void mainImage(out vec4 fragColor,
///                in vec2 fragCoord,
///                in vec2 resolution,
///                in vec2 uv) {
///   vec4 source1 = GskTexture(u_texture1, uv);
///   vec4 source2 = GskTexture(u_texture2, uv);
///
///   fragColor = position * source1 + (1.0 - position) * source2;
/// }
/// ```
pub const GLShader = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gsk.GLShaderClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Resource containing the source code for the shader.
        ///
        /// If the shader source is not coming from a resource, this
        /// will be `NULL`.
        pub const resource = struct {
            pub const name = "resource";

            pub const Type = ?[*:0]u8;
        };

        /// The source code for the shader, as a `GBytes`.
        pub const source = struct {
            pub const name = "source";

            pub const Type = ?*glib.Bytes;
        };
    };

    pub const signals = struct {};

    /// Creates a `GskGLShader` that will render pixels using the specified code.
    extern fn gsk_gl_shader_new_from_bytes(p_sourcecode: *glib.Bytes) *gsk.GLShader;
    pub const newFromBytes = gsk_gl_shader_new_from_bytes;

    /// Creates a `GskGLShader` that will render pixels using the specified code.
    extern fn gsk_gl_shader_new_from_resource(p_resource_path: [*:0]const u8) *gsk.GLShader;
    pub const newFromResource = gsk_gl_shader_new_from_resource;

    /// Tries to compile the `shader` for the given `renderer`.
    ///
    /// If there is a problem, this function returns `FALSE` and reports
    /// an error. You should use this function before relying on the shader
    /// for rendering and use a fallback with a simpler shader or without
    /// shaders if it fails.
    ///
    /// Note that this will modify the rendering state (for example
    /// change the current GL context) and requires the renderer to be
    /// set up. This means that the widget has to be realized. Commonly you
    /// want to call this from the realize signal of a widget, or during
    /// widget snapshot.
    extern fn gsk_gl_shader_compile(p_shader: *GLShader, p_renderer: *gsk.Renderer, p_error: ?*?*glib.Error) c_int;
    pub const compile = gsk_gl_shader_compile;

    /// Looks for a uniform by the name `name`, and returns the index
    /// of the uniform, or -1 if it was not found.
    extern fn gsk_gl_shader_find_uniform_by_name(p_shader: *GLShader, p_name: [*:0]const u8) c_int;
    pub const findUniformByName = gsk_gl_shader_find_uniform_by_name;

    /// Formats the uniform data as needed for feeding the named uniforms
    /// values into the shader.
    ///
    /// The argument list is a list of pairs of names, and values for the types
    /// that match the declared uniforms (i.e. double/int/guint/gboolean for
    /// primitive values and `graphene_vecN_t *` for vecN uniforms).
    ///
    /// Any uniforms of the shader that are not included in the argument list
    /// are zero-initialized.
    extern fn gsk_gl_shader_format_args(p_shader: *GLShader, ...) *glib.Bytes;
    pub const formatArgs = gsk_gl_shader_format_args;

    /// Formats the uniform data as needed for feeding the named uniforms
    /// values into the shader.
    ///
    /// The argument list is a list of pairs of names, and values for the
    /// types that match the declared uniforms (i.e. double/int/guint/gboolean
    /// for primitive values and `graphene_vecN_t *` for vecN uniforms).
    ///
    /// It is an error to pass a uniform name that is not declared by the shader.
    ///
    /// Any uniforms of the shader that are not included in the argument list
    /// are zero-initialized.
    extern fn gsk_gl_shader_format_args_va(p_shader: *GLShader, p_uniforms: std.builtin.VaList) *glib.Bytes;
    pub const formatArgsVa = gsk_gl_shader_format_args_va;

    /// Gets the value of the uniform `idx` in the `args` block.
    ///
    /// The uniform must be of bool type.
    extern fn gsk_gl_shader_get_arg_bool(p_shader: *GLShader, p_args: *glib.Bytes, p_idx: c_int) c_int;
    pub const getArgBool = gsk_gl_shader_get_arg_bool;

    /// Gets the value of the uniform `idx` in the `args` block.
    ///
    /// The uniform must be of float type.
    extern fn gsk_gl_shader_get_arg_float(p_shader: *GLShader, p_args: *glib.Bytes, p_idx: c_int) f32;
    pub const getArgFloat = gsk_gl_shader_get_arg_float;

    /// Gets the value of the uniform `idx` in the `args` block.
    ///
    /// The uniform must be of int type.
    extern fn gsk_gl_shader_get_arg_int(p_shader: *GLShader, p_args: *glib.Bytes, p_idx: c_int) i32;
    pub const getArgInt = gsk_gl_shader_get_arg_int;

    /// Gets the value of the uniform `idx` in the `args` block.
    ///
    /// The uniform must be of uint type.
    extern fn gsk_gl_shader_get_arg_uint(p_shader: *GLShader, p_args: *glib.Bytes, p_idx: c_int) u32;
    pub const getArgUint = gsk_gl_shader_get_arg_uint;

    /// Gets the value of the uniform `idx` in the `args` block.
    ///
    /// The uniform must be of vec2 type.
    extern fn gsk_gl_shader_get_arg_vec2(p_shader: *GLShader, p_args: *glib.Bytes, p_idx: c_int, p_out_value: *graphene.Vec2) void;
    pub const getArgVec2 = gsk_gl_shader_get_arg_vec2;

    /// Gets the value of the uniform `idx` in the `args` block.
    ///
    /// The uniform must be of vec3 type.
    extern fn gsk_gl_shader_get_arg_vec3(p_shader: *GLShader, p_args: *glib.Bytes, p_idx: c_int, p_out_value: *graphene.Vec3) void;
    pub const getArgVec3 = gsk_gl_shader_get_arg_vec3;

    /// Gets the value of the uniform `idx` in the `args` block.
    ///
    /// The uniform must be of vec4 type.
    extern fn gsk_gl_shader_get_arg_vec4(p_shader: *GLShader, p_args: *glib.Bytes, p_idx: c_int, p_out_value: *graphene.Vec4) void;
    pub const getArgVec4 = gsk_gl_shader_get_arg_vec4;

    /// Get the size of the data block used to specify arguments for this shader.
    extern fn gsk_gl_shader_get_args_size(p_shader: *GLShader) usize;
    pub const getArgsSize = gsk_gl_shader_get_args_size;

    /// Returns the number of textures that the shader requires.
    ///
    /// This can be used to check that the a passed shader works
    /// in your usecase. It is determined by looking at the highest
    /// u_textureN value that the shader defines.
    extern fn gsk_gl_shader_get_n_textures(p_shader: *GLShader) c_int;
    pub const getNTextures = gsk_gl_shader_get_n_textures;

    /// Get the number of declared uniforms for this shader.
    extern fn gsk_gl_shader_get_n_uniforms(p_shader: *GLShader) c_int;
    pub const getNUniforms = gsk_gl_shader_get_n_uniforms;

    /// Gets the resource path for the GLSL sourcecode being used
    /// to render this shader.
    extern fn gsk_gl_shader_get_resource(p_shader: *GLShader) ?[*:0]const u8;
    pub const getResource = gsk_gl_shader_get_resource;

    /// Gets the GLSL sourcecode being used to render this shader.
    extern fn gsk_gl_shader_get_source(p_shader: *GLShader) *glib.Bytes;
    pub const getSource = gsk_gl_shader_get_source;

    /// Get the name of the declared uniform for this shader at index `idx`.
    extern fn gsk_gl_shader_get_uniform_name(p_shader: *GLShader, p_idx: c_int) [*:0]const u8;
    pub const getUniformName = gsk_gl_shader_get_uniform_name;

    /// Get the offset into the data block where data for this uniforms is stored.
    extern fn gsk_gl_shader_get_uniform_offset(p_shader: *GLShader, p_idx: c_int) c_int;
    pub const getUniformOffset = gsk_gl_shader_get_uniform_offset;

    /// Get the type of the declared uniform for this shader at index `idx`.
    extern fn gsk_gl_shader_get_uniform_type(p_shader: *GLShader, p_idx: c_int) gsk.GLUniformType;
    pub const getUniformType = gsk_gl_shader_get_uniform_type;

    extern fn gsk_gl_shader_get_type() usize;
    pub const getGObjectType = gsk_gl_shader_get_type;

    extern fn g_object_ref(p_self: *gsk.GLShader) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gsk.GLShader) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GLShader, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node using a GL shader when drawing its children nodes.
pub const GLShaderNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = GLShaderNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will render the given `shader` into the
    /// area given by `bounds`.
    ///
    /// The `args` is a block of data to use for uniform input, as per types and
    /// offsets defined by the `shader`. Normally this is generated by
    /// `gsk.GLShader.formatArgs` or `gsk.ShaderArgsBuilder`.
    ///
    /// See `gsk.GLShader` for details about how the shader should be written.
    ///
    /// All the children will be rendered into textures (if they aren't already
    /// `GskTextureNodes`, which will be used directly). These textures will be
    /// sent as input to the shader.
    ///
    /// If the renderer doesn't support GL shaders, or if there is any problem
    /// when compiling the shader, then the node will draw pink. You should use
    /// `gsk.GLShader.compile` to ensure the `shader` will work for the
    /// renderer before using it.
    extern fn gsk_gl_shader_node_new(p_shader: *gsk.GLShader, p_bounds: *const graphene.Rect, p_args: *glib.Bytes, p_children: ?[*]*gsk.RenderNode, p_n_children: c_uint) *gsk.GLShaderNode;
    pub const new = gsk_gl_shader_node_new;

    /// Gets args for the node.
    extern fn gsk_gl_shader_node_get_args(p_node: *const GLShaderNode) *glib.Bytes;
    pub const getArgs = gsk_gl_shader_node_get_args;

    /// Gets one of the children.
    extern fn gsk_gl_shader_node_get_child(p_node: *const GLShaderNode, p_idx: c_uint) *gsk.RenderNode;
    pub const getChild = gsk_gl_shader_node_get_child;

    /// Returns the number of children
    extern fn gsk_gl_shader_node_get_n_children(p_node: *const GLShaderNode) c_uint;
    pub const getNChildren = gsk_gl_shader_node_get_n_children;

    /// Gets shader code for the node.
    extern fn gsk_gl_shader_node_get_shader(p_node: *const GLShaderNode) *gsk.GLShader;
    pub const getShader = gsk_gl_shader_node_get_shader;

    extern fn gsk_gl_shader_node_get_type() usize;
    pub const getGObjectType = gsk_gl_shader_node_get_type;

    pub fn as(p_instance: *GLShaderNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for an inset shadow.
pub const InsetShadowNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = InsetShadowNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will render an inset shadow
    /// into the box given by `outline`.
    extern fn gsk_inset_shadow_node_new(p_outline: *const gsk.RoundedRect, p_color: *const gdk.RGBA, p_dx: f32, p_dy: f32, p_spread: f32, p_blur_radius: f32) *gsk.InsetShadowNode;
    pub const new = gsk_inset_shadow_node_new;

    /// Retrieves the blur radius to apply to the shadow.
    extern fn gsk_inset_shadow_node_get_blur_radius(p_node: *const InsetShadowNode) f32;
    pub const getBlurRadius = gsk_inset_shadow_node_get_blur_radius;

    /// Retrieves the color of the inset shadow.
    ///
    /// The value returned by this function will not be correct
    /// if the render node was created for a non-sRGB color.
    extern fn gsk_inset_shadow_node_get_color(p_node: *const InsetShadowNode) *const gdk.RGBA;
    pub const getColor = gsk_inset_shadow_node_get_color;

    /// Retrieves the horizontal offset of the inset shadow.
    extern fn gsk_inset_shadow_node_get_dx(p_node: *const InsetShadowNode) f32;
    pub const getDx = gsk_inset_shadow_node_get_dx;

    /// Retrieves the vertical offset of the inset shadow.
    extern fn gsk_inset_shadow_node_get_dy(p_node: *const InsetShadowNode) f32;
    pub const getDy = gsk_inset_shadow_node_get_dy;

    /// Retrieves the outline rectangle of the inset shadow.
    extern fn gsk_inset_shadow_node_get_outline(p_node: *const InsetShadowNode) *const gsk.RoundedRect;
    pub const getOutline = gsk_inset_shadow_node_get_outline;

    /// Retrieves how much the shadow spreads inwards.
    extern fn gsk_inset_shadow_node_get_spread(p_node: *const InsetShadowNode) f32;
    pub const getSpread = gsk_inset_shadow_node_get_spread;

    extern fn gsk_inset_shadow_node_get_type() usize;
    pub const getGObjectType = gsk_inset_shadow_node_get_type;

    pub fn as(p_instance: *InsetShadowNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a linear gradient.
pub const LinearGradientNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = LinearGradientNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will create a linear gradient from the given
    /// points and color stops, and render that into the area given by `bounds`.
    extern fn gsk_linear_gradient_node_new(p_bounds: *const graphene.Rect, p_start: *const graphene.Point, p_end: *const graphene.Point, p_color_stops: [*]const gsk.ColorStop, p_n_color_stops: usize) *gsk.LinearGradientNode;
    pub const new = gsk_linear_gradient_node_new;

    /// Retrieves the color stops in the gradient.
    extern fn gsk_linear_gradient_node_get_color_stops(p_node: *const LinearGradientNode, p_n_stops: ?*usize) [*]const gsk.ColorStop;
    pub const getColorStops = gsk_linear_gradient_node_get_color_stops;

    /// Retrieves the final point of the linear gradient.
    extern fn gsk_linear_gradient_node_get_end(p_node: *const LinearGradientNode) *const graphene.Point;
    pub const getEnd = gsk_linear_gradient_node_get_end;

    /// Retrieves the number of color stops in the gradient.
    extern fn gsk_linear_gradient_node_get_n_color_stops(p_node: *const LinearGradientNode) usize;
    pub const getNColorStops = gsk_linear_gradient_node_get_n_color_stops;

    /// Retrieves the initial point of the linear gradient.
    extern fn gsk_linear_gradient_node_get_start(p_node: *const LinearGradientNode) *const graphene.Point;
    pub const getStart = gsk_linear_gradient_node_get_start;

    extern fn gsk_linear_gradient_node_get_type() usize;
    pub const getGObjectType = gsk_linear_gradient_node_get_type;

    pub fn as(p_instance: *LinearGradientNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node masking one child node with another.
pub const MaskNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = MaskNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will mask a given node by another.
    ///
    /// The `mask_mode` determines how the 'mask values' are derived from
    /// the colors of the `mask`. Applying the mask consists of multiplying
    /// the 'mask value' with the alpha of the source.
    extern fn gsk_mask_node_new(p_source: *gsk.RenderNode, p_mask: *gsk.RenderNode, p_mask_mode: gsk.MaskMode) *gsk.MaskNode;
    pub const new = gsk_mask_node_new;

    /// Retrieves the mask `GskRenderNode` child of the `node`.
    extern fn gsk_mask_node_get_mask(p_node: *const MaskNode) *gsk.RenderNode;
    pub const getMask = gsk_mask_node_get_mask;

    /// Retrieves the mask mode used by `node`.
    extern fn gsk_mask_node_get_mask_mode(p_node: *const MaskNode) gsk.MaskMode;
    pub const getMaskMode = gsk_mask_node_get_mask_mode;

    /// Retrieves the source `GskRenderNode` child of the `node`.
    extern fn gsk_mask_node_get_source(p_node: *const MaskNode) *gsk.RenderNode;
    pub const getSource = gsk_mask_node_get_source;

    extern fn gsk_mask_node_get_type() usize;
    pub const getGObjectType = gsk_mask_node_get_type;

    pub fn as(p_instance: *MaskNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A GL based renderer.
///
/// See `gsk.Renderer`.
pub const NglRenderer = opaque {
    pub const Parent = gsk.Renderer;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = NglRenderer;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Same as `gsk.GLRenderer.new`.
    extern fn gsk_ngl_renderer_new() *gsk.NglRenderer;
    pub const new = gsk_ngl_renderer_new;

    extern fn gsk_ngl_renderer_get_type() usize;
    pub const getGObjectType = gsk_ngl_renderer_get_type;

    extern fn g_object_ref(p_self: *gsk.NglRenderer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gsk.NglRenderer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NglRenderer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node controlling the opacity of its single child node.
pub const OpacityNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = OpacityNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will drawn the `child` with reduced
    /// `opacity`.
    extern fn gsk_opacity_node_new(p_child: *gsk.RenderNode, p_opacity: f32) *gsk.OpacityNode;
    pub const new = gsk_opacity_node_new;

    /// Gets the child node that is getting opacityed by the given `node`.
    extern fn gsk_opacity_node_get_child(p_node: *const OpacityNode) *gsk.RenderNode;
    pub const getChild = gsk_opacity_node_get_child;

    /// Gets the transparency factor for an opacity node.
    extern fn gsk_opacity_node_get_opacity(p_node: *const OpacityNode) f32;
    pub const getOpacity = gsk_opacity_node_get_opacity;

    extern fn gsk_opacity_node_get_type() usize;
    pub const getGObjectType = gsk_opacity_node_get_type;

    pub fn as(p_instance: *OpacityNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for an outset shadow.
pub const OutsetShadowNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = OutsetShadowNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will render an outset shadow
    /// around the box given by `outline`.
    extern fn gsk_outset_shadow_node_new(p_outline: *const gsk.RoundedRect, p_color: *const gdk.RGBA, p_dx: f32, p_dy: f32, p_spread: f32, p_blur_radius: f32) *gsk.OutsetShadowNode;
    pub const new = gsk_outset_shadow_node_new;

    /// Retrieves the blur radius of the shadow.
    extern fn gsk_outset_shadow_node_get_blur_radius(p_node: *const OutsetShadowNode) f32;
    pub const getBlurRadius = gsk_outset_shadow_node_get_blur_radius;

    /// Retrieves the color of the outset shadow.
    ///
    /// The value returned by this function will not be correct
    /// if the render node was created for a non-sRGB color.
    extern fn gsk_outset_shadow_node_get_color(p_node: *const OutsetShadowNode) *const gdk.RGBA;
    pub const getColor = gsk_outset_shadow_node_get_color;

    /// Retrieves the horizontal offset of the outset shadow.
    extern fn gsk_outset_shadow_node_get_dx(p_node: *const OutsetShadowNode) f32;
    pub const getDx = gsk_outset_shadow_node_get_dx;

    /// Retrieves the vertical offset of the outset shadow.
    extern fn gsk_outset_shadow_node_get_dy(p_node: *const OutsetShadowNode) f32;
    pub const getDy = gsk_outset_shadow_node_get_dy;

    /// Retrieves the outline rectangle of the outset shadow.
    extern fn gsk_outset_shadow_node_get_outline(p_node: *const OutsetShadowNode) *const gsk.RoundedRect;
    pub const getOutline = gsk_outset_shadow_node_get_outline;

    /// Retrieves how much the shadow spreads outwards.
    extern fn gsk_outset_shadow_node_get_spread(p_node: *const OutsetShadowNode) f32;
    pub const getSpread = gsk_outset_shadow_node_get_spread;

    extern fn gsk_outset_shadow_node_get_type() usize;
    pub const getGObjectType = gsk_outset_shadow_node_get_type;

    pub fn as(p_instance: *OutsetShadowNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a radial gradient.
pub const RadialGradientNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = RadialGradientNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that draws a radial gradient.
    ///
    /// The radial gradient
    /// starts around `center`. The size of the gradient is dictated by `hradius`
    /// in horizontal orientation and by `vradius` in vertical orientation.
    extern fn gsk_radial_gradient_node_new(p_bounds: *const graphene.Rect, p_center: *const graphene.Point, p_hradius: f32, p_vradius: f32, p_start: f32, p_end: f32, p_color_stops: [*]const gsk.ColorStop, p_n_color_stops: usize) *gsk.RadialGradientNode;
    pub const new = gsk_radial_gradient_node_new;

    /// Retrieves the center pointer for the gradient.
    extern fn gsk_radial_gradient_node_get_center(p_node: *const RadialGradientNode) *const graphene.Point;
    pub const getCenter = gsk_radial_gradient_node_get_center;

    /// Retrieves the color stops in the gradient.
    extern fn gsk_radial_gradient_node_get_color_stops(p_node: *const RadialGradientNode, p_n_stops: ?*usize) [*]const gsk.ColorStop;
    pub const getColorStops = gsk_radial_gradient_node_get_color_stops;

    /// Retrieves the end value for the gradient.
    extern fn gsk_radial_gradient_node_get_end(p_node: *const RadialGradientNode) f32;
    pub const getEnd = gsk_radial_gradient_node_get_end;

    /// Retrieves the horizontal radius for the gradient.
    extern fn gsk_radial_gradient_node_get_hradius(p_node: *const RadialGradientNode) f32;
    pub const getHradius = gsk_radial_gradient_node_get_hradius;

    /// Retrieves the number of color stops in the gradient.
    extern fn gsk_radial_gradient_node_get_n_color_stops(p_node: *const RadialGradientNode) usize;
    pub const getNColorStops = gsk_radial_gradient_node_get_n_color_stops;

    /// Retrieves the start value for the gradient.
    extern fn gsk_radial_gradient_node_get_start(p_node: *const RadialGradientNode) f32;
    pub const getStart = gsk_radial_gradient_node_get_start;

    /// Retrieves the vertical radius for the gradient.
    extern fn gsk_radial_gradient_node_get_vradius(p_node: *const RadialGradientNode) f32;
    pub const getVradius = gsk_radial_gradient_node_get_vradius;

    extern fn gsk_radial_gradient_node_get_type() usize;
    pub const getGObjectType = gsk_radial_gradient_node_get_type;

    pub fn as(p_instance: *RadialGradientNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The basic block in a scene graph to be rendered using `gsk.Renderer`.
///
/// Each node has a parent, except the top-level node; each node may have
/// children nodes.
///
/// Each node has an associated drawing surface, which has the size of
/// the rectangle set when creating it.
///
/// Render nodes are meant to be transient; once they have been associated
/// to a `gsk.Renderer` it's safe to release any reference you have on
/// them. All `gsk.RenderNode`s are immutable, you can only specify their
/// properties during construction.
pub const RenderNode = opaque {
    pub const Parent = gobject.TypeInstance;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = RenderNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Loads data previously created via `gsk.RenderNode.serialize`.
    ///
    /// For a discussion of the supported format, see that function.
    extern fn gsk_render_node_deserialize(p_bytes: *glib.Bytes, p_error_func: ?gsk.ParseErrorFunc, p_user_data: ?*anyopaque) ?*gsk.RenderNode;
    pub const deserialize = gsk_render_node_deserialize;

    /// Draws the contents of a render node on a cairo context.
    ///
    /// Typically, you'll use this function to implement fallback rendering
    /// of render nodes on an intermediate Cairo context, instead of using
    /// the drawing context associated to a `gdk.Surface`'s rendering buffer.
    ///
    /// For advanced nodes that cannot be supported using Cairo, in particular
    /// for nodes doing 3D operations, this function may fail.
    extern fn gsk_render_node_draw(p_node: *RenderNode, p_cr: *cairo.Context) void;
    pub const draw = gsk_render_node_draw;

    /// Retrieves the boundaries of the `node`.
    ///
    /// The node will not draw outside of its boundaries.
    extern fn gsk_render_node_get_bounds(p_node: *RenderNode, p_bounds: *graphene.Rect) void;
    pub const getBounds = gsk_render_node_get_bounds;

    /// Returns the type of the render node.
    extern fn gsk_render_node_get_node_type(p_node: *const RenderNode) gsk.RenderNodeType;
    pub const getNodeType = gsk_render_node_get_node_type;

    /// Gets an opaque rectangle inside the node that GTK can determine to
    /// be fully opaque.
    ///
    /// There is no guarantee that this is indeed the largest opaque rectangle or
    /// that regions outside the rectangle are not opaque. This function is a best
    /// effort with that goal.
    ///
    /// The rectangle will be fully contained in the bounds of the node.
    extern fn gsk_render_node_get_opaque_rect(p_self: *RenderNode, p_out_opaque: *graphene.Rect) c_int;
    pub const getOpaqueRect = gsk_render_node_get_opaque_rect;

    /// Acquires a reference on the given `GskRenderNode`.
    extern fn gsk_render_node_ref(p_node: *RenderNode) *gsk.RenderNode;
    pub const ref = gsk_render_node_ref;

    /// Serializes the `node` for later deserialization via
    /// `gsk.RenderNode.deserialize`. No guarantees are made about the format
    /// used other than that the same version of GTK will be able to deserialize
    /// the result of a call to `gsk.RenderNode.serialize` and
    /// `gsk.RenderNode.deserialize` will correctly reject files it cannot open
    /// that were created with previous versions of GTK.
    ///
    /// The intended use of this functions is testing, benchmarking and debugging.
    /// The format is not meant as a permanent storage format.
    extern fn gsk_render_node_serialize(p_node: *RenderNode) *glib.Bytes;
    pub const serialize = gsk_render_node_serialize;

    /// Releases a reference on the given `GskRenderNode`.
    ///
    /// If the reference was the last, the resources associated to the `node` are
    /// freed.
    extern fn gsk_render_node_unref(p_node: *RenderNode) void;
    pub const unref = gsk_render_node_unref;

    /// This function is equivalent to calling `gsk.RenderNode.serialize`
    /// followed by `glib.fileSetContents`.
    ///
    /// See those two functions for details on the arguments.
    ///
    /// It is mostly intended for use inside a debugger to quickly dump a render
    /// node to a file for later inspection.
    extern fn gsk_render_node_write_to_file(p_node: *RenderNode, p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const writeToFile = gsk_render_node_write_to_file;

    extern fn gsk_render_node_get_type() usize;
    pub const getGObjectType = gsk_render_node_get_type;

    pub fn as(p_instance: *RenderNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Renders a scene graph defined via a tree of `gsk.RenderNode` instances.
///
/// Typically you will use a `GskRenderer` instance to repeatedly call
/// `gsk.Renderer.render` to update the contents of its associated
/// `gdk.Surface`.
///
/// It is necessary to realize a `GskRenderer` instance using
/// `gsk.Renderer.realize` before calling `gsk.Renderer.render`,
/// in order to create the appropriate windowing system resources needed
/// to render the scene.
pub const Renderer = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gsk.RendererClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the renderer has been associated with a surface or draw context.
        pub const realized = struct {
            pub const name = "realized";

            pub const Type = c_int;
        };

        /// The surface associated with renderer.
        pub const surface = struct {
            pub const name = "surface";

            pub const Type = ?*gdk.Surface;
        };
    };

    pub const signals = struct {};

    /// Creates an appropriate `GskRenderer` instance for the given surface.
    ///
    /// If the `GSK_RENDERER` environment variable is set, GSK will
    /// try that renderer first, before trying the backend-specific
    /// default. The ultimate fallback is the cairo renderer.
    ///
    /// The renderer will be realized before it is returned.
    extern fn gsk_renderer_new_for_surface(p_surface: *gdk.Surface) ?*gsk.Renderer;
    pub const newForSurface = gsk_renderer_new_for_surface;

    /// Retrieves the surface that the renderer is associated with.
    ///
    /// If the renderer has not been realized yet, `NULL` will be returned.
    extern fn gsk_renderer_get_surface(p_renderer: *Renderer) ?*gdk.Surface;
    pub const getSurface = gsk_renderer_get_surface;

    /// Checks whether the renderer is realized or not.
    extern fn gsk_renderer_is_realized(p_renderer: *Renderer) c_int;
    pub const isRealized = gsk_renderer_is_realized;

    /// Creates the resources needed by the renderer.
    ///
    /// Since GTK 4.6, the surface may be `NULL`, which allows using
    /// renderers without having to create a surface. Since GTK 4.14,
    /// it is recommended to use `gsk.Renderer.realizeForDisplay`
    /// for this case.
    ///
    /// Note that it is mandatory to call `gsk.Renderer.unrealize`
    /// before destroying the renderer.
    extern fn gsk_renderer_realize(p_renderer: *Renderer, p_surface: ?*gdk.Surface, p_error: ?*?*glib.Error) c_int;
    pub const realize = gsk_renderer_realize;

    /// Creates the resources needed by the renderer.
    ///
    /// Note that it is mandatory to call `gsk.Renderer.unrealize`
    /// before destroying the renderer.
    extern fn gsk_renderer_realize_for_display(p_renderer: *Renderer, p_display: *gdk.Display, p_error: ?*?*glib.Error) c_int;
    pub const realizeForDisplay = gsk_renderer_realize_for_display;

    /// Renders the scene graph, described by a tree of `GskRenderNode` instances
    /// to the renderer's surface, ensuring that the given region gets redrawn.
    ///
    /// If the renderer has no associated surface, this function does nothing.
    ///
    /// Renderers must ensure that changes of the contents given by the `root`
    /// node as well as the area given by `region` are redrawn. They are however
    /// free to not redraw any pixel outside of `region` if they can guarantee that
    /// it didn't change.
    ///
    /// The renderer will acquire a reference on the `GskRenderNode` tree while
    /// the rendering is in progress.
    extern fn gsk_renderer_render(p_renderer: *Renderer, p_root: *gsk.RenderNode, p_region: ?*const cairo.Region) void;
    pub const render = gsk_renderer_render;

    /// Renders a scene graph, described by a tree of `GskRenderNode` instances,
    /// to a texture.
    ///
    /// The renderer will acquire a reference on the `GskRenderNode` tree while
    /// the rendering is in progress.
    ///
    /// If you want to apply any transformations to `root`, you should put it into a
    /// transform node and pass that node instead.
    extern fn gsk_renderer_render_texture(p_renderer: *Renderer, p_root: *gsk.RenderNode, p_viewport: ?*const graphene.Rect) *gdk.Texture;
    pub const renderTexture = gsk_renderer_render_texture;

    /// Releases all the resources created by `gsk.Renderer.realize`.
    extern fn gsk_renderer_unrealize(p_renderer: *Renderer) void;
    pub const unrealize = gsk_renderer_unrealize;

    extern fn gsk_renderer_get_type() usize;
    pub const getGObjectType = gsk_renderer_get_type;

    extern fn g_object_ref(p_self: *gsk.Renderer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gsk.Renderer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Renderer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node repeating its single child node.
pub const RepeatNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = RepeatNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will repeat the drawing of `child` across
    /// the given `bounds`.
    extern fn gsk_repeat_node_new(p_bounds: *const graphene.Rect, p_child: *gsk.RenderNode, p_child_bounds: ?*const graphene.Rect) *gsk.RepeatNode;
    pub const new = gsk_repeat_node_new;

    /// Retrieves the child of `node`.
    extern fn gsk_repeat_node_get_child(p_node: *const RepeatNode) *gsk.RenderNode;
    pub const getChild = gsk_repeat_node_get_child;

    /// Retrieves the bounding rectangle of the child of `node`.
    extern fn gsk_repeat_node_get_child_bounds(p_node: *const RepeatNode) *const graphene.Rect;
    pub const getChildBounds = gsk_repeat_node_get_child_bounds;

    extern fn gsk_repeat_node_get_type() usize;
    pub const getGObjectType = gsk_repeat_node_get_type;

    pub fn as(p_instance: *RepeatNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a repeating linear gradient.
pub const RepeatingLinearGradientNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = RepeatingLinearGradientNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will create a repeating linear gradient
    /// from the given points and color stops, and render that into the area
    /// given by `bounds`.
    extern fn gsk_repeating_linear_gradient_node_new(p_bounds: *const graphene.Rect, p_start: *const graphene.Point, p_end: *const graphene.Point, p_color_stops: [*]const gsk.ColorStop, p_n_color_stops: usize) *gsk.RepeatingLinearGradientNode;
    pub const new = gsk_repeating_linear_gradient_node_new;

    extern fn gsk_repeating_linear_gradient_node_get_type() usize;
    pub const getGObjectType = gsk_repeating_linear_gradient_node_get_type;

    pub fn as(p_instance: *RepeatingLinearGradientNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a repeating radial gradient.
pub const RepeatingRadialGradientNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = RepeatingRadialGradientNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that draws a repeating radial gradient.
    ///
    /// The radial gradient starts around `center`. The size of the gradient
    /// is dictated by `hradius` in horizontal orientation and by `vradius`
    /// in vertical orientation.
    extern fn gsk_repeating_radial_gradient_node_new(p_bounds: *const graphene.Rect, p_center: *const graphene.Point, p_hradius: f32, p_vradius: f32, p_start: f32, p_end: f32, p_color_stops: [*]const gsk.ColorStop, p_n_color_stops: usize) *gsk.RepeatingRadialGradientNode;
    pub const new = gsk_repeating_radial_gradient_node_new;

    extern fn gsk_repeating_radial_gradient_node_get_type() usize;
    pub const getGObjectType = gsk_repeating_radial_gradient_node_get_type;

    pub fn as(p_instance: *RepeatingRadialGradientNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node applying a rounded rectangle clip to its single child.
pub const RoundedClipNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = RoundedClipNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will clip the `child` to the area
    /// given by `clip`.
    extern fn gsk_rounded_clip_node_new(p_child: *gsk.RenderNode, p_clip: *const gsk.RoundedRect) *gsk.RoundedClipNode;
    pub const new = gsk_rounded_clip_node_new;

    /// Gets the child node that is getting clipped by the given `node`.
    extern fn gsk_rounded_clip_node_get_child(p_node: *const RoundedClipNode) *gsk.RenderNode;
    pub const getChild = gsk_rounded_clip_node_get_child;

    /// Retrieves the rounded rectangle used to clip the contents of the `node`.
    extern fn gsk_rounded_clip_node_get_clip(p_node: *const RoundedClipNode) *const gsk.RoundedRect;
    pub const getClip = gsk_rounded_clip_node_get_clip;

    extern fn gsk_rounded_clip_node_get_type() usize;
    pub const getGObjectType = gsk_rounded_clip_node_get_type;

    pub fn as(p_instance: *RoundedClipNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node drawing one or more shadows behind its single child node.
pub const ShadowNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ShadowNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will draw a `child` with the given
    /// `shadows` below it.
    extern fn gsk_shadow_node_new(p_child: *gsk.RenderNode, p_shadows: [*]const gsk.Shadow, p_n_shadows: usize) *gsk.ShadowNode;
    pub const new = gsk_shadow_node_new;

    /// Retrieves the child `GskRenderNode` of the shadow `node`.
    extern fn gsk_shadow_node_get_child(p_node: *const ShadowNode) *gsk.RenderNode;
    pub const getChild = gsk_shadow_node_get_child;

    /// Retrieves the number of shadows in the `node`.
    extern fn gsk_shadow_node_get_n_shadows(p_node: *const ShadowNode) usize;
    pub const getNShadows = gsk_shadow_node_get_n_shadows;

    /// Retrieves the shadow data at the given index `i`.
    extern fn gsk_shadow_node_get_shadow(p_node: *const ShadowNode, p_i: usize) *const gsk.Shadow;
    pub const getShadow = gsk_shadow_node_get_shadow;

    extern fn gsk_shadow_node_get_type() usize;
    pub const getGObjectType = gsk_shadow_node_get_type;

    pub fn as(p_instance: *ShadowNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node that will fill the area determined by stroking the the given
/// `gsk.Path` using the `gsk.Stroke` attributes.
pub const StrokeNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = StrokeNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `gsk.RenderNode` that will fill the outline generated by stroking
    /// the given `path` using the attributes defined in `stroke`.
    ///
    /// The area is filled with `child`.
    extern fn gsk_stroke_node_new(p_child: *gsk.RenderNode, p_path: *gsk.Path, p_stroke: *const gsk.Stroke) *gsk.StrokeNode;
    pub const new = gsk_stroke_node_new;

    /// Gets the child node that is getting drawn by the given `node`.
    extern fn gsk_stroke_node_get_child(p_node: *const StrokeNode) *gsk.RenderNode;
    pub const getChild = gsk_stroke_node_get_child;

    /// Retrieves the path that will be stroked with the contents of
    /// the `node`.
    extern fn gsk_stroke_node_get_path(p_node: *const StrokeNode) *gsk.Path;
    pub const getPath = gsk_stroke_node_get_path;

    /// Retrieves the stroke attributes used in this `node`.
    extern fn gsk_stroke_node_get_stroke(p_node: *const StrokeNode) *const gsk.Stroke;
    pub const getStroke = gsk_stroke_node_get_stroke;

    extern fn gsk_stroke_node_get_type() usize;
    pub const getGObjectType = gsk_stroke_node_get_type;

    pub fn as(p_instance: *StrokeNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node that potentially diverts a part of the scene graph to a subsurface.
pub const SubsurfaceNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = SubsurfaceNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the subsurface that was set on this node
    extern fn gsk_subsurface_node_get_subsurface(p_node: *const gsk.DebugNode) ?*anyopaque;
    pub const getSubsurface = gsk_subsurface_node_get_subsurface;

    /// Creates a `GskRenderNode` that will possibly divert the child
    /// node to a subsurface.
    ///
    /// Note: Since subsurfaces are currently private, these nodes cannot
    /// currently be created outside of GTK. See
    /// [GtkGraphicsOffload](../gtk4/class.GraphicsOffload.html).
    extern fn gsk_subsurface_node_new(p_child: *gsk.RenderNode, p_subsurface: ?*anyopaque) *gsk.SubsurfaceNode;
    pub const new = gsk_subsurface_node_new;

    /// Gets the child node that is getting drawn by the given `node`.
    extern fn gsk_subsurface_node_get_child(p_node: *const SubsurfaceNode) *gsk.RenderNode;
    pub const getChild = gsk_subsurface_node_get_child;

    extern fn gsk_subsurface_node_get_type() usize;
    pub const getGObjectType = gsk_subsurface_node_get_type;

    pub fn as(p_instance: *SubsurfaceNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node drawing a set of glyphs.
pub const TextNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = TextNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a render node that renders the given glyphs.
    ///
    /// Note that `color` may not be used if the font contains
    /// color glyphs.
    extern fn gsk_text_node_new(p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_color: *const gdk.RGBA, p_offset: *const graphene.Point) ?*gsk.TextNode;
    pub const new = gsk_text_node_new;

    /// Retrieves the color used by the text `node`.
    ///
    /// The value returned by this function will not be correct
    /// if the render node was created for a non-sRGB color.
    extern fn gsk_text_node_get_color(p_node: *const TextNode) *const gdk.RGBA;
    pub const getColor = gsk_text_node_get_color;

    /// Returns the font used by the text `node`.
    extern fn gsk_text_node_get_font(p_node: *const TextNode) *pango.Font;
    pub const getFont = gsk_text_node_get_font;

    /// Retrieves the glyph information in the `node`.
    extern fn gsk_text_node_get_glyphs(p_node: *const TextNode, p_n_glyphs: ?*c_uint) [*]const pango.GlyphInfo;
    pub const getGlyphs = gsk_text_node_get_glyphs;

    /// Retrieves the number of glyphs in the text node.
    extern fn gsk_text_node_get_num_glyphs(p_node: *const TextNode) c_uint;
    pub const getNumGlyphs = gsk_text_node_get_num_glyphs;

    /// Retrieves the offset applied to the text.
    extern fn gsk_text_node_get_offset(p_node: *const TextNode) *const graphene.Point;
    pub const getOffset = gsk_text_node_get_offset;

    /// Checks whether the text `node` has color glyphs.
    extern fn gsk_text_node_has_color_glyphs(p_node: *const TextNode) c_int;
    pub const hasColorGlyphs = gsk_text_node_has_color_glyphs;

    extern fn gsk_text_node_get_type() usize;
    pub const getGObjectType = gsk_text_node_get_type;

    pub fn as(p_instance: *TextNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a `GdkTexture`.
pub const TextureNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = TextureNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will render the given
    /// `texture` into the area given by `bounds`.
    ///
    /// Note that GSK applies linear filtering when textures are
    /// scaled and transformed. See `gsk.TextureScaleNode`
    /// for a way to influence filtering.
    extern fn gsk_texture_node_new(p_texture: *gdk.Texture, p_bounds: *const graphene.Rect) *gsk.TextureNode;
    pub const new = gsk_texture_node_new;

    /// Retrieves the `GdkTexture` used when creating this `GskRenderNode`.
    extern fn gsk_texture_node_get_texture(p_node: *const TextureNode) *gdk.Texture;
    pub const getTexture = gsk_texture_node_get_texture;

    extern fn gsk_texture_node_get_type() usize;
    pub const getGObjectType = gsk_texture_node_get_type;

    pub fn as(p_instance: *TextureNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node for a `GdkTexture`, with control over scaling.
pub const TextureScaleNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = TextureScaleNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a node that scales the texture to the size given by the
    /// bounds using the filter and then places it at the bounds' position.
    ///
    /// Note that further scaling and other transformations which are
    /// applied to the node will apply linear filtering to the resulting
    /// texture, as usual.
    ///
    /// This node is intended for tight control over scaling applied
    /// to a texture, such as in image editors and requires the
    /// application to be aware of the whole render tree as further
    /// transforms may be applied that conflict with the desired effect
    /// of this node.
    extern fn gsk_texture_scale_node_new(p_texture: *gdk.Texture, p_bounds: *const graphene.Rect, p_filter: gsk.ScalingFilter) *gsk.TextureScaleNode;
    pub const new = gsk_texture_scale_node_new;

    /// Retrieves the `GskScalingFilter` used when creating this `GskRenderNode`.
    extern fn gsk_texture_scale_node_get_filter(p_node: *const TextureScaleNode) gsk.ScalingFilter;
    pub const getFilter = gsk_texture_scale_node_get_filter;

    /// Retrieves the `GdkTexture` used when creating this `GskRenderNode`.
    extern fn gsk_texture_scale_node_get_texture(p_node: *const TextureScaleNode) *gdk.Texture;
    pub const getTexture = gsk_texture_scale_node_get_texture;

    extern fn gsk_texture_scale_node_get_type() usize;
    pub const getGObjectType = gsk_texture_scale_node_get_type;

    pub fn as(p_instance: *TextureScaleNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A render node applying a `GskTransform` to its single child node.
pub const TransformNode = opaque {
    pub const Parent = gsk.RenderNode;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = TransformNode;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `GskRenderNode` that will transform the given `child`
    /// with the given `transform`.
    extern fn gsk_transform_node_new(p_child: *gsk.RenderNode, p_transform: *gsk.Transform) *gsk.TransformNode;
    pub const new = gsk_transform_node_new;

    /// Gets the child node that is getting transformed by the given `node`.
    extern fn gsk_transform_node_get_child(p_node: *const TransformNode) *gsk.RenderNode;
    pub const getChild = gsk_transform_node_get_child;

    /// Retrieves the `GskTransform` used by the `node`.
    extern fn gsk_transform_node_get_transform(p_node: *const TransformNode) *gsk.Transform;
    pub const getTransform = gsk_transform_node_get_transform;

    extern fn gsk_transform_node_get_type() usize;
    pub const getGObjectType = gsk_transform_node_get_type;

    pub fn as(p_instance: *TransformNode, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Renders a GSK rendernode tree with Vulkan.
///
/// This renderer will fail to realize if Vulkan is not supported.
pub const VulkanRenderer = opaque {
    pub const Parent = gsk.Renderer;
    pub const Implements = [_]type{};
    pub const Class = gsk.VulkanRendererClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new Vulkan renderer.
    ///
    /// The Vulkan renderer is a renderer that uses the Vulkan library for
    /// rendering.
    ///
    /// This renderer will fail to realize when GTK was not compiled with
    /// Vulkan support.
    extern fn gsk_vulkan_renderer_new() *gsk.VulkanRenderer;
    pub const new = gsk_vulkan_renderer_new;

    extern fn gsk_vulkan_renderer_get_type() usize;
    pub const getGObjectType = gsk_vulkan_renderer_get_type;

    extern fn g_object_ref(p_self: *gsk.VulkanRenderer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gsk.VulkanRenderer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VulkanRenderer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BroadwayRendererClass = opaque {
    pub const Instance = gsk.BroadwayRenderer;

    pub fn as(p_instance: *BroadwayRendererClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CairoRendererClass = opaque {
    pub const Instance = gsk.CairoRenderer;

    pub fn as(p_instance: *CairoRendererClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A color stop in a gradient node.
pub const ColorStop = extern struct {
    /// the offset of the color stop
    f_offset: f32,
    /// the color at the given offset
    f_color: gdk.RGBA,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GLRendererClass = opaque {
    pub const Instance = gsk.GLRenderer;

    pub fn as(p_instance: *GLRendererClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GLShaderClass = extern struct {
    pub const Instance = gsk.GLShader;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *GLShaderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A location in a parse buffer.
pub const ParseLocation = extern struct {
    /// the offset of the location in the parse buffer, as bytes
    f_bytes: usize,
    /// the offset of the location in the parse buffer, as characters
    f_chars: usize,
    /// the line of the location in the parse buffer
    f_lines: usize,
    /// the position in the line, as bytes
    f_line_bytes: usize,
    /// the position in the line, as characters
    f_line_chars: usize,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes lines and curves that are more complex than simple rectangles.
///
/// Paths can used for rendering (filling or stroking) and for animations
/// (e.g. as trajectories).
///
/// `GskPath` is an immutable, opaque, reference-counted struct.
/// After creation, you cannot change the types it represents. Instead,
/// new `GskPath` objects have to be created. The `gsk.PathBuilder`
/// structure is meant to help in this endeavor.
///
/// Conceptually, a path consists of zero or more contours (continuous, connected
/// curves), each of which may or may not be closed. Contours are typically
/// constructed from Bézier segments.
///
/// <picture>
///   <source srcset="path-dark.png" media="(prefers-color-scheme: dark)">
///   <img alt="A Path" src="path-light.png">
/// </picture>
pub const Path = opaque {
    /// Constructs a path from a serialized form.
    ///
    /// The string is expected to be in (a superset of)
    /// [SVG path syntax](https://www.w3.org/TR/SVG11/paths.html`PathData`),
    /// as e.g. produced by `gsk.Path.toString`.
    ///
    /// A high-level summary of the syntax:
    ///
    /// - `M x y` Move to `(x, y)`
    /// - `L x y` Add a line from the current point to `(x, y)`
    /// - `Q x1 y1 x2 y2` Add a quadratic Bézier from the current point to `(x2, y2)`, with control point `(x1, y1)`
    /// - `C x1 y1 x2 y2 x3 y3` Add a cubic Bézier from the current point to `(x3, y3)`, with control points `(x1, y1)` and `(x2, y2)`
    /// - `Z` Close the contour by drawing a line back to the start point
    /// - `H x` Add a horizontal line from the current point to the given x value
    /// - `V y` Add a vertical line from the current point to the given y value
    /// - `T x2 y2` Add a quadratic Bézier, using the reflection of the previous segments' control point as control point
    /// - `S x2 y2 x3 y3` Add a cubic Bézier, using the reflection of the previous segments' second control point as first control point
    /// - `A rx ry r l s x y` Add an elliptical arc from the current point to `(x, y)` with radii rx and ry. See the SVG documentation for how the other parameters influence the arc.
    /// - `O x1 y1 x2 y2 w` Add a rational quadratic Bézier from the current point to `(x2, y2)` with control point `(x1, y1)` and weight `w`.
    ///
    /// All the commands have lowercase variants that interpret coordinates
    /// relative to the current point.
    ///
    /// The `O` command is an extension that is not supported in SVG.
    extern fn gsk_path_parse(p_string: [*:0]const u8) ?*gsk.Path;
    pub const parse = gsk_path_parse;

    /// Calls `func` for every operation of the path.
    ///
    /// Note that this may only approximate `self`, because paths can contain
    /// optimizations for various specialized contours, and depending on the
    /// `flags`, the path may be decomposed into simpler curves than the ones
    /// that it contained originally.
    ///
    /// This function serves two purposes:
    ///
    /// - When the `flags` allow everything, it provides access to the raw,
    ///   unmodified data of the path.
    /// - When the `flags` disallow certain operations, it provides
    ///   an approximation of the path using just the allowed operations.
    extern fn gsk_path_foreach(p_self: *Path, p_flags: gsk.PathForeachFlags, p_func: gsk.PathForeachFunc, p_user_data: ?*anyopaque) c_int;
    pub const foreach = gsk_path_foreach;

    /// Computes the bounds of the given path.
    ///
    /// The returned bounds may be larger than necessary, because this
    /// function aims to be fast, not accurate. The bounds are guaranteed
    /// to contain the path.
    ///
    /// It is possible that the returned rectangle has 0 width and/or height.
    /// This can happen when the path only describes a point or an
    /// axis-aligned line.
    ///
    /// If the path is empty, false is returned and `bounds` are set to
    /// `graphene.rectZero`. This is different from the case where the path
    /// is a single point at the origin, where the `bounds` will also be set to
    /// the zero rectangle but true will be returned.
    extern fn gsk_path_get_bounds(p_self: *Path, p_bounds: *graphene.Rect) c_int;
    pub const getBounds = gsk_path_get_bounds;

    /// Computes the closest point on the path to the given point.
    ///
    /// If there is no point closer than the given threshold,
    /// false is returned.
    extern fn gsk_path_get_closest_point(p_self: *Path, p_point: *const graphene.Point, p_threshold: f32, p_result: *gsk.PathPoint, p_distance: ?*f32) c_int;
    pub const getClosestPoint = gsk_path_get_closest_point;

    /// Gets the end point of the path.
    ///
    /// An empty path has no points, so false
    /// is returned in this case.
    extern fn gsk_path_get_end_point(p_self: *Path, p_result: *gsk.PathPoint) c_int;
    pub const getEndPoint = gsk_path_get_end_point;

    /// Gets the start point of the path.
    ///
    /// An empty path has no points, so false
    /// is returned in this case.
    extern fn gsk_path_get_start_point(p_self: *Path, p_result: *gsk.PathPoint) c_int;
    pub const getStartPoint = gsk_path_get_start_point;

    /// Computes the bounds for stroking the given path with the
    /// given parameters.
    ///
    /// The returned bounds may be larger than necessary, because this
    /// function aims to be fast, not accurate. The bounds are guaranteed
    /// to contain the area affected by the stroke, including protrusions
    /// like miters.
    extern fn gsk_path_get_stroke_bounds(p_self: *Path, p_stroke: *const gsk.Stroke, p_bounds: *graphene.Rect) c_int;
    pub const getStrokeBounds = gsk_path_get_stroke_bounds;

    /// Returns whether a point is inside the fill area of a path.
    ///
    /// Note that this function assumes that filling a contour
    /// implicitly closes it.
    extern fn gsk_path_in_fill(p_self: *Path, p_point: *const graphene.Point, p_fill_rule: gsk.FillRule) c_int;
    pub const inFill = gsk_path_in_fill;

    /// Returns if the path represents a single closed contour.
    extern fn gsk_path_is_closed(p_self: *Path) c_int;
    pub const isClosed = gsk_path_is_closed;

    /// Checks if the path is empty, i.e. contains no lines or curves.
    extern fn gsk_path_is_empty(p_self: *Path) c_int;
    pub const isEmpty = gsk_path_is_empty;

    /// Converts the path into a human-readable representation.
    ///
    /// The string is compatible with (a superset of)
    /// [SVG path syntax](https://www.w3.org/TR/SVG11/paths.html`PathData`),
    /// see `gsk.Path.parse` for a summary of the syntax.
    extern fn gsk_path_print(p_self: *Path, p_string: *glib.String) void;
    pub const print = gsk_path_print;

    /// Increases the reference count of a path by one.
    extern fn gsk_path_ref(p_self: *Path) *gsk.Path;
    pub const ref = gsk_path_ref;

    /// Appends the path to a cairo context for drawing with Cairo.
    ///
    /// This may cause some suboptimal conversions to be performed as
    /// Cairo does not support all features of `GskPath`.
    ///
    /// This function does not clear the existing Cairo path. Call
    /// `cairo_new_path` if you want this.
    extern fn gsk_path_to_cairo(p_self: *Path, p_cr: *cairo.Context) void;
    pub const toCairo = gsk_path_to_cairo;

    /// Converts the path into a human-readable string.
    ///
    /// You can use this function in a debugger to get a quick overview
    /// of the path.
    ///
    /// This is a wrapper around `gsk.Path.print`, see that function
    /// for details.
    extern fn gsk_path_to_string(p_self: *Path) [*:0]u8;
    pub const toString = gsk_path_to_string;

    /// Decreases the reference count of a path by one.
    ///
    /// If the resulting reference count is zero, frees the path.
    extern fn gsk_path_unref(p_self: *Path) void;
    pub const unref = gsk_path_unref;

    extern fn gsk_path_get_type() usize;
    pub const getGObjectType = gsk_path_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Constructs `GskPath` objects.
///
/// A path is constructed like this:
///
/// ```c
/// GskPath *
/// construct_path (void)
/// {
///   GskPathBuilder *builder;
///
///   builder = gsk_path_builder_new ();
///
///   // add contours to the path here
///
///   return gsk_path_builder_free_to_path (builder);
/// ```
///
/// Adding contours to the path can be done in two ways.
/// The easiest option is to use the `gsk_path_builder_add_*` group
/// of functions that add predefined contours to the current path,
/// either common shapes like `gsk.PathBuilder.addCircle`
/// or by adding from other paths like `gsk.PathBuilder.addPath`.
///
/// The `gsk_path_builder_add_*` methods always add complete contours,
/// and do not use or modify the current point.
///
/// The other option is to define each line and curve manually with
/// the `gsk_path_builder_*_to` group of functions. You start with
/// a call to `gsk.PathBuilder.moveTo` to set the starting point
/// and then use multiple calls to any of the drawing functions to
/// move the pen along the plane. Once you are done, you can call
/// `gsk.PathBuilder.close` to close the path by connecting it
/// back with a line to the starting point.
///
/// This is similar to how paths are drawn in Cairo.
///
/// Note that `GskPathBuilder` will reduce the degree of added Bézier
/// curves as much as possible, to simplify rendering.
pub const PathBuilder = opaque {
    /// Create a new `GskPathBuilder` object.
    ///
    /// The resulting builder would create an empty `GskPath`.
    /// Use addition functions to add types to it.
    extern fn gsk_path_builder_new() *gsk.PathBuilder;
    pub const new = gsk_path_builder_new;

    /// Adds a Cairo path to the builder.
    ///
    /// You can use `cairo_copy_path` to access the path
    /// from a Cairo context.
    extern fn gsk_path_builder_add_cairo_path(p_self: *PathBuilder, p_path: *const cairo.Path) void;
    pub const addCairoPath = gsk_path_builder_add_cairo_path;

    /// Adds a circle as a new contour.
    ///
    /// The path is going around the circle in clockwise direction.
    ///
    /// If `radius` is zero, the contour will be a closed point.
    extern fn gsk_path_builder_add_circle(p_self: *PathBuilder, p_center: *const graphene.Point, p_radius: f32) void;
    pub const addCircle = gsk_path_builder_add_circle;

    /// Adds the outlines for the glyphs in `layout` to the builder.
    extern fn gsk_path_builder_add_layout(p_self: *PathBuilder, p_layout: *pango.Layout) void;
    pub const addLayout = gsk_path_builder_add_layout;

    /// Appends all of `path` to the builder.
    extern fn gsk_path_builder_add_path(p_self: *PathBuilder, p_path: *gsk.Path) void;
    pub const addPath = gsk_path_builder_add_path;

    /// Adds a rectangle as a new contour.
    ///
    /// The path is going around the rectangle in clockwise direction.
    ///
    /// If the the width or height are 0, the path will be a closed
    /// horizontal or vertical line. If both are 0, it'll be a closed dot.
    extern fn gsk_path_builder_add_rect(p_self: *PathBuilder, p_rect: *const graphene.Rect) void;
    pub const addRect = gsk_path_builder_add_rect;

    /// Appends all of `path` to the builder, in reverse order.
    extern fn gsk_path_builder_add_reverse_path(p_self: *PathBuilder, p_path: *gsk.Path) void;
    pub const addReversePath = gsk_path_builder_add_reverse_path;

    /// Adds a rounded rectangle as a new contour.
    ///
    /// The path is going around the rectangle in clockwise direction.
    extern fn gsk_path_builder_add_rounded_rect(p_self: *PathBuilder, p_rect: *const gsk.RoundedRect) void;
    pub const addRoundedRect = gsk_path_builder_add_rounded_rect;

    /// Adds a segment of a path to the builder.
    ///
    /// If `start` is equal to or after `end`, the path will first add the
    /// segment from `start` to the end of the path, and then add the segment
    /// from the beginning to `end`. If the path is closed, these segments
    /// will be connected.
    ///
    /// Note that this method always adds a path with the given start point
    /// and end point. To add a closed path, use `gsk.PathBuilder.addPath`.
    extern fn gsk_path_builder_add_segment(p_self: *PathBuilder, p_path: *gsk.Path, p_start: *const gsk.PathPoint, p_end: *const gsk.PathPoint) void;
    pub const addSegment = gsk_path_builder_add_segment;

    /// Adds an elliptical arc from the current point to `x2`, `y2`
    /// with `x1`, `y1` determining the tangent directions.
    ///
    /// After this, `x2`, `y2` will be the new current point.
    ///
    /// Note: Two points and their tangents do not determine
    /// a unique ellipse, so GSK just picks one. If you need more
    /// precise control, use `gsk.PathBuilder.conicTo`
    /// or `gsk.PathBuilder.svgArcTo`.
    ///
    /// <picture>
    ///   <source srcset="arc-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Arc To" src="arc-light.png">
    /// </picture>
    extern fn gsk_path_builder_arc_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32) void;
    pub const arcTo = gsk_path_builder_arc_to;

    /// Ends the current contour with a line back to the start point.
    ///
    /// Note that this is different from calling `gsk.PathBuilder.lineTo`
    /// with the start point in that the contour will be closed. A closed
    /// contour behaves differently from an open one. When stroking, its
    /// start and end point are considered connected, so they will be
    /// joined via the line join, and not ended with line caps.
    extern fn gsk_path_builder_close(p_self: *PathBuilder) void;
    pub const close = gsk_path_builder_close;

    /// Adds a [conic curve](https://en.wikipedia.org/wiki/Non-uniform_rational_B-spline)
    /// from the current point to `x2`, `y2` with the given `weight` and `x1`, `y1` as the
    /// control point.
    ///
    /// The weight determines how strongly the curve is pulled towards the control point.
    /// A conic with weight 1 is identical to a quadratic Bézier curve with the same points.
    ///
    /// Conic curves can be used to draw ellipses and circles. They are also known as
    /// rational quadratic Bézier curves.
    ///
    /// After this, `x2`, `y2` will be the new current point.
    ///
    /// <picture>
    ///   <source srcset="conic-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Conic To" src="conic-light.png">
    /// </picture>
    extern fn gsk_path_builder_conic_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32, p_weight: f32) void;
    pub const conicTo = gsk_path_builder_conic_to;

    /// Adds a [cubic Bézier curve](https://en.wikipedia.org/wiki/B`C3``A9zier_curve`)
    /// from the current point to `x3`, `y3` with `x1`, `y1` and `x2`, `y2` as the control
    /// points.
    ///
    /// After this, `x3`, `y3` will be the new current point.
    ///
    /// <picture>
    ///   <source srcset="cubic-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Cubic To" src="cubic-light.png">
    /// </picture>
    extern fn gsk_path_builder_cubic_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32, p_x3: f32, p_y3: f32) void;
    pub const cubicTo = gsk_path_builder_cubic_to;

    /// Creates a new path from the current state of the
    /// builder, and unrefs the builder.
    extern fn gsk_path_builder_free_to_path(p_self: *PathBuilder) *gsk.Path;
    pub const freeToPath = gsk_path_builder_free_to_path;

    /// Gets the current point.
    ///
    /// The current point is used for relative drawing commands and
    /// updated after every operation.
    ///
    /// When the builder is created, the default current point is set
    /// to `0, 0`. Note that this is different from cairo, which starts
    /// out without a current point.
    extern fn gsk_path_builder_get_current_point(p_self: *PathBuilder) *const graphene.Point;
    pub const getCurrentPoint = gsk_path_builder_get_current_point;

    /// Implements arc-to according to the HTML Canvas spec.
    ///
    /// A convenience function that implements the
    /// [HTML arc_to](https://html.spec.whatwg.org/multipage/canvas.html`dom`-context-2d-arcto-dev)
    /// functionality.
    ///
    /// After this, the current point will be the point where
    /// the circle with the given radius touches the line from
    /// `x1`, `y1` to `x2`, `y2`.
    extern fn gsk_path_builder_html_arc_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32, p_radius: f32) void;
    pub const htmlArcTo = gsk_path_builder_html_arc_to;

    /// Draws a line from the current point to `x`, `y` and makes it
    /// the new current point.
    ///
    /// <picture>
    ///   <source srcset="line-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Line To" src="line-light.png">
    /// </picture>
    extern fn gsk_path_builder_line_to(p_self: *PathBuilder, p_x: f32, p_y: f32) void;
    pub const lineTo = gsk_path_builder_line_to;

    /// Starts a new contour by placing the pen at `x`, `y`.
    ///
    /// If this function is called twice in succession, the first
    /// call will result in a contour made up of a single point.
    /// The second call will start a new contour.
    extern fn gsk_path_builder_move_to(p_self: *PathBuilder, p_x: f32, p_y: f32) void;
    pub const moveTo = gsk_path_builder_move_to;

    /// Adds a [quadratic Bézier curve](https://en.wikipedia.org/wiki/B`C3``A9zier_curve`)
    /// from the current point to `x2`, `y2` with `x1`, `y1` as the control point.
    ///
    /// After this, `x2`, `y2` will be the new current point.
    ///
    /// <picture>
    ///   <source srcset="quad-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Quad To" src="quad-light.png">
    /// </picture>
    extern fn gsk_path_builder_quad_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32) void;
    pub const quadTo = gsk_path_builder_quad_to;

    /// Acquires a reference on the given builder.
    ///
    /// This function is intended primarily for language bindings.
    /// `GskPathBuilder` objects should not be kept around.
    extern fn gsk_path_builder_ref(p_self: *PathBuilder) *gsk.PathBuilder;
    pub const ref = gsk_path_builder_ref;

    /// Adds an elliptical arc from the current point to `x2`, `y2`
    /// with `x1`, `y1` determining the tangent directions.
    ///
    /// All coordinates are given relative to the current point.
    ///
    /// This is the relative version of `gsk.PathBuilder.arcTo`.
    extern fn gsk_path_builder_rel_arc_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32) void;
    pub const relArcTo = gsk_path_builder_rel_arc_to;

    /// Adds a [conic curve](https://en.wikipedia.org/wiki/Non-uniform_rational_B-spline)
    /// from the current point to `x2`, `y2` with the given `weight` and `x1`, `y1` as the
    /// control point.
    ///
    /// All coordinates are given relative to the current point.
    ///
    /// This is the relative version of `gsk.PathBuilder.conicTo`.
    extern fn gsk_path_builder_rel_conic_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32, p_weight: f32) void;
    pub const relConicTo = gsk_path_builder_rel_conic_to;

    /// Adds a [cubic Bézier curve](https://en.wikipedia.org/wiki/B`C3``A9zier_curve`)
    /// from the current point to `x3`, `y3` with `x1`, `y1` and `x2`, `y2` as the control
    /// points.
    ///
    /// All coordinates are given relative to the current point.
    ///
    /// This is the relative version of `gsk.PathBuilder.cubicTo`.
    extern fn gsk_path_builder_rel_cubic_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32, p_x3: f32, p_y3: f32) void;
    pub const relCubicTo = gsk_path_builder_rel_cubic_to;

    /// Implements arc-to according to the HTML Canvas spec.
    ///
    /// All coordinates are given relative to the current point.
    ///
    /// This is the relative version of `gsk.PathBuilder.htmlArcTo`.
    extern fn gsk_path_builder_rel_html_arc_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32, p_radius: f32) void;
    pub const relHtmlArcTo = gsk_path_builder_rel_html_arc_to;

    /// Draws a line from the current point to a point offset from it
    /// by `x`, `y` and makes it the new current point.
    ///
    /// This is the relative version of `gsk.PathBuilder.lineTo`.
    extern fn gsk_path_builder_rel_line_to(p_self: *PathBuilder, p_x: f32, p_y: f32) void;
    pub const relLineTo = gsk_path_builder_rel_line_to;

    /// Starts a new contour by placing the pen at `x`, `y`
    /// relative to the current point.
    ///
    /// This is the relative version of `gsk.PathBuilder.moveTo`.
    extern fn gsk_path_builder_rel_move_to(p_self: *PathBuilder, p_x: f32, p_y: f32) void;
    pub const relMoveTo = gsk_path_builder_rel_move_to;

    /// Adds a [quadratic Bézier curve](https://en.wikipedia.org/wiki/B`C3``A9zier_curve`)
    /// from the current point to `x2`, `y2` with `x1`, `y1` the control point.
    ///
    /// All coordinates are given relative to the current point.
    ///
    /// This is the relative version of `gsk.PathBuilder.quadTo`.
    extern fn gsk_path_builder_rel_quad_to(p_self: *PathBuilder, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32) void;
    pub const relQuadTo = gsk_path_builder_rel_quad_to;

    /// Implements arc-to according to the SVG spec.
    ///
    /// All coordinates are given relative to the current point.
    ///
    /// This is the relative version of `gsk.PathBuilder.svgArcTo`.
    extern fn gsk_path_builder_rel_svg_arc_to(p_self: *PathBuilder, p_rx: f32, p_ry: f32, p_x_axis_rotation: f32, p_large_arc: c_int, p_positive_sweep: c_int, p_x: f32, p_y: f32) void;
    pub const relSvgArcTo = gsk_path_builder_rel_svg_arc_to;

    /// Implements arc-to according to the SVG spec.
    ///
    /// A convenience function that implements the
    /// [SVG arc_to](https://www.w3.org/TR/SVG11/paths.html`PathDataEllipticalArcCommands`)
    /// functionality.
    ///
    /// After this, `x`, `y` will be the new current point.
    extern fn gsk_path_builder_svg_arc_to(p_self: *PathBuilder, p_rx: f32, p_ry: f32, p_x_axis_rotation: f32, p_large_arc: c_int, p_positive_sweep: c_int, p_x: f32, p_y: f32) void;
    pub const svgArcTo = gsk_path_builder_svg_arc_to;

    /// Creates a new path from the given builder.
    ///
    /// The given `GskPathBuilder` is reset once this function returns;
    /// you cannot call this function multiple times on the same builder
    /// instance.
    ///
    /// This function is intended primarily for language bindings.
    /// C code should use `gsk.PathBuilder.freeToPath`.
    extern fn gsk_path_builder_to_path(p_self: *PathBuilder) *gsk.Path;
    pub const toPath = gsk_path_builder_to_path;

    /// Releases a reference on the given builder.
    extern fn gsk_path_builder_unref(p_self: *PathBuilder) void;
    pub const unref = gsk_path_builder_unref;

    extern fn gsk_path_builder_get_type() usize;
    pub const getGObjectType = gsk_path_builder_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Performs measurements on paths such as determining the length of the path.
///
/// Many measuring operations require sampling the path length
/// at intermediate points. Therefore, a `GskPathMeasure` has
/// a tolerance that determines what precision is required
/// for such approximations.
///
/// A `GskPathMeasure` struct is a reference counted struct
/// and should be treated as opaque.
pub const PathMeasure = opaque {
    /// Creates a measure object for the given `path` with the
    /// default tolerance.
    extern fn gsk_path_measure_new(p_path: *gsk.Path) *gsk.PathMeasure;
    pub const new = gsk_path_measure_new;

    /// Creates a measure object for the given `path` and `tolerance`.
    extern fn gsk_path_measure_new_with_tolerance(p_path: *gsk.Path, p_tolerance: f32) *gsk.PathMeasure;
    pub const newWithTolerance = gsk_path_measure_new_with_tolerance;

    /// Gets the length of the path being measured.
    ///
    /// The length is cached, so this function does not do any work.
    extern fn gsk_path_measure_get_length(p_self: *PathMeasure) f32;
    pub const getLength = gsk_path_measure_get_length;

    /// Returns the path that the measure was created for.
    extern fn gsk_path_measure_get_path(p_self: *PathMeasure) *gsk.Path;
    pub const getPath = gsk_path_measure_get_path;

    /// Gets the point at the given distance into the path.
    ///
    /// An empty path has no points, so false is returned in that case.
    extern fn gsk_path_measure_get_point(p_self: *PathMeasure, p_distance: f32, p_result: *gsk.PathPoint) c_int;
    pub const getPoint = gsk_path_measure_get_point;

    /// Returns the tolerance that the measure was created with.
    extern fn gsk_path_measure_get_tolerance(p_self: *PathMeasure) f32;
    pub const getTolerance = gsk_path_measure_get_tolerance;

    /// Increases the reference count of a `GskPathMeasure` by one.
    extern fn gsk_path_measure_ref(p_self: *PathMeasure) *gsk.PathMeasure;
    pub const ref = gsk_path_measure_ref;

    /// Decreases the reference count of a `GskPathMeasure` by one.
    ///
    /// If the resulting reference count is zero, frees the object.
    extern fn gsk_path_measure_unref(p_self: *PathMeasure) void;
    pub const unref = gsk_path_measure_unref;

    extern fn gsk_path_measure_get_type() usize;
    pub const getGObjectType = gsk_path_measure_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Represents a point on a path.
///
/// It can be queried for properties of the path at that point,
/// such as its tangent or its curvature.
///
/// To obtain a `GskPathPoint`, use `gsk.Path.getClosestPoint`,
/// `gsk.Path.getStartPoint`, `gsk.Path.getEndPoint`
/// or `gsk.PathMeasure.getPoint`.
///
/// Note that `GskPathPoint` structs are meant to be stack-allocated,
/// and don't hold a reference to the path object they are obtained from.
/// It is the callers responsibility to keep a reference to the path
/// as long as the `GskPathPoint` is used.
pub const PathPoint = extern struct {
    anon0: extern union {
        anon0: extern struct {
            f_contour: usize,
            f_idx: usize,
            f_t: f32,
        },
        f_padding: [8]*anyopaque,
        f_alignment: graphene.Vec4,
    },

    /// Returns whether `point1` is before or after `point2`.
    extern fn gsk_path_point_compare(p_point1: *const PathPoint, p_point2: *const gsk.PathPoint) c_int;
    pub const compare = gsk_path_point_compare;

    /// Copies a path point.
    extern fn gsk_path_point_copy(p_point: *PathPoint) *gsk.PathPoint;
    pub const copy = gsk_path_point_copy;

    /// Returns whether the two path points refer to the same
    /// location on all paths.
    ///
    /// Note that the start- and endpoint of a closed contour
    /// will compare nonequal according to this definition.
    /// Use `gsk.Path.isClosed` to find out if the
    /// start- and endpoint of a concrete path refer to the
    /// same location.
    extern fn gsk_path_point_equal(p_point1: *const PathPoint, p_point2: *const gsk.PathPoint) c_int;
    pub const equal = gsk_path_point_equal;

    /// Frees a path point copied by `gsk.PathPoint.copy`.
    extern fn gsk_path_point_free(p_point: *PathPoint) void;
    pub const free = gsk_path_point_free;

    /// Calculates the curvature of the path at the point.
    ///
    /// Optionally, returns the center of the osculating circle as well.
    /// The curvature is the inverse of the radius of the osculating circle.
    ///
    /// Lines have a curvature of zero (indicating an osculating circle of
    /// infinite radius). In this case, the `center` is not modified.
    ///
    /// Circles with a radius of zero have `INFINITY` as curvature
    ///
    /// Note that certain points on a path may not have a single curvature,
    /// such as sharp turns. At such points, there are two curvatures — the
    /// (limit of) the curvature of the path going into the point, and the
    /// (limit of) the curvature of the path coming out of it. The `direction`
    /// argument lets you choose which one to get.
    ///
    /// <picture>
    ///   <source srcset="curvature-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Osculating circle" src="curvature-light.png">
    /// </picture>
    extern fn gsk_path_point_get_curvature(p_point: *const PathPoint, p_path: *gsk.Path, p_direction: gsk.PathDirection, p_center: ?*graphene.Point) f32;
    pub const getCurvature = gsk_path_point_get_curvature;

    /// Returns the distance from the beginning of the path
    /// to the point.
    extern fn gsk_path_point_get_distance(p_point: *const PathPoint, p_measure: *gsk.PathMeasure) f32;
    pub const getDistance = gsk_path_point_get_distance;

    /// Gets the position of the point.
    extern fn gsk_path_point_get_position(p_point: *const PathPoint, p_path: *gsk.Path, p_position: *graphene.Point) void;
    pub const getPosition = gsk_path_point_get_position;

    /// Gets the direction of the tangent at a given point.
    ///
    /// This is a convenience variant of `gsk.PathPoint.getTangent`
    /// that returns the angle between the tangent and the X axis. The angle
    /// can e.g. be used in
    /// [`gtk_snapshot_rotate`](../gtk4/method.Snapshot.rotate.html).
    extern fn gsk_path_point_get_rotation(p_point: *const PathPoint, p_path: *gsk.Path, p_direction: gsk.PathDirection) f32;
    pub const getRotation = gsk_path_point_get_rotation;

    /// Gets the tangent of the path at the point.
    ///
    /// Note that certain points on a path may not have a single
    /// tangent, such as sharp turns. At such points, there are
    /// two tangents — the direction of the path going into the
    /// point, and the direction coming out of it. The `direction`
    /// argument lets you choose which one to get.
    ///
    /// If the path is just a single point (e.g. a circle with
    /// radius zero), then the tangent is set to `0, 0`.
    ///
    /// If you want to orient something in the direction of the
    /// path, `gsk.PathPoint.getRotation` may be more
    /// convenient to use.
    extern fn gsk_path_point_get_tangent(p_point: *const PathPoint, p_path: *gsk.Path, p_direction: gsk.PathDirection, p_tangent: *graphene.Vec2) void;
    pub const getTangent = gsk_path_point_get_tangent;

    extern fn gsk_path_point_get_type() usize;
    pub const getGObjectType = gsk_path_point_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RendererClass = opaque {
    pub const Instance = gsk.Renderer;

    pub fn as(p_instance: *RendererClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A rectangular region with rounded corners.
///
/// Application code should normalize rectangles using
/// `gsk.RoundedRect.normalize`; this function will ensure that
/// the bounds of the rectangle are normalized and ensure that the corner
/// values are positive and the corners do not overlap.
///
/// All functions taking a `GskRoundedRect` as an argument will internally
/// operate on a normalized copy; all functions returning a `GskRoundedRect`
/// will always return a normalized one.
///
/// The algorithm used for normalizing corner sizes is described in
/// [the CSS specification](https://drafts.csswg.org/css-backgrounds-3/`border`-radius).
pub const RoundedRect = extern struct {
    /// the bounds of the rectangle
    f_bounds: graphene.Rect,
    /// the size of the 4 rounded corners
    f_corner: [4]graphene.Size,

    /// Checks if the given point is inside the rounded rectangle.
    extern fn gsk_rounded_rect_contains_point(p_self: *const RoundedRect, p_point: *const graphene.Point) c_int;
    pub const containsPoint = gsk_rounded_rect_contains_point;

    /// Checks if the given rectangle is contained inside the rounded rectangle.
    extern fn gsk_rounded_rect_contains_rect(p_self: *const RoundedRect, p_rect: *const graphene.Rect) c_int;
    pub const containsRect = gsk_rounded_rect_contains_rect;

    /// Initializes a rounded rectangle with the given values.
    ///
    /// This function will implicitly normalize the rounded rectangle
    /// before returning.
    extern fn gsk_rounded_rect_init(p_self: *RoundedRect, p_bounds: *const graphene.Rect, p_top_left: *const graphene.Size, p_top_right: *const graphene.Size, p_bottom_right: *const graphene.Size, p_bottom_left: *const graphene.Size) *gsk.RoundedRect;
    pub const init = gsk_rounded_rect_init;

    /// Initializes a rounded rectangle with a copy.
    ///
    /// This function will not normalize the rounded rectangle,
    /// so make sure the source is normalized.
    extern fn gsk_rounded_rect_init_copy(p_self: *RoundedRect, p_src: *const gsk.RoundedRect) *gsk.RoundedRect;
    pub const initCopy = gsk_rounded_rect_init_copy;

    /// Initializes a rounded rectangle to the given bounds
    /// and sets the radius of all four corners equally.
    extern fn gsk_rounded_rect_init_from_rect(p_self: *RoundedRect, p_bounds: *const graphene.Rect, p_radius: f32) *gsk.RoundedRect;
    pub const initFromRect = gsk_rounded_rect_init_from_rect;

    /// Checks if part a rectangle is contained
    /// inside the rounded rectangle.
    extern fn gsk_rounded_rect_intersects_rect(p_self: *const RoundedRect, p_rect: *const graphene.Rect) c_int;
    pub const intersectsRect = gsk_rounded_rect_intersects_rect;

    /// Checks if all corners of a rounded rectangle are right angles
    /// and the rectangle covers all of its bounds.
    ///
    /// This information can be used to decide if `gsk.ClipNode.new`
    /// or `gsk.RoundedClipNode.new` should be called.
    extern fn gsk_rounded_rect_is_rectilinear(p_self: *const RoundedRect) c_int;
    pub const isRectilinear = gsk_rounded_rect_is_rectilinear;

    /// Normalizes a rounded rectangle.
    ///
    /// This function will ensure that the bounds of the rounded rectangle
    /// are normalized and ensure that the corner values are positive
    /// and the corners do not overlap.
    extern fn gsk_rounded_rect_normalize(p_self: *RoundedRect) *gsk.RoundedRect;
    pub const normalize = gsk_rounded_rect_normalize;

    /// Offsets the rounded rectangle's origin by `dx` and `dy`.
    ///
    /// The size and corners of the rounded rectangle are unchanged.
    extern fn gsk_rounded_rect_offset(p_self: *RoundedRect, p_dx: f32, p_dy: f32) *gsk.RoundedRect;
    pub const offset = gsk_rounded_rect_offset;

    /// Shrinks (or grows) a rounded rectangle by moving the 4 sides
    /// according to the offsets given.
    ///
    /// The corner radii will be changed in a way that tries to keep
    /// the center of the corner circle intact. This emulates CSS behavior.
    ///
    /// This function also works for growing rounded rectangles
    /// if you pass negative values for the `top`, `right`, `bottom` or `left`.
    extern fn gsk_rounded_rect_shrink(p_self: *RoundedRect, p_top: f32, p_right: f32, p_bottom: f32, p_left: f32) *gsk.RoundedRect;
    pub const shrink = gsk_rounded_rect_shrink;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Builds the uniforms data for a `GskGLShader`.
pub const ShaderArgsBuilder = opaque {
    /// Allocates a builder that can be used to construct a new uniform data
    /// chunk.
    extern fn gsk_shader_args_builder_new(p_shader: *gsk.GLShader, p_initial_values: ?*glib.Bytes) *gsk.ShaderArgsBuilder;
    pub const new = gsk_shader_args_builder_new;

    /// Creates a new `GBytes` args from the current state of the
    /// given `builder`, and frees the `builder` instance.
    ///
    /// Any uniforms of the shader that have not been explicitly set
    /// on the `builder` are zero-initialized.
    extern fn gsk_shader_args_builder_free_to_args(p_builder: *ShaderArgsBuilder) *glib.Bytes;
    pub const freeToArgs = gsk_shader_args_builder_free_to_args;

    /// Increases the reference count of a `GskShaderArgsBuilder` by one.
    extern fn gsk_shader_args_builder_ref(p_builder: *ShaderArgsBuilder) *gsk.ShaderArgsBuilder;
    pub const ref = gsk_shader_args_builder_ref;

    /// Sets the value of the uniform `idx`.
    ///
    /// The uniform must be of bool type.
    extern fn gsk_shader_args_builder_set_bool(p_builder: *ShaderArgsBuilder, p_idx: c_int, p_value: c_int) void;
    pub const setBool = gsk_shader_args_builder_set_bool;

    /// Sets the value of the uniform `idx`.
    ///
    /// The uniform must be of float type.
    extern fn gsk_shader_args_builder_set_float(p_builder: *ShaderArgsBuilder, p_idx: c_int, p_value: f32) void;
    pub const setFloat = gsk_shader_args_builder_set_float;

    /// Sets the value of the uniform `idx`.
    ///
    /// The uniform must be of int type.
    extern fn gsk_shader_args_builder_set_int(p_builder: *ShaderArgsBuilder, p_idx: c_int, p_value: i32) void;
    pub const setInt = gsk_shader_args_builder_set_int;

    /// Sets the value of the uniform `idx`.
    ///
    /// The uniform must be of uint type.
    extern fn gsk_shader_args_builder_set_uint(p_builder: *ShaderArgsBuilder, p_idx: c_int, p_value: u32) void;
    pub const setUint = gsk_shader_args_builder_set_uint;

    /// Sets the value of the uniform `idx`.
    ///
    /// The uniform must be of vec2 type.
    extern fn gsk_shader_args_builder_set_vec2(p_builder: *ShaderArgsBuilder, p_idx: c_int, p_value: *const graphene.Vec2) void;
    pub const setVec2 = gsk_shader_args_builder_set_vec2;

    /// Sets the value of the uniform `idx`.
    ///
    /// The uniform must be of vec3 type.
    extern fn gsk_shader_args_builder_set_vec3(p_builder: *ShaderArgsBuilder, p_idx: c_int, p_value: *const graphene.Vec3) void;
    pub const setVec3 = gsk_shader_args_builder_set_vec3;

    /// Sets the value of the uniform `idx`.
    ///
    /// The uniform must be of vec4 type.
    extern fn gsk_shader_args_builder_set_vec4(p_builder: *ShaderArgsBuilder, p_idx: c_int, p_value: *const graphene.Vec4) void;
    pub const setVec4 = gsk_shader_args_builder_set_vec4;

    /// Creates a new `GBytes` args from the current state of the
    /// given `builder`.
    ///
    /// Any uniforms of the shader that have not been explicitly set on
    /// the `builder` are zero-initialized.
    ///
    /// The given `GskShaderArgsBuilder` is reset once this function returns;
    /// you cannot call this function multiple times on the same `builder` instance.
    ///
    /// This function is intended primarily for bindings. C code should use
    /// `gsk.ShaderArgsBuilder.freeToArgs`.
    extern fn gsk_shader_args_builder_to_args(p_builder: *ShaderArgsBuilder) *glib.Bytes;
    pub const toArgs = gsk_shader_args_builder_to_args;

    /// Decreases the reference count of a `GskShaderArgBuilder` by one.
    ///
    /// If the resulting reference count is zero, frees the builder.
    extern fn gsk_shader_args_builder_unref(p_builder: *ShaderArgsBuilder) void;
    pub const unref = gsk_shader_args_builder_unref;

    extern fn gsk_shader_args_builder_get_type() usize;
    pub const getGObjectType = gsk_shader_args_builder_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The shadow parameters in a shadow node.
pub const Shadow = extern struct {
    /// the color of the shadow
    f_color: gdk.RGBA,
    /// the horizontal offset of the shadow
    f_dx: f32,
    /// the vertical offset of the shadow
    f_dy: f32,
    /// the radius of the shadow
    f_radius: f32,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Collects the parameters that are needed when stroking a path.
pub const Stroke = opaque {
    /// Checks if two strokes are identical.
    extern fn gsk_stroke_equal(p_stroke1: ?*const anyopaque, p_stroke2: ?*const anyopaque) c_int;
    pub const equal = gsk_stroke_equal;

    /// Creates a new `GskStroke` with the given `line_width`.
    extern fn gsk_stroke_new(p_line_width: f32) *gsk.Stroke;
    pub const new = gsk_stroke_new;

    /// Creates a copy of a `GskStroke`.
    extern fn gsk_stroke_copy(p_other: *const Stroke) *gsk.Stroke;
    pub const copy = gsk_stroke_copy;

    /// Frees a `GskStroke`.
    extern fn gsk_stroke_free(p_self: *Stroke) void;
    pub const free = gsk_stroke_free;

    /// Gets the dash array in use.
    extern fn gsk_stroke_get_dash(p_self: *const Stroke, p_n_dash: *usize) ?[*]const f32;
    pub const getDash = gsk_stroke_get_dash;

    /// Gets the dash offset.
    extern fn gsk_stroke_get_dash_offset(p_self: *const Stroke) f32;
    pub const getDashOffset = gsk_stroke_get_dash_offset;

    /// Gets the line cap used.
    ///
    /// See `gsk.LineCap` for details.
    extern fn gsk_stroke_get_line_cap(p_self: *const Stroke) gsk.LineCap;
    pub const getLineCap = gsk_stroke_get_line_cap;

    /// Gets the line join used.
    ///
    /// See `gsk.LineJoin` for details.
    extern fn gsk_stroke_get_line_join(p_self: *const Stroke) gsk.LineJoin;
    pub const getLineJoin = gsk_stroke_get_line_join;

    /// Gets the line width used.
    extern fn gsk_stroke_get_line_width(p_self: *const Stroke) f32;
    pub const getLineWidth = gsk_stroke_get_line_width;

    /// Gets the miter limit.
    extern fn gsk_stroke_get_miter_limit(p_self: *const Stroke) f32;
    pub const getMiterLimit = gsk_stroke_get_miter_limit;

    /// Sets the dash pattern to use.
    ///
    /// A dash pattern is specified by an array of alternating non-negative
    /// values. Each value provides the length of alternate "on" and "off"
    /// portions of the stroke.
    ///
    /// Each "on" segment will have caps applied as if the segment were a
    /// separate contour. In particular, it is valid to use an "on" length
    /// of 0 with `gsk.@"LineCap.round"` or `gsk.@"LineCap.square"`
    /// to draw dots or squares along a path.
    ///
    /// If `n_dash` is 0, if all elements in `dash` are 0, or if there are
    /// negative values in `dash`, then dashing is disabled.
    ///
    /// If `n_dash` is 1, an alternating "on" and "off" pattern with the
    /// single dash length provided is assumed.
    ///
    /// If `n_dash` is uneven, the dash array will be used with the first
    /// element in `dash` defining an "on" or "off" in alternating passes
    /// through the array.
    ///
    /// You can specify a starting offset into the dash with
    /// `gsk.Stroke.setDashOffset`.
    extern fn gsk_stroke_set_dash(p_self: *Stroke, p_dash: ?[*]const f32, p_n_dash: usize) void;
    pub const setDash = gsk_stroke_set_dash;

    /// Sets the offset into the dash pattern where dashing should begin.
    ///
    /// This is an offset into the length of the path, not an index into
    /// the array values of the dash array.
    ///
    /// See `gsk.Stroke.setDash` for more details on dashing.
    extern fn gsk_stroke_set_dash_offset(p_self: *Stroke, p_offset: f32) void;
    pub const setDashOffset = gsk_stroke_set_dash_offset;

    /// Sets the line cap to be used when stroking.
    ///
    /// See `gsk.LineCap` for details.
    extern fn gsk_stroke_set_line_cap(p_self: *Stroke, p_line_cap: gsk.LineCap) void;
    pub const setLineCap = gsk_stroke_set_line_cap;

    /// Sets the line join to be used when stroking.
    ///
    /// See `gsk.LineJoin` for details.
    extern fn gsk_stroke_set_line_join(p_self: *Stroke, p_line_join: gsk.LineJoin) void;
    pub const setLineJoin = gsk_stroke_set_line_join;

    /// Sets the line width to be used when stroking.
    ///
    /// The line width must be > 0.
    extern fn gsk_stroke_set_line_width(p_self: *Stroke, p_line_width: f32) void;
    pub const setLineWidth = gsk_stroke_set_line_width;

    /// Sets the miter limit to be used when stroking.
    ///
    /// The miter limit is the distance from the corner where sharp
    /// turns of joins get cut off.
    ///
    /// The limit is specfied in units of line width and must be non-negative.
    ///
    /// For joins of type `gsk.@"LineJoin.miter"` that exceed the miter limit,
    /// the join gets rendered as if it was of type `gsk.@"LineJoin.bevel"`.
    extern fn gsk_stroke_set_miter_limit(p_self: *Stroke, p_limit: f32) void;
    pub const setMiterLimit = gsk_stroke_set_miter_limit;

    /// A helper function that sets the stroke parameters
    /// of a cairo context from a `GskStroke`.
    extern fn gsk_stroke_to_cairo(p_self: *const Stroke, p_cr: *cairo.Context) void;
    pub const toCairo = gsk_stroke_to_cairo;

    extern fn gsk_stroke_get_type() usize;
    pub const getGObjectType = gsk_stroke_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a 3D transform.
///
/// Unlike `graphene_matrix_t`, `GskTransform` retains the steps in how
/// a transform was constructed, and allows inspecting them. It is modeled
/// after the way CSS describes transforms.
///
/// `GskTransform` objects are immutable and cannot be changed after creation.
/// This means code can safely expose them as properties of objects without
/// having to worry about others changing them.
pub const Transform = opaque {
    /// Parses a given into a transform.
    ///
    /// Strings printed via `gsk.Transform.toString`
    /// can be read in again successfully using this function.
    ///
    /// If `string` does not describe a valid transform, false
    /// is returned and `NULL` is put in `out_transform`.
    extern fn gsk_transform_parse(p_string: [*:0]const u8, p_out_transform: **gsk.Transform) c_int;
    pub const parse = gsk_transform_parse;

    /// Creates a new identity transform.
    ///
    /// This function is meant to be used by language
    /// bindings. For C code, this is equivalent to using `NULL`.
    extern fn gsk_transform_new() *gsk.Transform;
    pub const new = gsk_transform_new;

    /// Checks two transforms for equality.
    extern fn gsk_transform_equal(p_first: ?*Transform, p_second: ?*gsk.Transform) c_int;
    pub const equal = gsk_transform_equal;

    /// Returns the category this transform belongs to.
    extern fn gsk_transform_get_category(p_self: ?*Transform) gsk.TransformCategory;
    pub const getCategory = gsk_transform_get_category;

    /// Inverts the given transform.
    ///
    /// If `self` is not invertible, `NULL` is returned.
    /// Note that inverting `NULL` also returns `NULL`, which is
    /// the correct inverse of `NULL`. If you need to differentiate
    /// between those cases, you should check `self` is not `NULL`
    /// before calling this function.
    ///
    /// This function consumes `self`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_invert(p_self: ?*Transform) ?*gsk.Transform;
    pub const invert = gsk_transform_invert;

    /// Multiplies `next` with the given `matrix`.
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_matrix(p_next: ?*Transform, p_matrix: *const graphene.Matrix) *gsk.Transform;
    pub const matrix = gsk_transform_matrix;

    /// Applies a perspective projection transform.
    ///
    /// This transform scales points in X and Y based on their Z value,
    /// scaling points with positive Z values away from the origin, and
    /// those with negative Z values towards the origin. Points
    /// on the z=0 plane are unchanged.
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_perspective(p_next: ?*Transform, p_depth: f32) *gsk.Transform;
    pub const perspective = gsk_transform_perspective;

    /// Converts the transform into a human-readable representation.
    ///
    /// The result of this function can later be parsed with
    /// `gsk.Transform.parse`.
    extern fn gsk_transform_print(p_self: ?*Transform, p_string: *glib.String) void;
    pub const print = gsk_transform_print;

    /// Acquires a reference on the given transform.
    extern fn gsk_transform_ref(p_self: ?*Transform) ?*gsk.Transform;
    pub const ref = gsk_transform_ref;

    /// Rotates `next` by an angle around the Z axis.
    ///
    /// The rotation happens around the origin point of (0, 0).
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_rotate(p_next: ?*Transform, p_angle: f32) ?*gsk.Transform;
    pub const rotate = gsk_transform_rotate;

    /// Rotates `next` `angle` degrees around `axis`.
    ///
    /// For a rotation in 2D space, use `gsk.Transform.rotate`
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_rotate_3d(p_next: ?*Transform, p_angle: f32, p_axis: *const graphene.Vec3) ?*gsk.Transform;
    pub const rotate3d = gsk_transform_rotate_3d;

    /// Scales `next` in 2-dimensional space by the given factors.
    ///
    /// Use `gsk.Transform.scale3d` to scale in all 3 dimensions.
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_scale(p_next: ?*Transform, p_factor_x: f32, p_factor_y: f32) ?*gsk.Transform;
    pub const scale = gsk_transform_scale;

    /// Scales `next` by the given factors.
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_scale_3d(p_next: ?*Transform, p_factor_x: f32, p_factor_y: f32, p_factor_z: f32) ?*gsk.Transform;
    pub const scale3d = gsk_transform_scale_3d;

    /// Applies a skew transform.
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_skew(p_next: ?*Transform, p_skew_x: f32, p_skew_y: f32) ?*gsk.Transform;
    pub const skew = gsk_transform_skew;

    /// Converts a transform to a 2D transformation matrix.
    ///
    /// `self` must be a 2D transformation. If you are not
    /// sure, use
    ///
    ///     `gsk.Transform.getCategory` >= GSK_TRANSFORM_CATEGORY_2D
    ///
    /// to check.
    ///
    /// The returned values are a subset of the full 4x4 matrix that
    /// is computed by `gsk.Transform.toMatrix` and have the
    /// following layout:
    ///
    /// ```
    ///   | xx yx |   |  a  b  0 |
    ///   | xy yy | = |  c  d  0 |
    ///   | dx dy |   | tx ty  1 |
    /// ```
    ///
    /// This function can be used to convert between a `GskTransform`
    /// and a matrix type from other 2D drawing libraries, in particular
    /// Cairo.
    extern fn gsk_transform_to_2d(p_self: *Transform, p_out_xx: *f32, p_out_yx: *f32, p_out_xy: *f32, p_out_yy: *f32, p_out_dx: *f32, p_out_dy: *f32) void;
    pub const to2d = gsk_transform_to_2d;

    /// Converts a transform to 2D transformation factors.
    ///
    /// To recreate an equivalent transform from the factors returned
    /// by this function, use
    ///
    ///     gsk_transform_skew (
    ///         gsk_transform_scale (
    ///             gsk_transform_rotate (
    ///                 gsk_transform_translate (NULL, &GRAPHENE_POINT_T (dx, dy)),
    ///                 angle),
    ///             scale_x, scale_y),
    ///         skew_x, skew_y)
    ///
    /// `self` must be a 2D transformation. If you are not sure, use
    ///
    ///     `gsk.Transform.getCategory` >= GSK_TRANSFORM_CATEGORY_2D
    ///
    /// to check.
    extern fn gsk_transform_to_2d_components(p_self: *Transform, p_out_skew_x: *f32, p_out_skew_y: *f32, p_out_scale_x: *f32, p_out_scale_y: *f32, p_out_angle: *f32, p_out_dx: *f32, p_out_dy: *f32) void;
    pub const to2dComponents = gsk_transform_to_2d_components;

    /// Converts a transform to 2D affine transformation factors.
    ///
    /// To recreate an equivalent transform from the factors returned
    /// by this function, use
    ///
    ///     gsk_transform_scale (
    ///         gsk_transform_translate (
    ///             NULL,
    ///             &GRAPHENE_POINT_T (dx, dy)),
    ///         sx, sy)
    ///
    /// `self` must be a 2D affine transformation. If you are not
    /// sure, use
    ///
    ///     `gsk.Transform.getCategory` >= GSK_TRANSFORM_CATEGORY_2D_AFFINE
    ///
    /// to check.
    extern fn gsk_transform_to_affine(p_self: *Transform, p_out_scale_x: *f32, p_out_scale_y: *f32, p_out_dx: *f32, p_out_dy: *f32) void;
    pub const toAffine = gsk_transform_to_affine;

    /// Computes the 4x4 matrix for the transform.
    ///
    /// The previous value of `out_matrix` will be ignored.
    extern fn gsk_transform_to_matrix(p_self: ?*Transform, p_out_matrix: *graphene.Matrix) void;
    pub const toMatrix = gsk_transform_to_matrix;

    /// Converts the transform into a human-readable string.
    ///
    /// The resulting string can be parsed with `gsk.Transform.parse`.
    ///
    /// This is a wrapper around `gsk.Transform.print`.
    extern fn gsk_transform_to_string(p_self: ?*Transform) [*:0]u8;
    pub const toString = gsk_transform_to_string;

    /// Converts a transform to a translation operation.
    ///
    /// `self` must be a 2D transformation. If you are not
    /// sure, use
    ///
    ///     `gsk.Transform.getCategory` >= GSK_TRANSFORM_CATEGORY_2D_TRANSLATE
    ///
    /// to check.
    extern fn gsk_transform_to_translate(p_self: *Transform, p_out_dx: *f32, p_out_dy: *f32) void;
    pub const toTranslate = gsk_transform_to_translate;

    /// Applies all the operations from `other` to `next`.
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_transform(p_next: ?*Transform, p_other: ?*gsk.Transform) ?*gsk.Transform;
    pub const transform = gsk_transform_transform;

    /// Transforms a rectangle using the given transform.
    ///
    /// The result is the bounding box containing the coplanar quad.
    extern fn gsk_transform_transform_bounds(p_self: *Transform, p_rect: *const graphene.Rect, p_out_rect: *graphene.Rect) void;
    pub const transformBounds = gsk_transform_transform_bounds;

    /// Transforms a point using the given transform.
    extern fn gsk_transform_transform_point(p_self: *Transform, p_point: *const graphene.Point, p_out_point: *graphene.Point) void;
    pub const transformPoint = gsk_transform_transform_point;

    /// Translates `next` in 2-dimensional space by `point`.
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_translate(p_next: ?*Transform, p_point: *const graphene.Point) ?*gsk.Transform;
    pub const translate = gsk_transform_translate;

    /// Translates `next` by `point`.
    ///
    /// This function consumes `next`. Use `gsk.Transform.ref` first
    /// if you want to keep it around.
    extern fn gsk_transform_translate_3d(p_next: ?*Transform, p_point: *const graphene.Point3D) ?*gsk.Transform;
    pub const translate3d = gsk_transform_translate_3d;

    /// Releases a reference on the given transform.
    ///
    /// If the reference was the last, the resources associated to the `self` are
    /// freed.
    extern fn gsk_transform_unref(p_self: ?*Transform) void;
    pub const unref = gsk_transform_unref;

    extern fn gsk_transform_get_type() usize;
    pub const getGObjectType = gsk_transform_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VulkanRendererClass = opaque {
    pub const Instance = gsk.VulkanRenderer;

    pub fn as(p_instance: *VulkanRendererClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The blend modes available for render nodes.
///
/// The implementation of each blend mode is deferred to the
/// rendering pipeline.
///
/// See <https://www.w3.org/TR/compositing-1/`blending`> for more information
/// on blending and blend modes.
pub const BlendMode = enum(c_int) {
    default = 0,
    multiply = 1,
    screen = 2,
    overlay = 3,
    darken = 4,
    lighten = 5,
    color_dodge = 6,
    color_burn = 7,
    hard_light = 8,
    soft_light = 9,
    difference = 10,
    exclusion = 11,
    color = 12,
    hue = 13,
    saturation = 14,
    luminosity = 15,
    _,

    extern fn gsk_blend_mode_get_type() usize;
    pub const getGObjectType = gsk_blend_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The corner indices used by `GskRoundedRect`.
pub const Corner = enum(c_int) {
    top_left = 0,
    top_right = 1,
    bottom_right = 2,
    bottom_left = 3,
    _,

    extern fn gsk_corner_get_type() usize;
    pub const getGObjectType = gsk_corner_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies how paths are filled.
///
/// Whether or not a point is included in the fill is determined by taking
/// a ray from that point to infinity and looking at intersections with the
/// path. The ray can be in any direction, as long as it doesn't pass through
/// the end point of a segment or have a tricky intersection such as
/// intersecting tangent to the path.
///
/// (Note that filling is not actually implemented in this way. This
/// is just a description of the rule that is applied.)
///
/// New entries may be added in future versions.
pub const FillRule = enum(c_int) {
    winding = 0,
    even_odd = 1,
    _,

    extern fn gsk_fill_rule_get_type() usize;
    pub const getGObjectType = gsk_fill_rule_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the types of the uniforms that `GskGLShaders` declare.
///
/// It defines both what the type is called in the GLSL shader
/// code, and what the corresponding C type is on the Gtk side.
pub const GLUniformType = enum(c_int) {
    none = 0,
    float = 1,
    int = 2,
    uint = 3,
    bool = 4,
    vec2 = 5,
    vec3 = 6,
    vec4 = 7,
    _,

    extern fn gsk_gl_uniform_type_get_type() usize;
    pub const getGObjectType = gsk_gl_uniform_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies how to render the start and end points of contours or
/// dashes when stroking.
///
/// The default line cap style is `GSK_LINE_CAP_BUTT`.
///
/// New entries may be added in future versions.
///
/// <figure>
///   <picture>
///     <source srcset="caps-dark.png" media="(prefers-color-scheme: dark)">
///     <img alt="Line Cap Styles" src="caps-light.png">
///   </picture>
///   <figcaption>GSK_LINE_CAP_BUTT, GSK_LINE_CAP_ROUND, GSK_LINE_CAP_SQUARE</figcaption>
/// </figure>
pub const LineCap = enum(c_int) {
    butt = 0,
    round = 1,
    square = 2,
    _,

    extern fn gsk_line_cap_get_type() usize;
    pub const getGObjectType = gsk_line_cap_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies how to render the junction of two lines when stroking.
///
/// The default line join style is `GSK_LINE_JOIN_MITER`.
///
/// New entries may be added in future versions.
///
/// <figure>
///   <picture>
///     <source srcset="join-dark.png" media="(prefers-color-scheme: dark)">
///     <img alt="Line Join Styles" src="join-light.png">
///   </picture>
///   <figcaption>GSK_LINE_JOINT_MITER, GSK_LINE_JOINT_ROUND, GSK_LINE_JOIN_BEVEL</figcaption>
/// </figure>
pub const LineJoin = enum(c_int) {
    miter = 0,
    round = 1,
    bevel = 2,
    _,

    extern fn gsk_line_join_get_type() usize;
    pub const getGObjectType = gsk_line_join_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The mask modes available for mask nodes.
pub const MaskMode = enum(c_int) {
    alpha = 0,
    inverted_alpha = 1,
    luminance = 2,
    inverted_luminance = 3,
    _,

    extern fn gsk_mask_mode_get_type() usize;
    pub const getGObjectType = gsk_mask_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used to pick one of the four tangents at a given point on the path.
///
/// Note that the directions for `GSK_PATH_FROM_START`/`GSK_PATH_TO_END` and
/// `GSK_PATH_TO_START`/`GSK_PATH_FROM_END` will coincide for smooth points.
/// Only sharp turns will exhibit four different directions.
///
/// <picture>
///   <source srcset="directions-dark.png" media="(prefers-color-scheme: dark)">
///   <img alt="Path Tangents" src="directions-light.png">
/// </picture>
pub const PathDirection = enum(c_int) {
    from_start = 0,
    to_start = 1,
    to_end = 2,
    from_end = 3,
    _,

    extern fn gsk_path_direction_get_type() usize;
    pub const getGObjectType = gsk_path_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the segments of a `GskPath`.
///
/// More values may be added in the future.
pub const PathOperation = enum(c_int) {
    move = 0,
    close = 1,
    line = 2,
    quad = 3,
    cubic = 4,
    conic = 5,
    _,

    extern fn gsk_path_operation_get_type() usize;
    pub const getGObjectType = gsk_path_operation_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of a node determines what the node is rendering.
pub const RenderNodeType = enum(c_int) {
    not_a_render_node = 0,
    container_node = 1,
    cairo_node = 2,
    color_node = 3,
    linear_gradient_node = 4,
    repeating_linear_gradient_node = 5,
    radial_gradient_node = 6,
    repeating_radial_gradient_node = 7,
    conic_gradient_node = 8,
    border_node = 9,
    texture_node = 10,
    inset_shadow_node = 11,
    outset_shadow_node = 12,
    transform_node = 13,
    opacity_node = 14,
    color_matrix_node = 15,
    repeat_node = 16,
    clip_node = 17,
    rounded_clip_node = 18,
    shadow_node = 19,
    blend_node = 20,
    cross_fade_node = 21,
    text_node = 22,
    blur_node = 23,
    debug_node = 24,
    gl_shader_node = 25,
    texture_scale_node = 26,
    mask_node = 27,
    fill_node = 28,
    stroke_node = 29,
    subsurface_node = 30,
    _,

    extern fn gsk_render_node_type_get_type() usize;
    pub const getGObjectType = gsk_render_node_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The filters used when scaling texture data.
///
/// The actual implementation of each filter is deferred to the
/// rendering pipeline.
pub const ScalingFilter = enum(c_int) {
    linear = 0,
    nearest = 1,
    trilinear = 2,
    _,

    extern fn gsk_scaling_filter_get_type() usize;
    pub const getGObjectType = gsk_scaling_filter_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Errors that can happen during (de)serialization.
pub const SerializationError = enum(c_int) {
    unsupported_format = 0,
    unsupported_version = 1,
    invalid_data = 2,
    _,

    /// Registers an error quark for `gsk.RenderNode` errors.
    extern fn gsk_serialization_error_quark() glib.Quark;
    pub const quark = gsk_serialization_error_quark;

    extern fn gsk_serialization_error_get_type() usize;
    pub const getGObjectType = gsk_serialization_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The categories of matrices relevant for GSK and GTK.
///
/// Note that any category includes matrices of all later categories.
/// So if you want to for example check if a matrix is a 2D matrix,
/// `category >= GSK_TRANSFORM_CATEGORY_2D` is the way to do this.
///
/// Also keep in mind that rounding errors may cause matrices to not
/// conform to their categories. Otherwise, matrix operations done via
/// multiplication will not worsen categories. So for the matrix
/// multiplication `C = A * B`, `category(C) = MIN (category(A), category(B))`.
pub const TransformCategory = enum(c_int) {
    unknown = 0,
    any = 1,
    @"3d" = 2,
    @"2d" = 3,
    @"2d_affine" = 4,
    @"2d_translate" = 5,
    identity = 6,
    _,

    extern fn gsk_transform_category_get_type() usize;
    pub const getGObjectType = gsk_transform_category_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that can be passed to `gsk.Path.foreach` to influence what
/// kinds of operations the path is decomposed into.
///
/// By default, `gsk.Path.foreach` will only emit a path with all
/// operations flattened to straight lines to allow for maximum compatibility.
/// The only operations emitted will be `GSK_PATH_MOVE`, `GSK_PATH_LINE` and
/// `GSK_PATH_CLOSE`.
pub const PathForeachFlags = packed struct(c_uint) {
    quad: bool = false,
    cubic: bool = false,
    conic: bool = false,
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

    pub const flags_only_lines: PathForeachFlags = @bitCast(@as(c_uint, 0));
    pub const flags_quad: PathForeachFlags = @bitCast(@as(c_uint, 1));
    pub const flags_cubic: PathForeachFlags = @bitCast(@as(c_uint, 2));
    pub const flags_conic: PathForeachFlags = @bitCast(@as(c_uint, 4));
    extern fn gsk_path_foreach_flags_get_type() usize;
    pub const getGObjectType = gsk_path_foreach_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Retrieves the render node stored inside a `GValue`,
/// and acquires a reference to it.
extern fn gsk_value_dup_render_node(p_value: *const gobject.Value) ?*gsk.RenderNode;
pub const valueDupRenderNode = gsk_value_dup_render_node;

/// Retrieves the render node stored inside a `GValue`.
extern fn gsk_value_get_render_node(p_value: *const gobject.Value) ?*gsk.RenderNode;
pub const valueGetRenderNode = gsk_value_get_render_node;

/// Stores the given render node inside a `GValue`.
///
/// The `gobject.Value` will acquire a reference
/// to the render node.
extern fn gsk_value_set_render_node(p_value: *gobject.Value, p_node: *gsk.RenderNode) void;
pub const valueSetRenderNode = gsk_value_set_render_node;

/// Stores the given render node inside a `GValue`.
///
/// This function transfers the ownership of the
/// render node to the `GValue`.
extern fn gsk_value_take_render_node(p_value: *gobject.Value, p_node: ?*gsk.RenderNode) void;
pub const valueTakeRenderNode = gsk_value_take_render_node;

/// Type of callback that is called when an error occurs
/// during node deserialization.
pub const ParseErrorFunc = *const fn (p_start: *const gsk.ParseLocation, p_end: *const gsk.ParseLocation, p_error: *const glib.Error, p_user_data: ?*anyopaque) callconv(.c) void;

/// Type of the callback to iterate through the operations of a path.
///
/// For each operation, the callback is given the `op` itself, the points
/// that the operation is applied to in `pts`, and a `weight` for conic
/// curves. The `n_pts` argument is somewhat redundant, since the number
/// of points can be inferred from the operation.
///
/// Each contour of the path starts with a `GSK_PATH_MOVE` operation.
/// Closed contours end with a `GSK_PATH_CLOSE` operation.
pub const PathForeachFunc = *const fn (p_op: gsk.PathOperation, p_pts: *const graphene.Point, p_n_pts: usize, p_weight: f32, p_user_data: ?*anyopaque) callconv(.c) c_int;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
