vim.cmd [[packadd packer.nvim]]

require('impatient')

return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- go to definition replace for dotnet
    use { 'Hoffs/omnisharp-extended-lsp.nvim' }

    -- colorsheme
    use { 'catppuccin/nvim' }

    -- improve performance
    use { 'lewis6991/impatient.nvim' }

    -- syntax, highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            "nvim-treesitter/nvim-treesitter-refactor",
            {
                "nvim-treesitter/completion-treesitter",
                run = function()
                    vim.cmd "TSUpdate"
                end,
            },
        },
        config = function()
            require 'plugins/treesitter'
        end,
    }

    --fuzzy finder/search
    -- use { 'junegunn/fzf', run = ":call fzf#install()" }
    -- use 'junegunn/fzf.vim'

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require 'plugins/telescope'
        end,
    }
    
    use {
        'MattesGroeger/vim-bookmarks',
        config = function ()
            require('plugins/vim-bookmarks')
        end
    }

    use {
        'tom-anders/telescope-vim-bookmarks.nvim',
        config = function ()
           require('telescope').load_extension('vim_bookmarks') 
        end
    }
    
    use 'iamcco/markdown-preview.nvim'

    -- lsp config
    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    }

    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup{
                ensure_installed = { 'omnisharp', 'tsserver', 'lua_ls', 'html', 'cssls', 'dockerls', 'jsonls', 'zk', 'emmet_ls' },
                automatic_installation = true,
            }
            require('plugins/lsp')
        end,
    }

    use { 'neovim/nvim-lspconfig' }

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
            require 'plugins/cmp'
        end,
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
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


    -- go to reference, code action, definition, diagnostics, etc
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("plugins/lspsaga")
        end,
        requires = {
            {"nvim-tree/nvim-web-devicons"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    })

    use 'nvim-tree/nvim-web-devicons'
    -- navigate between overload methods signature help for dotnet
    use { 'Issafalcon/lsp-overloads.nvim', }

    use ({
        'mfussenegger/nvim-dap',
        config = function ()
            require('plugins.dap')
        end
    })

    -- tabs view
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require('lualine').setup() end,
    }

    use {
        "windwp/nvim-autopairs",
        config = function() 
            require("nvim-autopairs").setup {} 
        end
    }

    -- lua with packer.nvim
    use {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    }

    use { 'tpope/vim-fugitive' }
    use { 
        'dcampos/nvim-snippy',
        config = function()
            require('plugins.snippy')
        end
  }

  use {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

    -- Lua
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
          {silent = true, noremap = true}
        )
      }
    end
  }

  use {
    "windwp/nvim-ts-autotag",
    config = function ()
      require('nvim-ts-autotag').setup()
    end
  }

end)
