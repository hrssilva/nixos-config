{ home-manager, allArgs, ... }:

let
  allusers = allArgs.allusers;
  super = allArgs.super;
  hostname = allArgs.hostname;
in
[
  home-manager.nixosModules.home-manager {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";

    home-manager.users = builtins.mapAttrs (name: user: {
      imports = [
        ./${name}
        ./${name}/hosts/${hostname}
      ];

      # opcional: passar variáveis personalizadas
      home = {
        username = name;
        homeDirectory = "/home/${name}";
      };

    }) allusers;

    home-manager.extraSpecialArgs = {
      inherit super hostname;
    };
  }
]

