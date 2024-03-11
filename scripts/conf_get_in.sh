#!/usr/bin/env bash

rsync -avh --update --exclude "*.git*" "athan@155.207.9.214:/home/athan/CODE/nixos"  "/home/athan/CODE"

