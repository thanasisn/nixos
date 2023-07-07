## Global R packages 
{ config, lib, pkgs, ... }:

let myPythonPackages = ps: with ps;
  [
    pandas
  ];
in {
  environment.systemPackages = [
    (pkgs.python3.withPackages myPythonPackages)
  ];
}
# in 
#   environment.systemPackages = [
#     (pkgs.python3.withPackages myPythonPackages)
#   ];
#
# environment.systemPackages = with pkgs; [
#    (python38.withPackages(ps: with ps; [ pandas requests]))
#   ];
# }
