{ config, pkgs, super, ... }: let 
    dotPath = "${config.home.homeDirectory}/nixos-config/home/nvim";
in {

    #xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink dotPath;
    home.packages = with pkgs; [ 
        marksman # Install system wide, since I use MD to take notes
        nil # For nix lsp
        ripgrep # For telescope
    ];     
    programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
    set notermguicolors
    set expandtab
    set shiftwidth=4
    let mapleader = " "
    '';
    plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        plenary-nvim
        telescope-nvim
        which-key-nvim
    ];
    extraLuaConfig = ''
    vim.lsp.enable('pyright')
    vim.lsp.enable('tsserver')
    vim.lsp.enable('marksman')
    vim.lsp.enable('nil')
    local builtin = require('telescope.builtin')
    local lspconfig = require("lspconfig")
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    '';
  };
}
