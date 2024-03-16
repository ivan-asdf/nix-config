{ pkgs, ... }:
let
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
    numpy
    opencv4
    #tk
    pygobject3
    wxpython
    ephem
    pytz
    ffmpeg-python
    #whisper
    openai-whisper
    #cmake
    #colour
    (callPackage ./packages/whoisdomain.nix { })
    (callPackage ./packages/colour-science.nix { })
    (callPackage ./packages/pywhispercpp.nix { })
    (callPackage ./packages/color-temp.nix { })

  ];
  python_with_packages = (pkgs.python3Full.withPackages python-packages);
in
{
  home.packages = with pkgs; [
    # etc
    zip
    flameshot
    cloc
    jq
    feh
    mpv
    zathura
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
    xorriso # manipulate iso
    # locksr where to put?!?
    betterlockscreen
    # default utils improvements
    eza # ls
    bat # cat
    fd # find
    duf # du
    xcp # cp
    ripgrep # grep
    du-dust # du
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
    nix-index
    cmake
    #gnumake
    sphinx
    pkg-config
    tesseract4
    scantailor
    leptonica
    cudatoolkit
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
    # google-chrome
    # chromium
    blender
    tor-browser-bundle-bin
    vbam
  ];
}
