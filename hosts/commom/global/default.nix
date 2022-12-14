# This file (and the global directory) holds config that i use on all hosts
{ pkgs, lib, inputs, outputs, ... }:
{
  imports = [
    ./nix.nix
    inputs.sops-nix.nixosModules.sops
  ] ++ (builtins.attrValues outputs.nixosModules);

  nixpkgs = {
    overlays = [
      inputs.clash-meta.overlay
      outputs.overlays.additions
    ];
    config = {
      allowUnfree = true;
    };
  };
}
