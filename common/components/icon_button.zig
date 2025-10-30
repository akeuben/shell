const gtk = @import("gtk");
const gdk = @import("gdk");
const gobject = @import("gobject");

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

    id: c_ulong,

    pub fn new(icon_name: [*:0]const u8, options: Options, context: anytype, onClicked: *const fn (*gtk.Button, @TypeOf(context)) callconv(.c) void) IconButton {
        const button = gtk.Button.new();
        button.f_parent_instance.setValign(options.valign);
        button.f_parent_instance.setHalign(options.halign);
        button.f_parent_instance.setVexpand(@intFromBool(options.vexpand));
        button.f_parent_instance.setHexpand(@intFromBool(options.hexpand));
        button.f_parent_instance.setCursor(getPointer());

        const id = gtk.Button.signals.clicked.connect(button, @TypeOf(context), onClicked, context, .{});

        const image = gtk.Image.newFromIconName(icon_name);
        image.setPixelSize(options.icon_size);

        button.setChild(image.as(gtk.Widget));

        return .{
            .image = image,
            .button = button,
            .id = id,
        };
    }

    pub fn deinit(self: *const IconButton) void {
        gobject.signalHandlerDisconnect(self.button.as(gobject.Object), self.id);
    }
};
