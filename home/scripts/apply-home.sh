set -o errexit

pushd ~/.nix-config
#home-manager switch -f ./home/home.nix
nix build .#homeConfigurations.ivan.activationPackage
./result/activate
popd
