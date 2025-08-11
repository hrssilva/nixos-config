{ifaces, ... }:
{

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
    containers."vNextcloud" = {
        privateNetwork = true;
        autoStart = true;
        bindMounts."/etc/ssh/ssh_host_ed25519_key".isReadOnly = true;
        bindMounts."/var/lib/nextcloud-server".isReadOnly = false;
        bindMounts."/mnt/data/nextcloud-server".isReadOnly = false;
        bindMounts."/run/postgresql".isReadOnly = false;

        interfaces = ifaces;

        config = { ... }:
            {
                import = [
                    ../nextcloud.nix
                ];
            };
    };
}
