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
    pprintpp
    pysrt
    #whisper
    # Ai dependecies stuff
    pytorch
    openai-whisper
    datasets
    accelerate
    librosa
    soundfile
    sentencepiece
    sacremoses
    dtw-python
    transformers
    pydub
    pyannote-audio
    nltk
    ctranslate2
    av
    # brouhaha
    #cmake
    #colour
    (callPackage ./packages/whoisdomain.nix { })
    (callPackage ./packages/colour-science.nix { })
    (callPackage ./packages/pywhispercpp.nix { })
    (callPackage ./packages/color-temp.nix { })
    (callPackage ./packages/whisper-timestamped.nix { })
    (callPackage ./packages/auditok.nix { })
    (callPackage ./packages/whisperx.nix { })
    (callPackage ./packages/faster-whisper.nix { })

  ];
  python_with_packages = (pkgs.python3.withPackages python-packages);
in
{
  home.packages = with pkgs; [
    audacity
    # etc
    zip
    flameshot
    cloc
    jq
    feh
    mpv
    iotop # realtime read/white speed
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
    exiftool # file info
    testdisk # photorec
    ffmpeg_5-full
    trashy
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
    typescript
    python_with_packages
    hatch
    docker-compose
    sqlitebrowser
    dbeaver
    # pgadmin4
    ruby
    rubyPackages.rails
    rustc
    cargo
    go
    apacheKafka
    gnumake
    stdenv.cc.cc.lib
    nix-prefetch-git
    cmake
    #gnumake
    sphinx
    pkg-config
    tesseract4
    scantailor
    leptonica
    # cudatoolkit
    # big non gui
    #texlive.combined.scheme-basic
    #texlive.combined.scheme-medium
    texlive.combined.scheme-full
    # big gui software
    font-manager
    cinnamon.nemo
    gimp
    pinta
    spotify
    qbittorrent
    yacreader
    libreoffice-qt
    # google-chrome
    # chromium
    blender
    tor-browser-bundle-bin
    vbam
    smartgithg
    lazygit
  ];
}
