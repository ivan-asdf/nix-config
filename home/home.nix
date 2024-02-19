{ pkgs, ... }:
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

  #nixpkgs.config.allowUnfree = true;

  home.shellAliases = {
    ls = "eza --icons --group-directories-first";
    la = "ls -a";
    lla = "ls -al";
    grep = "grep --color=always";
    mux = "tmuxinator";
  };

  fonts.fontconfig.enable = true;

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
  };
}

