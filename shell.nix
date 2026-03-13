{pkgs, desktop, ...}: pkgs.mkShell {
    inputsFrom = [
        desktop
    ];
}
