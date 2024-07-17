return {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
  -- 'nvim-telescope/telescope-dap.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
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
          "fonts",
          ".DS_Store"
        },
        dynamic_preview_title = true,
      },
    })

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
    vim.keymap.set("n", "<leader>p", builtin.git_files, {})
    vim.keymap.set("n", "<leader>rg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>re", builtin.lsp_references, {})
    vim.keymap.set("n", "<leader>z", builtin.resume, {})
    vim.keymap.set("n", "<tab>", builtin.find_files, {})
    -- vim.keymap.set("n", '<leader>k', builtin.marks, {})
    -- vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
    -- vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
    vim.keymap.set("n", '<C-q>', ':lua require("telescope.builtin").lsp_workspace_symbols({ symbols = "function"})<CR>', {})
    vim.keymap.set("n", '<leader>m', ':lua require("telescope.builtin").lsp_document_symbols({ symbols = "function"})<CR>', {})
    -- vim.keymap.set("n", '<leader>dp', dap.list_breakpoints, {})
  end,
}
