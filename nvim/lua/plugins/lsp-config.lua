return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "biome", "tsserver" },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "biome",
          "omnisharp",
          "html",
          "cssls",
          "clangd",
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {},
  },
  {
    -- omnisharp
    -- "Issafalcon/lsp-overloads.nvim",
    -- opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    depends = { "nvim-lua/lsp-status.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})

      lspconfig.omnisharp.setup {
        cmd = {
          vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp"
        },
        on_attach = function(client)
          --- Guard against servers without the signatureHelper capability
          if client.server_capabilities.signatureHelpProvider then
            -- print('client server signature help omnisharp')
            --require('lsp-overloads').setup(client, { })
          end
        end
      }
      -- lspconfig.omnisharp.setup{
      --   handlers={
      --     ["textDocument/definition"] = require("omnisharp_extend").handler,
      --   },
      --   on_attach = function (client)
      --     if client.server_capabilities.signatureHelpProvider then
      --       require("lsp-overloads").setup(client, {})
      --     end
      --   end
      -- }

      local keymap = vim.keymap
      keymap.set("n", "[", vim.diagnostic.goto_prev)
      keymap.set("n", "]", vim.diagnostic.goto_next)

      -- Define the color
      -- local bg_color = "#1f2335"
      local bg_color = "#252739"
      local fg_color = "white" -- For the border foreground color

      -- Create an autocmd that sets the highlight groups when the colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color })
          vim.api.nvim_set_hl(0, "FloatBorder", { fg = fg_color, bg = bg_color })
        end,
      })

      -- Trigger the autocmd to apply the color immediately
      vim.cmd("doautocmd ColorScheme")

      local lsp_handlers = vim.lsp.handlers

      -- Define the border style
      local border_style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

      -- Wrap the original handlers with a border
      lsp_handlers["textDocument/hover"] = function(err, result, ctx, config)
        config = config or {}
        config.border = border_style
        config.focusable = false
        vim.lsp.handlers.hover(err, result, ctx, config)
      end

      lsp_handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
        config = config or {}
        config.border = border_style
        vim.lsp.handlers.signature_help(err, result, ctx, config)
      end

      local signs = { Error = "X", Warning = "A", Hint = "", Information = "" }

      for type, icon in pairs(signs) do
        local hl = 'LspDiagnostiscSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- vim.keymap.set("n", "D", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
}
