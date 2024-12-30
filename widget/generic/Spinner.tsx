import GObject from "gi://GObject?version=2.0";
import { astalify, ConstructProps, Gtk } from "gjs/gtk3";

export class Spinner extends astalify(Gtk.Spinner) {
    static { GObject.registerClass(this) }

    constructor(props: ConstructProps<Spinner, Gtk.Spinner.ConstructorProps, {}>) {
        super(props as any);
    }
}
