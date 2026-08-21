local map = vim.keymap.set
local neotest = require("neotest")

---@diagnostic disable-next-line: missing-fields
neotest.setup({
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

map("n", "<leader>tr", function()
	neotest.run.run()
end, { silent = true, desc = "Run nearest test" })
map("n", "<leader>tf", function()
	neotest.run.run(vim.fn.expand("%"))
end, { silent = true, desc = "Run test file" })
map("n", "<leader>ta", function()
	---@type neotest.run.UserRunArgs
	local args = { suite = true }
	neotest.run.run(args)
end, { silent = true, desc = "Run all tests" })
map("n", "<leader>tl", function()
	neotest.run.run_last()
end, { silent = true, desc = "Run last test" })
map("n", "<leader>ts", function()
	neotest.summary.toggle()
end, { silent = true, desc = "Toggle test summary" })
map("n", "<leader>to", function()
	neotest.output.open({ enter = true })
end, { silent = true, desc = "Show test output" })
map("n", "<leader>tO", function()
	neotest.output_panel.toggle()
end, { silent = true, desc = "Toggle test output panel" })
map("n", "<leader>td", function()
	---@type neotest.run.UserRunArgs
	local args = { strategy = "dap" }
	neotest.run.run(args)
end, { silent = true, desc = "Debug nearest test" })
map("n", "<leader>tx", function()
	neotest.run.stop()
end, { silent = true, desc = "Stop test run" })
map("n", "<leader>tw", function()
	neotest.watch.toggle(vim.fn.expand("%"))
end, { silent = true, desc = "Watch test file" })
