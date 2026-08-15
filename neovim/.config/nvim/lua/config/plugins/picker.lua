local Snacks = require("snacks")
local map = vim.keymap.set

map("n", "<leader>e", function()
	Snacks.picker.explorer()
end, { desc = "Explorer" })

map("n", "<leader><space>", function()
	Snacks.picker.files()
end, { desc = "Files" })

map("n", "<leader>bb", function()
	Snacks.picker.buffers()
end, { silent = true, desc = "Buffers" })

map("n", "<leader>sg", function()
	Snacks.picker.grep()
end, { silent = true, desc = "Grep" })

map("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { silent = true, desc = "Git log" })
