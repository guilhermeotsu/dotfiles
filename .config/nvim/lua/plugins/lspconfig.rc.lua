require'lspconfig'.sumneko_lua.setup{}
require'lspconfig'.csharp_ls.setup{}
require'lspconfig'.omnisharp.setup {
    cmd = { "/home/otsu/.omnisharp/omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
