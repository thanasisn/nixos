{ config, pkgs, ... }: {

  ##  grafana configuration
  services.grafana.enable                    = true;
  services.grafana.settings.server.domain    = "grafana.nixvm";
  services.grafana.settings.server.http_port = 2342;
  services.grafana.settings.server.http_addr = "127.0.0.1";


  ## nginx reverse proxy
  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
    locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
    };
  };


  ## prometueus motiroring service
  services.prometheus = {
    enable = true;
    port   = 9001;
  };

  ## add exporters
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [
          "smartctl"
          "systemd"
          # "textfile"
          # "conntrack"
          # "diskstats"
          # "entropy"
          # "filefd"
          # "filesystem"
          # "interrupts"
          # "ksmd"
          # "loadavg"
          # "logind"
          # "mdadm"
          # "meminfo"
          # "netdev"
          # "netstat"
          # "stat"
          # "time"
          # "vmstat"
      ];
        port = 9002;
      };
      smartctl = {
        enable = true;
      };
    };

   scrapeConfigs = [
     {
       job_name = "chrysalis";
       static_configs = [{
         targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
       }];
     }
   ];
  };

#  services.loki = {
#    enable = true;
#    configFile = ./loki.yaml;
#  };
#
#  systemd.services.promtail = {
#    description = "Promtail service for Loki";
#    wantedBy = [ "multi-user.target" ];
#
#    serviceConfig = {
#      ExecStart = ''
#        ${pkgs.grafana-loki}/bin/promtail --config.file ${./promtail.yaml}
#      '';
#    };
#  };


  ## test munin
  services.munin-node.enable = true;
  services.munin-cron.enable = true;
  services.munin-cron.hosts  =''
    [${config.networking.hostName}]
    address localhost
  '';



}

