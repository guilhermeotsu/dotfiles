-- https://github.com/linrongbin16/lsp-progress.nvim/pull/133/files#diff-7bb74865bd40076b8da8648f3a65195d7d4728c862077e033d111b4bdf47c790
return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "linrongbin16/lsp-progress.nvim",
      opts = {},
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)

    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_augroup",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })
  end,
  opts = {
    options = {
      component_separators = { left = "|", right = "|" },
      globalstatus = true,
    },
    sections = {
      lualine_c = {
        function()
          return require("lsp-progress").progress()
        end,
      },
    },
    tabline = {
      lualine_a = {
        "buffers",
      },
    },
  },
}
