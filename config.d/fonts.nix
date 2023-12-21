
## fonts

{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
    fira-code
    fira-code-symbols
    liberation_ttf
    libertine
    lmodern
    mplus-outline-fonts.githubRelease
    noto-fonts
    noto-fonts-emoji
    proggyfonts
  ];
}
