{
    description = "KappaShell: An android inspired shell for Hyprland. Made using Astal.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        astal = {
            url = "github:aylur/astal";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        ags = {
            url = "github:aylur/ags";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        icon-theme-browser = {
            url = "github:aylur/icon-theme-browser";
        };
    };

    outputs = {
        self,
        nixpkgs,
        ags,
        astal,
        icon-theme-browser
    }: let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        packages.${system} = {
            desktop = let 
                name = "kappashell-desktop";
            in pkgs.stdenv.mkDerivation {
                name = name;

                src = ./desktop;
                nativeBuildInputs = with pkgs; [
                    wrapGAppsHook
                    gobject-introspection
                    ags.packages.${system}.default
                ];
                buildInputs = [
                    pkgs.glib 
                    pkgs.gjs 
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
                    pkgs.nodejs
                ];
                installPhase = ''
                    mkdir -p $out/bin
                    ags bundle app.ts $out/bin/${name}
                '';

                preFixup = ''
                    gappsWrapperArgs+=(
                    --prefix PATH : ${pkgs.lib.makeBinPath [
                        pkgs.coreutils
                        pkgs.hyprshot
                    ]}
                    )
                '';
            };
        };

        devShells.${system} = {
            default = pkgs.mkShell {
                buildInputs = [
                    # includes all Astal libraries
                    ags.packages.${system}.agsFull
                    pkgs.gobject-introspection
                    pkgs.evolution-data-server
                    pkgs.nodejs
                    icon-theme-browser.packages.${system}.default
                ];
                propogatedUserEnvPkgs = [
                    pkgs.evolution-data-server
                ];
                GSK_RENDERER = "opengl";
            };
        };
    };
}
