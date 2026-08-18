local Snacks = require("snacks")

require("todo-comments").setup({})

vim.keymap.set("n", "<leader>st", function()
	Snacks.picker.todo_comments()
end, { desc = "Todos" })
