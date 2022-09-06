vim.cmd 'packadd paq-nvim'

require "paq" {
    "savq/paq-nvim";
    "williamboman/nvim-lsp-installer";
    "neovim/nvim-lspconfig";
    "nvim-treesitter/nvim-treesitter";
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-path";
    "hrsh7th/cmp-vsnip";
    "hrsh7th/vim-vsnip";
    "sainnhe/everforest";
    {"junegunn/fzf", "{ 'do': { -> fzf#install() } }"};
    "junegunn/fzf.vim";
}

require'nvim-lsp-installer'.setup{}
require'lspconfig'.sumneko_lua.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.emmet_ls.setup{}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.jsonls.setup { capabilities = capabilities }

require'lspconfig'.html.setup {
  capabilities = capabilities,
  filetype = {"html", "cshtml"}
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
  filetypes = { "css", "scss", "less" }
}

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/otsu/.omnisharp/OmniSharp.dll"
local capabilitiesCmp = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.omnisharp.setup {
			cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
			--cmd = { omnisharp_bin },
			capabilities = capabilitiesCmp
}

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-c>'] = cmp.mapping.close(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
      { name = "nvim_lsp" },
      { name = "vsnip" },
      { name = "buffer" },
      { name = "path" }
  },
  completion = { completeopt = "menu,menuone,noinsert"},
  experimental = { ghost_text = true },
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c_sharp", "lua", "javascript", "html", "css" },
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
