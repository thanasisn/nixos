{ lib, ... }:
with lib;
{
  ## Definition of global var for this host
  hmod = {
    hostname = "nixVM";
    cosmosip = "10.12.12.88";
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

  users.users."user".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2854GJSVL5nRxLG5ob8DIkv7sftd9s8WtyO2kmtzuh7+X1qgu7F/I7Eka58lfLxDlkn6DlEs2BxDuCZ5yT8J/zCKaPFhB4g0dJuOwHEMfXPpG0fci2T8Tz3zw6aOHc/H1qfcIRqupKDMwOnTQjnHa/9vLxY+KcmbkcPggL/b8jnV3/vBTpX6XPAS2kVC90R8S2IAHBK5tVwBg9pbit6ncEePbY/RkKEDzNki2oWqWW0rVB5uqROsThzKbLRYLy0WhKigRaSsCIG3bnd4k+mYfC8qlSFmfghaNpQSuucHYl9Vlj8ajc97rEUl8uBtbsq28zABdaNPjViKGawdnC+Xb2tSjufRZ7+7D7kdCmkdP9hSt4RbXko5+V0Zhw5gFcS9bCYD7paEN+0iffJLq4MAsEb7YqnJeWBmJVF8+zZPPKYJ4EOvJmfcdyUOn5rg9KhhG0eLUblngvZV4isq6FO/m2XBGfAisJ3ukio3rmf+FO/Lnf3nUZxzGWKkVEnSEHb1ehgEZOir2QdSHs2bZ3KzogiNh1uj7aT0vd7TAEpphebQxz62cMXWnS2fbxEHmb1ePhTPKK9nskMs2geHeW+SYvOD0Pxvynl3HZGLcK2zgW0rBO5VGcWj3a8JqlvQT6b67EmrnndDzof+ZBwaavoPyZ9xxzAQMam+AwAHKnj/R4Q== "
  ];
}
