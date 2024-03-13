{ pkgs, config, ...}: {
  programs.rofi = {
    enable = true;
    theme = "mytheme";
  };

  xdg.configFile."rofi/mytheme.rasi" = {
    # source = ./${config.custom.theme}.rasi;
    text = ''
      * {
        mainfont: "${config.custom.font} 16";
        bigfont: "${config.custom.font} 21";
        font: @mainfont;
      }
      ${builtins.readFile ./${config.custom.theme}.rasi}
    '';
  };

  # kanagawa.rasi uses it
  home.packages = [ pkgs.papirus-icon-theme ];
}


