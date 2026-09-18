local Snacks = require("snacks")
local map = require("config.map")

map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, "Delete buffer")

map("n", "<leader>ch", function()
	vim.cmd("checkhealth")
end, "Check health")
