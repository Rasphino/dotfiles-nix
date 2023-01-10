{ lib, inputs, pkgs, ... }:
{
  home.username = "rasphino";
  home.homeDirectory = "/home/rasphino";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    neofetch
    htop
  ];

  # other user specific configuration
  imports = [
    ./global
    ./features/cli/git.nix
    ./features/editor/helix.nix
  ];
}
