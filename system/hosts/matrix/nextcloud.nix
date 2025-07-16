{pkgs, config, ...}:
{
    services.nextcloud = {                
        enable = true;                   
        package = pkgs.nextcloud31;
        # we'll reference the package version specified above
        extraApps = {
            inherit (config.services.nextcloud.package.packages.apps) mail contacts calendar tasks deck whiteboard spreed onlyoffice;
        };
        extraAppsEnable = true;
        # Might need to place some nginx configs instead
        hostName = "localhost";
        config = {
            adminpassFile = config.age.secrets.nextcloud-password.path;
            dbtype = "pgsql";
            dbhost = "/run/postgresql";
        };

        settings = {
            trusted_domains = [
                "cloud.hrssilva.dev.br"
                "matrix.weasel-cliff.ts.net"
            ];
        };
        home = "/var/lib/nextcloud-server";
        datadir = "/mnt/data/nextcloud-server";

    };

    services.postgresql = {
        enable = true;
        ensureDatabases = [ "nextcloud" ];
        ensureUsers = [
            {
                name = "nextcloud";
                ensureDBOwnership = true;
            }
        ];
    };
}
