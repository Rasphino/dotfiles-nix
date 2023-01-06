{ lib, inputs, pkgs, ... }:
{
  home.username = "rasp";
  home.homeDirectory = "/Users/rasp";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    dotnet-sdk_7
    go
  ];

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
