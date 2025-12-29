#!/usr/bin/env bash
cd lib/zig-gobject 

modules=($(find "$EXTRA_GIR_DIRS" -maxdepth 1 -name '*.gir' -printf '%f\n'))

module_flags=()
for m in "${modules[@]}"; do
    module_flags+=("-Dmodules=${m%.gir}")
done

zig build codegen -Dgir-files-path="$EXTRA_GIR_DIRS" "${module_flags[@]}"

sed -i 's/\.{ \.use_pkg_config = \.force }/.{}/g' zig-out/bindings/build.zig

cp zig-out/bindings ../../ -r
