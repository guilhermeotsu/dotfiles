return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "typescript-language-server",
          "biome",
          "omnisharp",
          "html",
          "cssls",
          "clangd",
          "gopls",
          "bash-language-server",
          -- "ruby-lsp"
        },
        integrations = {
          ['mason-lspconfig'] = true,
          -- ['mason-null-ls'] = true,
          -- ['mason-nvim-dap'] = true,
        },
      })
    end,
  },
  {
    "Issafalcon/lsp-overloads.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim",
    "j-hui/fidget.nvim",
    "nvim-lua/lsp-status.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    -- dependencies = {
    -- },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lsp_status = require('lsp-status')

      lsp_status.config({
        status_symbol = "🔧 ", -- Symbol for LSP status
        indicator_ok = "✔", -- Indicator for LSP ready
        indicator_errors = "✖",
        indicator_warnings = "⚠",
        indicator_info = "ℹ",
        indicator_hint = "💡",
        indicator_running = "⏳",
        spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- Spinner animation
        current_function = true, -- Show current function in status
      })

      lsp_status.register_progress()

      local servers = {
        -- "biome",
        "ts_ls",
        "lua_ls",
        "clangd",
        "gopls",
        "html",
        "cssls",
        "bashls",
        "ruby_lsp",
        -- "solargraph",
        -- "sorbet",
        "dockerls",
        "docker_compose_language_service"
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = function(client, bufnr)
            lsp_status.on_attach(client)
          end,
          capabilities = capabilities
        })
      end

      lspconfig.html.setup({
        filetypes = { "html", "cshtml", "javascript", "javascriptreact", "eruby" },
        on_attach = function(client, bufnr)
          lsp_status.on_attach(client)
        end,
        capabilities = capabilities
      })

      lspconfig.omnisharp.setup(
        {
          cmd = {
            vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp"
          },
          handlers = {
            ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
            ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
            ["textDocument/references"] = require('omnisharp_extended').references_handler,
            ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
          },
          on_attach = function(client, bufnr)
            lsp_status.on_attach(client)
            --- Guard against servers eithout the signatureHelper capability
            if client.server_capabilities.signatureHelpProvider then
              vim.keymap.set("n", "<leader>o", ":LspOverloadsSignature<CR>",
                { noremap = true, silent = true, buffer = bufnr })
              local lsp_overloads_ok, lsp_overloads = pcall(require, "lsp-overloads")
              if lsp_overloads_ok then
                lsp_overloads.setup(client, {
                  ui = {
                    close_events = { "CursorMoved", "CursorMovedI", "InsertCharPre" },
                    floating_window_above_cur_line = true,
                    silent = true,
                  }
                })
              end
            end
          end,
          capabilities = capabilities
        })

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

      vim.diagnostic.config({
        underline = {
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
          },
        },
        virtual_text = {
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN
          },
          spacing = 4,
          prefix = "●",
        },
        signs = {
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN
          }
        },
        float = {
          severity_sort = true,
        },
        update_in_insert = true,
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
