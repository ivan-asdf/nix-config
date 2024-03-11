{ pkgs, ... }: {
  imports = [
    ./starship
    ./bash
    ./zsh
    ./nushell
  ];

  programs.atuin = {
    enable = true;
    #enableBashIntegration = true;
  };
}


