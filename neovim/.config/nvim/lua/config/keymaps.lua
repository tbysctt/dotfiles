local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")

map("n", "<Esc>", "<cmd>noh<CR>", "Clear search highlight")
map("n", "<leader>w", "<cmd>w<CR>", "Save file")
map("n", "<leader>q", "<cmd>q<CR>", "Close window")
