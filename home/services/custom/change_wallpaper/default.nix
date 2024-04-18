{ pkgs, ... }:
let
  change_wallpaper = pkgs.writeShellScriptBin "change-wallpaper" (builtins.readFile ./random_wallpaper.sh);
in
{
  home.packages = [ change_wallpaper ];

  systemd.user.services.startup_wallpaper = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.betterlockscreen}/bin/betterlockscreen -w";
    };

    Unit = {
      Description = "Set wallpaper on startup";
      After = [ "graphical-session-pre.target" ];
    };
  };

  systemd.user.services.foo = {
    Service = {
      Type = "oneshot";
      ExecStart = "${change_wallpaper}/bin/change-wallpaper";
    };

    Unit = {
      Description = "Change wallpaper";
      After = [ "graphical-session-pre.target" ];
    };
  };
  systemd.user.timers.foo = {
    Install = { WantedBy = [ "timers.target" ]; };

    Timer = {
      #OnUnitActiveSec = "5s";
      #Unit = "foo.service";
      OnCalendar = "*-*-* *:00:00";
    };

    Unit = {
      Description = "Change wallpaper every hour";
      After = [ "graphical-session-pre.target" ];
    };
  };

  xdg.configFile."wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

}

