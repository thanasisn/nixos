#!/usr/bin/env bash
## created on 2023-12-12

#### Update, switch and remove old for home-manager

nix-channel --update

## with flakes
# nix flake update --flake "$HOME/CODE/nixos/home-manager"
# nix run nixpkgs\#home-manager -- switch --flake "$HOME/CODE/nixos/home-manager/#athan"

## without flakes
home-manager switch -f "$HOME/CODE/nixos/home-manager/home.nix"

## remove old generations
"./trim-generation.sh" 30 30 home-manager


## Delete all generations created more than number days ago
# nix-env --delete-generations 30d

## Keep the last number generations, along with any newer than current
# nix-env --delete-genarations +5

## deletes unreachable paths in the Nix store
# nix store gc

## delete all old profiles
# nix-collect-garbage -d

## delete older than n days
# nix-collect-garbage --delete-older-than  30d


exit 0
