require("flash").setup({
	modes = {
		char = {
			-- Flash enables f/t/F/T to jump to matches outside the current line, which contradicts vanilla vim.
			-- Uncomment the line below to disable it and restore the vanilla vim behaviour
			-- multi_line = false,
		},
	},
})
