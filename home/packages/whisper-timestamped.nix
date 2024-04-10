{ pkgs ? import <nixpkgs> { }, buildPythonPackage }:
buildPythonPackage rec {
  pname = "whisper-timestamped";
  version = "1.15.3";
  format = "wheel";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/53/77/4f6a0116cd73722de4c4b60b47ee8cdf4ba6fa03504892268f74b17a4055/whisper_timestamped-1.15.3-py3-none-any.whl";
    sha256 = "sha256-0qXQlTKsoIYOiDvXLp2b7rKUqFqTYrD+LVClzILB/aQ=";
  };
}
