{ pkgs ? import <nixpkgs> { }, buildPythonPackage }:
buildPythonPackage rec {
  pname = "whisperx";
  version = "3.1.1";
  doCheck = false;
  src = pkgs.fetchurl {
    url = "https://github.com/m-bain/whisperX/archive/refs/heads/main.zip";
    sha256 = "sha256-OBZG4Aa5UZT83WPAwL6O6cnlDj/4QcUXyDR1RTP4QRs=";
  };
}
