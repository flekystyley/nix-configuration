{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages.nix
      ./desktop.nix
      ./docker.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
   "button.lid_init_state=open"
   "pci=nomsi"
  ];

  hardware.pulseaudio.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  sound.enable = true;

  networking = {
    hostName = "flekystyley";
    nameservers = [ "8.8.8.8" ];  
    wireless.enable = true;
    useDHCP = false;
    interfaces.wlp1s0.useDHCP = true;
  };

  i18n = {
    inputMethod.enabled      = "ibus";
    inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc anthy ];
    consoleFont              = "Lat2-Terminus16";
    consoleKeyMap 	     = "us";
    defaultLocale            = "en_US.UTF-8";
  };

  time.timeZone = "Asia/Tokyo";

  services.openssh.enable = true;

  programs = {                                                                                                                                                                                   
    tmux.enable = true;
    zsh.enable = true;
  };

  users.users.flekystyley = {
    isNormalUser = true;
    uid 	 = 1000;
    shell 	 = pkgs.zsh;
    home 	 = "/home/flekystyley";
    createHome 	 = true;
    extraGroups  = [ "wheel" "networkmanager" "tty" "dialout" "plugdev" ];
  }; 

  system.stateVersion = "19.09";
}

