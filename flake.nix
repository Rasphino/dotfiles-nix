{
  description = "Rasphino's Nix Flake";

  inputs = {
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
    , home-manager
    , darwin
    , nur
    , ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      darwinConfigurations = {
        # Laptop (personal)
        rasphino-mbp = darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/rasphino-mbp
          ];
        };
      };

      nixosConfigurations = {
        # Desktop VM in rasphino-mbp
        nixos-vm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/nixos-vm/hardware-configuration.nix
            ./hosts/nixos-vm/configuration.nix
            {
              nixpkgs.overlays = [
                nur.overlay
              ];
            }
            ({ ... }: {
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            })
          ];
        };

        # Server in my home
        saki-mk1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            # TODO
          ];
        };
      };

      homeConfigurations = {
        "rasp@rasphino-mbp" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ 
            {
              nixpkgs.overlays = [
                nur.overlay
              ];
            }
            ./home/rasp/rasphino-mbp.nix 
          ];
        };
        "rasp@nixos-vm" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/rasp/nixos-vm.nix ];
        };
        "rasp@saki-mk1" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/rasp/saki-mk1.nix ];
        };
        # nix-user-chroot environment in whatbox
        "rasphino@elara.whatbox.ca" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/rasp/whatbox-sg.nix ];
        };
      };
    };
}
