#Why ? Because I can

{ config, pkgs, ... }:

{
  # Enable XRDP for Remote Desktop
  services.xrdp = {
    enable = true;
    defaultWindowManager = "startplasma-x11";
  };

  # Enable KDE Plasma and SDDM Display Manager
  services.xserver = {
    enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
  };
  # Open RDP port
}
