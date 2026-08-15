local Snacks = require("snacks")

local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")

map("n", "<C-Up>", "<cmd>resize +2<CR>", "Increase window height")
map("n", "<C-Down>", "<cmd>resize -2<CR>", "Decrease window height")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", "Decrease window width")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", "Increase window width")

map("n", "<leader>-", "<C-w>s", "Split window below")
map("n", "<leader>|", "<C-w>v", "Split window right")

map("n", "<S-h>", "<cmd>bprevious<CR>", "Prev buffer")
map("n", "<S-l>", "<cmd>bnext<CR>", "Next buffer")
map("n", "[b", "<cmd>bprevious<CR>", "Prev buffer")
map("n", "]b", "<cmd>bnext<CR>", "Next buffer")
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, "Delete buffer")

map("x", "<", "<gv", "Indent left")
map("x", ">", ">gv", "Indent right")

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<CR><Esc>", "Save file")

map("n", "<Esc>", "<cmd>noh<CR>", "Clear search highlight")
map("n", "<leader>w", "<cmd>w<CR>", "Save file")
map("n", "<leader>q", "<cmd>q<CR>", "Close window")
