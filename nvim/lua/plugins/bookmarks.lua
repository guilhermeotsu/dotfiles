return {
  "tomasky/bookmarks.nvim",
  event = "VimEnter",
  enable = false,
  config = function()
    require("bookmarks").setup{
      on_attach = function() 
        local bookmark = require("bookmarks")
        vim.keymap.set("n", "!", bookmark.bookmark_toggle, { noremap = true })
        vim.keymap.set("n", "{", bookmark.bookmark_prev,{ noremap = true })
        vim.keymap.set("n", "}", bookmark.bookmark_next,{ noremap = true })

        vim.keymap.set("n", "<leader>bk", bookmark.bookmark_list, { noremap = true })
        vim.keymap.set("n", "<leader>bc", bookmark.bookmark_clean, { noremap = true })
        vim.keymap.set("n", "<leader>ba", bookmark.bookmark_clear_all, { noremap = true })
      end
    }
  end
}
