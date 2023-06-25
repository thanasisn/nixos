
## extensive lists of cli tools

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # arp
    aspell
    aspellDicts.el
    aspellDicts.en
    astyle
    autofs5
    autojump
    bash
    bash-completion
    bat
    bc
    biber
    borgbackup
    bzip2
    cmake
    detox
    encfs
    exif
    expect
    fdupes
    feh
    ffmpeg
    ffmpegthumbs
    file
    findimagedupes
    flac
    fstrcmp
    fzf
    git
    glances
    gnuplot
    gnuplot_qt
    hddtemp
    hdparm
    hexcurse
    htop
    iftop
    imagemagick
    lf
    lfs
    exiftool
    lm_sensors
    lshw
    mc
    mediainfo
    molly-guard
    moreutils
    nano
    ncdu
    nmap
    ntp
    pandoc
    pdftk
    pv
#     python3-astropy
#     python3-cryptography
#     python3-ephem
#     python3-pip
#     python3-zmq
    R
    rar
    rclone
    rename
    rmlint
    rofi
    rsync
    rxvt-unicode
    shellcheck
    smartmontools
    highlight
    sxhkd
    timelimit
    tinc
    tldr
    tmux
    trash-cli
    tree
    unison
    unrar
    untex
    usbutils
    xdo
  ];
}
