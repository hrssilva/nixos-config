{ ... }:
{
    age.secrets = {
        tailscale.file = ../../../secrets/exitnode-tailscale.age;
        vpn-env.file = ../../../secrets/exitnode-vpn-env.age;
        nextcloud-password.file = ../../../secrets/nextcloud-password.age;
        config.age.secrets.cloudflared.file = ../../../secrets/cloudflared.age;
        config.age.secrets.cloudflared-home-server.file = ../../../secrets/cloudflared-home-server.age;
    };
}
