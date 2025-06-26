{
    description = "A collection of development environments to be used with 'nix develop'";
    inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    outputs = { self, pkgs }@inputs : {
        templates = {
            haroldo = {
                path = ./python.nix ;
                description = "Python 3 development environment";
            };
        };
    };
}
