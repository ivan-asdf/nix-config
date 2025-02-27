{ pkgs, ... }:
let
  icons = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/gokcehan/lf/r31/etc/icons.example";
    sha256 = "sha256-QbWr5FxJZ5cJqS4zg+qyNK8JUG6SdLmaFoBuFXi0q0M=";
  };
  # colors = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/gokcehan/lf/r31/etc/colors.example";
  #   sha256 = "sha256-cYJlXuRjuotQ1aynPG5+UGK2nBBNg/6xRiGs2mBpKeY=";
  # };
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
        BASENAME="''${f%%.*}"
        case "$f" in
          #*.zip | *.cbz) unzip "$f" -d $BASENAME;;
          #*.tar.gz) tar -xzvf "$f" ;;
          #*.tar.bz2) tar -xjvf "$f" ;;
          #*.tar) tar -xvf "$f" ;;
          #*.rar) unrar x "$f" $BASENAME ;;
          *.zip | *.cbz | *.tar* | *.rar) atool -x "$f" ;;
          *.iso) echo $BASENAME; 7z x "$f" -o"$BASENAME" ;;
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

      # Remap
      # dd - trash
      # dD - rm
      # y - yank
      # x - cut
      # e - extract (edit is removed)
      # o - open (remove arrow opens, this only way open)
      # Unbinded this way
      # e - edit is removed (what to use for edit?)
      # arrow open - its not "o"

      # Extra func
      # make "r" able to enter nvim if multiple selection to rename


      #"<c-h>" = "set hidden!";
      # for some reason <backspace> coresponds to <c-h>
      "<backspace>" = "set hidden!";

      "<c-s>" = "$zsh";

      x = "unarchive";

      R = "reload";
    };

    extraConfig = ''
      # set previewer ctpv
      set cleaner ctpvclear
      # &ctpv -s $id
      # &ctpvquit $id
    '';

    previewer.source = pkgs.writeShellScript "pv.sh" ''
      case "$1" in
        *.tar*) tar tf "$1";;
        *.zip) unzip -l "$1";;
        *.rar) unrar l "$1";;
        *.7z) 7z l "$1";;
        *.iso) xorriso -indev "$1" -find ;;
        # *.iso) 7z l "$1";;
        # *.iso) isoinfo -l -i "$1" ;;
        # *.pdf) pdftotext "$1" -;;
        # *) bat --color always "$1" ;;
        *) ctpv "$@" ;;
        # *) highlight -O ansi "$1" || cat "$1";;
      esac
    '';
  };

  xdg.configFile."lf/icons".source = icons;
  # If not set it will use default - dircolors(LS_COLORS)
  # xdg.configFile."lf/colors".source = colors;

  home.packages = with pkgs; [
    # for drawing image previews
    (callPackage ./ctpv/ctpv.nix { })
    # used by ctpv
    # images
    chafa
    #ueberzug # NO LONGER SUPPPORTED
    #ueberzugpp # C++ fork
    imagemagick # svg
    atool # archives
    ffmpegthumbnailer # video
    glow # markdown
    poppler_utils # pdf
    # ffmpeg # audio
  ];
}
