# This file (and the global directory) holds config that i use on all hosts
{ pkgs, lib, inputs, outputs, ... }:
{
  imports = [
    ./nix.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
    ];
    config = {
      allowUnfree = true;
    };
  };
}
