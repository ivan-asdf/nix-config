source "$(dirname "$0")/common.sh"
set -o errexit

sudo nixos-enter --root $MNT_PATH -c 'passwd ivan; chown -R ivan:users /home/ivan/.nix-config'
