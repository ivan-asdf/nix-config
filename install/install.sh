# STANDART_NIX_CONFIG_DIR=/mnt/etc/nixos
# sudo mkdir -p $STANDART_NIX_CONFIG_DIR
# echo "copying ${NIX_CONFIG_PATH} to ${STANDART_NIX_CONFIG_DIR}"
# sudo cp -r ${NIX_CONFIG_DIR}/system/* ${STANDART_NIX_CONFIG_DIR}
source "$(dirname "$0")/common.sh"
set -o errexit

sudo nixos-install --flake "$SCRIPT_DIR/..#desktop"

sudo cp -r $SCRIPT_DIR/.. $MNT_PATH/home/ivan/.nix-config

# Install a home manager bootstrap script along with config from iso
# BOOTSTRAP_SCRIPT=/mnt/home/ivan/bootstrap_hm.sh
# echo '
# set -o errexit

# nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# nix-channel --update
# nix-shell "<home-manager>" -A install

# SCRIPT_DIR=$(dirname "$0")

# home-manager switch -f ${SCRIPT_DIR}/.nix-config/home/home.nix

# # Delete iso nix-config from home directory leaving with fresh-installed OS
# sudo rm -rf ${SCRIPT_DIR}/.nix-config
# sudo rm ${SCRIPT_DIR}/bootstrap_hm.sh' >  $BOOTSTRAP_SCRIPT

# sudo chmod a+x $BOOTSTRAP_SCRIPT
