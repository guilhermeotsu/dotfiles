vim.cmd 'packadd paq-nvim'

require "paq" {
    "savq/paq-nvim";

    "neovim/nvim-lspconfig";
    "hrsh7th/nvim-cmp";
    "sainnhe/everforest";
    "Vonr/align.nvim"

    --{ "lervag/vimtex", opt=true };      -- Use braces when passing options
}
