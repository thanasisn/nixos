## Global R packages 
{ config, lib, pkgs, ... }:

let myRPackages = with pkgs.rPackages;
  [
    xfun
    data_table
#    arrow
    arsenal
    compareDF
    doMC
    dplyr
    foreach
    funr
    Hmisc
    htmlwidgets
    knitr
    lubridate
    optparse
    pander
    plotly
    renv
    rmarkdown
    shiny
    tidyr
  ];
in {
  environment.systemPackages = with pkgs; [
    (rWrapper.override       { packages = myRPackages; } )
    (rstudioWrapper.override { packages = myRPackages; } )
  ];
}
