{pkgs, astal, system}: let 
    pname = "kappashell-greeter";
    version = "0.1.0";
in pkgs.stdenv.mkDerivation { 
    inherit pname version;

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
        
    preFixup = ''
        glib-compile-schemas --strict \
            "$out/share/gsettings-schemas/${pname}-${version}/glib-2.0/schemas"
    '';
}
