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

local enabled_servers = {
	"lua_ls",
	"gopls",
	"tsc", -- Official native LSP included in TypeScript 7
	-- "vtsls", -- The LSP wrapper around the TypeScript VSCode extension
	"ruff",
	"intelephense",
	"yamlls",
	"terraformls",
	"tailwindcss",
	"taplo",
	"basedpyright",
	"bashls",
}

vim.lsp.enable(enabled_servers)

require("config.lsp.keymaps")
