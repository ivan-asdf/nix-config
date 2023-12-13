{ config, ... }: {
  programs.kitty = {
    enable = true;
    font.name = "Hack";
    #theme = "Catppuccin-Latte";
    settings = {
      confirm_os_window_close = 0;
      sync_to_monitor = "no";
      repaint_delay = 3;
      input_delay = 1;
    };
    extraConfig = ''
      # IEC Power Symbols
      symbol_map U+23FB-U+23FE Symbols Nerd Font

      # Octicons
      symbol_map U+2665 Symbols Nerd Font
      symbol_map U+26A1 Symbols Nerd Font
      symbol_map U+F000-U+F305 Symbols Nerd Font

      # IEC Power Symbols
      symbol_map U+2B58 Symbols Nerd Font

      # Pomicons
      symbol_map U+E000-U+E00A Symbols Nerd Font

      # Powerline
      symbol_map U+E0A0-U+E0A2 Symbols Nerd Font
      symbol_map U+E0B0-U+E0B3 Symbols Nerd Font

      # Powerline Extra
      symbol_map U+E0A3 Symbols Nerd Font
      symbol_map U+E0B4-U+E0C8 Symbols Nerd Font
      symbol_map U+E0CA Symbols Nerd Font
      symbol_map U+E0CC-U+E0D4 Symbols Nerd Font

      # Font Awesome Extension
      symbol_map U+E000-U+E0A9 Symbols Nerd Font

      # Weather Icons
      symbol_map U+F000-U+F0EB Symbols Nerd Font

      # Seti-UI + Custom
      symbol_map U+E5FA-U+E6A6 Symbols Nerd Font

      # Devicons
      symbol_map U+E600-U+E6C5 Symbols Nerd Font

      # Codicons
      symbol_map U+EA60-U+EBEB Symbols Nerd Font

      # Font Awesome
      symbol_map U+F000-U+F2E0 Symbols Nerd Font

      # Font Logos
      symbol_map U+F300-U+F32F Symbols Nerd Font

      # Octicons
      symbol_map U+F000-U+F305 Symbols Nerd Font

      # Material Design
      symbol_map U+F001-U+F847 Symbols Nerd Font
      symbol_map U+F500-U+FD46 Symbols Nerd Font
      symbol_map U+F0001-U+F1AF0 Symbols Nerd Font
      ${builtins.readFile ./kanagawa.conf}
       '';
  };
}

