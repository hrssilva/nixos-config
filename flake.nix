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

    };



    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let 
        allusers = {
            hrssilva = {
                description = "Haroldo R. S. Silva";
                password = "$6$2n8MhM9f4s7Fgpts$KJQCwjzJJYq3e1v2VkI6UC1QgpEewkh9HXQ8A.a1NLXlX/d9tFCa43k5WzaWh6bHleIBlP3lYbdY0TndSZ6L./";
                isuserhashed = true;
                groups = [];
                };

            neo = {
                description = "Thomas A. Anderson";
                password = "spoon";
                isuserhashed = false;
                groups = [];
                };
        };

        filterUsers = available: all:
            builtins.filterAttrs (name: _: builtins.elem name available) all;
    in {
        # Please replace my-nixos with your hostname
        nixosConfigurations = {
            laptop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                specialArgs = { inherit inputs; super = self; hostname = "laptop"; allusers = (filterUsers ["hrssilva"] allusers);} ;
                modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                ./system/hosts/laptop.nix
                ./home
                ];
            };
        };
    };
}
