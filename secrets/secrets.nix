
let
  matrix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBTszRSxo6CmRhwZagyveu3G3PHI/PjHuqe6XF2lciVd";
  systems = [ matrix ];
in
{
  "exitnode-tailscale.age".publicKeys = systems;
  "exitnode-vpn-env.age".publicKeys = systems;
}
