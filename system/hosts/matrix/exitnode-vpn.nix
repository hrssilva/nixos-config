{ pkgs, config, lib, ... }:
let
    # Using templates to generate with agenix on activation script
    v-tailscale-key = "@v-tailscale-key@";
    v-vpn-password = "@v-vpn-password@";
    v-vpn-username = "@v-vpn-username@";

in {
    virtualisation.podman.enable = true;

    system.activationScripts."exitnode-secret" = lib.stringAfter [ "etc" "agenix" "agenixRoot" ] ''
        v-tailscale-key=$(cat "${config.age.secrets.tailscale.path}")
        v-vpn-password=$(cat "${config.age.secrets.vpn-password.path}")
        v-vpn-username=$(cat "${config.age.secrets.vpn-user.path}")
    '';

    virtualisation.oci-containers.containers = {
        gluetun = {
            image = "qmcgaw/gluetun";
            autoStart = true;

            capAdd = [ "NET_ADMIN" ];
            extraOptions = [ "--device=/dev/net/tun:/dev/net/tun" ];
            environment = {
                VPN_SERVICE_PROVIDER = "protonvpn";
                OPENVPN_USER = v-vpn-username;
                OPENVPN_PASSWORD = v-vpn-password;
                TZ = "America/Sao_Paulo";
                UPDATER_PERIOD = "24h";
            };
        };

        tailscale-exit = {
            image = "tailscale/tailscale";
            autoStart = true;

            capAdd = [ "NET_ADMIN" "NET_RAW" ];
            extraOptions = [ "--network='service:gluetun'" ];
            environment = {
                TS_HOSTNAME = "vpn-exit-node";
                TS_EXTRA_ARGS = "--advertise-exit-node";
                TS_STATE_DIR = "/state";
                TS_AUTHKEY = v-tailscale-key;
            };
        };
    };
}
