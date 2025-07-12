{pkgs, ...}:

{
  services.netdata = {
    enable = true;

    config = {
      global = {
        "memory mode" = "save";
        "update every" = "1";
        "web files owner" = "netdata";
        "web files group" = "netdata";
        "web directory" = "${pkgs.netdata}/share/netdata/web";
      };

      web = {
        "default port" = "19999";
        "bind to" = "localhost:19999 *:19999";
        "enable web responses gzip" = "yes";
        "enable dashboard" = "yes";  
        "serve dashboard" = "yes";   
        "enable ssl" = "no";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 19999 ];

}

