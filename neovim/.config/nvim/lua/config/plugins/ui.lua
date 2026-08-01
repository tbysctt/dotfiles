local Snacks = require("snacks")

local mini_icons = require("mini.icons")
mini_icons.setup()
mini_icons.mock_nvim_web_devicons()

Snacks.setup({
	picker = {
		sources = {
			explorer = {
				hidden = true,
				layout = { preset = "default", focus = "list" },
				jump = { close = true },
			},
			files = {
				hidden = true,
				ignored = false,
			},
		},
	},
	bigfile = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

local wk = require("which-key")

wk.setup({
	preset = "helix",
})

require("todo-comments").setup({})

vim.keymap.set("n", "<leader>qt", "<cmd>TodoQuickFix<CR>", { silent = true, desc = "Todo list" })

require("lualine").setup({
	options = {
		theme = "catppuccin-mocha",
		globalstatus = true,
	},
})
