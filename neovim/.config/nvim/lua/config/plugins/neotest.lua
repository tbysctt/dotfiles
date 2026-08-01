local map = vim.keymap.set

require("neotest").setup({
	adapters = {
		require("neotest-python"),
		require("neotest-jest"),
		require("neotest-vitest"),
		require("neotest-playwright").adapter(),
	},
})

map("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })

map("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run test file" })

map("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })

map("n", "<leader>to", function()
	require("neotest").output.toggle()
end, { desc = "Toggle test output" })
