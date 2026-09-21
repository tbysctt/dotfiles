require("grug-far").setup({
	headerMaxWidth = 80,
	engines = {
		ripgrep = {
			extraArgs = "--hidden",
		},
	},
	windowCreationCommand = "split", -- keep your horizontal split preference
})

vim.keymap.set({ "n", "x" }, "<leader>sr", function()
	local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
	require("grug-far").open({
		transient = true,
		prefills = {
			filesFilter = ext and ext ~= "" and "*." .. ext or nil,
		},
	})
end, { silent = true, desc = "Search and Replace" })

vim.keymap.set("n", "<leader>sR", function()
	require("grug-far").open({
		transient = true,
		prefills = { paths = vim.fn.expand("%") },
	})
end, { silent = true, desc = "Search/replace in file" })
