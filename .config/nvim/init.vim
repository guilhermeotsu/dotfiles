"my person config using lsp
filetype plugin indent on
syntax enable
set autoread
set encoding=utf-8
:set smartindent
set backspace=indent,eol,start
set vb
set autoindent
set number
set relativenumber
set tabstop=2
set scrolloff=8
set shiftwidth=2
set expandtab
set smarttab
set sidescrolloff=15
set sidescroll=1
set incsearch
set hlsearch
set ignorecase   
set laststatus=2
set cpoptions+=n
set clipboard=unnamedplus

let mapleader = " "

imap jj <Esc>

nnoremap <C-n> :Explore<CR>
"nnoremap <C-q> :Telescope find_files<CR>
nnoremap <silent> <leader>gg :LazyGit<CR>
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprev<CR>
nnoremap <silent> <leader> vv :Vista!!<CR>

imap <C-BS> <C-W>

" clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[C

let g:coq_settings = { 'auto_start': v:true }

let g:razor_cs_shiftwidth = 5

" Emmet
let g:user_emmet_install_global=0
autocmd FileType html,css,cshtml,js,jsx EmmetInstall
imap hh <C-y>,

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'

" autocomplete lsp fast as FK
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" telescope vim
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

Plug 'tami5/lspsaga.nvim'

Plug 'kdheepak/lazygit.nvim'
Plug 'lifepillar/vim-gruvbox8'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'tpope/vim-commentary'

Plug 'liuchengxu/vista.vim'
Plug 'mattn/emmet-vim'
Plug 'jlcrochet/vim-razor'

Plug 'weilbith/nvim-code-action-menu', { 'cmd': 'CodeActionMenu' }

Plug 'camspiers/snap'

Plug 'f-person/git-blame.nvim'
Plug 'romgrk/nvim-treesitter-context'
call plug#end()

lua << EOF
local lsp = require "lspconfig"
local coq = require "coq" 
local saga = require "lspsaga"
local snap = require "snap"
local vimgrep = snap.config.vimgrep:with {reverse = true, suffix = ">>", limit = 50000}
--local telescope = require "telescope"
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/otsu/.omnisharp/run"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--telescope.setup{
--  defaults = { file_ignore_patterns = { "obj","bin","node_modules","git" }}
--}

snap.maps {
    {"<Leader><Leader>", snap.config.file {producer = "ripgrep.file"}},
    {"<Leader>fb", snap.config.file {producer = "vim.buffer"}},
    {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}},
    {"<Leader>ff", vimgrep {}},
}

saga.init_lsp_saga()

lsp.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

lsp.vuels.setup{
  filetypes = { "vue" }
}

lsp.tsserver.setup{}

lsp.html.setup {
  capabilities = capabilities,
  filetypes = { "html", "cshtml" }
}

lsp.cssls.setup {
  capabilities = capabilities,
}

lsp.omnisharp.setup{
    coq.lsp_ensure_capabilities();
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID" };
}

lsp.angularls.setup{}

require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    ident = {
      enable = true
    }
}
EOF

colorscheme gruvbox8

" snippets codes actions
"nnoremap <silent>gf :lua vim.lsp.buf.definition()<CR>
nnoremap <silent>im :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
" nnoremap <leader>ac :lua require'telescope.builtin'.lsp_code_actions{}<CR>
nnoremap <leader>ac :CodeActionMenu<CR>
" saga keymaps
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR> 
nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> rr :Lspsaga rename<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>

