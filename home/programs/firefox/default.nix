{ pkgs, ... }:
let
  # in nur there is a buildFirefoxXpiAddon defined
  youtube-speed-control = pkgs.stdenv.mkDerivation {
    name = "youtube_speed_control";
    version = "1.1.4";
    src = pkgs.fetchurl {
      url = "https://addons.mozilla.org/firefox/downloads/file/3993416/youtube_speed_control-1.1.4.xpi";
      sha256 = "377980ba62cfa24df269cf555437a21c381babb83d06c63b6c3f95afb2a5ffce";
    };
    buildCommand = '' 
      # this gets mapped to home-manager-files/.mozilla/firefox/{profile}/extensions
      dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
      mkdir -p "$dst"
      # A correct addon id is required you can get it by installing from store
      # and going to about:debugging and looking at ExtensionID.
      install -v -m644 "$src" "$dst/{63eebab4-6bd0-44a0-8d79-7fefb998ebc1}.xpi"
    '';
  };
in
{
  programs.firefox = {
    enable = true;
    profiles.ivan-nix = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        privacy-badger
        vimium
        betterttv
        youtube-speed-control
      ];
      extraConfig = builtins.readFile ./user.js;
      # This one has verticaly tighter rows
      userChrome = builtins.readFile ./userChrome.css;
      #userChrome = builtins.readFile ./multi-row_bookmarks.css;
    };
  };
}

