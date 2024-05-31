vim.g.mapleader = " "
-- default
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', 'q:', '')
-- map('n', '<tab>', ':bp<CR>')
-- map('n', '<s-tab>', ':bn<CR>')
vim.keymap.set('n', '<F12>', 'gg=G')
vim.keymap.set('n', '<esc>', ':noh<return><esc>')
vim.keymap.set('x', '<leader>p', '\'_dP')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- move lines
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- manage windows
vim.keymap.set('n', '<leader>v', ":vs<CR>")
vim.keymap.set('n', '<leader>s', ":sp<CR>")
vim.keymap.set('n', '<C-j>', '<c-w><c-j>')
vim.keymap.set('n', '<C-k>', '<c-w><c-k>')
vim.keymap.set('n', '<C-l>', '<c-w><c-l>')
vim.keymap.set('n', '<C-h>', '<c-w><c-h>')

-- alt shit hjkl
vim.keymap.set('n', '<C-Left>', '<C-w>5<')
vim.keymap.set('n', '<C-Right>', '<C-w>5>')
-- map('n', '<S-->', '<c-w>5>')
-- map('n', '<S-0>', '<c-w>5<', { noremap = true, silent = true })
