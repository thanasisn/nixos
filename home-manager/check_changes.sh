#!/bin/bash
## created on 2024-01-17

#### Cheack last changes


nix profile history

echo ""
echo "----------"
echo ""

## show changes from last generation
nix profile diff-closures --profile ~/.local/state/nix/profiles/home-manager

echo ""
echo "----------"
echo ""
## using nvd
last="$(find "$HOME/.local/state/nix/profiles/" -name "*home-manager-*" | sort | tail -n1)"
previous="$(find "$HOME/.local/state/nix/profiles/" -name "*home-manager-*" | sort | tail -n2 | head -n1)"

nvd diff "$previous" "$last"

exit 0 
