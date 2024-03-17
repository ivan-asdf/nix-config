{ ... }: {
  programs.yazi = {
    enable = true;
    settings = {
      tasks = {
        micro_workers = 5;
        macro_workers = 3;
      };
      manager = {
        ratio = [ 2 3 6 ];
        sort_by = "natural";
        sort_dir_first = true;
      };
      preview = {
        max_width = 2560;
        max_height = 1440;
      };
    };
    keymap = {
      manager.prepend_keymap = [
        { on = [ "<C-h>" ]; run = "hidden toggle"; desc = "Toggle hidden files"; }
        { on = [ "<C-s>" ]; run = ''shell "$SHELL" --block --confirm''; desc = "Open shell here"; }
      ];
    };
    # theme = {
    #   filetype = {
    #     rules = [
    #       { mime = "*"; fg = "#ffffaa"; }
    #     ];
    #   };
    # };
  };

  xdg.configFile."yazi/theme.toml".source = ./theme.toml;
  xdg.configFile."yazi/init.lua".source = ./init.lua;
}
