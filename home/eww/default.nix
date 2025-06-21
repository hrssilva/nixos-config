{ config, pkgs, super, ... }: let
    ewwPath = "${config.home.homeDirectory}/nixos-config/home/eww";
in {

    xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink ewwPath;

    home.packages = with pkgs; [ eww ];
}
