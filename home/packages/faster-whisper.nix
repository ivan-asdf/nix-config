{ pkgs ? import <nixpkgs> { }, buildPythonPackage }:
buildPythonPackage {
  pname = "faster-whisper";
  version = "1.0.1";
  src = pkgs.fetchurl {
    url = "https://github.com/SYSTRAN/faster-whisper/archive/refs/tags/v1.0.1.tar.gz";
    sha256 = "sha256-j2ToAds9Dzn6hUXEvnQtGechzdWF8juYuWJfKAUybf0=";
  };
  doCheck = false;
}
