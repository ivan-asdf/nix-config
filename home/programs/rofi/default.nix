{ pkgs, config, ...}: {
  programs.rofi = {
    enable = true;
    theme = "mytheme";
  };

  xdg.configFile."rofi/mytheme.rasi" = {
    source = ./${config.custom.theme}.rasi;
  };

  # kanagawa.rasi uses it
  home.packages = [ pkgs.papirus-icon-theme ];
}


