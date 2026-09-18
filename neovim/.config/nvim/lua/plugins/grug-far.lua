require("grug-far").setup({
	extraRgArgs = "--hidden --no-ignore",
	windowCreationCommand = "split",
})

vim.keymap.set("n", "<leader>sr", function()
	require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { silent = true, desc = "Search/replace" })

vim.keymap.set("x", "<leader>sr", function()
	require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { silent = true, desc = "Search/replace selection" })

vim.keymap.set("n", "<leader>sR", function()
	require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
end, { silent = true, desc = "Search/replace in file" })
