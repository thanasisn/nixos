
## an environment for R that contains libraries

## This works
{ config, pkgs, ... }: 

{
    nixpkgs.config.packageOverrides = super: let self = super.pkgs; in
    {
        rEnv = super.rWrapper.override 
        {
            packages = 
                with self.rPackages; 
                [ 
                    devtools
                    distr
                    ggplot2
                    lubridate
                ];
        };
    };

    environment = 
	{
		systemPackages = 
			with pkgs;
			[
                rEnv
            ];
    };
}
