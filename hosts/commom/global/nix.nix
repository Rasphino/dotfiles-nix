{ pkgs, inputs, lib, config, ... }:
{
  nix = {
    settings = {
      substituters = [
      #   "https://cache.m7.rs"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
      #   "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" ];
      # warn-dirty = false;
    };
    # package = pkgs.nixUnstable;
    gc = {
      automatic = true;
    } // lib.attrsets.optionalAttrs pkgs.stdenv.isDarwin {
      interval = { Weekday = 7; }; # Clean up on every sunday
    } // lib.attrsets.optionalAttrs pkgs.stdenv.isLinux {
      dates = "weekly";
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    # registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Map registries to channels
    # Very useful when using legacy commands
    # nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
