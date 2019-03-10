# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ../common.nix
      ../with-x.nix
      ../is-laptop.nix
      ../hardware-configuration.nix

    ];

  boot.loader.grub.device = "/dev/sdb"; # or "nodev" for efi only
  networking.hostName = "neptune.rs.io"; # Define your hostname.
  networking.hostId = "6f1cf088";
  programs.dconf.enable = true;
  virtualisation.libvirtd.enable = true;
  hardware.opengl.driSupport32Bit = true; # for steam
  hardware.pulseaudio.support32Bit = true; # for steam 
}