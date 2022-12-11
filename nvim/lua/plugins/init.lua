vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { 
        'Vonr/align.nvim',
        config = function() require('align') end
    }

    -- config server/lsp automacally
    use { 
        'williamboman/mason.nvim',
        config = function() require('mason') end,
    }
    use 'williamboman/mason-lspconfig.nvim'

    -- i think it's unselless
    use {
        'neovim/nvim-lspconfig',
        config = function() require('lsp') end,
    }

    -- autocomplete
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('cmp') end,
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
        config = function() require('treesitter') end,
    }

    use 'iamcco/markdown-preview.nvim'
    use 'preservim/nerdtree'

    -- go to reference, code action, definition, diagnostics, etc
    use ({
        'glepnir/lspsaga.nvim',
        branch = 'main',
        config = function() require('saga') end,
    })

    -- navigate between overload methods
    use { 
        'Issafalcon/lsp-overloads.nvim',
        config = function() require('lsp-overloads') end,
    }

    -- tabs view
    use 'kyazdani42/nvim-web-devicons' -- icons
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function() require('lualine') end
    }

    -- colorsheme
    use { 
        'catppuccin/nvim',
        config = function() require('') end
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
