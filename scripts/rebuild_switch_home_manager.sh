#!/usr/bin/env bash

#### Update and switch home-manager

export NIXPKGS_ALLOW_INSECURE=1
## with flakes
# nix flake update --flake "$HOME/CODE/nixos/home-manager"
# nix run nixpkgs\#home-manager -- switch --flake "$HOME/CODE/nixos/home-manager/#athan"

SCRIPT="$(basename "$0")"
PREFX="/home/athan/CODE/nixos"
LOGFL="/home/athan/LOGs/SYSTEM_LOGS/${SCRIPT%.sh}_$(hostname).log"

echo "NixOs Rebuilding and switch..."
home-manager switch                 \
  -f "$PREFX/home-manager/home.nix" \
    switch &> "$LOGFL" || (grep --color error "$LOGFL" && false)

echo "Remove old generations..."
"$PREFX/scripts/trim-generation.sh" 30 30 home-manager

echo "Delete unreachable paths in the Nix store..."
nix store gc

echo "Run garbage collector..."
## cleanup a litle?
nix-collect-garbage

## Delete all generations created more than number days ago
# nix-env --delete-generations 30d

## Keep the last number generations, along with any newer than current
# nix-env --delete-genarations +5

## delete all old profiles
# nix-collect-garbage -d

## delete older than n days
# nix-collect-garbage --delete-older-than  30d


echo "Display last changes..."
"$PREFX/scripts/changes_home_manager.sh"

exit 0
