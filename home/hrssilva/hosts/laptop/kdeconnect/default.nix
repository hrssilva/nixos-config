{ config, pkgs, super, hostname, ... }: let 
    pkgName = "kdeconnect";
in {
    # home.packages = with pkgs; [ pkgName ];
    # kdeconnect is available as a service in home-manager
    services."${pkgName}".enable = true;
    
    # WARNING: This pkg requires networking configs that can only be done at system level, remeber to disable if unninstalling
}
