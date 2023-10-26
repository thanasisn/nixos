{ lib, ... }:
with lib;
{
  options.hostmodule = {
    hostname = mkOption {
      type = types.str;
      description = "....";
    };
  };
}
