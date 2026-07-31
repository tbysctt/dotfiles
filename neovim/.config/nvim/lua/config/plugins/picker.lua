local Snacks = require("snacks")
local map = vim.keymap.set

map("n", "<leader>e", function()
	Snacks.picker.explorer()
end, { desc = "Explorer" })

map("n", "<leader><space>", function()
	Snacks.picker.files()
end, { desc = "Files" })
