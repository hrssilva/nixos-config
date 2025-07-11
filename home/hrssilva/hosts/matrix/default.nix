{pkgs, lib, hostname, ...}:
lib.mkIf (hostname == "matrix") {

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
