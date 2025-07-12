{pkgs, lib, hostname, ...}:
{
  imports = [
        # Comment out items to unninstall
	./hypr
  	./eww
  	./wofi
  	./kitty
	./cava
	./kdeconnect
	./dunst
	./inkscape
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    # networking tools
    mtr # A network diagnostic tool
    thunderbird
    discord
    teams-for-linux
    protege
    zotero
    galaxy-buds-client
    pavucontrol
    libreoffice
    htop
    lorien
    hyprpicker
    clipse
    devenv
    pastel
    astroterm
    fzf
    spotify-player
    gh
  ];

  # starship - a customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;
  
  # Install chromium.
  programs.chromium.enable = true;
  
}
