{ pkgs, ... }:
let
  python-packages = p: with p; [
    toml requests pyperclip
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
  ];

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  #nixpkgs.config.allowUnfree = true;

  home.shellAliases = {
    ls = "exa --icons";
    la = "ls -a";
    lla = "ls -al";
    grep = "grep --color=always";
    mux = "tmuxinator";
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # etc
    flameshot
    cloc
    jq
    feh
    mpv
    zathura
    neofetch
    yt-dlp
    lsof
    p7zip
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
    python_with_packages
    ruby
    rubyPackages.rails
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
    # big non gui
    #texlive.combined.scheme-basic
    #texlive.combined.scheme-medium
    texlive.combined.scheme-full
    # big gui software
    font-manager
    cinnamon.nemo
    gimp
    spotify
    transmission-gtk
    teams
    yacreader
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
    #gtk2.extraConfig = "gtk-cursor-theme-size=24";
    #gtk3.extraConfig."gtk-cursor-theme-size" = 24;
    #gtk4.extraConfig."gtk-cursor-theme-size" = 24;
    enable = true;
    theme =  {
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

