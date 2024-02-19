#!/usr/bin/env bash

#### Update build and switch system

PREFX="/home/athan/CODE/nixos"
export NIXPKGS_ALLOW_INSECURE=1

## update
nix-channel --update

## rebuild and switch
nixos-rebuild -I nixos-config="../$(hostname)/configuration.nix" switch

## remove old generations
"$PREFX/scripts/trim-generation.sh" 30 30 system

## deletes unreachable paths in the Nix store
nix store gc


## cleanup a litle?
nix-collect-garbage

## as root switch to generation 204
# sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation 204

## as root delete broken generations 205 and 206 
# sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations 205 206



## Display changes
"$PREFX/scripts/changes_system.sh"

exit 0
