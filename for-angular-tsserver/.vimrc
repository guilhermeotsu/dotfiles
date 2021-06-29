if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" Configs
syntax enable
" :filetype indent on
set encoding=utf-8
:set filetype=html
:set smartindent
set number
set relativenumber
scriptencoding utf-8
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set backspace=indent,eol,start
set laststatus=2
set cpoptions+=n
set vb

filetype plugin indent on    " required


" =============== Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" =============== Search ============================
"
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" =============== remap d ==========================
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" Emmet
let g:user_emmet_install_global=0
autocmd FileType html,css,cshtml EmmetInstall
imap hh <C-y>,

" Fzf Config
:map <C-p> :GFiles --cached --others --exclude-standard<CR>
:map <C-q> :Files<CR>

" NERDTree
:map <C-n> :NERDTreeToggle<CR>
:map <C-m> :NERDTreeFocus<CR>

" Buffer nav
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>

" Gruvbox colorsheme
colorscheme gruvbox8

" Airline Configs
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1  " https://github.com/vim-airline/vim-airline#unique_tail
let g:airline#extensions#tabline#formatte = 'unique_tail'  " https://github.com/vim-airline/vim-airline#unique_tail


" ================= COC =====================
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-actions',
  \ 'coc-lists',
  \ 'coc-tsserver',
  \ 'coc-css',
  \ 'coc-prettier',
  \ 'coc-vimlsp',
  \ 'coc-angular',
  \ 'coc-vetur'
  \ ]

set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
autocmd CursorHold * silent call CocActionAsync('highlight')

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·
set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================== shotcuts ==========
map <F5> :e!<CR>                    " force reload current file
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
