{
    description = "KappaShell: An android inspired shell for Hyprland. Made using Astal.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        astal = {
            url = "github:aylur/astal";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        icon-theme-browser = {
            url = "github:aylur/icon-theme-browser";
        };
    };

    outputs = { self, nixpkgs, astal, icon-theme-browser }: let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};

        # Gather all GIR-providing inputs
        girInputs = [
            pkgs.glib 
            pkgs.gtk4
            pkgs.gtk3
            pkgs.glib 
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
        ];

        # Join all dev outputs so we can access their GIR files
        girDirs = pkgs.symlinkJoin {
            name = "gir-dirs";
            paths = builtins.concatLists (map (pkg: [ (pkg.dev or pkg) ]) girInputs);
        };

    in {
        packages.${system} = {
            desktop = pkgs.stdenv.mkDerivation {
                name = "kappashell-desktop";

                src = ./desktop;

                nativeBuildInputs = with pkgs; [
                    gobject-introspection
                    zig_0_15
                    wrapGAppsHook
                    pkg-config
                    libxslt
                    gtk4-layer-shell
                ];

                buildInputs = girInputs;

                preBuild = ''
          export EXTRA_GIR_DIRS="${girDirs}/share/gir-1.0"
          export GI_TYPELIB_PATH="${girDirs}/lib/girepository-1.0"
          echo "[build] Set EXTRA_GIR_DIRS=$EXTRA_GIR_DIRS"
          echo "[build] Set GI_TYPELIB_PATH=$GI_TYPELIB_PATH"
          '';

                # Replace with your actual build/install logic
                installPhase = ''
          mkdir -p $out/bin
          echo "No build logic defined yet." > $out/bin/kappashell-desktop
          chmod +x $out/bin/kappashell-desktop
          '';
            };
        };

        devShells.${system} = {
            default = pkgs.mkShell {
                buildInputs = [
                    pkgs.gobject-introspection
                    pkgs.evolution-data-server
                    icon-theme-browser.packages.${system}.default
                    pkgs.zig_0_15
                    pkgs.wrapGAppsHook
                    pkgs.pkg-config
                    pkgs.libxslt
                    pkgs.gtk4-layer-shell
                ] ++ girInputs;

                nativeBuildInputs = [
                    pkgs.wrapGAppsHook
                ];

                shellHook = ''
          export EXTRA_GIR_DIRS="${girDirs}/share/gir-1.0"
          export GI_TYPELIB_PATH="${girDirs}/lib/girepository-1.0"
          echo "[devShell] Set EXTRA_GIR_DIRS=$EXTRA_GIR_DIRS"
          echo "[devShell] Set GI_TYPELIB_PATH=$GI_TYPELIB_PATH"
          export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath girInputs}:$LD_LIBRARY_PATH
          export PKG_CONFIG_PATH=${pkgs.lib.makeLibraryPath girInputs}:$LD_LIBRARY_PATH
          '';
            };
        };
    };
}
