local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
-- default
map('i', 'jj', '<Esc>')
map('n', '<leader>w', ':w<CR>')
-- map('n', '<tab>', ':bp<CR>')
-- map('n', '<s-tab>', ':bn<CR>')
map('n', '<F12>', 'gg=G')
map('n', '<esc>', ':noh<return><esc>')
map('x', '<leader>p', '\'_dP')
map('v', 'J', ":m '>+1<CR>gv=gv") -- move lines
map('v', 'K', ":m '<-2<CR>gv=gv")

-- manage windows
map('n', '<leader>v', ":vs<CR>")
map('n', '<leader>s', ":sp<CR>")
map('n', '<C-j>', '<c-w><c-j>')
map('n', '<C-k>', '<c-w><c-k>')
map('n', '<C-l>', '<c-w><c-l>')
map('n', '<C-h>', '<c-w><c-h>')

-- alt shit hjkl
map('n', '<S-->', '<c-w>5>')
map('n', '<S-0>', '<c-w>5<', { noremap = true, silent = true })
