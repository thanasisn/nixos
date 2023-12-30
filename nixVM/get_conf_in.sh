#!/usr/bin/env bash

rsync -avh --exclude "*.git*" "athan@10.12.12.6:/home/athan/CODE/nixos"  "/home/athan/CODE"

