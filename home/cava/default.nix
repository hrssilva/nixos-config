{ config, pkgs, super, ... }: let
    cavaPath = "${config.home.homeDirectory}/nixos-config/home/cava";
in {

    xdg.configFile."cava".source = config.lib.file.mkOutOfStoreSymlink cavaPath;

    home.packages = with pkgs; [ cava ];
}
