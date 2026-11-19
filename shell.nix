{pkgs, desktop, greeter, ...}: pkgs.mkShell {
    inputsFrom = [
        desktop
        greeter
    ];
}
