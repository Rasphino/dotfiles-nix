{ pkgs, ... }:
{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh.enable = true;
  # bash is enabled by default
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # editors
    helix
    neovim

    alacritty

    curl
    wget
    aria
    
    htop
    neofetch

    # fonts
    nerdfonts
    iosevka
  ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    # onActivation.upgrade = true;
    casks = [
      "hammerspoon"
      "raycast"
      "logseq"
      "iina"
      "firefox"
      "steam"
      # "miniconda"
    ];
    masApps = {
      QQ = 451108668;
      WeChat = 836500024;
      NflxMultiSubs = 1594059167;
      Xnip = 1221250572;
      "Hidden Bar" = 1452453066;
      "Apple Configurator" = 1037126344;
      "Microsoft Word" = 462054704;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Excel" = 462058435;
    };
  };
  
  imports = [ ./kmonad/kmonad.nix ];
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  users.users.rasp = {
    name = "rasp";
    home = "/Users/rasp";
  };
  home-manager.users.rasp = import ./rasp-home.nix;
}
