# Edit this configuration file to define what should be installe
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./services
      ./fonts
    ];

  fileSystems."/home/ivan/nfs" = {
    device = "192.168.0.111:/home/ivan/nfs";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.device-timeout=0.5" # this doesnt seem to work with nfs the same was as hdd
      "x-systemd.idle-timeout=600" # not sure if this does anything

      "noauto" # dont mount durring boot
      # "nofail" # dont fail boot if fails during boot
      # "bg"

      # nfs specific
      "soft"
      "intr"
      "timeo=30"
      "retrans=3"
      "nfsvers=3"
    ];
  };

  fileSystems."/home/ivan/tosh_hdd" = {
    device = "/dev/disk/by-uuid/9a1de96b-5327-4a79-86d4-f06ccee488b0";
    fsType = "ext4";
    options = [
      "x-systemd.automount"
      "x-systemd.device-timeout=0.5"
      "x-systemd.idle-timeout=600"
      "noauto"
      "X-mount.owner=ivan"
    ];
  };

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
  };

  boot.resumeDevice = "/dev/disk/by-label/swap";
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "idle=nowait" ];

  /*
    boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      device = "nodev";
      #gfxmodeEfi = "2560x1440";
    };
    };
  */

  #boot.plymouth.enable = true;
  #boot.plymouth.theme = "breeze";

  networking.hostName = "desktop";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Sofia";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the Plasma 5 Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    # support32Bit = true;
  };
  hardware.enableAllFirmware = true;
  # security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  hardware.bluetooth.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.groups.seat = { };

  #  Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ivan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "docker" ];
    uid = 1000;
  };
  nix.settings.trusted-users = [ "root @wheel" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # To make nvim python tree-siter syntax highlight work(need libstdc++)
  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
  };
  environment.systemPackages = with pkgs; [
    # basic user-programs
    firefox
    tmux
    ranger
    # basic utilities
    neovim
    git
    wget
    efibootmgr
    htop
    file
    unrar
    unzip
    pstree
    tree
    # dev
    gcc
    # vpn
    networkmanager-l2tp
    networkmanagerapplet
    bluez
  ];
  programs.ssh.askPassword = "";
  programs.zsh.enable = true;
  users.users.ivan.shell = pkgs.zsh;
  environment.shellAliases = {
    dd = "dd status=progress";
  };
  programs.dconf.enable = true;

  # security.polkit.enable = true;

  #nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia =
    {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "555.42.02";
      #   sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
      #   sha256_aarch64 = lib.fakeSha256;
      #   openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      #   settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      #   persistencedSha256 = lib.fakeSha256;
      #
      # };
      powerManagement.enable = true;
      modesetting.enable = true;
    };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPortRanges = [
    { from = 8000; to = 8010; }
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
  /*
      systemd.services.foo = {
      enable = true;
      description = "Disables an acpi device that on its own wakes up pc from hibernation";
      script = ''
      cat /proc/acpi/wakeup
      # echo PTXH > /proc/acpi/wakeup
      echo "disabled acpi device, error: " $?
      cat /proc/acpi/wakeup
      '';
      wantedBy = [ "multi-user.target" ]; # start after login
      };
    */

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  #users.extraGroups.vboxusers.members = [ "ivan" ];

  systemd.tmpfiles.rules = [
    "w /proc/acpi/wakeup - - - - PTXH"
  ];

  /* moved to xserver.sessionCommands
    systemd.services.fooxset = {
    script = ''
      ${pkgs.xorg.xset}/bin/xset -dpms
    '';
    #environment = "DISPLAY=:0";
    serviceConfig = {
      Environment = [ "\"XAUTHORITY=/home/ivan/.Xauthority\"" "\"DISPLAY=:0\""];
    };
    wantedBy = [ "graphical-session.target" ];
    };
  */
  services.gnome.gnome-keyring.enable = true;
}
