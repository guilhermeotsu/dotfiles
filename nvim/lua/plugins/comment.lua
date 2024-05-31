return {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup()

    -- Define comment pattern for MySQL files
    vim.api.nvim_exec([[
      autocmd FileType mysql setlocal commentstring=#\ %s
    ]], false)
  end,
}
