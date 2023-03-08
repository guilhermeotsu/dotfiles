local lspconfig = require('lspconfig')

lspconfig.omnisharp.setup{
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    on_attach = function(client)
        --- Guard against servers without the signatureHelper capability
        if client.server_capabilities.signatureHelpProvider then
            require('lsp-overloads').setup(client, { })
        end
    end,
    flags = lsp_flags,
}

lspconfig.lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    'vim',
                    'on_attach',
                    'lsp_flags'
                }
            }
        }
    }
}

lspconfig.emmet_ls.setup{}
