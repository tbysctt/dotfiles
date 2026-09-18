local Snacks = require("snacks")

Snacks.keymap.set("n", "K", vim.lsp.buf.hover, {
	lsp = { method = "textDocument/hover" },
	desc = "LSP hover",
})
Snacks.keymap.set("n", "gK", vim.lsp.buf.signature_help, {
	lsp = { method = "textDocument/signatureHelp" },
	desc = "Signature help",
})
Snacks.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {
	lsp = { method = "textDocument/signatureHelp" },
	desc = "Signature help",
})

Snacks.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { lsp = { method = "textDocument/definition" }, desc = "Go to definition" })
Snacks.keymap.set("n", "gD", vim.lsp.buf.declaration, {
	lsp = { method = "textDocument/declaration" },
	desc = "Go to declaration",
})
Snacks.keymap.set("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { lsp = { method = "textDocument/implementation" }, desc = "Go to implementation" })
Snacks.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { lsp = { method = "textDocument/references" }, desc = "References", nowait = true })
Snacks.keymap.set("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { lsp = { method = "textDocument/typeDefinition" }, desc = "Go to type definition" })

Snacks.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
	lsp = { method = "textDocument/rename" },
	desc = "Rename symbol",
})
Snacks.keymap.set("n", "<leader>cR", function()
	Snacks.rename.rename_file()
end, { desc = "Rename file" })

Snacks.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, {
	lsp = { method = "textDocument/codeAction" },
	desc = "Code actions",
})
Snacks.keymap.set({ "n", "x" }, "<leader>cA", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source" },
			diagnostics = {},
		},
	})
end, { lsp = { method = "textDocument/codeAction" }, desc = "Source action" })
Snacks.keymap.set("n", "<leader>co", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.organizeImports" },
			diagnostics = {},
		},
	})
end, { lsp = { method = "textDocument/codeAction" }, desc = "Organize imports" })

Snacks.keymap.set({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, {
	lsp = { method = "textDocument/codeLens" },
	desc = "Run codelens",
})
Snacks.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, {
	lsp = { method = "textDocument/codeLens" },
	desc = "Refresh & Display Codelens",
})
Snacks.keymap.set("n", "<leader>cl", function()
	Snacks.picker.lsp_config()
end, { desc = "Lsp Info" })
Snacks.keymap.set("n", "gai", function()
	Snacks.picker.lsp_incoming_calls()
end, { lsp = { method = "textDocument/prepareCallHierarchy" }, desc = "C[a]lls Incoming" })
Snacks.keymap.set("n", "gao", function()
	Snacks.picker.lsp_outgoing_calls()
end, { lsp = { method = "textDocument/prepareCallHierarchy" }, desc = "C[a]lls Outgoing" })

Snacks.keymap.set("n", "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next reference" })
Snacks.keymap.set("n", "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev reference" })
Snacks.keymap.set("n", "<A-n>", function()
	Snacks.words.jump(vim.v.count1, true)
end, { desc = "Next reference" })
Snacks.keymap.set("n", "<A-p>", function()
	Snacks.words.jump(-vim.v.count1, true)
end, { desc = "Prev reference" })

Snacks.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
Snacks.keymap.set("n", "<leader>sd", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
Snacks.keymap.set("n", "<leader>sD", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Diagnostics (current buffer)" })

Snacks.keymap.set("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { lsp = { method = "textDocument/documentSymbol" }, desc = "Document symbols" })
Snacks.keymap.set("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { lsp = { method = "workspace/symbol" }, desc = "Workspace symbols" })
