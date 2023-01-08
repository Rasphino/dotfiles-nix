{ inputs, lib, pkgs, config, outputs, ... }:
{
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
      outputs.overlays.additions
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home.packages = with pkgs; [
    unzip
    ripgrep
    fd
    gitui
    just
    du-dust
  ];

  imports = [
    ./zsh.nix
    ./neovim
  ] ++ (builtins.attrValues outputs.homeManagerModules);
}
