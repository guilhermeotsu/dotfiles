return {
	"Wansmer/treesj",
	config = function()
    -- omnisharp doesnt work with this plugin
    -- need to implement some thing in this to 
    -- see treesitter
    -- shoud be able to do like fun(arg1, agr3, agr3)
    -- to func(arg1,
          -- arg2,
          -- arg3
    -- )
		local tsj = require("treesj")
		tsj.setup({
			use_default_keymaps = false,
		})
		vim.keymap.set("n", "<leader>j", tsj.toggle)
		vim.keymap.set("n", "<leader>J", function()
			tsj.toggle({ split = { recursive = true } })
		end)
	end,
}
