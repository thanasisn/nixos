{ lib, ... }:
with lib;
{
  ## Definition of global var for this host
  hmod = {
    hostname = "crane";
    cosmosip = "10.12.12.1";
  };
}
