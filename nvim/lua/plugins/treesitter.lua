print('nvim-treesitter load')
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c_sharp", "lua", "javascript", "html", "css" },
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = { -- Very slow opening file
    enable = true,
  },
}
