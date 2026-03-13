{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        astal = {
            url = "github:aylur/astal";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, astal }: let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        packages.${system}.kappashell-desktop = import ./desktop.nix {
            inherit pkgs astal system;
        };

        devShells.${system}.default = import ./shell.nix {
            inherit pkgs astal system;
        };
    };
}
