
{ config, pkgs, ...}:

let

  nixVm_T_ip   = "10.12.12.88";
  # nixVm_T_name = "nixVM";
  nixVm_T_name = config.networking.hostName;
  # nixVm_T_name = "${hostname}";

  myMeshMask = "255.255.255.0";
  myMeshName = "cosmos";

in {
  sops.secrets."tinc_${myMeshName}/rsapriv" = {};
  sops.secrets."tinc_${myMeshName}/rsapub"  = {};
  sops.secrets."tinc_${myMeshName}/ip"      = {};
  sops.secrets."HUID"                       = {};

  # simple interface setup
  # ----------------------
  # option A
  # networking.interfaces."tinc.${myMeshName}" = [ { address = nixVm_T_ip; } ];
  # option B
  networking.interfaces."tinc.${myMeshName}".ipv4.addresses = [ { address = nixVm_T_ip; prefixLength = 24; } ];
  # option c
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
  # security.sudo.extraRules = [
  #   {
  #     users    = [ "tinc.${myMeshName}" ];
  #     commands = [
  #       {
  #         command  = "${pkgs.nettools}/bin/ifconfig";
  #         options  = [ "NOPASSWD" ];
  #       }
  #     ];
  #   }
  # ];


  # configure tinc service
  # ----------------------
  services.tinc.networks."${myMeshName}"= {

    name          = "${nixVm_T_name}"; 
    debugLevel    = 3;                 # the debug level for journal -u tinc.private
    chroot        = false;             # otherwise addresses can't be a DNS
    interfaceType = "tap";             # tun might also work.

    #ed25519PrivateKeyFile = config.sops.secrets.tinc-ed25519.path;
    rsaPrivateKeyFile = config.sops.secrets."tinc_${myMeshName}/rsapriv".path;
                                                      
    extraConfig   = ''                                
      # connect to peter                              
      # ----------------                              
      # check AutoConnect as alternative option.
      ConnectTo  = sagan

    '';
    hosts = {

#        cat ${sops.secrets."tinc_cosmos/nixVM/rsakey".path}
      nixVM = ''

        Subnet = 10.12.12.88
         
        -----BEGIN RSA PUBLIC KEY-----
        MIICCgKCAgEA3JlzQd8FnWuuHR8Y8WD1vcrggZv2b4b104vjbI4W2P3o3AjKQ0LC
        /eTVl56wh5AJNKAGjPkmfv9g3kNyfbmqrbPNOzdXEQ3b3JJCDSfDs0JD71tKEeHf
        pl62g7VgpYIHGZFoOobimy+q8WQZeet2NdE4R2ijVUTYaNEa16SfP6cm6D4O0NPG
        F2Rvcl1bGLRYrI3PUm9n30Ph1nplYCfZFltzydHAHIntgvdHNkXw5tZImbTe+pbp
        DWhiz0Z5oGZYuerG2Wyoac3bv5SZz0x79IIX74bMJ4ntFi7hpMJeGJgPv76zPjQ7
        6OprV4uM6byNQ81NN7dAPTIOlfwaDTfzfPYYYx0iNY5SSLImBzg3Fu0W8lWSNvRk
        iN1YPEREFNtyaeFZpgW9M6xqgefW4zoIPkpILOxtLMQIvduoeUV7Q+qOf4XbpzoB
        2S6DDfnwjP5QY6kROHxsjXCKT3ckocjFLSWkM4JO14DJZSwK/7r2ArqQF4FEam8N
        UoyUJs7iZh7Ak7PtMMOzDYDMCmP9klvHHH6+WdutAthW3qSPYuRhZWiZdD7TjA3K
        ATmpvS1x0p3F/V97F5puxUw5hWCvkyMoOvtGKyUogW4005/XO63oqXst9wi7GU00
        AXdOKSugFkuwI0vPLVyifPlm9SQmDxFFE2rEnG7IhC3poSRPJgu18WkCAwEAAQ==
        -----END RSA PUBLIC KEY-----
        '';

      sagan = ''
        ## sagan ##
        
        Address = 155.207.9.214
        Subnet  = 10.12.12.5
        
        -----BEGIN RSA PUBLIC KEY-----
        MIIECgKCBAEAv1x7dkfP6CAdaUlhD3yzNCx//mJz5ADoomn5IHPmR2DePtwCYUuG
        Exo7ekeDcViB0IGAJ8G9VJglQv2adz+VyAukYrmdqpFlXgIGw+uws/8xB0lO5jt+
        iS8oTz79UL5geUKxNj25FuLRf/luloBpQmBDJ6rVOwBa+Y6uDKYDObJFxBs9WFaF
        Kfdk9cAXj9iFCQ1awhMWOeYbJnoL9kQxZVJrwGCMfEO/L/mgoEMUok8S6XwV8JFC
        7/8H/2edieNo0WhPWvW60xG0TkX2Kx4hDWaSF2BcCSpY1n3zcunPDY62sxI2m8U5
        lV7tn2UDoz6eOhIs0Lkrd88ZMw2LA6G70b8Is2uNRy8jUjY02vuarP0g75rrEGSH
        ZSBEJtSrPTgX//fb09pTEjGIrbzjSqau9/GFC22wrvg5VPMGLPkUOd/9/Q6pfROI
        u/jCr/MxjNSQkjfgSjoiJK+C8UzhNfZLMrdH1VuNRuDZOukhJ0EksUTpy5x7WddG
        S4Dpl3KbfwoDYICPQnzlzb9gp8KwM2w5OnlimiREyiDT9F/WPiEhA/99qEwuFqC1
        KJiI3A4TstMnv9tzmxw8jbN14WElRB2Rb6WQu7j+BVpfuqlBDpfvFnjLsB/LEcXA
        ErGTWC95JUENT43GgZS2rvZqTrGNrcaIhyQqfrTzYU4ST+sSRJKBNri5Cam7mrWr
        q89xxcvZHoTInt6WhMZa2SoGEbM1Wpw/tANdrl2BU5iVeM0FJmY/zbTzd5bbXCXr
        wjkX7l/pbpZM0VjGLA2r/eeMokc1gysyfuyF6jpra/e18gpwhhgIZ82eCWB+2Pe3
        mkwLmp2O6aN/usmSsP55Mp6TTbgZfsRt6L60i+LLZ1E7bxsbrBwXJnF1kOaf7KhW
        lowW6zCVhHqV0FVHHJ0BFhM2lg3/tXpLZy1iJ8p2v8LsrpRt8J8O1C2bTRKYe+YE
        NuaZD32SyARIZRTSDZ/IT1Re18MJ8hIlv+pVwKZ6gS9AOdoSW3YZ3Aq9hYtJk14A
        TAUcFJrk84FfudKQdud9zdLPcokLjyG/sUQuU3+TjX+LMfFc8JitIewXV0Frx6U+
        Ovl5BMjCQ9JX0EFkPT8d/njwCm059FjuDVgVWsWDZQuai+rB38sutg5xMt5Z1CP3
        ksy7edwOqm9G9sFH2o39AYkJJs/RHJN4SIu+7U4UJrptDR3o9KBorijbrAZU8JiE
        DtC1sWuD/QZEaKrBO/Sm79rqak36MQc7h9MgJ61XqI89HH3RueYk2blaWOThRS3z
        xJ/W8bNgeR4JXMFysI4SJzuYV0WwruHUgiwlLtvNhvmtmyfa454el9snrHslWgil
        DY/QKyIBPewFFOcPdB0YX4Dddeq821zS4QIDAQAB
        -----END RSA PUBLIC KEY-----
      '';

      crane = ''
        ## crane ##

        Subnet = 10.12.12.1

        -----BEGIN RSA PUBLIC KEY-----
        MIIBCgKCAQEAtr0lAPjWVTJ2WQSvo/owSdyfkvi3Dz70DK6g12y1YLwhg97jOm0X
        KfaP4PglWKu83eaFBCqoBpxYk3BQS0IUUyASlN+tOgkOmP++R5eO7tziRhsyrJho
        v3ch4/vEsEkCSPi8+Y8T8HWVTKw+BC76fFY4B6l04YEXfEaezlt3gUZWeI4ld7D3
        nzl4Dbb+OsBjOFmNEE/c1/VaTJFtdOTb/s6kNfejsrkwjHuHuEwGFH6G8MpjBlFa
        DH2ii9XMrp9UHmgD+IGnNiFaa28+GBuIyS1ZquiXmmU+rYVs7UyoPfUy+L9UoTs0
        hkE4hGlFrI4R1pyJVFi2d5Ao3pbYQN/O5wIDAQAB
        -----END RSA PUBLIC KEY-----
        '';
    };
  };

}

