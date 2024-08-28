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
        ensure_installed = { "lua_ls", "biome", "tsserver" },
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
    opts = {},
  },
  {
    "Hoffs/omnisharp-extended-lsp.nvim"
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
        on_attach = function(client, bufnr)
          --- Guard against servers eithout the signatureHelper capability
          -- if client.server_capabilities.signatureHelpProvider then
          -- vim.api.nvim_set_keymap("n", "<leader>o", ":LspOverloadsSignature<CR>", { noremap = true, silent = true, buffer = bufnr })
          -- local lsp_overloads_ok, lsp_overloads = pcall(require, "lsp-overloads")
          -- if lsp_overloads_ok then
          --   lsp_overloads.setup(client, {
          --     ui = {
          --       close_events = { "CursorMoved", "CursorMovedI", "InsertCharPre" },
          --       floating_window_above_cur_line = true,
          --       silent = true,
          --     }
          --   })
          -- end
          -- end

        end
      }

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

      -- Wrap handlers for dotnet
      -- lsp_handlers["textDocument/definition"] = require('omnisharp_extended').definition_handler
      -- lsp_handlers["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler
      -- lsp_handlers["textDocument/references"] = require('omnisharp_extended').references_handler
      -- lsp_handlers["textDocument/implementation"] = require('omnisharp_extended').implementation_handler

      local signs = { Error = "X", Warning = "A", Hint = "", Information = "" }

      for type, icon in pairs(signs) do
        local hl = 'LspDiagnostiscSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local omni_ext = require('omnisharp_extended')
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

          vim.keymap.set("n", "<leader>gd", omni_ext.definition_handler)
          vim.keymap.set("n", "<leader>gi", omni_ext.implementation_handler)
        end,
      })
    end,
  },
}
