{ lib, inputs, pkgs, ... }:
{
  home.username = "rasp";
  home.homeDirectory = "/Users/rasp";
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    dotnet-sdk_7
    go
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    initExtra = ''
      source "$HOME/.cargo/env"
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
  };

  # other user specific configuration
  imports = builtins.map (x: ../.. + builtins.toPath ("/modules/" + x + "/default.nix")) [
    "firefox"
    "git"
    "helix"
    "neovim"
    "packages"
  ];


}
