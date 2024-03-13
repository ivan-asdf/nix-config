{ config, ... }: {
  programs.alacritty.enable = true;


  xdg.configFile."alacritty/alacritty.toml" = {
      #${builtins.readFile ./alacritty.toml}
    text = ''
      [env]
      TERM = "xterm-256color"

      [font]
      size = 9.5

      [font.bold]
      family = "${config.custom.font}"
      style = "Bold"

      [font.italic]
      family = "${config.custom.font}"
      style = "Italic"

      [font.normal]
      family = "${config.custom.font}"
      style = "Regular"

      ${builtins.readFile ./${config.custom.theme}.toml}
    '';
  };
}
