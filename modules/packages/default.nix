{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unzip ripgrep fd gitui just du-dust
  ];
}
