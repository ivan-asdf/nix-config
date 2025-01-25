{ pkgs, ... }:
let
  python-packages = p: with p; [
    toml
    requests pyperclip
    lark
    django
    django-celery-results watchdog
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
    # wxpython # not supported for 3.12
    ephem
    pytz
    ffmpeg-python
    pprintpp
    pysrt
    #whisper
    # Ai dependecies stuff
    pytorch
    torchvision
    openai-whisper
    datasets
    accelerate
    # librosa
    soundfile
    sentencepiece
    sacremoses
    # dtw-python
    transformers
    pydub
    pyannote-audio
    nltk
    ctranslate2
    av
    # brouhaha
    #cmake
    #colour
    pyautogui
    pynput
    keyboard
    pyperclip
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
  python_with_packages = (pkgs.python311.withPackages python-packages);
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
    # imlib2
    imlib2Full
    libtiff
    # dcraw
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
    ffmpeg_7-full
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
    bat-extras.batgrep
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
    nodePackages.postcss-cli
    tailwindcss

    ## Containers
    docker-compose

    ## Database
    sqlitebrowser
    dbeaver-bin
    mysql-workbench
    beekeeper-studio
    # pgadmin4
    redis
    postgresql
    # mysql
    mariadb
    # libsass
    redisinsight
    (callPackage ./packages/redis-commander.nix { })
    # (callPackage ./packages/redisinsight.nix { })


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
    wgo # live reloading
    delve
    gdlv
    apacheKafka
    minikube
    kubectl
    logstash
    pgsync
    sqlc
    go-migrate
    atlas
    go-task

    ## C/C++
    gnumake
    pkg-config
    stdenv.cc.cc.lib
    cmake
    clang_18
    doxygen
    # sqlitecpp
    # sqlite
    # sphinx

    ## C#
    # dotnetCorePackages.sdk_9_0
    # dotnet-sdk # version 6
    dotnet-sdk_8
    csharp-ls

    ## Php
    php84
    php84Packages.composer

    ## Python
    python_with_packages

    # Game engine
    unityhub

    ## Other
    # cudatoolkit
    tesseract4
    scantailor
    leptonica


    # Productivity & Office ----------------------------------------------------

    vscode
    # texlive.combined.scheme-basic
    # texlive.combined.scheme-medium
    texlive.combined.scheme-full
    obs-studio
    font-manager
    nemo
    ark
    gimp
    rawtherapee
    darktable
    pinta
    krita
    spotify
    qbittorrent
    # transmission_4
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

    wofi
    blueman
  ];

  # nixpkgs.config.permittedInsecurePackages = [
  #   "dcraw"
  # ];
}
