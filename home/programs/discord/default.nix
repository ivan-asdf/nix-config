{ pkgs, config, ... }:
let
  themesMapping =
    {
      catppuccin = "catppuccin.css";
      kanagawa = "gruvbox.css";
    };
  themeCss = builtins.readFile ./${builtins.getAttr config.custom.theme themesMapping};
in
{
  home.packages = [ (pkgs.discord.override { withOpenASAR = true; }) ];
  xdg.configFile."discord/settings.json".text = ''
    {
      "SKIP_HOST_UPDATE": true,
      "openasar": {
        "setup": true,
        "css": ${builtins.toJSON themeCss},
        "quickstart": true
      },
      "IS_MAXIMIZED": false,
      "IS_MINIMIZED": false,
      "WINDOW_BOUNDS": {
        "x": 24,
        "y": 50,
        "width": 1122,
        "height": 1224
      },
      "trayBalloonShown": true
    }'';

  # bugged: fails to find preload.js file in /tmp location
  /*
    programs.discocss = {
    enable = true;
    discord = pkgs.discord.override {withOpenASAR = true;};
    css = builtins.readFile ./discord.css;
    };
  */
  /*
    programs.discocss = {
    enable = true;
    #discordPackage = pkgs.discord.override { withOpenASAR = true; };
    css = builtins.readFile (builtins.fetchurl {
      url = "https://github.com/catppuccin/discord/blob/main/themes/latte.theme.css";
      sha256 = "175i1x99p0jd92wbfdalya4q9lq80lmv0acv672rc2vprzs2p5zz";
    });
    };
  */

}
