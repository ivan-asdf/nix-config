{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    #cdpath = [ "~/.nix-config" ]; ?!?! what dis do?
    dotDir = ".config/zsh";

    enableCompletion = true; # somesomething add bla bla for system pkgs completion!??!
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = "^P";
      searchDownKey = "^N";
    };
    history = {
      ignorePatterns = [ "rm *" ];
      ignoreSpace = true;
      extended = true;
      share = true;
    };
    defaultKeymap = "emacs";

    plugins = [
      {
        name = "auto-notify";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-auto-notify";
          rev = "0.8.0";
          sha256 = "bY0qLX5Kpt2x4KnfvXjYK2+BhR3zKBgGsCvIxSzApws=";
        };
      }
    ];


    initExtraFirst = builtins.readFile ./catppuccin_latte-zsh-syntax-highlighting.zsh;
    initExtra = builtins.readFile ./zshrc;
    #TODO
    # auto-notify add exceptions
    # vim mode(not vi which cant delete in insert mode) + cursor collors change
  };

  # dependecy of auto-notify plugin
  home.packages = [ pkgs.libnotify ];
}
