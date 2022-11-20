{
  description = "Rasphino's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # add the inputs declared above to the argument attribute set
  outputs =
  { self
  , nixpkgs
  , home-manager
  , nur
  , ... }@inputs:
  {
    nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux"; # "x86_64-darwin" if you're using a pre M1 mac
      modules = [
        ./hosts/nixos-vm/hardware-configuration.nix
        ./hosts/nixos-vm/configuration.nix
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [
            nur.overlay
          ];
        }
        ({ ... }: {
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        })
      ]; # will be important later
    };
  };
}
