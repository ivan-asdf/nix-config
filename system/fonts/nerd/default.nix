{ pkgs, ... }:
let
  nerd_font = pkgs.stdenv.mkDerivation {
    name = "Nerd Font";
    src = ./.;
    installPhase = "
      mkdir -p $out/share/fonts/nerd
      echo 'HELLO'
      cp $src/'Symbols-2048-em Nerd Font Complete.ttf' $out/share/fonts/nerd/
    ";
  };
in
nerd_font

