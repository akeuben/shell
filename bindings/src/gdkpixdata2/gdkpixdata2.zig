pub const ext = @import("ext.zig");
const gdkpixdata = @This();

const std = @import("std");
const compat = @import("compat");
const gdkpixbuf = @import("gdkpixbuf2");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// A pixel buffer suitable for serialization and streaming.
///
/// Using `GdkPixdata`, images can be compiled into an application,
/// making it unnecessary to refer to external image files at runtime.
///
/// `GdkPixbuf` includes a utility named `gdk-pixbuf-csource`, which
/// can be used to convert image files into `GdkPixdata` structures suitable
/// for inclusion in C sources. To convert the `GdkPixdata` structures back
/// into a `GdkPixbuf`, use ``gdkpixdata.pixbufFromPixdata``.
pub const Pixdata = extern struct {
    /// magic number. A valid `GdkPixdata` structure must have
    ///   `GDK_PIXBUF_MAGIC_NUMBER` here
    f_magic: u32,
    /// less than 1 to disable length checks, otherwise
    ///   `GDK_PIXDATA_HEADER_LENGTH` plus the length of `pixel_data`
    f_length: i32,
    /// information about colorspace, sample width and
    ///   encoding, in a `GdkPixdataType`
    f_pixdata_type: u32,
    /// Distance in bytes between rows
    f_rowstride: u32,
    /// Width of the image in pixels
    f_width: u32,
    /// Height of the image in pixels
    f_height: u32,
    /// `width` x `height`
    ///   pixels, encoded according to `pixdata_type` and `rowstride`
    f_pixel_data: ?[*]u8,

    /// Deserializes (reconstruct) a `gdkpixdata.Pixdata` structure from a byte stream.
    ///
    /// The byte stream consists of a straightforward writeout of the
    /// `GdkPixdata` fields in network byte order, plus the `pixel_data`
    /// bytes the structure points to.
    ///
    /// The `pixdata` contents are reconstructed byte by byte and are checked
    /// for validity.
    ///
    /// This function may fail with `GDK_PIXBUF_ERROR_CORRUPT_IMAGE`
    /// or `GDK_PIXBUF_ERROR_UNKNOWN_TYPE`.
    extern fn gdk_pixdata_deserialize(p_pixdata: *Pixdata, p_stream_length: c_uint, p_stream: [*]const u8, p_error: ?*?*glib.Error) c_int;
    pub const deserialize = gdk_pixdata_deserialize;

    /// Converts a `GdkPixbuf` to a `GdkPixdata`.
    ///
    /// If `use_rle` is `TRUE`, the pixel data is run-length encoded into
    /// newly-allocated memory and a pointer to that memory is returned.
    extern fn gdk_pixdata_from_pixbuf(p_pixdata: *Pixdata, p_pixbuf: *const gdkpixbuf.Pixbuf, p_use_rle: c_int) ?[*]u8;
    pub const fromPixbuf = gdk_pixdata_from_pixbuf;

    /// Serializes a `gdkpixdata.Pixdata` structure into a byte stream.
    /// The byte stream consists of a straightforward writeout of the
    /// `gdkpixdata.Pixdata` fields in network byte order, plus the `pixel_data`
    /// bytes the structure points to.
    extern fn gdk_pixdata_serialize(p_pixdata: *const Pixdata, p_stream_length_p: *c_uint) [*]u8;
    pub const serialize = gdk_pixdata_serialize;

    /// Generates C source code suitable for compiling images directly
    /// into programs.
    ///
    /// GdkPixbuf ships with a program called `gdk-pixbuf-csource`, which offers
    /// a command line interface to this function.
    extern fn gdk_pixdata_to_csource(p_pixdata: *Pixdata, p_name: [*:0]const u8, p_dump_type: gdkpixdata.PixdataDumpType) *glib.String;
    pub const toCsource = gdk_pixdata_to_csource;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration which is used by `gdkpixdata.Pixdata.toCsource` to
/// determine the form of C source to be generated. The three values
/// `GDK_PIXDATA_DUMP_PIXDATA_STREAM`, `GDK_PIXDATA_DUMP_PIXDATA_STRUCT`
/// and `GDK_PIXDATA_DUMP_MACROS` are mutually exclusive, as are
/// `GDK_PIXBUF_DUMP_GTYPES` and `GDK_PIXBUF_DUMP_CTYPES`. The remaining
/// elements are optional flags that can be freely added.
pub const PixdataDumpType = packed struct(c_uint) {
    pixdata_struct: bool = false,
    macros: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    ctypes: bool = false,
    static: bool = false,
    @"const": bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    rle_decoder: bool = false,
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

    pub const flags_pixdata_stream: PixdataDumpType = @bitCast(@as(c_uint, 0));
    pub const flags_pixdata_struct: PixdataDumpType = @bitCast(@as(c_uint, 1));
    pub const flags_macros: PixdataDumpType = @bitCast(@as(c_uint, 2));
    pub const flags_gtypes: PixdataDumpType = @bitCast(@as(c_uint, 0));
    pub const flags_ctypes: PixdataDumpType = @bitCast(@as(c_uint, 256));
    pub const flags_static: PixdataDumpType = @bitCast(@as(c_uint, 512));
    pub const flags_const: PixdataDumpType = @bitCast(@as(c_uint, 1024));
    pub const flags_rle_decoder: PixdataDumpType = @bitCast(@as(c_uint, 65536));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration containing three sets of flags for a `gdkpixdata.Pixdata` struct:
/// one for the used colorspace, one for the width of the samples and one
/// for the encoding of the pixel data.
pub const PixdataType = packed struct(c_uint) {
    color_type_rgb: bool = false,
    color_type_rgba: bool = false,
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
    sample_width_8: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    encoding_raw: bool = false,
    encoding_rle: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_color_type_rgb: PixdataType = @bitCast(@as(c_uint, 1));
    pub const flags_color_type_rgba: PixdataType = @bitCast(@as(c_uint, 2));
    pub const flags_color_type_mask: PixdataType = @bitCast(@as(c_uint, 255));
    pub const flags_sample_width_8: PixdataType = @bitCast(@as(c_uint, 65536));
    pub const flags_sample_width_mask: PixdataType = @bitCast(@as(c_uint, 983040));
    pub const flags_encoding_raw: PixdataType = @bitCast(@as(c_uint, 16777216));
    pub const flags_encoding_rle: PixdataType = @bitCast(@as(c_uint, 33554432));
    pub const flags_encoding_mask: PixdataType = @bitCast(@as(c_uint, 251658240));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Converts a `GdkPixdata` to a `GdkPixbuf`.
///
/// If `copy_pixels` is `TRUE` or if the pixel data is run-length-encoded,
/// the pixel data is copied into newly-allocated memory; otherwise it is
/// reused.
extern fn gdk_pixbuf_from_pixdata(p_pixdata: *const gdkpixdata.Pixdata, p_copy_pixels: c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
pub const pixbufFromPixdata = gdk_pixbuf_from_pixdata;

/// Magic number for `gdkpixdata.Pixdata` structures.
pub const PIXBUF_MAGIC_NUMBER = 1197763408;
/// The length of a `gdkpixdata.Pixdata` structure without the `pixel_data` pointer.
pub const PIXDATA_HEADER_LENGTH = 24;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
