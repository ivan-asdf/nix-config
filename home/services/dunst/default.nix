{ pkgs, config, lib, ... }:
let
  settings = {
    global = {
      mouse_left_click = "context";
      mouse_middle_click = "close_current";
      dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
      browser = "${pkgs.xdg-utils}/bin/xdg-open";

      transparency = 33;
      offset = "10x35";

      font = "Hack 11";
      markup = "full";
      format = "<big><b>%s</b></big>\\n%b\\n<sub><i>%a</i></sub>";

      # Do not remove notification if inactive(mouse not moving)
      idle_threshold = 0;

      show_age_threshold = 30;
    };

    play_normal_sound = {
      summary = "*";
      script = "${play_notification_sound}";
    };
  };

  play_notification_sound = pkgs.writeShellScript
    "play_notification_sound" ''
    set -e
    case $DUNST_URGENCY in
    "LOW")
      ${pkgs.mpv}/bin/mpv ${notification_sound}/Taptap.ogg
      ;;
    "NORMAL")
      ${pkgs.mpv}/bin/mpv ${notification_sound}/Taptap.ogg
      #${pkgs.mpv}/bin/mpv ${notification_sound}/notification.mp3
      ;;
    "CRITICAL")
      ${pkgs.mpv}/bin/mpv ${notification_sound}/Alarmed.ogg;
      #${pkgs.mpv}/bin/mpv ${notification_sound}/Beeper.ogg;
      ;;
    esac
    '';

  notification_sound = pkgs.stdenv.mkDerivation {
    name = "notification_sound";
    src = ./notification_sound;
    dontUnpack = true;
    installPhase = ''
      mkdir $out
      cp $src/* $out/
    '';
  };
in
{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    settings = lib.recursiveUpdate settings (import ./themes/${config.custom.theme}.nix);

    # There is no extraConfig option
    /*
      xdg.configFile."dunst/dunstrc".text = ''
      ${theme}
      ${builtins.getAttr config.custom.theme themeConf}
      ${builtins.readFile ./dunstrc}
      '';
      */
  };
}
