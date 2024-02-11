#!/usr/bin/env bash

#### Build and switch system without update

## update?
# nix-channel --update

## rebuild and switch
nixos-rebuild -I nixos-config="../$(hostname)/configuration.nix" switch

# nixos-rebuild --verbose -I nixos-config="./configuration.nix" switch

## cleanup a litle?
nix-collect-garbage

## as root switch to generation 204
# sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation 204

## as root delete broken generations 205 and 206 
# sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations 205 206

## remove old
"./trim-generation.sh" 30 30 system


## Display system changes
"./changes_system.sh"

exit 0
