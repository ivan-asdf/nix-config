{ pkgs, fetchgit, ... }:
pkgs.stdenv.mkDerivation {
  name = "ctpv";
  src = fetchgit {
    url = "https://github.com/NikitaIvanovV/ctpv.git";
    sha256 = "1zj0jcsk9zqnrifvrh6rn12hmmkp78l38ichj27ik11qdvi2456w";
  };
  # libmagic libcrypto
  buildInputs = with pkgs; [ file openssl ];
  installPhase = "DESTDIR=$out make PREFIX=\"\" install";
}
