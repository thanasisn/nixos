
## extensive lists of cli tools

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lf
    git
    pandoc
    rclone
    lfs
  ];
}
