{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages.nix
      ./desktop.nix
      ./virtualisation.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
   "button.lid_init_state=open"
   "pci=nomsi"
  ];
  

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.brightnessctl.enable = true;
  sound.enable = true;

  networking = {
    hostName = "flekystyley";
    nameservers = [ "8.8.8.8" ];  
    wireless.enable = false;
    useDHCP = true;
    firewall.allowedTCPPorts = [ 57621 ];
  };

  i18n = {
    inputMethod.enabled      = "ibus";
    inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc anthy ];
    consoleFont              = "Lat2-Terminus16";
    consoleKeyMap 	     = "us";
    defaultLocale            = "ja_JP.UTF-8";
  };

  time.timeZone = "Asia/Tokyo";

  programs = {
    tmux.enable = true;
    zsh.enable = true;
    light.enable = true;
  };

  users.users.flekystyley = {
    isNormalUser = true;
    uid 	 = 1000;
    shell 	 = pkgs.zsh;
    home 	 = "/home/flekystyley";
    createHome 	 = true;
    extraGroups  = [ "wheel" "networkmanager" "tty" "dialout" "plugdev" "video" ];
  }; 

  users.extraGroups.vboxusers.members = [ "flekystyley" ];

  system.stateVersion = "19.09";

}

