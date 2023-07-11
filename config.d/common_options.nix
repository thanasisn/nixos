{ config, pkgs, options, ... }:

{
  # Vim for all
  environment.variables.EDITOR = "vim";

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
 
  # ### TODO
  # services.postfix = {
  #   enable    = true;
  #   submissionOptions.smtp_sasl_auth_enable = "yes";
  #   relayHost = "smtp.gmail.com";
  #   relayPort = 587;
  # };

  sops.secrets.systemgmailusr = {};
  sops.secrets.systemgmailpsw = {};

  programs.msmtp = {
    enable = true;
      defaults = {
        tls = true;
        port = 587;
      };
    accounts = {
      defaults = {
        auth = true;
        from = "$(cat /run/secrets/systemgmailusr)";
        host = "smtp.gmail.com";
        user = ''$(cat /run/secrets/systemgmailusr)'';
        password = "$(cat /run/secrets/systemgmailpsw)";
      };
    };
  };




  services.cron = {
    enable = true;
      systemCronJobs = [
        "*/5 * * * * root date"
      ];
  };

}
