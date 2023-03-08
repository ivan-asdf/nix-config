{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ":luafile ~/.config/nvim/init.lua";
    plugins = with pkgs.vimPlugins; [
      lualine-nvim
      gitsigns-nvim
      #nvim-treesitter.withAllGrammars
    ];
  };

  xdg.configFile.nvim = {
    source = ./nvim_config;
    recursive = true;
  };

  home.packages = with pkgs; [
    xclip # to support copy to global clipboard register
    nil # nix language lsp
  ];
}

