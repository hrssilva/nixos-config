{ config, pkgs, username, hostname, ... }:
{
  imports = [
        # Comment out items to unninstall
  	./nvim
        ./tmux
        ./hosts/laptop
        ./hosts/matrix
  ];

  home.username = "hrssilva";
  home.homeDirectory = "/home/hrssilva";
  nix.registry.dev.to = {
    type = "path";
    path = "${./dev}";
  };

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

  # Allow home-manager as a standalone tool.
  # programs.home-manager.enable = true;

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "hrssilva";
    userEmail = "haroldo.rssilva@gmail.com";
  };



  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
      set -o vi
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
    la = "ll -a";
    };
  };



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
