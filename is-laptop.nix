{ config, pkgs, ... }:

{

  services.xserver.libinput.enable = true; # touchpad support
  services.xserver.libinput.tapping = false;

}