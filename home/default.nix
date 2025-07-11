{ home-manager, allArgs, ... }:
let
    perUserSystemConfigs = builtins.filter builtins.pathExists (
        builtins.map (name: ./. + "/${name}/system-config") (builtins.attrNames allusers)
      );
    allusers = allArgs.allusers;
    super = allArgs.super;
in 
    
    perUserSystemConfigs ++ [

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          home-manager.users = builtins.mapAttrs (name: user: import ./${name}  ) allusers;

          home-manager.extraSpecialArgs = {
            inherit  super;
            hostname = allArgs.hostname;
          };
        }
    ]

