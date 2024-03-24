{ pkgs, config, ... }:
let
  powermenu = pkgs.writeShellScriptBin
    "powermenu"
    ''
      chosen=$(printf "  Power Off\n  Restart\n  Suspend\n  Hibernate\n  Log Out\n Lock" | \
      ${pkgs.rofi}/bin/rofi \
      -dmenu -i -location 3 \
      -theme-str 'window {width: 500px;} textbox-current-entry {horizontal-align: 0;}' \
      -yoffset ${toString config.services.polybar.settings."bar/bar1".height})

      case "$chosen" in
        "  Power Off") ${pkgs.systemd}/bin/poweroff ;;
        "  Restart") ${pkgs.systemd}/bin/reboot ;;
        "  Suspend") ${pkgs.systemd}/bin/systemctl suspend-then-hibernate ;;
        "  Hibernate") ${pkgs.systemd}/bin/systemctl hibernate ;;
        "  Log Out") ${pkgs.i3}/bin/i3-msg exit ;;
        " Lock") ${pkgs.betterlockscreen}/bin/betterlockscreen -l ;;
        *) exit 1 ;;
      esac'';
in
{
  config = {
    home.packages = [ powermenu ];

    nixpkgs.overlays = [
      (self: super: {
        inherit powermenu;
      })
    ];
  };
}
