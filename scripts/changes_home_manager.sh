#!/usr/bin/env bash
## created on 2024-01-17

#### Check last changes for home-manager

# nix profile history


## Using nix
echo ""
echo "--- Changes in each generation ---"
echo ""
nix profile diff-closures --profile ~/.local/state/nix/profiles/home-manager


## Using nvd
echo ""
echo "--- Changes on the last generations -------"
echo ""
last="$(    find "$HOME/.local/state/nix/profiles/" -name "*home-manager-*" | sort | tail -n1)"
previous="$(find "$HOME/.local/state/nix/profiles/" -name "*home-manager-*" | sort | tail -n2 | head -n1)"
nvd diff "$previous" "$last"



exit 0
