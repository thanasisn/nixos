
## Setup a working environment for my work
## Include usual gui programs

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gthumb
    jabref
    libreoffice
    mate.caja-with-extensions
    ncview
    rstudio
    sqlitebrowser
    thunderbird    
    xfce.xfce4-appfinder
    zotero
    rclone-browser
  ];
}
