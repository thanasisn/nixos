
## Basic tools for desktop node or resque

{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    arandr
    autorandr
    brave
    meld
    firefox
    git-cola
    gitg
    gnome.gnome-disk-utility
    gparted
    keepassxc
  ];
}
