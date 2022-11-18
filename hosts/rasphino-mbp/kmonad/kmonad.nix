{ ... }: 
{
  environment.launchDaemons = {
    kmonad = {
      enable = true;
      source = ./local.kmonad.plist;
      target = "local.kmonad.plist";
    };
  };
}
