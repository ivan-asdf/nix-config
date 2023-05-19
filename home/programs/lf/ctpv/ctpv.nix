{ pkgs, fetchgit, ... }:
pkgs.stdenv.mkDerivation {
  name = "ctpv";
  src = fetchgit {
    url = "https://github.com/NikitaIvanovV/ctpv.git";
    sha256 = "sha256-1TwmP6gH03xQv+F9ByfTS2B/SQmTzTOqrCRYjYpmHDo=";
  };
  # libmagic libcrypto
  buildInputs = with pkgs; [ file openssl ];
  installPhase = "DESTDIR=$out make PREFIX=\"\" install";
}
