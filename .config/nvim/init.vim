let mapleader = " "

imap jj <Esc>

filetype plugin indent on

set autoread
set vb
set encoding=utf-8
set autoindent
set relativenumber
set tabstop=2
set shiftwidth=2
set incsearch
set hlsearch
set ignorecase
set clipboard=unnamedplus
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set completeopt=menu,menuone,noselect

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'ray-x/lsp_signature.nvim'
Plug 'jiangmiao/auto-pairs'

Plug 'liuchengxu/vista.vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'tpope/vim-commentary'
Plug 'junegunn/goyo.vim'
Plug 'mattn/emmet-vim'

Plug 'mfussenegger/nvim-dap'
call plug#end()

colorscheme gruvbox8

lua << EOF
	local lsp = require "lspconfig"
	local pid = vim.fn.getpid()
	local omnisharp_bin = "/home/otsu/.omnisharp/omnisharp/OmniSharp"

	require'nvim-treesitter.configs'.setup {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			ident = {
				enable = true
			}
	}

	local cmp = require'cmp'
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		mapping = {
			['<C-c>'] = cmp.mapping.close(),
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<Tab>'] = cmp.mapping.select_next_item(),
			['<S-Tab>'] = cmp.mapping.select_prev_item(),
		},
		sources = {
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
				{ name = "buffer" },
				{ name = "path" }
		},
		completion = { completeopt = "menu,menuone,noinsert"},
		experimental = { ghost_text = true },
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local capabilitiesCmp = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

	lsp.omnisharp.setup{
			cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
			capabilities = capabilitiesCmp
	}

	lsp.cssls.setup{
		capabilities = capabilitiesCmp
	}
	lsp.jsonls.setup{ capabilities = capabilities, }
	lsp.html.setup{ capabilities = capabilities, filetypes = { "html", "cshtml" }}
	lsp.tsserver.setup{}
	lsp.angularls.setup{}

	require "lsp_signature".setup{
		bind = true,
		handler_opts = { border = "rounded"},
		floating_window = true,
	}

	local dap = require('dap')
	dap.adapters.netcoredbg = {
		type = 'executable',
		command = '/home/otsu/Downloads/netcoredbg/netcoredbg/netcoredbg',
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

" Serach in current file or all buffer ctags fzf
function s:gtags_search(line)
     let l:line = split(a:line)[1]
     let l:file = split(a:line)[2]
     execute 'edit +'.l:line l:file
endfunction

 nnoremap <silent> <Leader>t :call fzf#run(fzf#wrap({'source':'global -x .', 'sink':function('<sid>gtags_search'),
             \ 'options': ['-m', '-d', '\t', '--with-nth', '1,2', '-n', '1', '--prompt', 'Tags> ']}))<CR>

let g:user_emmet_install_global=0
autocmd FileType html,css,cshtml,js,jsx EmmetInstall
imap hh <C-y>,

let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Add your own mapping. For example:
noremap <silent><leader>n :NERDTreeToggle<CR>

" clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[C

nnoremap <silent> <leader>w :w<CR>

nnoremap <silent><leader>p :GFiles --cached --others --exclude-standard<CR>
nnoremap <silent><leader><leader> :Files<CR>
nnoremap <silent><leader>ff :Rg<CR>
nnoremap <silent><leader>b :Buffers<CR>

nnoremap <silent><F9>  :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent><F5>  :lua require'dap'.continue()<CR>
nnoremap <silent><F10> :lua require'dap'.step_over()<CR>
nnoremap <silent><F11> :lua require'dap'.step_into()<CR>
nnoremap <silent><F12> :lua require'dap'.repl.open()<CR>

nnoremap <silent>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent>im :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>re :References<CR>
nnoremap <leader>si :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>ac :CodeActions<CR>
nnoremap <silent>K :lua vim.lsp.buf.hover()<CR>
