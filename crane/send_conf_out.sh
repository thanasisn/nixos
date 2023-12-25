#!/usr/bin/env bash

rsync -ahv --exclude "*.git*" "/home/athan/CODE/nixos/"  "athan@155.207.9.214:/home/athan/CODE/tmp_nixos4"

