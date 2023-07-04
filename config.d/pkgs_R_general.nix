## Global R packages 
{ config, lib, pkgs, ... }:

let myRPackages = with pkgs.rPackages;
  [
    Hmisc
    RNetCDF
    arrow
    arsenal
    caTools                                                                    
    compareDF
    data_table
    doMC
    dplyr
    filelock
    foreach
    funr
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
    xfun
  ];
in {
  environment.systemPackages = with pkgs; [
    (rWrapper.override       { packages = myRPackages; } )
    (rstudioWrapper.override { packages = myRPackages; } )
  ];
}
