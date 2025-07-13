{pkgs, ...}:
{
    services.postgresql = {
        enable = true;
        package = pkgs.postgresql_16;
        dataDir = "/var/lib/postgresql/16";
    };

    services.postgresqlBackup = {
        enable = true;
        location = "/mnt/data/backup/postgresql/16";
    };
}
