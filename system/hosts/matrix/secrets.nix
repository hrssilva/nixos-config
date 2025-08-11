{ ... }:
{
    age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # isn't set automatically when openssh is not setup
    age.secrets = {
        tailscale.file = ../../../secrets/exitnode-tailscale.age;
        vpn-env.file = ../../../secrets/exitnode-vpn-env.age;
        nextcloud-password.file = ../../../secrets/nextcloud-password.age;
        cloudflared.file = ../../../secrets/cloudflared.age;
        cloudflared-home-server.file = ../../../secrets/cloudflared-home-server.age;
    };
}
