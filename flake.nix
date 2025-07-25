{
    description = "A simple NixOS flake";

    inputs = {
        # NixOS official package source, using the nixos-25.05 branch here
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        # ghostty.url = "github:ghostty-org/ghostty/main";
        home-manager = {
          url = "github:nix-community/home-manager/release-25.05";
          # The `follows` keyword in inputs is used for inheritance.
          # Here, `inputs.nixpkgs` of home-manager is kept consistent with
          # the `inputs.nixpkgs` of the current flake,
          # to avoid problems caused by different versions of nixpkgs.
          inputs.nixpkgs.follows = "nixpkgs";
        };
        disko = {
            url = "github:nix-community/disko/";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };



    outputs = { self, nixpkgs, home-manager, disko, agenix, ... }@inputs: 
    let 
        allusers = {
            hrssilva = {
                description = "Haroldo R. S. Silva";
                password = "$6$2n8MhM9f4s7Fgpts$KJQCwjzJJYq3e1v2VkI6UC1QgpEewkh9HXQ8A.a1NLXlX/d9tFCa43k5WzaWh6bHleIBlP3lYbdY0TndSZ6L./";
                isuserhashed = true;
                groups = [];
                ssh-keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0sl0eS13w8hxRqrdhyEvbLXe3IlvbeTOkJd6wm6qY1" ];
                };

            neo = {
                description = "Thomas A. Anderson";
                password = "spoon";
                isuserhashed = false;
                groups = [];
                ssh-keys = [];
                };
        };

        filterUsers = available: all:
            nixpkgs.lib.filterAttrs (name: _: builtins.elem name available) all;

        laptopArgs = { inherit inputs; super = self; hostname = "laptop"; allusers = (filterUsers ["hrssilva"] allusers);} ;
        matrixArgs = { inherit inputs; super = self; hostname = "matrix"; allusers = (filterUsers ["hrssilva"] allusers);} ;
    in {
        # Please replace my-nixos with your hostname
        nixosConfigurations = {
            laptop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                specialArgs = laptopArgs ;
                modules = [
                agenix.nixosModules.default
                ./system/hosts/laptop
                ] ++ (import ./home {inherit home-manager; allArgs = laptopArgs; }) ;
                
            };

            matrix = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                specialArgs = matrixArgs ;
                modules = [
                disko.nixosModules.disko
                agenix.nixosModules.default
                ./system/hosts/matrix
                ] ++ (import ./home {inherit home-manager; allArgs = matrixArgs; }) ;
            };
        };
    };
}
