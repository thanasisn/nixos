#!/usr/bin/env bash

nixos-rebuild -I nixos-config="./configuration.nix" switch
# nixos-rebuild --verbose -I nixos-config="./configuration.nix" switch
