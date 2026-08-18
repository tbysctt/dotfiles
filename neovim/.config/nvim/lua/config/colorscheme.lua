require("catppuccin").setup({
	flavour = "mocha",
	integrations = {
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
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
