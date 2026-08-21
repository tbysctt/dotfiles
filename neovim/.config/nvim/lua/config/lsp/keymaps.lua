-- NOT EXACT YET

local Snacks = require("snacks")
local map = Snacks.keymap.set

map("n", "K", vim.lsp.buf.hover, {
	lsp = { method = "textDocument/hover" },
	desc = "LSP hover",
})
map("n", "gK", vim.lsp.buf.signature_help, {
	lsp = { method = "textDocument/signatureHelp" },
	desc = "Signature help",
})
map("i", "<C-k>", vim.lsp.buf.signature_help, {
	lsp = { method = "textDocument/signatureHelp" },
	desc = "Signature help",
})

map("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { lsp = { method = "textDocument/definition" }, desc = "Go to definition" })
map("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { lsp = { method = "textDocument/declaration" }, desc = "Go to declaration" })
map("n", "gri", function()
	Snacks.picker.lsp_implementations()
end, { lsp = { method = "textDocument/implementation" }, desc = "Go to implementation" })
map("n", "grr", function()
	Snacks.picker.lsp_references()
end, { lsp = { method = "textDocument/references" }, desc = "References", nowait = true })
map("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { lsp = { method = "textDocument/typeDefinition" }, desc = "Go to type definition" })

map("n", "<leader>cr", vim.lsp.buf.rename, {
	lsp = { method = "textDocument/rename" },
	desc = "Rename symbol",
})
map("n", "<leader>cR", function()
	Snacks.rename.rename_file()
end, { desc = "Rename file" })

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
	lsp = { method = "textDocument/codeAction" },
	desc = "Code actions",
})
map({ "n", "v" }, "<leader>cA", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source" },
			diagnostics = {},
		},
	})
end, { lsp = { method = "textDocument/codeAction" }, desc = "Source action" })
map("n", "<leader>co", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.organizeImports" },
			diagnostics = {},
		},
	})
end, { lsp = { method = "textDocument/codeAction" }, desc = "Organize imports" })

map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, {
	lsp = { method = "textDocument/codeLens" },
	desc = "Run codelens",
})
map("n", "<leader>cC", function()
	vim.lsp.codelens.enable(true, { bufnr = 0 })
end, {
	lsp = { method = "textDocument/codeLens" },
	desc = "Refresh codelens",
})
map("n", "<leader>cL", function()
	Snacks.picker.lsp_config()
end, { desc = "LSP info" })
map("n", "<leader>cli", function()
	Snacks.picker.lsp_incoming_calls()
end, { lsp = { method = "textDocument/prepareCallHierarchy" }, desc = "Incoming calls" })
map("n", "<leader>clo", function()
	Snacks.picker.lsp_outgoing_calls()
end, { lsp = { method = "textDocument/prepareCallHierarchy" }, desc = "Outgoing calls" })

map("n", "<A-n>", function()
	Snacks.words.jump(vim.v.count1, true)
end, { desc = "Next reference" })
map("n", "<A-p>", function()
	Snacks.words.jump(-vim.v.count1, true)
end, { desc = "Prev reference" })

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>ds", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })

map("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { lsp = { method = "textDocument/documentSymbol" }, desc = "Document symbols" })
map("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { lsp = { method = "workspace/symbol" }, desc = "Workspace symbols" })
