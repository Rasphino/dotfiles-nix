{ lib, inputs, pkgs, ... }:
{
  home.username = "rasp";
  home.homeDirectory = "/home/rasp";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [ ];

  # other user specific configuration
  imports = [
    ./global
    ./features/cli/git.nix
    ./features/cli/zsh.nix
    ./features/desktop/firefox
    ./features/editor/neovim
    ./features/editor/helix.nix
  ];
}
