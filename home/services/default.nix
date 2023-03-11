{...} : {
  imports = [
    ./picom
    ./polybar
    ./custom/change_wallpaper
  ];

  systemd.user.sessionVariables = {
    PATH = "$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
  };

  /*TODO:
  Added lock screen activated when monitor sleep, suspend, hibernate
  monitor sleep
    is manageged by X11(somewhere configured)
      you can also manually call it
      you can also use xautolocker which independ of X11 config tracks input and activates given program
  suspend + hibernate
    they are systemd targets so just write a requiredBy=suspend unit
  */
}
