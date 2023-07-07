
## Setup a working environment for my work
## Include usual gui programs

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # kst
    # nix-software-center
    # regexxer
    # searchmonkey
    adwaita-qt
    # python3
    arrow-cpp
    cdo
    conky
    czkawka
    dia
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
    libreoffice
    libsForQt5.dolphin
    libsForQt5.kate
    libsForQt5.okular
    libsForQt5.oxygen-icons5
    libsForQt5.qt5ct
    lxappearance
    mate.caja-with-extensions
    meld
    ncview
    oxygenfonts
    qalculate-gtk
    rclone-browser
    recoll
    regextester
    rstudio
    spyder
    sqlitebrowser
    thunderbird
    viking
    xfce.xfce4-appfinder
    zathura
    zotero
  ];
}
