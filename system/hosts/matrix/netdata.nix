{pkgs, ...}:

{
    services.netdata = {
        enable = true;
        config = {
            global = {
                "memory mode" = "ram";     
                "update every" = "1";
            };
        };
    };

    networking.firewall.allowedTCPPorts = [ 19999 ]; # Porta padrão do Netdata

    environment.systemPackages = with pkgs; [
        netdata
    ];
}

