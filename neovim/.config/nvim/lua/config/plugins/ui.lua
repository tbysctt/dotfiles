local Snacks = require("snacks")

Snacks.setup({
	picker = {
		sources = {
			explorer = {
				hidden = true,
				layout = {preset = "default", focus = "list" },
				jump = {close = true},
			},
			files = {
				hidden = true,
				ignored = false,
			},
		},
	},
})

local wk = require("which-key")

wk.setup({
	preset = "helix",
})

require("lualine").setup({
	options = {
		theme = "catppuccin-mocha",
		globalstatus = true,
	}
})
