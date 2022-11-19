{ config, pkgs, ... }: {
  home.username = "rasp";
  home.homeDirectory = "/home/rasp";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [ 
    firefox
    htop
  ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(starship init bash)"
    '';
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
}
