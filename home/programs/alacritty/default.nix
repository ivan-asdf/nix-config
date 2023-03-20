{ config, ... }: {
  programs.alacritty.enable = true;

  xdg.configFile."alacritty/alacritty.yml" = {
    text = ''
      ${builtins.readFile ./alacritty.yml}
      ${builtins.readFile ./${config.custom.theme}.yml}
    '';
  };
}
