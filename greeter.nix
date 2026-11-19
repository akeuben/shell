{pkgs, astal, system}: pkgs.stdenv.mkDerivation { 
    pname = "kappashell-greeter";
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
    ];

    buildInputs = let 
        astalDeps = with astal.packages.${system}; [
            astal4
            apps
            io
            battery
            wireplumber 
            network 
            mpris 
            powerprofiles 
            tray 
            bluetooth
            hyprland
            greet
        ];
        deps = with pkgs; [
            libadwaita
            networkmanager
            json-glib
            libgee
        ];
    in 
        astalDeps ++ deps;
}
