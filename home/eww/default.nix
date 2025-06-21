{ config, pkgs, super, ... }: let
    ewwPath = "${super}/home/eww";
in {

    xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink ewwPath;

    home.packages = with pkgs; [ eww ];
}
