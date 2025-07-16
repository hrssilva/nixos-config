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

        hostName = "localhost";
        config = {
            adminpassFile = config.age.secrets.nextcloud-password.path;
            dbtype = "pgsql";
            dbhost = "/run/postgres";
        };

        settings = {
            trusted_domains = [
                "cloud.hrssilva.dev.br"
                "matrix.weasel-cliff.ts.net"
            ];
        };
        datadir = "/mnt/data/nextcloud";

    };
}
