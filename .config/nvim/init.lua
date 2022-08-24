local cmd = vim.cmd
local opt = vim.opt

vim.g.mapleader             = " "

vim.g.background            = 'light'
vim.g.everforest_background = 'soft'
vim.g.everforest_cursor     = 'orange'

cmd 'colorscheme everforest'

opt.completeopt             = { 'menuone', 'noinsert', 'noselect' }
opt.ignorecase              = true
opt.expandtab               = true
opt.joinspaces              = false
opt.relativenumber          = true
opt.scrolloff               = 4                   
opt.shiftround              = true               
opt.shiftwidth              = 2                  
opt.sidescrolloff           = 8               
opt.shiftround              = true               
opt.shiftwidth              = 2                  
opt.sidescrolloff           = 8               
opt.smartcase               = true
opt.smartindent             = true
opt.tabstop                 = 2
opt.termguicolors           = true
opt.wrap                    = false
opt.encoding                = 'utf-8'
opt.fileencoding            = 'utf-8'
opt.syntax                  = 'on'
opt.clipboard               = 'unnamedplus'
opt.colorcolumn             = '72'
opt.autoindent              = true

require('keymap')
require('plugins')
