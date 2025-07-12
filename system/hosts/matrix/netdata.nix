{pkgs, ...}:

{
    services.netdata = {
        enable = true;
        config = {
            global = {
                "memory mode" = "ram";     
                "update every" = "1";
                "web files owner" = "netdata";  
                "web files group" = "netdata";  
                "web directory" = "${pkgs.netdata}/share/netdata/web";
            };
        };
    };

    networking.firewall.allowedTCPPorts = [ 19999 ]; # Porta padrão do Netdata

    environment.systemPackages = with pkgs; [
        netdata
    ];
}

