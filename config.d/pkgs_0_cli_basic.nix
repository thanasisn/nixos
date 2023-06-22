
## Basic cli tools

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btrfs-progs
    ddrescue
    encfs
    fdupes
    git
    gocryptfs
    htop
    iftop
    lm_sensors
    mc
    ncdu
    nmap
    rmlint
    rsync
    shellcheck
    smartmontools
    sshfs
    testdisk
    tinc
    tmux 
    unison
    vim
    vimPlugins.YouCompleteMe
    vimPlugins.syntastic
    vimPlugins.vim-addon-manager
    zfs
    zsh
    zsh-autosuggestions
  ];
}
