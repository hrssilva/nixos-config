{  allusers, ... } :
{

  users.users = builtins.mapAttrs (_name: user:
      {
        isNormalUser = true;
        description = user.description;
        extraGroups = [ "wheel" ] ++ user.groups;
        hashedPassword = if user.isuserhashed then user.password else null;
        password = if !user.isuserhashed then user.password else null;
        openssh.authorizedKeys.keys = user.ssh-keys;
      }) allusers ;
}
