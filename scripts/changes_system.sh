#!/usr/bin/env bash
## created on 2024-01-17

#### Check last changes for system

# nix profile history


## Using nix
echo ""
echo "--- Changes in each generation ---"
echo ""
nix profile diff-closures --profile /nix/var/nix/profiles/system


## Using nvd
echo ""
echo "--- Changes on the last generations -------"
echo ""
last="$(    find "/nix/var/nix/profiles/" -name "*system-*" | sort | tail -n1)"
previous="$(find "/nix/var/nix/profiles/" -name "*system-*" | sort | tail -n2 | head -n1)"
nvd diff "$previous" "$last"



exit 0 
