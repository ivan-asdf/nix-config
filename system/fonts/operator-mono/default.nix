{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "Operator Font";
  # src = ./fonts;
  src = pkgs.fetchgit {
    url = "https://github.com/keyding/Operator-Mono";
    rev = "c67835e";
    sha256 = "sha256-9XSzC6Hc13ljiDoTL8X6at5zKC9PNiT8FvQjJsFOg+4=";
  };
  installPhase = "
      mkdir -p $out/share/fonts/operator-mono
      cp $src/Fonts/* $out/share/fonts/operator-mono/
    ";
}
