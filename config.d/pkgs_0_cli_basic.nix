
## Basic cli tools

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btrfs-progs
    coreutils
    curl
    ddrescue
    encfs
    fdupes
    git
    gnugrep
    gnupg
    gnused
    gocryptfs
    htop
    iftop
    ipset
    lm_sensors
    magic-wormhole
    mailutils
    mc
    mutt
    ncdu
    nmap
    openssh
    pkg-config
    rmlint
    rsync
    shellcheck
    smartmontools
    sshfs
    sudo
    testdisk
    tinc
    tmux 
    unison
    unzip
    vim
    vimPlugins.YouCompleteMe
    vimPlugins.syntastic
    vimPlugins.vim-addon-manager
    wget
    zfs
    zsh
    zsh-autosuggestions
  ];
}
