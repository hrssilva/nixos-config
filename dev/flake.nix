{ config, pkgs, ... }: 
{
    description = "A collection of development environments to be used with 'nix develop'";
    outputs = { self, pkgs } : {
        templates = {
            python = {
                path = ./python.nix ;
                description = "Python 3 development environment";
            };
        };
    };
}
