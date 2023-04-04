{ pkgs, fetchgit, ... }:
pkgs.stdenv.mkDerivation {
  name = "ctpv";
  src = fetchgit {
    url = "https://github.com/NikitaIvanovV/ctpv.git";
    sha256 = "sha256-Hi3ed6mvghOwMngydey54KeF6H2ca3an3xHM7I4XGSE=";
  };
  # libmagic libcrypto
  buildInputs = with pkgs; [ file openssl ];
  installPhase = "DESTDIR=$out make PREFIX=\"\" install";
}
