
## Setup a working environment for my work
## Include usual gui programs

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    adwaita-qt
    libsForQt5.dolphin
    cdo
    regextester
    conky
    diffpdf
    dunst
    evince
    evolution
    font-manager
    geany
    gnome.adwaita-icon-theme
    gnome.simple-scan
    gpsbabel
    graphviz
    gthumb
    hdfview
    jabref
    josm
    # kst
    libreoffice
    libsForQt5.kate
    libsForQt5.okular
    libsForQt5.oxygen-icons5
    libsForQt5.qt5ct
    lxappearance
    mate.caja-with-extensions
    meld
    ncview
    oxygenfonts
    rclone-browser
    recoll
    # regexxer
    rstudio
    # searchmonkey
    spyder
    sqlitebrowser
    thunderbird    
    viking
    xfce.xfce4-appfinder
    zathura
    zotero
  ];
}
