local dap = require("dap")
local map = require("config.map")

require("dap-go").setup()

-- Mason's debugpy package venv (adapter host); dap-python still resolves project python for the debuggee.
local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
require("dap-python").setup(debugpy)

-- js-debug (vscode-js-debug); required by neotest-vitest/jest (type = "pwa-node").
-- Mason and system installs both expose `js-debug-adapter` on PATH.
dap.adapters["pwa-node"] = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = "js-debug-adapter",
		args = { "${port}", "127.0.0.1" },
	},
}

local js_config = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		processId = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}
for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	dap.configurations[language] = js_config
end

require("dap-view").setup({
	auto_toggle = true,
})

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })

map("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, "Toggle breakpoint")
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Conditional breakpoint")
map("n", "<leader>dc", function()
	dap.continue()
end, "Continue / start")
map("n", "<leader>di", function()
	dap.step_into()
end, "Step into")
map("n", "<leader>dO", function()
	dap.step_over()
end, "Step over")
map("n", "<leader>do", function()
	dap.step_out()
end, "Step out")
map("n", "<leader>dt", function()
	dap.terminate()
end, "Terminate")
map("n", "<leader>dl", function()
	dap.run_last()
end, "Run last")
map("n", "<leader>du", function()
	require("dap-view").toggle()
end, "Toggle DAP view")
map("n", "<leader>dw", function()
	require("dap-view").hover()
end, "DAP hover")
