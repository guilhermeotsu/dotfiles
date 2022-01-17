"my person config using lsp
filetype plugin indent on
syntax enable
set autoread
set termguicolors
set smartindent
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

set backspace=indent,eol,start

let mapleader = " "

imap jj <Esc>

nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>gg :LazyGit<CR>
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprev<CR>
nnoremap <silent> <leader>vv :Vista!!<CR>

" clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

let g:razor_cs_shiftwidth = 5

let g:coq_settings = { 'auto_start': v:true }

" Emmet
let g:user_emmet_install_global=0
autocmd FileType html,css,cshtml,js,jsx EmmetInstall
imap hh <C-y>,

" close all buffers except current one
command! BufCurOnly execute '%bdelete|edit#|bdelete#'

" Close all buffers but current
nnoremap <C-B>c :BufCurOnly<CR>

" show method cursor
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"keep visual mode after indent
vnoremap > >gv
vnoremap < <gv

imap <C-BS> <C-W>

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'

Plug 'neovim/nvim-lspconfig'

" Action - Lsp
" autocomplete lsp fast as FK
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'weilbith/nvim-code-action-menu', { 'cmd': 'CodeActionMenu' }
Plug 'tami5/lspsaga.nvim'

Plug 'lifepillar/vim-gruvbox8'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'tpope/vim-commentary'

Plug 'liuchengxu/vista.vim'

Plug 'mattn/emmet-vim'
Plug 'jlcrochet/vim-razor'

" Fuzy finder
Plug 'camspiers/snap'

" Regex Finder
Plug 'dyng/ctrlsf.vim'

" Tab UI
Plug 'romgrk/barbar.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'f-person/git-blame.nvim'
Plug 'kdheepak/lazygit.nvim'

" Icons
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'ryanoasis/vim-devicons'

" Debug
Plug 'mfussenegger/nvim-dap'

" Focus
Plug 'junegunn/goyo.vim'

Plug 'chrisbra/matchit'

Plug 'ap/vim-css-color'
Plug 'mhinz/vim-signify'
call plug#end()

lua << EOF
local dap = require "dap"
local lsp = require "lspconfig"
local coq = require "coq" 
local saga = require "lspsaga"
local snap = require "snap"
local vimgrep = snap.config.vimgrep:with {reverse = true, suffix = ">>", limit = 50000}
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/otsu/.omnisharp/run"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

lsp.vuels.setup{}

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
      disable = {"css"}
    },
    ident = { enable = true, disable = { "yaml" } }
}

-- Debugger .net core
dap.adapters.netcoredbg = {
  type = 'executable',
  command = '/home/otsu/.netcoredbg/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

EOF

colorscheme gruvbox8

nnoremap <leader>w :w<CR>

" snippets codes actions
nnoremap <silent>gf :lua vim.lsp.buf.definition()<CR>
nnoremap <silent>im :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
" nnoremap <leader>ac :lua require'telescope.builtin'.lsp_code_actions{}<CR>
nnoremap <leader>ac :CodeActionMenu<CR>
" saga keymaps
nnoremap <silent> <leader>ca :Lspsaga code_action<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR> 
nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> rr :Lspsaga rename<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>

