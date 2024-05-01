return {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("telescope").setup({
      defaults = {
        theme = "dropdown",
        sorters = require("telescope.sorters").get_fzy_sorter(),
        mappings = {
          i = {
            ["Esc"] = require("telescope.actions").close,
          },
        },
        file_ignore_patterns = {
          ".git",
          "lazy-lock.json",
          "node_modules",
          "yarn.lock",
          "fonts"
        },
        dynamic_preview_title = true,
      },
      -- pickers = {
      --   find_files = {
      --     sort_lastused = true,
      --     hidden = true,
      --     theme = "dropdown"
      --   },
      --   git_files = {
      --     sort_lastused = true,
      --     theme = "dropdown"
      --   },
      --   resume = {
      --     theme = "dropdown"
      --   },
      --   buffers = {
      --     theme = "dropdown"
      --   }
      -- }
    })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
    vim.keymap.set("n", "<leader>p", builtin.git_files, {})
    vim.keymap.set("n", "<leader>rg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>z", builtin.resume, {})
    vim.keymap.set("n", "<leader>b", builtin.buffers, {})
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
    vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
    vim.keymap.set("n", '@', ':lua require("telescope.builtin").lsp_workspace_symbols({ symbols = "function"})<CR>', {})
    vim.keymap.set("n", '<C-m>', ':lua require("telescope.builtin").lsp_document_symbols({ symbols = "function"})<CR>', {})
  end,
}
