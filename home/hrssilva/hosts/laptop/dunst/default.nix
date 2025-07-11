# Example flake for installing a usual package from the nix store for the user.
# For most packages it should be enough to replace "example" with the name of the desired pkg.
# This example installs the pkg and creates a symlink to the pkg folder for managing the dotfiles.

{ config, pkgs, super, ... }: let 
    pkgName = "dunst";
    dotPath = "${config.home.homeDirectory}/nixos-config/home/${config.home.username}/${pkgName}";
    package = builtins.getAttr pkgName pkgs;
in {

    xdg.configFile."${pkgName}".source = config.lib.file.mkOutOfStoreSymlink dotPath;

    home.packages = with pkgs; [ package ];
}
