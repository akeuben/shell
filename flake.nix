{
    description = "KappaShell: An android inspired shell for Hyprland. Made using Astal.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        ags = {
            url = "github:aylur/ags";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        ags,
    }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    in {
        packages.${system} = {
            desktop = ags.lib.bundle {
                inherit pkgs;
                src = ./.;
                name = "kappashell-desktop";
                entry = "desktop/app.ts";

                # additional libraries and executables to add to gjs' runtime
                extraPackages = [
                    ags.packages.${system}.hyprland
                    ags.packages.${system}.apps
                    ags.packages.${system}.tray
                    ags.packages.${system}.network
                    ags.packages.${system}.bluetooth
                    ags.packages.${system}.wireplumber
                    ags.packages.${system}.notifd
                    ags.packages.${system}.mpris
                    ags.packages.${system}.battery
                    ags.packages.${system}.greet
                    pkgs.evolution-data-server
                    pkgs.nodejs
                ];

            };
            greeter = ags.lib.bundle {
                inherit pkgs;
                src = ./.;
                name = "kappashell-greeter";
                entry = "greeter/app.ts";

                # additional libraries and executables to add to gjs' runtime
                extraPackages = [
                    ags.packages.${system}.hyprland
                    ags.packages.${system}.apps
                    ags.packages.${system}.tray
                    ags.packages.${system}.network
                    ags.packages.${system}.bluetooth
                    ags.packages.${system}.wireplumber
                    ags.packages.${system}.notifd
                    ags.packages.${system}.mpris
                    ags.packages.${system}.battery
                    ags.packages.${system}.greet
                    pkgs.evolution-data-server
                    pkgs.nodejs
                ];

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
                ];
                propogatedUserEnvPkgs = [
                    pkgs.evolution-data-server
                ];
            };
        };
    };
}
