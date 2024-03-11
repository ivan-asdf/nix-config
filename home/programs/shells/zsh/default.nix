{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    #cdpath = [ "~/.nix-config" ]; ?!?! what dis do?
    dotDir = ".config/zsh";

    enableCompletion = true; # somesomething add bla bla for system pkgs completion!??!
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
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
      {
        name = "zsh-vim-mode";
        src = pkgs.fetchFromGitHub {
          owner = "softmoth";
          repo = "zsh-vim-mode";
          rev = "1f9953b7d6f2f0a8d2cb8e8977baa48278a31eab";
          sha256 = "1i79rrv22mxpk3i9i1b9ykpx8b4w93z2avck893wvmaqqic89vkb";
        };
      }
      {
        name = "you-should-use";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.7.3";
          sha256 = "1dz48rd66priqhxx7byndqhbmlwxi1nfw8ik25k0z5k7k754brgy";
        };
      }
    ];
    /*
    oh-my-zsh = {
      enable = true;
      # also bugged no Ctrl-F Ctrl-B
      plugins = [ "vi-mode" ];
    };
    */

      #${builtins.readFile ./catppuccin_latte-zsh-syntax-highlighting.zsh}
    initExtraFirst = ''

      # bugged ^[[Z which is shift + tab acts as Esc ^[
      #source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
    initExtra = builtins.readFile ./zshrc;
    #TODO
    # make nix-shell use fsh instead of bash
    # how do auto notify exclusions work ?!? make nix-shell -p cmatrix for example not notify when exit
  };

  # dependecy of auto-notify plugin
  home.packages = [ pkgs.libnotify ];
}
