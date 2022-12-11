local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- default
map('i', 'jj', '<Esc><CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>n', ':NERDTreeToggle<CR>')
map('n', '<tab>', ':bp<CR>')
map('n', '<s-tab>', ':bn<CR>')
map('n', '<F12>', 'gg=G')

map('n', '<leader><leader>', ':Files<CR>')
map('n', '<leader>p', ':GFiles<CR>')
map('n', '<leader>b', ':Buffers<CR>')
map('n', '<esc>', ':noh<return><esc>')

--map('n', 'gi', 'vim.lsp.buf.implementation')
map('n', '<leader>ac', 'vim.lsp.buf.code_actions')
--map('n', 'gd', 'vim.lsp.buf.definition')
