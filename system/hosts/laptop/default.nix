{ ... }@args :
{
  imports = 
    [ 
      ../hardware/laptop.nix
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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  
  boot.kernelParams = [
    "intel_pstate=disable"
  ];


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.



  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable power management for battery life on laptop
  
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };
  services = {
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
          energy_performance_preference = "power";
	  energy_perf_bias = "power";
	  platform_profile = "low-power";
	  scaling_max_freq = "1000000";
        };
        charger = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };
    system76-scheduler = {
      enable = true;
      useStockConfig = true;
    };
  };
  #powerManagement.enable = true;
  #powerManagement.powertop.enable = true;


  

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Install steam
  programs.steam.enable = true;
}
