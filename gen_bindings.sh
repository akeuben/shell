#!/usr/bin/env bash
cd lib/zig-gobject 

# Find all .gir files in $EXTRA_GIR_DIRS and extract just the filename without the path
modules=($(find "$EXTRA_GIR_DIRS" -maxdepth 1 -name '*.gir' -printf '%f\n'))

# If the .gir filenames include the .gir extension and you want them removed:
# modules=("${modules[@]/%.gir/}")

module_flags=()
for m in "${modules[@]}"; do
    module_flags+=("-Dmodules=${m%.gir}")
done

zig build codegen -Dgir-files-path="$EXTRA_GIR_DIRS" "${module_flags[@]}"

sed -i 's/\.{ \.use_pkg_config = \.force }/.{}/g' zig-out/bindings/build.zig
