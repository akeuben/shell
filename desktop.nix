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
    ];

    
        buildInputs = let 
            astalDeps = with astal.packages.${system}; [
                astal4
                io
                battery
                wireplumber 
                network 
                mpris 
                powerprofiles 
                tray 
                bluetooth
            ];
            deps = with pkgs; [
                networkmanager
            ];
        in 
            astalDeps ++ deps;
}
