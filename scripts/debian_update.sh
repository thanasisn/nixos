#!/usr/bin/env bash
## created on 2024-02-19

#### enter description here

sudo apt update
sudo apt -y upgrade
sudo apt -y autoclean
sudo apt -y autoremove

/home/athan/CODE/nixos/scripts/update_home_manager.sh


exit 0 
