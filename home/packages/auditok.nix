{ pkgs ? import <nixpkgs> { }, buildPythonPackage }:
buildPythonPackage rec {
  pname = "auditok";
  version = "0.2.0";
  format = "wheel";
  src = pkgs.fetchPypi {
    inherit pname version format;
    sha256 = "sha256-M24xV+L2xFUBgrMnKi6jLSrKfyUdO3/u/y01XSgM3Bs=";
    dist = "py3";
    python = "py3";
  };
}

