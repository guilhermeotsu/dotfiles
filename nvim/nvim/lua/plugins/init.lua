vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- performance
    use { 
        'lewis6991/impatient.nvim',
        config = function() require('impatient') end,
    }

    -- align lines a little unselles, just use in options.lua
    use {
        'Vonr/align.nvim',
        config = function() require('plugins.align') end,
    }

    -- config server/lsp automacally
    use { 
        'williamboman/mason.nvim',
    }
    use { 
        'williamboman/mason-lspconfig.nvim',
        config = function() require('plugins.mason') end,
    }

   use {
       'neovim/nvim-lspconfig',
       config = function() require('plugins.lsp') end,
   }

    -- autocomplete
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugins.cmp') end,
    }

    use 'hrsh7th/cmp-buffer' -- buffer completions
    use 'hrsh7th/cmp-path' -- path completions
    use 'hrsh7th/cmp-cmdline' -- cmdline completions
    use 'hrsh7th/cmp-nvim-lsp' -- LSP completion support
    use 'hrsh7th/cmp-vsnip'

    -- fuzzy finder/search
    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use 'junegunn/fzf.vim'

    -- syntax, highlight
    use { 
        'nvim-treesitter/nvim-treesitter',
        config = function() require('plugins.treesitter') end,
    }

    use 'iamcco/markdown-preview.nvim'
    use 'preservim/nerdtree'

    -- go to reference, code action, definition, diagnostics, etc
    use ({
        'glepnir/lspsaga.nvim',
        branch = 'main',
        config = function() require('plugins.saga') end,
    })

    -- navigate between overload methods
    use { 
        'Issafalcon/lsp-overloads.nvim',
        config = function() require('plugins.lsp-overloads') end,
    }

    -- tabs view
    use 'kyazdani42/nvim-web-devicons' -- icons
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function() require('lualine').setup() end
    }

    -- colorsheme
    use { 
        'catppuccin/nvim'
    }

    -- comment code
    use { 
        'numToStr/Comment.nvim',
        config = function() require('plugins.comment') end,
    }

    use {
     'romgrk/barbar.nvim',
     requires = {'kyazdani42/nvim-web-devicons'}
    }
end)
