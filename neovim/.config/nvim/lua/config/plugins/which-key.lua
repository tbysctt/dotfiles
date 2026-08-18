-- TODO: NOT EXACT YET

local wk = require("which-key")

wk.setup({
	preset = "helix",
})

wk.add({
	{ "<leader>c", group = "code" },
	{ "<leader>cl", group = "calls" },
	{ "<leader>d", group = "diagnostics" },
	{ "<leader>g", group = "git" },
	{ "<leader>h", group = "hunks" },
	{ "<leader>s", group = "search" },
	{ "<leader>t", group = "test" },
	{ "<leader>u", group = "ui" },
	{ "<leader>q", group = "quit/todos" },
	{ "<leader>b", group = "buffers" },
})
