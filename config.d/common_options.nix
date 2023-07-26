{ config, pkgs, options, ... }:

{
  # Vim for all
  environment.variables.EDITOR         = "vim";
  environment.variables.VISUAL         = "vim";
  environment.variables.SYSTEMD_EDITOR = "vim";

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

  # Configure keymap in X11
  services.xserver = {
    layout     = "us,el";
    xkbVariant = "";
  };

  # NTP servises
  networking.timeServers = 
    options.networking.timeServers.default ++
      [
        "ntp.fastpath.gr"
        "time.cloudflare.com"
      ]; 
 
  ### TODO
  systemd.services.postfix.after = [ "sops-nix.service" ];
  sops.secrets.postfix_sasl_passwd = {
    owner = config.services.postfix.user;
    key   = "postfix_sasl_passwd";
  };  
  services.postfix = {
    enable    = true;
    submissionOptions.smtp_sasl_auth_enable = "yes";
    submissionOptions.smtp_sasl_password_maps = "hash:${config.sops.secrets.postfix_sasl_passwd.path}"; 
    relayHost = "smtp.gmail.com";
    relayPort = 587;
    extraConfig = ''
    smtp_use_tls = yes                                                        
    smtp_sasl_auth_enable = yes                                               
    smtp_sasl_security_options =                                              
    # smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd                   
    # smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt                      
    smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
    # myhostname = nixVM
    alias_maps = hash:/etc/aliases
    alias_database = hash:/etc/aliases
    ## ? myorigin = /etc/mailname
    mydestination = $myhostname, nixVM.net, nixVM, localhost.localdomain, localhost
    mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
    mailbox_size_limit = 0
    recipient_delimiter = +
    inet_interfaces = all
    inet_protocols = all
    '';
  };


  environment.etc = {
    "aliases" = {
      text = ''
        mailer-daemon: postmaster
        postmaster:    root
        nobody:        root
        hostmaster:    root
        usenet:        root
        news:          root
        webmaster:     root
        www:           root
        ftp:           root
        abuse:         root
        noc:           root
        security:      root
        root:          ath.nats.sys@gmail.com 
        athan:         ath.nats.sys@gmail.com
        ppss:          ath.nats.sys@gmail.com
        clamav:        root
        logcheck:      root
        monit:         root
      '';
      mode = "0644";
    };
  };


  sops.secrets.systemgmailusr = {};
  sops.secrets.systemgmailpsw = {};

  # programs.msmtp = {
  #   enable = true;
  #     defaults = {
  #       tls = true;
  #       port = 587;
  #     };
  #   accounts = {
  #     defaults = {
  #       auth = true;
  #       from = "$(cat /run/secrets/systemgmailusr)";
  #       host = "smtp.gmail.com";
  #       user = ''$(cat /run/secrets/systemgmailusr)'';
  #       password = "$(cat /run/secrets/systemgmailpsw)";
  #     };
  #   };
  # };




  services.cron = {
    enable = true;
      systemCronJobs = [
        "*/5 * * * * root date"
      ];
  };

}
