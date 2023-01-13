vim.cmd [[packadd packer.nvim]]

require('impatient')

return require('packer').startup(function(use)
   use { 'wbthomason/packer.nvim' }

   -- colorsheme
   use { 'catppuccin/nvim' }

   -- syntax, highlight
   use {
       'nvim-treesitter/nvim-treesitter',
       config = function() 
           require('plugins.treesitter')
       end,
   }

   -- improve performance
   use { 'lewis6991/impatient.nvim' }

   use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('plugins.mason')
        end,
   }

   use {
        'neovim/nvim-lspconfig',
        config = function() 
            require('lsp')
        end,
   }

    use { 
        "lukas-reineke/indent-blankline.nvim",
        config = function() 
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end,
    }


    -- autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = { 
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            require('plugins.cmp')
        end,
    }

   -- -- fuzzy finder/search
   use { 'junegunn/fzf', run = ":call fzf#install()" }
   use 'junegunn/fzf.vim'

   use 'iamcco/markdown-preview.nvim'
   use 'preservim/nerdtree'

   -- go to reference, code action, definition, diagnostics, etc
   use {
       'glepnir/lspsaga.nvim',
       branch = 'main',
       config = function() require('plugins.saga') end,
   }

   -- navigate between overload methods
   use { 
       'Issafalcon/lsp-overloads.nvim',
       config = function() require ('plugins.lsp-overloads') end,
   }

   -- tabs view
   use {
     'nvim-lualine/lualine.nvim',
     requires = { 'kyazdani42/nvim-web-devicons', opt = true },
     config = function() require('lualine').setup() end,
   }

   use {
       'numToStr/Comment.nvim',
       config = function()
           require('plugins.comment')
       end
   }

   use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
   }
end)
