{ config, pkgs, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.supportedFilesystems = [ "zfs" ];
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
     mg fish git 
  ];

  nixpkgs.config.allowUnfree = true; 
  programs.fish.enable = true;

  services.openssh.enable = true;
  services.locate.enable = true;
  users.users.rps = {
     isNormalUser = true;
     home = "/home/rps";
     shell = pkgs.fish;
     extraGroups = [ "wheel" "networkmanager" "libvirtd"];
  };
  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "18.09"; # Did you read the comment?
} 