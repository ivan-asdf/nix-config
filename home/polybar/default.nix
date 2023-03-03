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
    #script = "polybar example";
    script = "polybar bar1";
    #extraConfig = builtins.readFile ./polybar/latte.init;
    settings = {
      "bar/bar1" = {
        font = [
          "Fira Code Regular Nerd Font Complete;3"
          "Noto Color Emoji:scale=8;2"
        ];
        width = "100%";
        height = 29;
        padding-right = 1;

        background = "\${colors.base}";
        foreground = "\${colors.text}";

        border-size = 5;
        border-color = "\${colors.crust}";

        seperator = "|";
        modules-left = "i3";
        modules-center = "xwindow";
        modules-right = "volume";
      };
      "module/i3" = {
        type = "internal/i3";
        label-focused-background = "\${colors.overlay0}";
        #label-separator = " ";
        #label-separator-padding = 1;
        workspace-label = " %index% ";
        label-focused = "\${self.workspace-label}";
        label-unfocused = "\${self.workspace-label}";
        label-urgent = "\${self.workspace-label}";
        label-visible = "\${self.workspace-label}";
      };
      "module/xwindow" = {
        type = "internal/xwindow";
      };
      "module/volume" = {
        type = "internal/pulseaudio";
        format.volume = "<label-volume> <ramp-volume>";
        label.muted.text = "🔇";
        ramp.volume = [ "🔈" "🔉" "🔊" ];
        click.right = "pavucontrol &";
      };
    };
  };
}

