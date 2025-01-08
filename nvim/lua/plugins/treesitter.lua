return {
  "nvim-treesitter/nvim-treesitter",
  -- dependencies = {
  --   "dependencieswindwp/nvim-ts-autotag",
  --   -- "nvim-treesitter/nvim-treesitter-context"
  -- },
  build = ":TSUpdate",
  lazy = vim.fn.argc(-1) == 0,
  config = function()
    -- require('nvim-ts-autotag').setup{}
    local config = require("nvim-treesitter.configs")
    -- local config = require("nvim-ts-autotag")
    config.setup({
      ensure_installed = {
        "lua",
        "tsx",
        "typescript",
        "javascript",
        "html",
        "css",
        "json",
        "yaml",
        "regex",
        "markdown",
        "markdown_inline",
        "c",
        "c_sharp",
        "vim",
        "vimdoc"
      },
      sync_install = true,
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      autotag = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
