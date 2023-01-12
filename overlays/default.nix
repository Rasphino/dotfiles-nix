{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  neovim-plugins = final: prev:
    let
      go-nvim = prev.vimUtils.buildVimPluginFrom2Nix {
        name = "go.nvim";
        src = inputs.go-nvim;
      };
      guihua-lua = prev.vimUtils.buildVimPluginFrom2Nix {
        name = "guihua.lua";
        src = inputs.guihua-lua;
      };
    in
    {
      vimPlugins =
        prev.vimPlugins // {
          inherit go-nvim guihua-lua;
        };
    };
}
