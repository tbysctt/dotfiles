-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>l")
-- vim.keymap.del("n", "<leader>L")

vim.keymap.set("n", "<leader>l", "", { desc = "LazyVim" })
vim.keymap.set("n", "<leader>ll", "<Cmd>Lazy<CR>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>le", "<Cmd>LazyExtras<CR>", { desc = "Lazy Extras" })
vim.keymap.set(
  "n",
  "<leader>lc",
  ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
  { desc = "Configuration" }
)
vim.keymap.set("n", "<leader>lC", function()
  vim.cmd.news.changelog()
end, { desc = "Changelog" })
