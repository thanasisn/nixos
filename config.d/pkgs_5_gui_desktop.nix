
## My desktop 
## Include more specific programs

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    digikam
    evolution
    golden-cheetah-bin
  ];
}
