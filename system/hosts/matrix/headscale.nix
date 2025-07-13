{ ... }:
{
    services.headscale = {
        enable = true;
        port = 8083;
        settings = {
            dns = {
                base_domain = "tailnet.com";
            };
        };
    };

    services.cloudflared = {
        enable = true;
        certificateFile = "/var/lib/cloudflared/cert.pem";
        tunnels = {
            "home-server" = {
                ingress = {
                    "lighthouse.hrssilva.dev.br" = "http://localhost:8083";
                };
                default = "http_status:404";
            };
        };
    };
}

