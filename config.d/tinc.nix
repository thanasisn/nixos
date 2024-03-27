## Configure tinc network
{ config, pkgs, ...}:

{
  ## prepare secrets
  sops.secrets."tinc_${config.hmod.tincnet1}/rsapriv" = {};
  sops.secrets."tinc_${config.hmod.tincnet1}/rsapub"  = {};

  ## create hosts files
  sops.secrets."tinc_${config.hmod.tincnet1}/hosts/yperos" = {
    owner = "tinc.${config.hmod.tincnet1}";
    path  = "/etc/tinc/${config.hmod.tincnet1}/hosts/yperos";
  };

  sops.secrets."tinc_${config.hmod.tincnet1}/hosts/tyler" = {
    owner = "tinc.${config.hmod.tincnet1}";
    path  = "/etc/tinc/${config.hmod.tincnet1}/hosts/tyler";
  };

  sops.secrets."tinc_${config.hmod.tincnet1}/hosts/sagan" = {
    owner = "tinc.${config.hmod.tincnet1}";
    path  = "/etc/tinc/${config.hmod.tincnet1}/hosts/sagan";
  };

  sops.secrets."tinc_${config.hmod.tincnet1}/hosts/blue" = {
    owner = "tinc.${config.hmod.tincnet1}";
    path  = "/etc/tinc/${config.hmod.tincnet1}/hosts/blue";
  };

  sops.secrets."tinc_${config.hmod.tincnet1}/hosts/door" = {
    owner = "tinc.${config.hmod.tincnet1}";
    path  = "/etc/tinc/${config.hmod.tincnet1}/hosts/door";
  };

  sops.secrets."tinc_${config.hmod.tincnet1}/hosts/crane" = {
    owner = "tinc.${config.hmod.tincnet1}";
    path  = "/etc/tinc/${config.hmod.tincnet1}/hosts/crane";
  };

  sops.secrets."tinc_${config.hmod.tincnet1}/hosts/nixVM" = {
    owner = "tinc.${config.hmod.tincnet1}";
    path  = "/etc/tinc/${config.hmod.tincnet1}/hosts/nixVM";
  };

  ## simple interface setup for this host
  networking.interfaces."tinc.${config.hmod.tincnet1}".ipv4.addresses =
    [ { address = config.hmod.cosmosip; prefixLength = 24; } ];
  # other option for interface setup
  # environment.etc = {
  #     "tinc/${myMeshName}/tinc-up".source = pkgs.writeScript "tinc-up-${myMeshName}" ''
  #         #!${pkgs.stdenv.shell}
  #         ${pkgs.nettools}/bin/ifconfig $INTERFACE ${nixVm_T_ip} netmask 255.255.255.0
  #     '';
  #     "tinc/${myMeshName}/tinc-down".source = pkgs.writeScript "tinc-down-${myMeshName}" ''
  #         #!${pkgs.stdenv.shell}
  #         /run/wrappers/bin/sudo ${pkgs.nettools}/bin/ifconfig $INTERFACE down
  #     '';
  # };

  ## configure tinc
  services.tinc.networks."${config.hmod.tincnet1}"= {
    name          = config.hmod.hostname; # get nane from host module
    debugLevel    = 3;                    # the debug level for journal -u tinc.private
    chroot        = false;                # otherwise addresses can't be a DNS
    interfaceType = "tap";                # tun might also work.

    ## get this host private key
    rsaPrivateKeyFile = config.sops.secrets."tinc_${config.hmod.tincnet1}/rsapriv".path;

    extraConfig   = ''
      AutoConnect    = yes
      LocalDiscovery = yes

      ConnectTo      = sagan
      ConnectTo      = yperos
      ConnectTo      = blue
      ConnectTo      = crane
      ConnectTo      = kostas
      ConnectTo      = nixVM
      ConnectTo      = tyler

      GraphDumpFile  = /dev/shm/tinc.dot
    '';
    hosts = {

#       nixVM = ''
#         Subnet = 10.12.12.88
#         -----BEGIN RSA PUBLIC KEY-----
#         MIICCgKCAgEA3JlzQd8FnWuuHR8Y8WD1vcrggZv2b4b104vjbI4W2P3o3AjKQ0LC
#         AXdOKSugFkuwI0vPLVyifPlm9SQmDxFFE2rEnG7IhC3poSRPJgu18WkCAwEAAQ==
#         -----END RSA PUBLIC KEY-----
#         '';

#       sagan = ''
#         ## sagan ##
#         Address = 155.207.9.214
#         Subnet  = 10.12.12.5
#         -----BEGIN RSA PUBLIC KEY-----
#         MIIECgKCBAEAv1x7dkfP6CAdaUlhD3yzNCx//mJz5ADoomn5IHPmR2DePtwCYUuG
#         DY/QKyIBPewFFOcPdB0YX4Dddeq821zS4QIDAQAB
#         -----END RSA PUBLIC KEY-----
#       '';

#       crane = ''
#         ## crane ##
#         Subnet = 10.12.12.1
#         -----BEGIN RSA PUBLIC KEY-----
#         MIIBCgKCAQEAtr0lAPjWVTJ2WQSvo/owSdyfkvi3Dz70DK6g12y1YLwhg97jOm0X
#         hkE4hGlFrI4R1pyJVFi2d5Ao3pbYQN/O5wIDAQAB
#         -----END RSA PUBLIC KEY-----
#         '';

    };
  };
}
