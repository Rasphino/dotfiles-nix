{ ... } :
{
  programs.git = {
    enable = true;
    userName = "Rasphino";
    userEmail = "im.lihh@outlook.com";
    
    delta.enable = true;
    delta.options = {
      side-by-side = true;
    };

    extraConfig = {
      merge.conflictstyle = "diff3";
    };
  };
}
