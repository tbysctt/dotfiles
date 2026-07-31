require("catppuccin").setup({
	flavour = "mocha",
	integrations = {
		blink_cmp = true,
		which_key = true,
		snacks = { enabled = true },
	}
})

vim.cmd.colorscheme("catppuccin")
