local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- default
map('i', 'jj', '<Esc><CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>n', ':E<CR>')
map('n', '<tab>', ':bn<CR>')
map('n', '<s-tab>', ':bp<CR>')

map('n', '<leader><leader>', ':Files<CR>')
map('n', '<leader>p', ':GFiles<CR>')
map('n', '<leader>b', ':Buffers<CR>')

local opts = { noremap=true, silent=true }
local bufopts = { noremap=true, silent=true, buffer=bufnr }
map('n', 'gd', 'vim.lsp.buf.definition', bufopts)
map('n', 'gi', 'vim.lsp.buf.implementation', bufopts)
map('n', 'ca', 'vim.lsp.buf.code_actions', bufopts)
