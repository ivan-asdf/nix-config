{ pkgs, config, lib, ... }:
let
  mod = "Mod4";
  terminal = "kitty";
  #menu = "dmenu_run";
  menu = "rofi -show drun -show-icons";
in
{
  home.packages = with pkgs; [ autotiling ];
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      # set these so that default config can use them
      modifier = mod;
      inherit terminal menu;
      keybindings = lib.mkOptionDefault {
        "${mod}+p" = "exec ${menu}";
        "Print" = "exec flameshot full -c -p ~/.cache/screenshots/";
        "Shift+Print" = "exec flameshot gui -c -p ~/.cache/screenshots/";
        "${mod}+Shift+x" = "exec betterlockscreen -l blur";
        #"${mod}+u" = "exec betterlockscreen -l blur";
        "${mod}+Escape" = "exec ${pkgs.powermenu}/bin/powermenu";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
      };

      startup = [
        { command = "autotiling"; always = true; }
        #runing with systemd - it restarts alone from time to time receives (signal 15)
        { command = "systemctl --user restart polybar"; always = true; notification = false; }
        #{ command = "pkill polybar; polybar --log=info 2>> /home/ivan/.cache/polybar1.log"; always = true; notification = false; }
        #{ command = "pkill polybar; polybar"; always = true; notification = false; }
        { command = "mkdir ~/.cache/screenshots/ -p"; always = true; }
      ];
      defaultWorkspace = "workspace number 1";

      # remove i3 bar
      bars = [ ];
      # remove titlebars
      window.titlebar = false;
      window.border = 4;
      gaps.outer = 13;
      gaps.top = 29 + 13;
      gaps.inner = 10;
    };

    extraConfig = builtins.readFile ./themes/${config.custom.theme};
  };
}

