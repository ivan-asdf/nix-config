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
    # librosa
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
    # (callPackage ./packages/pgsync.nix { })
  ];
  python_with_packages = (pkgs.python3.withPackages python-packages);
in
{
  home.packages = with pkgs; [
    # Utilities ----------------------------------------------------------------
    audacity
    zip
    p7zip
    flameshot # Screen capture
    cloc # Count lines of code
    jq # Cmdline json processor
    feh # Image viewer
    mpv # Video player
    iotop # Realtime disk read/white speed
    zathura # Pdf viewer
    ssh-askpass-fullscreen
    lxqt.lxqt-openssh-askpass
    #calibre
    pavucontrol # Audio control
    neofetch # Quick sysinfo
    yt-dlp # Youtube(& others) video downloader
    lsof # List open files
    pciutils # lspci (list pci devices)
    xdotool # x11 actions
    xorriso # Manipulate iso files
    exiftool # file info
    testdisk # photorec(raw disk recovery tool)
    ffmpeg_5-full
    trashy # trash command
    nmap
    dig # dns trace
    dnscrypt-proxy
    nethogs
    # locksr where to put?!?
    betterlockscreen
    # Default cmdline utils improvements
    eza # ls
    bat # cat
    fd # find
    duf # du
    xcp # cp
    ripgrep # grep
    du-dust # du
    ## Nix specific stuff
    nix-prefetch-git

    # Development & Tools ------------------------------------------------------
    ## Javascript
    nodejs
    typescript
    yarn
    electron

    ## Containers
    docker-compose

    ## Database
    sqlitebrowser
    dbeaver-bin
    # pgadmin4
    redis
    postgresql
    # libsass
    redisinsight
    (callPackage ./packages/redis-commander.nix { })


    ## Ruby
    # ruby
    rubyPackages.rails

    ## Rust
    rustc
    cargo

    ## Golang
    go
    golangci-lint
    gofumpt
    delve
    gdlv
    apacheKafka
    minikube
    kubectl
    logstash
    pgsync

    ## C/C++
    gnumake
    stdenv.cc.cc.lib
    cmake
    pkg-config
    # sphinx

    ## Python
    python_with_packages

    ## Other
    # cudatoolkit
    tesseract4
    scantailor
    leptonica


    # Productivity & Office ----------------------------------------------------

    #texlive.combined.scheme-basic
    #texlive.combined.scheme-medium
    # texlive.combined.scheme-full
    obs-studio
    font-manager
    cinnamon.nemo
    gimp
    pinta
    spotify
    qbittorrent
    yacreader
    libreoffice-qt
    # google-chrome
    chromium
    blender
    tor-browser-bundle-bin
    vbam
    # smartgithg
    lazygit
    kdenlive
  ];
}
