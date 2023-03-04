{ pkgs, ... }:
let
  apply_home = pkgs.writeShellScriptBin
    "apply-home"
    (builtins.readFile ../apply-home.sh);

  apply_system = pkgs.writeShellScriptBin
    "apply-system"
    (builtins.readFile ../apply-system.sh);

  nerd_font = pkgs.stdenv.mkDerivation {
    name = "Nerd Font";
    src = ./fonts;
    installPhase = "
      mkdir -p $out/share/fonts/nerd
      echo 'HELLO'
      cp $src/'Symbols-2048-em Nerd Font Complete.ttf' $out/share/fonts/nerd/
    ";
  };

  python-packages = p: with p; [
    toml
    requests
  ];
  python_with_packages = (pkgs.python3Full.withPackages python-packages);
in
{
  imports = [
    ./i3.nix
  ];

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  home.shellAliases = {
    ls = "exa --icons";
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # my pkgs
    apply_home
    apply_system
    # nvim 
    nil
    xclip
    # etc
    cloc
    unzip
    tree
    # bash improvements
    exa
    # dev
    nodejs
    nodePackages.pyright
    python_with_packages
    rustc
    cargo
    # big gui software
    font-manager
    cinnamon.nemo
    # fonts
    nerd_font
    # temp test
    konsole
    wezterm
  ];

  programs.git = {
    enable = true;
    userName = "Ivan";
    userEmail = "ivan.asdf0@gmail.com";
    extraConfig.init.defaultBranch = "master";
  };

  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./bashrc;
  };

  programs.starship = {
    enable = true;
  };
  xdg.configFile."starship.toml" = {
    source = ./starship.toml;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ":luafile ~/.config/nvim/init.lua";
    plugins = with pkgs.vimPlugins; [
      lualine-nvim
      #nvim-treesitter.withAllGrammars
    ];
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    extraConfig = ''
      set-option -sg escape-time 10
      set-option -g focus-events on

      set -g default-terminal "screen-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
  };
}

