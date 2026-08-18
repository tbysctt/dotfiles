local map = vim.keymap.set
local gf = require("grug-far")

gf.setup({
	extraRgArgs = "--hidden --no-ignore",
	windowCreationCommand = "split",
})

map("n", "<leader>sr", function()
	gf.open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { silent = true, desc = "Search/replace" })

map("x", "<leader>sr", function()
	gf.with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { silent = true, desc = "Search/replace selection" })

map("n", "<leader>sR", function()
	gf.open({ prefills = { paths = vim.fn.expand("%") } })
end, { silent = true, desc = "Seach/replace in file" })
