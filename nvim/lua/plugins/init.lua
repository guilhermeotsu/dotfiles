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

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require 'plugins/telescope'
    end,
  }

  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup()
    end
}

  use {
    'crusj/bookmarks.nvim',
    branch = 'main',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require("plugins.bookmarks")
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
        ensure_installed = { 'omnisharp', 'tsserver', 'lua_ls', 'html', 'cssls', 'jsonls'  },
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
      require("ibl").setup{}
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

  -- use ({
  --   'mfussenegger/nvim-dap',
  --   config = function ()
  --     require('plugins.dap')
  --   end
  -- })

  -- use { "rcarriga/nvim-dap-ui",
  --   requires = {"mfussenegger/nvim-dap"},
  --   config = function ()
  --     require("dapui").setup()
  --   end
  -- }

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

  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  }

  use { 'tpope/vim-fugitive' }

  use {
    'folke/zen-mode.nvim',
    config = function ()
      require("zen-mode").setup {}
    end
  }

  use {
    'dcampos/nvim-snippy',
    config = function()
      require('snippy').setup({
        mappings = {
          is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
          },
          nx = {
            ['<leader>x'] = 'cut_text',
          },
        },
      })
    end
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

  use { 'christoomey/vim-tmux-navigator' }

  use { 'norcalli/nvim-colorizer.lua', config = function ()
    require'colorizer'.setup()
  end 
  }
end)
