{ config, pkgs, super, ... }: let
    cavaPath = "${super}/home/cava";
in {

    xdg.configFile."cava".source = config.lib.file.mkOutOfStoreSymlink cavaPath;

    home.packages = with pkgs; [ cava ];
}
