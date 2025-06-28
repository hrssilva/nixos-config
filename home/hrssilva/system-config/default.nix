{ config, lib, pkgs, ... }:

{
    imports = [
    ./kdeconnect.nix
    ];
    nix.extraOptions = ''
        trusted-users = root hrssilva
    '';
}
