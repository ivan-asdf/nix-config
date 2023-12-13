{ pkgs, fetchgit, ... }:
pkgs.stdenv.mkDerivation {
  name = "ctpv";
  src = fetchgit {
    url = "https://github.com/NikitaIvanovV/ctpv.git";
    sha256 = "sha256-CFCEJfCSn/GCK2kcD7KUkCq8O++BbAyhCDk3CZo/koA=";
  };
  # libmagic libcrypto
  buildInputs = with pkgs; [ file openssl ];
  installPhase = "DESTDIR=$out make PREFIX=\"\" install";
}
