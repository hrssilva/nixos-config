{ config, pkgs, super, ... }: let 
    dotPath = "${config.home.homeDirectory}/nixos-config/home/hypr";
in {
    xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink dotPath;

    wayland.windowManager.hyprland.enable = true; # enable Hyprland
    home.packages = with pkgs; [ 
    hyprland-monitor-attached
 ];
}
