{...}: {
  programs.rofi = {
    enable = true;
    theme = "catppuccin";
  };

  xdg.configFile."rofi/catppuccin.rasi" = {
    source = ./rofi_theme_catppuccin.rasi;
  };
}


