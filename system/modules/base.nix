{ pkgs, username, ... } :
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Change kernel version to mainline
  # boot.kernelPackages = pkgs.linuxPackages_testing;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.extraOptions = ''
        trusted-users = root ${username}
    '';
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    git
    neovim
    brightnessctl
    playerctl
  ];

  environment.variables.EDITOR = "nvim";

  system.stateVersion = "24.11"; # Did you read the comment?
}
