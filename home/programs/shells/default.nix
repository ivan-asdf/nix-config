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
  };
}


