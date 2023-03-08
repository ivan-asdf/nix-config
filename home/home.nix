{ pkgs, ... }:
let
  python-packages = p: with p; [
    toml
    requests
  ];
  python_with_packages = (pkgs.python3Full.withPackages python-packages);
in
{
  imports = [
    ./i3
    ./services
    ./programs
    ./scripts
    ./fonts
  ];

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  home.shellAliases = {
    ls = "exa --icons";
    grep = "grep --color=always";
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # etc
    flameshot
    cloc
    unzip
    tree
    pstree
    jq
    feh
    zathura
    # default utils improvements
    exa # ls
    bat # cat
    fd # find
    # dev
    nodejs
    nodePackages.pyright
    python_with_packages
    rustc
    cargo
    swift
    sourcekit-lsp
    clang-tools
    gnumake
    # BUILD POLYBAR
    #cmake
    #gnumake
    sphinx
    pkg-config
    # big gui software
    font-manager
    cinnamon.nemo
  ];

  programs.git = {
    enable = true;
    userName = "Ivan";
    userEmail = "ivan.asdf0@gmail.com";
    extraConfig.init.defaultBranch = "master";
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

