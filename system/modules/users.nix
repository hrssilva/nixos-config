{ config, pkgs, username, userdescription, usergroups, ... } :
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = userdescription;
    extraGroups = [ "wheel" ] ++ usergroups;
  };
}
