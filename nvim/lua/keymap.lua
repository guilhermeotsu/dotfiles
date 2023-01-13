local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- default
map('i', 'jj', '<Esc>')
map('n', '<leader>w', ':w<CR>')
--map('n', '<leader>n', ':NERDTreeToggle<CR>')
map('n', '<tab>', ':bp<CR>')
map('n', '<s-tab>', ':bn<CR>')
map('n', '<F12>', 'gg=G')

map('n', '<leader><leader>', ':Files<CR>')
map('n', '<leader>p', ':GFiles<CR>')
map('n', '<leader>rg', ':Rg<CR>')
map('n', '<leader>bu', ':Buffers<CR>')
map('n', '<leader>bl', ':BLines<CR>')
map('n', '<leader>bt', ':BTags<CR>')
map('n', '<leader>tt', ':Tags<CR>')
map('n', '<esc>', ':noh<return><esc>')

map('x', '<leader>p', '\'_dP')
map('n', '<leader>n', vim.cmd.Ex) -- newtr

map('v', 'J', ":m '>+1<CR>gv=gv") -- move lines
map('v', 'K', ":m '<-2<CR>gv=gv")

map('n', 'J', 'mzJ`z') -- cursor still in same position
map('n', '<C-d>', '<C-d>zz') -- cursor still in center screen
map('n', '<C-u>', '<C-u>zz') 
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- don't work :(
map('n', '<leader>y', "\"+y")
map('v', '<leader>y', "\"+y")
map('n', '<leader>Y', "\"+Y")

--map('n', '<C-f>', '<cmd> silent !tmux neww tmux-sessionizer<CR>')
