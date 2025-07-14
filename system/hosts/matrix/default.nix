{ pkgs, ... }@args :
{
  imports = 
    [ 
      ../../hardware/matrix.nix
      ../../hardware/disks/matrix.nix
      ../../modules/base.nix
      ../../modules/network.nix
      ../../modules/users.nix
      ../../modules/fonts.nix
      ../../modules/sound.nix
      ../../modules/ssh.nix
      ../../modules/locales/abnt2.nix
      ../../modules/tailscale.nix
      ../../modules/cloudflare.nix
      ./netdata.nix
      ./postgres.nix
      #./headscale.nix #gave up on headscale until I actually try to setup DDNS
      ./exitnode-vpn.nix
    ];

  boot.swraid.enable = true;
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;


  environment.systemPackages = with pkgs; [
    mdadm  # RAID
    smartmontools  # Disk monitoring
  ];
}
