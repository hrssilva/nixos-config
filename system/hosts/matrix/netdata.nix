{pkgs, ...}:
{
  networking.firewall.allowedTCPPorts = [19999];

  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "ram";
        "debug log" = "none";
        "access log" = "none";
        "error log" = "syslog";
      };
    };
  };
}
