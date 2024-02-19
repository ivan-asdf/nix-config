{ pkgs, ... }:
let
  g = ps: ps.callPackage ./packages/whoisdomain.nix { };
  python-packages = p: with p; [
    toml
    requests
    pyperclip
    lark
    django
    django-celery-results
    watchdog
    celery
    psycopg2
    validators
    python-whois
    pip
    beautifulsoup4
    urllib3
    #(g p)
    (callPackage ./packages/whoisdomain.nix { })
  ];
  #pk = python-packages;
  python_with_packages = (pkgs.python3Full.withPackages python-packages);
  #python_with_packages = (pkgs.python3Full.withPackages (ps: with ps; [(python-packages ps)]);
  #python_with_packages = pkgs.python3Full.withPackages(ps: [(g ps)]);
in
{
  home.packages = with pkgs; [
    # etc
    flameshot
    cloc
    jq
    feh
    mpv
    zathura
    zellij
    ssh-askpass-fullscreen
    lxqt.lxqt-openssh-askpass
    #calibre
    pavucontrol
    neofetch
    yt-dlp
    lsof
    p7zip
    pciutils
    xdotool
    # locksr where to put?!?
    betterlockscreen
    # default utils improvements
    eza # ls
    bat # cat
    fd # find
    duf # du
    xcp # cp
    ripgrep # grep
    # dev
    nodejs
    python_with_packages
    hatch
    docker-compose
    sqlitebrowser
    dbeaver
    pgadmin4
    ruby
    rubyPackages.rails
    rustc
    cargo
    go
    gnumake
    stdenv.cc.cc.lib
    nix-prefetch-git
    #cmake
    #gnumake
    sphinx
    pkg-config
    tesseract4
    scantailor
    leptonica
    # big non gui
    #texlive.combined.scheme-basic
    #texlive.combined.scheme-medium
    texlive.combined.scheme-full
    # big gui software
    font-manager
    cinnamon.nemo
    gimp
    spotify
    qbittorrent
    yacreader
    libreoffice-qt
    google-chrome
    chromium
    blender
    tor-browser-bundle-bin
    vbam
  ];
}
