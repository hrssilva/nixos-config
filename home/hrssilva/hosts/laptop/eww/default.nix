{ config, pkgs, super, hostname, ... }: let
    ewwPath = "${config.home.homeDirectory}/nixos-config/home/${config.home.username}/hosts/${hostname}/eww";
in {

    xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink ewwPath;

    home.packages = with pkgs; [ eww ];
}
