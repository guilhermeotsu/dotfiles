vim.opt.numberwidth=4

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.md" },
  callback = require("zen-mode").open,
})
