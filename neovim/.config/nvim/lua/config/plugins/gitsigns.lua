-- TODO: Add the actual signs to the placeholder config spots.

require("gitsigns").setup({
	-- signs = {
	--        add = { text = "" },
	--        change = { text = "" },
	--        delete = { text = "" },
	--        topdelete = { text = "" },
	--        changedelete = { text = "" },
	--        untracked = { text = "" },
	--    },
	-- signs_staged = {
	--        add = { text = "" },
	--        change = { text = "" },
	--        delete = { text = "" },
	--        topdelete = { text = "" },
	--        changedelete = { text = "" },
	--    },
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 500,
	},
})
