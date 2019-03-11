{ config, pkgs, ... }:

{
  networking.firewall.enable = false;
  services.openssh.forwardX11 = true;

  sound.enable = true;
  hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull; 
  };

  hardware.bluetooth.extraConfig = "
  [General]
  Enable=Source,Sink,Media,Socket
  ";
  hardware.bluetooth.enable = true;

  services.xserver = {
    enable = true;
    libinput.enable = true; # touchpad support
    libinput.tapping = false;
    layout = "us";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
	haskellPackages.xmobar
      ];
    };
    windowManager.default = "xmonad";
    desktopManager.xterm.enable = false;
    displayManager.sessionCommands = with pkgs; lib.mkAfter
      ''
      xmodmap /etc/xmodmap
      '';
  };

  environment.systemPackages = with pkgs; [
    xfce.terminal emacs firefox mpv pavucontrol signal-desktop evince gnome3.nautilus calibre dmenu 
  ];
}
