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

-- Terraform uses terraformls defaults from nvim-lspconfig.
-- Rust is handled by rustaceanvim (auto-starts rust-analyzer).

vim.lsp.enable({ "lua_ls", "gopls", "tsc", "ruff", "intelephense", "terraformls" })

map("n", "K", vim.lsp.buf.hover, { silent = true, desc = "LSP hover" })

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
map("n", "gr", function()
	Snacks.picker.lsp_references()
end, { silent = true, desc = "References" })
map("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { silent = true, desc = "Go to type definition" })
map("n", "<leader>ca", function()
	Snacks.picker.actions()
end, { silent = true, desc = "Code actions" })

map("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })
map("n", "<leader>ds", function()
	Snacks.picker.diagnostics()
end, { silent = true, desc = "Diagnostics" })

map("n", "<leader>uH", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { silent = true, desc = "Toggle inlay hints" })
