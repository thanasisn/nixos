
## extensive lists of cli tools

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    R
    # arp
    aspell
    aspellDicts.el
    aspellDicts.en
    astyle
    autofs5
    autojump
    emacs
    bash
    bash-completion
    bat
    nvd              # see version diffs in nixos
    bc
    biber
    borgbackup
    bzip2
    cmake
    detox
    encfs
    exif
    exiftool
    expect
    fdupes
    feh
    ffmpeg
    ffmpegthumbs
    file
    # findimagedupes
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
    highlight
    htop
    iftop
    imagemagick
    lf
    lfs
    lm_sensors
    lshw
    mc
    mediainfo
    molly-guard
    moreutils
    nano
    ncdu
    neovim
    nmap
    ntp
    pandoc
    pdftk
    pv
    # python3-astropy
    # python3-cryptography
    # python3-ephem
    # python3-pip
    # python3-zmq
    rar
    rclone
    rename
    rmlint
    rofi
    rsync
    rxvt-unicode
    shellcheck
    smartmontools
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
