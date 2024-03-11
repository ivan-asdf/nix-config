{ pkgs ? import <nixpkgs> { }, buildPythonPackage, cmake }:
buildPythonPackage rec {
  pname = "pywhispercpp";
  version = "1.2.0";
  format = "wheel";
  # src = pkgs.fetchPypi {
  #   inherit pname version format;
  #   inherit pname version;
  #   sha256 = "sha256-0MSmwGyn019K9V91AAAGwwOQQ7Cyun7uQqvtHU6mPM8=";
  #   url = "https://files.pythonhosted.org/packages/2c/f3/cb15a452507b3cf37b61c144db9da8aa1670bd9ded24436a9d1e4fa01b90/pywhispercpp-1.2.0-pp310-pypy310_pp73-win_amd64.whl";
  #   dist = "AAAAAAAAAAAAAAAApp310";
  #   python = "pypy310_pp73";
  #   abi = "manylinux_2_17_x86_64";
  #   platform = "manylinux2014_x86_64";
  # };
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/51/a2/c62b2353c857a9a385ea19d6c736cb4c1d50dc4d136bd4d24ac7e47a0d26/pywhispercpp-1.2.0-pp310-pypy310_pp73-manylinux_2_17_x86_64.manylinux2014_x86_64.whl";
    sha256 = "sha256-1sE2uIWojOOuxZ+48CQ5PXPQKhCmsBRPiwl/IO4PZug=";
  };
  # buildInputs = [ pkgs.cmake ];
  # propagatedBuildInputs = [ pkgs.cmake ];
  # cmakeFlags = [
  #   "-DWHISPER_COREML=1"  # Example of a CMake argument
  #   # Add other CMake arguments here
  # ];
  # nativeBuildInputs = [ pkgs.cmake ];
}
