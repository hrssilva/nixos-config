{pkgs, lib, hostname, ...}:
{

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    # networking tools
    mtr # A network diagnostic tool
    pavucontrol
    htop
    clipse
    fzf
  ];
}
