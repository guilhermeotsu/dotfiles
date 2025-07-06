return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry"
        }
      })
      require("mason-lspconfig").setup()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "typescript-language-server",
          "biome",
          "rzls",
          "html",
          "cssls",
          "clangd",
          "gopls",
          "bash-language-server",
        },
        integrations = {
          ['mason-lspconfig'] = true,
        },
      })
    end,
  },
  {
    "Issafalcon/lsp-overloads.nvim",
    -- "Hoffs/omnisharp-extended-lsp.nvim",
    "j-hui/fidget.nvim",
    "nvim-lua/lsp-status.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")

      local servers = {
        "ts_ls",
        "lua_ls",
        "clangd",
        "gopls",
        "html",
        "cssls",
        "bashls",
        "ruby_lsp",
        "dockerls",
        "docker_compose_language_service"
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = function(client, bufnr)
            -- Guard against servers without the signatureHelper capability
            if client.server_capabilities.signatureHelpProvider then
              require('lsp-overloads').setup(client, {})
            end
          end,
        })
      end

      lspconfig.html.setup({
        filetypes = { "html", "cshtml", "javascript", "javascriptreact", "eruby" },
      })

      vim.diagnostic.config({
        underline = {
          severity = {
            vim.diagnostic.severity.ERROR,
            -- vim.diagnostic.severity.WARN,
          },
        },
        virtual_text = {
          severity = {
            vim.diagnostic.severity.ERROR,
            -- vim.diagnostic.severity.WARN
          },
          spacing = 4,
          prefix = "●",
        },
        signs = {
          severity = {
            vim.diagnostic.severity.ERROR,
            -- vim.diagnostic.severity.WARN
          }
        },
        float = {
          severity_sort = true,
        },
        update_in_insert = true,
      })

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
          vim.keymap.set("n", "D", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          -- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>l", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
}
