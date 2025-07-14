{ pkgs, config, lib, ... }:
let
    # Using templates to generate with agenix on activation script
    v-tailscale-key = "@v-tailscale-key@";
    v-vpn-password = "@v-vpn-password@";
    v-vpn-username = "@v-vpn-username@";

in {
    virtualisation.docker.enable = true;

    system.activationScripts."exitnode-secret" = lib.stringAfter [ "etc" "agenix" "agenixRoot" ] ''
        v-tailscale-key=$(cat "${config.age.secrets.tailscale.path}")
        v-vpn-password=$(cat "${config.age.secrets.vpn-password.path}")
        v-vpn-username=$(cat "${config.age.secrets.vpn-user.path}")
    '';

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
                OPENVPN_USER = v-vpn-username;
                OPENVPN_PASSWORD = v-vpn-password;
                TZ = "America/Sao_Paulo";
                UPDATER_PERIOD = "24h";
            };
            volumes = [
                "/var/lib/exitnode-vpn/gluetun:/gluetun"
            ];
        };

        tailscale-exit = {
            image = "tailscale/tailscale";
            autoStart = true;

            extraOptions = [ 
                "--network='service:gluetun'" 
                "--cap-add=NET_ADMIN"
                "--cap-add=NET_RAW"
            ];
            environment = {
                TS_HOSTNAME = "vpn-exit-node";
                TS_EXTRA_ARGS = "--advertise-exit-node";
                TS_STATE_DIR = "/state";
                TS_AUTHKEY = v-tailscale-key;
            };
            volumes = [
                "/var/lib/exitnode-vpn/tailscale/var/lib:/var/lib"
                "/var/lib/exitnode-vpn/tailscale/state:/state"
                "/dev/net/tun:/dev/net/tun"
            ];
        };
    };
}
