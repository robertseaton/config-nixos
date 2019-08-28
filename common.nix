{ config, pkgs, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.supportedFilesystems = [ "zfs" ];
  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
     mg fish git killall unison emacs mu tmux ispell
  ];
  networking.nameservers = ["8.8.8.8"];
  nixpkgs.config.allowUnfree = true; 
  programs.fish.enable = true;

  services.openssh.enable = true;
  services.locate.enable = true;
  services.cron.enable = true;
  services.zfs.autoSnapshot.enable = true;

  users.users.rps = {
     isNormalUser = true;
     home = "/home/rps";
     shell = pkgs.fish;
     extraGroups = [ "wheel" "networkmanager" "libvirtd"];
  };
  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "19.03"; # Did you read the comment?
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-19.03";
} 
