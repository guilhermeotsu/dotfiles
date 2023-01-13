local cmd                = vim.cmd
local opt                = vim.opt

vim.g.NERDTreeQuitOnOpen = 1

opt.completeopt          = 'menuone,noinsert,noselect'
opt.ignorecase           = true
opt.hlsearch             = true
opt.expandtab            = true
opt.joinspaces           = false
opt.relativenumber       = true
opt.scrolloff            = 8
opt.shiftround           = true
opt.shiftwidth           = 4
opt.sidescrolloff        = 15
opt.smartcase            = true
opt.smartindent          = true
opt.smarttab             = true
opt.tabstop              = 4
opt.termguicolors        = true
opt.wrap                 = false
opt.encoding             = 'utf-8'
opt.fileencoding         = 'utf-8'
opt.syntax               = 'on'
opt.colorcolumn          = '72'
opt.autoindent           = true
opt.list                 = true
opt.clipboard:append('unnamedplus') -- not working in my workflow :(
opt.backup               = true
opt.backupdir            = '/tmp//,.'
opt.writebackup          = false
opt.swapfile             = false
opt.wrap                 = false
opt.backspace            = 'indent,eol,start'
opt.guicursor            = 'i:block' -- chad fat cursor insert mode
opt.list                 = true
