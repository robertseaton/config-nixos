{ config, pkgs, ... }:

{
  imports =
    [ 
      ../common.nix
      # ../with-x.nix # uncomment to enable X server
      # ../is-laptop.nix # uncomment if system is laptop
      ../hardware-configuration.nix

    ];

    # boot.loader.grub.device = "/dev/sdX"; # Boot device, must be defined
    # networking.hostName = "my_cool_name"; # Define your hostname.
    # networking.hostId = "XXXXXXX"; # Necessary for ZFS, replace string with output of `head -c 8 /etc/machine-id`
}