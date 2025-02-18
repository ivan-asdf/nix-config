{ pkgs, config, ... }:
let
  themes = {
    catppuccin = ''
      vim.cmd.colorscheme 'catppuccin'
      vim.o.background = "light"
    '';
    kanagawa = ''
      require('kanagawa').setup({
        typeStyle = { bold = true },
      })

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
    plugins = with pkgs.vimPlugins; [
      # lualine-nvim
      # gitsigns-nvim
      nvim-treesitter.withAllGrammars #couse file readonly error blabla inside nvim
    ];
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

    # LSs, Formatters, linters(nil-ls diagnostics)
    # Nix
    nil # nix language lsp
    nixpkgs-fmt
    # Bash
    nodePackages.bash-language-server
    # bash-language-server
    # Lua
    lua-language-server
    # Python
    # nodePackages.pyright
    pyright
    # black
    # Django
    djlint
    #ruff
    #python310Packages.autopep8
    python310Packages.flake8
    # Ruby
    rubyPackages.solargraph
    # Typescript
    nodePackages.typescript-language-server
    # Rust
    rust-analyzer
    rustfmt
    # C/C++
    #sourcekit-lsp # C++
    clang-tools
    bear
    cmake
    # Golang
    gopls
    # Css
    # nodePackages.vscode-css-languageserver-bin # replaced by extracted
    # Json
    # nodePackages.vscode-json-languageserver-bin # replaced by extracred
    # Html
    nodePackages.vscode-langservers-extracted
    # Tailwindcss
    tailwindcss-language-server
    # Tex
    texlab
  ];
  # xdg.configFile."clang/config.yaml".text =
  # ''
  # ColumnLimit: 200
  # '';
}

