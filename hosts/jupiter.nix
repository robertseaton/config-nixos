# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ../common.nix
      ../with-x.nix
      ../hardware-configuration.nix

    ];

  boot.loader.grub.device = "/dev/sda"; 
  boot.supportedFilesystems = [ "zfs" ];
  boot.kernel.sysctl = { "net.ipv4.ip_forward" = 1; };

  networking.hostName = "jupiter"; # Define your hostname.
  networking.hostId = "5f69a2bd";

  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  # GPU passthrough stuff. 
  virtualisation.libvirtd.enable = true;
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];
  boot.kernelModules = [
    "vfio"
    "vfio_pci"
    "vfio_iommu_type1"
    "kvm-intel"
  ];

  boot.extraModprobeConfig ="options vfio-pci ids=10de:1380,10de:0fbc";

  boot.kernelParams = [
    "intel_iommu=on"
  ];

  virtualisation.libvirtd.qemuVerbatimConfig = ''
    nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
  '';

  # samba server
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = jupiter
      netbios name = jupiter
      #use sendfile = yes
      #max protocol = smb2
      hosts allow = 192.168.122.0/24 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = {
        path = "/home/rps/torrents";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "rps";
        "force group" = "users";
      };
   };
};
}
