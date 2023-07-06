
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
    git-cola
    gitg
    gnome.gnome-disk-utility
    gparted
    keepassxc
  ];
}
