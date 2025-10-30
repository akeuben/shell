{ nixpkgs, self }:

let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    astal = self.inputs.astal;
    iconThemeBrowser = self.inputs."icon-theme-browser";

    girInputs = [
        pkgs.glib
        pkgs.gtk4
        pkgs.gtk3
        pkgs.graphene
        pkgs.harfbuzz
        pkgs.pango
        pkgs.gdk-pixbuf
        pkgs.atk
        pkgs.gobject-introspection
        astal.packages.${system}.io
        astal.packages.${system}.astal4
        astal.packages.${system}.hyprland
        astal.packages.${system}.apps
        astal.packages.${system}.tray
        astal.packages.${system}.network
        astal.packages.${system}.bluetooth
        astal.packages.${system}.wireplumber
        astal.packages.${system}.notifd
        astal.packages.${system}.mpris
        astal.packages.${system}.battery
        astal.packages.${system}.greet
        pkgs.evolution-data-server
        pkgs.libadwaita
        pkgs.gtk4-layer-shell
        pkgs.networkmanager
        pkgs.libsoup_3
        pkgs.json-glib
        pkgs.libical
    ];

    girDirs = pkgs.symlinkJoin {
        name = "gir-dirs";
        paths = builtins.concatLists (map (pkg: [ (pkg.dev or pkg) ]) girInputs);
    };
in
    pkgs.stdenv.mkDerivation {
        pname = "kappashell-desktop";
        version = "1.0";
        src = ./.;

        zigBuildFlags = [ "-Doptimize=Debug" ];

        nativeBuildInputs = with pkgs; [
            zig_0_15
            pkg-config
            libxslt
            makeWrapper
            wayland
            wrapGAppsHook
            gobject-introspection
        ];

        buildInputs = [
            pkgs.gobject-introspection
            pkgs.evolution-data-server
            iconThemeBrowser.packages.${system}.default
            pkgs.wayland
            pkgs.libxslt
            pkgs.gtk4-layer-shell
        ] ++ girInputs;

        preBuild = ''
        export EXTRA_GIR_DIRS="${girDirs}/share/gir-1.0"
        export GI_TYPELIB_PATH="${girDirs}/lib/girepository-1.0"
        '';

        buildPhase = ''
        export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/.zig-cache
        zig build
        '';

        installPhase = ''
        mkdir -p $out/bin
        cp ./zig-out/bin/kappashell-desktop $out/bin
        '';
    }
