{ config, lib, inputs, pkgs, ...}: 
{
  config.home.username = "rasp";
  config.home.homeDirectory = "/Users/rasp";
  config.home.stateVersion = "22.05";
  
  config.home.packages = with pkgs; [
    rustup
    dotnet-sdk_7
    go
    
    zoxide
  ];
  
  # other user specific configuration
  imports = builtins.map (x: ../.. + builtins.toPath ("/modules/" + x + "/default.nix")) [ 
    "firefox"
    "git"
    "helix"
    "neovim"
  ];
  
  
}
