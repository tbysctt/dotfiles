local map = vim.keymap.set

local neotest_ready = false

local function ensure_neotest()
	if neotest_ready then
		return
	end
	neotest_ready = true

	require("neotest").setup({
		adapters = {
			require("neotest-python"),
			require("neotest-jest"),
			require("neotest-vitest"),
			require("neotest-playwright").adapter({
				options = {
					persist_project_selection = true,
					enable_dynamic_test_discovery = true,
				},
			}),
		},
	})
end

map("n", "<leader>tt", function()
	ensure_neotest()
	require("neotest").run.run()
end, { silent = true, desc = "Run nearest test" })

map("n", "<leader>tf", function()
	ensure_neotest()
	require("neotest").run.run(vim.fn.expand("%"))
end, { silent = true, desc = "Run test file" })

map("n", "<leader>ts", function()
	ensure_neotest()
	require("neotest").summary.toggle()
end, { silent = true, desc = "Toggle test summary" })

map("n", "<leader>to", function()
	ensure_neotest()
	require("neotest").output.toggle()
end, { silent = true, desc = "Toggle test output" })
