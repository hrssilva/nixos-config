{ ... }:
{
    age.secrets = {
        tailscale.file = ../../../secrets/exitnode-tailscale.age;
        vpn-env.file = ../../../secrets/exitnode-vpn-env.age;
    };
}
