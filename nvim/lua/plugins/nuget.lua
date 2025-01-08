return {
  "d7omdev/nuget.nvim",
  ft = "cs",
  lazy = "true",
  config = function()
    require("nuget").setup()
  end,
}
