local gf = require("grug-far")

gf.setup({
	extraRgArgs = "--hidden --no-ignore",
	windowCreationCommand = "split",
})

vim.keymap.set("n", "<leader>sr", function()
	gf.open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { silent = true, desc = "Search/replace" })

vim.keymap.set("x", "<leader>sr", function()
	gf.with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { silent = true, desc = "Search/replace selection" })

vim.keymap.set("n", "<leader>sR", function()
	gf.open({ prefills = { paths = vim.fn.expand("%") } })
end, { silent = true, desc = "Seach/replace in file" })
