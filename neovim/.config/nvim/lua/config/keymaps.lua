local Snacks = require("snacks")

local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, "Delete buffer")

map("n", "<leader>ch", function()
	vim.cmd("checkhealth")
end, "Check health")
