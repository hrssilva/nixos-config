{ config, pkgs, super, ... }: let 
    dotPath = "${config.home.homeDirectory}/nixos-config/home/nvim";
in {

    #xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink dotPath;
    home.packages = with pkgs; [ marksman ]; # Install system wide, since I use MD to take notes
    programs.neovim = {
        enable = true;
        defaultEditor = true;
	extraConfig = ''
        set notermguicolors
	set expandtab
	set shiftwidth=4
	'';
	plugins = with pkgs.vimPlugins; [
	    nvim-lspconfig
	    plenary-nvim
	    telescope-nvim
	    which-key-nvim
	];
	extraLuaConfig = ''
	vim.lsp.enable('pyright')
	vim.lsp.enable('tsserver')
	vim.lsp.enable('marksman')
	'';
  };
}
