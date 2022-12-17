{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unzip ripgrep fd gitui ncdu just
  ];
}
