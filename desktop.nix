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
        cmake
        libyaml
        wrapGAppsHook4
    ];

    buildInputs = let 
        astalDeps = with astal.packages.${system}; [
            astal4
            apps
            io
            battery
            greet
            wireplumber 
            network 
            mpris 
            powerprofiles 
            tray 
            bluetooth
            hyprland
        ];
        deps = with pkgs; [
            libadwaita
            networkmanager
            json-glib
            libgee
            adwaita-icon-theme
            librsvg
        ];
    in 
        astalDeps ++ deps;
}
