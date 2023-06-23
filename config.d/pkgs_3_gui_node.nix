
## Basic tools for desktop node or resque

{ pkgs, ... }:
{
  imports = [
   ./fonts.nix
];
  environment.systemPackages = with pkgs; [
    gnome.gnome-disk-utility
    gparted
    keepassxc
    arandr
  ];
}
