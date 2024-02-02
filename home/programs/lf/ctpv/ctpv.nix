{ pkgs, fetchgit, ... }:
pkgs.stdenv.mkDerivation {
  name = "ctpv";
  src = fetchgit {
    url = "https://github.com/NikitaIvanovV/ctpv.git";
    branchName = "1.1v";
    sha256 = "sha256-tFBXCUey1lsNAg1mB0iQjDoH70qL8aytE6h9rhHlBe4=";
  };
  # libmagic libcrypto
  buildInputs = with pkgs; [ file openssl ];
  installPhase = "DESTDIR=$out make PREFIX=\"\" install";
}
