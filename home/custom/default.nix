{ lib, config, ... }: {
  # This will be read by programs which configure their themes
  options.custom.theme = lib.mkOption {
    type = lib.types.str;
    default = "kanagawa";
    description = ''
      This will be read by modules of programs which use it to configure their themes.
      Used by: nvim, alacritty, polybar, i3, firefox, discord, rofi, dunst
      Currently available values:
        "kanagawa"
        "catppuccin"
    '';
  };
  #config.custom.theme = "catppuccin";
  # Discord variants for theming:
  # openasar(you can insert css in discord settings.json)
  # betterdiscord(you can insert css file & other plugins)
  # discocss(wrapper)(you can specify css which it inserts)(bugged tmp file deleted)
  # webcord(electron wrapper) you cannot specify theme
  # Other: powercord, armcord
  # Other niche or terminal: discordo, cordless

  options.custom.font = lib.mkOption {
    type = lib.types.str;
    default = "Cascadia code";
    description = ''
      A default font to be used for configuration by various programs
    '';
  };
  # config.custom.font = "Hack";
  # config.custom.font = "Fira Code";
  # config.custom.font = "Operator Mono Medium";
}
