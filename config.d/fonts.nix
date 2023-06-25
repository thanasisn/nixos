
## fonts

{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    dejavu_fonts
    fira-code
    fira-code-symbols
    liberation_ttf
    libertine
    corefonts
    lmodern
    mplus-outline-fonts.githubRelease
    noto-fonts
    noto-fonts-emoji
    proggyfonts
  ];
}
