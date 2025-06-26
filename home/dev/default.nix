{ config, pkgs, super, ... }: 

{
    templates = {
        python = {
            path = ./python.nix ;
            description = "Python 3 development environment";
        };

    };

}
