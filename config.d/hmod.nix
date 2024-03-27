{ lib, ... }:
with lib;
{
  ##  Create some variables to used by each host
  options.hmod = {
    hostname = mkOption {
      type = types.str;
      description = "Host name";
    };
    tincnet1 = mkOption {
      type = types.str;
      default = "cosmos";
      description = "Name of the 1 rst tinc network";
    };
    cosmosip = mkOption {
      type = types.str;
      description = "Hosts IP for cosmos tinc network";
    };
  };
}
