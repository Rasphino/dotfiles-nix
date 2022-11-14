{ pkgs, ... }:
{

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh.enable = true;
  # bash is enabled by default

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
    ];
  };
}
