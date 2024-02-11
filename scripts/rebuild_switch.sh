#!/usr/bin/env bash

## update?
# nix-channel --update

## rebuild and switch
nixos-rebuild -I nixos-config="./configuration.nix" switch

# nixos-rebuild --verbose -I nixos-config="./configuration.nix" switch

## cleanup a litle
nix-collect-garbage

## list generations
# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

## as root switch to generation 204
# sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation 204

## as root delete broken generations 205 and 206 
# sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations 205 206
