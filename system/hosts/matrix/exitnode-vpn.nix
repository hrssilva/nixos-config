{ pkgs, config, lib, ... }:
{

    virtualisation.oci-containers.backend = "docker";
    virtualisation.oci-containers.containers = {
        gluetun = {
            image = "qmcgaw/gluetun";
            autoStart = true;

            extraOptions = [ 
                "--device=/dev/net/tun:/dev/net/tun"
                "--cap-add=NET_ADMIN"
            ];
            environment = {
                VPN_SERVICE_PROVIDER = "protonvpn";
                VPN_TYPE = "wireguard";
                FREE_ONLY = "on";
                TZ = "America/Sao_Paulo";
                UPDATER_PERIOD = "24h";
            };
            environmentFiles = [
                config.age.secrets.vpn-env.path
            ];
            volumes = [
                "/var/lib/exitnode-vpn/gluetun:/gluetun"
            ];
        };

        tailscale-exit = {
            image = "tailscale/tailscale";
            autoStart = true;
            dependsOn = [ "gluetun" ];

            extraOptions = [ 
                "--network=container:gluetun" 
                "--cap-add=NET_ADMIN"
                "--cap-add=NET_RAW"
            ];
            environment = {
                TS_HOSTNAME = "vpn-exit-node";
                TS_EXTRA_ARGS = "--advertise-exit-node";
                TS_STATE_DIR = "/state";
            };
            environmentFiles = [
                config.age.secrets.tailscale.path
            ];
            volumes = [
                "/var/lib/exitnode-vpn/tailscale/var/lib:/var/lib"
                "/var/lib/exitnode-vpn/tailscale/state:/state"
                "/dev/net/tun:/dev/net/tun"
            ];
        };
    };
}
