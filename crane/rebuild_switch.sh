#!/usr/bin/env bash

## always upadte secrets
cp -v ./secrets/crane_secrets.yaml /etc/nixos/secrets/example.yaml
## rebuild and switch
nixos-rebuild -I nixos-config="./configuration.nix" switch

# nixos-rebuild --verbose -I nixos-config="./configuration.nix" switch


# nix-collect-garbage

