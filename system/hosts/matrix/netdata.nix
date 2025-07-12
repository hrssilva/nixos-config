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
            web = {
                "bind to" = "localhost:19999 *:19999";
                "enable ssl" = "no";  
            };
        };
    };

    networking.firewall.allowedTCPPorts = [ 19999 ]; 

    environment.systemPackages = with pkgs; [
        netdata
    ];
}

