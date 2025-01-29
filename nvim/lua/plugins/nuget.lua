return {
  "d7omdev/nuget.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
  ft = "cs",
  lazy = "true",
  config = function()
    require("nuget").setup()
  end,
}
