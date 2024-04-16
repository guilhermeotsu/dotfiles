local builtin = require('telescope.builtin')
local extend_omnisharp = require('omnisharp_extended')
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ['q'] = actions.close
            }
        }
    },
    pickers = {
        find_files = {
            theme = "dropdown"
        },
        git_files = {
            theme = "dropdown"
        }
    },
    extensions = {
        file_browser = {
            theme = 'dropdown',
            hijack_newtw = true,
            mappings = {
                ['i'] = {
                    ['<C-w>'] = function() vim.cmd('normal vbd') end,
                }
            }
        }
    }
})

--print(extend_omnisharp.telescope_lsp_definitions())

vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})

vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>brg', builtin.current_buffer_fuzzy_find, {})
-- vim.keymap.set('n', '<leader>btg', builtin.current_buffer_tags, {})
vim.keymap.set('n', '<leader>/', builtin.search_history, {})

-- search word under curson
vim.keymap.set('n', '<leader>f', builtin.grep_string, {})
vim.keymap.set('n', '<leader>re', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>tg', builtin.help_tags, {})
--vim.keymap.set('n', '<leader>di', builtin.diagnostics, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'td', builtin.lsp_type_definitions, {})

vim.keymap.set('n', '<leader>gi', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gs', builtin.git_stash, {})
vim.keymap.set('n', '<leader>p', builtin.git_files, {})
vim.keymap.set('n', '<leader>z', builtin.resume, {})

vim.keymap.set('n', '<leader>tr', builtin.treesitter, {})

-- vim.keymap.set('n', '<leader>te', extend_omnisharp.telescope_lsp_definitions(), {})
