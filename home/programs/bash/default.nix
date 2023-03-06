{...} : {
  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./bashrc;
  };

  programs.starship = {
    enable = true;
  };

  xdg.configFile."starship.toml" = {
    source = ./starship.toml;
  };
}
