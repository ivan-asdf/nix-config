{ pkgs, config, lib, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    settings = lib.recursiveUpdate (import ./common.nix) (import ./${config.custom.theme}.nix);

    # There is no extraConfig option
    /*
      xdg.configFile."dunst/dunstrc".text = ''
      ${theme}
      ${builtins.getAttr config.custom.theme themeConf}
      ${builtins.readFile ./dunstrc}
      '';
      */
  };
}
