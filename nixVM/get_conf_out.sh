#!/usr/bin/env bash

# trach "/home/athan/CODE/nixos"
# scp -r  "athan@192.168.1.104:/home/athan/CODE/nixos" "/home/athan/CODE/"
rsync -ahrps "athan@192.168.1.104:/home/athan/CODE/nixos"  "/home/athan/CODE"
