#!/usr/bin/env bash
## created on 2023-12-12

#### Update and switch home-manager

export NIXPKGS_ALLOW_INSECURE=1

nix-channel --update

## with flakes
# nix flake update --flake "$HOME/CODE/nixos/home-manager"
# nix run nixpkgs\#home-manager -- switch --flake "$HOME/CODE/nixos/home-manager/#athan"

PREFX="/home/athan/CODE/nixos"

## rebuild and switch
home-manager switch -f "$PREFX/home-manager/home.nix"

## remove old generations
"$PREFX/scripts/trim-generation.sh" 30 30 home-manager

## deletes unreachable paths in the Nix store
nix store gc


## Delete all generations created more than number days ago
# nix-env --delete-generations 30d

## Keep the last number generations, along with any newer than current
# nix-env --delete-genarations +5

## delete all old profiles
# nix-collect-garbage -d

## delete older than n days
# nix-collect-garbage --delete-older-than  30d


## Display changes
"$PREFX/scripts/changes_home_manager.sh"

exit 0
