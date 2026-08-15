local Snacks = require("snacks")
local map = vim.keymap.set

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { current_line = true },
	update_in_insert = true,
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

-- Python

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

vim.lsp.enable({ "lua_ls", "gopls", "tsc", "ruff", "intelephense", "yamlls", "terraformls" })

map("n", "K", vim.lsp.buf.hover, { silent = true, desc = "LSP hover" })
map("n", "gK", vim.lsp.buf.signature_help, { silent = true, desc = "Signature help" })
map("i", "<C-k>", vim.lsp.buf.signature_help, { silent = true, desc = "Signature help" })

map("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { silent = true, desc = "Go to definition" })
map("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { silent = true, desc = "Go to declaration" })
map("n", "gri", function()
	Snacks.picker.lsp_implementations()
end, { silent = true, desc = "Go to implementation" })
map("n", "grr", vim.lsp.buf.rename, { silent = true, desc = "Rename symbol" })
map("n", "<leader>cr", vim.lsp.buf.rename, { silent = true, desc = "Rename symbol" })
map("n", "<leader>cR", function()
	Snacks.rename.rename_file()
end, { silent = true, desc = "Rename file" })
map("n", "gr", function()
	Snacks.picker.lsp_references()
end, { silent = true, desc = "References" })
map("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { silent = true, desc = "Go to type definition" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "Code actions" })
map({ "n", "v" }, "<leader>cA", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source" },
			diagnostics = {},
		},
	})
end, { silent = true, desc = "Source action" })
map("n", "<leader>co", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.organizeImports" },
			diagnostics = {},
		},
	})
end, { silent = true, desc = "Organize imports" })
map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { silent = true, desc = "Run codelens" })
map("n", "<leader>cC", vim.lsp.codelens.refresh, { silent = true, desc = "Refresh codelens" })
map("n", "<leader>cL", function()
	Snacks.picker.lsp_config()
end, { silent = true, desc = "LSP info" })
map("n", "<leader>cli", function()
	Snacks.picker.lsp_incoming_calls()
end, { silent = true, desc = "Incoming calls" })
map("n", "<leader>clo", function()
	Snacks.picker.lsp_outgoing_calls()
end, { silent = true, desc = "Outgoing calls" })

map("n", "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { silent = true, desc = "Next reference" })
map("n", "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { silent = true, desc = "Prev reference" })

local function diagnostic_goto(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end

map("n", "]d", diagnostic_goto(true), { silent = true, desc = "Next diagnostic" })
map("n", "[d", diagnostic_goto(false), { silent = true, desc = "Prev diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { silent = true, desc = "Next error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { silent = true, desc = "Prev error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { silent = true, desc = "Next warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { silent = true, desc = "Prev warning" })
map("n", "<leader>cd", vim.diagnostic.open_float, { silent = true, desc = "Line diagnostics" })
map("n", "<leader>ds", function()
	Snacks.picker.diagnostics()
end, { silent = true, desc = "Diagnostics" })

map("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { silent = true, desc = "Document symbols" })
map("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { silent = true, desc = "Workspace symbols" })

map("n", "<leader>uH", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { silent = true, desc = "Toggle inlay hints" })
