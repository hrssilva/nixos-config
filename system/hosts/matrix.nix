{ ... }@args :
{
  imports = 
    [ 
      ../modules/base.nix
      ../modules/network.nix
      ../modules/users.nix
      ../modules/fonts.nix
      ../modules/sound.nix
      ../modules/locales/abnt2.nix
      ../modules/displaymanagers/plasma.nix
      ../modules/displaymanagers/hyprland.nix
    ];


  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.systemd-boot.configurationLimit = 10;

  


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.



  # Enable bluetooth
  #hardware.bluetooth.enable = true; # enables support for Bluetooth
  #hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable power management for battery life on laptop
  
}
