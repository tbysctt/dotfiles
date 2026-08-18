-- TODO: NOT EXACT YET

local wk = require("which-key")

wk.setup({
	preset = "helix",
})

wk.add({
	{ "<leader>b", group = "buffers" },
	{ "<leader>c", group = "code" },
	{ "<leader>cl", group = "calls" },
	{ "<leader>d", group = "diagnostics" },
	{ "<leader>f", group = "files/find" },
	{ "<leader>g", group = "git" },
	{ "<leader>s", group = "search" },
	{ "<leader>t", group = "test" },
	{ "<leader>u", group = "ui" },
	{ "<leader>x", group = "diagnostics/quickfix" },
})
