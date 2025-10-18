#!/usr/bin/env bash
cd lib/zig-gobject 

modules=("Gtk-4.0" "Gdk-4.0" "Gio-2.0" "Astal-4.0")

module_flags=()
for m in "${modules[@]}"; do
    module_flags+=("-Dmodules=$m")
done

zig build codegen -Dgir-files-path="$EXTRA_GIR_DIRS" "${module_flags[@]}"
