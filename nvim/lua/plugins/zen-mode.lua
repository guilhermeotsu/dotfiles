return {
  {
    "folke/zen-mode.nvim",
    opts = {},
    config = function()
      -- vim.api.nvim_create_autocmd({ "BufEnter" }, {
      --   pattern = { "*.md" },
      --   callback = require("zen-mode").open,
      -- })
    end,
  },
}
