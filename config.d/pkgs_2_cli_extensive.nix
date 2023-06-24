
## extensive lists of cli tools

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    arp
    aspell
    aspell-el
    aspell-en
    astyle
    autofs
    autojump
    bash
    bash-completion
    bat
    batcat
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
    git-gui
    gitg
    gitk
    glances
    gnuplot
    gnuplot-data
    gnuplot-qt
    gnuplot-tex
    hddtemp
    hdparm
    hexcurse
    htop
    iftop
    imagemagick
    lf
    lfs
    libimage-exiftool-perl
    librsvg2-bin
    lm-sensors
    lshw
    mc
    mediainfo
    molly-guard
    moreutils
    myspell-el-gr
    myspell-en-us
    nano
    ncal
    ncdu
    nmap
    ntp
    ntpdate
    pandoc
    pdftk
    pv
#     python3-astropy
#     python3-cryptography
#     python3-ephem
#     python3-pip
#     python3-zmq
    r-base
    rar
    rclone
    rename
    rmlint
    rofi
    rsync
    rxvt-unicode-256color
    shellcheck
    similarity-tester
    smartmontools
    source-highlight
    sxhkd
    timelimit
    tinc
    tldr
    tmux
    trash-cli
    tree
    unison
    unrar-free
    untex
    usbutils
    xdo
  ];
}
