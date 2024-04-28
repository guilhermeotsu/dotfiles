vim.cmd("let g:nvcode_termcolors=256")

vim.g.catppuccin_flavour = "macchiato"

-- Configure catppuccin
require("catppuccin").setup({
  transparent_background = false,
  term_colors = false,
  integrations = {
    telescope = false,
  }
})

vim.cmd([[colorscheme catppuccin]])
-- vim.o.background = "light"
