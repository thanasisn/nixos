#!/usr/bin/env bash

rsync -ahv --exclude "*.git*" "/home/athan/CODE/nixos/" "athan@10.12.12.6:/home/athan/CODE/tmp_nixos3"

