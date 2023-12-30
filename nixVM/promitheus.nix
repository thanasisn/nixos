{ config, pkgs, ... }: {

 # grafana configuration
 services.grafana = {
   enable = true;
   domain = "grafana.nixvm";
   port = 2342;
   addr = "127.0.0.1";
 };


 # nginx reverse proxy
 services.nginx.virtualHosts.${config.services.grafana.domain} = {
   locations."/" = {
       proxyPass = "http://127.0.0.1:${toString config.services.grafana.port}";
       proxyWebsockets = true;
   };
 };


 ## prometueus motiroring service
 services.prometheus = {
   enable = true;
   port = 9001;
 };

 ## add exporters
 services.prometheus = {
   exporters = {
     node = {
       enable = true;
       enabledCollectors = [ "systemd" ];
       port = 9002;
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
   

}

