{ config, pkgs, super, ... }: let 
    pkgName = "kdeconnect";
    dotPath = "${config.home.homeDirectory}/nixos-config/home/${appName}";
in {

    xdg.configFile."${appName}".source = config.lib.file.mkOutOfStoreSymlink dotPath;

    home.packages = with pkgs; [ pkgName ];
}
