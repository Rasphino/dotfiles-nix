{ config, pkgs, ... }:
{
  home.file.".config/nvim/settings.lua".source = ./init.lua;
  home.file.".config/nvim/lua".source = ./lua;
 
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraPackages = with pkgs; [
      python310 python310Packages.flake8
      nodejs nodePackages.prettier 
      sumneko-lua-language-server stylua # lua
      rnix-lsp nixfmt # nix
      google-java-format # java
      gopls # go
      gcc
      unzip ripgrep fd black tree-sitter
    ];

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-autopairs
      comment-nvim
      nvim-ts-context-commentstring
      nvim-web-devicons
      nvim-tree-lua
      bufferline-nvim
      vim-bbye
      lualine-nvim
      toggleterm-nvim
      project-nvim
      impatient-nvim
      indent-blankline-nvim
      alpha-nvim
      # -- color schemes --
      tokyonight-nvim
      # darkplus-nvim
      # -- cmp --
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      # -- snippets --
      luasnip
      friendly-snippets
      # -- LSP --
      nvim-lspconfig
      null-ls-nvim
      vim-illuminate
      # -- telescope --
      telescope-nvim
      # -- treesitter --
      nvim-treesitter
      # -- git --
      gitsigns-nvim
      # -- dap --
      nvim-dap
      nvim-dap-ui
      # -- enhance paren matching --
      {
        plugin = vim-matchup;
        config = "let g:matchup_matchparen_offscreen = {'method': 'popup'}";
      }
      # -- rainbow paren --
      nvim-ts-rainbow
      vim-surround
      lightspeed-nvim
    ];

    extraConfig = ''
      luafile ~/.config/nvim/settings.lua
    '';
  };
}

