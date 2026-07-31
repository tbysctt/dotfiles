local Snacks = require("snacks")
local map = vim.keymap.set

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
vim.lsp.enable({ "gopls" })

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
vim.lsp.enable("lua_ls")

-- TypeScript (native TS7 preview, aka tsgo)

vim.lsp.enable("tsgo")

-- Python

vim.lsp.config("ruff", {
	init_options = {
		settings = {
			format = { enable = false }, -- conform.nvim handles formatting
		},
	},
})
vim.lsp.enable("ruff")

map("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Go to definition" })
