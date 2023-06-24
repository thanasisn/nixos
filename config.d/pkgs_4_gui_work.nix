
## Setup a working environment for my work
## Include usual gui programs

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adwaita-qt
    font-manager
    gthumb
    jabref
    libreoffice
    lxappearance
    mate.caja-with-extensions
    ncview
    oxygen-icon-theme
    oxygencursors
    qt5ct
    rclone-browser
    rstudio
    spyder3
    sqlitebrowser
    thunderbird    
    xfce.xfce4-appfinder
    zotero
    conky
    diffpdf
    evince
    graphviz
    meld
    okular
    viking
    kst
    recoll
    regexxer
    rkward
    searchmonkey
    sqlitebrowser
  ];
}
