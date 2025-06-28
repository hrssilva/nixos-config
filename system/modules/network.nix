{ allusers, hostname, ... } :
{
  networking.hostName = hostname; # Define your hostname.
  
  # Enable networking
  networking.networkmanager.enable = true;
  users.users = builtins.mapAttrs (_name: user: {
    extraGroups = [ "networkmanager" ];
  }) allusers ;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
