{ pkgs, ... }:
let
  change_wallpaper = pkgs.writeShellScriptBin "change-wallpaper" (builtins.readFile ./random_wallpaper.sh);
in
{
  home.packages = [ change_wallpaper ];

  systemd.user.services.foo = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Unit = {
      Description = "Change wallpaper";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      #ExecStart = "${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.nix-config/home/random_wallpaper.sh";
      ExecStart = "${change_wallpaper}/bin/change-wallpaper";
      #ExecStart = "${pkgs.picom}/bin/picom --config /nix/store/ybnm7km16yp08jjs7ql1f97igzqb6mih-hm_picompicom.conf";
      #ExecStart = "/nix/store/srna44y6ph66nil7hix0pqk3l957zcba-my-script/bin/my-script";
    };
  };
  systemd.user.timers.foo = {
    Unit = { Description = "Change wallpaper every "; };

    Timer = {
      #OnUnitActiveSec = "5s";
      #Unit = "foo.service";
      OnCalendar = "*-*-* *:00:00"; # every minute at 05 seconds
    };

    Install = { WantedBy = [ "timers.target" ]; };
  };

  xdg.configFile."wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

}

