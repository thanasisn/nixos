
## Basic tools for desktop node or resque

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome.gnome-disk-utility
    gparted
    keepassxc
    arandr
  ];
}
