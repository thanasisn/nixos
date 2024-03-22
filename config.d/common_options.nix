{ config, pkgs, options, lib, ... }:

{
  # Vim for all
  environment.variables.EDITOR         = "vim";
  environment.variables.VISUAL         = "vim";
  environment.variables.SYSTEMD_EDITOR = "vim";

  # ignore laptop lid
  services.logind.lidSwitch       = "ignore";
  services.logind.lidSwitchDocked = "ignore";

  # hdd temp
  # hardware.sensor.hddtemp.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANG              = "en_US.UTF-8";
    LC_ADDRESS        = "el_GR.UTF-8";
    LC_COLLATE        = "en_US.UTF-8";
    LC_CTYPE          = "en_US.UTF-8";
    LC_IDENTIFICATION = "el_GR.UTF-8";
    LC_MEASUREMENT    = "el_GR.UTF-8";
    LC_MESSAGES       = "en_US.UTF-8";
    LC_MONETARY       = "el_GR.UTF-8";
    LC_NAME           = "el_GR.UTF-8";
    LC_NUMERIC        = "C.UTF-8";
    LC_PAPER          = "el_GR.UTF-8";
    LC_TELEPHONE      = "el_GR.UTF-8";
    LC_TIME           = "en_DK.UTF-8";
  };

  # make zsh available to the system
  programs.zsh.enable = true;
  # and set it for all users
  users.defaultUserShell = pkgs.zsh;

  # Configure keymap in X11
  services.xserver = {
    layout     = "us,gr";
    # layout     = "us,el";
    xkbOptions = "grp:alt_shift_toggle,caps:escape_shifted_capslock";
    # Make Caps Lock an additional Esc, but Shift + Caps Lock is the regular Caps Lock
    xkbVariant = "";
  };

  # Only install the docs I use
  documentation.enable       = true;
  documentation.nixos.enable = true;
  documentation.man.enable   = true;
  documentation.info.enable  = false;
  documentation.doc.enable   = false;

  # NTP servises
  networking.timeServers =
    options.networking.timeServers.default ++
      [
        "ntp.fastpath.gr"
        "time.cloudflare.com"
      ];


  systemd.services.postfix.after = [ "sops-nix.service" ];

  sops.secrets.postfix_sasl_passwd = {
  #  owner = config.services.postfix.user;
  #  key   = "postfix_sasl_passwd";
    mode  = "0400";
  };

  sops.secrets."systemgmailusr" = {};

  sops.secrets."aliases" = {
    mode = "0644";
  };

  environment.etc = {
    "aliases" = {
       source = "/run/secrets/aliases" ;
       mode   = "0644";
    };
  };

# my.cron.script = ''
#     cat ${config.sops.secrets."systemgmailusr".path}
# '';

  services.postfix = {
    enable    = true;
    relayHost = "smtp.gmail.com";
    relayPort = 587;

    # mapFiles.mycreds = config.sops.secrets.postfix_sasl_passwd.path;
    mapFiles.postfix_sasl_passwd = "/run/secrets/postfix_sasl_passwd";

    ## test
    # mapFiles.aliasFiles = "/run/secrets/etc/aliases";
    #  mapFiles.aliasesFiles = config.sops.secrets."etc/aliases".path;

    config = {
      myhostname                 = config.hmod.hostname;
      smtp_use_tls               = "yes";
      smtp_sasl_auth_enable      = "yes";
      smtp_sasl_security_options = "noanonymous";
      smtp_sasl_password_maps    = "hash:/etc/postfix/postfix_sasl_passwd";
      #NO alias_maps                 = lib.mkForce "/etc/aliases";
      # alias_maps                 = lib.mkForce "hash:/etc/aliases";
      # alias_database             = lib.mkForce "hash:/etc/aliases";
      alias_maps                 = lib.mkForce "";
      # alias_maps                 = lib.mkForce "/run/secrets/aliases";
      # alias_maps                 = lib.mkForce "hash:/run/secrets/aliases";
      # alias_database             = "/etc/aliases.db";
      aliasFiles                 = "/etc/aliases";
      # virtual                   = "@crane ath.nats.sys@gmail.com";
      virtual                    = "* ath.nats.sys@gmail.com";
      # smtp_tls_wrappermode       = "yes";
      # smtp_tls_security_level    = "encrypt";
    };

   #  extraConfig = ''
   #  # smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
   #  # smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
   #  # myhostname = nixVM
   #  # alias_maps     = hash:/etc/aliases
   #  # alias_database = hash:/etc/aliases
   #  ## ? myorigin = /etc/mailname
   #  mydestination = $myhostname, nixVM.net, nixVM, localhost.localdomain, localhost
   #  # mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
   #  # mailbox_size_limit = 0
   #  # recipient_delimiter = +
   #  # inet_interfaces = all
   #  # inet_protocols = all
   #  '';
  };



  ## test cron and email
  services.cron = {
    enable = true;
      systemCronJobs = [
        "*/10 * * * * date"
        "*/10 * * * * root date"
        "*/10 * * * * echo hello1 > /tmp/cronout1"
        "*/10 * * * * root hello2 > /tmp/cronout2"
      ];
  };


  systemd.timers."hello-world" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec       = "5m";
      OnUnitActiveSec = "5m";
      Unit = "hello-world.service";
    };
  };

  systemd.services."hello-world" = {
    script = ''
        set -eu
        ${pkgs.coreutils}/bin/echo "Hello World" 
      '';
      serviceConfig = {
         Type = "oneshot";
         User = "root";
      };
    };



  # systemd.services."status_email_user" = {
  #   script = ''
  #     #!/bin/sh
  #     /usr/bin/sendmail -t <<ERRMAIL
  #     To: $1
  #     From: systemd <root@$HOSTNAME>
  #     Subject: $2
  #     Content-Transfer-Encoding: 8bit
  #     Content-Type: text/plain;
  #     charset=UTF-8

  #     $(systemctl status --full "$2")
  #     ERRMAIL
  #     '';
  #     serviceConfig = {
  #        Type = "oneshot";
  #        User = "nobody";
  #        ExecStart = "systemd-email address %i";
  #        Group = "systemd-journal";
  #     };
  #   };




  ## smart
  services.smartd.enable                   = true;
  services.smartd.notifications.x11.enable = true;
  services.smartd.notifications.test       = true;


  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "electron-25.9.0"
  ];

}
