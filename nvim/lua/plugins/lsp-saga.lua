return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      lightbulb = {
        enable = false
      },
      finder = {
        keys = {
          toggle_or_open = '<CR>',
          quit = '<esc>'
        }
      }
    })

    -- vim.keymap.set("n", "<leader>re", ":Lspsaga finder<CR>" )
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',     -- optional
    'nvim-tree/nvim-web-devicons',         -- optional
  }
}
