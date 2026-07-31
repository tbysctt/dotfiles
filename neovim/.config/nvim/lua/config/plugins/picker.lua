local Snacks = require("snacks")
local map = vim.keymap.set

map("n", "<leader>e", function()
	Snacks.picker.explorer()
end, { desc = "Explorer" })

