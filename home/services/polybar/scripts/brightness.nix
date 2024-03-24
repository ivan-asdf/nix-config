{ pkgs, ... }: pkgs.stdenv.mkDerivation {
  name = "brightness";
  dontUnpack = true;
  src = ./brightness.py;
  propagatedBuildInputs = with pkgs; [
    python3
  ];
  buildInputs = [
    pkgs.makeWrapper
  ];
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 $src $out/bin/brightness
  '';
  postFixup = with pkgs; ''
    wrapProgram $out/bin/brightness \
      --set PATH ${lib.makeBinPath [
    gawk
    xorg.xrandr
    gnugrep
    ]}
  '';
}
