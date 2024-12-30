{
    description = "My Awesome Desktop Shell";

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
            default = ags.lib.bundle {
                inherit pkgs;
                src = ./.;
                name = "my-shell";
                entry = "app.ts";

                # additional libraries and executables to add to gjs' runtime
                extraPackages = [
                    ags.packages.${system}.hyprland
                    ags.packages.${system}.apps
                    ags.packages.${system}.tray
                    ags.packages.${system}.network
                    ags.packages.${system}.bluetooth
                    ags.packages.${system}.wireplumber
                    ags.packages.${system}.notifd
                    pkgs.evolution-data-server
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
                ];
                propogatedUserEnvPkgs = [
                    pkgs.evolution-data-server
                ];
            };
        };
    };
}
