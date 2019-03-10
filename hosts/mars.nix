{ config, pkgs, ... }:

{
  imports =
    [ 
      ../common.nix
      ../with-x.nix # uncomment to enable X server
      ../is-laptop.nix # uncomment if system is laptop
      ../hardware-configuration.nix

    ];

    boot.loader.grub.device = "/dev/sda"; # Boot device, must be defined
    networking.hostName = "mars.rs.io"; # Define your hostname.
    networking.hostId = "be548cd5"; # Necessary for ZFS, replace string with output of `head -c 8 /etc/machine-id`
}
