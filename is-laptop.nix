{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  services.xserver.libinput.enable = true; # touchpad support
  services.xserver.libinput.tapping = false;

}
