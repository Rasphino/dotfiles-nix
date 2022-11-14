{
  description = "Rasphino's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };
  
  # add the inputs declared above to the argument attribute set
  outputs = { self, nixpkgs, home-manager, darwin }: {
    darwinConfigurations."rasphino-mbp" = darwin.lib.darwinSystem {
      # you can have multiple darwinConfigurations per flake, one per hostname

      system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
      modules = [ 
        ./hosts/rasphino-mbp/default.nix 
      ]; # will be important later
    };
  };
}
