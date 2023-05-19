{ pkgs, ... }:
let
  wc = "${pkgs.coreutils}/bin/wc";
  grep = "${pkgs.gnugrep}/bin/grep";
  pulseaudio-ctl = "${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl";
  pacmd = "${pkgs.pulseaudio}/bin/pacmd";
in
pkgs.writeShellScript
  "mic_polybar"
  ''
    #this does not work because pulseuadio-ctl is bash script which internaly cannot find grep
    #echo $(${pulseaudio-ctl} | ${grep} "Is source muted" | ${wc} -c)
    if ${pacmd} list-sources | ${grep} -A 15 "* index" | ${grep} -q "muted: yes"
    then
      echo "  " # Muted Icon (Install Some icon pack like feather, nerd-fonts)
    else
      echo "  " # Unmuted Icon (Install Some icon pack like feather, nerd-fonts)
    fi
  ''

