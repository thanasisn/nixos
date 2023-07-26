
## My desktop 
## Include more specific programs mostly for my desktop

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    digikam
    evolution
    golden-cheetah
    doxygen
    doxygen_gui
    gparted
    gpicview
    gpsbabel
    libsForQt5.gwenview
    qgis
    tellico
    texinfo
    texlive.combined.scheme-small
    texstudio
    vlc
# ttf-dejavu
# ttf-mscorefonts-installer
# ttf-unifont              
# upower
# vlc
# volumeicon-alsa
# xdotool
# xserver-xorg-input-synaptics
    zathura
    zim

  ];
}
