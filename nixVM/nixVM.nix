{ lib, ... }:
with lib;
{
  ## Definition of global var for this host
  hmod = {
    hostname = "nixVM";
    cosmosip = "10.12.12.88";
  };
}
