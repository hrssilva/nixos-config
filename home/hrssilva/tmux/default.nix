# Example flake for installing a usual package from the nix store for the user.
# For most packages it should be enough to replace "example" with the name of the desired pkg.
# This example installs the pkg and creates a symlink to the pkg folder for managing the dotfiles.

{ config, pkgs, super, ... }:  
{
    programs.tmux = {
        enable = true;
        clock24 = true;
        keyMode = "vi";
        prefix = "C-a";
        sensibleOnTop = true;
        plugins = with pkgs.tmuxPlugins; [
            resurrect
        ];
        extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
            set -g status-style bg=default
        '';
    };
}
