local Snacks = require("snacks")
local map = require("config.map")

map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, "Delete buffer")

map("n", "<leader>ch", function()
	vim.cmd("checkhealth")
end, "Check health")

-- Be a good little vimmer
map("n", "<left>", "<cmd>echo 'Use h to move!!'<CR>")
map("n", "<right>", "<cmd>echo 'Use l to move!!'<CR>")
map("n", "<up>", "<cmd>echo 'Use k to move!!'<CR>")
map("n", "<down>", "<cmd>echo 'Use j to move!!'<CR>")
