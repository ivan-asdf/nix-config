{ pkgs, ... }: {
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
      plugin = {
        # prepend_previewers = [
        #   { mime = "image/tiff"; run = "raw"; }
        # ];
        prepend_preloaders = [
          { mime = "image/tiff"; run = "raw"; }
          { mime = "image/x-canon-cr2"; run = "raw"; }
        ];
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
  xdg.configFile."yazi/plugins/raw.yazi/init.lua".source = ./plugins/raw.yazi/init.lua;

  home.packages = with pkgs; [
    # ffmpegthumbnailer # video thumbnails
    # poppler_utils # pdf
    unar
  ];
}
