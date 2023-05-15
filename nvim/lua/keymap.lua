local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- default
map('i', 'jj', '<Esc>')
map('n', '<leader>w', ':w<CR>')
map('n', '<tab>', ':bp<CR>')
map('n', '<s-tab>', ':bn<CR>')
map('n', '<F12>', 'gg=G')

map('n', '<esc>', ':noh<return><esc>')

map('x', '<leader>p', '\'_dP')
map('n', '<leader>n', ':E<CR>')
-- map('n', '<leader>n', ':NvimTreeToggle<CR>')
-- map('n', '<leader>N', ':NvimTreeFindFileToggle<CR>')

map('v', 'J', ":m '>+1<CR>gv=gv") -- move lines
map('v', 'K', ":m '<-2<CR>gv=gv")

map('n', "<leader>'", ":ToggleTerm direction=float<CR>")
