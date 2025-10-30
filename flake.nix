{
    description = "KappaShell: An Android-inspired shell for Hyprland. Made using Astal.";

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

    outputs = { self, nixpkgs, ... }: {
        packages.x86_64-linux.desktop = import ./desktop.nix {
            inherit nixpkgs self;
        };
        devShell.x86_64-linux = import ./shell.nix { inherit nixpkgs self; };
    };
}
