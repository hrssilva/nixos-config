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
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('my.lsp', {}),
      callback = function(args)
        local opts = function(desc)
          return { buffer = bufnr, desc = desc }
        end
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/implementation') then
          -- Create a keymap for vim.lsp.buf.implementation ...
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to Implementation"))
        if client:supports_method('textDocument/definition') then
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to Definition"))
        end
        if client:supports_method('textDocument/declaration') then
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to Declaration"))
        end
        if client:supports_method('textDocument/references') then
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("List References"))
        end
        if client:supports_method('textDocument/hover') then
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover Documentation"))
        end
        if client:supports_method('textDocument/signatureHelp') then
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))
        end
        if client:supports_method('textDocument/rename') then
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename Symbol"))
        end
        if client:supports_method('textDocument/codeAction') then
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
        end

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
          -- Optional: trigger autocompletion on EVERY keypress. May be slow!
          -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
          -- client.server_capabilities.completionProvider.triggerCharacters = chars

          vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
        end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
            end,
          })
        end
      end,
    })
    '';
  };
}
