#!/usr/bin/env bash

#### Build and switch system without update

export NIXPKGS_ALLOW_INSECURE=1


SCRIPT="$(basename "$0")"
PREFX="/home/athan/CODE/nixos"
LOGDR="/home/athan/LOGs/SYSTEM_LOGS/"
LOGFL="$LOGDR/nix_${SCRIPT%.sh}_$(hostname).log"
BLDFL="$LOGDR/nix_${SCRIPT%.sh}_$(hostname).build"
ERRFL="$LOGDR/nix_${SCRIPT%.sh}_$(hostname).err"
mkdir -p "$LOGDR"

## universal logging
exec  > >(tee -i "${LOGFL}")
exec 2> >(tee -i "${ERRFL}" >&2)


echo "NixOs Rebuilding..."
# https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5
## rebuild and switch
nixos-rebuild                                          \
    -I nixos-config="../$(hostname)/configuration.nix" \
    switch &> "$BLDFL" || (grep --color error "$LOGFL" && false)

# # Get current generation metadata
# current=$(nixos-rebuild list-generations | grep current)
# # Commit all changes witih the generation metadata 
# git commit -am "$(hostname) $current"

echo "Remove old generations..."
"$PREFX/scripts/trim-generation.sh" 30 30 system

echo "Delete unreachable paths in the Nix store..."
nix store gc

echo "Run garbage collector..."
## cleanup a litle?
nix-collect-garbage

## as root switch to generation 204
# sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation 204

## as root delete broken generations 205 and 206 
# sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations 205 206

echo "Display last changes..."
"$PREFX/scripts/changes_system.sh"

echo "Nix folder size..."
du -sh /nix

exit 0
