require("catppuccin").setup({
	flavour = "mocha",
	integrations = {
		blink_cmp = true,
		gitsigns = true,
		markdown = true,
		neotest = true,
		treesitter = true,
		which_key = true,
		snacks = { enabled = true },
	},
})

vim.cmd.colorscheme("catppuccin")
