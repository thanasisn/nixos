
## My desktop 
## Include more specific programs mostly for my desktop

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    digikam
    evolution
    golden-cheetah-bin

dia
doxygen
doxygen-gui
fonts-dejavu
fonts-dejavu-core
fonts-dejavu-extra
fonts-firacode
fonts-liberation
fonts-liberation2
fonts-linuxlibertine
fonts-lmodern
fonts-noto
fonts-unifont
gparted
gpicview
gpsbabel
gwenview
i3lock
kde-config-gtk-style
kde-config-gtk-style-preview
keepassx
libreoffice
libreoffice-l10n-el
python3-i3ipc
qgis
tellico
texinfo
texlive
texlive-base
texlive-bibtex-extra
texlive-binaries
texlive-extra-utils
texlive-font-utils
texlive-fonts-extra
texlive-fonts-extra-doc
texlive-fonts-recommended
texlive-fonts-recommended-doc
texlive-generic-extra
texlive-generic-recommended
texlive-lang-english
texlive-lang-greek
texlive-latex-base
texlive-latex-base-doc
texlive-latex-extra
texlive-latex-extra-doc
texlive-latex-recommended
texlive-latex-recommended-doc
texlive-pictures
texlive-pictures-doc
texlive-pstricks
texlive-pstricks-doc
texlive-science
texlive-science-doc
texlive-xetex
texstudio
ttf-bitstream-vera
ttf-bitstream-vera       
ttf-dejavu
ttf-mscorefonts-installer
ttf-unifont              
upower
vlc
volumeicon-alsa
xdotool
xserver-xorg-input-synaptics
zathura-dev
zathura-djvu
zathura-pdf-poppler
zim

  ];
}
