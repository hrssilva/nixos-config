{ config, pkgs, super, hostname, ... }: {
    programs.wezterm = {
        enable = true;
        extraConfig = """
        -- Pull in the wezterm API
        local wezterm = require 'wezterm'

        -- This will hold the configuration.
        local config = wezterm.config_builder()

        -- This is where you actually apply your config choices.

        -- For example, changing the initial geometry for new windows:
        -- config.initial_cols = 120
        -- config.initial_rows = 28

        -- or, changing the font size and color scheme.
        -- config.font_size = 10
        config.color_scheme = 'Rosé Pine Moon (Gogh)'
        config.window_background_opacity = 0.65

        -- Finally, return the configuration to wezterm:
        return config
        """ ;
    } ;
}
