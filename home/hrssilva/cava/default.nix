{ config, pkgs, super, ... }: let
    cavaPath = "${config.home.homeDirectory}/nixos-config/home/${config.home.username}/cava";
in {

    xdg.configFile."cava".source = config.lib.file.mkOutOfStoreSymlink cavaPath;

    home.packages = with pkgs; [ cava ];
}
