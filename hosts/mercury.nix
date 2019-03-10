{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	./mercury.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.supportedFilesystems = [ "zfs" ];

  # Not strictly required, but useful to be able to use the serial console
  boot.kernelParams = [ "console=ttyS1" ];

  networking.hostName = "mercury.rs.io"; # Define your hostname.
  networking.interfaces.eth0 = { ipAddress = "163.172.60.65"; prefixLength = 24; };
  networking.defaultGateway  = "163.172.60.1";
  networking.nameservers     = [ "62.210.16.6" "62.210.16.7" ];
  networking.hostId          = "ab1a9b76"; # necessary for zfs 
 
  # By default, systemd "predictable interface names" are used for network interfaces.
  # Since the Dedibox SC only has one network interface, it is safe to disable this,
  # and simply use eth0 as above. 
  # If you remove this line, you need to replace "eth0" above by the correct interface name.
  networking.usePredictableInterfaceNames = false;



  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
     mg fish
  ];

  nixpkgs.config.allowUnfree = true; 
  programs.fish.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  
  services.xserver.enable = false;
  services.locate.enable = true;

  users.extraUsers.rps = 
    { createHome      = true;
      isNormalUser    = true;
      home            = "/home/rps";
      extraGroups     = [ "wheel" ];
      shell	      = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC50Egzpy4UCwQvGzRaulv7uMVLu5LP4OPLSEhlG3LUU7RYivfLymRlitF3+gyh7YfLv3NqAtGQTMhQM808NySmEyEYkOoo24Gpi0h71CKnV/cd5YC48/VTe88kOE3t+T5eMV7RlqWCEP7Y311sbKVOlJ/oPpaY7+GvKnfGkOutKWNXwX04xktsN19tdWvbqouTsHboPpxi4MNUS04eVgXpByOOfU4VTFxygJU7TsZWVNSe0R8Qaee4oGs3QvyPutu7sYDD9BWZwVB0pVANk0Un7zIZ08wXEubjav5GgO/50M3oS9JyjkkNmjMSrJhBtj30o2c1HIhOLKKpAKj6ILZbmUzyR6YXlhz43TQUvmROvHyFzX0dabLaY1xvq7UgabnHW90naqwE+8txsl2hFwb9mIKLryNhLMDXAbkcc7N+4D1oORP1cyPc355XeU+x5XTlLX4AYLOCdVN9iDbztYbyR432B920ChB19hem20mjuMO/5GZ2B1DvVfxHCjoi5yT7Kv7Zbsar6I01INwa5uo4cro+hUcWAYgjNXgqPPLxwhkna/1IxvSBdd/Ar98q9k1uXcgzwcmcG6nLAs7VfIAVZ5DN2zV34Y2ZekIGXz/0T/FuPHQw0KdQttGSfQ6c7ywR91EbthYV9974MKynZ5P+SpjnNxejEWZAcKLTMqN7Uw== robbpseaton@gmail.com"
      ];
    };

  security.sudo.wheelNeedsPassword = false;  

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
