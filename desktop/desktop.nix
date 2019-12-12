{ config, pkgs, ... }:

{
  services.xserver = {
    enable          = true;
    layout     	    = "us";
    xkbOptions      = "ctrl:nocaps";
    libinput = {
      enable = true;
      tapping = false;
    };
    
    displayManager.lightdm.enable = true;
    desktopManager.xterm.enable = false;

    windowManager.i3 = {
      enable  = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
	i3status
	i3lock
	i3blocks
      ];
    };
  };
  
  services.compton = {
    enable 	    = true;
    fade            = true;
    activeOpacity   = "0.9";
    inactiveOpacity = "0.8";
    shadow          = true;
    fadeDelta       = 4; 
  };

  services.sshd.enable = true;
  
  fonts = {
    enableDefaultFonts     = true;
    enableFontDir          = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      hack-font
      nerdfonts
      ubuntu_font_family
    ];
  };
}
