local cmd = vim.cmd
local opt = vim.opt

vim.g.everforest_background = 'soft'

cmd 'colorscheme everforest'

opt.completeopt             = { 'menuone', 'noinsert', 'noselect' }
opt.ignorecase              = true
opt.hlsearch                = true
opt.expandtab               = true
opt.joinspaces              = false
opt.relativenumber          = true
opt.scrolloff               = 4                   
opt.shiftround              = true               
opt.shiftwidth              = 2                  
opt.sidescrolloff           = 15
opt.smartcase               = true
opt.smartindent             = true
opt.smarttab                = true
opt.tabstop                 = 2
opt.termguicolors           = true
opt.wrap                    = false
opt.encoding                = 'utf-8'
opt.fileencoding            = 'utf-8'
opt.syntax                  = 'on'
opt.colorcolumn             = '72'
opt.autoindent              = true

vim.o.clipboard             = 'unnamedplus'
vim.o.background            = 'dark'
vim.o.encoding              = 'utf-8'
vim.o.fileencoding          = 'utf-8'
