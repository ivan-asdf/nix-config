{ pkgs, ... }:
let
  backup_nfs = pkgs.writeShellScriptBin "backup-nfs" (builtins.readFile ./backup_nfs.sh);
in
{
  home.packages = [ backup_nfs ];

  systemd.user.services.backup-nfs = {
    Service = {
      Type = "oneshot";
      ExecStart = "${backup_nfs}/bin/backup-nfs";
    };

    Unit = {
      Description = "Backups nfs mounted drive to local drive";
      # After = [ "graphical-session-pre.target" ];
    };
  };

  systemd.user.timers.backup-nfs = {
    Install = { WantedBy = [ "timers.target" ]; };

    Timer = {
      OnCalendar = "*-*-* *:00:00"; # every hour at 00 minutes & 00 seconds
    };

    Unit = {
      Description = "Backup nfs every hour";
      After = [ "graphical-session-pre.target" ];
    };
  };
}

