return {
  'rmagatti/alternate-toggler',
  config = function()
    require("alternate-toggler").setup {
      alternates = {
        ["=="] = "!="
      }
    }

    vim.keymap.set( "n",
      "<leader>a",
      "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>"
    )
  end,
  event = { "BufReadPost" }, -- lazy load after reading a buffer
}
