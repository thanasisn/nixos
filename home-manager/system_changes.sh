#!/usr/bin/env bash
## created on 2024-01-17

#### Cheack last changes


# nix profile history

echo ""
echo "----------"
echo ""

## show changes from last generation
nix profile diff-closures --profile /nix/var/nix/profiles/system

echo ""
echo "----------"
echo ""
## using nvd
last="$(find "/nix/var/nix/profiles/" -name "*system-*" | sort | tail -n1)"
previous="$(find "/nix/var/nix/profiles/" -name "*system-*" | sort | tail -n2 | head -n1)"
nvd diff "$previous" "$last"

exit 0 

