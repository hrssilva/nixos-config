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
      #../modules/displaymanagers/plasma.nix
      #../modules/displaymanagers/hyprland.nix
    ];

  boot.initrd.mdadm.enable = true;

  environment.systemPackages = with pkgs; [
    mdadm  # RAID
    smartmontools  # Disk monitoring
  ];
}
