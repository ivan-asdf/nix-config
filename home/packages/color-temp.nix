{ pkgs ? import <nixpkgs> { }, buildPythonPackage }:
buildPythonPackage rec {
  pname = "color_temp";
  version = "0.1.0";
  format = "wheel";
  # src = pkgs.fetchPypi {
  #   inherit pname version format;
  #   sha256 = "sha256-B9iubaam90WoOjLfJob6rOip97r32mHbtsqaYfdnG9s=";
  #   dist = "py2";
  #   python = "py2";
  # };
  #
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/a7/da/281959bc428952ce9d50ac7da87bfa593f3671f3d29cee9155be163483ce/color_temp-0.1.0-py2-none-any.whl";
    sha256 = "sha256-ZjoHf5NayVrFs7LqX4GoWMLwq8H4o3nVYzKimyUJ6VY=";
  };

  #propagatedBuildInputs = [ scipy matplotlib ];
}
