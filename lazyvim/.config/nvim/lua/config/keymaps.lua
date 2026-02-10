-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>l")
-- vim.keymap.del("n", "<leader>L")

vim.keymap.set("n", "<leader>l", "", { desc = "LazyVim" })
vim.keymap.set("n", "<leader>ll", "<Cmd>Lazy<CR>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>lh", "<Cmd>LazyHealth<CR>", { desc = "Lazy Health" })
vim.keymap.set("n", "<leader>lx", "<Cmd>LazyExtras<CR>", { desc = "Lazy Extras" })
vim.keymap.set("n", "<leader>lc", function()
  Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") })
end, { desc = "Configuration" })
vim.keymap.set("n", "<leader>lC", function()
  vim.cmd.news.changelog()
end, { desc = "Changelog" })

-- Make <leader>bd open the dashboard if the last buffer is deleted
vim.keymap.set("n", "<leader>bd", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs <= 1 then
    Snacks.bufdelete()
    Snacks.dashboard.open()
  else
    Snacks.bufdelete()
  end
end, { desc = "Delete Buffer" })
