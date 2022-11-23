{
  description = "Rasphino's Nix Flake";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs"; # ...
    };
    nur.url = "github:nix-community/NUR";
  };
  
  # add the inputs declared above to the argument attribute set
  outputs = 
  { self
  , nixpkgs
  , nixpkgs-stable
  , home-manager
  , darwin
  , nur
  , ... }@inputs: 
  let
    overlay-stable = final: prev: {
      stable = nixpkgs-stable.legacyPackages.${prev.system}; # considering nixpkgs-unstable is an input registered before.
    };
  in {
    darwinConfigurations."rasphino-mbp" = darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
      modules = [ 
        {
          nixpkgs.overlays = [
            overlay-stable
            nur.overlay
          ];
        }
        home-manager.darwinModules.home-manager
        ./hosts/rasphino-mbp/configuration.nix 
      ]; # will be important later
    };

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
