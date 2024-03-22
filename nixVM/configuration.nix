{ config, pkgs, lib, ... }:

{
  imports =
    [
      <home-manager/nixos>                 # home manafer for users
      ./nixVM.nix                          # this host global variables
      /etc/nixos/hardware-configuration.nix         # results of the hardware scan
      ../config.d/hmod.nix                 # custom module for host globals
      ../config.d/common_options.nix       # common options for all
      "${builtins.fetchTarball "https://github.com/Mic92/sops-nix/archive/master.tar.gz"}/modules/sops" 
    ];

  ## need to run for home-manager
  ## get home-manger into nixOS as root
  # # sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
  # # nix-channel --update
  ## Init home-manager as a user
  # $ nix run home-manager/release-23.11 -- init --switch
  # $ home-manager switch


  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = config.hmod.hostname; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Enable zsh for system
  programs.zsh.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LXQT Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.lxqt.enable    = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable    = true;
  services.xserver.displayManager.autoLogin.user      = "athan";
  
  ## there is option for default desktop sellection
  # services.xserver.displayManager.defaultSession      = "budgie";
  # services.xserver.windowManager.herbstluftwm.enable  = true;
  # services.xserver.windowManager.herbstluftwm.package = true;
  # services.xserver.desktopManager.budgie.enable       = true;
  services.xserver.windowManager.i3.enable            = true;
  services.xserver.windowManager.i3.package           = pkgs.i3-gaps;

  # Configure keymap in X11
  # services.xserver.xkb.layout  = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  # services.xserver.xkbOptions = "caps:swapescape";
  console.useXkbConfig         = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.athan = {
    isNormalUser = true;
    extraGroups  = [
                     "networkmanager"
                     "wheel"
                     "cdrom"
                     "flopy"
                     "sudo"
                     "audio"
                     "dip"
                     "video"
                     "plugdev"
                     "kvm"
                     "netdev"
                     "bluetooth"
                     "lpadmin"
                     "scanner"
                     "whireshark"
                     "libvirt"
                   ];
  #  shell        = pkgs.zsh;
    packages     = with pkgs; [
      thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  services.spice-vdagentd.enable = true; 

  environment.systemPackages = with pkgs; [
    vim
    wget
    rsync
    meld
    sops
    vim
    unzip
    usbutils
    firefox
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
 
  ## update system  
  system.autoUpgrade.enable        = false;
  nix.settings.auto-optimise-store = true;

  ## auto garbage collection
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 3d";
  };

  ## restrict logging size
  services.journald.extraConfig = ''
    SystemMaxUse=2G
  '';

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable                   = true;
    settings.PermitRootLogin = "no";
  };

  # Open ports in the firewall.
  networking.firewall.enable = true;
  ## UDP ports
  networking.firewall.allowedUDPPorts = [
    655  # tinc
  ];
  ## TCP ports
  networking.firewall.allowedTCPPorts = [
     22  # ssh
    655  # tinc
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This will add secrets.yml to the nix store
  # You can avoid this by adding a string to the full path instead, i.e.
  sops.defaultSopsFile   = "/home/athan/CODE/nixos/nixVM/secrets/example.yaml";
  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile       = "/root/.config/sops/age/keys.txt";
  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey   = false;
  sops.validateSopsFiles = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

