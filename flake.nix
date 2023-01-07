{
  description = "Rasphino's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";
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

    clash-meta = {
      url = "github:Rasphino/Clash.Meta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # add the inputs declared above to the argument attribute set
  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , darwin
    , nur
    , ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      overlays = import ./overlays;

      darwinConfigurations = {
        # Laptop (personal)
        rasphino-mbp = darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/rasphino-mbp ];
        };
      };

      nixosConfigurations = {
        # Desktop VM in rasphino-mbp
        nixos-vm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nixos-vm ];
        };

        # Server in my home
        saki-mk1 = nixpkgs-stable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/saki-mk1 ];
        };
      };

      homeConfigurations = {
        "rasp@rasphino-mbp" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/rasp/rasphino-mbp.nix ];
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
