{pkgs, ...}:

{
  services.netdata = {
    package = (pkgs.netdata.override { withCloudUi = true; });
    enable = true;

    config = {
      global = {
        "update every" = "5";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 19999 ];

}

