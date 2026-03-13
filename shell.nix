{pkgs, ...}: pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
        meson 
        ninja 
        pkg-config 
        vala 
        gobject-introspection
    ];
}
