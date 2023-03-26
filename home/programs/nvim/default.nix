{ pkgs, config, ... }:
let
  themes = {
  catppuccin = ''
    vim.cmd.colorscheme 'catppuccin'
    vim.o.background = "light"
  '';
  kanagawa = ''
    vim.cmd.colorscheme 'kanagawa'
    vim.o.background = "dark"
  '';
  };
  theme = themes.${config.custom.theme};
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    #extraConfig = ":luafile ~/.config/nvim/init1.lua";
    extraLuaConfig = ''
      require('init')
      ${theme} 
    ''
    ;
    ##plugins = with pkgs.vimPlugins; [
    #lualine-nvim
    #gitsigns-nvim
    #nvim-treesitter.withAllGrammars #couse file readonly error blabla inside nvim
    #];
    /*
      generatedConfigs = {
      lua = "dasdas";
      };
    */
  };

  xdg.configFile.nvim = {
    source = ./nvim_config;
    recursive = true;
  };

  home.packages = with pkgs; [
    xclip # to support copy to global clipboard register
    nil # nix language lsp
    nixpkgs-fmt
    lua-language-server
    rust-analyzer
    rustfmt
    sourcekit-lsp # C++
    clang-tools
    cmake
    gopls
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    texlab
  ];
}

