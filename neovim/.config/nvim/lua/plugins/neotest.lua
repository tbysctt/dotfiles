---@diagnostic disable-next-line: missing-fields
require("neotest").setup({
	adapters = {
		require("neotest-python")({
			runner = "pytest",
		}),
		require("neotest-jest")({
			jestCommand = "npm test --",
			cwd = function()
				return vim.fn.getcwd()
			end,
		}),
		require("neotest-vitest")({
			filter_dir = function(name)
				return name ~= "node_modules"
			end,
		}),
		require("neotest-go")({
			args = { "-count=1", "-timeout=60s" },
		}),
		require("neotest-playwright").adapter({
			options = {
				persist_project_selection = true,
				enable_dynamic_test_discovery = true,
			},
		}),
	},
})

vim.keymap.set("n", "<leader>tr", function()
	require("neotest").run.run()
end, { silent = true, desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { silent = true, desc = "Run test file" })
vim.keymap.set("n", "<leader>ta", function()
	---@type neotest.run.UserRunArgs
	local args = { suite = true }
	require("neotest").run.run(args)
end, { silent = true, desc = "Run all tests" })
vim.keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { silent = true, desc = "Run last test" })
vim.keymap.set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { silent = true, desc = "Toggle test summary" })
vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true })
end, { silent = true, desc = "Show test output" })
vim.keymap.set("n", "<leader>tO", function()
	require("neotest").output_panel.toggle()
end, { silent = true, desc = "Toggle test output panel" })
vim.keymap.set("n", "<leader>tx", function()
	require("neotest").run.stop()
end, { silent = true, desc = "Stop test run" })
vim.keymap.set("n", "<leader>tw", function()
	require("neotest").watch.toggle(vim.fn.expand("%"))
end, { silent = true, desc = "Watch test file" })
