

# to test

# Configuration file for Home-Manager
{ config, pkgs, ... }:

let
  # R Studio
  my-R-packages = pkgs.rstudioWrapper.override
  { packages = with pkgs.rPackages; [
    ggplot2
    tidyverse
    languageserver
    lintr
    styler
    devtools
    ];
  };
in

{
  # Home packages
  home.packages = with pkgs; [
    my-R-packages
  ];
  
}
