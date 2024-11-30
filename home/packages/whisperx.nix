{ pkgs ? import <nixpkgs> { }, buildPythonPackage }:
buildPythonPackage rec {
  pname = "whisperx";
  version = "3.1.1";
  doCheck = false;
  src = pkgs.fetchurl {
    url = "https://github.com/m-bain/whisperX/archive/refs/heads/main.zip";
    sha256 = "sha256-cReysZkLz/98eY01hNNTNFI7Cl+Q13UIRFTMH8ErLdo=";
  };
}
