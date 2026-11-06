require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 500,
	},
})

vim.keymap.set("n", "<leader>ub", function()
	require("gitsigns").toggle_current_line_blame()
end, { silent = true, desc = "Toggle git line blame" })
