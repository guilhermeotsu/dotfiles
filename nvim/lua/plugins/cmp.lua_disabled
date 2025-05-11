return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
    "onsails/lspkind.nvim", -- vs-code like pictograms
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help"
  },
  config = function()
    local cmp = require("cmp")
    local snippy = require("snippy")
    local lspkind = require("lspkind")

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          snippy.expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        -- ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name= "snippy"},
        { name = "crates" },
        { name = "nvim_lsp_signature_help" },
        { name = "path" }
      }, {
          { name = "buffer" },
        }),
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
          { name = "buffer" },
        }),
    })

    cmp.setup.filetype({ "sql", "mysql" }, {
      sources = cmp.config.sources({
        { name = "vim-dadbod-completion"},
        { name = "buffer"}
      })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }, {
          { name = "buffer"}
        }),
    })

    snippy.setup({
      mappings = {
        is = {
          ['<Tab>'] = 'expand_or_advance',
          ['<S-Tab>'] = 'previous',
        },
      },
    })
  end,
}
