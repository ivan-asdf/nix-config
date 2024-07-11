{ pkgs, ... }:
let
  git-alias = pkgs.fetchFromGitHub {
    owner = "GitAlias";
    repo = "gitalias";
    rev = "7b941c3";
    sha256 = "sha256-IvHM6mRtoeVm01cUmTkKqjm6/n3Izau89B7MT69Afo0=";
  };
in
{
  imports = [
    ./packages.nix
    ./custom
    ./i3
    ./services
    ./programs
    ./scripts
  ];

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  home.shellAliases = {
    ls = "eza --icons --group-directories-first";
    la = "ls -a";
    lla = "ls -al";
    grep = "grep --color=always";
    mux = "tmuxinator";
    cp = "xcp";
  };

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
    TERMINAL = "kitty";
    XCURSOR_SIZE = "24";
    EZA_COLORS = "mp=38;5;30;4";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
    PATH = "$PATH:$HOME/.dotnet/tools";
  };

  fonts.fontconfig.enable = true;

  gtk = {
    #gtk2.extraConfig = "gtk-cursor-theme-size=24";
    #gtk3.extraConfig."gtk-cursor-theme-size" = 24;
    #gtk4.extraConfig."gtk-cursor-theme-size" = 24;
    enable = true;
    theme = {
      #package = pkgs.gnome.gnome-themes-extra;
      #name = "Adwaita-dark";
      package = pkgs.yaru-theme;
      name = "Yaru-bark-dark";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
    };
  };
  # Have to enable otherwise the symlink get overriden by applications(transmission)
  xdg.configFile."mimeapps.list".force = true;

  programs.git = {
    enable = true;
    userName = "Ivan";
    userEmail = "ivan.asdf0@gmail.com";
    extraConfig.init.defaultBranch = "master";
    extraConfig.include.path = "${git-alias}/gitalias.txt";
  };

  # programs.lazygit = {
  #   enable = true;
  #   settings = {
  #     keybindings = {
  #     };
  #   };
  # };

  services.udiskie = {
    enable = true;
    tray = "never";
  };
}

