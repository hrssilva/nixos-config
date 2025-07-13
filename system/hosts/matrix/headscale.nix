{ ... }:
let
    cloudflared-cert = "/var/lib/cloudflared/cert.pem";
    cloudflared-dir = "/var/lib/cloudflared";
    home-server-uuid = "41147f7a-bf4a-41de-9757-2e2de2d699e5";
in {
    services.headscale = {
        enable = true;
        port = 8083;
        settings = {
            dns = {
                base_domain = "tailnet.com";
            };
            server_url = "http://127.0.0.1:8083";
        };
    };

    services.cloudflared = {
        enable = true;
        certificateFile = cloudflared-cert;
        tunnels = {
            "home-server" = {
                ingress = {
                    "lighthouse.hrssilva.dev.br" = "http://localhost:8083";
                };
                default = "http_status:404";
                credentialsFile = "${cloudflared-dir}/${home-server-uuid}.json";
            };
        };
    };
}

