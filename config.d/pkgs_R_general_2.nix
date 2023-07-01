
## an environment for R that contains libraries

# to test
self: super:
{
  rWrapped = super.rWrapped.override
  {
    packages = with self.rPackages;
    [
      ggplot2
      yaml
      RColorBrewer
      rlist
    ];
  };
}
