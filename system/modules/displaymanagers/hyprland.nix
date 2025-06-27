{ pkgs, ... } :
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # Install hyprland WM
  programs.hyprland.enable = true; # enable Hyprland

  # Add some wayland stuff
  xdg.portal = { enable = true; extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; }; 

  environment.systemPackages = with pkgs; [
    kitty
    wofi
    networkmanagerapplet
    swww
    libnotify
    socat
    jq
    blueman
    wl-clipboard
    clipman
    grim
    slurp
  ];
}
