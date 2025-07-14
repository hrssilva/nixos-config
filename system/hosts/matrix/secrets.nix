{ ... }:
{
    age.secrets = {
        tailscale.file = ../../../secrets/exitnode-tailscale.age;
        vpn-user.file = ../../../secrets/exitnode-vpn-user.age;
        vpn-password.file = ../../../secrets/exitnode-vpn-password.age;
    };
}
