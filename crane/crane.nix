{ lib, ... }:
with lib;
{
  ## Definition of global var for this host
  hmod = {
    hostname = "crane";
    cosmosip = "10.12.12.1";
  };

  imports = [
      ../config.d/tinc.nix                 # start a tinc vpn
      ../config.d/pkgs_0_cli_basic.nix     # basic cli tools
      ../config.d/pkgs_1_netsec.nix        # network security
      ../config.d/pkgs_2_cli_extensive.nix # extra cli functionality
      ../config.d/pkgs_3_gui_node.nix      # bagic gui tools
      # ./config.d/pkgs_4_gui_work.nix      # basic staff for work
      # ./config.d/pkgs_5_gui_desktop.nix   # my full desktop
      # ./config.d/pkgs_R_general.nix       # my R libraries
      # ./config.d/pkgs_python_general.nix  # my R libraries
      # ./config.d/pkgs_texlive.nix         # my R libraries
  ];

}
