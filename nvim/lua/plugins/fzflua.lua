return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
  },
  config = {
    winopts = {
      height  = 0.65,
      width   = 0.50,
      preview = {
        layout = "vertical"
      }
    },
    file_ignore_patterns = {
      ".git",
      "lazy-lock.json",
      "node_modules",
      "yarn.lock",
      "fonts",
      ".DS_Store",
      "bin",
      "obj"
    },
    vim.keymap.set("n", "<leader><leader>", ":FzfLua files<CR>", {}),
    vim.keymap.set("n", "<leader>x", ":FzfLua lsp_document_diagnostics<CR>", {}),
    vim.keymap.set("n", "<leader>X", ":FzfLua lsp_workspace_diagnostics<CR>", {}),
    vim.keymap.set("n", "<leader>p", ":FzfLua git_files<CR>", {}),
    vim.keymap.set("n", "@", ":FzfLua lsp_live_workspace_symbols<CR>", {}),
    vim.keymap.set("n", "<leader>m", ":FzfLua lsp_document_symbols<CR>", {}),
    vim.keymap.set("n", "<leader>re", ":FzfLua lsp_finder<CR>", {}),
    vim.keymap.set("n", "<leader>z", ":FzfLua resume<CR>", {}),
    vim.keymap.set({ "v" }, "<C-f>", ":FzfLua grep_visual<CR>", {}),
    vim.keymap.set("n", "<C-f>", ":FzfLua grep_cword<CR>", {}),
    vim.keymap.set({ "n", "v" }, "<leader>rg", ":FzfLua live_grep<CR>", {}),
    vim.keymap.set({ "n", "v" }, "<leader>ca", ":FzfLua code_actions<CR>", {}),
  }
}
