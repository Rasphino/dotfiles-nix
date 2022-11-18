{ config, lib, inputs, pkgs, ...}: 
{
  config.home.username = "rasp";
  config.home.homeDirectory = "/Users/rasp";
  
  config.home.packages = with pkgs; [
    rustup
    dotnet-sdk_7
    
    zoxide
  ];
  
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # gui
    firefox.enable = true;
  };
  
  # other user specific configuration
  config.programs.git = {
    enable = true;
    userName = "Rasphino";
    userEmail = "im.lihh@outlook.com";
  };
  
  config.programs.helix = {
    enable = true;
    settings = {
      theme = "dracula";
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };
  };
}
