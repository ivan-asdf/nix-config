{ pkgs, ... }: {
  # Enable the X11 windowing system.
  services.xserver =
    {
      enable = true;
      videoDrivers = [ "nvidia" ];
      windowManager.i3 = {
        enable = true;
        extraPackages = [ ];
      };
      displayManager = {
        # these go inside the xsession-wrapper
        sessionCommands = ''
          # default values 660 25
          ${pkgs.xorg.xset}/bin/xset r rate 250 35
        '';
        lightdm.greeters.mini = {
          enable = true;
          user = "ivan";
          extraConfig = ''
            [greeter]
            show-password-label = false
            password-alignment = left

            [greeter-theme]
            background-image = ""
            background-color = "#eff1f5"
            font = Hack
            font-size = 1em
            font-weight = bold
            text-color = "#4c4f69"
            error-color = "#e64553"
            window-color = "#04a5e5"
            border-color = "#209fb5"
            border-width = 4px
            layout-space = 0
            password-background-color = "#e6e9ef"
            password-border-color = "#209fb5"
            password-color = "#4c4f69"
            password-border-width = 4px
          '';
        };
        defaultSession = "none+i3";
      };
      layout = "us,bg(phonetic)";
      xkbOptions = "grp:alt_shift_toggle";
    };
}
