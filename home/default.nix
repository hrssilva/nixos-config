{ home-manager, allusers, super, ... }:
let
    perUserSystemConfigs = builtins.filter builtins.pathExists (
        builtins.map (name: ./. + "/${name}/system-config") (builtins.attrNames allusers)
      );
in {
    imports = perUserSystemConfigs ++ [

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          home-manager.users = builtins.mapAttrs (name: user: import ./${name} {inherit user; username = name; } ) allusers;

          home-manager.extraSpecialArgs = {
            inherit  super;
          };
        }
    ];
}
