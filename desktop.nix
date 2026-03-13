{pkgs, astal, system}: pkgs.stdenv.mkDerivation { 
    pname = "kappashell-desktop";
    version = "0.1.0";
    src = ./.;

    nativeBuildInputs = with pkgs; [
        meson
        ninja
        pkg-config
        vala
        gobject-introspection
    ];

    buildInputs = [
        astal.packages.${system}.io
        astal.packages.${system}.astal3
        astal.packages.${system}.battery
    ];
}
