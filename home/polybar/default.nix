{ pkgs, ... }: {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      pulseSupport = true;
      githubSupport = true;
      i3Support = true;
    };

    config = ./latte.ini;
    script = "polybar bar1";
    #extraConfig = builtins.readFile ./polybar/latte.init;
    settings = {
      "bar/bar1" = {
        font = [
          "FiraCode Nerd Font;3"
          "Noto Color Emoji:scale=8;2"
          "Font Awesome 5 Free"
          "FontAwesome6Free"
          "FontAwesome6Free Solid"
          "FontAwesome6Brands"
          "fontello;3"
        ];
        width = "100%";
        height = 29;
        padding-right = 1;

        background = "\${colors.base}";
        foreground = "\${colors.text}";

        border-size = 5;
        border-color = "\${colors.crust}";

        seperator = "|";
        module-margin = 2;
        modules-left = "i3";
        modules-center = "xwindow";
        modules-right = "cpu volume";
      };
      "module/i3" = {
        type = "internal/i3";
        label-focused-background = "\${colors.overlay0}";
        label-unfocused-background = "\${colors.surface0}";
        #label-separator = " ";
        #label-separator-padding = 1;
        workspace-label = "%index%";
        label-focused = "\${self.workspace-label}";
        label-unfocused = "\${self.workspace-label}";
        label-urgent = "\${self.workspace-label}";
        label-visible = "\${self.workspace-label}";
        label-focused-padding = 2;
        label-unfocused-padding = 1;
      };
      "module/xwindow" = {
        type = "internal/xwindow";
      };
      "module/volume" = {
        type = "internal/pulseaudio";
        format.volume = "<ramp-volume> <label-volume>";
        label.muted.text = "🔇";
        ramp.volume = [ "🔈" "🔉" "🔊" ];
        click.right = "pavucontrol &";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 0.5;
        format = "<label> <ramp-coreload>";
        label = " %percentage%%";
        label-warn = " %percentage%%";
        #ramp-coreload-spacing = 1;
        ramp-coreload = [ " " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        ramp-coreload-spacing = 0;
      };
    };
  };
}

