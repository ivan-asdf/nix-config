{ pkgs, ... }: {
  imports = [
    ./bash
    ./zsh
    ./nushell

    ./starship
    ./dircolors
  ];

  programs.atuin = {
    enable = true;
    #enableBashIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      style = "compact";
    };
  };

  # fzf --preview='kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {}'

  # With this the preview is fine until you go to image after which the 0, 0 position goes beyong the preview borders(at exact 0, 0)
  # fzf --preview='ctpv {} ${FZF_PREVIEW_COLUMNS} ${FZF_PREVIEW_LINES} ${FZF_PREVIEW_LEFT} ${FZF_PREVIEW_TOP}'
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--height 90%" "--border" ];
    colors = {
      fg = "#dcd7ba";
      bg = "#1f1f28";
      "hl" = "#2d4f67";
      "bg+" = "#dcd7ba";
      "fg+" = "#1f1f28";
      "hl+" = "#2d4f67";
      gutter = "#1f1f28"; # By default =bg+. Now its effectively transparent.
    };
  };

  programs.zoxide = {
    enable = true;
  };
}


