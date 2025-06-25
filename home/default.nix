{ config, pkgs, ... }:
{
  imports = [
        # Comment out items to unninstall
	./hypr
  	./eww
  	./wofi
  	./nvim
  	./kitty
	./cava
	./kdeconnect
	./dunst
	./inkscape
  ];

  home.username = "hrssilva";
  home.homeDirectory = "/home/hrssilva";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 196608;
  };

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
  ];

  # Allow home-manager as a standalone tool.
  # programs.home-manager.enable = true;

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "hrssilva";
    userEmail = "haroldo.rssilva@gmail.com";
  };

  # starship - an customizable prompt for any shell
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


  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
    la = "ll -a";
    };
  };

  # Install firefox.
  programs.firefox.enable = true;
  
  # Install chromium.
  programs.chromium.enable = true;
  


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
