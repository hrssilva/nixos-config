{self, nixpkgs}:
{
    description = "A collection of development environments to be used with 'nix develop'";
    outputs = { self, nixpkgs }@inputs : {
        templates = {
            haroldo = {
                path = ./python.nix ;
                description = "Python 3 development environment";
            };
        };
    };
}
