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
    ./custom
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

  nixpkgs.config =
    {
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
      allowUnfree = true;
    };

  home.shellAliases = {
    ls = "exa --icons";
    la = "ls -a";
    lla = "ls -al";
    grep = "grep --color=always";
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # etc
    flameshot
    cloc
    jq
    feh
    zathura
    neofetch
    # locksr where to put?!?
    betterlockscreen
    # default utils improvements
    exa # ls
    bat # cat
    fd # find
    duf # du
    xcp # cp
    ripgrep # grep
    # dev
    nodejs
    nodePackages.pyright
    nodePackages.typescript-language-server
    python_with_packages
    rustc
    cargo
    go
    gnumake
    nix-prefetch-git
    # BUILD POLYBAR
    #cmake
    #gnumake
    sphinx
    pkg-config
    # big gui software
    font-manager
    cinnamon.nemo
  ];

  home.pointerCursor = {
    #package = pkgs.catppuccin-cursors.latteLight;
    #name = "Catppuccin-Latte-Light-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    #package = pkgs.catppuccin-cursors.lattePink;
    #name = "Catppuccin-Latte-Pink-Cursors";
    size = 24;
    gtk.enable = true;
  };
  home.sessionVariables = {
    #XCURSOR_THEME = "phinger-cursors";
    XCURSOR_SIZE = "24";
  };
  gtk = {
    gtk2.extraConfig = "gtk-cursor-theme-size=24";
    gtk3.extraConfig."gtk-cursor-theme-size" = 24;
    gtk4.extraConfig."gtk-cursor-theme-size" = 24;
  };

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

