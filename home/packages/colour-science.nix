{ pkgs ? import <nixpkgs> { }, buildPythonPackage, scipy, matplotlib }:
buildPythonPackage rec {
  pname = "colour_science";
  version = "0.4.4";
  format = "wheel";
  src = pkgs.fetchPypi {
    inherit pname version format;
    sha256 = "sha256-B9iubaam90WoOjLfJob6rOip97r32mHbtsqaYfdnG9s=";
    dist = "py3";
    python = "py3";
  };
  propagatedBuildInputs = [ scipy matplotlib ];
}
