{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "22.05";
    imports = [
        # gui
        ./firefox
    ];
}
