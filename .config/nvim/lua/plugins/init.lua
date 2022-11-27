vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'williamboman/mason.nvim' -- configure lsp 
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- The completion plugin
    use 'hrsh7th/cmp-buffer' -- buffer completions
    use 'hrsh7th/cmp-path' -- path completions
    use 'hrsh7th/cmp-cmdline' -- cmdline completions
    use 'hrsh7th/cmp-nvim-lsp' -- LSP completion support
    use 'hrsh7th/cmp-vsnip'
    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use 'junegunn/fzf.vim'
    use 'nvim-treesitter/nvim-treesitter'

    use 'iamcco/markdown-preview.nvim'
    use 'preservim/nerdtree' -- menu
    use ({'glepnir/lspsaga.nvim', branch = 'main'}) -- lsp funcs
    use 'Issafalcon/lsp-overloads.nvim' -- navigation overload funcs
    use 'kyazdani42/nvim-web-devicons' -- icons
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'catppuccin/nvim'
    use 'numToStr/Comment.nvim'
    use {
     'romgrk/barbar.nvim',
     requires = {'kyazdani42/nvim-web-devicons'}
    }
end)

--require("mason").setup()
--require'lspconfig'.sumneko_lua.setup{}
--require'lspconfig'.emmet_ls.setup{}

--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true
--require'lspconfig'.jsonls.setup { capabilities = capabilities }
--local cmp = require'cmp'
--cmp.setup({
--  snippet = {
--    expand = function(args)
--      vim.fn["vsnip#anonymous"](args.body)
--    end,
--  },
--  mapping = {
--    ['<C-c>'] = cmp.mapping.close(),
--    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--    ['<CR>'] = cmp.mapping.confirm({ select = true }),
--    ['<Tab>'] = cmp.mapping.select_next_item(),
--    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--  },
--  sources = {
--      { name = "nvim_lsp" },
--      { name = "path" }
--  },
--  completion = { completeopt = "menu,menuone,noinsert"},
--  experimental = { ghost_text = true },
--})
--
----
---- lspsapa
--local keymap = vim.keymap.set
--local saga = require('lspsaga')
--
--saga.init_lsp_saga()
--
---- Lsp finder find the symbol definition implement reference
---- when you use action in finder like open vsplit then you can
---- use <C-t> to jump back
--keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
--
---- Code action
--keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
--keymap("v", "<leader>ca", "<cmd>Lspsaga range_code_action<CR>", { silent = true })
--
---- Rename
--keymap("n", "<leader>r", "<cmd>Lspsaga rename<CR>", { silent = true })
--
---- Definition preview
----keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
--
---- Show line diagnostics
--keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
--
---- Show cursor diagnostic
--keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
--keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
--keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
--
---- Only jump to error
--keymap("n", "[E", function()
--  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
--end, { silent = true })
--keymap("n", "]E", function()
--  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
--end, { silent = true })
--
---- Outline
--keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })
--
---- Hover Doc
--keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
--
---- if you want pass somc cli command into terminal you can do like this
---- open lazygit in lspsaga float terminal
--keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
---- close floaterm
--keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
--
--
--
---- Mappings.
---- See `:help vim.diagnostic.*` for documentation on any of the below functions
--local opts = { noremap=true, silent=true }
--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
--
---- Use an on_attach function to only map the following keys
---- after the language server attaches to the current buffer
--local on_attach = function(client, bufnr)
--  -- Enable completion triggered by <c-x><c-o>
--  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--  -- Mappings.
--  -- See `:help vim.lsp.*` for documentation on any of the below functions
--  local bufopts = { noremap=true, silent=true, buffer=bufnr }
--  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--  vim.keymap.set('i', '<C-i>', vim.lsp.buf.signature_help, bufopts)
--  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--  vim.keymap.set('n', '<space>wl', function()
--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--  end, bufopts)
--  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
--
--   --- Guard against servers without the signatureHelper capability
--  if client.server_capabilities.signatureHelpProvider then
--    require('lsp-overloads').setup(client, {
--        ui = {
--          -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
--          border = "single"
--        },
--        keymaps = {
--          next_signature = "<C-j>",
--          previous_signature = "<C-k>",
--          next_parameter = "<C-l>",
--          previous_parameter = "<C-h>",
--        },
--      })
--  end
--end
--
--local lsp_flags = {
--  -- This is the default in Nvim 0.7+
--  debounce_text_changes = 150,
--}
--
--require'lspconfig'.tsserver.setup{
--  on_attach = on_attach,
--  flags = lsp_flags,
--}
--
--require'lspconfig'.html.setup {
--  capabilities = capabilities,
--  filetype = {"html", "cshtml"},
--  on_attach = on_attach,
--  flags = lsp_flags,
--}
--require'lspconfig'.cssls.setup {
--  capabilities = capabilities,
--  filetypes = { "css", "scss", "less" },
--  on_attach = on_attach,
--  flags = lsp_flags,
--}
--
--require'lspconfig'.omnisharp.setup{
--  on_attach = on_attach,
--  flags = lsp_flags,
--}
--
