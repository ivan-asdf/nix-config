{ pkgs, ... }:
let
  icons = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
    sha256 = "sha256-FSwjydZ2I1OUBs9CNl/S+jo4SOEcKP9byt50FOk8YEQ=";
  };
  colors = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example";
    sha256 = "sha256-cYJlXuRjuotQ1aynPG5+UGK2nBBNg/6xRiGs2mBpKeY=";
  };
in
{
  programs.lf = {
    enable = true;

    settings = {
      icons = true;
    };

    # live update
    # trash

    commands = {
      mkdir = ''''${{
        echo "Create file: "
        read filename
        if [[ "$filename" == */ ]]; then
          mkdir "$filename"
        else
          touch "$filename"
        fi
      }}'';

      # '%' pipes output to ui, '$' runs in seperate shell
      unarchive = ''%{{
        case "$f" in
          *.zip) unzip "$f" ;;
          *.tar.gz) tar -xzvf "$f" ;;
          *.tar.bz2) tar -xjvf "$f" ;;
          *.tar) tar -xvf "$f" ;;
          *.rar) unrar x "$f" "$(basename "$f" ".rar")/" ;;
          *) echo "Unsupported format";;
        esac
      }}'';

      # default &$OPENER "$f" (async - opens text files browser for some reason)
      # switching to $$OPENER (sync - opens text files slow)
      # Final solution (its both fast and works as expected)
      open = ''''${{
        #case $(file --mime-type "$f" -bL) in
        case $(xdg-mime query filetype "$f") in
          text/*|application/json) $EDITOR "$f";;
          application/x-executable) "$f" ; zsh;;
          *) xdg-open "$f" ;;
        esac
      }}'';
    };

    keybindings = {
      a = "mkdir";

      d = "";
      dD = "delete";
      dd = "cut";

      #"<c-h>" = "set hidden!";
      # for some reason <backspace> coresponds to <c-h>
      "<backspace>" = "set hidden!";

      "<c-s>" = "$zsh";

      x = "unarchive";

      R = "reload";
    };

    extraConfig = ''
      set previewer ctpv
      set cleaner ctpvclear
      &ctpv -s $id
      &ctpvquit $id
    '';
  };

  xdg.configFile."lf/icons".source = icons;
  xdg.configFile."lf/colors".source = colors;

  home.packages = with pkgs; [
    # for drawing image previews
    (callPackage ./ctpv/ctpv.nix { })
    # used by ctpv
    ueberzug # images
    imagemagick # svg
    atool # archives
    ffmpegthumbnailer # video
    glow # markdown
    poppler_utils # pdf
    ffmpeg # audio
  ];
}
