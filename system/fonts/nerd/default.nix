{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "Nerd Font";
  src = ./.;
  installPhase = "
    mkdir -p $out/share/fonts/nerd
    cp $src/'Symbols-2048-em Nerd Font Complete.ttf' $out/share/fonts/nerd/
  ";
}
