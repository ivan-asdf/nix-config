{ pkgs, ... }:
let
  apply_home = pkgs.writeShellScriptBin
    "apply-home"
    (builtins.readFile ./apply-home.sh);

  apply_system = pkgs.writeShellScriptBin
    "apply-system"
    (builtins.readFile ./apply-system.sh);
in
{
  imports = [ ./powermenu.nix ];
  home.packages = [
    apply_home
    apply_system
  ];
}
 
