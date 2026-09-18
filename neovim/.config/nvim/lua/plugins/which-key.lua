require("which-key").setup({
	preset = "helix",
})

require("which-key").add({
	{ "<leader>b", group = "buffers" },
	{ "<leader>c", group = "code" },
	{ "<leader>g", group = "git" },
	{ "<leader>s", group = "search" },
	{ "<leader>t", group = "tests" },
	{ "<leader>u", group = "ui" },
})
