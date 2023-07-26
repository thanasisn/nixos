{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./nixVM.nix                          # this host global variables
      ./hardware-configuration.nix         # results of the hardware scan
      ../config.d/hmod.nix                 # custom module for host globals
      ../config.d/common_options.nix       # common options for all
      "${builtins.fetchTarball "https://github.com/Mic92/sops-nix/archive/master.tar.gz"}/modules/sops" 
   ];

  # Bootloader.
  boot.loader.grub.enable      = true;
  boot.loader.grub.device      = "/dev/sda";
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.athan = {
    isNormalUser = true;
    description  = "athan";
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

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable    = true;
  services.xserver.displayManager.autoLogin.user      = "athan";
  ## there is option for default desktop sellection
  # services.xserver.displayManager.defaultSession      = "budgie";
  # services.xserver.windowManager.herbstluftwm.enable  = true;
  # services.xserver.windowManager.herbstluftwm.package = true;
  # services.xserver.desktopManager.budgie.enable       = true;
  # services.xserver.windowManager.i3.enable            = true;
  # services.xserver.windowManager.i3.package           = pkgs.i3-gaps;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

  ## change key binds
  services.xserver.xkbOptions = "caps:swapescape";
  console.useXkbConfig        = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # This will add secrets.yml to the nix store
  # You can avoid this by adding a string to the full path instead, i.e.
  # sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
  sops.defaultSopsFile   = "/etc/nixos/secrets/example.yaml";
  # This will automatically import SSH keys as age keys
  sops.age.sshKeyPaths   = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile       = "/root/.config/sops/age/keys.txt";
  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey   = true;
  sops.validateSopsFiles = false;


  environment = {
    # Eject nano and perl from the system
    defaultPackages = with pkgs; lib.mkForce [
      #? gitMinimal
      home-manager
      micro
      rsync
    ];
    systemPackages = with pkgs; [
      #? pciutils
      #? psmisc
      sops
      vim
      unzip
      usbutils
    ];
  };

}

