local Snacks = require("snacks")
local map = Snacks.keymap.set

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { current_line = true },
	update_in_insert = false,
	float = {
		border = "rounded",
		source = true,
	},
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Lua

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME, "${3rd}/lua/library" },
			},
			diagnostics = { globals = { "vim" } },
			completion = { callSnippet = "Replace" },
		},
	},
})

-- Go

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			usePlaceholders = true,
			completeUnimported = true,
			analyses = { unusedparams = true, nilness = true, shadow = true },
		},
	},
})

-- TypeScript

vim.lsp.config("tsc", {
	cmd = { "tsc", "--lsp", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "package.json", ".git" },
})

-- Python (Ruff for lint/organize; basedpyright for types when installed)

vim.lsp.config("ruff", {
	init_options = {
		settings = {
			format = { enable = false }, -- conform.nvim handles formatting
		},
	},
})

-- PHP

vim.lsp.config("intelephense", {
	settings = {
		intelephense = {
			telemetry = { enabled = false },
		},
	},
})

-- YAML

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			format = { enable = false }, -- conform.nvim handles formatting
			validate = true,
			hover = true,
			completion = true,
			schemaStore = { enable = true },
		},
	},
})

-- Terraform uses terraformls defaults from nvim-lspconfig.
-- Rust is handled by rustaceanvim (auto-starts rust-analyzer).

local servers = { "lua_ls", "gopls", "tsc", "ruff", "intelephense", "yamlls", "terraformls" }
if vim.fn.executable("basedpyright-langserver") == 1 or vim.fn.executable("basedpyright") == 1 then
	servers[#servers + 1] = "basedpyright"
end
vim.lsp.enable(servers)

-- Align with Neovim 0.11+ gr* defaults; use Snacks pickers where useful.
-- grn = rename (stock), gra = code action (stock), grr = references, gri = implementation

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
map("n", "<leader>cC", vim.lsp.codelens.refresh, {
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

local function diagnostic_goto(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end

map("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev warning" })
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

map("n", "<leader>uH", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
