require("todo-comments").setup({})

vim.keymap.set("n", "<leader>st", function()
	require("snacks").picker.pick("todo_comments")
end, { desc = "TODO comments (in workspace)" })
