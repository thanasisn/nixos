
## Basic cli tools

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btrfs-progs
    curl
    ddrescue
    encfs
    fdupes
    git
    gnupg
    gocryptfs
    grep
    htop
    iftop
    ipset
    lm_sensors
    mc
    ncdu
    nmap
    openssh-client
    rmlint
    rsync
    sed
    shellcheck
    smartmontools
    ssh
    sshfs
    sudo
    tee
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
