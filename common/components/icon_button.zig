const gtk = @import("gtk");
const gdk = @import("gdk");

var pointer: ?*gdk.Cursor = null;

pub fn getPointer() *gdk.Cursor {
    if(pointer == null) {
        pointer = gdk.Cursor.newFromName("pointer", null);
    }

    return pointer.?;
}

const Options = struct {
    valign: gtk.Align = .center,
    halign: gtk.Align = .center,

    vexpand: bool = false,
    hexpand: bool = false,
    icon_size: c_int = 24,
};

pub const IconButton = struct {
    button: *gtk.Button,
    image: *gtk.Image,

    pub fn new(icon_name: [*:0]const u8, options: Options) IconButton {
        const button = gtk.Button.new();
        button.f_parent_instance.setValign(options.valign);
        button.f_parent_instance.setHalign(options.halign);
        button.f_parent_instance.setVexpand(@intFromBool(options.vexpand));
        button.f_parent_instance.setHexpand(@intFromBool(options.hexpand));

        const image = gtk.Image.newFromIconName(icon_name);
        image.setPixelSize(options.icon_size);

        button.setChild(image.as(gtk.Widget));

        return .{
            .image = image,
            .button = button,
        };
    }
};
