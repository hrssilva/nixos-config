{ config, pkgs, super, ... }: let 
    pkgName = "kdeconnect";
    dotPath = "${config.home.homeDirectory}/nixos-config/home/${pkgName}";
in {

    xdg.configFile."${pkgName}".source = config.lib.file.mkOutOfStoreSymlink dotPath;

    # home.packages = with pkgs; [ pkgName ];
    # kdeconnect is available as a service in home-manager
    services."${pkgName}".enable = true;

    };
    modules = [
        ./networking.nix
    ];
}
