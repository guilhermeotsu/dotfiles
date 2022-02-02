let mapleader = " "

inoremap jj <Esc>

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
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set completeopt=menu,menuone,noselect

set colorcolumn=72

let g:AutoPairsShortcutToggle = '<C-p>'

let g:user_emmet_install_global=0
autocmd FileType html,css,cshtml,js,jsx EmmetInstall

let g:vimspector_enable_mappings = 'HUMAN'

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'

Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
" Plug 'romgrk/nvim-treesitter-context'

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

" Plug 'OmniSharp/omnisharp-vim'
Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-dap'
call plug#end()

colorscheme gruvbox8

lua << EOF
	local lsp = require "lspconfig"
	local pid = vim.fn.getpid()
	local omnisharp_bin = "/home/otsu/.omnisharp/omnisharp/OmniSharp"

--	require'nvim-treesitter.configs'.setup {
--			highlight = {
--				enable = true,
--				additional_vim_regex_highlighting = false,
--			},
--			ident = {
--				enable = true
--			}
--	}

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
	lsp.vimls.setup{}

	require "lsp_signature".setup{
		bind = true,
		handler_opts = { border = "rounded"},
		floating_window = true,
	}


	local dap = require('dap')
	dap.adapters.netcoredbg = {
		type = 'executable',
		command = '/home/otsu/.netcoredbg/netcoredbg',
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

--vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
--vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
EOF

" emmet snippet
autocmd FileType html, css, js, tsx, ts <buffer> imap hh <C-y>,

noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>Y "+y
noremap <leader>P "+p

noremap <silent><leader>n :NERDTreeToggle<CR>

" clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[C

nnoremap <silent><leader>w :w<CR>

nnoremap <silent><leader>p :GFiles --cached --others --exclude-standard<CR>
nnoremap <silent><leader><leader> :Files<CR>
nnoremap <silent><leader>ff :Rg<CR>
nnoremap <silent><leader>b :Buffers<CR>

nnoremap <silent>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>i :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>re :References<CR>
nnoremap <leader>si :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>ac :CodeActions<CR>
nnoremap <silent>K :lua vim.lsp.buf.hover()<CR>

" nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <S-k> :lua require'dap'.step_out()<CR>
" nnoremap <S-l> :lua require'dap'.step_into()<CR>
" nnoremap <S-j> :lua require'dap'.step_over()<CR>
" nnoremap <leader>ds :lua require'dap'.stop()<CR>
" nnoremap <leader>dn :lua require'dap'.continue()<CR>
" nnoremap <leader>dk :lua require'dap'.up()<CR>
" nnoremap <leader>dj :lua require'dap'.down()<CR>
" nnoremap <leader>d_ :lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>
" nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
" nnoremap <leader>di :lua require'dap.ui.variables'.hover()<CR>
" vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
" nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
" nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
" nnoremap <leader>da :lua require'debugHelper'.attach()<CR>
" nnoremap <leader>dA :lua require'debugHelper'.attachToRemote()<CR>
" nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
" nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
"
" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
