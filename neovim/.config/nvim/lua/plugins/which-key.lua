require("which-key").setup({
	preset = "helix",
})

require("which-key").add({
	{ "<leader>b", group = "buffers" },
	{ "<leader>c", group = "code" },
	{ "<leader>f", group = "files/find" },
	{ "<leader>g", group = "git" },
	{ "<leader>s", group = "search" },
	{ "<leader>t", group = "Tests" },
	{ "<leader>u", group = "ui" },
	{ "<leader>x", group = "diagnostics/quickfix" },
})
