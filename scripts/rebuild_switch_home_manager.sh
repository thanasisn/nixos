#!/usr/bin/env bash

#### Update and switch home-manager

export NIXPKGS_ALLOW_INSECURE=1

## with flakes
# nix flake update --flake "$HOME/CODE/nixos/home-manager"
# nix run nixpkgs\#home-manager -- switch --flake "$HOME/CODE/nixos/home-manager/#athan"

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

echo "NixOs Rebuilding and switch..."
# home-manager switch                 \
#   -f "$PREFX/home-manager/home.nix" \
#     switch &> "$BLDFL" || (grep --color error "$LOGFL" && false)
home-manager switch                 \
  -f "$PREFX/home-manager/home.nix" \
    switch
switchtatus="$?"

if [ $switchtatus -eq 0 ]; then
  echo "Successful Switch"
else
  echo "Switch failed!!"
  exit
fi

# Commit to git
git ls-remote "$PREFX" -q
gitstatus="$?"

if [ $gitstatus -eq 0 ]; then
  echo "Commit to git"
  git -C "$PREFX" add .
  ## commit to local repo
  git -C "$PREFX" commit -uno -a -m "Home-manager switch $(hostname) $(date +'%F %R')"
  git -C "$PREFX" push -f
  git -C "$PREFX" push --tag
  git -C "$PREFX" maintenance run --auto
fi

exit


echo "Remove old generations..."
"$PREFX/scripts/trim-generation.sh" 20 20 home-manager

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

echo "Nix folder size..."
du -sh /nix

echo "Nix folder..."
df -h /nix

exit 0
