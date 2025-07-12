{ config, pkgs, super, hostname, ... }: let
    cavaPath = "${config.home.homeDirectory}/nixos-config/home/${config.home.username}/hosts/${hostname}/cava";
in {

    xdg.configFile."cava".source = config.lib.file.mkOutOfStoreSymlink cavaPath;

    home.packages = with pkgs; [ cava ];
}
