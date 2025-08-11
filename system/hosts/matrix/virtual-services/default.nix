{ ... }:
let 
    bridge-prefix = "nxbr-";
    interface-prefix = "nxve-";
    nextcloud-app = "${interface-prefix}nextapp";
    nextcloud-gw = "${interface-prefix}nextgw";
    host = "${interface-prefix}host";
    gw = "${interface-prefix}gw";
in {
    imports = [
        (import ./nextcloud.nix {ifaces = [ nextcloud-app ];})
        (import ./gateway.nix {ifaces = [ nextcloud-gw gw ];})
        #./dns.nix
    ];

    networking.networkmanager.unmanaged = [
        "interface-name:${bridge-prefix}*"
        "interface-name:${interface-prefix}*"
    ];


    networking.interfaces = {
        "${nextcloud-app}" = {
            virutal = true;
            ipv4.adresses = {
                address = "192.168.101.2";
                prefixLength = 28;
            };
        };
        "${nextcloud-gw}" = {
            virutal = true;
            ipv4.adresses = {
                address = "192.168.101.1";
                prefixLength = 28;
            };
        };
        "${host}" = {
            ipv4.adresses = {
                address = "192.168.100.1";
                prefixLength = 28;
            };
        };
        "${gw}" = {
            virtual = true;
            ipv4.adresses = {
                address = "192.168.100.2";
                prefixLength = 28;
            };
        };
    };
}
