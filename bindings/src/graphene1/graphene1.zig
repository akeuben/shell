pub const ext = @import("ext.zig");
const graphene = @This();

const std = @import("std");
const compat = @import("compat");
const gobject = @import("gobject2");
const glib = @import("glib2");
/// A 3D box, described as the volume between a minimum and
/// a maximum vertices.
pub const Box = extern struct {
    f_min: graphene.Vec3,
    f_max: graphene.Vec3,

    /// A degenerate `graphene.Box` that can only be expanded.
    ///
    /// The returned value is owned by Graphene and should not be modified or freed.
    extern fn graphene_box_empty() *const graphene.Box;
    pub const empty = graphene_box_empty;

    /// A degenerate `graphene.Box` that cannot be expanded.
    ///
    /// The returned value is owned by Graphene and should not be modified or freed.
    extern fn graphene_box_infinite() *const graphene.Box;
    pub const infinite = graphene_box_infinite;

    /// A `graphene.Box` with the minimum vertex set at (-1, -1, -1) and the
    /// maximum vertex set at (0, 0, 0).
    ///
    /// The returned value is owned by Graphene and should not be modified or freed.
    extern fn graphene_box_minus_one() *const graphene.Box;
    pub const minusOne = graphene_box_minus_one;

    /// A `graphene.Box` with the minimum vertex set at (0, 0, 0) and the
    /// maximum vertex set at (1, 1, 1).
    ///
    /// The returned value is owned by Graphene and should not be modified or freed.
    extern fn graphene_box_one() *const graphene.Box;
    pub const one = graphene_box_one;

    /// A `graphene.Box` with the minimum vertex set at (-1, -1, -1) and the
    /// maximum vertex set at (1, 1, 1).
    ///
    /// The returned value is owned by Graphene and should not be modified or freed.
    extern fn graphene_box_one_minus_one() *const graphene.Box;
    pub const oneMinusOne = graphene_box_one_minus_one;

    /// A `graphene.Box` with both the minimum and maximum vertices set at (0, 0, 0).
    ///
    /// The returned value is owned by Graphene and should not be modified or freed.
    extern fn graphene_box_zero() *const graphene.Box;
    pub const zero = graphene_box_zero;

    /// Allocates a new `graphene.Box`.
    ///
    /// The contents of the returned structure are undefined.
    extern fn graphene_box_alloc() *graphene.Box;
    pub const alloc = graphene_box_alloc;

    /// Checks whether the `graphene.Box` `a` contains the given
    /// `graphene.Box` `b`.
    extern fn graphene_box_contains_box(p_a: *const Box, p_b: *const graphene.Box) bool;
    pub const containsBox = graphene_box_contains_box;

    /// Checks whether `box` contains the given `point`.
    extern fn graphene_box_contains_point(p_box: *const Box, p_point: *const graphene.Point3D) bool;
    pub const containsPoint = graphene_box_contains_point;

    /// Checks whether the two given boxes are equal.
    extern fn graphene_box_equal(p_a: *const Box, p_b: *const graphene.Box) bool;
    pub const equal = graphene_box_equal;

    /// Expands the dimensions of `box` to include the coordinates at `point`.
    extern fn graphene_box_expand(p_box: *const Box, p_point: *const graphene.Point3D, p_res: *graphene.Box) void;
    pub const expand = graphene_box_expand;

    /// Expands the dimensions of `box` by the given `scalar` value.
    ///
    /// If `scalar` is positive, the `graphene.Box` will grow; if `scalar` is
    /// negative, the `graphene.Box` will shrink.
    extern fn graphene_box_expand_scalar(p_box: *const Box, p_scalar: f32, p_res: *graphene.Box) void;
    pub const expandScalar = graphene_box_expand_scalar;

    /// Expands the dimensions of `box` to include the coordinates of the
    /// given vector.
    extern fn graphene_box_expand_vec3(p_box: *const Box, p_vec: *const graphene.Vec3, p_res: *graphene.Box) void;
    pub const expandVec3 = graphene_box_expand_vec3;

    /// Frees the resources allocated by `graphene.Box.alloc`.
    extern fn graphene_box_free(p_box: *Box) void;
    pub const free = graphene_box_free;

    /// Computes the bounding `graphene.Sphere` capable of containing the given
    /// `graphene.Box`.
    extern fn graphene_box_get_bounding_sphere(p_box: *const Box, p_sphere: *graphene.Sphere) void;
    pub const getBoundingSphere = graphene_box_get_bounding_sphere;

    /// Retrieves the coordinates of the center of a `graphene.Box`.
    extern fn graphene_box_get_center(p_box: *const Box, p_center: *graphene.Point3D) void;
    pub const getCenter = graphene_box_get_center;

    /// Retrieves the size of the `box` on the Z axis.
    extern fn graphene_box_get_depth(p_box: *const Box) f32;
    pub const getDepth = graphene_box_get_depth;

    /// Retrieves the size of the `box` on the Y axis.
    extern fn graphene_box_get_height(p_box: *const Box) f32;
    pub const getHeight = graphene_box_get_height;

    /// Retrieves the coordinates of the maximum point of the given
    /// `graphene.Box`.
    extern fn graphene_box_get_max(p_box: *const Box, p_max: *graphene.Point3D) void;
    pub const getMax = graphene_box_get_max;

    /// Retrieves the coordinates of the minimum point of the given
    /// `graphene.Box`.
    extern fn graphene_box_get_min(p_box: *const Box, p_min: *graphene.Point3D) void;
    pub const getMin = graphene_box_get_min;

    /// Retrieves the size of the box on all three axes, and stores
    /// it into the given `size` vector.
    extern fn graphene_box_get_size(p_box: *const Box, p_size: *graphene.Vec3) void;
    pub const getSize = graphene_box_get_size;

    /// Computes the vertices of the given `graphene.Box`.
    extern fn graphene_box_get_vertices(p_box: *const Box, p_vertices: *[8]graphene.Vec3) void;
    pub const getVertices = graphene_box_get_vertices;

    /// Retrieves the size of the `box` on the X axis.
    extern fn graphene_box_get_width(p_box: *const Box) f32;
    pub const getWidth = graphene_box_get_width;

    /// Initializes the given `graphene.Box` with two vertices.
    extern fn graphene_box_init(p_box: *Box, p_min: ?*const graphene.Point3D, p_max: ?*const graphene.Point3D) *graphene.Box;
    pub const init = graphene_box_init;

    /// Initializes the given `graphene.Box` with the vertices of
    /// another `graphene.Box`.
    extern fn graphene_box_init_from_box(p_box: *Box, p_src: *const graphene.Box) *graphene.Box;
    pub const initFromBox = graphene_box_init_from_box;

    /// Initializes the given `graphene.Box` with the given array
    /// of vertices.
    ///
    /// If `n_points` is 0, the returned box is initialized with
    /// `graphene.boxEmpty`.
    extern fn graphene_box_init_from_points(p_box: *Box, p_n_points: c_uint, p_points: [*]const graphene.Point3D) *graphene.Box;
    pub const initFromPoints = graphene_box_init_from_points;

    /// Initializes the given `graphene.Box` with two vertices
    /// stored inside `graphene.Vec3`.
    extern fn graphene_box_init_from_vec3(p_box: *Box, p_min: ?*const graphene.Vec3, p_max: ?*const graphene.Vec3) *graphene.Box;
    pub const initFromVec3 = graphene_box_init_from_vec3;

    /// Initializes the given `graphene.Box` with the given array
    /// of vertices.
    ///
    /// If `n_vectors` is 0, the returned box is initialized with
    /// `graphene.boxEmpty`.
    extern fn graphene_box_init_from_vectors(p_box: *Box, p_n_vectors: c_uint, p_vectors: [*]const graphene.Vec3) *graphene.Box;
    pub const initFromVectors = graphene_box_init_from_vectors;

    /// Intersects the two given `graphene.Box`.
    ///
    /// If the two boxes do not intersect, `res` will contain a degenerate box
    /// initialized with `graphene.boxEmpty`.
    extern fn graphene_box_intersection(p_a: *const Box, p_b: *const graphene.Box, p_res: ?*graphene.Box) bool;
    pub const intersection = graphene_box_intersection;

    /// Unions the two given `graphene.Box`.
    extern fn graphene_box_union(p_a: *const Box, p_b: *const graphene.Box, p_res: *graphene.Box) void;
    pub const @"union" = graphene_box_union;

    extern fn graphene_box_get_type() usize;
    pub const getGObjectType = graphene_box_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describe a rotation using Euler angles.
///
/// The contents of the `graphene.Euler` structure are private
/// and should never be accessed directly.
pub const Euler = extern struct {
    f_angles: graphene.Vec3,
    f_order: graphene.EulerOrder,

    /// Allocates a new `graphene.Euler`.
    ///
    /// The contents of the returned structure are undefined.
    extern fn graphene_euler_alloc() *graphene.Euler;
    pub const alloc = graphene_euler_alloc;

    /// Checks if two `graphene.Euler` are equal.
    extern fn graphene_euler_equal(p_a: *const Euler, p_b: *const graphene.Euler) bool;
    pub const equal = graphene_euler_equal;

    /// Frees the resources allocated by `graphene.Euler.alloc`.
    extern fn graphene_euler_free(p_e: *Euler) void;
    pub const free = graphene_euler_free;

    /// Retrieves the first component of the Euler angle vector,
    /// depending on the order of rotation.
    ///
    /// See also: `graphene.Euler.getX`
    extern fn graphene_euler_get_alpha(p_e: *const Euler) f32;
    pub const getAlpha = graphene_euler_get_alpha;

    /// Retrieves the second component of the Euler angle vector,
    /// depending on the order of rotation.
    ///
    /// See also: `graphene.Euler.getY`
    extern fn graphene_euler_get_beta(p_e: *const Euler) f32;
    pub const getBeta = graphene_euler_get_beta;

    /// Retrieves the third component of the Euler angle vector,
    /// depending on the order of rotation.
    ///
    /// See also: `graphene.Euler.getZ`
    extern fn graphene_euler_get_gamma(p_e: *const Euler) f32;
    pub const getGamma = graphene_euler_get_gamma;

    /// Retrieves the order used to apply the rotations described in the
    /// `graphene.Euler` structure, when converting to and from other
    /// structures, like `graphene.Quaternion` and `graphene.Matrix`.
    ///
    /// This function does not return the `GRAPHENE_EULER_ORDER_DEFAULT`
    /// enumeration value; it will return the effective order of rotation
    /// instead.
    extern fn graphene_euler_get_order(p_e: *const Euler) graphene.EulerOrder;
    pub const getOrder = graphene_euler_get_order;

    /// Retrieves the rotation angle on the X axis, in degrees.
    extern fn graphene_euler_get_x(p_e: *const Euler) f32;
    pub const getX = graphene_euler_get_x;

    /// Retrieves the rotation angle on the Y axis, in degrees.
    extern fn graphene_euler_get_y(p_e: *const Euler) f32;
    pub const getY = graphene_euler_get_y;

    /// Retrieves the rotation angle on the Z axis, in degrees.
    extern fn graphene_euler_get_z(p_e: *const Euler) f32;
    pub const getZ = graphene_euler_get_z;

    /// Initializes a `graphene.Euler` using the given angles.
    ///
    /// The order of the rotations is `GRAPHENE_EULER_ORDER_DEFAULT`.
    extern fn graphene_euler_init(p_e: *Euler, p_x: f32, p_y: f32, p_z: f32) *graphene.Euler;
    pub const init = graphene_euler_init;

    /// Initializes a `graphene.Euler` using the angles and order of
    /// another `graphene.Euler`.
    ///
    /// If the `graphene.Euler` `src` is `NULL`, this function is equivalent
    /// to calling `graphene.Euler.init` with all angles set to 0.
    extern fn graphene_euler_init_from_euler(p_e: *Euler, p_src: ?*const graphene.Euler) *graphene.Euler;
    pub const initFromEuler = graphene_euler_init_from_euler;

    /// Initializes a `graphene.Euler` using the given rotation matrix.
    ///
    /// If the `graphene.Matrix` `m` is `NULL`, the `graphene.Euler` will
    /// be initialized with all angles set to 0.
    extern fn graphene_euler_init_from_matrix(p_e: *Euler, p_m: ?*const graphene.Matrix, p_order: graphene.EulerOrder) *graphene.Euler;
    pub const initFromMatrix = graphene_euler_init_from_matrix;

    /// Initializes a `graphene.Euler` using the given normalized quaternion.
    ///
    /// If the `graphene.Quaternion` `q` is `NULL`, the `graphene.Euler` will
    /// be initialized with all angles set to 0.
    extern fn graphene_euler_init_from_quaternion(p_e: *Euler, p_q: ?*const graphene.Quaternion, p_order: graphene.EulerOrder) *graphene.Euler;
    pub const initFromQuaternion = graphene_euler_init_from_quaternion;

    /// Initializes a `graphene.Euler` using the given angles
    /// and order of rotation.
    extern fn graphene_euler_init_from_radians(p_e: *Euler, p_x: f32, p_y: f32, p_z: f32, p_order: graphene.EulerOrder) *graphene.Euler;
    pub const initFromRadians = graphene_euler_init_from_radians;

    /// Initializes a `graphene.Euler` using the angles contained in a
    /// `graphene.Vec3`.
    ///
    /// If the `graphene.Vec3` `v` is `NULL`, the `graphene.Euler` will be
    /// initialized with all angles set to 0.
    extern fn graphene_euler_init_from_vec3(p_e: *Euler, p_v: ?*const graphene.Vec3, p_order: graphene.EulerOrder) *graphene.Euler;
    pub const initFromVec3 = graphene_euler_init_from_vec3;

    /// Initializes a `graphene.Euler` with the given angles and `order`.
    extern fn graphene_euler_init_with_order(p_e: *Euler, p_x: f32, p_y: f32, p_z: f32, p_order: graphene.EulerOrder) *graphene.Euler;
    pub const initWithOrder = graphene_euler_init_with_order;

    /// Reorders a `graphene.Euler` using `order`.
    ///
    /// This function is equivalent to creating a `graphene.Quaternion` from the
    /// given `graphene.Euler`, and then converting the quaternion into another
    /// `graphene.Euler`.
    extern fn graphene_euler_reorder(p_e: *const Euler, p_order: graphene.EulerOrder, p_res: *graphene.Euler) void;
    pub const reorder = graphene_euler_reorder;

    /// Converts a `graphene.Euler` into a transformation matrix expressing
    /// the extrinsic composition of rotations described by the Euler angles.
    ///
    /// The rotations are applied over the reference frame axes in the order
    /// associated with the `graphene.Euler`; for instance, if the order
    /// used to initialize `e` is `GRAPHENE_EULER_ORDER_XYZ`:
    ///
    ///  * the first rotation moves the body around the X axis with
    ///    an angle φ
    ///  * the second rotation moves the body around the Y axis with
    ///    an angle of ϑ
    ///  * the third rotation moves the body around the Z axis with
    ///    an angle of ψ
    ///
    /// The rotation sign convention is right-handed, to preserve compatibility
    /// between Euler-based, quaternion-based, and angle-axis-based rotations.
    extern fn graphene_euler_to_matrix(p_e: *const Euler, p_res: *graphene.Matrix) void;
    pub const toMatrix = graphene_euler_to_matrix;

    /// Converts a `graphene.Euler` into a `graphene.Quaternion`.
    extern fn graphene_euler_to_quaternion(p_e: *const Euler, p_res: *graphene.Quaternion) void;
    pub const toQuaternion = graphene_euler_to_quaternion;

    /// Retrieves the angles of a `graphene.Euler` and initializes a
    /// `graphene.Vec3` with them.
    extern fn graphene_euler_to_vec3(p_e: *const Euler, p_res: *graphene.Vec3) void;
    pub const toVec3 = graphene_euler_to_vec3;

    extern fn graphene_euler_get_type() usize;
    pub const getGObjectType = graphene_euler_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A 3D volume delimited by 2D clip planes.
///
/// The contents of the `graphene_frustum_t` are private, and should not be
/// modified directly.
pub const Frustum = extern struct {
    f_planes: [6]graphene.Plane,

    /// Allocates a new `graphene.Frustum` structure.
    ///
    /// The contents of the returned structure are undefined.
    extern fn graphene_frustum_alloc() *graphene.Frustum;
    pub const alloc = graphene_frustum_alloc;

    /// Checks whether a point is inside the volume defined by the given
    /// `graphene.Frustum`.
    extern fn graphene_frustum_contains_point(p_f: *const Frustum, p_point: *const graphene.Point3D) bool;
    pub const containsPoint = graphene_frustum_contains_point;

    /// Checks whether the two given `graphene.Frustum` are equal.
    extern fn graphene_frustum_equal(p_a: *const Frustum, p_b: *const graphene.Frustum) bool;
    pub const equal = graphene_frustum_equal;

    /// Frees the resources allocated by `graphene.Frustum.alloc`.
    extern fn graphene_frustum_free(p_f: *Frustum) void;
    pub const free = graphene_frustum_free;

    /// Retrieves the planes that define the given `graphene.Frustum`.
    extern fn graphene_frustum_get_planes(p_f: *const Frustum, p_planes: *[6]graphene.Plane) void;
    pub const getPlanes = graphene_frustum_get_planes;

    /// Initializes the given `graphene.Frustum` using the provided
    /// clipping planes.
    extern fn graphene_frustum_init(p_f: *Frustum, p_p0: *const graphene.Plane, p_p1: *const graphene.Plane, p_p2: *const graphene.Plane, p_p3: *const graphene.Plane, p_p4: *const graphene.Plane, p_p5: *const graphene.Plane) *graphene.Frustum;
    pub const init = graphene_frustum_init;

    /// Initializes the given `graphene.Frustum` using the clipping
    /// planes of another `graphene.Frustum`.
    extern fn graphene_frustum_init_from_frustum(p_f: *Frustum, p_src: *const graphene.Frustum) *graphene.Frustum;
    pub const initFromFrustum = graphene_frustum_init_from_frustum;

    /// Initializes a `graphene.Frustum` using the given `matrix`.
    extern fn graphene_frustum_init_from_matrix(p_f: *Frustum, p_matrix: *const graphene.Matrix) *graphene.Frustum;
    pub const initFromMatrix = graphene_frustum_init_from_matrix;

    /// Checks whether the given `box` intersects a plane of
    /// a `graphene.Frustum`.
    extern fn graphene_frustum_intersects_box(p_f: *const Frustum, p_box: *const graphene.Box) bool;
    pub const intersectsBox = graphene_frustum_intersects_box;

    /// Checks whether the given `sphere` intersects a plane of
    /// a `graphene.Frustum`.
    extern fn graphene_frustum_intersects_sphere(p_f: *const Frustum, p_sphere: *const graphene.Sphere) bool;
    pub const intersectsSphere = graphene_frustum_intersects_sphere;

    extern fn graphene_frustum_get_type() usize;
    pub const getGObjectType = graphene_frustum_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure capable of holding a 4x4 matrix.
///
/// The contents of the `graphene.Matrix` structure are private and
/// should never be accessed directly.
pub const Matrix = extern struct {
    f_value: graphene.Simd4X4F,

    /// Allocates a new `graphene.Matrix`.
    extern fn graphene_matrix_alloc() *graphene.Matrix;
    pub const alloc = graphene_matrix_alloc;

    /// Decomposes a transformation matrix into its component transformations.
    ///
    /// The algorithm for decomposing a matrix is taken from the
    /// [CSS3 Transforms specification](http://dev.w3.org/csswg/css-transforms/);
    /// specifically, the decomposition code is based on the equivalent code
    /// published in "Graphics Gems II", edited by Jim Arvo, and
    /// [available online](http://web.archive.org/web/20150512160205/http://tog.acm.org/resources/GraphicsGems/gemsii/unmatrix.c).
    extern fn graphene_matrix_decompose(p_m: *const Matrix, p_translate: *graphene.Vec3, p_scale: *graphene.Vec3, p_rotate: *graphene.Quaternion, p_shear: *graphene.Vec3, p_perspective: *graphene.Vec4) bool;
    pub const decompose = graphene_matrix_decompose;

    /// Computes the determinant of the given matrix.
    extern fn graphene_matrix_determinant(p_m: *const Matrix) f32;
    pub const determinant = graphene_matrix_determinant;

    /// Checks whether the two given `graphene.Matrix` matrices are equal.
    extern fn graphene_matrix_equal(p_a: *const Matrix, p_b: *const graphene.Matrix) bool;
    pub const equal = graphene_matrix_equal;

    /// Checks whether the two given `graphene.Matrix` matrices are
    /// byte-by-byte equal.
    ///
    /// While this function is faster than `graphene.Matrix.equal`, it
    /// can also return false negatives, so it should be used in
    /// conjuction with either `graphene.Matrix.equal` or
    /// `graphene.Matrix.near`. For instance:
    ///
    /// ```
    ///   if (graphene_matrix_equal_fast (a, b))
    ///     {
    ///       // matrices are definitely the same
    ///     }
    ///   else
    ///     {
    ///       if (graphene_matrix_equal (a, b))
    ///         // matrices contain the same values within an epsilon of FLT_EPSILON
    ///       else if (graphene_matrix_near (a, b, 0.0001))
    ///         // matrices contain the same values within an epsilon of 0.0001
    ///       else
    ///         // matrices are not equal
    ///     }
    /// ```
    extern fn graphene_matrix_equal_fast(p_a: *const Matrix, p_b: *const graphene.Matrix) bool;
    pub const equalFast = graphene_matrix_equal_fast;

    /// Frees the resources allocated by `graphene.Matrix.alloc`.
    extern fn graphene_matrix_free(p_m: *Matrix) void;
    pub const free = graphene_matrix_free;

    /// Retrieves the given row vector at `index_` inside a matrix.
    extern fn graphene_matrix_get_row(p_m: *const Matrix, p_index_: c_uint, p_res: *graphene.Vec4) void;
    pub const getRow = graphene_matrix_get_row;

    /// Retrieves the value at the given `row` and `col` index.
    extern fn graphene_matrix_get_value(p_m: *const Matrix, p_row: c_uint, p_col: c_uint) f32;
    pub const getValue = graphene_matrix_get_value;

    /// Retrieves the scaling factor on the X axis in `m`.
    extern fn graphene_matrix_get_x_scale(p_m: *const Matrix) f32;
    pub const getXScale = graphene_matrix_get_x_scale;

    /// Retrieves the translation component on the X axis from `m`.
    extern fn graphene_matrix_get_x_translation(p_m: *const Matrix) f32;
    pub const getXTranslation = graphene_matrix_get_x_translation;

    /// Retrieves the scaling factor on the Y axis in `m`.
    extern fn graphene_matrix_get_y_scale(p_m: *const Matrix) f32;
    pub const getYScale = graphene_matrix_get_y_scale;

    /// Retrieves the translation component on the Y axis from `m`.
    extern fn graphene_matrix_get_y_translation(p_m: *const Matrix) f32;
    pub const getYTranslation = graphene_matrix_get_y_translation;

    /// Retrieves the scaling factor on the Z axis in `m`.
    extern fn graphene_matrix_get_z_scale(p_m: *const Matrix) f32;
    pub const getZScale = graphene_matrix_get_z_scale;

    /// Retrieves the translation component on the Z axis from `m`.
    extern fn graphene_matrix_get_z_translation(p_m: *const Matrix) f32;
    pub const getZTranslation = graphene_matrix_get_z_translation;

    /// Initializes a `graphene.Matrix` from the values of an affine
    /// transformation matrix.
    ///
    /// The arguments map to the following matrix layout:
    ///
    /// ```
    ///   ⎛ xx  yx ⎞   ⎛  a   b  0 ⎞
    ///   ⎜ xy  yy ⎟ = ⎜  c   d  0 ⎟
    ///   ⎝ x0  y0 ⎠   ⎝ tx  ty  1 ⎠
    /// ```
    ///
    /// This function can be used to convert between an affine matrix type
    /// from other libraries and a `graphene.Matrix`.
    extern fn graphene_matrix_init_from_2d(p_m: *Matrix, p_xx: f64, p_yx: f64, p_xy: f64, p_yy: f64, p_x_0: f64, p_y_0: f64) *graphene.Matrix;
    pub const initFrom2d = graphene_matrix_init_from_2d;

    /// Initializes a `graphene.Matrix` with the given array of floating
    /// point values.
    extern fn graphene_matrix_init_from_float(p_m: *Matrix, p_v: *const [16]f32) *graphene.Matrix;
    pub const initFromFloat = graphene_matrix_init_from_float;

    /// Initializes a `graphene.Matrix` using the values of the
    /// given matrix.
    extern fn graphene_matrix_init_from_matrix(p_m: *Matrix, p_src: *const graphene.Matrix) *graphene.Matrix;
    pub const initFromMatrix = graphene_matrix_init_from_matrix;

    /// Initializes a `graphene.Matrix` with the given four row
    /// vectors.
    extern fn graphene_matrix_init_from_vec4(p_m: *Matrix, p_v0: *const graphene.Vec4, p_v1: *const graphene.Vec4, p_v2: *const graphene.Vec4, p_v3: *const graphene.Vec4) *graphene.Matrix;
    pub const initFromVec4 = graphene_matrix_init_from_vec4;

    /// Initializes a `graphene.Matrix` compatible with `graphene.Frustum`.
    ///
    /// See also: `graphene.Frustum.initFromMatrix`
    extern fn graphene_matrix_init_frustum(p_m: *Matrix, p_left: f32, p_right: f32, p_bottom: f32, p_top: f32, p_z_near: f32, p_z_far: f32) *graphene.Matrix;
    pub const initFrustum = graphene_matrix_init_frustum;

    /// Initializes a `graphene.Matrix` with the identity matrix.
    extern fn graphene_matrix_init_identity(p_m: *Matrix) *graphene.Matrix;
    pub const initIdentity = graphene_matrix_init_identity;

    /// Initializes a `graphene.Matrix` so that it positions the "camera"
    /// at the given `eye` coordinates towards an object at the `center`
    /// coordinates. The top of the camera is aligned to the direction
    /// of the `up` vector.
    ///
    /// Before the transform, the camera is assumed to be placed at the
    /// origin, looking towards the negative Z axis, with the top side of
    /// the camera facing in the direction of the Y axis and the right
    /// side in the direction of the X axis.
    ///
    /// In theory, one could use `m` to transform a model of such a camera
    /// into world-space. However, it is more common to use the inverse of
    /// `m` to transform another object from world coordinates to the view
    /// coordinates of the camera. Typically you would then apply the
    /// camera projection transform to get from view to screen
    /// coordinates.
    extern fn graphene_matrix_init_look_at(p_m: *Matrix, p_eye: *const graphene.Vec3, p_center: *const graphene.Vec3, p_up: *const graphene.Vec3) *graphene.Matrix;
    pub const initLookAt = graphene_matrix_init_look_at;

    /// Initializes a `graphene.Matrix` with an orthographic projection.
    extern fn graphene_matrix_init_ortho(p_m: *Matrix, p_left: f32, p_right: f32, p_top: f32, p_bottom: f32, p_z_near: f32, p_z_far: f32) *graphene.Matrix;
    pub const initOrtho = graphene_matrix_init_ortho;

    /// Initializes a `graphene.Matrix` with a perspective projection.
    extern fn graphene_matrix_init_perspective(p_m: *Matrix, p_fovy: f32, p_aspect: f32, p_z_near: f32, p_z_far: f32) *graphene.Matrix;
    pub const initPerspective = graphene_matrix_init_perspective;

    /// Initializes `m` to represent a rotation of `angle` degrees on
    /// the axis represented by the `axis` vector.
    extern fn graphene_matrix_init_rotate(p_m: *Matrix, p_angle: f32, p_axis: *const graphene.Vec3) *graphene.Matrix;
    pub const initRotate = graphene_matrix_init_rotate;

    /// Initializes a `graphene.Matrix` with the given scaling factors.
    extern fn graphene_matrix_init_scale(p_m: *Matrix, p_x: f32, p_y: f32, p_z: f32) *graphene.Matrix;
    pub const initScale = graphene_matrix_init_scale;

    /// Initializes a `graphene.Matrix` with a skew transformation
    /// with the given factors.
    extern fn graphene_matrix_init_skew(p_m: *Matrix, p_x_skew: f32, p_y_skew: f32) *graphene.Matrix;
    pub const initSkew = graphene_matrix_init_skew;

    /// Initializes a `graphene.Matrix` with a translation to the
    /// given coordinates.
    extern fn graphene_matrix_init_translate(p_m: *Matrix, p_p: *const graphene.Point3D) *graphene.Matrix;
    pub const initTranslate = graphene_matrix_init_translate;

    /// Linearly interpolates the two given `graphene.Matrix` by
    /// interpolating the decomposed transformations separately.
    ///
    /// If either matrix cannot be reduced to their transformations
    /// then the interpolation cannot be performed, and this function
    /// will return an identity matrix.
    extern fn graphene_matrix_interpolate(p_a: *const Matrix, p_b: *const graphene.Matrix, p_factor: f64, p_res: *graphene.Matrix) void;
    pub const interpolate = graphene_matrix_interpolate;

    /// Inverts the given matrix.
    extern fn graphene_matrix_inverse(p_m: *const Matrix, p_res: *graphene.Matrix) bool;
    pub const inverse = graphene_matrix_inverse;

    /// Checks whether the given `graphene.Matrix` is compatible with an
    /// a 2D affine transformation matrix.
    extern fn graphene_matrix_is_2d(p_m: *const Matrix) bool;
    pub const is2d = graphene_matrix_is_2d;

    /// Checks whether a `graphene.Matrix` has a visible back face.
    extern fn graphene_matrix_is_backface_visible(p_m: *const Matrix) bool;
    pub const isBackfaceVisible = graphene_matrix_is_backface_visible;

    /// Checks whether the given `graphene.Matrix` is the identity matrix.
    extern fn graphene_matrix_is_identity(p_m: *const Matrix) bool;
    pub const isIdentity = graphene_matrix_is_identity;

    /// Checks whether a matrix is singular.
    extern fn graphene_matrix_is_singular(p_m: *const Matrix) bool;
    pub const isSingular = graphene_matrix_is_singular;

    /// Multiplies two `graphene.Matrix`.
    ///
    /// Matrix multiplication is not commutative in general; the order of the factors matters.
    /// The product of this multiplication is (`a` × `b`)
    extern fn graphene_matrix_multiply(p_a: *const Matrix, p_b: *const graphene.Matrix, p_res: *graphene.Matrix) void;
    pub const multiply = graphene_matrix_multiply;

    /// Compares the two given `graphene.Matrix` matrices and checks
    /// whether their values are within the given `epsilon` of each
    /// other.
    extern fn graphene_matrix_near(p_a: *const Matrix, p_b: *const graphene.Matrix, p_epsilon: f32) bool;
    pub const near = graphene_matrix_near;

    /// Normalizes the given `graphene.Matrix`.
    extern fn graphene_matrix_normalize(p_m: *const Matrix, p_res: *graphene.Matrix) void;
    pub const normalize = graphene_matrix_normalize;

    /// Applies a perspective of `depth` to the matrix.
    extern fn graphene_matrix_perspective(p_m: *const Matrix, p_depth: f32, p_res: *graphene.Matrix) void;
    pub const perspective = graphene_matrix_perspective;

    /// Prints the contents of a matrix to the standard error stream.
    ///
    /// This function is only useful for debugging; there are no guarantees
    /// made on the format of the output.
    extern fn graphene_matrix_print(p_m: *const Matrix) void;
    pub const print = graphene_matrix_print;

    /// Projects a `graphene.Point` using the matrix `m`.
    extern fn graphene_matrix_project_point(p_m: *const Matrix, p_p: *const graphene.Point, p_res: *graphene.Point) void;
    pub const projectPoint = graphene_matrix_project_point;

    /// Projects all corners of a `graphene.Rect` using the given matrix.
    ///
    /// See also: `graphene.Matrix.projectPoint`
    extern fn graphene_matrix_project_rect(p_m: *const Matrix, p_r: *const graphene.Rect, p_res: *graphene.Quad) void;
    pub const projectRect = graphene_matrix_project_rect;

    /// Projects a `graphene.Rect` using the given matrix.
    ///
    /// The resulting rectangle is the axis aligned bounding rectangle capable
    /// of fully containing the projected rectangle.
    extern fn graphene_matrix_project_rect_bounds(p_m: *const Matrix, p_r: *const graphene.Rect, p_res: *graphene.Rect) void;
    pub const projectRectBounds = graphene_matrix_project_rect_bounds;

    /// Adds a rotation transformation to `m`, using the given `angle`
    /// and `axis` vector.
    ///
    /// This is the equivalent of calling `graphene.Matrix.initRotate` and
    /// then multiplying the matrix `m` with the rotation matrix.
    extern fn graphene_matrix_rotate(p_m: *Matrix, p_angle: f32, p_axis: *const graphene.Vec3) void;
    pub const rotate = graphene_matrix_rotate;

    /// Adds a rotation transformation to `m`, using the given
    /// `graphene.Euler`.
    extern fn graphene_matrix_rotate_euler(p_m: *Matrix, p_e: *const graphene.Euler) void;
    pub const rotateEuler = graphene_matrix_rotate_euler;

    /// Adds a rotation transformation to `m`, using the given
    /// `graphene.Quaternion`.
    ///
    /// This is the equivalent of calling `graphene.Quaternion.toMatrix` and
    /// then multiplying `m` with the rotation matrix.
    extern fn graphene_matrix_rotate_quaternion(p_m: *Matrix, p_q: *const graphene.Quaternion) void;
    pub const rotateQuaternion = graphene_matrix_rotate_quaternion;

    /// Adds a rotation transformation around the X axis to `m`, using
    /// the given `angle`.
    ///
    /// See also: `graphene.Matrix.rotate`
    extern fn graphene_matrix_rotate_x(p_m: *Matrix, p_angle: f32) void;
    pub const rotateX = graphene_matrix_rotate_x;

    /// Adds a rotation transformation around the Y axis to `m`, using
    /// the given `angle`.
    ///
    /// See also: `graphene.Matrix.rotate`
    extern fn graphene_matrix_rotate_y(p_m: *Matrix, p_angle: f32) void;
    pub const rotateY = graphene_matrix_rotate_y;

    /// Adds a rotation transformation around the Z axis to `m`, using
    /// the given `angle`.
    ///
    /// See also: `graphene.Matrix.rotate`
    extern fn graphene_matrix_rotate_z(p_m: *Matrix, p_angle: f32) void;
    pub const rotateZ = graphene_matrix_rotate_z;

    /// Adds a scaling transformation to `m`, using the three
    /// given factors.
    ///
    /// This is the equivalent of calling `graphene.Matrix.initScale` and then
    /// multiplying the matrix `m` with the scale matrix.
    extern fn graphene_matrix_scale(p_m: *Matrix, p_factor_x: f32, p_factor_y: f32, p_factor_z: f32) void;
    pub const scale = graphene_matrix_scale;

    /// Adds a skew of `factor` on the X and Y axis to the given matrix.
    extern fn graphene_matrix_skew_xy(p_m: *Matrix, p_factor: f32) void;
    pub const skewXy = graphene_matrix_skew_xy;

    /// Adds a skew of `factor` on the X and Z axis to the given matrix.
    extern fn graphene_matrix_skew_xz(p_m: *Matrix, p_factor: f32) void;
    pub const skewXz = graphene_matrix_skew_xz;

    /// Adds a skew of `factor` on the Y and Z axis to the given matrix.
    extern fn graphene_matrix_skew_yz(p_m: *Matrix, p_factor: f32) void;
    pub const skewYz = graphene_matrix_skew_yz;

    /// Converts a `graphene.Matrix` to an affine transformation
    /// matrix, if the given matrix is compatible.
    ///
    /// The returned values have the following layout:
    ///
    /// ```
    ///   ⎛ xx  yx ⎞   ⎛  a   b  0 ⎞
    ///   ⎜ xy  yy ⎟ = ⎜  c   d  0 ⎟
    ///   ⎝ x0  y0 ⎠   ⎝ tx  ty  1 ⎠
    /// ```
    ///
    /// This function can be used to convert between a `graphene.Matrix`
    /// and an affine matrix type from other libraries.
    extern fn graphene_matrix_to_2d(p_m: *const Matrix, p_xx: *f64, p_yx: *f64, p_xy: *f64, p_yy: *f64, p_x_0: *f64, p_y_0: *f64) bool;
    pub const to2d = graphene_matrix_to_2d;

    /// Converts a `graphene.Matrix` to an array of floating point
    /// values.
    extern fn graphene_matrix_to_float(p_m: *const Matrix, p_v: *[16]f32) void;
    pub const toFloat = graphene_matrix_to_float;

    /// Transforms each corner of a `graphene.Rect` using the given matrix `m`.
    ///
    /// The result is the axis aligned bounding rectangle containing the coplanar
    /// quadrilateral.
    ///
    /// See also: `graphene.Matrix.transformPoint`
    extern fn graphene_matrix_transform_bounds(p_m: *const Matrix, p_r: *const graphene.Rect, p_res: *graphene.Rect) void;
    pub const transformBounds = graphene_matrix_transform_bounds;

    /// Transforms the vertices of a `graphene.Box` using the given matrix `m`.
    ///
    /// The result is the axis aligned bounding box containing the transformed
    /// vertices.
    extern fn graphene_matrix_transform_box(p_m: *const Matrix, p_b: *const graphene.Box, p_res: *graphene.Box) void;
    pub const transformBox = graphene_matrix_transform_box;

    /// Transforms the given `graphene.Point` using the matrix `m`.
    ///
    /// Unlike `graphene.Matrix.transformVec3`, this function will take into
    /// account the fourth row vector of the `graphene.Matrix` when computing
    /// the dot product of each row vector of the matrix.
    ///
    /// See also: `graphene_simd4x4f_point3_mul`
    extern fn graphene_matrix_transform_point(p_m: *const Matrix, p_p: *const graphene.Point, p_res: *graphene.Point) void;
    pub const transformPoint = graphene_matrix_transform_point;

    /// Transforms the given `graphene.Point3D` using the matrix `m`.
    ///
    /// Unlike `graphene.Matrix.transformVec3`, this function will take into
    /// account the fourth row vector of the `graphene.Matrix` when computing
    /// the dot product of each row vector of the matrix.
    ///
    /// See also: `graphene_simd4x4f_point3_mul`
    extern fn graphene_matrix_transform_point3d(p_m: *const Matrix, p_p: *const graphene.Point3D, p_res: *graphene.Point3D) void;
    pub const transformPoint3d = graphene_matrix_transform_point3d;

    /// Transform a `graphene.Ray` using the given matrix `m`.
    extern fn graphene_matrix_transform_ray(p_m: *const Matrix, p_r: *const graphene.Ray, p_res: *graphene.Ray) void;
    pub const transformRay = graphene_matrix_transform_ray;

    /// Transforms each corner of a `graphene.Rect` using the given matrix `m`.
    ///
    /// The result is a coplanar quadrilateral.
    ///
    /// See also: `graphene.Matrix.transformPoint`
    extern fn graphene_matrix_transform_rect(p_m: *const Matrix, p_r: *const graphene.Rect, p_res: *graphene.Quad) void;
    pub const transformRect = graphene_matrix_transform_rect;

    /// Transforms a `graphene.Sphere` using the given matrix `m`. The
    /// result is the bounding sphere containing the transformed sphere.
    extern fn graphene_matrix_transform_sphere(p_m: *const Matrix, p_s: *const graphene.Sphere, p_res: *graphene.Sphere) void;
    pub const transformSphere = graphene_matrix_transform_sphere;

    /// Transforms the given `graphene.Vec3` using the matrix `m`.
    ///
    /// This function will multiply the X, Y, and Z row vectors of the matrix `m`
    /// with the corresponding components of the vector `v`. The W row vector will
    /// be ignored.
    ///
    /// See also: `graphene_simd4x4f_vec3_mul`
    extern fn graphene_matrix_transform_vec3(p_m: *const Matrix, p_v: *const graphene.Vec3, p_res: *graphene.Vec3) void;
    pub const transformVec3 = graphene_matrix_transform_vec3;

    /// Transforms the given `graphene.Vec4` using the matrix `m`.
    ///
    /// See also: `graphene_simd4x4f_vec4_mul`
    extern fn graphene_matrix_transform_vec4(p_m: *const Matrix, p_v: *const graphene.Vec4, p_res: *graphene.Vec4) void;
    pub const transformVec4 = graphene_matrix_transform_vec4;

    /// Adds a translation transformation to `m` using the coordinates
    /// of the given `graphene.Point3D`.
    ///
    /// This is the equivalent of calling `graphene.Matrix.initTranslate` and
    /// then multiplying `m` with the translation matrix.
    extern fn graphene_matrix_translate(p_m: *Matrix, p_pos: *const graphene.Point3D) void;
    pub const translate = graphene_matrix_translate;

    /// Transposes the given matrix.
    extern fn graphene_matrix_transpose(p_m: *const Matrix, p_res: *graphene.Matrix) void;
    pub const transpose = graphene_matrix_transpose;

    /// Unprojects the given `point` using the `projection` matrix and
    /// a `modelview` matrix.
    extern fn graphene_matrix_unproject_point3d(p_projection: *const Matrix, p_modelview: *const graphene.Matrix, p_point: *const graphene.Point3D, p_res: *graphene.Point3D) void;
    pub const unprojectPoint3d = graphene_matrix_unproject_point3d;

    /// Undoes the transformation on the corners of a `graphene.Rect` using the
    /// given matrix, within the given axis aligned rectangular `bounds`.
    extern fn graphene_matrix_untransform_bounds(p_m: *const Matrix, p_r: *const graphene.Rect, p_bounds: *const graphene.Rect, p_res: *graphene.Rect) void;
    pub const untransformBounds = graphene_matrix_untransform_bounds;

    /// Undoes the transformation of a `graphene.Point` using the
    /// given matrix, within the given axis aligned rectangular `bounds`.
    extern fn graphene_matrix_untransform_point(p_m: *const Matrix, p_p: *const graphene.Point, p_bounds: *const graphene.Rect, p_res: *graphene.Point) bool;
    pub const untransformPoint = graphene_matrix_untransform_point;

    extern fn graphene_matrix_get_type() usize;
    pub const getGObjectType = graphene_matrix_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A 2D plane that extends infinitely in a 3D volume.
///
/// The contents of the `graphene_plane_t` are private, and should not be
/// modified directly.
pub const Plane = extern struct {
    f_normal: graphene.Vec3,
    f_constant: f32,

    /// Allocates a new `graphene.Plane` structure.
    ///
    /// The contents of the returned structure are undefined.
    extern fn graphene_plane_alloc() *graphene.Plane;
    pub const alloc = graphene_plane_alloc;

    /// Computes the distance of `point` from a `graphene.Plane`.
    extern fn graphene_plane_distance(p_p: *const Plane, p_point: *const graphene.Point3D) f32;
    pub const distance = graphene_plane_distance;

    /// Checks whether the two given `graphene.Plane` are equal.
    extern fn graphene_plane_equal(p_a: *const Plane, p_b: *const graphene.Plane) bool;
    pub const equal = graphene_plane_equal;

    /// Frees the resources allocated by `graphene.Plane.alloc`.
    extern fn graphene_plane_free(p_p: *Plane) void;
    pub const free = graphene_plane_free;

    /// Retrieves the distance along the normal vector of the
    /// given `graphene.Plane` from the origin.
    extern fn graphene_plane_get_constant(p_p: *const Plane) f32;
    pub const getConstant = graphene_plane_get_constant;

    /// Retrieves the normal vector pointing towards the origin of the
    /// given `graphene.Plane`.
    extern fn graphene_plane_get_normal(p_p: *const Plane, p_normal: *graphene.Vec3) void;
    pub const getNormal = graphene_plane_get_normal;

    /// Initializes the given `graphene.Plane` using the given `normal` vector
    /// and `constant` values.
    extern fn graphene_plane_init(p_p: *Plane, p_normal: ?*const graphene.Vec3, p_constant: f32) *graphene.Plane;
    pub const init = graphene_plane_init;

    /// Initializes the given `graphene.Plane` using the normal
    /// vector and constant of another `graphene.Plane`.
    extern fn graphene_plane_init_from_plane(p_p: *Plane, p_src: *const graphene.Plane) *graphene.Plane;
    pub const initFromPlane = graphene_plane_init_from_plane;

    /// Initializes the given `graphene.Plane` using the given normal vector
    /// and an arbitrary co-planar point.
    extern fn graphene_plane_init_from_point(p_p: *Plane, p_normal: *const graphene.Vec3, p_point: *const graphene.Point3D) *graphene.Plane;
    pub const initFromPoint = graphene_plane_init_from_point;

    /// Initializes the given `graphene.Plane` using the 3 provided co-planar
    /// points.
    ///
    /// The winding order is counter-clockwise, and determines which direction
    /// the normal vector will point.
    extern fn graphene_plane_init_from_points(p_p: *Plane, p_a: *const graphene.Point3D, p_b: *const graphene.Point3D, p_c: *const graphene.Point3D) *graphene.Plane;
    pub const initFromPoints = graphene_plane_init_from_points;

    /// Initializes the given `graphene.Plane` using the components of
    /// the given `graphene.Vec4` vector.
    extern fn graphene_plane_init_from_vec4(p_p: *Plane, p_src: *const graphene.Vec4) *graphene.Plane;
    pub const initFromVec4 = graphene_plane_init_from_vec4;

    /// Negates the normal vector and constant of a `graphene.Plane`, effectively
    /// mirroring the plane across the origin.
    extern fn graphene_plane_negate(p_p: *const Plane, p_res: *graphene.Plane) void;
    pub const negate = graphene_plane_negate;

    /// Normalizes the vector of the given `graphene.Plane`,
    /// and adjusts the constant accordingly.
    extern fn graphene_plane_normalize(p_p: *const Plane, p_res: *graphene.Plane) void;
    pub const normalize = graphene_plane_normalize;

    /// Transforms a `graphene.Plane` `p` using the given `matrix`
    /// and `normal_matrix`.
    ///
    /// If `normal_matrix` is `NULL`, a transformation matrix for the plane
    /// normal will be computed from `matrix`. If you are transforming
    /// multiple planes using the same `matrix` it's recommended to compute
    /// the normal matrix beforehand to avoid incurring in the cost of
    /// recomputing it every time.
    extern fn graphene_plane_transform(p_p: *const Plane, p_matrix: *const graphene.Matrix, p_normal_matrix: ?*const graphene.Matrix, p_res: *graphene.Plane) void;
    pub const transform = graphene_plane_transform;

    extern fn graphene_plane_get_type() usize;
    pub const getGObjectType = graphene_plane_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A point with two coordinates.
pub const Point = extern struct {
    /// the X coordinate of the point
    f_x: f32,
    /// the Y coordinate of the point
    f_y: f32,

    /// Returns a point fixed at (0, 0).
    extern fn graphene_point_zero() *const graphene.Point;
    pub const zero = graphene_point_zero;

    /// Allocates a new `graphene.Point` structure.
    ///
    /// The coordinates of the returned point are (0, 0).
    ///
    /// It's possible to chain this function with `graphene.Point.init`
    /// or `graphene.Point.initFromPoint`, e.g.:
    ///
    /// ```
    ///   graphene_point_t *
    ///   point_new (float x, float y)
    ///   {
    ///     return graphene_point_init (graphene_point_alloc (), x, y);
    ///   }
    ///
    ///   graphene_point_t *
    ///   point_copy (const graphene_point_t *p)
    ///   {
    ///     return graphene_point_init_from_point (graphene_point_alloc (), p);
    ///   }
    /// ```
    extern fn graphene_point_alloc() *graphene.Point;
    pub const alloc = graphene_point_alloc;

    /// Computes the distance between `a` and `b`.
    extern fn graphene_point_distance(p_a: *const Point, p_b: *const graphene.Point, p_d_x: ?*f32, p_d_y: ?*f32) f32;
    pub const distance = graphene_point_distance;

    /// Checks if the two points `a` and `b` point to the same
    /// coordinates.
    ///
    /// This function accounts for floating point fluctuations; if
    /// you want to control the fuzziness of the match, you can use
    /// `graphene.Point.near` instead.
    extern fn graphene_point_equal(p_a: *const Point, p_b: *const graphene.Point) bool;
    pub const equal = graphene_point_equal;

    /// Frees the resources allocated by `graphene.Point.alloc`.
    extern fn graphene_point_free(p_p: *Point) void;
    pub const free = graphene_point_free;

    /// Initializes `p` to the given `x` and `y` coordinates.
    ///
    /// It's safe to call this function multiple times.
    extern fn graphene_point_init(p_p: *Point, p_x: f32, p_y: f32) *graphene.Point;
    pub const init = graphene_point_init;

    /// Initializes `p` with the same coordinates of `src`.
    extern fn graphene_point_init_from_point(p_p: *Point, p_src: *const graphene.Point) *graphene.Point;
    pub const initFromPoint = graphene_point_init_from_point;

    /// Initializes `p` with the coordinates inside the given `graphene.Vec2`.
    extern fn graphene_point_init_from_vec2(p_p: *Point, p_src: *const graphene.Vec2) *graphene.Point;
    pub const initFromVec2 = graphene_point_init_from_vec2;

    /// Linearly interpolates the coordinates of `a` and `b` using the
    /// given `factor`.
    extern fn graphene_point_interpolate(p_a: *const Point, p_b: *const graphene.Point, p_factor: f64, p_res: *graphene.Point) void;
    pub const interpolate = graphene_point_interpolate;

    /// Checks whether the two points `a` and `b` are within
    /// the threshold of `epsilon`.
    extern fn graphene_point_near(p_a: *const Point, p_b: *const graphene.Point, p_epsilon: f32) bool;
    pub const near = graphene_point_near;

    /// Stores the coordinates of the given `graphene.Point` into a
    /// `graphene.Vec2`.
    extern fn graphene_point_to_vec2(p_p: *const Point, p_v: *graphene.Vec2) void;
    pub const toVec2 = graphene_point_to_vec2;

    extern fn graphene_point_get_type() usize;
    pub const getGObjectType = graphene_point_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A point with three components: X, Y, and Z.
pub const Point3D = extern struct {
    /// the X coordinate
    f_x: f32,
    /// the Y coordinate
    f_y: f32,
    /// the Z coordinate
    f_z: f32,

    /// Retrieves a constant point with all three coordinates set to 0.
    extern fn graphene_point3d_zero() *const graphene.Point3D;
    pub const zero = graphene_point3d_zero;

    /// Allocates a `graphene.Point3D` structure.
    extern fn graphene_point3d_alloc() *graphene.Point3D;
    pub const alloc = graphene_point3d_alloc;

    /// Computes the cross product of the two given `graphene.Point3D`.
    extern fn graphene_point3d_cross(p_a: *const Point3D, p_b: *const graphene.Point3D, p_res: *graphene.Point3D) void;
    pub const cross = graphene_point3d_cross;

    /// Computes the distance between the two given `graphene.Point3D`.
    extern fn graphene_point3d_distance(p_a: *const Point3D, p_b: *const graphene.Point3D, p_delta: ?*graphene.Vec3) f32;
    pub const distance = graphene_point3d_distance;

    /// Computes the dot product of the two given `graphene.Point3D`.
    extern fn graphene_point3d_dot(p_a: *const Point3D, p_b: *const graphene.Point3D) f32;
    pub const dot = graphene_point3d_dot;

    /// Checks whether two given points are equal.
    extern fn graphene_point3d_equal(p_a: *const Point3D, p_b: *const graphene.Point3D) bool;
    pub const equal = graphene_point3d_equal;

    /// Frees the resources allocated via `graphene.Point3D.alloc`.
    extern fn graphene_point3d_free(p_p: *Point3D) void;
    pub const free = graphene_point3d_free;

    /// Initializes a `graphene.Point3D` with the given coordinates.
    extern fn graphene_point3d_init(p_p: *Point3D, p_x: f32, p_y: f32, p_z: f32) *graphene.Point3D;
    pub const init = graphene_point3d_init;

    /// Initializes a `graphene.Point3D` using the coordinates of
    /// another `graphene.Point3D`.
    extern fn graphene_point3d_init_from_point(p_p: *Point3D, p_src: *const graphene.Point3D) *graphene.Point3D;
    pub const initFromPoint = graphene_point3d_init_from_point;

    /// Initializes a `graphene.Point3D` using the components
    /// of a `graphene.Vec3`.
    extern fn graphene_point3d_init_from_vec3(p_p: *Point3D, p_v: *const graphene.Vec3) *graphene.Point3D;
    pub const initFromVec3 = graphene_point3d_init_from_vec3;

    /// Linearly interpolates each component of `a` and `b` using the
    /// provided `factor`, and places the result in `res`.
    extern fn graphene_point3d_interpolate(p_a: *const Point3D, p_b: *const graphene.Point3D, p_factor: f64, p_res: *graphene.Point3D) void;
    pub const interpolate = graphene_point3d_interpolate;

    /// Computes the length of the vector represented by the
    /// coordinates of the given `graphene.Point3D`.
    extern fn graphene_point3d_length(p_p: *const Point3D) f32;
    pub const length = graphene_point3d_length;

    /// Checks whether the two points are near each other, within
    /// an `epsilon` factor.
    extern fn graphene_point3d_near(p_a: *const Point3D, p_b: *const graphene.Point3D, p_epsilon: f32) bool;
    pub const near = graphene_point3d_near;

    /// Computes the normalization of the vector represented by the
    /// coordinates of the given `graphene.Point3D`.
    extern fn graphene_point3d_normalize(p_p: *const Point3D, p_res: *graphene.Point3D) void;
    pub const normalize = graphene_point3d_normalize;

    /// Normalizes the coordinates of a `graphene.Point3D` using the
    /// given viewport and clipping planes.
    ///
    /// The coordinates of the resulting `graphene.Point3D` will be
    /// in the [ -1, 1 ] range.
    extern fn graphene_point3d_normalize_viewport(p_p: *const Point3D, p_viewport: *const graphene.Rect, p_z_near: f32, p_z_far: f32, p_res: *graphene.Point3D) void;
    pub const normalizeViewport = graphene_point3d_normalize_viewport;

    /// Scales the coordinates of the given `graphene.Point3D` by
    /// the given `factor`.
    extern fn graphene_point3d_scale(p_p: *const Point3D, p_factor: f32, p_res: *graphene.Point3D) void;
    pub const scale = graphene_point3d_scale;

    /// Stores the coordinates of a `graphene.Point3D` into a
    /// `graphene.Vec3`.
    extern fn graphene_point3d_to_vec3(p_p: *const Point3D, p_v: *graphene.Vec3) void;
    pub const toVec3 = graphene_point3d_to_vec3;

    extern fn graphene_point3d_get_type() usize;
    pub const getGObjectType = graphene_point3d_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A 4 vertex quadrilateral, as represented by four `graphene.Point`.
///
/// The contents of a `graphene.Quad` are private and should never be
/// accessed directly.
pub const Quad = extern struct {
    f_points: [4]graphene.Point,

    /// Allocates a new `graphene.Quad` instance.
    ///
    /// The contents of the returned instance are undefined.
    extern fn graphene_quad_alloc() *graphene.Quad;
    pub const alloc = graphene_quad_alloc;

    /// Computes the bounding rectangle of `q` and places it into `r`.
    extern fn graphene_quad_bounds(p_q: *const Quad, p_r: *graphene.Rect) void;
    pub const bounds = graphene_quad_bounds;

    /// Checks if the given `graphene.Quad` contains the given `graphene.Point`.
    extern fn graphene_quad_contains(p_q: *const Quad, p_p: *const graphene.Point) bool;
    pub const contains = graphene_quad_contains;

    /// Frees the resources allocated by `graphene.Quad.alloc`
    extern fn graphene_quad_free(p_q: *Quad) void;
    pub const free = graphene_quad_free;

    /// Retrieves the point of a `graphene.Quad` at the given index.
    extern fn graphene_quad_get_point(p_q: *const Quad, p_index_: c_uint) *const graphene.Point;
    pub const getPoint = graphene_quad_get_point;

    /// Initializes a `graphene.Quad` with the given points.
    extern fn graphene_quad_init(p_q: *Quad, p_p1: *const graphene.Point, p_p2: *const graphene.Point, p_p3: *const graphene.Point, p_p4: *const graphene.Point) *graphene.Quad;
    pub const init = graphene_quad_init;

    /// Initializes a `graphene.Quad` using an array of points.
    extern fn graphene_quad_init_from_points(p_q: *Quad, p_points: *const [4]graphene.Point) *graphene.Quad;
    pub const initFromPoints = graphene_quad_init_from_points;

    /// Initializes a `graphene.Quad` using the four corners of the
    /// given `graphene.Rect`.
    extern fn graphene_quad_init_from_rect(p_q: *Quad, p_r: *const graphene.Rect) *graphene.Quad;
    pub const initFromRect = graphene_quad_init_from_rect;

    extern fn graphene_quad_get_type() usize;
    pub const getGObjectType = graphene_quad_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A quaternion.
///
/// The contents of the `graphene.Quaternion` structure are private
/// and should never be accessed directly.
pub const Quaternion = extern struct {
    f_x: f32,
    f_y: f32,
    f_z: f32,
    f_w: f32,

    /// Allocates a new `graphene.Quaternion`.
    ///
    /// The contents of the returned value are undefined.
    extern fn graphene_quaternion_alloc() *graphene.Quaternion;
    pub const alloc = graphene_quaternion_alloc;

    /// Adds two `graphene.Quaternion` `a` and `b`.
    extern fn graphene_quaternion_add(p_a: *const Quaternion, p_b: *const graphene.Quaternion, p_res: *graphene.Quaternion) void;
    pub const add = graphene_quaternion_add;

    /// Computes the dot product of two `graphene.Quaternion`.
    extern fn graphene_quaternion_dot(p_a: *const Quaternion, p_b: *const graphene.Quaternion) f32;
    pub const dot = graphene_quaternion_dot;

    /// Checks whether the given quaternions are equal.
    extern fn graphene_quaternion_equal(p_a: *const Quaternion, p_b: *const graphene.Quaternion) bool;
    pub const equal = graphene_quaternion_equal;

    /// Releases the resources allocated by `graphene.Quaternion.alloc`.
    extern fn graphene_quaternion_free(p_q: *Quaternion) void;
    pub const free = graphene_quaternion_free;

    /// Initializes a `graphene.Quaternion` using the given four values.
    extern fn graphene_quaternion_init(p_q: *Quaternion, p_x: f32, p_y: f32, p_z: f32, p_w: f32) *graphene.Quaternion;
    pub const init = graphene_quaternion_init;

    /// Initializes a `graphene.Quaternion` using an `angle` on a
    /// specific `axis`.
    extern fn graphene_quaternion_init_from_angle_vec3(p_q: *Quaternion, p_angle: f32, p_axis: *const graphene.Vec3) *graphene.Quaternion;
    pub const initFromAngleVec3 = graphene_quaternion_init_from_angle_vec3;

    /// Initializes a `graphene.Quaternion` using the values of
    /// the [Euler angles](http://en.wikipedia.org/wiki/Euler_angles)
    /// on each axis.
    ///
    /// See also: `graphene.Quaternion.initFromEuler`
    extern fn graphene_quaternion_init_from_angles(p_q: *Quaternion, p_deg_x: f32, p_deg_y: f32, p_deg_z: f32) *graphene.Quaternion;
    pub const initFromAngles = graphene_quaternion_init_from_angles;

    /// Initializes a `graphene.Quaternion` using the given `graphene.Euler`.
    extern fn graphene_quaternion_init_from_euler(p_q: *Quaternion, p_e: *const graphene.Euler) *graphene.Quaternion;
    pub const initFromEuler = graphene_quaternion_init_from_euler;

    /// Initializes a `graphene.Quaternion` using the rotation components
    /// of a transformation matrix.
    extern fn graphene_quaternion_init_from_matrix(p_q: *Quaternion, p_m: *const graphene.Matrix) *graphene.Quaternion;
    pub const initFromMatrix = graphene_quaternion_init_from_matrix;

    /// Initializes a `graphene.Quaternion` with the values from `src`.
    extern fn graphene_quaternion_init_from_quaternion(p_q: *Quaternion, p_src: *const graphene.Quaternion) *graphene.Quaternion;
    pub const initFromQuaternion = graphene_quaternion_init_from_quaternion;

    /// Initializes a `graphene.Quaternion` using the values of
    /// the [Euler angles](http://en.wikipedia.org/wiki/Euler_angles)
    /// on each axis.
    ///
    /// See also: `graphene.Quaternion.initFromEuler`
    extern fn graphene_quaternion_init_from_radians(p_q: *Quaternion, p_rad_x: f32, p_rad_y: f32, p_rad_z: f32) *graphene.Quaternion;
    pub const initFromRadians = graphene_quaternion_init_from_radians;

    /// Initializes a `graphene.Quaternion` with the values from `src`.
    extern fn graphene_quaternion_init_from_vec4(p_q: *Quaternion, p_src: *const graphene.Vec4) *graphene.Quaternion;
    pub const initFromVec4 = graphene_quaternion_init_from_vec4;

    /// Initializes a `graphene.Quaternion` using the identity
    /// transformation.
    extern fn graphene_quaternion_init_identity(p_q: *Quaternion) *graphene.Quaternion;
    pub const initIdentity = graphene_quaternion_init_identity;

    /// Inverts a `graphene.Quaternion`, and returns the conjugate
    /// quaternion of `q`.
    extern fn graphene_quaternion_invert(p_q: *const Quaternion, p_res: *graphene.Quaternion) void;
    pub const invert = graphene_quaternion_invert;

    /// Multiplies two `graphene.Quaternion` `a` and `b`.
    extern fn graphene_quaternion_multiply(p_a: *const Quaternion, p_b: *const graphene.Quaternion, p_res: *graphene.Quaternion) void;
    pub const multiply = graphene_quaternion_multiply;

    /// Normalizes a `graphene.Quaternion`.
    extern fn graphene_quaternion_normalize(p_q: *const Quaternion, p_res: *graphene.Quaternion) void;
    pub const normalize = graphene_quaternion_normalize;

    /// Scales all the elements of a `graphene.Quaternion` `q` using
    /// the given scalar factor.
    extern fn graphene_quaternion_scale(p_q: *const Quaternion, p_factor: f32, p_res: *graphene.Quaternion) void;
    pub const scale = graphene_quaternion_scale;

    /// Interpolates between the two given quaternions using a spherical
    /// linear interpolation, or [SLERP](http://en.wikipedia.org/wiki/Slerp),
    /// using the given interpolation `factor`.
    extern fn graphene_quaternion_slerp(p_a: *const Quaternion, p_b: *const graphene.Quaternion, p_factor: f32, p_res: *graphene.Quaternion) void;
    pub const slerp = graphene_quaternion_slerp;

    /// Converts a quaternion into an `angle`, `axis` pair.
    extern fn graphene_quaternion_to_angle_vec3(p_q: *const Quaternion, p_angle: *f32, p_axis: *graphene.Vec3) void;
    pub const toAngleVec3 = graphene_quaternion_to_angle_vec3;

    /// Converts a `graphene.Quaternion` to its corresponding rotations
    /// on the [Euler angles](http://en.wikipedia.org/wiki/Euler_angles)
    /// on each axis.
    extern fn graphene_quaternion_to_angles(p_q: *const Quaternion, p_deg_x: ?*f32, p_deg_y: ?*f32, p_deg_z: ?*f32) void;
    pub const toAngles = graphene_quaternion_to_angles;

    /// Converts a quaternion into a transformation matrix expressing
    /// the rotation defined by the `graphene.Quaternion`.
    extern fn graphene_quaternion_to_matrix(p_q: *const Quaternion, p_m: *graphene.Matrix) void;
    pub const toMatrix = graphene_quaternion_to_matrix;

    /// Converts a `graphene.Quaternion` to its corresponding rotations
    /// on the [Euler angles](http://en.wikipedia.org/wiki/Euler_angles)
    /// on each axis.
    extern fn graphene_quaternion_to_radians(p_q: *const Quaternion, p_rad_x: ?*f32, p_rad_y: ?*f32, p_rad_z: ?*f32) void;
    pub const toRadians = graphene_quaternion_to_radians;

    /// Copies the components of a `graphene.Quaternion` into a
    /// `graphene.Vec4`.
    extern fn graphene_quaternion_to_vec4(p_q: *const Quaternion, p_res: *graphene.Vec4) void;
    pub const toVec4 = graphene_quaternion_to_vec4;

    extern fn graphene_quaternion_get_type() usize;
    pub const getGObjectType = graphene_quaternion_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A ray emitted from an origin in a given direction.
///
/// The contents of the `graphene_ray_t` structure are private, and should not
/// be modified directly.
pub const Ray = extern struct {
    f_origin: graphene.Vec3,
    f_direction: graphene.Vec3,

    /// Allocates a new `graphene.Ray` structure.
    ///
    /// The contents of the returned structure are undefined.
    extern fn graphene_ray_alloc() *graphene.Ray;
    pub const alloc = graphene_ray_alloc;

    /// Checks whether the two given `graphene.Ray` are equal.
    extern fn graphene_ray_equal(p_a: *const Ray, p_b: *const graphene.Ray) bool;
    pub const equal = graphene_ray_equal;

    /// Frees the resources allocated by `graphene.Ray.alloc`.
    extern fn graphene_ray_free(p_r: *Ray) void;
    pub const free = graphene_ray_free;

    /// Computes the point on the given `graphene.Ray` that is closest to the
    /// given point `p`.
    extern fn graphene_ray_get_closest_point_to_point(p_r: *const Ray, p_p: *const graphene.Point3D, p_res: *graphene.Point3D) void;
    pub const getClosestPointToPoint = graphene_ray_get_closest_point_to_point;

    /// Retrieves the direction of the given `graphene.Ray`.
    extern fn graphene_ray_get_direction(p_r: *const Ray, p_direction: *graphene.Vec3) void;
    pub const getDirection = graphene_ray_get_direction;

    /// Computes the distance of the origin of the given `graphene.Ray` from the
    /// given plane.
    ///
    /// If the ray does not intersect the plane, this function returns `INFINITY`.
    extern fn graphene_ray_get_distance_to_plane(p_r: *const Ray, p_p: *const graphene.Plane) f32;
    pub const getDistanceToPlane = graphene_ray_get_distance_to_plane;

    /// Computes the distance of the closest approach between the
    /// given `graphene.Ray` `r` and the point `p`.
    ///
    /// The closest approach to a ray from a point is the distance
    /// between the point and the projection of the point on the
    /// ray itself.
    extern fn graphene_ray_get_distance_to_point(p_r: *const Ray, p_p: *const graphene.Point3D) f32;
    pub const getDistanceToPoint = graphene_ray_get_distance_to_point;

    /// Retrieves the origin of the given `graphene.Ray`.
    extern fn graphene_ray_get_origin(p_r: *const Ray, p_origin: *graphene.Point3D) void;
    pub const getOrigin = graphene_ray_get_origin;

    /// Retrieves the coordinates of a point at the distance `t` along the
    /// given `graphene.Ray`.
    extern fn graphene_ray_get_position_at(p_r: *const Ray, p_t: f32, p_position: *graphene.Point3D) void;
    pub const getPositionAt = graphene_ray_get_position_at;

    /// Initializes the given `graphene.Ray` using the given `origin`
    /// and `direction` values.
    extern fn graphene_ray_init(p_r: *Ray, p_origin: ?*const graphene.Point3D, p_direction: ?*const graphene.Vec3) *graphene.Ray;
    pub const init = graphene_ray_init;

    /// Initializes the given `graphene.Ray` using the origin and direction
    /// values of another `graphene.Ray`.
    extern fn graphene_ray_init_from_ray(p_r: *Ray, p_src: *const graphene.Ray) *graphene.Ray;
    pub const initFromRay = graphene_ray_init_from_ray;

    /// Initializes the given `graphene.Ray` using the given vectors.
    extern fn graphene_ray_init_from_vec3(p_r: *Ray, p_origin: ?*const graphene.Vec3, p_direction: ?*const graphene.Vec3) *graphene.Ray;
    pub const initFromVec3 = graphene_ray_init_from_vec3;

    /// Intersects the given `graphene.Ray` `r` with the given
    /// `graphene.Box` `b`.
    extern fn graphene_ray_intersect_box(p_r: *const Ray, p_b: *const graphene.Box, p_t_out: *f32) graphene.RayIntersectionKind;
    pub const intersectBox = graphene_ray_intersect_box;

    /// Intersects the given `graphene.Ray` `r` with the given
    /// `graphene.Sphere` `s`.
    extern fn graphene_ray_intersect_sphere(p_r: *const Ray, p_s: *const graphene.Sphere, p_t_out: *f32) graphene.RayIntersectionKind;
    pub const intersectSphere = graphene_ray_intersect_sphere;

    /// Intersects the given `graphene.Ray` `r` with the given
    /// `graphene.Triangle` `t`.
    extern fn graphene_ray_intersect_triangle(p_r: *const Ray, p_t: *const graphene.Triangle, p_t_out: *f32) graphene.RayIntersectionKind;
    pub const intersectTriangle = graphene_ray_intersect_triangle;

    /// Checks whether the given `graphene.Ray` `r` intersects the
    /// given `graphene.Box` `b`.
    ///
    /// See also: `graphene.Ray.intersectBox`
    extern fn graphene_ray_intersects_box(p_r: *const Ray, p_b: *const graphene.Box) bool;
    pub const intersectsBox = graphene_ray_intersects_box;

    /// Checks if the given `graphene.Ray` `r` intersects the
    /// given `graphene.Sphere` `s`.
    ///
    /// See also: `graphene.Ray.intersectSphere`
    extern fn graphene_ray_intersects_sphere(p_r: *const Ray, p_s: *const graphene.Sphere) bool;
    pub const intersectsSphere = graphene_ray_intersects_sphere;

    /// Checks whether the given `graphene.Ray` `r` intersects the
    /// given `graphene.Triangle` `b`.
    ///
    /// See also: `graphene.Ray.intersectTriangle`
    extern fn graphene_ray_intersects_triangle(p_r: *const Ray, p_t: *const graphene.Triangle) bool;
    pub const intersectsTriangle = graphene_ray_intersects_triangle;

    extern fn graphene_ray_get_type() usize;
    pub const getGObjectType = graphene_ray_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The location and size of a rectangle region.
///
/// The width and height of a `graphene.Rect` can be negative; for instance,
/// a `graphene.Rect` with an origin of [ 0, 0 ] and a size of [ 10, 10 ] is
/// equivalent to a `graphene.Rect` with an origin of [ 10, 10 ] and a size
/// of [ -10, -10 ].
///
/// Application code can normalize rectangles using `graphene.Rect.normalize`;
/// this function will ensure that the width and height of a rectangle are
/// positive values. All functions taking a `graphene.Rect` as an argument
/// will internally operate on a normalized copy; all functions returning a
/// `graphene.Rect` will always return a normalized rectangle.
pub const Rect = extern struct {
    /// the coordinates of the origin of the rectangle
    f_origin: graphene.Point,
    /// the size of the rectangle
    f_size: graphene.Size,

    /// Allocates a new `graphene.Rect`.
    ///
    /// The contents of the returned rectangle are undefined.
    extern fn graphene_rect_alloc() *graphene.Rect;
    pub const alloc = graphene_rect_alloc;

    /// Returns a degenerate rectangle with origin fixed at (0, 0) and
    /// a size of 0, 0.
    extern fn graphene_rect_zero() *const graphene.Rect;
    pub const zero = graphene_rect_zero;

    /// Checks whether a `graphene.Rect` contains the given coordinates.
    extern fn graphene_rect_contains_point(p_r: *const Rect, p_p: *const graphene.Point) bool;
    pub const containsPoint = graphene_rect_contains_point;

    /// Checks whether a `graphene.Rect` fully contains the given
    /// rectangle.
    extern fn graphene_rect_contains_rect(p_a: *const Rect, p_b: *const graphene.Rect) bool;
    pub const containsRect = graphene_rect_contains_rect;

    /// Checks whether the two given rectangle are equal.
    extern fn graphene_rect_equal(p_a: *const Rect, p_b: *const graphene.Rect) bool;
    pub const equal = graphene_rect_equal;

    /// Expands a `graphene.Rect` to contain the given `graphene.Point`.
    extern fn graphene_rect_expand(p_r: *const Rect, p_p: *const graphene.Point, p_res: *graphene.Rect) void;
    pub const expand = graphene_rect_expand;

    /// Frees the resources allocated by `graphene.rectAlloc`.
    extern fn graphene_rect_free(p_r: *Rect) void;
    pub const free = graphene_rect_free;

    /// Compute the area of given normalized rectangle.
    extern fn graphene_rect_get_area(p_r: *const Rect) f32;
    pub const getArea = graphene_rect_get_area;

    /// Retrieves the coordinates of the bottom-left corner of the given rectangle.
    extern fn graphene_rect_get_bottom_left(p_r: *const Rect, p_p: *graphene.Point) void;
    pub const getBottomLeft = graphene_rect_get_bottom_left;

    /// Retrieves the coordinates of the bottom-right corner of the given rectangle.
    extern fn graphene_rect_get_bottom_right(p_r: *const Rect, p_p: *graphene.Point) void;
    pub const getBottomRight = graphene_rect_get_bottom_right;

    /// Retrieves the coordinates of the center of the given rectangle.
    extern fn graphene_rect_get_center(p_r: *const Rect, p_p: *graphene.Point) void;
    pub const getCenter = graphene_rect_get_center;

    /// Retrieves the normalized height of the given rectangle.
    extern fn graphene_rect_get_height(p_r: *const Rect) f32;
    pub const getHeight = graphene_rect_get_height;

    /// Retrieves the coordinates of the top-left corner of the given rectangle.
    extern fn graphene_rect_get_top_left(p_r: *const Rect, p_p: *graphene.Point) void;
    pub const getTopLeft = graphene_rect_get_top_left;

    /// Retrieves the coordinates of the top-right corner of the given rectangle.
    extern fn graphene_rect_get_top_right(p_r: *const Rect, p_p: *graphene.Point) void;
    pub const getTopRight = graphene_rect_get_top_right;

    /// Computes the four vertices of a `graphene.Rect`.
    extern fn graphene_rect_get_vertices(p_r: *const Rect, p_vertices: *[4]graphene.Vec2) void;
    pub const getVertices = graphene_rect_get_vertices;

    /// Retrieves the normalized width of the given rectangle.
    extern fn graphene_rect_get_width(p_r: *const Rect) f32;
    pub const getWidth = graphene_rect_get_width;

    /// Retrieves the normalized X coordinate of the origin of the given
    /// rectangle.
    extern fn graphene_rect_get_x(p_r: *const Rect) f32;
    pub const getX = graphene_rect_get_x;

    /// Retrieves the normalized Y coordinate of the origin of the given
    /// rectangle.
    extern fn graphene_rect_get_y(p_r: *const Rect) f32;
    pub const getY = graphene_rect_get_y;

    /// Initializes the given `graphene.Rect` with the given values.
    ///
    /// This function will implicitly normalize the `graphene.Rect`
    /// before returning.
    extern fn graphene_rect_init(p_r: *Rect, p_x: f32, p_y: f32, p_width: f32, p_height: f32) *graphene.Rect;
    pub const init = graphene_rect_init;

    /// Initializes `r` using the given `src` rectangle.
    ///
    /// This function will implicitly normalize the `graphene.Rect`
    /// before returning.
    extern fn graphene_rect_init_from_rect(p_r: *Rect, p_src: *const graphene.Rect) *graphene.Rect;
    pub const initFromRect = graphene_rect_init_from_rect;

    /// Changes the given rectangle to be smaller, or larger depending on the
    /// given inset parameters.
    ///
    /// To create an inset rectangle, use positive `d_x` or `d_y` values; to
    /// create a larger, encompassing rectangle, use negative `d_x` or `d_y`
    /// values.
    ///
    /// The origin of the rectangle is offset by `d_x` and `d_y`, while the size
    /// is adjusted by `(2 * `d_x`, 2 * `d_y`)`. If `d_x` and `d_y` are positive
    /// values, the size of the rectangle is decreased; if `d_x` and `d_y` are
    /// negative values, the size of the rectangle is increased.
    ///
    /// If the size of the resulting inset rectangle has a negative width or
    /// height then the size will be set to zero.
    extern fn graphene_rect_inset(p_r: *Rect, p_d_x: f32, p_d_y: f32) *graphene.Rect;
    pub const inset = graphene_rect_inset;

    /// Changes the given rectangle to be smaller, or larger depending on the
    /// given inset parameters.
    ///
    /// To create an inset rectangle, use positive `d_x` or `d_y` values; to
    /// create a larger, encompassing rectangle, use negative `d_x` or `d_y`
    /// values.
    ///
    /// The origin of the rectangle is offset by `d_x` and `d_y`, while the size
    /// is adjusted by `(2 * `d_x`, 2 * `d_y`)`. If `d_x` and `d_y` are positive
    /// values, the size of the rectangle is decreased; if `d_x` and `d_y` are
    /// negative values, the size of the rectangle is increased.
    ///
    /// If the size of the resulting inset rectangle has a negative width or
    /// height then the size will be set to zero.
    extern fn graphene_rect_inset_r(p_r: *const Rect, p_d_x: f32, p_d_y: f32, p_res: *graphene.Rect) void;
    pub const insetR = graphene_rect_inset_r;

    /// Linearly interpolates the origin and size of the two given
    /// rectangles.
    extern fn graphene_rect_interpolate(p_a: *const Rect, p_b: *const graphene.Rect, p_factor: f64, p_res: *graphene.Rect) void;
    pub const interpolate = graphene_rect_interpolate;

    /// Computes the intersection of the two given rectangles.
    ///
    /// ![](rectangle-intersection.png)
    ///
    /// The intersection in the image above is the blue outline.
    ///
    /// If the two rectangles do not intersect, `res` will contain
    /// a degenerate rectangle with origin in (0, 0) and a size of 0.
    extern fn graphene_rect_intersection(p_a: *const Rect, p_b: *const graphene.Rect, p_res: ?*graphene.Rect) bool;
    pub const intersection = graphene_rect_intersection;

    /// Normalizes the passed rectangle.
    ///
    /// This function ensures that the size of the rectangle is made of
    /// positive values, and that the origin is the top-left corner of
    /// the rectangle.
    extern fn graphene_rect_normalize(p_r: *Rect) *graphene.Rect;
    pub const normalize = graphene_rect_normalize;

    /// Normalizes the passed rectangle.
    ///
    /// This function ensures that the size of the rectangle is made of
    /// positive values, and that the origin is in the top-left corner
    /// of the rectangle.
    extern fn graphene_rect_normalize_r(p_r: *const Rect, p_res: *graphene.Rect) void;
    pub const normalizeR = graphene_rect_normalize_r;

    /// Offsets the origin by `d_x` and `d_y`.
    ///
    /// The size of the rectangle is unchanged.
    extern fn graphene_rect_offset(p_r: *Rect, p_d_x: f32, p_d_y: f32) *graphene.Rect;
    pub const offset = graphene_rect_offset;

    /// Offsets the origin of the given rectangle by `d_x` and `d_y`.
    ///
    /// The size of the rectangle is left unchanged.
    extern fn graphene_rect_offset_r(p_r: *const Rect, p_d_x: f32, p_d_y: f32, p_res: *graphene.Rect) void;
    pub const offsetR = graphene_rect_offset_r;

    /// Rounds the origin and size of the given rectangle to
    /// their nearest integer values; the rounding is guaranteed
    /// to be large enough to have an area bigger or equal to the
    /// original rectangle, but might not fully contain its extents.
    /// Use `graphene.Rect.roundExtents` in case you need to round
    /// to a rectangle that covers fully the original one.
    ///
    /// This function is the equivalent of calling `floor` on
    /// the coordinates of the origin, and `ceil` on the size.
    extern fn graphene_rect_round(p_r: *const Rect, p_res: *graphene.Rect) void;
    pub const round = graphene_rect_round;

    /// Rounds the origin of the given rectangle to its nearest
    /// integer value and and recompute the size so that the
    /// rectangle is large enough to contain all the conrners
    /// of the original rectangle.
    ///
    /// This function is the equivalent of calling `floor` on
    /// the coordinates of the origin, and recomputing the size
    /// calling `ceil` on the bottom-right coordinates.
    ///
    /// If you want to be sure that the rounded rectangle
    /// completely covers the area that was covered by the
    /// original rectangle — i.e. you want to cover the area
    /// including all its corners — this function will make sure
    /// that the size is recomputed taking into account the ceiling
    /// of the coordinates of the bottom-right corner.
    /// If the difference between the original coordinates and the
    /// coordinates of the rounded rectangle is greater than the
    /// difference between the original size and and the rounded
    /// size, then the move of the origin would not be compensated
    /// by a move in the anti-origin, leaving the corners of the
    /// original rectangle outside the rounded one.
    extern fn graphene_rect_round_extents(p_r: *const Rect, p_res: *graphene.Rect) void;
    pub const roundExtents = graphene_rect_round_extents;

    /// Rounds the origin and the size of the given rectangle to
    /// their nearest integer values; the rounding is guaranteed
    /// to be large enough to contain the original rectangle.
    extern fn graphene_rect_round_to_pixel(p_r: *Rect) *graphene.Rect;
    pub const roundToPixel = graphene_rect_round_to_pixel;

    /// Scales the size and origin of a rectangle horizontaly by `s_h`,
    /// and vertically by `s_v`. The result `res` is normalized.
    extern fn graphene_rect_scale(p_r: *const Rect, p_s_h: f32, p_s_v: f32, p_res: *graphene.Rect) void;
    pub const scale = graphene_rect_scale;

    /// Computes the union of the two given rectangles.
    ///
    /// ![](rectangle-union.png)
    ///
    /// The union in the image above is the blue outline.
    extern fn graphene_rect_union(p_a: *const Rect, p_b: *const graphene.Rect, p_res: *graphene.Rect) void;
    pub const @"union" = graphene_rect_union;

    extern fn graphene_rect_get_type() usize;
    pub const getGObjectType = graphene_rect_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Simd4F = extern struct {
    f_x: f32,
    f_y: f32,
    f_z: f32,
    f_w: f32,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Simd4X4F = extern struct {
    f_x: graphene.Simd4F,
    f_y: graphene.Simd4F,
    f_z: graphene.Simd4F,
    f_w: graphene.Simd4F,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A size.
pub const Size = extern struct {
    /// the width
    f_width: f32,
    /// the height
    f_height: f32,

    /// A constant pointer to a zero `graphene.Size`, useful for
    /// equality checks and interpolations.
    extern fn graphene_size_zero() *const graphene.Size;
    pub const zero = graphene_size_zero;

    /// Allocates a new `graphene.Size`.
    ///
    /// The contents of the returned value are undefined.
    extern fn graphene_size_alloc() *graphene.Size;
    pub const alloc = graphene_size_alloc;

    /// Checks whether the two give `graphene.Size` are equal.
    extern fn graphene_size_equal(p_a: *const Size, p_b: *const graphene.Size) bool;
    pub const equal = graphene_size_equal;

    /// Frees the resources allocated by `graphene.Size.alloc`.
    extern fn graphene_size_free(p_s: *Size) void;
    pub const free = graphene_size_free;

    /// Initializes a `graphene.Size` using the given `width` and `height`.
    extern fn graphene_size_init(p_s: *Size, p_width: f32, p_height: f32) *graphene.Size;
    pub const init = graphene_size_init;

    /// Initializes a `graphene.Size` using the width and height of
    /// the given `src`.
    extern fn graphene_size_init_from_size(p_s: *Size, p_src: *const graphene.Size) *graphene.Size;
    pub const initFromSize = graphene_size_init_from_size;

    /// Linearly interpolates the two given `graphene.Size` using the given
    /// interpolation `factor`.
    extern fn graphene_size_interpolate(p_a: *const Size, p_b: *const graphene.Size, p_factor: f64, p_res: *graphene.Size) void;
    pub const interpolate = graphene_size_interpolate;

    /// Scales the components of a `graphene.Size` using the given `factor`.
    extern fn graphene_size_scale(p_s: *const Size, p_factor: f32, p_res: *graphene.Size) void;
    pub const scale = graphene_size_scale;

    extern fn graphene_size_get_type() usize;
    pub const getGObjectType = graphene_size_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A sphere, represented by its center and radius.
pub const Sphere = extern struct {
    f_center: graphene.Vec3,
    f_radius: f32,

    /// Allocates a new `graphene.Sphere`.
    ///
    /// The contents of the newly allocated structure are undefined.
    extern fn graphene_sphere_alloc() *graphene.Sphere;
    pub const alloc = graphene_sphere_alloc;

    /// Checks whether the given `point` is contained in the volume
    /// of a `graphene.Sphere`.
    extern fn graphene_sphere_contains_point(p_s: *const Sphere, p_point: *const graphene.Point3D) bool;
    pub const containsPoint = graphene_sphere_contains_point;

    /// Computes the distance of the given `point` from the surface of
    /// a `graphene.Sphere`.
    extern fn graphene_sphere_distance(p_s: *const Sphere, p_point: *const graphene.Point3D) f32;
    pub const distance = graphene_sphere_distance;

    /// Checks whether two `graphene.Sphere` are equal.
    extern fn graphene_sphere_equal(p_a: *const Sphere, p_b: *const graphene.Sphere) bool;
    pub const equal = graphene_sphere_equal;

    /// Frees the resources allocated by `graphene.Sphere.alloc`.
    extern fn graphene_sphere_free(p_s: *Sphere) void;
    pub const free = graphene_sphere_free;

    /// Computes the bounding box capable of containing the
    /// given `graphene.Sphere`.
    extern fn graphene_sphere_get_bounding_box(p_s: *const Sphere, p_box: *graphene.Box) void;
    pub const getBoundingBox = graphene_sphere_get_bounding_box;

    /// Retrieves the coordinates of the center of a `graphene.Sphere`.
    extern fn graphene_sphere_get_center(p_s: *const Sphere, p_center: *graphene.Point3D) void;
    pub const getCenter = graphene_sphere_get_center;

    /// Retrieves the radius of a `graphene.Sphere`.
    extern fn graphene_sphere_get_radius(p_s: *const Sphere) f32;
    pub const getRadius = graphene_sphere_get_radius;

    /// Initializes the given `graphene.Sphere` with the given `center` and `radius`.
    extern fn graphene_sphere_init(p_s: *Sphere, p_center: ?*const graphene.Point3D, p_radius: f32) *graphene.Sphere;
    pub const init = graphene_sphere_init;

    /// Initializes the given `graphene.Sphere` using the given array
    /// of 3D coordinates so that the sphere includes them.
    ///
    /// The center of the sphere can either be specified, or will be center
    /// of the 3D volume that encompasses all `points`.
    extern fn graphene_sphere_init_from_points(p_s: *Sphere, p_n_points: c_uint, p_points: [*]const graphene.Point3D, p_center: ?*const graphene.Point3D) *graphene.Sphere;
    pub const initFromPoints = graphene_sphere_init_from_points;

    /// Initializes the given `graphene.Sphere` using the given array
    /// of 3D coordinates so that the sphere includes them.
    ///
    /// The center of the sphere can either be specified, or will be center
    /// of the 3D volume that encompasses all `vectors`.
    extern fn graphene_sphere_init_from_vectors(p_s: *Sphere, p_n_vectors: c_uint, p_vectors: [*]const graphene.Vec3, p_center: ?*const graphene.Point3D) *graphene.Sphere;
    pub const initFromVectors = graphene_sphere_init_from_vectors;

    /// Checks whether the sphere has a zero radius.
    extern fn graphene_sphere_is_empty(p_s: *const Sphere) bool;
    pub const isEmpty = graphene_sphere_is_empty;

    /// Translates the center of the given `graphene.Sphere` using the `point`
    /// coordinates as the delta of the translation.
    extern fn graphene_sphere_translate(p_s: *const Sphere, p_point: *const graphene.Point3D, p_res: *graphene.Sphere) void;
    pub const translate = graphene_sphere_translate;

    extern fn graphene_sphere_get_type() usize;
    pub const getGObjectType = graphene_sphere_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A triangle.
pub const Triangle = extern struct {
    f_a: graphene.Vec3,
    f_b: graphene.Vec3,
    f_c: graphene.Vec3,

    /// Allocates a new `graphene.Triangle`.
    ///
    /// The contents of the returned structure are undefined.
    extern fn graphene_triangle_alloc() *graphene.Triangle;
    pub const alloc = graphene_triangle_alloc;

    /// Checks whether the given triangle `t` contains the point `p`.
    extern fn graphene_triangle_contains_point(p_t: *const Triangle, p_p: *const graphene.Point3D) bool;
    pub const containsPoint = graphene_triangle_contains_point;

    /// Checks whether the two given `graphene.Triangle` are equal.
    extern fn graphene_triangle_equal(p_a: *const Triangle, p_b: *const graphene.Triangle) bool;
    pub const equal = graphene_triangle_equal;

    /// Frees the resources allocated by `graphene.Triangle.alloc`.
    extern fn graphene_triangle_free(p_t: *Triangle) void;
    pub const free = graphene_triangle_free;

    /// Computes the area of the given `graphene.Triangle`.
    extern fn graphene_triangle_get_area(p_t: *const Triangle) f32;
    pub const getArea = graphene_triangle_get_area;

    /// Computes the [barycentric coordinates](http://en.wikipedia.org/wiki/Barycentric_coordinate_system)
    /// of the given point `p`.
    ///
    /// The point `p` must lie on the same plane as the triangle `t`; if the
    /// point is not coplanar, the result of this function is undefined.
    ///
    /// If we place the origin in the coordinates of the triangle's A point,
    /// the barycentric coordinates are `u`, which is on the AC vector; and `v`
    /// which is on the AB vector:
    ///
    /// ![](triangle-barycentric.png)
    ///
    /// The returned `graphene.Vec2` contains the following values, in order:
    ///
    ///  - `res.x = u`
    ///  - `res.y = v`
    extern fn graphene_triangle_get_barycoords(p_t: *const Triangle, p_p: ?*const graphene.Point3D, p_res: *graphene.Vec2) bool;
    pub const getBarycoords = graphene_triangle_get_barycoords;

    /// Computes the bounding box of the given `graphene.Triangle`.
    extern fn graphene_triangle_get_bounding_box(p_t: *const Triangle, p_res: *graphene.Box) void;
    pub const getBoundingBox = graphene_triangle_get_bounding_box;

    /// Computes the coordinates of the midpoint of the given `graphene.Triangle`.
    ///
    /// The midpoint G is the [centroid](https://en.wikipedia.org/wiki/Centroid`Triangle_centroid`)
    /// of the triangle, i.e. the intersection of its medians.
    extern fn graphene_triangle_get_midpoint(p_t: *const Triangle, p_res: *graphene.Point3D) void;
    pub const getMidpoint = graphene_triangle_get_midpoint;

    /// Computes the normal vector of the given `graphene.Triangle`.
    extern fn graphene_triangle_get_normal(p_t: *const Triangle, p_res: *graphene.Vec3) void;
    pub const getNormal = graphene_triangle_get_normal;

    /// Computes the plane based on the vertices of the given `graphene.Triangle`.
    extern fn graphene_triangle_get_plane(p_t: *const Triangle, p_res: *graphene.Plane) void;
    pub const getPlane = graphene_triangle_get_plane;

    /// Retrieves the three vertices of the given `graphene.Triangle` and returns
    /// their coordinates as `graphene.Point3D`.
    extern fn graphene_triangle_get_points(p_t: *const Triangle, p_a: ?*graphene.Point3D, p_b: ?*graphene.Point3D, p_c: ?*graphene.Point3D) void;
    pub const getPoints = graphene_triangle_get_points;

    /// Computes the UV coordinates of the given point `p`.
    ///
    /// The point `p` must lie on the same plane as the triangle `t`; if the point
    /// is not coplanar, the result of this function is undefined. If `p` is `NULL`,
    /// the point will be set in (0, 0, 0).
    ///
    /// The UV coordinates will be placed in the `res` vector:
    ///
    ///  - `res.x = u`
    ///  - `res.y = v`
    ///
    /// See also: `graphene.Triangle.getBarycoords`
    extern fn graphene_triangle_get_uv(p_t: *const Triangle, p_p: ?*const graphene.Point3D, p_uv_a: *const graphene.Vec2, p_uv_b: *const graphene.Vec2, p_uv_c: *const graphene.Vec2, p_res: *graphene.Vec2) bool;
    pub const getUv = graphene_triangle_get_uv;

    /// Retrieves the three vertices of the given `graphene.Triangle`.
    extern fn graphene_triangle_get_vertices(p_t: *const Triangle, p_a: ?*graphene.Vec3, p_b: ?*graphene.Vec3, p_c: ?*graphene.Vec3) void;
    pub const getVertices = graphene_triangle_get_vertices;

    /// Initializes a `graphene.Triangle` using the three given arrays
    /// of floating point values, each representing the coordinates of
    /// a point in 3D space.
    extern fn graphene_triangle_init_from_float(p_t: *Triangle, p_a: *const [3]f32, p_b: *const [3]f32, p_c: *const [3]f32) *graphene.Triangle;
    pub const initFromFloat = graphene_triangle_init_from_float;

    /// Initializes a `graphene.Triangle` using the three given 3D points.
    extern fn graphene_triangle_init_from_point3d(p_t: *Triangle, p_a: ?*const graphene.Point3D, p_b: ?*const graphene.Point3D, p_c: ?*const graphene.Point3D) *graphene.Triangle;
    pub const initFromPoint3d = graphene_triangle_init_from_point3d;

    /// Initializes a `graphene.Triangle` using the three given vectors.
    extern fn graphene_triangle_init_from_vec3(p_t: *Triangle, p_a: ?*const graphene.Vec3, p_b: ?*const graphene.Vec3, p_c: ?*const graphene.Vec3) *graphene.Triangle;
    pub const initFromVec3 = graphene_triangle_init_from_vec3;

    extern fn graphene_triangle_get_type() usize;
    pub const getGObjectType = graphene_triangle_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure capable of holding a vector with two dimensions, x and y.
///
/// The contents of the `graphene.Vec2` structure are private and should
/// never be accessed directly.
pub const Vec2 = extern struct {
    f_value: graphene.Simd4F,

    /// Retrieves a constant vector with (1, 1) components.
    extern fn graphene_vec2_one() *const graphene.Vec2;
    pub const one = graphene_vec2_one;

    /// Retrieves a constant vector with (1, 0) components.
    extern fn graphene_vec2_x_axis() *const graphene.Vec2;
    pub const xAxis = graphene_vec2_x_axis;

    /// Retrieves a constant vector with (0, 1) components.
    extern fn graphene_vec2_y_axis() *const graphene.Vec2;
    pub const yAxis = graphene_vec2_y_axis;

    /// Retrieves a constant vector with (0, 0) components.
    extern fn graphene_vec2_zero() *const graphene.Vec2;
    pub const zero = graphene_vec2_zero;

    /// Allocates a new `graphene.Vec2` structure.
    ///
    /// The contents of the returned structure are undefined.
    ///
    /// Use `graphene.Vec2.init` to initialize the vector.
    extern fn graphene_vec2_alloc() *graphene.Vec2;
    pub const alloc = graphene_vec2_alloc;

    /// Adds each component of the two passed vectors and places
    /// each result into the components of `res`.
    extern fn graphene_vec2_add(p_a: *const Vec2, p_b: *const graphene.Vec2, p_res: *graphene.Vec2) void;
    pub const add = graphene_vec2_add;

    /// Divides each component of the first operand `a` by the corresponding
    /// component of the second operand `b`, and places the results into the
    /// vector `res`.
    extern fn graphene_vec2_divide(p_a: *const Vec2, p_b: *const graphene.Vec2, p_res: *graphene.Vec2) void;
    pub const divide = graphene_vec2_divide;

    /// Computes the dot product of the two given vectors.
    extern fn graphene_vec2_dot(p_a: *const Vec2, p_b: *const graphene.Vec2) f32;
    pub const dot = graphene_vec2_dot;

    /// Checks whether the two given `graphene.Vec2` are equal.
    extern fn graphene_vec2_equal(p_v1: *const Vec2, p_v2: *const graphene.Vec2) bool;
    pub const equal = graphene_vec2_equal;

    /// Frees the resources allocated by `v`
    extern fn graphene_vec2_free(p_v: *Vec2) void;
    pub const free = graphene_vec2_free;

    /// Retrieves the X component of the `graphene.Vec2`.
    extern fn graphene_vec2_get_x(p_v: *const Vec2) f32;
    pub const getX = graphene_vec2_get_x;

    /// Retrieves the Y component of the `graphene.Vec2`.
    extern fn graphene_vec2_get_y(p_v: *const Vec2) f32;
    pub const getY = graphene_vec2_get_y;

    /// Initializes a `graphene.Vec2` using the given values.
    ///
    /// This function can be called multiple times.
    extern fn graphene_vec2_init(p_v: *Vec2, p_x: f32, p_y: f32) *graphene.Vec2;
    pub const init = graphene_vec2_init;

    /// Initializes `v` with the contents of the given array.
    extern fn graphene_vec2_init_from_float(p_v: *Vec2, p_src: *const [2]f32) *graphene.Vec2;
    pub const initFromFloat = graphene_vec2_init_from_float;

    /// Copies the contents of `src` into `v`.
    extern fn graphene_vec2_init_from_vec2(p_v: *Vec2, p_src: *const graphene.Vec2) *graphene.Vec2;
    pub const initFromVec2 = graphene_vec2_init_from_vec2;

    /// Linearly interpolates `v1` and `v2` using the given `factor`.
    extern fn graphene_vec2_interpolate(p_v1: *const Vec2, p_v2: *const graphene.Vec2, p_factor: f64, p_res: *graphene.Vec2) void;
    pub const interpolate = graphene_vec2_interpolate;

    /// Computes the length of the given vector.
    extern fn graphene_vec2_length(p_v: *const Vec2) f32;
    pub const length = graphene_vec2_length;

    /// Compares the two given vectors and places the maximum
    /// values of each component into `res`.
    extern fn graphene_vec2_max(p_a: *const Vec2, p_b: *const graphene.Vec2, p_res: *graphene.Vec2) void;
    pub const max = graphene_vec2_max;

    /// Compares the two given vectors and places the minimum
    /// values of each component into `res`.
    extern fn graphene_vec2_min(p_a: *const Vec2, p_b: *const graphene.Vec2, p_res: *graphene.Vec2) void;
    pub const min = graphene_vec2_min;

    /// Multiplies each component of the two passed vectors and places
    /// each result into the components of `res`.
    extern fn graphene_vec2_multiply(p_a: *const Vec2, p_b: *const graphene.Vec2, p_res: *graphene.Vec2) void;
    pub const multiply = graphene_vec2_multiply;

    /// Compares the two given `graphene.Vec2` vectors and checks
    /// whether their values are within the given `epsilon`.
    extern fn graphene_vec2_near(p_v1: *const Vec2, p_v2: *const graphene.Vec2, p_epsilon: f32) bool;
    pub const near = graphene_vec2_near;

    /// Negates the given `graphene.Vec2`.
    extern fn graphene_vec2_negate(p_v: *const Vec2, p_res: *graphene.Vec2) void;
    pub const negate = graphene_vec2_negate;

    /// Computes the normalized vector for the given vector `v`.
    extern fn graphene_vec2_normalize(p_v: *const Vec2, p_res: *graphene.Vec2) void;
    pub const normalize = graphene_vec2_normalize;

    /// Multiplies all components of the given vector with the given scalar `factor`.
    extern fn graphene_vec2_scale(p_v: *const Vec2, p_factor: f32, p_res: *graphene.Vec2) void;
    pub const scale = graphene_vec2_scale;

    /// Subtracts from each component of the first operand `a` the
    /// corresponding component of the second operand `b` and places
    /// each result into the components of `res`.
    extern fn graphene_vec2_subtract(p_a: *const Vec2, p_b: *const graphene.Vec2, p_res: *graphene.Vec2) void;
    pub const subtract = graphene_vec2_subtract;

    /// Stores the components of `v` into an array.
    extern fn graphene_vec2_to_float(p_v: *const Vec2, p_dest: *[2]f32) void;
    pub const toFloat = graphene_vec2_to_float;

    extern fn graphene_vec2_get_type() usize;
    pub const getGObjectType = graphene_vec2_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure capable of holding a vector with three dimensions: x, y, and z.
///
/// The contents of the `graphene.Vec3` structure are private and should
/// never be accessed directly.
pub const Vec3 = extern struct {
    f_value: graphene.Simd4F,

    /// Provides a constant pointer to a vector with three components,
    /// all sets to 1.
    extern fn graphene_vec3_one() *const graphene.Vec3;
    pub const one = graphene_vec3_one;

    /// Provides a constant pointer to a vector with three components
    /// with values set to (1, 0, 0).
    extern fn graphene_vec3_x_axis() *const graphene.Vec3;
    pub const xAxis = graphene_vec3_x_axis;

    /// Provides a constant pointer to a vector with three components
    /// with values set to (0, 1, 0).
    extern fn graphene_vec3_y_axis() *const graphene.Vec3;
    pub const yAxis = graphene_vec3_y_axis;

    /// Provides a constant pointer to a vector with three components
    /// with values set to (0, 0, 1).
    extern fn graphene_vec3_z_axis() *const graphene.Vec3;
    pub const zAxis = graphene_vec3_z_axis;

    /// Provides a constant pointer to a vector with three components,
    /// all sets to 0.
    extern fn graphene_vec3_zero() *const graphene.Vec3;
    pub const zero = graphene_vec3_zero;

    /// Allocates a new `graphene.Vec3` structure.
    ///
    /// The contents of the returned structure are undefined.
    ///
    /// Use `graphene.Vec3.init` to initialize the vector.
    extern fn graphene_vec3_alloc() *graphene.Vec3;
    pub const alloc = graphene_vec3_alloc;

    /// Adds each component of the two given vectors.
    extern fn graphene_vec3_add(p_a: *const Vec3, p_b: *const graphene.Vec3, p_res: *graphene.Vec3) void;
    pub const add = graphene_vec3_add;

    /// Computes the cross product of the two given vectors.
    extern fn graphene_vec3_cross(p_a: *const Vec3, p_b: *const graphene.Vec3, p_res: *graphene.Vec3) void;
    pub const cross = graphene_vec3_cross;

    /// Divides each component of the first operand `a` by the corresponding
    /// component of the second operand `b`, and places the results into the
    /// vector `res`.
    extern fn graphene_vec3_divide(p_a: *const Vec3, p_b: *const graphene.Vec3, p_res: *graphene.Vec3) void;
    pub const divide = graphene_vec3_divide;

    /// Computes the dot product of the two given vectors.
    extern fn graphene_vec3_dot(p_a: *const Vec3, p_b: *const graphene.Vec3) f32;
    pub const dot = graphene_vec3_dot;

    /// Checks whether the two given `graphene.Vec3` are equal.
    extern fn graphene_vec3_equal(p_v1: *const Vec3, p_v2: *const graphene.Vec3) bool;
    pub const equal = graphene_vec3_equal;

    /// Frees the resources allocated by `v`
    extern fn graphene_vec3_free(p_v: *Vec3) void;
    pub const free = graphene_vec3_free;

    /// Retrieves the first component of the given vector `v`.
    extern fn graphene_vec3_get_x(p_v: *const Vec3) f32;
    pub const getX = graphene_vec3_get_x;

    /// Creates a `graphene.Vec2` that contains the first and second
    /// components of the given `graphene.Vec3`.
    extern fn graphene_vec3_get_xy(p_v: *const Vec3, p_res: *graphene.Vec2) void;
    pub const getXy = graphene_vec3_get_xy;

    /// Creates a `graphene.Vec3` that contains the first two components of
    /// the given `graphene.Vec3`, and the third component set to 0.
    extern fn graphene_vec3_get_xy0(p_v: *const Vec3, p_res: *graphene.Vec3) void;
    pub const getXy0 = graphene_vec3_get_xy0;

    /// Converts a `graphene.Vec3` in a `graphene.Vec4` using 0.0
    /// as the value for the fourth component of the resulting vector.
    extern fn graphene_vec3_get_xyz0(p_v: *const Vec3, p_res: *graphene.Vec4) void;
    pub const getXyz0 = graphene_vec3_get_xyz0;

    /// Converts a `graphene.Vec3` in a `graphene.Vec4` using 1.0
    /// as the value for the fourth component of the resulting vector.
    extern fn graphene_vec3_get_xyz1(p_v: *const Vec3, p_res: *graphene.Vec4) void;
    pub const getXyz1 = graphene_vec3_get_xyz1;

    /// Converts a `graphene.Vec3` in a `graphene.Vec4` using `w` as
    /// the value of the fourth component of the resulting vector.
    extern fn graphene_vec3_get_xyzw(p_v: *const Vec3, p_w: f32, p_res: *graphene.Vec4) void;
    pub const getXyzw = graphene_vec3_get_xyzw;

    /// Retrieves the second component of the given vector `v`.
    extern fn graphene_vec3_get_y(p_v: *const Vec3) f32;
    pub const getY = graphene_vec3_get_y;

    /// Retrieves the third component of the given vector `v`.
    extern fn graphene_vec3_get_z(p_v: *const Vec3) f32;
    pub const getZ = graphene_vec3_get_z;

    /// Initializes a `graphene.Vec3` using the given values.
    ///
    /// This function can be called multiple times.
    extern fn graphene_vec3_init(p_v: *Vec3, p_x: f32, p_y: f32, p_z: f32) *graphene.Vec3;
    pub const init = graphene_vec3_init;

    /// Initializes a `graphene.Vec3` with the values from an array.
    extern fn graphene_vec3_init_from_float(p_v: *Vec3, p_src: *const [3]f32) *graphene.Vec3;
    pub const initFromFloat = graphene_vec3_init_from_float;

    /// Initializes a `graphene.Vec3` with the values of another
    /// `graphene.Vec3`.
    extern fn graphene_vec3_init_from_vec3(p_v: *Vec3, p_src: *const graphene.Vec3) *graphene.Vec3;
    pub const initFromVec3 = graphene_vec3_init_from_vec3;

    /// Linearly interpolates `v1` and `v2` using the given `factor`.
    extern fn graphene_vec3_interpolate(p_v1: *const Vec3, p_v2: *const graphene.Vec3, p_factor: f64, p_res: *graphene.Vec3) void;
    pub const interpolate = graphene_vec3_interpolate;

    /// Retrieves the length of the given vector `v`.
    extern fn graphene_vec3_length(p_v: *const Vec3) f32;
    pub const length = graphene_vec3_length;

    /// Compares each component of the two given vectors and creates a
    /// vector that contains the maximum values.
    extern fn graphene_vec3_max(p_a: *const Vec3, p_b: *const graphene.Vec3, p_res: *graphene.Vec3) void;
    pub const max = graphene_vec3_max;

    /// Compares each component of the two given vectors and creates a
    /// vector that contains the minimum values.
    extern fn graphene_vec3_min(p_a: *const Vec3, p_b: *const graphene.Vec3, p_res: *graphene.Vec3) void;
    pub const min = graphene_vec3_min;

    /// Multiplies each component of the two given vectors.
    extern fn graphene_vec3_multiply(p_a: *const Vec3, p_b: *const graphene.Vec3, p_res: *graphene.Vec3) void;
    pub const multiply = graphene_vec3_multiply;

    /// Compares the two given `graphene.Vec3` vectors and checks
    /// whether their values are within the given `epsilon`.
    extern fn graphene_vec3_near(p_v1: *const Vec3, p_v2: *const graphene.Vec3, p_epsilon: f32) bool;
    pub const near = graphene_vec3_near;

    /// Negates the given `graphene.Vec3`.
    extern fn graphene_vec3_negate(p_v: *const Vec3, p_res: *graphene.Vec3) void;
    pub const negate = graphene_vec3_negate;

    /// Normalizes the given `graphene.Vec3`.
    extern fn graphene_vec3_normalize(p_v: *const Vec3, p_res: *graphene.Vec3) void;
    pub const normalize = graphene_vec3_normalize;

    /// Multiplies all components of the given vector with the given scalar `factor`.
    extern fn graphene_vec3_scale(p_v: *const Vec3, p_factor: f32, p_res: *graphene.Vec3) void;
    pub const scale = graphene_vec3_scale;

    /// Subtracts from each component of the first operand `a` the
    /// corresponding component of the second operand `b` and places
    /// each result into the components of `res`.
    extern fn graphene_vec3_subtract(p_a: *const Vec3, p_b: *const graphene.Vec3, p_res: *graphene.Vec3) void;
    pub const subtract = graphene_vec3_subtract;

    /// Copies the components of a `graphene.Vec3` into the given array.
    extern fn graphene_vec3_to_float(p_v: *const Vec3, p_dest: *[3]f32) void;
    pub const toFloat = graphene_vec3_to_float;

    extern fn graphene_vec3_get_type() usize;
    pub const getGObjectType = graphene_vec3_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure capable of holding a vector with four dimensions: x, y, z, and w.
///
/// The contents of the `graphene.Vec4` structure are private and should
/// never be accessed directly.
pub const Vec4 = extern struct {
    f_value: graphene.Simd4F,

    /// Retrieves a pointer to a `graphene.Vec4` with all its
    /// components set to 1.
    extern fn graphene_vec4_one() *const graphene.Vec4;
    pub const one = graphene_vec4_one;

    /// Retrieves a pointer to a `graphene.Vec4` with its
    /// components set to (0, 0, 0, 1).
    extern fn graphene_vec4_w_axis() *const graphene.Vec4;
    pub const wAxis = graphene_vec4_w_axis;

    /// Retrieves a pointer to a `graphene.Vec4` with its
    /// components set to (1, 0, 0, 0).
    extern fn graphene_vec4_x_axis() *const graphene.Vec4;
    pub const xAxis = graphene_vec4_x_axis;

    /// Retrieves a pointer to a `graphene.Vec4` with its
    /// components set to (0, 1, 0, 0).
    extern fn graphene_vec4_y_axis() *const graphene.Vec4;
    pub const yAxis = graphene_vec4_y_axis;

    /// Retrieves a pointer to a `graphene.Vec4` with its
    /// components set to (0, 0, 1, 0).
    extern fn graphene_vec4_z_axis() *const graphene.Vec4;
    pub const zAxis = graphene_vec4_z_axis;

    /// Retrieves a pointer to a `graphene.Vec4` with all its
    /// components set to 0.
    extern fn graphene_vec4_zero() *const graphene.Vec4;
    pub const zero = graphene_vec4_zero;

    /// Allocates a new `graphene.Vec4` structure.
    ///
    /// The contents of the returned structure are undefined.
    ///
    /// Use `graphene.Vec4.init` to initialize the vector.
    extern fn graphene_vec4_alloc() *graphene.Vec4;
    pub const alloc = graphene_vec4_alloc;

    /// Adds each component of the two given vectors.
    extern fn graphene_vec4_add(p_a: *const Vec4, p_b: *const graphene.Vec4, p_res: *graphene.Vec4) void;
    pub const add = graphene_vec4_add;

    /// Divides each component of the first operand `a` by the corresponding
    /// component of the second operand `b`, and places the results into the
    /// vector `res`.
    extern fn graphene_vec4_divide(p_a: *const Vec4, p_b: *const graphene.Vec4, p_res: *graphene.Vec4) void;
    pub const divide = graphene_vec4_divide;

    /// Computes the dot product of the two given vectors.
    extern fn graphene_vec4_dot(p_a: *const Vec4, p_b: *const graphene.Vec4) f32;
    pub const dot = graphene_vec4_dot;

    /// Checks whether the two given `graphene.Vec4` are equal.
    extern fn graphene_vec4_equal(p_v1: *const Vec4, p_v2: *const graphene.Vec4) bool;
    pub const equal = graphene_vec4_equal;

    /// Frees the resources allocated by `v`
    extern fn graphene_vec4_free(p_v: *Vec4) void;
    pub const free = graphene_vec4_free;

    /// Retrieves the value of the fourth component of the given `graphene.Vec4`.
    extern fn graphene_vec4_get_w(p_v: *const Vec4) f32;
    pub const getW = graphene_vec4_get_w;

    /// Retrieves the value of the first component of the given `graphene.Vec4`.
    extern fn graphene_vec4_get_x(p_v: *const Vec4) f32;
    pub const getX = graphene_vec4_get_x;

    /// Creates a `graphene.Vec2` that contains the first two components
    /// of the given `graphene.Vec4`.
    extern fn graphene_vec4_get_xy(p_v: *const Vec4, p_res: *graphene.Vec2) void;
    pub const getXy = graphene_vec4_get_xy;

    /// Creates a `graphene.Vec3` that contains the first three components
    /// of the given `graphene.Vec4`.
    extern fn graphene_vec4_get_xyz(p_v: *const Vec4, p_res: *graphene.Vec3) void;
    pub const getXyz = graphene_vec4_get_xyz;

    /// Retrieves the value of the second component of the given `graphene.Vec4`.
    extern fn graphene_vec4_get_y(p_v: *const Vec4) f32;
    pub const getY = graphene_vec4_get_y;

    /// Retrieves the value of the third component of the given `graphene.Vec4`.
    extern fn graphene_vec4_get_z(p_v: *const Vec4) f32;
    pub const getZ = graphene_vec4_get_z;

    /// Initializes a `graphene.Vec4` using the given values.
    ///
    /// This function can be called multiple times.
    extern fn graphene_vec4_init(p_v: *Vec4, p_x: f32, p_y: f32, p_z: f32, p_w: f32) *graphene.Vec4;
    pub const init = graphene_vec4_init;

    /// Initializes a `graphene.Vec4` with the values inside the given array.
    extern fn graphene_vec4_init_from_float(p_v: *Vec4, p_src: *const [4]f32) *graphene.Vec4;
    pub const initFromFloat = graphene_vec4_init_from_float;

    /// Initializes a `graphene.Vec4` using the components of a
    /// `graphene.Vec2` and the values of `z` and `w`.
    extern fn graphene_vec4_init_from_vec2(p_v: *Vec4, p_src: *const graphene.Vec2, p_z: f32, p_w: f32) *graphene.Vec4;
    pub const initFromVec2 = graphene_vec4_init_from_vec2;

    /// Initializes a `graphene.Vec4` using the components of a
    /// `graphene.Vec3` and the value of `w`.
    extern fn graphene_vec4_init_from_vec3(p_v: *Vec4, p_src: *const graphene.Vec3, p_w: f32) *graphene.Vec4;
    pub const initFromVec3 = graphene_vec4_init_from_vec3;

    /// Initializes a `graphene.Vec4` using the components of
    /// another `graphene.Vec4`.
    extern fn graphene_vec4_init_from_vec4(p_v: *Vec4, p_src: *const graphene.Vec4) *graphene.Vec4;
    pub const initFromVec4 = graphene_vec4_init_from_vec4;

    /// Linearly interpolates `v1` and `v2` using the given `factor`.
    extern fn graphene_vec4_interpolate(p_v1: *const Vec4, p_v2: *const graphene.Vec4, p_factor: f64, p_res: *graphene.Vec4) void;
    pub const interpolate = graphene_vec4_interpolate;

    /// Computes the length of the given `graphene.Vec4`.
    extern fn graphene_vec4_length(p_v: *const Vec4) f32;
    pub const length = graphene_vec4_length;

    /// Compares each component of the two given vectors and creates a
    /// vector that contains the maximum values.
    extern fn graphene_vec4_max(p_a: *const Vec4, p_b: *const graphene.Vec4, p_res: *graphene.Vec4) void;
    pub const max = graphene_vec4_max;

    /// Compares each component of the two given vectors and creates a
    /// vector that contains the minimum values.
    extern fn graphene_vec4_min(p_a: *const Vec4, p_b: *const graphene.Vec4, p_res: *graphene.Vec4) void;
    pub const min = graphene_vec4_min;

    /// Multiplies each component of the two given vectors.
    extern fn graphene_vec4_multiply(p_a: *const Vec4, p_b: *const graphene.Vec4, p_res: *graphene.Vec4) void;
    pub const multiply = graphene_vec4_multiply;

    /// Compares the two given `graphene.Vec4` vectors and checks
    /// whether their values are within the given `epsilon`.
    extern fn graphene_vec4_near(p_v1: *const Vec4, p_v2: *const graphene.Vec4, p_epsilon: f32) bool;
    pub const near = graphene_vec4_near;

    /// Negates the given `graphene.Vec4`.
    extern fn graphene_vec4_negate(p_v: *const Vec4, p_res: *graphene.Vec4) void;
    pub const negate = graphene_vec4_negate;

    /// Normalizes the given `graphene.Vec4`.
    extern fn graphene_vec4_normalize(p_v: *const Vec4, p_res: *graphene.Vec4) void;
    pub const normalize = graphene_vec4_normalize;

    /// Multiplies all components of the given vector with the given scalar `factor`.
    extern fn graphene_vec4_scale(p_v: *const Vec4, p_factor: f32, p_res: *graphene.Vec4) void;
    pub const scale = graphene_vec4_scale;

    /// Subtracts from each component of the first operand `a` the
    /// corresponding component of the second operand `b` and places
    /// each result into the components of `res`.
    extern fn graphene_vec4_subtract(p_a: *const Vec4, p_b: *const graphene.Vec4, p_res: *graphene.Vec4) void;
    pub const subtract = graphene_vec4_subtract;

    /// Stores the components of the given `graphene.Vec4` into an array
    /// of floating point values.
    extern fn graphene_vec4_to_float(p_v: *const Vec4, p_dest: *[4]f32) void;
    pub const toFloat = graphene_vec4_to_float;

    extern fn graphene_vec4_get_type() usize;
    pub const getGObjectType = graphene_vec4_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specify the order of the rotations on each axis.
///
/// The `GRAPHENE_EULER_ORDER_DEFAULT` value is special, and is used
/// as an alias for one of the other orders.
pub const EulerOrder = enum(c_int) {
    default = -1,
    xyz = 0,
    yzx = 1,
    zxy = 2,
    xzy = 3,
    yxz = 4,
    zyx = 5,
    sxyz = 6,
    sxyx = 7,
    sxzy = 8,
    sxzx = 9,
    syzx = 10,
    syzy = 11,
    syxz = 12,
    syxy = 13,
    szxy = 14,
    szxz = 15,
    szyx = 16,
    szyz = 17,
    rzyx = 18,
    rxyx = 19,
    ryzx = 20,
    rxzx = 21,
    rxzy = 22,
    ryzy = 23,
    rzxy = 24,
    ryxy = 25,
    ryxz = 26,
    rzxz = 27,
    rxyz = 28,
    rzyz = 29,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of intersection.
pub const RayIntersectionKind = enum(c_int) {
    none = 0,
    enter = 1,
    leave = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PI = 3.141593;
pub const PI_2 = 1.570796;
/// Evaluates to the number of components of a `graphene.Vec2`.
///
/// This symbol is useful when declaring a C array of floating
/// point values to be used with `graphene.Vec2.initFromFloat` and
/// `graphene.Vec2.toFloat`, e.g.
///
/// ```
///   float v[GRAPHENE_VEC2_LEN];
///
///   // vec is defined elsewhere
///   graphene_vec2_to_float (&vec, v);
///
///   for (int i = 0; i < GRAPHENE_VEC2_LEN; i++)
///     fprintf (stdout, "component `d`: `g`\n", i, v[i]);
/// ```
pub const VEC2_LEN = 2;
/// Evaluates to the number of components of a `graphene.Vec3`.
///
/// This symbol is useful when declaring a C array of floating
/// point values to be used with `graphene.Vec3.initFromFloat` and
/// `graphene.Vec3.toFloat`, e.g.
///
/// ```
///   float v[GRAPHENE_VEC3_LEN];
///
///   // vec is defined elsewhere
///   graphene_vec3_to_float (&vec, v);
///
///   for (int i = 0; i < GRAPHENE_VEC2_LEN; i++)
///     fprintf (stdout, "component `d`: `g`\n", i, v[i]);
/// ```
pub const VEC3_LEN = 3;
/// Evaluates to the number of components of a `graphene.Vec4`.
///
/// This symbol is useful when declaring a C array of floating
/// point values to be used with `graphene.Vec4.initFromFloat` and
/// `graphene.Vec4.toFloat`, e.g.
///
/// ```
///   float v[GRAPHENE_VEC4_LEN];
///
///   // vec is defined elsewhere
///   graphene_vec4_to_float (&vec, v);
///
///   for (int i = 0; i < GRAPHENE_VEC4_LEN; i++)
///     fprintf (stdout, "component `d`: `g`\n", i, v[i]);
/// ```
pub const VEC4_LEN = 4;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
