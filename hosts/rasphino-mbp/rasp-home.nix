{ config, lib, inputs, pkgs, ...}: 
{
  config.home.username = "rasp";
  config.home.homeDirectory = "/Users/rasp";
  config.home.stateVersion = "22.05";
  
  config.home.packages = with pkgs; [
    rustup
    dotnet-sdk_7
    
    zoxide
  ];
  
  # other user specific configuration
  imports = [ 
    ../../modules/firefox/default.nix 
    ../../modules/git/default.nix 
    ../../modules/helix/default.nix 
  ];
  
}
