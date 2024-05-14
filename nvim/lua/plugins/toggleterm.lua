return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function ()
      require("toggleterm").setup()
      vim.keymap.set({"n", "t"}, "<C-t>", "<cmd>ToggleTerm size=30 direction=float<CR>", {})
    end
  }
}
