{
    description = "A collection of development environments to be used with 'nix develop'";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    outputs = { self, nixpkgs, ... }@inputs : {
        templates = {
            python = {
                path = ./python ;
                description = "Python 3 development environment";
            };
            python-pip = {
                path = ./python-pip ;
                description = "Python 3 development environment for use with venv and pip";
            };
        };
    };
}
